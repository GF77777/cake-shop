package com.fr.config;

import com.fr.service.OperationLogService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Component
public class OperationLogInterceptor implements HandlerInterceptor {

    private static final Logger logger = LoggerFactory.getLogger(OperationLogInterceptor.class);

    @Autowired
    private OperationLogService operationLogService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // 将请求信息存储到请求属性中，供后续控制器使用
        String ip = getClientIp(request);
        request.setAttribute("clientIp", ip);
        
        // 从请求头或Session获取当前用户信息（这里简化处理，实际项目中应该从JWT token或Session获取）
        String userId = request.getHeader("X-User-Id");
        String userName = request.getHeader("X-User-Name");
        String role = request.getHeader("X-Role");
        
        if (userId != null) {
            request.setAttribute("userId", Integer.parseInt(userId));
        }
        if (userName != null) {
            request.setAttribute("userName", userName);
        }
        if (role != null) {
            request.setAttribute("role", role);
        }
        
        return true;
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
            ip = request.getHeader("X-Real-IP");
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