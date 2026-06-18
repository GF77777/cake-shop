package com.fr.controller;

import com.fr.common.AjaxResult;
import com.fr.common.PageResult;
import com.fr.entity.Goods;
import com.fr.entity.Order;
import com.fr.entity.OrderItem;
import com.fr.mapper.GoodsMapper;
import com.fr.mapper.OrderItemMapper;
import com.fr.service.OperationLogService;
import com.fr.service.OrderService;
import com.fr.util.LogUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api")
public class OrderController {

    private static final Logger logger = LoggerFactory.getLogger(OrderController.class);

    @Autowired
    private OrderService orderService;

    @Autowired
    private OrderItemMapper orderItemMapper;

    @Autowired
    private GoodsMapper goodsMapper;

    @Autowired
    private OperationLogService operationLogService;

    @Autowired
    private com.fr.service.MessageService messageService;

    @GetMapping("/order")
    public AjaxResult<PageResult<Order>> getAllOrders(
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "10") int pageSize) {
        logger.info("接收到查询所有订单请求, pageNum={}, pageSize={}", pageNum, pageSize);
        try {
            PageResult<Order> result = orderService.getAllOrders(pageNum, pageSize);
            return AjaxResult.success("查询成功", result);
        } catch (Exception e) {
            logger.error("查询所有订单失败", e);
            return AjaxResult.error("查询失败");
        }
    }

    @GetMapping("/orderByUserId")
    public AjaxResult<PageResult<Order>> getOrdersByUserId(
            @RequestParam int userId,
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "5") int pageSize,
            @RequestParam(required = false) String keyword) {
        logger.info("接收到按用户ID查询订单请求, userId={}, pageNum={}, pageSize={}, keyword={}", userId, pageNum, pageSize, keyword);
        try {
            PageResult<Order> result;
            if (keyword != null && !keyword.trim().isEmpty()) {
                result = orderService.getOrdersByUserIdAndKeyword(userId, keyword.trim(), pageNum, pageSize);
            } else {
                result = orderService.getOrdersByUserId(userId, pageNum, pageSize);
            }
            return AjaxResult.success("查询成功", result);
        } catch (Exception e) {
            logger.error("按用户ID查询订单失败", e);
            return AjaxResult.error("查询失败");
        }
    }

    @GetMapping("/orderDetail")
    public AjaxResult<Map<String, Object>> getOrderDetail(@RequestParam int orderId) {
        logger.info("接收到查询订单详情请求, orderId={}", orderId);
        try {
            // 获取订单信息
            Order order = orderService.getOrderById(orderId);
            if (order == null) {
                return AjaxResult.error("订单不存在");
            }
            
            // 获取订单项
            List<OrderItem> items = orderItemMapper.getByOrderId(orderId);
            
            // 获取商品详情
            List<Map<String, Object>> orderItems = items.stream().map(item -> {
                Map<String, Object> map = new HashMap<>();
                map.put("id", item.getId());
                map.put("price", item.getPrice());
                map.put("amount", item.getAmount());
                map.put("goodsId", item.getGoodId());
                
                // 获取商品信息
                Goods goods = goodsMapper.getById(item.getGoodId());
                if (goods != null) {
                    map.put("goodsName", goods.getName());
                    map.put("goodsCover", goods.getCover());
                    map.put("goodsPrice", goods.getPrice());
                }
                return map;
            }).collect(Collectors.toList());
            
            Map<String, Object> result = new HashMap<>();
            result.put("order", order);
            result.put("items", orderItems);
            
            return AjaxResult.success("查询成功", result);
        } catch (Exception e) {
            logger.error("查询订单详情失败", e);
            return AjaxResult.error("查询失败");
        }
    }

    @PostMapping("/order")
    public AjaxResult<Void> submitOrder(@RequestBody Map<String, Object> request) {
        logger.info("接收到提交订单请求");
        try {
            Order order = new Order();
            Map<String, Object> orderMap = (Map<String, Object>) request.get("order");
            if (orderMap.containsKey("total")) {
                order.setTotal(Double.parseDouble(orderMap.get("total").toString()));
            }
            if (orderMap.containsKey("amount")) {
                order.setAmount(Integer.parseInt(orderMap.get("amount").toString()));
            }
            if (orderMap.containsKey("status")) {
                order.setStatus(Integer.parseInt(orderMap.get("status").toString()));
            }
            if (orderMap.containsKey("payType")) {
                order.setPayType(Integer.parseInt(orderMap.get("payType").toString()));
            }
            if (orderMap.containsKey("name")) {
                order.setName(orderMap.get("name").toString());
            }
            if (orderMap.containsKey("phone")) {
                order.setPhone(orderMap.get("phone").toString());
            }
            if (orderMap.containsKey("address")) {
                order.setAddress(orderMap.get("address").toString());
            }
            if (orderMap.containsKey("userId")) {
                order.setUserId(Integer.parseInt(orderMap.get("userId").toString()));
            }
            
            order.setDateTime(LocalDateTime.now());

            List<OrderItem> items = null;
            if (request.containsKey("items")) {
                List<Map<String, Object>> itemsList = (List<Map<String, Object>>) request.get("items");
                items = itemsList.stream().map(itemMap -> {
                    OrderItem item = new OrderItem();
                    if (itemMap.containsKey("price")) {
                        item.setPrice(Double.parseDouble(itemMap.get("price").toString()));
                    }
                    if (itemMap.containsKey("amount")) {
                        item.setAmount(Integer.parseInt(itemMap.get("amount").toString()));
                    }
                    if (itemMap.containsKey("goodId")) {
                        item.setGoodId(Integer.parseInt(itemMap.get("goodId").toString()));
                    }
                    return item;
                }).collect(Collectors.toList());
            }

            int result = orderService.submitOrder(order, items);
            if (result > 0) {
                // 发送新订单提醒给所有骑手
                String content = String.format("您有一笔新订单等待接单，订单金额：¥%.2f，请及时处理", order.getTotal());
                messageService.sendToAllRiders("order", "新订单提醒", content);
                return AjaxResult.success("订单提交成功", null);
            } else {
                return AjaxResult.fail("订单提交失败");
            }
        } catch (Exception e) {
            logger.error("提交订单失败", e);
            return AjaxResult.error("订单提交失败");
        }
    }

    @PostMapping("/updateOrder")
    public AjaxResult<Void> updateOrder(
            @RequestParam int orderId,
            @RequestParam int status,
            @RequestParam int payType,
            @RequestParam String name,
            @RequestParam String phone,
            @RequestParam String address) {
        logger.info("接收到修改订单请求, orderId={}", orderId);
        try {
            int result = orderService.updateOrder(orderId, status, payType, name, phone, address);
            if (result > 0) {
                LogUtils.log(operationLogService, "UPDATE", "订单管理", "修改订单 ID: " + orderId + ", 状态: " + status);
                return AjaxResult.success("修改成功", null);
            } else {
                return AjaxResult.fail("修改失败");
            }
        } catch (Exception e) {
            logger.error("修改订单失败", e);
            return AjaxResult.error("修改失败");
        }
    }

    @DeleteMapping("/order")
    public AjaxResult<Void> deleteOrder(@RequestParam int orderId) {
        logger.info("接收到删除订单请求, orderId={}", orderId);
        try {
            int result = orderService.deleteOrder(orderId);
            if (result > 0) {
                LogUtils.log(operationLogService, "DELETE", "订单管理", "删除订单 ID: " + orderId);
                return AjaxResult.success("删除成功", null);
            } else {
                return AjaxResult.fail("删除失败");
            }
        } catch (Exception e) {
            logger.error("删除订单失败", e);
            return AjaxResult.error("删除失败");
        }
    }

    @PutMapping("/order/deliveryFee")
    public AjaxResult<Void> updateDeliveryFee(
            @RequestParam int orderId,
            @RequestParam double deliveryFee) {
        logger.info("接收到修改配送费请求, orderId={}, deliveryFee={}", orderId, deliveryFee);
        try {
            int result = orderService.updateDeliveryFee(orderId, deliveryFee);
            if (result > 0) {
                LogUtils.log(operationLogService, "UPDATE", "订单管理", "修改配送费 ID: " + orderId + ", 金额: " + deliveryFee);
                return AjaxResult.success("修改成功", null);
            } else {
                return AjaxResult.fail("修改失败");
            }
        } catch (Exception e) {
            logger.error("修改配送费失败", e);
            return AjaxResult.error("修改失败");
        }
    }

    @PutMapping("/order")
    public AjaxResult<Void> deliverOrder(@RequestParam int orderId) {
        logger.info("接收到订单发货请求, orderId={}", orderId);
        try {
            int result = orderService.deliverOrder(orderId);
            if (result > 0) {
                LogUtils.log(operationLogService, "UPDATE", "订单管理", "订单发货 ID: " + orderId);
                return AjaxResult.success("发货成功", null);
            } else {
                return AjaxResult.fail("发货失败");
            }
        } catch (Exception e) {
            logger.error("订单发货失败", e);
            return AjaxResult.error("发货失败");
        }
    }

    @PutMapping("/getorder")
    public AjaxResult<Void> confirmOrder(@RequestParam int orderId) {
        logger.info("接收到确认收货请求, orderId={}", orderId);
        try {
            int result = orderService.confirmOrder(orderId);
            if (result > 0) {
                return AjaxResult.success("确认收货成功", null);
            } else {
                return AjaxResult.fail("确认收货失败");
            }
        } catch (Exception e) {
            logger.error("确认收货失败", e);
            return AjaxResult.error("确认收货失败");
        }
    }
}
