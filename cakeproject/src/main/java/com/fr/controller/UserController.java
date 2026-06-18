package com.fr.controller;

import com.fr.common.AjaxResult;
import com.fr.common.LoginRequest;
import com.fr.common.PageResult;
import com.fr.entity.User;
import com.fr.service.OperationLogService;
import com.fr.service.UserService;
import com.fr.util.LogUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/api")
public class UserController {

    private static final Logger logger = LoggerFactory.getLogger(UserController.class);

    @Autowired
    private UserService userService;

    @Autowired
    private OperationLogService operationLogService;

    @GetMapping("/users")
    public AjaxResult<PageResult<User>> getAllUsers(
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "10") int pageSize) {
        logger.info("接收到查询用户列表请求, pageNum={}, pageSize={}", pageNum, pageSize);
        try {
            PageResult<User> result = userService.getAllUsers(pageNum, pageSize);
            return AjaxResult.success("查询成功", result);
        } catch (Exception e) {
            logger.error("查询用户列表失败", e);
            return AjaxResult.error("查询失败");
        }
    }

    @PostMapping("/login")
    public AjaxResult<User> login(@RequestBody LoginRequest request, HttpServletRequest httpRequest) {
        logger.info("接收到用户登录请求, username={}", request.getUserName());
        try {
            User user = userService.login(request.getUserName(), request.getPassWord());
            if (user != null) {
                String ip = getClientIp(httpRequest);
                String role = user.getIsAdmin() == 1 ? "管理员" : "用户";
                operationLogService.log(
                    user.getId(),
                    user.getUserName(),
                    role,
                    "LOGIN",
                    "用户登录",
                    user.getUserName() + "(" + role + ") 登录成功",
                    ip
                );
                return AjaxResult.success("登录成功", user);
            } else {
                return AjaxResult.fail("用户名或密码错误");
            }
        } catch (Exception e) {
            logger.error("用户登录失败", e);
            return AjaxResult.error("登录失败");
        }
    }

    @PostMapping("/register")
    public AjaxResult<Void> register(@RequestBody User user) {
        logger.info("接收到用户注册请求, username={}", user.getUserName());
        try {
            int result = userService.register(user);
            if (result > 0) {
                return AjaxResult.success("注册成功", null);
            } else {
                return AjaxResult.fail("注册失败");
            }
        } catch (Exception e) {
            logger.error("用户注册失败", e);
            return AjaxResult.error("注册失败");
        }
    }

    @PostMapping("/logout")
    public AjaxResult<Void> logout(@RequestBody User user, HttpServletRequest httpRequest) {
        logger.info("接收到用户退出登录请求, username={}", user.getUserName());
        try {
            String ip = getClientIp(httpRequest);
            String role = user.getIsAdmin() == 1 ? "管理员" : "用户";
            operationLogService.log(
                user.getId(),
                user.getUserName(),
                role,
                "LOGOUT",
                "用户退出",
                user.getUserName() + "(" + role + ") 退出登录",
                ip
            );
            return AjaxResult.success("退出成功", null);
        } catch (Exception e) {
            logger.error("用户退出登录失败", e);
            return AjaxResult.error("退出失败");
        }
    }

    @PostMapping("/update")
    public AjaxResult<Void> update(@RequestBody User user) {
        logger.info("接收到修改用户请求, userId={}", user.getId());
        try {
            int result = userService.update(user);
            if (result > 0) {
                LogUtils.log(operationLogService, "UPDATE", "用户管理", "修改用户 ID: " + user.getId() + ", 用户名: " + user.getUserName());
                return AjaxResult.success("修改成功", null);
            } else {
                return AjaxResult.fail("修改失败");
            }
        } catch (Exception e) {
            logger.error("修改用户失败", e);
            return AjaxResult.error("修改失败");
        }
    }

    @PostMapping("/updatePassword")
    public AjaxResult<Void> updatePassword(@RequestBody User user) {
        logger.info("接收到重置密码请求, userId={}", user.getId());
        try {
            int result = userService.updatePassword(user.getId(), user.getPassWord());
            if (result > 0) {
                LogUtils.log(operationLogService, "UPDATE", "用户管理", "重置用户密码 ID: " + user.getId());
                return AjaxResult.success("密码重置成功", null);
            } else {
                return AjaxResult.fail("密码重置失败");
            }
        } catch (Exception e) {
            logger.error("重置密码失败", e);
            return AjaxResult.error("密码重置失败");
        }
    }

    @PostMapping("/adduser")
    public AjaxResult<Void> addUser(@RequestBody User user) {
        logger.info("接收到添加用户请求, username={}", user.getUserName());
        try {
            int result = userService.addUser(user);
            if (result > 0) {
                LogUtils.log(operationLogService, "ADD", "用户管理", "添加用户: " + user.getUserName());
                return AjaxResult.success("添加成功", null);
            } else {
                return AjaxResult.fail("添加失败");
            }
        } catch (Exception e) {
            logger.error("添加用户失败", e);
            return AjaxResult.error("添加失败");
        }
    }

    @DeleteMapping("/login")
    public AjaxResult<Void> delete(@RequestParam int id) {
        logger.info("接收到删除用户请求, userId={}", id);
        try {
            int result = userService.delete(id);
            if (result > 0) {
                LogUtils.log(operationLogService, "DELETE", "用户管理", "删除用户 ID: " + id);
                return AjaxResult.success("删除成功", null);
            } else {
                return AjaxResult.fail("删除失败");
            }
        } catch (Exception e) {
            logger.error("删除用户失败", e);
            return AjaxResult.error("删除失败");
        }
    }

    private String getClientIp(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        if (ip != null && ip.contains(",")) {
            ip = ip.split(",")[0].trim();
        }
        return ip;
    }
}