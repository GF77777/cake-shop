package com.fr.controller;

import com.fr.CakeprojectApplication;
import com.fr.common.LoginRequest;
import com.fr.entity.User;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * 用户控制器测试类
 * 测试用户登录、注册、退出等核心功能
 */
@SpringBootTest(classes = CakeprojectApplication.class)
@AutoConfigureMockMvc
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class UserControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    private static String testUsername = "test_user_" + System.currentTimeMillis();
    private static String testPassword = "123456";

    /**
     * 测试1：用户注册功能
     */
    @Test
    @Order(1)
    @DisplayName("用户注册 - 成功")
    void testRegister_Success() throws Exception {
        User user = new User();
        user.setUserName(testUsername);
        user.setPassWord(testPassword);
        user.setName("测试用户");
        user.setEmail("test@example.com");
        user.setPhone("13800138000");

        mockMvc.perform(post("/api/register")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(user)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.message").value("注册成功"));
    }

    /**
     * 测试2：用户注册 - 用户名已存在
     */
    @Test
    @Order(2)
    @DisplayName("用户注册 - 用户名已存在")
    void testRegister_DuplicateUsername() throws Exception {
        User user = new User();
        user.setUserName(testUsername);
        user.setPassWord(testPassword);
        user.setName("重复用户");

        mockMvc.perform(post("/api/register")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(user)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(500))
                .andExpect(jsonPath("$.message").value("注册失败"));
    }

    /**
     * 测试3：用户登录 - 成功
     */
    @Test
    @Order(3)
    @DisplayName("用户登录 - 成功")
    void testLogin_Success() throws Exception {
        LoginRequest request = new LoginRequest();
        request.setUserName(testUsername);
        request.setPassWord(testPassword);

        MvcResult result = mockMvc.perform(post("/api/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.message").value("登录成功"))
                .andExpect(jsonPath("$.data.userName").value(testUsername))
                .andReturn();

        System.out.println("登录成功响应: " + result.getResponse().getContentAsString());
    }

    /**
     * 测试4：用户登录 - 密码错误
     */
    @Test
    @Order(4)
    @DisplayName("用户登录 - 密码错误")
    void testLogin_WrongPassword() throws Exception {
        LoginRequest request = new LoginRequest();
        request.setUserName(testUsername);
        request.setPassWord("wrong_password");

        mockMvc.perform(post("/api/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(400))
                .andExpect(jsonPath("$.message").value("用户名或密码错误"));
    }

    /**
     * 测试5：用户登录 - 用户不存在
     */
    @Test
    @Order(5)
    @DisplayName("用户登录 - 用户不存在")
    void testLogin_UserNotFound() throws Exception {
        LoginRequest request = new LoginRequest();
        request.setUserName("non_existent_user");
        request.setPassWord("123456");

        mockMvc.perform(post("/api/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(400))
                .andExpect(jsonPath("$.message").value("用户名或密码错误"));
    }

    /**
     * 测试6：获取用户列表 - 分页查询
     */
    @Test
    @Order(6)
    @DisplayName("获取用户列表 - 分页查询")
    void testGetUsers_Pagination() throws Exception {
        mockMvc.perform(get("/api/users")
                        .param("pageNum", "1")
                        .param("pageSize", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.data").exists())
                .andExpect(jsonPath("$.data.list").isArray())
                .andExpect(jsonPath("$.data.total").isNumber());
    }

    /**
     * 测试7：用户退出登录
     */
    @Test
    @Order(7)
    @DisplayName("用户退出登录")
    void testLogout_Success() throws Exception {
        User user = new User();
        user.setUserName(testUsername);
        user.setName("测试用户");

        mockMvc.perform(post("/api/logout")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(user)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.message").value("退出成功"));
    }
}