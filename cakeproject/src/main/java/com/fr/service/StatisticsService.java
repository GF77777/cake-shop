package com.fr.service;

import java.util.List;
import java.util.Map;

public interface StatisticsService {
    Map<String, Object> getOrderStatistics();
    Map<String, Object> getGoodsStatistics();
    Map<String, Object> getUserStatistics();
    List<Map<String, Object>> getDailySalesTrend();
    List<Map<String, Object>> getWeeklyOrderTrend();
    List<Map<String, Object>> getMonthlySalesTrend();
    Map<String, Object> getAllStatistics();
}