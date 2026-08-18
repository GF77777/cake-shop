package com.fr.controller;

import com.fr.common.AjaxResult;
import com.fr.entity.Order;
import com.fr.entity.Rider;
import com.fr.service.RiderService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/rider")
public class RiderController {

    private static final Logger logger = LoggerFactory.getLogger(RiderController.class);

    @Autowired
    private RiderService riderService;

    @Autowired
    private com.fr.service.MessageService messageService;

    @PostMapping("/register")
    public AjaxResult<Void> register(Rider rider) {
        String userName = rider.getUserName();
        String passWord = rider.getPassWord();
        String realName = rider.getRealName();
        String phone = rider.getPhone();
        String workNo = rider.getWorkNo();
        String area = rider.getArea();
        
        logger.info("接收到骑手注册请求, userName={}, passWord={}, realName={}, phone={}, workNo={}, area={}", 
                   userName, passWord, realName, phone, workNo, area);
        
        // 参数校验
        if (userName == null || userName.trim().isEmpty()) {
            return AjaxResult.fail("账号不能为空");
        }
        if (passWord == null || passWord.trim().isEmpty()) {
            return AjaxResult.fail("密码不能为空");
        }
        if (realName == null || realName.trim().isEmpty()) {
            return AjaxResult.fail("姓名不能为空");
        }
        if (phone == null || phone.trim().isEmpty()) {
            return AjaxResult.fail("手机号不能为空");
        }
        
        try {
            // 检查账号是否已存在
            Rider existing = riderService.getByUserName(userName);
            if (existing != null) {
                return AjaxResult.fail("账号已存在");
            }
            
            rider.setStatus(0);
            rider.setCreateTime(java.time.LocalDateTime.now());
            
            int result = riderService.addRider(rider);
            if (result > 0) {
                return AjaxResult.success("注册成功", null);
            } else {
                return AjaxResult.fail("注册失败");
            }
        } catch (Exception e) {
            logger.error("骑手注册失败", e);
            return AjaxResult.error("注册失败");
        }
    }

    @PostMapping("/login")
    public AjaxResult<Rider> login(@RequestBody Map<String, String> request) {
        String userName = request.get("userName");
        String passWord = request.get("passWord");
        logger.info("接收到骑手登录请求, userName={}", userName);
        try {
            Rider rider = riderService.login(userName, passWord);
            if (rider != null) {
                return AjaxResult.success("登录成功", rider);
            } else {
                return AjaxResult.fail("用户名或密码错误");
            }
        } catch (Exception e) {
            logger.error("骑手登录失败", e);
            return AjaxResult.error("登录失败");
        }
    }

    @PostMapping("/logout")
    public AjaxResult<Void> logout(@RequestBody Map<String, Integer> request) {
        Integer riderId = request.get("riderId");
        logger.info("接收到骑手退出登录请求, riderId={}", riderId);
        try {
            riderService.updateStatus(riderId, 0);
            return AjaxResult.success("退出成功", null);
        } catch (Exception e) {
            logger.error("骑手退出失败", e);
            return AjaxResult.error("退出失败");
        }
    }

    @GetMapping("/info")
    public AjaxResult<Rider> getRiderInfo(@RequestParam int riderId) {
        logger.info("接收到获取骑手信息请求, riderId={}", riderId);
        try {
            Rider rider = riderService.getById(riderId);
            if (rider != null) {
                return AjaxResult.success("查询成功", rider);
            } else {
                return AjaxResult.fail("骑手不存在");
            }
        } catch (Exception e) {
            logger.error("获取骑手信息失败", e);
            return AjaxResult.error("查询失败");
        }
    }

    @PostMapping("/updatePassword")
    public AjaxResult<Void> updatePassword(@RequestBody Map<String, Object> request) {
        Integer riderId = (Integer) request.get("riderId");
        String password = (String) request.get("password");
        logger.info("接收到修改骑手密码请求, riderId={}", riderId);
        try {
            int result = riderService.updatePassword(riderId, password);
            if (result > 0) {
                return AjaxResult.success("修改成功", null);
            } else {
                return AjaxResult.fail("修改失败");
            }
        } catch (Exception e) {
            logger.error("修改骑手密码失败", e);
            return AjaxResult.error("修改失败");
        }
    }

    @PostMapping("/updateInfo")
    public AjaxResult<Void> updateRiderInfo(@RequestBody Rider rider) {
        logger.info("接收到修改骑手信息请求, riderId={}, realName={}, phone={}, area={}", 
                   rider.getId(), rider.getRealName(), rider.getPhone(), rider.getArea());
        try {
            int result = riderService.updateRiderProfile(rider);
            if (result > 0) {
                return AjaxResult.success("修改成功", null);
            } else {
                return AjaxResult.fail("修改失败");
            }
        } catch (Exception e) {
            logger.error("修改骑手信息失败", e);
            return AjaxResult.error("修改失败");
        }
    }

    @PostMapping("/updateStatus")
    public AjaxResult<Void> updateStatus(@RequestBody Map<String, Integer> request) {
        Integer riderId = request.get("riderId");
        Integer status = request.get("status");
        logger.info("接收到更新骑手状态请求, riderId={}, status={}", riderId, status);
        try {
            int result = riderService.updateStatus(riderId, status);
            if (result > 0) {
                return AjaxResult.success("更新成功", null);
            } else {
                return AjaxResult.fail("更新失败");
            }
        } catch (Exception e) {
            logger.error("更新骑手状态失败", e);
            return AjaxResult.error("更新失败");
        }
    }

    @GetMapping("/orders/pending")
    public AjaxResult<List<Order>> getPendingOrders() {
        logger.info("接收到获取待接单订单请求");
        try {
            List<Order> orders = riderService.getPendingOrders();
            return AjaxResult.success("查询成功", orders);
        } catch (Exception e) {
            logger.error("获取待接单订单失败", e);
            return AjaxResult.error("查询失败");
        }
    }

    @GetMapping("/orders/accepted")
    public AjaxResult<List<Order>> getAcceptedOrders(@RequestParam int riderId) {
        logger.info("接收到获取已接单订单请求, riderId={}", riderId);
        try {
            List<Order> orders = riderService.getAcceptedOrders(riderId);
            return AjaxResult.success("查询成功", orders);
        } catch (Exception e) {
            logger.error("获取已接单订单失败", e);
            return AjaxResult.error("查询失败");
        }
    }

    @GetMapping("/orders/delivering")
    public AjaxResult<List<Order>> getDeliveringOrders(@RequestParam int riderId) {
        logger.info("接收到获取配送中订单请求, riderId={}", riderId);
        try {
            List<Order> orders = riderService.getDeliveringOrders(riderId);
            return AjaxResult.success("查询成功", orders);
        } catch (Exception e) {
            logger.error("获取配送中订单失败", e);
            return AjaxResult.error("查询失败");
        }
    }

    @GetMapping("/orders/history")
    public AjaxResult<List<Order>> getHistoryOrders(@RequestParam int riderId) {
        logger.info("接收到获取历史订单请求, riderId={}", riderId);
        try {
            List<Order> orders = riderService.getHistoryOrders(riderId);
            return AjaxResult.success("查询成功", orders);
        } catch (Exception e) {
            logger.error("获取历史订单失败", e);
            return AjaxResult.error("查询失败");
        }
    }

    @GetMapping("/order/detail")
    public AjaxResult<Order> getOrderDetail(@RequestParam int orderId) {
        logger.info("接收到获取订单详情请求, orderId={}", orderId);
        try {
            Order order = riderService.getOrderDetail(orderId);
            if (order != null) {
                return AjaxResult.success("查询成功", order);
            } else {
                return AjaxResult.fail("订单不存在");
            }
        } catch (Exception e) {
            logger.error("获取订单详情失败", e);
            return AjaxResult.error("查询失败");
        }
    }

    @PostMapping("/order/accept")
    public AjaxResult<Void> acceptOrder(@RequestBody Map<String, Integer> request) {
        Integer orderId = request.get("orderId");
        Integer riderId = request.get("riderId");
        logger.info("接收到骑手接单请求, orderId={}, riderId={}", orderId, riderId);
        try {
            int result = riderService.acceptOrder(orderId, riderId);
            if (result > 0) {
                // 发送接单成功消息通知
                messageService.addMessage(riderId, "order", "订单已接单", 
                        String.format("您已成功接单，订单号：%d，请尽快前往商家取货", orderId));
                return AjaxResult.success("接单成功", null);
            } else {
                return AjaxResult.fail("接单失败");
            }
        } catch (Exception e) {
            logger.error("骑手接单失败", e);
            return AjaxResult.error("接单失败");
        }
    }

    @PostMapping("/order/start")
    public AjaxResult<Void> startDelivery(@RequestBody Map<String, Integer> request) {
        Integer orderId = request.get("orderId");
        logger.info("接收到开始配送请求, orderId={}", orderId);
        try {
            // 获取订单信息
            Order order = riderService.getOrderDetail(orderId);
            if (order == null) {
                return AjaxResult.fail("订单不存在");
            }
            int riderId = order.getRiderId();
            
            int result = riderService.startDelivery(orderId);
            if (result > 0) {
                // 发送开始取货消息通知
                messageService.addMessage(riderId, "order", "开始取货", 
                        String.format("您已到达商家并开始取货，订单号：%d", orderId));
                return AjaxResult.success("开始配送", null);
            } else {
                return AjaxResult.fail("操作失败");
            }
        } catch (Exception e) {
            logger.error("开始配送失败", e);
            return AjaxResult.error("操作失败");
        }
    }

    @PostMapping("/order/complete")
    public AjaxResult<Void> completeDelivery(@RequestBody Map<String, Integer> request) {
        Integer orderId = request.get("orderId");
        logger.info("接收到确认送达请求, orderId={}", orderId);
        try {
            // 获取订单信息
            Order order = riderService.getOrderDetail(orderId);
            if (order == null) {
                return AjaxResult.fail("订单不存在");
            }
            int riderId = order.getRiderId();
            Double deliveryFeeObj = order.getDeliveryFee();
            double deliveryFee = deliveryFeeObj != null ? deliveryFeeObj : 0.0;
            
            int result = riderService.completeDelivery(orderId);
            if (result > 0) {
                // 发送收入到账通知
                String content = String.format("您完成了一笔配送订单，配送收入：¥%.2f已到账", deliveryFee);
                messageService.addMessage(riderId, "income", "收入到账", content);
                return AjaxResult.success("送达成功", null);
            } else {
                return AjaxResult.fail("操作失败");
            }
        } catch (Exception e) {
            logger.error("确认送达失败", e);
            return AjaxResult.error("操作失败");
        }
    }

    @PostMapping("/order/cancel")
    public AjaxResult<Void> cancelOrder(@RequestBody Map<String, Object> request) {
        Integer orderId = (Integer) request.get("orderId");
        String reason = (String) request.get("reason");
        logger.info("接收到取消订单请求, orderId={}, reason={}", orderId, reason);
        try {
            int result = riderService.cancelOrder(orderId, reason);
            if (result > 0) {
                return AjaxResult.success("取消成功", null);
            } else {
                return AjaxResult.fail("取消失败");
            }
        } catch (Exception e) {
            logger.error("取消订单失败", e);
            return AjaxResult.error("取消失败");
        }
    }

    @GetMapping("/statistics/today")
    public AjaxResult<Map<String, Object>> getTodayStatistics(@RequestParam int riderId) {
        logger.info("接收到获取今日统计请求, riderId={}", riderId);
        try {
            Map<String, Object> result = riderService.getTodayStatistics(riderId);
            return AjaxResult.success("查询成功", result);
        } catch (Exception e) {
            logger.error("获取今日统计失败", e);
            return AjaxResult.error("查询失败");
        }
    }

    @GetMapping("/statistics/month")
    public AjaxResult<Map<String, Object>> getMonthStatistics(@RequestParam int riderId) {
        logger.info("接收到获取本月统计请求, riderId={}", riderId);
        try {
            Map<String, Object> result = riderService.getMonthStatistics(riderId);
            return AjaxResult.success("查询成功", result);
        } catch (Exception e) {
            logger.error("获取本月统计失败", e);
            return AjaxResult.error("查询失败");
        }
    }

    @GetMapping("/statistics/income")
    public AjaxResult<List<Map<String, Object>>> getIncomeDetail(
            @RequestParam int riderId,
            @RequestParam(required = false, defaultValue = "0") int month) {
        logger.info("接收到获取收益明细请求, riderId={}, month={}", riderId, month);
        try {
            List<Map<String, Object>> result = riderService.getIncomeDetail(riderId, month);
            return AjaxResult.success("查询成功", result);
        } catch (Exception e) {
            logger.error("获取收益明细失败", e);
            return AjaxResult.error("查询失败");
        }
    }

    @GetMapping("/account/info")
    public AjaxResult<Map<String, Object>> getRiderAccountInfo(@RequestParam int riderId) {
        logger.info("接收到获取骑手账户信息请求, riderId={}", riderId);
        try {
            Map<String, Object> result = riderService.getRiderAccountInfo(riderId);
            return AjaxResult.success("查询成功", result);
        } catch (Exception e) {
            logger.error("获取骑手账户信息失败", e);
            return AjaxResult.error("查询失败");
        }
    }
}