package com.fr.service;

import com.fr.common.PageResult;
import com.fr.entity.DeliveryRecord;
import com.fr.entity.Order;
import com.fr.entity.Rider;

import java.util.List;
import java.util.Map;

public interface RiderService {
    Rider login(String userName, String passWord);

    Rider getById(int id);

    Rider getByUserName(String userName);

    List<Rider> getAllRiders();

    int addRider(Rider rider);

    int updateRider(Rider rider);

    int updateRiderProfile(Rider rider);

    int updatePassword(int id, String password);

    int updateStatus(int id, int status);

    int deleteRider(int id);

    List<Order> getPendingOrders();

    List<Order> getAcceptedOrders(int riderId);

    List<Order> getDeliveringOrders(int riderId);

    List<Order> getHistoryOrders(int riderId);

    Order getOrderDetail(int orderId);

    int acceptOrder(int orderId, int riderId);

    int startDelivery(int orderId);

    int completeDelivery(int orderId);

    int cancelOrder(int orderId, String reason);

    Map<String, Object> getTodayStatistics(int riderId);

    Map<String, Object> getMonthStatistics(int riderId);

    List<Map<String, Object>> getIncomeDetail(int riderId, int month);

    Map<String, Object> getRiderAccountInfo(int riderId);
}