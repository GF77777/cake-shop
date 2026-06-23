package com.fr.service.impl;

import com.fr.common.PageResult;
import com.github.pagehelper.PageHelper;
import com.fr.entity.DeliveryRecord;
import com.fr.entity.Order;
import com.fr.entity.Rider;
import com.fr.mapper.DeliveryRecordMapper;
import com.fr.mapper.OrderMapper;
import com.fr.mapper.RiderMapper;
import com.fr.service.RiderService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class RiderServiceImpl implements RiderService {

    private static final Logger logger = LoggerFactory.getLogger(RiderServiceImpl.class);

    @Autowired
    private RiderMapper riderMapper;

    @Autowired
    private OrderMapper orderMapper;

    @Autowired
    private DeliveryRecordMapper deliveryRecordMapper;

    @Override
    public Rider login(String userName, String passWord) {
        logger.info("骑手登录, userName={}", userName);
        return riderMapper.login(userName, passWord);
    }

    @Override
    public Rider getById(int id) {
        return riderMapper.getById(id);
    }

    @Override
    public Rider getByUserName(String userName) {
        logger.info("根据用户名查询骑手, userName={}", userName);
        return riderMapper.getByUserName(userName);
    }

    @Override
    public List<Rider> getAllRiders() {
        return riderMapper.getAll();
    }

    @Override
    public PageResult<Rider> getRidersWithPage(int pageNum, int pageSize, String keyword) {
        logger.info("分页查询骑手列表, pageNum={}, pageSize={}, keyword={}", pageNum, pageSize, keyword);
        PageHelper.startPage(pageNum, pageSize);
        List<Rider> riders;
        if (keyword != null && !keyword.trim().isEmpty()) {
            riders = riderMapper.getByKeyword(keyword.trim());
        } else {
            riders = riderMapper.getAll();
        }
        return PageResult.of(riders);
    }

    @Override
    public int addRider(Rider rider) {
        logger.info("添加骑手, userName={}", rider.getUserName());
        return riderMapper.addRider(rider);
    }

    @Override
    public int updateRider(Rider rider) {
        logger.info("修改骑手信息, id={}", rider.getId());
        return riderMapper.updateRider(rider);
    }

    @Override
    public int updateRiderProfile(Rider rider) {
        logger.info("修改骑手个人信息, id={}", rider.getId());
        return riderMapper.updateRiderProfile(rider);
    }

    @Override
    public int updatePassword(int id, String password) {
        logger.info("修改骑手密码, id={}", id);
        return riderMapper.updatePassword(id, password);
    }

    @Override
    public int updateStatus(int id, int status) {
        logger.info("更新骑手状态, id={}, status={}", id, status);
        return riderMapper.updateStatus(id, status);
    }

    @Override
    public int deleteRider(int id) {
        logger.info("删除骑手, id={}", id);
        return riderMapper.deleteRider(id);
    }

    @Override
    public List<Order> getPendingOrders() {
        logger.info("获取待接单订单列表");
        return orderMapper.getPendingOrders();
    }

    @Override
    public List<Order> getAcceptedOrders(int riderId) {
        logger.info("获取骑手已接单订单列表, riderId={}", riderId);
        return orderMapper.getAcceptedOrders(riderId);
    }

    @Override
    public List<Order> getDeliveringOrders(int riderId) {
        logger.info("获取骑手配送中订单列表, riderId={}", riderId);
        return orderMapper.getDeliveringOrders(riderId);
    }

    @Override
    public List<Order> getHistoryOrders(int riderId) {
        logger.info("获取骑手历史订单列表, riderId={}", riderId);
        return orderMapper.getHistoryOrders(riderId);
    }

    @Override
    public Order getOrderDetail(int orderId) {
        logger.info("获取订单详情, orderId={}", orderId);
        return orderMapper.getById(orderId);
    }

    @Override
    @Transactional
    public int acceptOrder(int orderId, int riderId) {
        logger.info("骑手接单, orderId={}, riderId={}", orderId, riderId);
        
        Rider rider = riderMapper.getById(riderId);
        if (rider == null) {
            logger.error("骑手不存在, riderId={}", riderId);
            return 0;
        }

        int result = orderMapper.acceptOrder(orderId, riderId, rider.getRealName(), rider.getPhone());
        if (result > 0) {
            DeliveryRecord record = new DeliveryRecord();
            record.setOrderId(orderId);
            record.setRiderId(riderId);
            record.setStatus(1);
            deliveryRecordMapper.addRecord(record);
        }
        return result;
    }

    @Override
    @Transactional
    public int startDelivery(int orderId) {
        logger.info("开始配送, orderId={}", orderId);
        
        int result = orderMapper.startDelivery(orderId);
        if (result > 0) {
            DeliveryRecord record = deliveryRecordMapper.getByOrderId(orderId);
            if (record != null) {
                record.setStatus(2);
                deliveryRecordMapper.updateRecord(record);
            }
        }
        return result;
    }

    @Override
    @Transactional
    public int completeDelivery(int orderId) {
        logger.info("完成配送, orderId={}", orderId);
        
        int result = orderMapper.completeDelivery(orderId);
        if (result > 0) {
            DeliveryRecord record = deliveryRecordMapper.getByOrderId(orderId);
            if (record != null) {
                record.setStatus(3);
                deliveryRecordMapper.updateRecord(record);
            }
        }
        return result;
    }

    @Override
    @Transactional
    public int cancelOrder(int orderId, String reason) {
        logger.info("取消订单, orderId={}, reason={}", orderId, reason);
        
        DeliveryRecord record = new DeliveryRecord();
        record.setOrderId(orderId);
        Order order = orderMapper.getById(orderId);
        if (order != null && order.getRiderId() > 0) {
            record.setRiderId(order.getRiderId());
        }
        record.setStatus(-1);
        record.setRemark(reason);
        deliveryRecordMapper.addRecord(record);
        
        return orderMapper.cancelOrder(orderId);
    }

    @Override
    public Map<String, Object> getTodayStatistics(int riderId) {
        logger.info("获取今日统计, riderId={}", riderId);
        Map<String, Object> result = new HashMap<>();
        result.put("todayOrders", orderMapper.getTodayOrderCount(riderId));
        result.put("todayIncome", orderMapper.getTodayIncome(riderId));
        return result;
    }

    @Override
    public Map<String, Object> getMonthStatistics(int riderId) {
        logger.info("获取本月统计, riderId={}", riderId);
        Map<String, Object> result = new HashMap<>();
        result.put("monthOrders", orderMapper.getMonthOrderCount(riderId));
        result.put("monthIncome", orderMapper.getMonthIncome(riderId));
        return result;
    }

    @Override
    public List<Map<String, Object>> getIncomeDetail(int riderId, int month) {
        logger.info("获取收益明细, riderId={}, month={}", riderId, month);
        return orderMapper.getIncomeDetail(riderId, month);
    }

    @Override
    public Map<String, Object> getRiderAccountInfo(int riderId) {
        logger.info("获取骑手账户信息, riderId={}", riderId);
        Map<String, Object> result = new HashMap<>();
        
        // 获取骑手基本信息（包含余额）
        Rider rider = riderMapper.getById(riderId);
        if (rider != null) {
            result.put("balance", rider.getBalance() != null ? rider.getBalance() : 0.0);
        } else {
            result.put("balance", 0.0);
        }
        
        // 获取累计收入（所有已完成订单的配送费总和）
        double totalIncome = orderMapper.getTotalIncome(riderId);
        result.put("totalIncome", totalIncome);
        
        return result;
    }
}