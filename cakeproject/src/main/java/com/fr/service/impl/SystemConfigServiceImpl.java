package com.fr.service.impl;

import com.fr.entity.SystemConfig;
import com.fr.mapper.SystemConfigMapper;
import com.fr.service.SystemConfigService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SystemConfigServiceImpl implements SystemConfigService {

    private static final Logger logger = LoggerFactory.getLogger(SystemConfigServiceImpl.class);
    private static final String DEFAULT_DELIVERY_FEE_KEY = "default_delivery_fee";
    private static final double DEFAULT_DELIVERY_FEE_VALUE = 5.00;
    private static final String STOCK_WARNING_THRESHOLD_KEY = "stock_warning_threshold";
    private static final int DEFAULT_STOCK_WARNING_THRESHOLD = 10;

    @Autowired
    private SystemConfigMapper systemConfigMapper;

    @Override
    public SystemConfig getByKey(String configKey) {
        return systemConfigMapper.getByKey(configKey);
    }

    @Override
    public String getValue(String configKey) {
        SystemConfig config = systemConfigMapper.getByKey(configKey);
        return config != null ? config.getConfigValue() : null;
    }

    @Override
    public int updateValue(String configKey, String configValue) {
        logger.info("更新系统配置, key={}, value={}", configKey, configValue);
        return systemConfigMapper.updateValue(configKey, configValue);
    }

    @Override
    public double getDefaultDeliveryFee() {
        try {
            String value = getValue(DEFAULT_DELIVERY_FEE_KEY);
            if (value != null && !value.isEmpty()) {
                return Double.parseDouble(value);
            }
        } catch (Exception e) {
            logger.error("获取默认配送费失败，使用默认值", e);
        }
        return DEFAULT_DELIVERY_FEE_VALUE;
    }

    @Override
    public int updateDefaultDeliveryFee(double deliveryFee) {
        logger.info("更新默认配送费, deliveryFee={}", deliveryFee);
        return updateValue(DEFAULT_DELIVERY_FEE_KEY, String.valueOf(deliveryFee));
    }

    @Override
    public int getStockWarningThreshold() {
        try {
            String value = getValue(STOCK_WARNING_THRESHOLD_KEY);
            if (value != null && !value.isEmpty()) {
                return Integer.parseInt(value);
            }
        } catch (Exception e) {
            logger.error("获取库存预警阈值失败，使用默认值", e);
        }
        return DEFAULT_STOCK_WARNING_THRESHOLD;
    }

    @Override
    public int updateStockWarningThreshold(int threshold) {
        logger.info("更新库存预警阈值, threshold={}", threshold);
        return updateValue(STOCK_WARNING_THRESHOLD_KEY, String.valueOf(threshold));
    }
}