package com.fr.mapper;

import com.fr.entity.OrderItem;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface OrderItemMapper {
    /*添加订单项*/
    int addOrderItem(OrderItem item);

    /*按订单ID查询订单项*/
    List<OrderItem> getByOrderId(@Param("orderId") int orderId);

    /*删除订单项*/
    int deleteByOrderId(@Param("orderId") int orderId);
}