package com.fr.service;

import com.fr.common.PageResult;
import com.fr.entity.OperationLog;

import java.util.List;

public interface OperationLogService {
    void log(int userId, String userName, String role, String operation, String module, String detail, String ip);
    List<OperationLog> getAllLogs();
    List<OperationLog> getLogsByConditions(String userName, String operation, String role);
    PageResult<OperationLog> getLogsWithPage(int pageNum, int pageSize, String userName, String operation, String role);
    int deleteLogsBeforeDate(String date);
    int countLogsBeforeDate(String date);
}