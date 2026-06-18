package com.fr.service.impl;

import com.fr.common.PageResult;
import com.fr.entity.Order;
import com.fr.entity.OrderItem;
import com.fr.mapper.GoodsMapper;
import com.fr.mapper.OrderItemMapper;
import com.fr.mapper.OrderMapper;
import com.fr.service.OrderService;
import com.github.pagehelper.PageHelper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class OrderServiceImpl implements OrderService {

    private static final Logger logger = LoggerFactory.getLogger(OrderServiceImpl.class);

    @Autowired
    private OrderMapper orderMapper;

    @Autowired
    private OrderItemMapper orderItemMapper;

    @Autowired
    private GoodsMapper goodsMapper;

    @Autowired
    private com.fr.service.SystemConfigService systemConfigService;

    @Override
    public PageResult<Order> getAllOrders(int pageNum, int pageSize) {
        logger.info("查询所有订单, pageNum={}, pageSize={}", pageNum, pageSize);
        PageHelper.startPage(pageNum, pageSize);
        List<Order> orders = orderMapper.getAll();
        return PageResult.of(orders);
    }

    @Override
    public PageResult<Order> getOrdersByUserId(int userId, int pageNum, int pageSize) {
        logger.info("按用户ID查询订单, userId={}, pageNum={}, pageSize={}", userId, pageNum, pageSize);
        PageHelper.startPage(pageNum, pageSize);
        List<Order> orders = orderMapper.getByUserId(userId);
        return PageResult.of(orders);
    }

    @Override
    public PageResult<Order> getOrdersByUserIdAndKeyword(int userId, String keyword, int pageNum, int pageSize) {
        logger.info("按用户ID和关键词查询订单, userId={}, keyword={}, pageNum={}, pageSize={}", userId, keyword, pageNum, pageSize);
        PageHelper.startPage(pageNum, pageSize);
        List<Order> orders = orderMapper.getByUserIdAndKeyword(userId, keyword);
        return PageResult.of(orders);
    }

    @Override
    @Transactional
    public int submitOrder(Order order, List<OrderItem> items) {
        logger.info("提交订单, userId={}", order.getUserId());
        // 从系统配置中获取默认配送费
        double defaultDeliveryFee = systemConfigService.getDefaultDeliveryFee();
        order.setDeliveryFee(defaultDeliveryFee);
        logger.info("设置配送费为: {}", defaultDeliveryFee);
        int result = orderMapper.addOrder(order);
        if (result > 0 && items != null && !items.isEmpty()) {
            int orderId = order.getOrderId();
            for (OrderItem item : items) {
                item.setOrderId(orderId);
                orderItemMapper.addOrderItem(item);
            }
        }
        logger.info("订单提交结果: {}", result > 0 ? "成功" : "失败");
        return result;
    }

    @Override
    @Transactional
    public int updateOrder(int orderId, int status, int payType, String name, String phone, String address) {
        logger.info("修改订单, orderId={}", orderId);
        return orderMapper.updateOrder(orderId, status, payType, name, phone, address);
    }

    @Override
    @Transactional
    public int updateDeliveryFee(int orderId, double deliveryFee) {
        logger.info("修改配送费, orderId={}, deliveryFee={}", orderId, deliveryFee);
        return orderMapper.updateDeliveryFee(orderId, deliveryFee);
    }

    @Override
    @Transactional
    public int deleteOrder(int orderId) {
        logger.info("删除订单, orderId={}", orderId);
        orderItemMapper.deleteByOrderId(orderId);
        int result = orderMapper.delete(orderId);
        logger.info("删除订单结果: {}", result > 0 ? "成功" : "失败");
        return result;
    }

    @Override
    @Transactional
    public int deliverOrder(int orderId) {
        logger.info("订单发货, orderId={}", orderId);
        
        // 获取订单的所有订单项
        List<OrderItem> items = orderItemMapper.getByOrderId(orderId);
        
        // 扣减每个商品的库存
        for (OrderItem item : items) {
            int goodsId = item.getGoodId();
            int amount = item.getAmount();
            logger.info("扣减商品库存, goodsId={}, amount={}", goodsId, amount);
            
            int reduceResult = goodsMapper.reduceStock(goodsId, amount);
            if (reduceResult == 0) {
                logger.error("商品库存不足, goodsId={}, amount={}", goodsId, amount);
                throw new RuntimeException("商品库存不足");
            }
        }
        
        // 更新订单状态为已发货
        int result = orderMapper.deliverOrder(orderId);
        logger.info("订单发货结果: {}", result > 0 ? "成功" : "失败");
        return result;
    }

    @Override
    public int confirmOrder(int orderId) {
        logger.info("用户确认收货, orderId={}", orderId);
        int result = orderMapper.confirmOrder(orderId);
        logger.info("确认收货结果: {}", result > 0 ? "成功" : "失败");
        return result;
    }

    @Override
    public Order getOrderById(int orderId) {
        logger.info("获取订单信息, orderId={}", orderId);
        return orderMapper.getById(orderId);
    }
}
