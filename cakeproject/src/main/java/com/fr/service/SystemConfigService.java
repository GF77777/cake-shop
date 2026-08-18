package com.fr.service;

import com.fr.entity.SystemConfig;

public interface SystemConfigService {
    SystemConfig getByKey(String configKey);

    String getValue(String configKey);

    int updateValue(String configKey, String configValue);

    double getDefaultDeliveryFee();

    int updateDefaultDeliveryFee(double deliveryFee);

    int getStockWarningThreshold();

    int updateStockWarningThreshold(int threshold);
}