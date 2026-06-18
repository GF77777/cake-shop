-- 系统配置表
CREATE TABLE IF NOT EXISTS `system_config` (
  `id` INT PRIMARY KEY AUTO_INCREMENT COMMENT '主键ID',
  `config_key` VARCHAR(100) NOT NULL UNIQUE COMMENT '配置键',
  `config_value` VARCHAR(500) NOT NULL COMMENT '配置值',
  `config_name` VARCHAR(100) NOT NULL COMMENT '配置名称',
  `description` VARCHAR(500) COMMENT '配置描述',
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  INDEX `idx_config_key` (`config_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统配置表';

-- 插入默认配送费配置
INSERT INTO `system_config` (`config_key`, `config_value`, `config_name`, `description`) 
VALUES ('default_delivery_fee', '5.00', '默认配送费', '新订单的默认配送费金额（元）')
ON DUPLICATE KEY UPDATE `config_value` = '5.00';