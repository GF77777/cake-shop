CREATE TABLE IF NOT EXISTS operation_log (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '日志ID',
    user_id INT COMMENT '用户ID（游客为0）',
    user_name VARCHAR(50) NOT NULL COMMENT '用户名',
    role VARCHAR(20) NOT NULL COMMENT '角色（管理员/用户/游客）',
    operation VARCHAR(20) NOT NULL COMMENT '操作类型（LOGIN/LOGOUT/ADD/UPDATE/DELETE）',
    module VARCHAR(50) NOT NULL COMMENT '操作模块',
    detail TEXT COMMENT '操作详情',
    ip VARCHAR(50) COMMENT '操作IP',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间',
    INDEX idx_user_name (user_name),
    INDEX idx_operation (operation),
    INDEX idx_role (role),
    INDEX idx_create_time (create_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='操作日志表';