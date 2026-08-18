package com.fr.controller;

import com.fr.CakeprojectApplication;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;
import org.junit.jupiter.api.MethodOrderer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import java.util.HashMap;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * 订单控制器测试类
 * 测试订单创建、查询、状态更新等核心功能
 */
@SpringBootTest(classes = CakeprojectApplication.class)
@AutoConfigureMockMvc
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class OrderControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    /**
     * 测试1：创建订单 - 成功
     */
    @Test
    @org.junit.jupiter.api.Order(1)
    @DisplayName("创建订单 - 成功")
    void testCreateOrder_Success() throws Exception {
        Map<String, Object> request = new HashMap<>();
        
        Map<String, Object> orderMap = new HashMap<>();
        orderMap.put("total", 100.00);
        orderMap.put("amount", 2);
        orderMap.put("status", 0);
        orderMap.put("payType", 0);
        orderMap.put("name", "测试收件人");
        orderMap.put("phone", "13800138000");
        orderMap.put("address", "测试地址");
        orderMap.put("userId", 1);
        
        request.put("order", orderMap);

        mockMvc.perform(post("/api/order")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.message").value("订单提交成功"));
    }

    /**
     * 测试2：获取订单列表 - 分页查询
     */
    @Test
    @org.junit.jupiter.api.Order(2)
    @DisplayName("获取订单列表 - 分页查询")
    void testGetOrders_Pagination() throws Exception {
        mockMvc.perform(get("/api/order")
                        .param("pageNum", "1")
                        .param("pageSize", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data").exists())
                .andExpect(jsonPath("$.data.list").isArray())
                .andExpect(jsonPath("$.data.total").isNumber());
    }

    /**
     * 测试3：获取订单详情 - 订单存在
     */
    @Test
    @org.junit.jupiter.api.Order(3)
    @DisplayName("获取订单详情")
    void testGetOrderDetail_Success() throws Exception {
        Map<String, Object> request = new HashMap<>();
        Map<String, Object> orderMap = new HashMap<>();
        orderMap.put("total", 88.00);
        orderMap.put("amount", 1);
        orderMap.put("status", 0);
        orderMap.put("payType", 0);
        orderMap.put("name", "详情测试");
        orderMap.put("phone", "13800138001");
        orderMap.put("address", "详情测试地址");
        orderMap.put("userId", 1);
        request.put("order", orderMap);

        mockMvc.perform(post("/api/order")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));

        String listResponse = mockMvc.perform(get("/api/order")
                        .param("pageNum", "1")
                        .param("pageSize", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andReturn().getResponse().getContentAsString();

        System.out.println("订单列表响应(详情测试): " + listResponse);

        JsonNode root = objectMapper.readTree(listResponse);
        assertTrue(root.has("data"), "Response should have data field");
        
        JsonNode dataNode = root.get("data");
        assertNotNull(dataNode, "data should not be null");
        assertTrue(dataNode.has("list"), "data should have list field");
        
        JsonNode listNode = dataNode.get("list");
        assertNotNull(listNode, "list should not be null");
        assertTrue(listNode.isArray() && listNode.size() > 0, "list should not be empty");
        
        JsonNode firstOrder = listNode.get(0);
        assertNotNull(firstOrder, "first order should not be null");
        assertTrue(firstOrder.has("orderId"), "order should have orderId field");
        
        int orderId = firstOrder.get("orderId").asInt();
        assertTrue(orderId > 0, "orderId should be positive");

        mockMvc.perform(get("/api/orderDetail")
                        .param("orderId", String.valueOf(orderId)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data.order").exists());
    }

    /**
     * 测试4：获取订单详情 - 订单不存在
     */
    @Test
    @org.junit.jupiter.api.Order(4)
    @DisplayName("获取订单详情 - 订单不存在")
    void testGetOrderDetail_NotFound() throws Exception {
        mockMvc.perform(get("/api/orderDetail")
                        .param("orderId", "99999"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(500));
    }

    /**
     * 测试5：订单发货
     */
    @Test
    @org.junit.jupiter.api.Order(5)
    @DisplayName("订单发货")
    void testDeliverOrder_Success() throws Exception {
        Map<String, Object> request = new HashMap<>();
        Map<String, Object> orderMap = new HashMap<>();
        orderMap.put("total", 66.00);
        orderMap.put("amount", 1);
        orderMap.put("status", 0);
        orderMap.put("payType", 0);
        orderMap.put("name", "发货测试");
        orderMap.put("phone", "13800138002");
        orderMap.put("address", "发货测试地址");
        orderMap.put("userId", 1);
        request.put("order", orderMap);

        mockMvc.perform(post("/api/order")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));

        String listResponse = mockMvc.perform(get("/api/order")
                        .param("pageNum", "1")
                        .param("pageSize", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andReturn().getResponse().getContentAsString();

        System.out.println("订单列表响应(发货测试): " + listResponse);

        JsonNode root = objectMapper.readTree(listResponse);
        assertTrue(root.has("data"), "Response should have data field");
        
        JsonNode dataNode = root.get("data");
        assertNotNull(dataNode, "data should not be null");
        assertTrue(dataNode.has("list"), "data should have list field");
        
        JsonNode listNode = dataNode.get("list");
        assertNotNull(listNode, "list should not be null");
        assertTrue(listNode.isArray() && listNode.size() > 0, "list should not be empty");
        
        int orderId = listNode.get(0).get("orderId").asInt();
        assertTrue(orderId > 0, "orderId should be positive");

        mockMvc.perform(put("/api/order")
                        .param("orderId", String.valueOf(orderId)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.message").value("发货成功"));
    }

    /**
     * 测试6：更新订单配送费
     */
    @Test
    @org.junit.jupiter.api.Order(6)
    @DisplayName("更新订单配送费")
    void testUpdateDeliveryFee_Success() throws Exception {
        Map<String, Object> request = new HashMap<>();
        Map<String, Object> orderMap = new HashMap<>();
        orderMap.put("total", 77.00);
        orderMap.put("amount", 1);
        orderMap.put("status", 0);
        orderMap.put("payType", 0);
        orderMap.put("name", "配送费测试");
        orderMap.put("phone", "13800138003");
        orderMap.put("address", "配送费测试地址");
        orderMap.put("userId", 1);
        request.put("order", orderMap);

        mockMvc.perform(post("/api/order")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));

        String listResponse = mockMvc.perform(get("/api/order")
                        .param("pageNum", "1")
                        .param("pageSize", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andReturn().getResponse().getContentAsString();

        System.out.println("订单列表响应(配送费测试): " + listResponse);

        JsonNode root = objectMapper.readTree(listResponse);
        assertTrue(root.has("data"), "Response should have data field");
        
        JsonNode dataNode = root.get("data");
        assertNotNull(dataNode, "data should not be null");
        assertTrue(dataNode.has("list"), "data should have list field");
        
        JsonNode listNode = dataNode.get("list");
        assertNotNull(listNode, "list should not be null");
        assertTrue(listNode.isArray() && listNode.size() > 0, "list should not be empty");
        
        int orderId = listNode.get(0).get("orderId").asInt();
        assertTrue(orderId > 0, "orderId should be positive");

        mockMvc.perform(put("/api/order/deliveryFee")
                        .param("orderId", String.valueOf(orderId))
                        .param("deliveryFee", "8.00"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.message").value("修改成功"));
    }

    /**
     * 测试7：删除订单
     */
    @Test
    @org.junit.jupiter.api.Order(7)
    @DisplayName("删除订单")
    void testDeleteOrder_Success() throws Exception {
        Map<String, Object> request = new HashMap<>();
        Map<String, Object> orderMap = new HashMap<>();
        orderMap.put("total", 50.00);
        orderMap.put("amount", 1);
        orderMap.put("status", 0);
        orderMap.put("payType", 0);
        orderMap.put("name", "删除测试");
        orderMap.put("phone", "13800138004");
        orderMap.put("address", "删除测试地址");
        orderMap.put("userId", 1);
        request.put("order", orderMap);

        mockMvc.perform(post("/api/order")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));

        String listResponse = mockMvc.perform(get("/api/order")
                        .param("pageNum", "1")
                        .param("pageSize", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andReturn().getResponse().getContentAsString();

        System.out.println("订单列表响应(删除测试): " + listResponse);

        JsonNode root = objectMapper.readTree(listResponse);
        assertTrue(root.has("data"), "Response should have data field");
        
        JsonNode dataNode = root.get("data");
        assertNotNull(dataNode, "data should not be null");
        assertTrue(dataNode.has("list"), "data should have list field");
        
        JsonNode listNode = dataNode.get("list");
        assertNotNull(listNode, "list should not be null");
        assertTrue(listNode.isArray() && listNode.size() > 0, "list should not be empty");
        
        int orderId = listNode.get(0).get("orderId").asInt();
        assertTrue(orderId > 0, "orderId should be positive");

        mockMvc.perform(delete("/api/order")
                        .param("orderId", String.valueOf(orderId)))
                .andExpect(status().isOk());
    }

    /**
     * 测试8：获取用户订单列表
     */
    @Test
    @org.junit.jupiter.api.Order(8)
    @DisplayName("获取用户订单列表")
    void testGetOrdersByUserId() throws Exception {
        mockMvc.perform(get("/api/orderByUserId")
                        .param("userId", "1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data").exists())
                .andExpect(jsonPath("$.data.list").isArray());
    }
}