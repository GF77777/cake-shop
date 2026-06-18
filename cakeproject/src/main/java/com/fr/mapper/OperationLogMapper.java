package com.fr.mapper;

import com.fr.entity.OperationLog;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface OperationLogMapper {
    void insert(OperationLog log);
    List<OperationLog> selectAll();
    List<OperationLog> selectByConditions(
        @Param("userName") String userName,
        @Param("operation") String operation,
        @Param("role") String role
    );
    int deleteLogsBeforeDate(@Param("date") String date);
    int countLogsBeforeDate(@Param("date") String date);
}