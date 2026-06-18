-- 创建骑手表
CREATE TABLE IF NOT EXISTS rider (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT '骑手ID',
    user_name VARCHAR(50) NOT NULL UNIQUE COMMENT '登录账号',
    pass_word VARCHAR(100) NOT NULL COMMENT '登录密码（加密）',
    real_name VARCHAR(50) NOT NULL COMMENT '真实姓名',
    phone VARCHAR(20) NOT NULL UNIQUE COMMENT '联系电话',
    work_no VARCHAR(30) UNIQUE COMMENT '工号',
    status INT DEFAULT 0 COMMENT '在线状态：0-离线，1-在线',
    area VARCHAR(100) COMMENT '常驻配送区域',
    avatar VARCHAR(255) COMMENT '头像URL',
    balance DECIMAL(10,2) DEFAULT 0 COMMENT '账户余额',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    INDEX idx_status (status),
    INDEX idx_area (area)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='骑手表';

-- 创建配送记录表
CREATE TABLE IF NOT EXISTS delivery_record (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT '记录ID',
    order_id INT NOT NULL COMMENT '订单ID',
    rider_id INT NOT NULL COMMENT '骑手ID',
    status INT NOT NULL COMMENT '配送状态',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    remark VARCHAR(500) COMMENT '异常备注',
    INDEX idx_order_id (order_id),
    INDEX idx_rider_id (rider_id),
    FOREIGN KEY (order_id) REFERENCES `order`(order_id) ON DELETE CASCADE,
    FOREIGN KEY (rider_id) REFERENCES rider(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='配送记录表';

-- 修改骑手表，添加账户余额字段
ALTER TABLE rider ADD COLUMN balance DECIMAL(10,2) DEFAULT 0 COMMENT '账户余额';

-- 修改订单表，添加骑手相关字段
ALTER TABLE `order` 
ADD COLUMN rider_id INT COMMENT '骑手ID' AFTER user_id,
ADD COLUMN rider_name VARCHAR(50) COMMENT '骑手姓名' AFTER rider_id,
ADD COLUMN rider_phone VARCHAR(20) COMMENT '骑手电话' AFTER rider_name,
ADD COLUMN delivery_fee DECIMAL(10,2) DEFAULT 0 COMMENT '配送费' AFTER rider_phone,
ADD COLUMN accept_time DATETIME COMMENT '接单时间' AFTER delivery_fee,
ADD COLUMN delivery_time DATETIME COMMENT '送达时间' AFTER accept_time,
ADD COLUMN remark VARCHAR(500) COMMENT '订单备注' AFTER delivery_time,
ADD INDEX idx_rider_id (rider_id);

-- 添加骑手示例数据
INSERT INTO rider (user_name, pass_word, real_name, phone, work_no, status) VALUES
('rider001', '123456', '张骑手', '13800138001', 'R001', 1),
('rider002', '123456', '李骑手', '13800138002', 'R002', 1),
('rider003', '123456', '王骑手', '13800138003', 'R003', 0);