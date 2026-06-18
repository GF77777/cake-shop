CREATE TABLE IF NOT EXISTS message (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '消息ID',
    rider_id INT NOT NULL COMMENT '骑手ID',
    type VARCHAR(20) NOT NULL COMMENT '消息类型：order-订单, system-系统, income-收入',
    title VARCHAR(100) NOT NULL COMMENT '消息标题',
    content TEXT NOT NULL COMMENT '消息内容',
    is_read TINYINT DEFAULT 0 COMMENT '是否已读：0-未读, 1-已读',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    FOREIGN KEY (rider_id) REFERENCES rider(id) ON DELETE CASCADE,
    INDEX idx_rider_id (rider_id),
    INDEX idx_is_read (is_read),
    INDEX idx_create_time (create_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='消息表';

-- 插入示例数据
INSERT INTO message (rider_id, type, title, content, is_read, create_time) VALUES
(6, 'order', '新订单提醒', '您有一笔新订单等待接单，请及时处理', 0, NOW() - INTERVAL 10 MINUTE),
(6, 'system', '系统公告', '平台将于今晚22:00-23:00进行系统维护，请提前完成配送任务', 0, NOW() - INTERVAL 1 HOUR),
(6, 'income', '收入到账', '您今日配送收入已到账，共计¥35.00', 1, NOW() - INTERVAL 2 HOUR);