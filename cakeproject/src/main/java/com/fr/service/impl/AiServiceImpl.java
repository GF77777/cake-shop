package com.fr.service.impl;

import com.fr.config.VolcEngineConfig;
import com.fr.entity.Goods;
import com.fr.entity.GoodsSales;
import com.fr.service.AiService;
import com.fr.service.GoodsService;
import com.fr.service.SalesService;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.ResourceAccessException;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class AiServiceImpl implements AiService {

    private static final Logger logger = LoggerFactory.getLogger(AiServiceImpl.class);

    @Autowired
    private VolcEngineConfig volcEngineConfig;

    @Autowired
    private GoodsService goodsService;

    @Autowired
    private SalesService salesService;

    private final RestTemplate restTemplate;
    private final Gson gson = new Gson();

    public AiServiceImpl() {
        this.restTemplate = createRestTemplate();
    }

    private RestTemplate createRestTemplate() {
        RestTemplate template = new RestTemplate();
        return template;
    }

    @Override
    public String chat(String message, String history) {
        String goodsInfo = getGoodsInfo();
        
        String prompt = "你是蛋糕店的 AI 客服小甜，你的回答必须基于以下蛋糕店的商品信息：\n\n" +
                "蛋糕店商品列表：\n" + goodsInfo + "\n\n" +
                "请根据以上商品信息回答客户问题。如果问题与蛋糕店无关，请礼貌地拒绝回答。\n\n" +
                "历史对话：\n" + history + "\n\n" +
                "用户问题：" + message;

        return callVolcEngineApi(prompt);
    }

    private String getGoodsInfo() {
        try {
            List<Goods> goodsList = goodsService.getAllGoods();
            
            Map<Integer, Integer> salesMap = new HashMap<>();
            try {
                List<GoodsSales> salesList = salesService.getSalesRanking();
                for (GoodsSales sales : salesList) {
                    salesMap.put(sales.getGoodsId(), sales.getSalesCount());
                }
            } catch (Exception e) {
                logger.warn("获取销量数据失败，将使用默认值", e);
            }
            
            Map<String, List<Goods>> goodsByType = new HashMap<>();
            for (Goods goods : goodsList) {
                if (goods.getStock() <= 0) {
                    continue;
                }
                String typeName = goods.getTypeName();
                if (!goodsByType.containsKey(typeName)) {
                    goodsByType.put(typeName, new java.util.ArrayList<>());
                }
                goodsByType.get(typeName).add(goods);
            }
            
            if (goodsByType.isEmpty()) {
                return "暂无商品信息";
            }
            
            StringBuilder sb = new StringBuilder();
            sb.append("我们店有以下蛋糕：\n");
            
            for (Map.Entry<String, List<Goods>> entry : goodsByType.entrySet()) {
                sb.append("【").append(entry.getKey()).append("】\n");
                for (Goods goods : entry.getValue()) {
                    int sales = salesMap.getOrDefault(goods.getId(), 0);
                    sb.append("  - ")
                      .append(goods.getName())
                      .append("，价格为")
                      .append(goods.getPrice())
                      .append("元，销量")
                      .append(sales)
                      .append("件\n");
                }
            }
            
            return sb.toString();
        } catch (Exception e) {
            logger.error("获取商品信息失败", e);
            return "暂无商品信息";
        }
    }

    private String callVolcEngineApi(String prompt) {
        String apiUrl = volcEngineConfig.getApiUrl();
        String apiKey = volcEngineConfig.getApiKey();
        String model = volcEngineConfig.getModel();

        Map<String, Object> requestBody = new HashMap<>();
        requestBody.put("model", model);
        requestBody.put("max_tokens", 1024);
        requestBody.put("temperature", 0.7);
        
        List<Map<String, String>> messages = new java.util.ArrayList<>();
        
        Map<String, String> systemMessage = new HashMap<>();
        systemMessage.put("role", "system");
        systemMessage.put("content", "你是蛋糕店的AI客服小甜，回答要友好、专业，基于提供的商品信息回答客户问题。");
        messages.add(systemMessage);
        
        Map<String, String> userMessage = new HashMap<>();
        userMessage.put("role", "user");
        userMessage.put("content", prompt);
        messages.add(userMessage);
        
        requestBody.put("messages", messages);

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("Authorization", "Bearer " + apiKey);

        HttpEntity<String> entity = new HttpEntity<>(gson.toJson(requestBody), headers);

        try {
            ResponseEntity<String> response = restTemplate.exchange(
                    apiUrl,
                    HttpMethod.POST,
                    entity,
                    String.class
            );

            if (response.getStatusCode().is2xxSuccessful() && response.getBody() != null) {
                String responseBody = response.getBody();
                JsonObject jsonObject = gson.fromJson(responseBody, JsonObject.class);
                
                if (jsonObject.has("choices") && jsonObject.get("choices").isJsonArray()) {
                    com.google.gson.JsonArray choices = jsonObject.getAsJsonArray("choices");
                    if (choices.size() > 0) {
                        JsonObject choice = choices.get(0).getAsJsonObject();
                        if (choice.has("message") && choice.get("message").isJsonObject()) {
                            JsonObject message = choice.getAsJsonObject("message");
                            if (message.has("content")) {
                                return message.get("content").getAsString();
                            }
                        }
                    }
                }
                
                return responseBody;
            } else {
                logger.warn("API调用失败，状态码: {}", response.getStatusCodeValue());
                return "API调用失败: " + response.getStatusCodeValue();
            }
        } catch (org.springframework.web.client.HttpClientErrorException.Forbidden e) {
            logger.error("API权限不足，请检查API Key和模型配置", e);
            return "API权限不足，请检查API Key和模型配置是否正确";
        } catch (org.springframework.web.client.HttpClientErrorException.Unauthorized e) {
            logger.error("API Key无效或已过期", e);
            return "API Key无效或已过期，请检查配置";
        } catch (ResourceAccessException e) {
            logger.error("网络连接失败或请求超时", e);
            return "网络连接失败，请检查网络设置或稍后重试";
        } catch (RestClientException e) {
            logger.error("REST客户端异常", e);
            return "请求处理异常，请稍后重试";
        } catch (Exception e) {
            logger.error("未知异常", e);
            return "系统异常，请稍后重试";
        }
    }
}
