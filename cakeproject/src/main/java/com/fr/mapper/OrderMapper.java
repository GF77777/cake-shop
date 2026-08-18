package com.fr.mapper;

import com.fr.entity.Order;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface OrderMapper {
    List<Order> getAll();

    List<Order> getByUserId(@Param("userId") int userId);

    List<Order> getByUserIdAndKeyword(@Param("userId") int userId, @Param("keyword") String keyword);

    int addOrder(Order order);

    int updateOrder(@Param("orderId") int orderId, @Param("status") int status, 
                    @Param("payType") int payType, @Param("name") String name, 
                    @Param("phone") String phone, @Param("address") String address);

    int updateDeliveryFee(@Param("orderId") int orderId, @Param("deliveryFee") double deliveryFee);

    int delete(@Param("orderId") int orderId);

    int deliverOrder(@Param("orderId") int orderId);

    int confirmOrder(@Param("orderId") int orderId);

    Order getById(@Param("orderId") int orderId);

    List<Order> getPendingOrders();

    List<Order> getAcceptedOrders(@Param("riderId") int riderId);

    List<Order> getDeliveringOrders(@Param("riderId") int riderId);

    List<Order> getHistoryOrders(@Param("riderId") int riderId);

    int acceptOrder(@Param("orderId") int orderId, @Param("riderId") int riderId,
                    @Param("riderName") String riderName, @Param("riderPhone") String riderPhone);

    int startDelivery(@Param("orderId") int orderId);

    int completeDelivery(@Param("orderId") int orderId);

    int cancelOrder(@Param("orderId") int orderId);

    int getTodayOrderCount(@Param("riderId") int riderId);

    double getTodayIncome(@Param("riderId") int riderId);

    int getMonthOrderCount(@Param("riderId") int riderId);

    double getMonthIncome(@Param("riderId") int riderId);

    List<Map<String, Object>> getIncomeDetail(@Param("riderId") int riderId, @Param("month") int month);

    double getTotalIncome(@Param("riderId") int riderId);
}