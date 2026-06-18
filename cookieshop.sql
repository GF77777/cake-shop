/*
 Navicat Premium Data Transfer

 Source Server         : cust
 Source Server Type    : MySQL
 Source Server Version : 80042 (8.0.42)
 Source Host           : localhost:3306
 Source Schema         : cookieshop

 Target Server Type    : MySQL
 Target Server Version : 80042 (8.0.42)
 File Encoding         : 65001

 Date: 19/06/2026 00:20:27
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for delivery_record
-- ----------------------------
DROP TABLE IF EXISTS `delivery_record`;
CREATE TABLE `delivery_record`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `rider_id` int NOT NULL,
  `status` int NOT NULL,
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_order_id`(`order_id` ASC) USING BTREE,
  INDEX `idx_rider_id`(`rider_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of delivery_record
-- ----------------------------
INSERT INTO `delivery_record` VALUES (8, 54, 6, 3, '2026-06-18 11:14:58', NULL);
INSERT INTO `delivery_record` VALUES (9, 52, 6, 1, '2026-06-18 11:15:03', NULL);
INSERT INTO `delivery_record` VALUES (10, 50, 6, 3, '2026-06-18 11:15:11', NULL);
INSERT INTO `delivery_record` VALUES (11, 53, 6, 1, '2026-06-18 12:35:14', NULL);
INSERT INTO `delivery_record` VALUES (12, 36, 23, 2, '2026-06-18 19:03:52', NULL);
INSERT INTO `delivery_record` VALUES (13, 55, 23, 3, '2026-06-18 19:09:07', NULL);
INSERT INTO `delivery_record` VALUES (14, 51, 1, 3, '2026-06-18 19:11:58', NULL);
INSERT INTO `delivery_record` VALUES (15, 49, 23, 3, '2026-06-18 19:14:08', NULL);
INSERT INTO `delivery_record` VALUES (16, 48, 23, 1, '2026-06-18 19:14:40', NULL);
INSERT INTO `delivery_record` VALUES (17, 47, 23, 1, '2026-06-18 19:15:20', NULL);

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '商品id',
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '商品名称',
  `cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '商品封面图',
  `image1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '商品详细图1',
  `image2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '商品详细图2',
  `price` float(10, 2) NULL DEFAULT NULL COMMENT '商品价格',
  `intro` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '商品描述',
  `stock` int NULL DEFAULT NULL COMMENT '商品库存',
  `type_id` int NULL DEFAULT NULL COMMENT '商品类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES (1, '草莓冰淇淋', '/picture/9-1.jpg', '/picture/9-2.jpg', '/picture/9-3.jpg', 299.00, '采用草莓冰淇淋最受欢迎的口感配方,搭配绵密顺滑的奶浆,加入新鲜草莓果肉,制成冰淇淋,香甜可口,风味独特.\n口味:草莓冰淇淋味 主要原料:草莓,牛奶,奶油,糖\n储存温度：-12℃~-15℃冷冻', 10, 1);
INSERT INTO `goods` VALUES (2, '芒果布丁杯', '/picture/10-1.jpg', '/picture/10-2.jpg', '/picture/10-3.jpg', 28.00, '精选优质布丁师,口感浓郁,质地细腻,入口即化.布丁师精心调配比例,带来平滑柔顺的口感,呈现多层次的味觉享受.', 10, 2);
INSERT INTO `goods` VALUES (3, '原味布丁', '/picture/11-1.jpg', '/picture/11-1.jpg', '/picture/11-1.jpg', 38.00, '为保证布丁新鲜,布丁制作当天配送至门店,布丁,浓香,顺滑,天然原料,无添加,小份包装,通用水杯,确保布丁口感细腻,新鲜,留住布丁原味细节.', 10, 2);
INSERT INTO `goods` VALUES (4, '抹茶布丁杯', '/picture/12-1.jpg', '/picture/1-2.jpg', '/picture/12-1.jpg', 36.00, '抹茶布丁口感清新,浓郁茶香,质地细腻,入口顺滑.', 10, 3);
INSERT INTO `goods` VALUES (5, '巧克力蛋糕', '/picture/13-1.jpg', '/picture/13-1.jpg', '/picture/13-1.jpg', 36.00, '融合巧克力与蛋糕的双重魅力,带来丰富层次的味觉体验.口感Q弹浓郁,回味悠长.适合蛋糕爱好者的首选.', 10, 3);
INSERT INTO `goods` VALUES (6, '双莓布丁杯', '/picture/14-1.jpg', '/picture/14-1.jpg', '/picture/14-1.jpg', 39.00, '以新鲜草莓和蓝莓布丁为主要原料,口感浓郁,清新怡人.', 10, 3);
INSERT INTO `goods` VALUES (7, '小熊乐园', '/picture/8-1.jpg', '/picture/8-2.jpg', '/picture/8-3.jpg', 299.00, '高端小熊乐园,适合小朋友的一款创意甜品组合,摘取草莓冰淇淋地方特制可可风味酱料,带来一份童趣与真实的美味.\n口味:草莓混合味 主要原料:巧克力,可可粉,草莓,奶油,糖\n储存温度：5-7℃冷藏', 10, 4);
INSERT INTO `goods` VALUES (9, '生日蛋糕max', '/picture/生日蛋糕max.jpg', '/picture/生日蛋糕max.jpg', '/picture/生日蛋糕max.jpg', 532.00, '696969696', 14, 4);
INSERT INTO `goods` VALUES (12, '手作冰淇淋', '/picture/手作冰淇淋.jpg', '/picture/手作冰淇淋.jpg', '/picture/手作冰淇淋.jpg', 26.00, '好吃好吃', 10, 1);
INSERT INTO `goods` VALUES (13, 'KUMO冰淇淋', '/picture/KUMO冰淇淋.jpg', '/picture/KUMO冰淇淋.jpg', '/picture/KUMO冰淇淋.jpg', 48.00, '好吃好吃', 214, 1);
INSERT INTO `goods` VALUES (14, 'MADO冰淇淋', '/picture/MADO冰淇淋.jpg', '/picture/MADO冰淇淋.jpg', '/picture/MADO冰淇淋.jpg', 36.00, '好吃好吃', 543, 1);
INSERT INTO `goods` VALUES (15, '如迪冰淇淋', '/picture/如迪冰淇淋.jpg', '/picture/如迪冰淇淋.jpg', '/picture/如迪冰淇淋.jpg', 16.00, '好吃好吃', 355, 1);
INSERT INTO `goods` VALUES (16, '宋式冰淇淋', '/picture/宋式冰淇淋.jpg', '/picture/宋式冰淇淋.jpg', '/picture/宋式冰淇淋.jpg', 36.00, '好吃好吃', 554, 1);
INSERT INTO `goods` VALUES (17, 'DQ冰淇淋', '/picture/DQ冰淇淋.jpg', '/picture/DQ冰淇淋.jpg', '/picture/DQ冰淇淋.jpg', 24.00, '好吃好吃', 532, 1);
INSERT INTO `goods` VALUES (18, 'GODI冰淇淋', '/picture/GODI冰淇淋.jpg', '/picture/GODI冰淇淋.jpg', '/picture/GODI冰淇淋.jpg', 56.00, '好吃好吃', 354, 1);
INSERT INTO `goods` VALUES (19, '鲜果青柠茶', '/picture/鲜果青柠茶.jpg', '/picture/鲜果青柠茶.jpg', '/picture/鲜果青柠茶.jpg', 16.00, '好喝好喝', 432, 5);
INSERT INTO `goods` VALUES (20, '暴打青柠冰', '/picture/暴打青柠冰.jpg', '/picture/暴打青柠冰.jpg', '/picture/暴打青柠冰.jpg', 16.00, '好喝好喝', 351, 5);
INSERT INTO `goods` VALUES (21, '蛋糕卷', '/picture/蛋糕卷.jpg', '/picture/蛋糕卷.jpg', '/picture/蛋糕卷.jpg', 24.00, '好吃好吃', 2532, 6);
INSERT INTO `goods` VALUES (22, '杯子小蛋糕', '/picture/杯子小蛋糕.jpg', '/picture/杯子小蛋糕.jpg', '/picture/杯子小蛋糕.jpg', 26.00, '好吃好吃', 235, 6);
INSERT INTO `goods` VALUES (23, '贴纸', '/picture/贴纸.jpg', '/picture/贴纸.jpg', '/picture/贴纸.jpg', 5.00, '好看好看', 453346, 7);
INSERT INTO `goods` VALUES (24, '小蛋糕狗', '/picture/小蛋糕狗.jpg', '/picture/小蛋糕狗.jpg', '/picture/小蛋糕狗.jpg', 14.00, '可爱可爱', 5235, 7);
INSERT INTO `goods` VALUES (26, '巧克力蛋糕', '/picture/巧克力蛋糕.jpg', '/picture/巧克力蛋糕.jpg', '/picture/巧克力蛋糕.jpg', 565.00, '好吃好吃', 24, 10);
INSERT INTO `goods` VALUES (29, '甜点', '/picture/351cdeaa-2c8b-47ca-80bd-dbc0f3fdc6a6.jpg', '/picture/bf41b6cb-821d-47ec-b4f0-7f7b64c35818.jpg', '/picture/0f09df75-8c5f-4ba2-89d8-aa441fa1b692.jpg', 12.00, '好吃好吃', 20, 6);

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `rider_id` int NOT NULL,
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `is_read` tinyint NULL DEFAULT 0,
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_rider_id`(`rider_id` ASC) USING BTREE,
  INDEX `idx_is_read`(`is_read` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE,
  CONSTRAINT `message_ibfk_1` FOREIGN KEY (`rider_id`) REFERENCES `rider` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 44 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES (10, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，请及时处理', 1, '2026-06-18 12:45:13');
INSERT INTO `message` VALUES (13, 6, 'system', '系统公告', '平台将于今晚22:00-23:00进行系统维护，请提前完成配送任务', 1, '2026-06-18 12:47:10');
INSERT INTO `message` VALUES (14, 6, 'income', '收入到账', '您今日配送收入已到账，共计35.00元', 1, '2026-06-18 12:47:10');
INSERT INTO `message` VALUES (19, 6, 'income', '收入到账', '您完成了一笔配送订单，配送收入：¥6.00已到账', 1, '2026-06-18 05:41:03');
INSERT INTO `message` VALUES (20, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥72.00，请及时处理', 0, '2026-06-18 06:13:27');
INSERT INTO `message` VALUES (21, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥72.00，请及时处理', 0, '2026-06-18 06:13:27');
INSERT INTO `message` VALUES (22, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥72.00，请及时处理', 0, '2026-06-18 06:13:27');
INSERT INTO `message` VALUES (23, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥72.00，请及时处理', 0, '2026-06-18 06:13:27');
INSERT INTO `message` VALUES (24, 6, 'system', '1111111（测试）', '11111111', 1, '2026-06-18 06:33:25');
INSERT INTO `message` VALUES (25, 1, 'system', '1111111（测试）', '11111111', 0, '2026-06-18 06:33:25');
INSERT INTO `message` VALUES (26, 2, 'system', '1111111（测试）', '11111111', 0, '2026-06-18 06:33:25');
INSERT INTO `message` VALUES (27, 3, 'system', '1111111（测试）', '11111111', 0, '2026-06-18 06:33:25');
INSERT INTO `message` VALUES (28, 23, 'system', '666（测试）', '66', 1, '2026-06-18 07:56:03');
INSERT INTO `message` VALUES (29, 6, 'system', '666（测试）', '66', 0, '2026-06-18 07:56:03');
INSERT INTO `message` VALUES (30, 1, 'system', '666（测试）', '66', 0, '2026-06-18 07:56:03');
INSERT INTO `message` VALUES (31, 2, 'system', '666（测试）', '66', 0, '2026-06-18 07:56:03');
INSERT INTO `message` VALUES (32, 3, 'system', '666（测试）', '66', 0, '2026-06-18 07:56:03');
INSERT INTO `message` VALUES (33, 1, 'order', '????', '????????', 0, '2026-06-18 11:10:47');
INSERT INTO `message` VALUES (34, 1, 'order', '订单已接单', '您已成功接单，订单号：51，请尽快前往商家取货', 0, '2026-06-18 11:11:58');
INSERT INTO `message` VALUES (35, 1, 'order', '开始取货', '您已到达商家并开始取货，订单号：51', 0, '2026-06-18 11:12:31');
INSERT INTO `message` VALUES (36, 1, 'income', '收入到账', '您完成了一笔配送订单，配送收入：¥5.00已到账', 0, '2026-06-18 11:12:42');
INSERT INTO `message` VALUES (37, 23, 'order', '开始取货', '您已到达商家并开始取货，订单号：55', 0, '2026-06-18 11:13:21');
INSERT INTO `message` VALUES (38, 23, 'income', '收入到账', '您完成了一笔配送订单，配送收入：¥5.00已到账', 0, '2026-06-18 11:13:26');
INSERT INTO `message` VALUES (39, 23, 'order', '订单已接单', '您已成功接单，订单号：49，请尽快前往商家取货', 0, '2026-06-18 11:14:09');
INSERT INTO `message` VALUES (40, 23, 'order', '订单已接单', '您已成功接单，订单号：48，请尽快前往商家取货', 0, '2026-06-18 11:14:40');
INSERT INTO `message` VALUES (41, 23, 'order', '订单已接单', '您已成功接单，订单号：47，请尽快前往商家取货', 0, '2026-06-18 11:15:21');
INSERT INTO `message` VALUES (42, 23, 'order', '开始取货', '您已到达商家并开始取货，订单号：49', 0, '2026-06-18 11:17:52');
INSERT INTO `message` VALUES (43, 23, 'income', '收入到账', '您完成了一笔配送订单，配送收入：¥5.00已到账', 0, '2026-06-18 11:17:55');

-- ----------------------------
-- Table structure for operation_log
-- ----------------------------
DROP TABLE IF EXISTS `operation_log`;
CREATE TABLE `operation_log`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `user_id` int NULL DEFAULT NULL COMMENT '用户ID（游客为0）',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `role` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色（管理员/用户/游客）',
  `operation` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '操作类型（LOGIN/LOGOUT/ADD/UPDATE/DELETE）',
  `module` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '操作模块',
  `detail` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '操作详情',
  `ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作IP',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_name`(`user_name` ASC) USING BTREE,
  INDEX `idx_operation`(`operation` ASC) USING BTREE,
  INDEX `idx_role`(`role` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 68 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '操作日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of operation_log
-- ----------------------------
INSERT INTO `operation_log` VALUES (1, 1, 'admin', '管理员', 'LOGIN', '用户登录', 'admin(管理员) 登录成功', '127.0.0.1', '2026-06-12 06:41:50');
INSERT INTO `operation_log` VALUES (2, 1, 'admin', '管理员', 'LOGIN', '用户登录', 'admin(管理员) 登录成功', '127.0.0.1', '2026-06-12 06:43:38');
INSERT INTO `operation_log` VALUES (6, 1, 'admin', '管理员', 'ADD', '分类管理', '添加分类: ????2', '127.0.0.1', '2026-06-12 06:56:23');
INSERT INTO `operation_log` VALUES (7, 1, 'admin', '管理员', 'DELETE', '分类管理', '删除分类 ID: 29', '127.0.0.1', '2026-06-12 06:56:58');
INSERT INTO `operation_log` VALUES (8, 1, 'admin', '管理员', 'UPDATE', '订单管理', '订单发货 ID: 49', '127.0.0.1', '2026-06-12 06:57:19');
INSERT INTO `operation_log` VALUES (9, 3, 'admin1', '用户', 'LOGIN', '用户登录', 'admin1(用户) 登录成功', '127.0.0.1', '2026-06-12 07:08:17');
INSERT INTO `operation_log` VALUES (10, 1, 'admin', '管理员', 'LOGIN', '用户登录', 'admin(管理员) 登录成功', '127.0.0.1', '2026-06-12 07:08:39');
INSERT INTO `operation_log` VALUES (11, 1, 'admin', '管理员', 'LOGIN', '用户登录', 'admin(管理员) 登录成功', '127.0.0.1', '2026-06-12 07:09:08');
INSERT INTO `operation_log` VALUES (12, 1, 'admin', '管理员', 'LOGOUT', '用户退出', 'admin(管理员) 退出登录', '127.0.0.1', '2026-06-12 07:12:17');
INSERT INTO `operation_log` VALUES (13, 1, 'admin', '管理员', 'DELETE', '分类管理', '删除分类 ID: 30', '127.0.0.1', '2026-06-12 07:41:24');
INSERT INTO `operation_log` VALUES (14, 1, 'admin', '管理员', 'LOGOUT', '用户退出', 'admin(管理员) 退出登录', '0:0:0:0:0:0:0:1', '2026-06-17 01:11:41');
INSERT INTO `operation_log` VALUES (15, 0, '', '用户', 'LOGOUT', '用户退出', '(用户) 退出登录', '0:0:0:0:0:0:0:1', '2026-06-17 01:11:43');
INSERT INTO `operation_log` VALUES (16, 0, '', '用户', 'LOGOUT', '用户退出', '(用户) 退出登录', '0:0:0:0:0:0:0:1', '2026-06-17 01:11:44');
INSERT INTO `operation_log` VALUES (17, 0, '', '用户', 'LOGOUT', '用户退出', '(用户) 退出登录', '0:0:0:0:0:0:0:1', '2026-06-17 01:11:44');
INSERT INTO `operation_log` VALUES (18, 0, '', '用户', 'LOGOUT', '用户退出', '(用户) 退出登录', '0:0:0:0:0:0:0:1', '2026-06-17 01:11:44');
INSERT INTO `operation_log` VALUES (19, 0, '', '用户', 'LOGOUT', '用户退出', '(用户) 退出登录', '0:0:0:0:0:0:0:1', '2026-06-17 01:11:45');
INSERT INTO `operation_log` VALUES (20, 0, '', '用户', 'LOGOUT', '用户退出', '(用户) 退出登录', '0:0:0:0:0:0:0:1', '2026-06-17 01:11:45');
INSERT INTO `operation_log` VALUES (21, 1, 'admin', '管理员', 'LOGIN', '用户登录', 'admin(管理员) 登录成功', '127.0.0.1', '2026-06-17 01:12:21');
INSERT INTO `operation_log` VALUES (22, 1, 'admin', '管理员', 'LOGOUT', '用户退出', 'admin(管理员) 退出登录', '0:0:0:0:0:0:0:1', '2026-06-17 01:13:28');
INSERT INTO `operation_log` VALUES (23, 0, '', '用户', 'LOGOUT', '用户退出', '(用户) 退出登录', '0:0:0:0:0:0:0:1', '2026-06-17 01:13:30');
INSERT INTO `operation_log` VALUES (24, 1, 'rider001', '骑手', 'LOGIN', '骑手登录', '张骑手(骑手) 登录成功', '127.0.0.1', '2026-06-17 01:22:09');
INSERT INTO `operation_log` VALUES (25, 1, 'admin', '管理员', 'UPDATE', '骑手管理', '骑手状态更新: 离线', '127.0.0.1', '2026-06-17 01:22:17');
INSERT INTO `operation_log` VALUES (26, 1, 'admin', '管理员', 'LOGIN', '用户登录', 'admin(管理员) 登录成功', '127.0.0.1', '2026-06-17 01:22:34');
INSERT INTO `operation_log` VALUES (27, 1, 'admin', '管理员', 'LOGOUT', '用户退出', 'admin(管理员) 退出登录', '0:0:0:0:0:0:0:1', '2026-06-17 02:12:09');
INSERT INTO `operation_log` VALUES (28, 0, '', '用户', 'LOGOUT', '用户退出', '(用户) 退出登录', '0:0:0:0:0:0:0:1', '2026-06-17 02:12:12');
INSERT INTO `operation_log` VALUES (29, 1, 'admin', '管理员', 'LOGIN', '用户登录', 'admin(管理员) 登录成功', '127.0.0.1', '2026-06-17 02:23:44');
INSERT INTO `operation_log` VALUES (30, 1, 'admin', '管理员', 'LOGOUT', '用户退出', 'admin(管理员) 退出登录', '0:0:0:0:0:0:0:1', '2026-06-17 02:32:04');
INSERT INTO `operation_log` VALUES (31, 0, '', '用户', 'LOGOUT', '用户退出', '(用户) 退出登录', '0:0:0:0:0:0:0:1', '2026-06-17 02:32:05');
INSERT INTO `operation_log` VALUES (32, 0, '', '用户', 'LOGOUT', '用户退出', '(用户) 退出登录', '0:0:0:0:0:0:0:1', '2026-06-17 02:50:15');
INSERT INTO `operation_log` VALUES (33, 1, 'admin', '管理员', 'LOGOUT', '用户退出', 'admin(管理员) 退出登录', '0:0:0:0:0:0:0:1', '2026-06-17 10:42:56');
INSERT INTO `operation_log` VALUES (34, 0, '', '用户', 'LOGOUT', '用户退出', '(用户) 退出登录', '0:0:0:0:0:0:0:1', '2026-06-17 10:42:57');
INSERT INTO `operation_log` VALUES (35, 1, 'admin', '管理员', 'LOGIN', '用户登录', 'admin(管理员) 登录成功', '127.0.0.1', '2026-06-17 11:09:55');
INSERT INTO `operation_log` VALUES (36, 1, 'admin', '管理员', 'UPDATE', '订单管理', '修改配送费 ID: 48, 金额: 5.0', '127.0.0.1', '2026-06-17 11:27:16');
INSERT INTO `operation_log` VALUES (37, 1, 'admin', '管理员', 'UPDATE', '订单管理', '修改配送费 ID: 50, 金额: 6.0', '127.0.0.1', '2026-06-17 11:27:24');
INSERT INTO `operation_log` VALUES (38, 1, 'admin', '管理员', 'UPDATE', '订单管理', '修改配送费 ID: 49, 金额: 5.0', '127.0.0.1', '2026-06-17 11:27:30');
INSERT INTO `operation_log` VALUES (39, 1, 'admin', '管理员', 'UPDATE', '订单管理', '修改配送费 ID: 46, 金额: 7.0', '127.0.0.1', '2026-06-17 11:27:39');
INSERT INTO `operation_log` VALUES (40, 1, 'admin', '管理员', 'UPDATE', '订单管理', '修改配送费 ID: 36, 金额: 3.0', '127.0.0.1', '2026-06-17 11:27:45');
INSERT INTO `operation_log` VALUES (41, 1, 'admin', '管理员', 'UPDATE', '订单管理', '修改配送费 ID: 34, 金额: 6.0', '127.0.0.1', '2026-06-17 11:27:51');
INSERT INTO `operation_log` VALUES (42, 1, 'admin', '管理员', 'UPDATE', '订单管理', '修改配送费 ID: 52, 金额: 5.0', '127.0.0.1', '2026-06-17 11:46:09');
INSERT INTO `operation_log` VALUES (43, 1, 'admin', '管理员', 'UPDATE', '系统配置', '更新默认配送费: 6.0元', '127.0.0.1', '2026-06-17 12:36:12');
INSERT INTO `operation_log` VALUES (44, 1, 'admin', '管理员', 'UPDATE', '系统配置', '更新默认配送费: 5.0元', '127.0.0.1', '2026-06-17 12:37:53');
INSERT INTO `operation_log` VALUES (45, 1, 'admin', '管理员', 'LOGOUT', '用户退出', 'admin(管理员) 退出登录', '0:0:0:0:0:0:0:1', '2026-06-17 14:19:01');
INSERT INTO `operation_log` VALUES (46, 0, '', '用户', 'LOGOUT', '用户退出', '(用户) 退出登录', '0:0:0:0:0:0:0:1', '2026-06-17 14:19:04');
INSERT INTO `operation_log` VALUES (47, 1, 'admin', '管理员', 'LOGIN', '用户登录', 'admin(管理员) 登录成功', '127.0.0.1', '2026-06-17 15:28:53');
INSERT INTO `operation_log` VALUES (48, 1, 'admin', '管理员', 'UPDATE', '订单管理', '修改订单 ID: 8, 状态: 0', '127.0.0.1', '2026-06-17 15:29:27');
INSERT INTO `operation_log` VALUES (49, 1, 'admin', '管理员', 'LOGOUT', '用户退出', 'admin(管理员) 退出登录', '0:0:0:0:0:0:0:1', '2026-06-18 02:41:25');
INSERT INTO `operation_log` VALUES (50, 0, '', '用户', 'LOGOUT', '用户退出', '(用户) 退出登录', '0:0:0:0:0:0:0:1', '2026-06-18 02:41:28');
INSERT INTO `operation_log` VALUES (51, 0, '', '用户', 'LOGOUT', '用户退出', '(用户) 退出登录', '0:0:0:0:0:0:0:1', '2026-06-18 02:41:29');
INSERT INTO `operation_log` VALUES (52, 0, '', '用户', 'LOGOUT', '用户退出', '(用户) 退出登录', '0:0:0:0:0:0:0:1', '2026-06-18 02:41:29');
INSERT INTO `operation_log` VALUES (53, 0, '', '用户', 'LOGOUT', '用户退出', '(用户) 退出登录', '0:0:0:0:0:0:0:1', '2026-06-18 02:41:30');
INSERT INTO `operation_log` VALUES (54, 0, '', '用户', 'LOGOUT', '用户退出', '(用户) 退出登录', '0:0:0:0:0:0:0:1', '2026-06-18 02:41:30');
INSERT INTO `operation_log` VALUES (55, 1, 'admin', '管理员', 'LOGIN', '用户登录', 'admin(管理员) 登录成功', '127.0.0.1', '2026-06-18 05:47:33');
INSERT INTO `operation_log` VALUES (56, 1, 'admin', '管理员', 'LOGOUT', '用户退出', 'admin(管理员) 退出登录', '0:0:0:0:0:0:0:1', '2026-06-18 06:35:58');
INSERT INTO `operation_log` VALUES (57, 0, '', '用户', 'LOGOUT', '用户退出', '(用户) 退出登录', '0:0:0:0:0:0:0:1', '2026-06-18 06:35:59');
INSERT INTO `operation_log` VALUES (58, 1, 'admin', '管理员', 'LOGIN', '用户登录', 'admin(管理员) 登录成功', '127.0.0.1', '2026-06-18 07:45:34');
INSERT INTO `operation_log` VALUES (59, 1, 'admin', '管理员', 'LOGOUT', '用户退出', 'admin(管理员) 退出登录', '0:0:0:0:0:0:0:1', '2026-06-18 11:03:31');
INSERT INTO `operation_log` VALUES (60, 0, '', '用户', 'LOGOUT', '用户退出', '(用户) 退出登录', '0:0:0:0:0:0:0:1', '2026-06-18 11:03:32');
INSERT INTO `operation_log` VALUES (61, 0, '', '用户', 'LOGOUT', '用户退出', '(用户) 退出登录', '0:0:0:0:0:0:0:1', '2026-06-18 11:03:34');
INSERT INTO `operation_log` VALUES (62, 0, '', '用户', 'LOGOUT', '用户退出', '(用户) 退出登录', '0:0:0:0:0:0:0:1', '2026-06-18 11:03:35');
INSERT INTO `operation_log` VALUES (63, 0, '', '用户', 'LOGOUT', '用户退出', '(用户) 退出登录', '0:0:0:0:0:0:0:1', '2026-06-18 14:02:37');
INSERT INTO `operation_log` VALUES (64, 0, '', '用户', 'LOGOUT', '用户退出', '(用户) 退出登录', '0:0:0:0:0:0:0:1', '2026-06-18 14:02:38');
INSERT INTO `operation_log` VALUES (65, 0, '', '用户', 'LOGOUT', '用户退出', '(用户) 退出登录', '0:0:0:0:0:0:0:1', '2026-06-18 14:02:38');
INSERT INTO `operation_log` VALUES (66, 0, '', '用户', 'LOGOUT', '用户退出', '(用户) 退出登录', '0:0:0:0:0:0:0:1', '2026-06-18 15:47:15');
INSERT INTO `operation_log` VALUES (67, 0, '', '用户', 'LOGOUT', '用户退出', '(用户) 退出登录', '0:0:0:0:0:0:0:1', '2026-06-18 15:50:48');

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `total` float(10, 2) NULL DEFAULT NULL COMMENT '商品总额',
  `amount` int NULL DEFAULT NULL COMMENT '商品数量',
  `status` tinyint(1) NULL DEFAULT NULL COMMENT '订单状态（0已付款，1已发货，2已完成，3 已送达、4 已取消）',
  `paytype` tinyint(1) NULL DEFAULT NULL COMMENT '支付方式（0微信，1支付宝，2银行卡）',
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名字',
  `phone` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '收货人电话',
  `address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '收获人地址',
  `datetime` datetime NULL DEFAULT NULL COMMENT '订单日期',
  `user_id` int NULL DEFAULT NULL COMMENT '用户id',
  `rider_id` int NULL DEFAULT NULL,
  `rider_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `rider_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `delivery_fee` decimal(10, 2) NULL DEFAULT 0.00,
  `accept_time` datetime NULL DEFAULT NULL,
  `delivery_time` datetime NULL DEFAULT NULL,
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 56 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES (8, 337.00, 2, 0, 2, '张三', '13800000000', '上海市浦东新区', '2025-12-19 19:07:45', 3, 1, 'Rider Zhang', '13800138001', 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (9, 337.00, 2, 0, 2, '张三', '13800000000', '上海市浦东新区', '2025-12-19 19:08:19', 3, 2, 'Rider Li', '13800138002', 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (13, 337.00, 2, 0, 2, '张三', '13800000000', '上海市浦东新区', '2025-12-19 19:11:25', 3, 2, 'Rider Li', '13800138002', 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (18, 634.00, 3, 0, 2, '管理员', '1333333333', '中国北京市', '2025-12-20 00:51:20', 1, 1, 'Rider Zhang', '13800138001', 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (19, 1198.00, 18, 0, 2, '管理员', '1333333333', '中国北京市', '2025-12-20 00:52:12', 1, NULL, NULL, NULL, 8.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (20, 299.00, 1, 0, 2, '张三', '13800000000', '上海市浦东新区', '2026-01-05 10:24:50', 3, 1, 'Rider Zhang', '13800138001', 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (21, 64.00, 2, 0, 2, '张三', '13800000000', '上海市浦东新区', '2026-01-07 21:24:17', 3, 1, 'Rider Zhang', '13800138001', 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (22, 299.00, 1, 0, 2, '管理员', '1333333333', '中国北京市', '2026-01-08 19:28:34', 1, NULL, NULL, NULL, 6.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (24, 609.00, 3, 0, 2, '管理员', '1333333333', '中国北京市', '2026-01-10 16:03:58', 1, 2, 'Rider Li', '13800138002', 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (27, 781.00, 4, 0, 1, '水滴', '66666666', '发是发是发发发发发', '2026-01-11 16:41:50', 1, 2, 'Rider Li', '13800138002', 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (28, 327.00, 2, 0, 1, '普通用户', '1344444444', '中国福建省', '2026-01-15 10:33:20', 2, NULL, NULL, NULL, 0.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (29, 337.00, 2, 0, 0, '普通用户', '1344444444', '中国福建省', '2026-01-15 10:37:14', 2, NULL, NULL, NULL, 0.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (33, 66.00, 2, 0, 1, '管理员1', '13355', '中国北京市', '2026-01-16 15:04:33', 1, NULL, NULL, NULL, 0.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (34, 337.00, 2, 0, 2, '张三', '13800000000', '上海市浦东新区', '2026-01-16 15:21:36', 3, 6, 'df', '15681264852', 6.00, '2026-06-17 19:01:22', NULL, NULL);
INSERT INTO `order` VALUES (36, 327.00, 2, 2, 0, '管理员', '1333333388', '中国北京市11', '2026-01-16 18:10:53', 1, 23, 'zs1', '156841469', 3.00, '2026-06-18 19:03:52', NULL, NULL);
INSERT INTO `order` VALUES (46, 10.00, 2, 0, 1, '管理员', '1333333388', '中国北京市', '2026-05-27 11:18:14', 1, NULL, NULL, NULL, 7.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (47, 84.00, 6, 1, 1, '张三', '13800000001', '上海市浦东新区1', '2026-05-29 14:26:12', 3, 23, 'zs1', '156841469', 5.00, '2026-06-18 19:15:20', '2026-06-17 19:01:31', NULL);
INSERT INTO `order` VALUES (48, 565.00, 1, 1, 1, '管理员', '1333333388', '中国北京市', '2026-06-03 08:38:08', 1, 23, 'zs1', '156841469', 5.00, '2026-06-18 19:14:40', NULL, NULL);
INSERT INTO `order` VALUES (49, 565.00, 1, 3, 1, '管理员', '1333333388', '中国北京市', '2026-06-10 10:10:13', 1, 23, 'zs1', '156841469', 5.00, '2026-06-18 19:14:08', '2026-06-18 19:17:54', NULL);
INSERT INTO `order` VALUES (50, 16.00, 1, 3, 1, '管理员', '1333333388', '中国北京市', '2026-06-12 15:40:31', 1, 6, 'df', '15681264852', 6.00, '2026-06-18 11:15:11', '2026-06-18 13:41:02', NULL);
INSERT INTO `order` VALUES (51, 48.00, 2, 3, 0, '管理员', '1333333388', '中国北京市', '2026-06-12 15:41:36', 1, 1, 'Rider Zhang', '13800138001', 5.00, '2026-06-18 19:11:58', '2026-06-18 19:12:42', NULL);
INSERT INTO `order` VALUES (52, 24.00, 1, 1, 1, '管理员', '1333333388', '中国北京市', '2026-06-17 19:28:15', 1, 6, 'df', '15681264852', 5.00, '2026-06-18 11:15:03', NULL, NULL);
INSERT INTO `order` VALUES (53, 16.00, 1, 1, 2, '管理员', '1333333388', '中国北京市', '2026-06-17 19:46:26', 1, 6, 'df', '15681264852', 5.00, '2026-06-18 12:35:14', NULL, NULL);
INSERT INTO `order` VALUES (54, 16.00, 1, 3, 1, '管理员', '1333333388', '中国北京市', '2026-06-17 20:36:24', 1, 6, 'df', '15681264852', 6.00, '2026-06-18 11:14:58', '2026-06-18 11:15:17', NULL);
INSERT INTO `order` VALUES (55, 72.00, 2, 3, 1, '管理员', '1333333388', '中国北京市', '2026-06-18 14:13:27', 1, 23, 'zs1', '156841469', 5.00, '2026-06-18 19:09:07', '2026-06-18 19:13:25', NULL);

-- ----------------------------
-- Table structure for orderitem
-- ----------------------------
DROP TABLE IF EXISTS `orderitem`;
CREATE TABLE `orderitem`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '订单项id',
  `price` float(10, 2) NULL DEFAULT NULL COMMENT '商品价格',
  `amount` int NULL DEFAULT NULL COMMENT '商品数量',
  `goods_id` int NULL DEFAULT NULL COMMENT '商品id',
  `order_id` int NULL DEFAULT NULL COMMENT '订单id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 63 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orderitem
-- ----------------------------
INSERT INTO `orderitem` VALUES (1, 299.00, 1, 1, 1);
INSERT INTO `orderitem` VALUES (2, 28.00, 1, 2, 1);
INSERT INTO `orderitem` VALUES (3, 299.00, 1, 7, 8);
INSERT INTO `orderitem` VALUES (4, 38.00, 1, 3, 8);
INSERT INTO `orderitem` VALUES (5, 299.00, 1, 7, 9);
INSERT INTO `orderitem` VALUES (6, 38.00, 1, 3, 9);
INSERT INTO `orderitem` VALUES (7, 299.00, 1, 7, 13);
INSERT INTO `orderitem` VALUES (8, 38.00, 1, 3, 13);
INSERT INTO `orderitem` VALUES (9, 299.00, 2, 1, 18);
INSERT INTO `orderitem` VALUES (10, 36.00, 1, 4, 18);
INSERT INTO `orderitem` VALUES (11, 299.00, 2, 1, 19);
INSERT INTO `orderitem` VALUES (12, 36.00, 8, 5, 19);
INSERT INTO `orderitem` VALUES (13, 39.00, 8, 6, 19);
INSERT INTO `orderitem` VALUES (14, 299.00, 1, 1, 20);
INSERT INTO `orderitem` VALUES (15, 36.00, 1, 4, 21);
INSERT INTO `orderitem` VALUES (16, 28.00, 1, 2, 21);
INSERT INTO `orderitem` VALUES (17, 299.00, 1, 1, 22);
INSERT INTO `orderitem` VALUES (20, 155.00, 2, 9, 24);
INSERT INTO `orderitem` VALUES (21, 299.00, 1, 1, 24);
INSERT INTO `orderitem` VALUES (22, 28.00, 1, 2, 25);
INSERT INTO `orderitem` VALUES (23, 36.00, 1, 4, 25);
INSERT INTO `orderitem` VALUES (24, 28.00, 2, 2, 26);
INSERT INTO `orderitem` VALUES (25, 36.00, 3, 4, 26);
INSERT INTO `orderitem` VALUES (26, 299.00, 2, 1, 27);
INSERT INTO `orderitem` VALUES (27, 28.00, 1, 2, 27);
INSERT INTO `orderitem` VALUES (28, 155.00, 1, 9, 27);
INSERT INTO `orderitem` VALUES (29, 28.00, 1, 2, 28);
INSERT INTO `orderitem` VALUES (30, 299.00, 1, 1, 28);
INSERT INTO `orderitem` VALUES (31, 299.00, 1, 1, 29);
INSERT INTO `orderitem` VALUES (32, 38.00, 1, 3, 29);
INSERT INTO `orderitem` VALUES (33, 299.00, 1, 1, 30);
INSERT INTO `orderitem` VALUES (34, 38.00, 1, 3, 30);
INSERT INTO `orderitem` VALUES (35, 36.00, 5, 5, 31);
INSERT INTO `orderitem` VALUES (36, 39.00, 6, 6, 31);
INSERT INTO `orderitem` VALUES (37, 28.00, 1, 2, 32);
INSERT INTO `orderitem` VALUES (38, 36.00, 2, 5, 32);
INSERT INTO `orderitem` VALUES (39, 39.00, 1, 6, 32);
INSERT INTO `orderitem` VALUES (40, 28.00, 1, 2, 33);
INSERT INTO `orderitem` VALUES (41, 38.00, 1, 3, 33);
INSERT INTO `orderitem` VALUES (42, 299.00, 1, 7, 34);
INSERT INTO `orderitem` VALUES (43, 38.00, 1, 3, 34);
INSERT INTO `orderitem` VALUES (44, 299.00, 1, 1, 35);
INSERT INTO `orderitem` VALUES (45, 26.00, 2, 12, 35);
INSERT INTO `orderitem` VALUES (46, 56.00, 2, 18, 35);
INSERT INTO `orderitem` VALUES (47, 28.00, 1, 2, 36);
INSERT INTO `orderitem` VALUES (48, 299.00, 1, 7, 36);
INSERT INTO `orderitem` VALUES (52, 565.00, 1, 26, 45);
INSERT INTO `orderitem` VALUES (53, 5.00, 2, 23, 46);
INSERT INTO `orderitem` VALUES (54, 14.00, 6, 24, 47);
INSERT INTO `orderitem` VALUES (55, 565.00, 1, 26, 48);
INSERT INTO `orderitem` VALUES (56, 565.00, 1, 26, 49);
INSERT INTO `orderitem` VALUES (57, 16.00, 1, 19, 50);
INSERT INTO `orderitem` VALUES (58, 24.00, 2, 21, 51);
INSERT INTO `orderitem` VALUES (59, 24.00, 1, 21, 52);
INSERT INTO `orderitem` VALUES (60, 16.00, 1, 20, 53);
INSERT INTO `orderitem` VALUES (61, 16.00, 1, 19, 54);
INSERT INTO `orderitem` VALUES (62, 36.00, 2, 14, 55);

-- ----------------------------
-- Table structure for recommend
-- ----------------------------
DROP TABLE IF EXISTS `recommend`;
CREATE TABLE `recommend`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '推荐栏id',
  `type` tinyint(1) NULL DEFAULT NULL COMMENT '商品类型(0横条，1热销，2新品)',
  `good_id` int NULL DEFAULT NULL COMMENT '商品id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of recommend
-- ----------------------------
INSERT INTO `recommend` VALUES (1, 1, 2);
INSERT INTO `recommend` VALUES (2, 1, 4);
INSERT INTO `recommend` VALUES (3, 2, 3);
INSERT INTO `recommend` VALUES (4, 2, 1);
INSERT INTO `recommend` VALUES (7, 0, 1);
INSERT INTO `recommend` VALUES (10, 0, 5);
INSERT INTO `recommend` VALUES (13, 1, 9);
INSERT INTO `recommend` VALUES (15, 1, 22);
INSERT INTO `recommend` VALUES (23, 1, 26);
INSERT INTO `recommend` VALUES (26, 0, 7);

-- ----------------------------
-- Table structure for rider
-- ----------------------------
DROP TABLE IF EXISTS `rider`;
CREATE TABLE `rider`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '骑手ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '登录账号',
  `pass_word` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '登录密码（加密）',
  `real_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '真实姓名',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系电话',
  `work_no` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '工号',
  `status` int NULL DEFAULT 0 COMMENT '在线状态：0-离线，1-在线',
  `area` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '常驻配送区域',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像URL',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user_name`(`user_name` ASC) USING BTREE,
  UNIQUE INDEX `phone`(`phone` ASC) USING BTREE,
  UNIQUE INDEX `work_no`(`work_no` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_area`(`area` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '骑手表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rider
-- ----------------------------
INSERT INTO `rider` VALUES (1, 'rider001', '123456', 'Rider Zhang', '13800138001', 'R001', 1, NULL, NULL, '2026-06-17 09:50:35', NULL);
INSERT INTO `rider` VALUES (2, 'rider002', '123456', 'Rider Li', '13800138002', 'R002', 0, '', NULL, '2026-06-17 09:50:35', '2026-06-17 10:30:50');
INSERT INTO `rider` VALUES (3, 'rider003', '123456', 'Rider Wang', '13800138003', 'R003', 1, NULL, NULL, '2026-06-17 09:50:35', '2026-06-17 10:37:50');
INSERT INTO `rider` VALUES (6, 'rider004', '654321', 'df', '15681264852', '', 1, '', NULL, '2026-06-17 10:31:54', '2026-06-18 14:35:40');
INSERT INTO `rider` VALUES (23, 'zs', '123456', 'zs', '156841469', NULL, 1, '', NULL, '2026-06-18 15:44:46', '2026-06-18 23:34:00');

-- ----------------------------
-- Table structure for system_config
-- ----------------------------
DROP TABLE IF EXISTS `system_config`;
CREATE TABLE `system_config`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '配置键',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '配置值',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '配置名称',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '配置描述',
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `config_key`(`config_key` ASC) USING BTREE,
  INDEX `idx_config_key`(`config_key` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_config
-- ----------------------------
INSERT INTO `system_config` VALUES (1, 'default_delivery_fee', '5.0', '默认配送费', '新订单的默认配送费金额（元）', '2026-06-17 19:53:51', '2026-06-17 20:37:53');
INSERT INTO `system_config` VALUES (2, 'stock_warning_threshold', '10', '库存预警阈值', '库存低于此数量时触发预警', '2026-06-17 19:55:06', '2026-06-17 19:55:06');

-- ----------------------------
-- Table structure for type
-- ----------------------------
DROP TABLE IF EXISTS `type`;
CREATE TABLE `type`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '商品id',
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '商品名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of type
-- ----------------------------
INSERT INTO `type` VALUES (1, '冰淇淋系列');
INSERT INTO `type` VALUES (2, '零食系列');
INSERT INTO `type` VALUES (3, '儿童系列');
INSERT INTO `type` VALUES (4, '正式系列');
INSERT INTO `type` VALUES (5, '饮料系列');
INSERT INTO `type` VALUES (6, '甜点系列');
INSERT INTO `type` VALUES (7, '其他系列');
INSERT INTO `type` VALUES (10, '平价系类');
INSERT INTO `type` VALUES (25, '111');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `username` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `password` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户密码',
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名字',
  `email` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户邮箱',
  `phone` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户电话',
  `address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户地址',
  `isadmin` bit(1) NOT NULL COMMENT '是否为管理员（1是，0不是）',
  `isvalidate` bit(1) NOT NULL COMMENT '账号是否有效（0有效，1无效）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', '123456', '管理员', 'admin@vilicode.com', '1333333388', '中国北京市', b'1', b'0');
INSERT INTO `user` VALUES (2, 'vili', '654321', '普通用户', 'vili@vilicode.com', '1344444444', '中国福建省', b'1', b'0');
INSERT INTO `user` VALUES (3, 'admin1', '123456', '张三', '1214325@qq.com', '13800000000', '上海市浦东新区', b'0', b'0');
INSERT INTO `user` VALUES (9, '325346', '123456', '普通用户', 'vili@vilicode.com', '1344444444', '中国福建省', b'0', b'0');

SET FOREIGN_KEY_CHECKS = 1;
