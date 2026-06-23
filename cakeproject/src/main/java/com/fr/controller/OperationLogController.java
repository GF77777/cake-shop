package com.fr.controller;

import com.fr.common.AjaxResult;
import com.fr.common.PageResult;
import com.fr.entity.OperationLog;
import com.fr.service.OperationLogService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/logs")
public class OperationLogController {
    
    private static final Logger logger = LoggerFactory.getLogger(OperationLogController.class);
    
    @Autowired
    private OperationLogService operationLogService;
    
    @GetMapping
    public AjaxResult<PageResult<OperationLog>> getLogs(
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "10") int pageSize,
            @RequestParam(required = false) String userName,
            @RequestParam(required = false) String operation,
            @RequestParam(required = false) String role) {
        logger.info("查询操作日志, pageNum={}, pageSize={}, userName={}, operation={}, role={}", pageNum, pageSize, userName, operation, role);
        try {
            PageResult<OperationLog> result = operationLogService.getLogsWithPage(pageNum, pageSize, userName, operation, role);
            return AjaxResult.success("查询成功", result);
        } catch (Exception e) {
            logger.error("查询操作日志失败", e);
            return AjaxResult.error("查询失败");
        }
    }
}