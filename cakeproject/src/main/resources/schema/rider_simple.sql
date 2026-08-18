CREATE TABLE IF NOT EXISTS rider (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(50) NOT NULL UNIQUE,
    pass_word VARCHAR(100) NOT NULL,
    real_name VARCHAR(50) NOT NULL,
    phone VARCHAR(20) NOT NULL UNIQUE,
    work_no VARCHAR(30) UNIQUE,
    status INT DEFAULT 0,
    area VARCHAR(100),
    avatar VARCHAR(255),
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_status (status),
    INDEX idx_area (area)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS delivery_record (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    rider_id INT NOT NULL,
    status INT NOT NULL,
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    remark VARCHAR(500),
    INDEX idx_order_id (order_id),
    INDEX idx_rider_id (rider_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `order` 
ADD COLUMN rider_id INT,
ADD COLUMN rider_name VARCHAR(50),
ADD COLUMN rider_phone VARCHAR(20),
ADD COLUMN delivery_fee DECIMAL(10,2) DEFAULT 0,
ADD COLUMN accept_time DATETIME,
ADD COLUMN delivery_time DATETIME,
ADD COLUMN remark VARCHAR(500);

INSERT INTO rider (user_name, pass_word, real_name, phone, work_no, status) VALUES
('rider001', '123456', 'Rider Zhang', '13800138001', 'R001', 1),
('rider002', '123456', 'Rider Li', '13800138002', 'R002', 1),
('rider003', '123456', 'Rider Wang', '13800138003', 'R003', 0);