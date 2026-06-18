package com.fr.task;

import com.fr.service.OperationLogService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.text.SimpleDateFormat;
import java.util.Date;

@Component
public class LogCleanTask {

    private static final Logger logger = LoggerFactory.getLogger(LogCleanTask.class);

    @Autowired
    private OperationLogService operationLogService;

    /**
     * 定时清理历史日志
     * cron: 0 0 3 * * ? - 每天凌晨3:00自动执行
     * 删除 create_time < 当天 00:00:00 的历史日志，保留当日数据
     */
    @Scheduled(cron = "0 0 3 * * ?")
    public void cleanLogs() {
        logger.info("开始执行日志清理任务...");
        
        // 获取当天 00:00:00 的日期字符串
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd 00:00:00");
        String todayStart = sdf.format(new Date());
        
        // 步骤1: 查询非当天的日志数量
        int count = operationLogService.countLogsBeforeDate(todayStart);
        logger.info("待清理的历史日志数量: {}", count);
        
        if (count > 0) {
            // 步骤2: 调用 deleteLogs 批量删除
            int deletedCount = operationLogService.deleteLogsBeforeDate(todayStart);
            logger.info("成功清理 {} 条历史日志", deletedCount);
            
            // 步骤3: 写入一条 CLEAN 类型的新日志记录本次清理操作
            operationLogService.log(0, "system", "系统", "CLEAN", "日志管理", 
                "自动清理历史日志，共清理 " + deletedCount + " 条记录", null);
        } else {
            logger.info("没有需要清理的历史日志");
        }
        
        logger.info("日志清理任务执行完成");
    }
}