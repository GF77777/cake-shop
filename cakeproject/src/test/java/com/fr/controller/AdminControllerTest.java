package com.fr.controller;

import com.fr.CakeprojectApplication;
import com.fr.entity.Rider;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.*;
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
 * 管理员控制器测试类
 * 测试骑手管理相关功能
 */
@SpringBootTest(classes = CakeprojectApplication.class)
@AutoConfigureMockMvc
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class AdminControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    /**
     * 测试1：获取骑手列表 - 分页查询
     */
    @Test
    @org.junit.jupiter.api.Order(1)
    @DisplayName("获取骑手列表 - 分页查询")
    void testGetRiders_Pagination() throws Exception {
        mockMvc.perform(get("/api/admin/riders")
                        .param("pageNum", "1")
                        .param("pageSize", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data").exists())
                .andExpect(jsonPath("$.data.list").isArray())
                .andExpect(jsonPath("$.data.total").isNumber());
    }

    /**
     * 测试2：获取骑手列表 - 搜索
     */
    @Test
    @org.junit.jupiter.api.Order(2)
    @DisplayName("获取骑手列表 - 搜索")
    void testGetRiders_Search() throws Exception {
        mockMvc.perform(get("/api/admin/riders")
                        .param("pageNum", "1")
                        .param("pageSize", "10")
                        .param("keyword", "test"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));
    }

    /**
     * 测试3：添加骑手 - 成功
     */
    @Test
    @org.junit.jupiter.api.Order(3)
    @DisplayName("添加骑手 - 成功")
    void testAddRider_Success() throws Exception {
        String username = "test_rider_add_" + System.currentTimeMillis();
        Rider rider = new Rider();
        rider.setUserName(username);
        rider.setPassWord("123456");
        rider.setRealName("测试骑手");
        rider.setPhone("13900139" + (System.currentTimeMillis() % 10000));
        rider.setWorkNo("R" + System.currentTimeMillis());
        rider.setArea("朝阳区");
        rider.setStatus(1);

        mockMvc.perform(post("/api/admin/riders")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(rider)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.message").value("添加成功"));
    }

    /**
     * 测试4：获取骑手详情
     */
    @Test
    @org.junit.jupiter.api.Order(4)
    @DisplayName("获取骑手详情")
    void testGetRiderById_Success() throws Exception {
        String username = "test_rider_get_" + System.currentTimeMillis();
        
        Rider rider = new Rider();
        rider.setUserName(username);
        rider.setPassWord("123456");
        rider.setRealName("测试骑手");
        rider.setPhone("13900139" + (System.currentTimeMillis() % 10000));
        rider.setWorkNo("R" + System.currentTimeMillis());
        rider.setArea("朝阳区");
        rider.setStatus(1);

        mockMvc.perform(post("/api/admin/riders")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(rider)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));

        String searchResponse = mockMvc.perform(get("/api/admin/riders")
                        .param("pageNum", "1")
                        .param("pageSize", "10")
                        .param("keyword", username))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andReturn().getResponse().getContentAsString();

        JsonNode root = objectMapper.readTree(searchResponse);
        Assertions.assertNotNull(root.get("data"), "data should not be null");
        Assertions.assertNotNull(root.get("data").get("list"), "list should not be null");
        Assertions.assertTrue(root.get("data").get("list").size() > 0, "list should not be empty");
        
        int riderId = root.get("data").get("list").get(0).get("id").asInt();
        
        mockMvc.perform(get("/api/admin/riders/{id}", riderId))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data.userName").value(username));
    }

    /**
     * 测试5：更新骑手信息
     */
    @Test
    @org.junit.jupiter.api.Order(5)
    @DisplayName("更新骑手信息")
    void testUpdateRider_Success() throws Exception {
        String username = "test_rider_update_" + System.currentTimeMillis();
        
        Rider rider = new Rider();
        rider.setUserName(username);
        rider.setPassWord("123456");
        rider.setRealName("测试骑手");
        rider.setPhone("13900139" + (System.currentTimeMillis() % 10000));
        rider.setWorkNo("R" + System.currentTimeMillis());
        rider.setArea("朝阳区");
        rider.setStatus(1);

        mockMvc.perform(post("/api/admin/riders")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(rider)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));

        String searchResponse = mockMvc.perform(get("/api/admin/riders")
                        .param("pageNum", "1")
                        .param("pageSize", "10")
                        .param("keyword", username))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andReturn().getResponse().getContentAsString();

        System.out.println("搜索骑手响应: " + searchResponse);
        
        int riderId = objectMapper.readTree(searchResponse).get("data").get("list").get(0).get("id").asInt();

        Rider updateRider = new Rider();
        updateRider.setId(riderId);
        updateRider.setUserName(username);
        updateRider.setPassWord("123456");
        updateRider.setRealName("更新后的骑手");
        updateRider.setPhone("139" + (System.currentTimeMillis() % 1000000000L)); // 使用唯一的11位手机号
        updateRider.setWorkNo("R_UPDATE_" + System.currentTimeMillis()); // 使用唯一的工号
        updateRider.setArea("海淀区");
        updateRider.setStatus(1);
        updateRider.setAvatar("");

        String updateResponse = mockMvc.perform(put("/api/admin/riders/{id}", riderId)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(updateRider)))
                .andExpect(status().isOk())
                .andReturn().getResponse().getContentAsString();
        
        System.out.println("更新骑手响应: " + updateResponse);
        
        assertTrue(updateResponse.contains("\"code\":200"), "Expected code 200 but got: " + updateResponse);
    }

    /**
     * 测试6：更新骑手状态
     */
    @Test
    @org.junit.jupiter.api.Order(6)
    @DisplayName("更新骑手状态")
    void testUpdateRiderStatus_Success() throws Exception {
        String username = "test_rider_status_" + System.currentTimeMillis();
        
        Rider rider = new Rider();
        rider.setUserName(username);
        rider.setPassWord("123456");
        rider.setRealName("测试骑手");
        rider.setPhone("13900139" + (System.currentTimeMillis() % 10000));
        rider.setWorkNo("R" + System.currentTimeMillis());
        rider.setArea("朝阳区");
        rider.setStatus(1);

        mockMvc.perform(post("/api/admin/riders")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(rider)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));

        String searchResponse = mockMvc.perform(get("/api/admin/riders")
                        .param("pageNum", "1")
                        .param("pageSize", "10")
                        .param("keyword", username))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andReturn().getResponse().getContentAsString();

        int riderId = objectMapper.readTree(searchResponse).get("data").get("list").get(0).get("id").asInt();

        Map<String, Integer> request = new HashMap<>();
        request.put("status", 0);

        mockMvc.perform(put("/api/admin/riders/{id}/status", riderId)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.message").value("更新成功"));
    }

    /**
     * 测试7：删除骑手
     */
    @Test
    @org.junit.jupiter.api.Order(7)
    @DisplayName("删除骑手")
    void testDeleteRider_Success() throws Exception {
        String username = "test_rider_delete_" + System.currentTimeMillis();
        
        Rider rider = new Rider();
        rider.setUserName(username);
        rider.setPassWord("123456");
        rider.setRealName("测试骑手");
        rider.setPhone("13900139" + (System.currentTimeMillis() % 10000));
        rider.setWorkNo("R" + System.currentTimeMillis());
        rider.setArea("朝阳区");
        rider.setStatus(1);

        mockMvc.perform(post("/api/admin/riders")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(rider)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200));

        String searchResponse = mockMvc.perform(get("/api/admin/riders")
                        .param("pageNum", "1")
                        .param("pageSize", "10")
                        .param("keyword", username))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andReturn().getResponse().getContentAsString();

        int riderId = objectMapper.readTree(searchResponse).get("data").get("list").get(0).get("id").asInt();

        mockMvc.perform(delete("/api/admin/riders/{id}", riderId))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.message").value("删除成功"));
    }
}