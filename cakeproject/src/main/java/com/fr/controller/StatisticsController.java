package com.fr.controller;

import com.fr.common.AjaxResult;
import com.fr.service.StatisticsService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api")
public class StatisticsController {

    private static final Logger logger = LoggerFactory.getLogger(StatisticsController.class);

    @Autowired
    private StatisticsService statisticsService;

    @GetMapping("/statistics/order")
    public AjaxResult<Map<String, Object>> getOrderStatistics() {
        logger.info("接收到获取订单统计请求");
        try {
            Map<String, Object> result = statisticsService.getOrderStatistics();
            return AjaxResult.success("查询成功", result);
        } catch (Exception e) {
            logger.error("获取订单统计失败", e);
            return AjaxResult.error("查询失败");
        }
    }

    @GetMapping("/statistics/goods")
    public AjaxResult<Map<String, Object>> getGoodsStatistics() {
        logger.info("接收到获取商品统计请求");
        try {
            Map<String, Object> result = statisticsService.getGoodsStatistics();
            return AjaxResult.success("查询成功", result);
        } catch (Exception e) {
            logger.error("获取商品统计失败", e);
            return AjaxResult.error("查询失败");
        }
    }

    @GetMapping("/statistics/user")
    public AjaxResult<Map<String, Object>> getUserStatistics() {
        logger.info("接收到获取用户统计请求");
        try {
            Map<String, Object> result = statisticsService.getUserStatistics();
            return AjaxResult.success("查询成功", result);
        } catch (Exception e) {
            logger.error("获取用户统计失败", e);
            return AjaxResult.error("查询失败");
        }
    }

    @GetMapping("/statistics/dailyTrend")
    public AjaxResult<List<Map<String, Object>>> getDailySalesTrend() {
        logger.info("接收到获取日销售趋势请求");
        try {
            List<Map<String, Object>> result = statisticsService.getDailySalesTrend();
            return AjaxResult.success("查询成功", result);
        } catch (Exception e) {
            logger.error("获取日销售趋势失败", e);
            return AjaxResult.error("查询失败");
        }
    }

    @GetMapping("/statistics/weeklyTrend")
    public AjaxResult<List<Map<String, Object>>> getWeeklyOrderTrend() {
        logger.info("接收到获取周订单趋势请求");
        try {
            List<Map<String, Object>> result = statisticsService.getWeeklyOrderTrend();
            return AjaxResult.success("查询成功", result);
        } catch (Exception e) {
            logger.error("获取周订单趋势失败", e);
            return AjaxResult.error("查询失败");
        }
    }

    @GetMapping("/statistics/monthlyTrend")
    public AjaxResult<List<Map<String, Object>>> getMonthlySalesTrend() {
        logger.info("接收到获取月销售趋势请求");
        try {
            List<Map<String, Object>> result = statisticsService.getMonthlySalesTrend();
            return AjaxResult.success("查询成功", result);
        } catch (Exception e) {
            logger.error("获取月销售趋势失败", e);
            return AjaxResult.error("查询失败");
        }
    }

    @GetMapping("/statistics/all")
    public AjaxResult<Map<String, Object>> getAllStatistics() {
        logger.info("接收到获取所有统计请求");
        try {
            Map<String, Object> result = statisticsService.getAllStatistics();
            return AjaxResult.success("查询成功", result);
        } catch (Exception e) {
            logger.error("获取所有统计失败", e);
            return AjaxResult.error("查询失败");
        }
    }
}