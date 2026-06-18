package com.fr.mapper;

import com.fr.entity.DeliveryRecord;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface DeliveryRecordMapper {
    int addRecord(DeliveryRecord record);

    DeliveryRecord getByOrderId(int orderId);

    List<DeliveryRecord> getByRiderId(int riderId);

    int updateRecord(DeliveryRecord record);
}