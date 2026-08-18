package com.fr.service;

import com.fr.common.PageResult;
import com.fr.entity.Order;
import com.fr.entity.OrderItem;

import java.util.List;

public interface OrderService {
    PageResult<Order> getAllOrders(int pageNum, int pageSize);

    PageResult<Order> getOrdersByUserId(int userId, int pageNum, int pageSize);

    PageResult<Order> getOrdersByUserIdAndKeyword(int userId, String keyword, int pageNum, int pageSize);

    int submitOrder(Order order, List<OrderItem> items);

    int updateOrder(int orderId, int status, int payType, String name, String phone, String address);

    int updateDeliveryFee(int orderId, double deliveryFee);

    int deleteOrder(int orderId);

    int deliverOrder(int orderId);

    int confirmOrder(int orderId);

    Order getOrderById(int orderId);
}
