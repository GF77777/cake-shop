package com.fr.controller;

import com.fr.common.AjaxResult;
import com.fr.entity.Goods;
import com.fr.service.AiService;
import com.fr.service.GoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/ai")
public class AiController {

    @Autowired
    private AiService aiService;
    
    @Autowired
    private GoodsService goodsService;
    
    @Autowired
    private com.fr.service.SalesService salesService;

    @PostMapping("/chat")
    public AjaxResult chat(@RequestBody Map<String, String> request) {
        String message = request.get("message");
        String history = request.getOrDefault("history", "");
        
        String response = aiService.chat(message, history);
        
        return AjaxResult.success(response);
    }
    
    @GetMapping("/goods")
    public AjaxResult getGoodsInfo() {
        try {
            List<Goods> goodsList = goodsService.getAllGoods();
            return AjaxResult.success(goodsList);
        } catch (Exception e) {
            return AjaxResult.error("获取商品信息失败");
        }
    }
    
    @GetMapping("/goods/format")
    public AjaxResult getFormattedGoodsInfo() {
        try {
            List<Goods> goodsList = goodsService.getAllGoods();
            List<com.fr.entity.GoodsSales> salesList = salesService.getSalesRanking();
            
            java.util.Map<Integer, Integer> salesMap = new java.util.HashMap<>();
            for (com.fr.entity.GoodsSales sales : salesList) {
                salesMap.put(sales.getGoodsId(), sales.getSalesCount());
            }
            
            java.util.Map<String, List<Goods>> goodsByType = new java.util.HashMap<>();
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
            
            StringBuilder sb = new StringBuilder();
            sb.append("我们店有以下蛋糕：\n");
            
            for (java.util.Map.Entry<String, List<Goods>> entry : goodsByType.entrySet()) {
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
            
            return AjaxResult.success(sb.toString());
        } catch (Exception e) {
            return AjaxResult.error("获取商品信息失败: " + e.getMessage());
        }
    }
}
