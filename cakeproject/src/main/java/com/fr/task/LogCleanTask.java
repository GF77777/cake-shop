package com.fr.task;

import com.fr.service.OperationLogService;
import com.fr.service.SystemConfigService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;

@Component
public class LogCleanTask {

    private static final Logger logger = LoggerFactory.getLogger(LogCleanTask.class);
    private static final String LAST_CLEAN_DATE_KEY = "log_clean_last_date";

    @Autowired
    private OperationLogService operationLogService;

    @Autowired
    private SystemConfigService systemConfigService;

    /**
     * 定时清理历史日志
     * cron: 0 0 3 * * ? - 每天凌晨3:00自动执行
     * 删除 create_time < 当天 00:00:00 的历史日志，保留当日数据
     * 通过记录字段确保每天只执行一次
     */
    @Scheduled(cron = "0 0 3 * * ?")
    public void scheduledCleanLogs() {
        logger.info("定时任务触发日志清理");
        cleanLogsInternal();
    }

    /**
     * 执行日志清理（供外部调用，如登录时）
     * 检查是否今天已执行，避免重复执行
     */
    public void cleanLogs() {
        logger.info("外部调用日志清理");
        cleanLogsInternal();
    }

    /**
     * 内部清理逻辑：检查今天是否已执行，然后执行清理
     */
    private void cleanLogsInternal() {
        String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        
        // 检查今天是否已执行
        String lastCleanDate = systemConfigService.getValue(LAST_CLEAN_DATE_KEY);
        if (today.equals(lastCleanDate)) {
            logger.info("今日({})已执行过日志清理，跳过", today);
            return;
        }

        logger.info("开始执行日志清理任务...");
        
        // 获取当天 00:00:00 的日期字符串
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd 00:00:00");
        String todayStart = sdf.format(new Date());
        
        // 查询非当天的日志数量
        int count = operationLogService.countLogsBeforeDate(todayStart);
        logger.info("待清理的历史日志数量: {}", count);
        
        if (count > 0) {
            // 批量删除历史日志
            int deletedCount = operationLogService.deleteLogsBeforeDate(todayStart);
            logger.info("成功清理 {} 条历史日志", deletedCount);
            
            // 写入一条 CLEAN 类型的新日志记录本次清理操作
            operationLogService.log(0, "system", "系统", "CLEAN", "日志管理", 
                "自动清理历史日志，共清理 " + deletedCount + " 条记录", null);
        } else {
            logger.info("没有需要清理的历史日志");
            // 即使没有日志，也记录一次执行
            operationLogService.log(0, "system", "系统", "CLEAN", "日志管理", 
                "执行日志清理检查，无历史日志需清理", null);
        }
        
        // 更新最后执行日期
        systemConfigService.updateValue(LAST_CLEAN_DATE_KEY, today);
        
        logger.info("日志清理任务执行完成");
    }
}