package com.fr.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import java.io.IOException;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")
                .allowedOriginPatterns("*")
                .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS")
                .allowedHeaders("*")
                .allowCredentials(true);
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // 配置静态资源映射，允许访问 /picture/ 目录下的图片
        String picturePath = System.getProperty("user.dir") + "/picture/";
        registry.addResourceHandler("/picture/**")
                .addResourceLocations("file:" + picturePath);
    }

    @WebFilter("/*")
    public static class CharacterEncodingFilter implements Filter {
        @Override
        public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
                throws IOException, ServletException {
            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");
            response.setContentType("application/json;charset=UTF-8");
            chain.doFilter(request, response);
        }
    }
}