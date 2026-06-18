package com.fr.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

@Mapper
public interface StatisticsMapper {

    @Select("SELECT COUNT(*) FROM `order`")
    int getTotalOrderCount();

    @Select("SELECT COALESCE(SUM(total), 0) FROM `order`")
    double getTotalSalesAmount();

    @Select("SELECT COUNT(*) FROM `order` WHERE DATE(datetime) = CURDATE()")
    int getTodayOrderCount();

    @Select("SELECT COALESCE(SUM(total), 0) FROM `order` WHERE DATE(datetime) = CURDATE()")
    double getTodaySalesAmount();

    @Select("SELECT s.statusName, s.count, ROUND(s.count * 100.0 / t.total, 2) AS percentage FROM (SELECT status, CASE status WHEN 0 THEN '待发货' WHEN 1 THEN '已发货' WHEN 2 THEN '已完成' ELSE '其他' END AS statusName, COUNT(*) AS count FROM `order` GROUP BY status) s, (SELECT COUNT(*) AS total FROM `order`) t")
    List<Map<String, Object>> getOrderStatusDistribution();

    @Select("SELECT p.payTypeName, p.count, ROUND(p.count * 100.0 / t.total, 2) AS percentage FROM (SELECT paytype, CASE paytype WHEN 0 THEN '支付宝' WHEN 1 THEN '微信支付' WHEN 2 THEN '银行卡' ELSE '其他' END AS payTypeName, COUNT(*) AS count FROM `order` GROUP BY paytype) p, (SELECT COUNT(*) AS total FROM `order`) t")
    List<Map<String, Object>> getPayTypeDistribution();

    @Select("SELECT COUNT(*) FROM goods")
    int getTotalGoodsCount();

    @Select("SELECT COALESCE(SUM(stock), 0) FROM goods")
    int getTotalStock();

    @Select("SELECT t.name AS typeName, COUNT(g.id) AS count FROM type t LEFT JOIN goods g ON t.id = g.type_id GROUP BY t.id, t.name")
    List<Map<String, Object>> getGoodsByType();

    @Select("SELECT g.id, g.name, g.stock, t.name AS typeName FROM goods g LEFT JOIN type t ON g.type_id = t.id WHERE g.stock <= #{threshold} ORDER BY g.stock ASC")
    List<Map<String, Object>> getLowStockGoods(int threshold);

    @Select("SELECT COUNT(*) FROM user")
    int getTotalUserCount();

    @Select("SELECT COUNT(*) FROM user WHERE isadmin = 1")
    int getAdminCount();

    @Select("SELECT COUNT(*) FROM user WHERE isadmin = 0")
    int getNormalUserCount();

    @Select("SELECT COUNT(*) FROM user WHERE isvalidate = 0")
    int getUnvalidatedUserCount();

    @Select("SELECT d.date, d.orderCount, d.salesAmount FROM (SELECT DATE(datetime) AS date, COUNT(*) AS orderCount, COALESCE(SUM(total), 0) AS salesAmount FROM `order` WHERE datetime >= DATE_SUB(CURDATE(), INTERVAL 7 DAY) GROUP BY DATE(datetime)) d ORDER BY d.date ASC")
    List<Map<String, Object>> getDailySalesTrend();

    @Select("SELECT YEARWEEK(datetime, 1) AS weekNum, DATE_FORMAT(DATE_SUB(MIN(datetime), INTERVAL WEEKDAY(MIN(datetime)) DAY), '%Y-%m-%d') AS weekStart, COUNT(*) AS orderCount FROM `order` WHERE datetime >= DATE_SUB(CURDATE(), INTERVAL 4 WEEK) GROUP BY YEARWEEK(datetime, 1) ORDER BY weekNum ASC")
    List<Map<String, Object>> getWeeklyOrderTrend();

    @Select("SELECT m.month, m.orderCount, m.salesAmount FROM (SELECT DATE_FORMAT(datetime, '%Y-%m') AS month, COUNT(*) AS orderCount, COALESCE(SUM(total), 0) AS salesAmount FROM `order` WHERE datetime >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH) GROUP BY DATE_FORMAT(datetime, '%Y-%m')) m ORDER BY m.month ASC")
    List<Map<String, Object>> getMonthlySalesTrend();
}