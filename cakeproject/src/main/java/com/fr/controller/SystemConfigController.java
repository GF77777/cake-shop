package com.fr.controller;

import com.fr.common.AjaxResult;
import com.fr.entity.SystemConfig;
import com.fr.service.SystemConfigService;
import com.fr.util.LogUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/system")
public class SystemConfigController {

    private static final Logger logger = LoggerFactory.getLogger(SystemConfigController.class);

    @Autowired
    private SystemConfigService systemConfigService;

    @Autowired
    private com.fr.service.OperationLogService operationLogService;

    @GetMapping("/config")
    public AjaxResult<SystemConfig> getConfig(@RequestParam String configKey) {
        logger.info("获取系统配置, configKey={}", configKey);
        try {
            SystemConfig config = systemConfigService.getByKey(configKey);
            if (config != null) {
                return AjaxResult.success("查询成功", config);
            } else {
                return AjaxResult.error("配置不存在");
            }
        } catch (Exception e) {
            logger.error("获取系统配置失败", e);
            return AjaxResult.error("查询失败");
        }
    }

    @GetMapping("/defaultDeliveryFee")
    public AjaxResult<Double> getDefaultDeliveryFee() {
        logger.info("获取默认配送费");
        try {
            double fee = systemConfigService.getDefaultDeliveryFee();
            return AjaxResult.success("查询成功", fee);
        } catch (Exception e) {
            logger.error("获取默认配送费失败", e);
            return AjaxResult.error("查询失败");
        }
    }

    @PutMapping("/defaultDeliveryFee")
    public AjaxResult<Void> updateDefaultDeliveryFee(@RequestParam double deliveryFee) {
        logger.info("更新默认配送费, deliveryFee={}", deliveryFee);
        try {
            if (deliveryFee < 0) {
                return AjaxResult.error("配送费不能为负数");
            }
            int result = systemConfigService.updateDefaultDeliveryFee(deliveryFee);
            if (result > 0) {
                LogUtils.log(operationLogService, "UPDATE", "系统配置", "更新默认配送费: " + deliveryFee + "元");
                return AjaxResult.success("更新成功", null);
            } else {
                return AjaxResult.fail("更新失败");
            }
        } catch (Exception e) {
            logger.error("更新默认配送费失败", e);
            return AjaxResult.error("更新失败");
        }
    }
}