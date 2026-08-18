package com.fr.service.impl;

import com.fr.mapper.StatisticsMapper;
import com.fr.service.StatisticsService;
import com.fr.service.SystemConfigService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class StatisticsServiceImpl implements StatisticsService {

    private static final Logger logger = LoggerFactory.getLogger(StatisticsServiceImpl.class);

    @Autowired
    private StatisticsMapper statisticsMapper;

    @Autowired
    private SystemConfigService systemConfigService;

    @Override
    public Map<String, Object> getOrderStatistics() {
        logger.info("获取订单统计信息");
        Map<String, Object> result = new HashMap<>();
        result.put("totalOrderCount", statisticsMapper.getTotalOrderCount());
        result.put("totalSalesAmount", statisticsMapper.getTotalSalesAmount());
        result.put("todayOrderCount", statisticsMapper.getTodayOrderCount());
        result.put("todaySalesAmount", statisticsMapper.getTodaySalesAmount());
        result.put("statusDistribution", statisticsMapper.getOrderStatusDistribution());
        result.put("payTypeDistribution", statisticsMapper.getPayTypeDistribution());
        return result;
    }

    @Override
    public Map<String, Object> getGoodsStatistics() {
        logger.info("获取商品统计信息");
        Map<String, Object> result = new HashMap<>();
        result.put("totalGoodsCount", statisticsMapper.getTotalGoodsCount());
        result.put("totalStock", statisticsMapper.getTotalStock());
        result.put("goodsByType", statisticsMapper.getGoodsByType());
        // 获取动态阈值并查询库存预警商品
        int threshold = systemConfigService.getStockWarningThreshold();
        logger.info("使用库存预警阈值: {}", threshold);
        result.put("lowStockGoods", statisticsMapper.getLowStockGoods(threshold));
        return result;
    }

    @Override
    public Map<String, Object> getUserStatistics() {
        logger.info("获取用户统计信息");
        Map<String, Object> result = new HashMap<>();
        result.put("totalUserCount", statisticsMapper.getTotalUserCount());
        result.put("adminCount", statisticsMapper.getAdminCount());
        result.put("normalUserCount", statisticsMapper.getNormalUserCount());
        result.put("unvalidatedUserCount", statisticsMapper.getUnvalidatedUserCount());
        return result;
    }

    @Override
    public List<Map<String, Object>> getDailySalesTrend() {
        logger.info("获取日销售趋势");
        return statisticsMapper.getDailySalesTrend();
    }

    @Override
    public List<Map<String, Object>> getWeeklyOrderTrend() {
        logger.info("获取周订单趋势");
        return statisticsMapper.getWeeklyOrderTrend();
    }

    @Override
    public List<Map<String, Object>> getMonthlySalesTrend() {
        logger.info("获取月销售趋势");
        return statisticsMapper.getMonthlySalesTrend();
    }

    @Override
    public Map<String, Object> getAllStatistics() {
        logger.info("获取所有统计信息");
        Map<String, Object> result = new HashMap<>();
        result.put("order", getOrderStatistics());
        result.put("goods", getGoodsStatistics());
        result.put("user", getUserStatistics());
        result.put("dailyTrend", getDailySalesTrend());
        result.put("weeklyTrend", getWeeklyOrderTrend());
        result.put("monthlyTrend", getMonthlySalesTrend());
        return result;
    }
}