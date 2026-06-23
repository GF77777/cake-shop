package com.fr.service.impl;

import com.fr.common.PageResult;
import com.fr.entity.OperationLog;
import com.fr.mapper.OperationLogMapper;
import com.fr.service.OperationLogService;
import com.github.pagehelper.PageHelper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class OperationLogServiceImpl implements OperationLogService {
    
    private static final Logger logger = LoggerFactory.getLogger(OperationLogServiceImpl.class);
    
    @Autowired
    private OperationLogMapper operationLogMapper;
    
    @Override
    public void log(int userId, String userName, String role, String operation, String module, String detail, String ip) {
        try {
            OperationLog log = new OperationLog();
            log.setUserId(userId);
            log.setUserName(userName);
            log.setRole(role);
            log.setOperation(operation);
            log.setModule(module);
            log.setDetail(detail);
            log.setIp(ip);
            log.setCreateTime(new Date());
            operationLogMapper.insert(log);
        } catch (Exception e) {
            logger.error("记录操作日志失败", e);
        }
    }
    
    @Override
    public List<OperationLog> getAllLogs() {
        return operationLogMapper.selectAll();
    }
    
    @Override
    public List<OperationLog> getLogsByConditions(String userName, String operation, String role) {
        return operationLogMapper.selectByConditions(userName, operation, role);
    }
    
    @Override
    public PageResult<OperationLog> getLogsWithPage(int pageNum, int pageSize, String userName, String operation, String role) {
        logger.info("分页查询操作日志, pageNum={}, pageSize={}, userName={}, operation={}, role={}", pageNum, pageSize, userName, operation, role);
        PageHelper.startPage(pageNum, pageSize);
        List<OperationLog> logs = operationLogMapper.selectByConditions(userName, operation, role);
        return PageResult.of(logs);
    }
    
    @Override
    public int deleteLogsBeforeDate(String date) {
        try {
            return operationLogMapper.deleteLogsBeforeDate(date);
        } catch (Exception e) {
            logger.error("删除日志失败", e);
            return 0;
        }
    }
    
    @Override
    public int countLogsBeforeDate(String date) {
        try {
            return operationLogMapper.countLogsBeforeDate(date);
        } catch (Exception e) {
            logger.error("统计日志数量失败", e);
            return 0;
        }
    }
}