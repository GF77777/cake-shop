package com.fr.util;

import com.fr.service.OperationLogService;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;

public class LogUtils {

    public static void log(OperationLogService logService, String operation, String module, String detail) {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        
        // 从请求上下文中获取用户信息
        Integer userId = (Integer) request.getAttribute("userId");
        String userName = (String) request.getAttribute("userName");
        String role = (String) request.getAttribute("role");
        String ip = (String) request.getAttribute("clientIp");
        
        // 如果没有从请求头获取到用户信息，使用默认值（适用于未集成认证的场景）
        if (userId == null) {
            userId = 1; // 默认管理员ID
        }
        if (userName == null || userName.isEmpty()) {
            userName = "admin";
        }
        if (role == null || role.isEmpty()) {
            role = "管理员";
        }
        
        logService.log(userId, userName, role, operation, module, detail, ip);
    }
}