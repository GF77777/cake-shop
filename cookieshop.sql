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

 Date: 23/06/2026 10:55:33
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
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

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
INSERT INTO `delivery_record` VALUES (18, 157, 1, 3, '2026-06-23 10:15:38', NULL);
INSERT INTO `delivery_record` VALUES (19, 154, 1, 1, '2026-06-23 10:37:59', NULL);

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
INSERT INTO `goods` VALUES (1, '草莓冰淇淋', '/picture/9-1.jpg', '/picture/9-2.jpg', '/picture/9-3.jpg', 299.00, '采用草莓冰淇淋最受欢迎的口感配方,搭配绵密顺滑的奶浆,加入新鲜草莓果肉,制成冰淇淋,香甜可口,风味独特.\n口味:草莓冰淇淋味 主要原料:草莓,牛奶,奶油,糖\n储存温度：-12℃~-15℃冷冻', 5, 1);
INSERT INTO `goods` VALUES (2, '芒果布丁杯', '/picture/10-1.jpg', '/picture/10-2.jpg', '/picture/10-3.jpg', 28.00, '精选优质布丁师,口感浓郁,质地细腻,入口即化.布丁师精心调配比例,带来平滑柔顺的口感,呈现多层次的味觉享受.', 5, 2);
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
) ENGINE = InnoDB AUTO_INCREMENT = 4145 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

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
INSERT INTO `message` VALUES (34, 1, 'order', '订单已接单', '您已成功接单，订单号：51，请尽快前往商家取货', 0, '2026-06-18 11:11:58');
INSERT INTO `message` VALUES (35, 1, 'order', '开始取货', '您已到达商家并开始取货，订单号：51', 0, '2026-06-18 11:12:31');
INSERT INTO `message` VALUES (36, 1, 'income', '收入到账', '您完成了一笔配送订单，配送收入：¥5.00已到账', 1, '2026-06-18 11:12:42');
INSERT INTO `message` VALUES (37, 23, 'order', '开始取货', '您已到达商家并开始取货，订单号：55', 0, '2026-06-18 11:13:21');
INSERT INTO `message` VALUES (38, 23, 'income', '收入到账', '您完成了一笔配送订单，配送收入：¥5.00已到账', 0, '2026-06-18 11:13:26');
INSERT INTO `message` VALUES (39, 23, 'order', '订单已接单', '您已成功接单，订单号：49，请尽快前往商家取货', 0, '2026-06-18 11:14:09');
INSERT INTO `message` VALUES (40, 23, 'order', '订单已接单', '您已成功接单，订单号：48，请尽快前往商家取货', 0, '2026-06-18 11:14:40');
INSERT INTO `message` VALUES (41, 23, 'order', '订单已接单', '您已成功接单，订单号：47，请尽快前往商家取货', 0, '2026-06-18 11:15:21');
INSERT INTO `message` VALUES (42, 23, 'order', '开始取货', '您已到达商家并开始取货，订单号：49', 0, '2026-06-18 11:17:52');
INSERT INTO `message` VALUES (43, 23, 'income', '收入到账', '您完成了一笔配送订单，配送收入：¥5.00已到账', 0, '2026-06-18 11:17:55');
INSERT INTO `message` VALUES (44, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:18:21');
INSERT INTO `message` VALUES (45, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:18:21');
INSERT INTO `message` VALUES (46, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:18:21');
INSERT INTO `message` VALUES (47, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:18:21');
INSERT INTO `message` VALUES (48, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:18:21');
INSERT INTO `message` VALUES (49, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:18:21');
INSERT INTO `message` VALUES (50, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:18:21');
INSERT INTO `message` VALUES (51, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:18:21');
INSERT INTO `message` VALUES (52, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:18:21');
INSERT INTO `message` VALUES (53, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:18:21');
INSERT INTO `message` VALUES (54, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:18:52');
INSERT INTO `message` VALUES (55, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:18:52');
INSERT INTO `message` VALUES (56, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:18:52');
INSERT INTO `message` VALUES (57, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:18:52');
INSERT INTO `message` VALUES (58, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:18:52');
INSERT INTO `message` VALUES (59, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:18:52');
INSERT INTO `message` VALUES (60, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:18:52');
INSERT INTO `message` VALUES (61, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:18:52');
INSERT INTO `message` VALUES (62, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:18:52');
INSERT INTO `message` VALUES (63, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:18:52');
INSERT INTO `message` VALUES (64, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:19:03');
INSERT INTO `message` VALUES (65, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:19:03');
INSERT INTO `message` VALUES (66, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:19:03');
INSERT INTO `message` VALUES (67, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:19:03');
INSERT INTO `message` VALUES (68, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:19:03');
INSERT INTO `message` VALUES (69, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:19:03');
INSERT INTO `message` VALUES (70, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:19:03');
INSERT INTO `message` VALUES (71, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:19:03');
INSERT INTO `message` VALUES (72, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:19:03');
INSERT INTO `message` VALUES (73, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:19:03');
INSERT INTO `message` VALUES (74, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:20:59');
INSERT INTO `message` VALUES (75, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:20:59');
INSERT INTO `message` VALUES (76, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:20:59');
INSERT INTO `message` VALUES (77, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:20:59');
INSERT INTO `message` VALUES (78, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:20:59');
INSERT INTO `message` VALUES (79, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:20:59');
INSERT INTO `message` VALUES (80, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:20:59');
INSERT INTO `message` VALUES (81, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:20:59');
INSERT INTO `message` VALUES (82, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:20:59');
INSERT INTO `message` VALUES (83, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:20:59');
INSERT INTO `message` VALUES (85, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:24:04');
INSERT INTO `message` VALUES (86, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:24:04');
INSERT INTO `message` VALUES (87, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:24:04');
INSERT INTO `message` VALUES (88, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:24:04');
INSERT INTO `message` VALUES (89, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:24:04');
INSERT INTO `message` VALUES (91, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:24:04');
INSERT INTO `message` VALUES (92, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:24:04');
INSERT INTO `message` VALUES (93, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:24:04');
INSERT INTO `message` VALUES (94, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:24:04');
INSERT INTO `message` VALUES (95, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:24:04');
INSERT INTO `message` VALUES (131, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:29:08');
INSERT INTO `message` VALUES (132, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:29:08');
INSERT INTO `message` VALUES (133, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:29:08');
INSERT INTO `message` VALUES (134, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:29:08');
INSERT INTO `message` VALUES (135, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:29:08');
INSERT INTO `message` VALUES (141, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 01:29:08');
INSERT INTO `message` VALUES (142, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 01:29:08');
INSERT INTO `message` VALUES (143, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 01:29:08');
INSERT INTO `message` VALUES (144, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 01:29:08');
INSERT INTO `message` VALUES (145, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 01:29:08');
INSERT INTO `message` VALUES (151, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 01:29:08');
INSERT INTO `message` VALUES (152, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 01:29:08');
INSERT INTO `message` VALUES (153, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 01:29:08');
INSERT INTO `message` VALUES (154, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 01:29:08');
INSERT INTO `message` VALUES (155, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 01:29:08');
INSERT INTO `message` VALUES (161, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 01:29:08');
INSERT INTO `message` VALUES (162, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 01:29:08');
INSERT INTO `message` VALUES (163, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 01:29:08');
INSERT INTO `message` VALUES (164, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 01:29:08');
INSERT INTO `message` VALUES (165, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 01:29:08');
INSERT INTO `message` VALUES (171, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:29:08');
INSERT INTO `message` VALUES (172, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:29:08');
INSERT INTO `message` VALUES (173, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:29:08');
INSERT INTO `message` VALUES (174, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:29:08');
INSERT INTO `message` VALUES (175, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:29:08');
INSERT INTO `message` VALUES (181, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:31:12');
INSERT INTO `message` VALUES (182, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:31:12');
INSERT INTO `message` VALUES (183, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:31:12');
INSERT INTO `message` VALUES (184, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:31:12');
INSERT INTO `message` VALUES (185, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:31:12');
INSERT INTO `message` VALUES (191, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:31:54');
INSERT INTO `message` VALUES (192, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:31:54');
INSERT INTO `message` VALUES (193, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:31:54');
INSERT INTO `message` VALUES (194, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:31:54');
INSERT INTO `message` VALUES (195, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:31:54');
INSERT INTO `message` VALUES (201, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 01:31:55');
INSERT INTO `message` VALUES (202, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 01:31:55');
INSERT INTO `message` VALUES (203, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 01:31:55');
INSERT INTO `message` VALUES (204, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 01:31:55');
INSERT INTO `message` VALUES (205, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 01:31:55');
INSERT INTO `message` VALUES (211, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 01:31:55');
INSERT INTO `message` VALUES (212, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 01:31:55');
INSERT INTO `message` VALUES (213, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 01:31:55');
INSERT INTO `message` VALUES (214, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 01:31:55');
INSERT INTO `message` VALUES (215, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 01:31:55');
INSERT INTO `message` VALUES (221, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 01:31:55');
INSERT INTO `message` VALUES (222, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 01:31:55');
INSERT INTO `message` VALUES (223, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 01:31:55');
INSERT INTO `message` VALUES (224, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 01:31:55');
INSERT INTO `message` VALUES (225, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 01:31:55');
INSERT INTO `message` VALUES (231, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:31:55');
INSERT INTO `message` VALUES (232, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:31:55');
INSERT INTO `message` VALUES (233, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:31:55');
INSERT INTO `message` VALUES (234, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:31:55');
INSERT INTO `message` VALUES (235, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:31:55');
INSERT INTO `message` VALUES (241, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 01:33:50');
INSERT INTO `message` VALUES (242, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 01:33:50');
INSERT INTO `message` VALUES (243, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 01:33:50');
INSERT INTO `message` VALUES (244, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 01:33:50');
INSERT INTO `message` VALUES (245, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 01:33:50');
INSERT INTO `message` VALUES (251, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 01:35:35');
INSERT INTO `message` VALUES (252, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 01:35:35');
INSERT INTO `message` VALUES (253, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 01:35:35');
INSERT INTO `message` VALUES (254, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 01:35:35');
INSERT INTO `message` VALUES (255, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 01:35:35');
INSERT INTO `message` VALUES (261, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:35:48');
INSERT INTO `message` VALUES (262, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:35:48');
INSERT INTO `message` VALUES (263, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:35:48');
INSERT INTO `message` VALUES (264, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:35:48');
INSERT INTO `message` VALUES (265, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:35:48');
INSERT INTO `message` VALUES (271, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 01:35:48');
INSERT INTO `message` VALUES (272, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 01:35:48');
INSERT INTO `message` VALUES (273, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 01:35:48');
INSERT INTO `message` VALUES (274, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 01:35:48');
INSERT INTO `message` VALUES (275, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 01:35:48');
INSERT INTO `message` VALUES (281, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 01:35:48');
INSERT INTO `message` VALUES (282, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 01:35:48');
INSERT INTO `message` VALUES (283, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 01:35:48');
INSERT INTO `message` VALUES (284, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 01:35:48');
INSERT INTO `message` VALUES (285, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 01:35:48');
INSERT INTO `message` VALUES (291, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 01:35:48');
INSERT INTO `message` VALUES (292, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 01:35:48');
INSERT INTO `message` VALUES (293, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 01:35:48');
INSERT INTO `message` VALUES (294, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 01:35:48');
INSERT INTO `message` VALUES (295, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 01:35:48');
INSERT INTO `message` VALUES (301, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:35:49');
INSERT INTO `message` VALUES (302, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:35:49');
INSERT INTO `message` VALUES (303, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:35:49');
INSERT INTO `message` VALUES (304, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:35:49');
INSERT INTO `message` VALUES (305, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:35:49');
INSERT INTO `message` VALUES (315, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:36:01');
INSERT INTO `message` VALUES (316, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:36:01');
INSERT INTO `message` VALUES (317, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:36:01');
INSERT INTO `message` VALUES (318, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:36:01');
INSERT INTO `message` VALUES (319, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:36:01');
INSERT INTO `message` VALUES (329, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 01:36:01');
INSERT INTO `message` VALUES (330, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 01:36:01');
INSERT INTO `message` VALUES (331, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 01:36:01');
INSERT INTO `message` VALUES (332, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 01:36:01');
INSERT INTO `message` VALUES (333, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 01:36:01');
INSERT INTO `message` VALUES (343, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 01:36:02');
INSERT INTO `message` VALUES (344, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 01:36:02');
INSERT INTO `message` VALUES (345, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 01:36:02');
INSERT INTO `message` VALUES (346, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 01:36:02');
INSERT INTO `message` VALUES (347, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 01:36:02');
INSERT INTO `message` VALUES (357, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 01:36:02');
INSERT INTO `message` VALUES (358, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 01:36:02');
INSERT INTO `message` VALUES (359, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 01:36:02');
INSERT INTO `message` VALUES (360, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 01:36:02');
INSERT INTO `message` VALUES (361, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 01:36:02');
INSERT INTO `message` VALUES (371, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:36:02');
INSERT INTO `message` VALUES (372, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:36:02');
INSERT INTO `message` VALUES (373, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:36:02');
INSERT INTO `message` VALUES (374, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:36:02');
INSERT INTO `message` VALUES (375, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:36:02');
INSERT INTO `message` VALUES (390, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:37:07');
INSERT INTO `message` VALUES (391, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:37:07');
INSERT INTO `message` VALUES (392, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:37:07');
INSERT INTO `message` VALUES (393, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:37:07');
INSERT INTO `message` VALUES (394, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 01:37:07');
INSERT INTO `message` VALUES (409, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 01:37:07');
INSERT INTO `message` VALUES (410, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 01:37:07');
INSERT INTO `message` VALUES (411, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 01:37:07');
INSERT INTO `message` VALUES (412, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 01:37:07');
INSERT INTO `message` VALUES (413, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 01:37:07');
INSERT INTO `message` VALUES (428, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 01:37:07');
INSERT INTO `message` VALUES (429, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 01:37:07');
INSERT INTO `message` VALUES (430, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 01:37:07');
INSERT INTO `message` VALUES (431, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 01:37:07');
INSERT INTO `message` VALUES (432, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 01:37:07');
INSERT INTO `message` VALUES (447, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 01:37:08');
INSERT INTO `message` VALUES (448, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 01:37:08');
INSERT INTO `message` VALUES (449, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 01:37:08');
INSERT INTO `message` VALUES (450, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 01:37:08');
INSERT INTO `message` VALUES (451, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 01:37:08');
INSERT INTO `message` VALUES (466, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:37:08');
INSERT INTO `message` VALUES (467, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:37:08');
INSERT INTO `message` VALUES (468, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:37:08');
INSERT INTO `message` VALUES (469, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:37:08');
INSERT INTO `message` VALUES (470, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 01:37:08');
INSERT INTO `message` VALUES (496, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:00:56');
INSERT INTO `message` VALUES (497, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:00:56');
INSERT INTO `message` VALUES (498, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:00:56');
INSERT INTO `message` VALUES (499, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:00:56');
INSERT INTO `message` VALUES (500, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:00:56');
INSERT INTO `message` VALUES (526, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:00:56');
INSERT INTO `message` VALUES (527, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:00:56');
INSERT INTO `message` VALUES (528, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:00:56');
INSERT INTO `message` VALUES (529, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:00:56');
INSERT INTO `message` VALUES (530, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:00:56');
INSERT INTO `message` VALUES (556, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:00:56');
INSERT INTO `message` VALUES (557, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:00:56');
INSERT INTO `message` VALUES (558, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:00:56');
INSERT INTO `message` VALUES (559, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:00:56');
INSERT INTO `message` VALUES (560, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:00:56');
INSERT INTO `message` VALUES (586, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:00:56');
INSERT INTO `message` VALUES (587, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:00:56');
INSERT INTO `message` VALUES (588, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:00:56');
INSERT INTO `message` VALUES (589, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:00:56');
INSERT INTO `message` VALUES (590, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:00:56');
INSERT INTO `message` VALUES (616, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:00:56');
INSERT INTO `message` VALUES (617, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:00:56');
INSERT INTO `message` VALUES (618, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:00:56');
INSERT INTO `message` VALUES (619, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:00:56');
INSERT INTO `message` VALUES (620, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:00:56');
INSERT INTO `message` VALUES (660, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:03:42');
INSERT INTO `message` VALUES (661, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:03:42');
INSERT INTO `message` VALUES (662, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:03:42');
INSERT INTO `message` VALUES (663, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:03:43');
INSERT INTO `message` VALUES (664, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:03:43');
INSERT INTO `message` VALUES (704, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:03:43');
INSERT INTO `message` VALUES (705, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:03:43');
INSERT INTO `message` VALUES (706, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:03:43');
INSERT INTO `message` VALUES (707, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:03:43');
INSERT INTO `message` VALUES (708, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:03:43');
INSERT INTO `message` VALUES (748, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:03:43');
INSERT INTO `message` VALUES (749, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:03:43');
INSERT INTO `message` VALUES (750, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:03:43');
INSERT INTO `message` VALUES (751, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:03:43');
INSERT INTO `message` VALUES (752, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:03:43');
INSERT INTO `message` VALUES (792, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:03:43');
INSERT INTO `message` VALUES (793, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:03:43');
INSERT INTO `message` VALUES (794, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:03:43');
INSERT INTO `message` VALUES (795, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:03:43');
INSERT INTO `message` VALUES (796, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:03:43');
INSERT INTO `message` VALUES (836, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:03:43');
INSERT INTO `message` VALUES (837, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:03:43');
INSERT INTO `message` VALUES (838, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:03:43');
INSERT INTO `message` VALUES (839, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:03:43');
INSERT INTO `message` VALUES (840, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:03:43');
INSERT INTO `message` VALUES (884, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:04:18');
INSERT INTO `message` VALUES (885, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:04:18');
INSERT INTO `message` VALUES (886, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:04:18');
INSERT INTO `message` VALUES (887, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:04:18');
INSERT INTO `message` VALUES (888, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:04:18');
INSERT INTO `message` VALUES (932, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:04:19');
INSERT INTO `message` VALUES (933, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:04:19');
INSERT INTO `message` VALUES (934, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:04:19');
INSERT INTO `message` VALUES (935, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:04:19');
INSERT INTO `message` VALUES (936, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:04:19');
INSERT INTO `message` VALUES (980, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:04:19');
INSERT INTO `message` VALUES (981, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:04:19');
INSERT INTO `message` VALUES (982, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:04:19');
INSERT INTO `message` VALUES (983, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:04:19');
INSERT INTO `message` VALUES (984, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:04:19');
INSERT INTO `message` VALUES (1028, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:04:19');
INSERT INTO `message` VALUES (1029, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:04:19');
INSERT INTO `message` VALUES (1030, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:04:19');
INSERT INTO `message` VALUES (1031, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:04:19');
INSERT INTO `message` VALUES (1032, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:04:19');
INSERT INTO `message` VALUES (1076, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:04:19');
INSERT INTO `message` VALUES (1077, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:04:19');
INSERT INTO `message` VALUES (1078, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:04:19');
INSERT INTO `message` VALUES (1079, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:04:19');
INSERT INTO `message` VALUES (1080, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:04:19');
INSERT INTO `message` VALUES (1128, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:04:44');
INSERT INTO `message` VALUES (1129, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:04:44');
INSERT INTO `message` VALUES (1130, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:04:44');
INSERT INTO `message` VALUES (1131, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:04:44');
INSERT INTO `message` VALUES (1132, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:04:44');
INSERT INTO `message` VALUES (1180, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:04:44');
INSERT INTO `message` VALUES (1181, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:04:44');
INSERT INTO `message` VALUES (1182, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:04:44');
INSERT INTO `message` VALUES (1183, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:04:44');
INSERT INTO `message` VALUES (1184, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:04:44');
INSERT INTO `message` VALUES (1232, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:04:44');
INSERT INTO `message` VALUES (1233, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:04:44');
INSERT INTO `message` VALUES (1234, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:04:44');
INSERT INTO `message` VALUES (1235, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:04:44');
INSERT INTO `message` VALUES (1236, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:04:44');
INSERT INTO `message` VALUES (1284, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:04:44');
INSERT INTO `message` VALUES (1285, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:04:44');
INSERT INTO `message` VALUES (1286, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:04:44');
INSERT INTO `message` VALUES (1287, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:04:44');
INSERT INTO `message` VALUES (1288, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:04:44');
INSERT INTO `message` VALUES (1336, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:04:44');
INSERT INTO `message` VALUES (1337, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:04:44');
INSERT INTO `message` VALUES (1338, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:04:44');
INSERT INTO `message` VALUES (1339, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:04:44');
INSERT INTO `message` VALUES (1340, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:04:44');
INSERT INTO `message` VALUES (1392, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:05:04');
INSERT INTO `message` VALUES (1393, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:05:04');
INSERT INTO `message` VALUES (1394, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:05:04');
INSERT INTO `message` VALUES (1395, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:05:04');
INSERT INTO `message` VALUES (1396, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:05:04');
INSERT INTO `message` VALUES (1448, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:05:04');
INSERT INTO `message` VALUES (1449, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:05:04');
INSERT INTO `message` VALUES (1450, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:05:04');
INSERT INTO `message` VALUES (1451, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:05:04');
INSERT INTO `message` VALUES (1452, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:05:04');
INSERT INTO `message` VALUES (1504, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:05:04');
INSERT INTO `message` VALUES (1505, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:05:04');
INSERT INTO `message` VALUES (1506, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:05:04');
INSERT INTO `message` VALUES (1507, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:05:04');
INSERT INTO `message` VALUES (1508, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:05:04');
INSERT INTO `message` VALUES (1560, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:05:05');
INSERT INTO `message` VALUES (1561, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:05:05');
INSERT INTO `message` VALUES (1562, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:05:05');
INSERT INTO `message` VALUES (1563, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:05:05');
INSERT INTO `message` VALUES (1564, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:05:05');
INSERT INTO `message` VALUES (1616, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:05:05');
INSERT INTO `message` VALUES (1617, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:05:05');
INSERT INTO `message` VALUES (1618, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:05:05');
INSERT INTO `message` VALUES (1619, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:05:05');
INSERT INTO `message` VALUES (1620, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:05:05');
INSERT INTO `message` VALUES (1676, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:05:15');
INSERT INTO `message` VALUES (1677, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:05:15');
INSERT INTO `message` VALUES (1678, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:05:15');
INSERT INTO `message` VALUES (1679, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:05:15');
INSERT INTO `message` VALUES (1680, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:05:15');
INSERT INTO `message` VALUES (1736, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:05:16');
INSERT INTO `message` VALUES (1737, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:05:16');
INSERT INTO `message` VALUES (1738, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:05:16');
INSERT INTO `message` VALUES (1739, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:05:16');
INSERT INTO `message` VALUES (1740, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:05:16');
INSERT INTO `message` VALUES (1796, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:05:16');
INSERT INTO `message` VALUES (1797, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:05:16');
INSERT INTO `message` VALUES (1798, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:05:16');
INSERT INTO `message` VALUES (1799, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:05:16');
INSERT INTO `message` VALUES (1800, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:05:16');
INSERT INTO `message` VALUES (1856, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:05:16');
INSERT INTO `message` VALUES (1857, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:05:16');
INSERT INTO `message` VALUES (1858, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:05:16');
INSERT INTO `message` VALUES (1859, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:05:16');
INSERT INTO `message` VALUES (1860, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:05:16');
INSERT INTO `message` VALUES (1916, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:05:16');
INSERT INTO `message` VALUES (1917, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:05:16');
INSERT INTO `message` VALUES (1918, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:05:16');
INSERT INTO `message` VALUES (1919, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:05:16');
INSERT INTO `message` VALUES (1920, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:05:16');
INSERT INTO `message` VALUES (1980, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:05:46');
INSERT INTO `message` VALUES (1981, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:05:46');
INSERT INTO `message` VALUES (1982, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:05:46');
INSERT INTO `message` VALUES (1983, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:05:46');
INSERT INTO `message` VALUES (1984, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:05:46');
INSERT INTO `message` VALUES (2044, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:05:46');
INSERT INTO `message` VALUES (2045, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:05:46');
INSERT INTO `message` VALUES (2046, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:05:46');
INSERT INTO `message` VALUES (2047, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:05:46');
INSERT INTO `message` VALUES (2048, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:05:46');
INSERT INTO `message` VALUES (2108, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:05:47');
INSERT INTO `message` VALUES (2109, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:05:47');
INSERT INTO `message` VALUES (2110, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:05:47');
INSERT INTO `message` VALUES (2111, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:05:47');
INSERT INTO `message` VALUES (2112, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:05:47');
INSERT INTO `message` VALUES (2172, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:05:47');
INSERT INTO `message` VALUES (2173, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:05:47');
INSERT INTO `message` VALUES (2174, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:05:47');
INSERT INTO `message` VALUES (2175, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:05:47');
INSERT INTO `message` VALUES (2176, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:05:47');
INSERT INTO `message` VALUES (2236, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:05:47');
INSERT INTO `message` VALUES (2237, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:05:47');
INSERT INTO `message` VALUES (2238, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:05:47');
INSERT INTO `message` VALUES (2239, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:05:47');
INSERT INTO `message` VALUES (2240, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:05:47');
INSERT INTO `message` VALUES (2304, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:06:01');
INSERT INTO `message` VALUES (2305, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:06:01');
INSERT INTO `message` VALUES (2306, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:06:01');
INSERT INTO `message` VALUES (2307, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:06:01');
INSERT INTO `message` VALUES (2308, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:06:01');
INSERT INTO `message` VALUES (2372, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:06:01');
INSERT INTO `message` VALUES (2373, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:06:01');
INSERT INTO `message` VALUES (2374, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:06:01');
INSERT INTO `message` VALUES (2375, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:06:01');
INSERT INTO `message` VALUES (2376, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:06:01');
INSERT INTO `message` VALUES (2440, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:06:02');
INSERT INTO `message` VALUES (2441, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:06:02');
INSERT INTO `message` VALUES (2442, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:06:02');
INSERT INTO `message` VALUES (2443, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:06:02');
INSERT INTO `message` VALUES (2444, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:06:02');
INSERT INTO `message` VALUES (2508, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:06:02');
INSERT INTO `message` VALUES (2509, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:06:02');
INSERT INTO `message` VALUES (2510, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:06:02');
INSERT INTO `message` VALUES (2511, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:06:02');
INSERT INTO `message` VALUES (2512, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:06:02');
INSERT INTO `message` VALUES (2576, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:06:02');
INSERT INTO `message` VALUES (2577, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:06:02');
INSERT INTO `message` VALUES (2578, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:06:02');
INSERT INTO `message` VALUES (2579, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:06:02');
INSERT INTO `message` VALUES (2580, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:06:02');
INSERT INTO `message` VALUES (2648, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:06:12');
INSERT INTO `message` VALUES (2649, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:06:12');
INSERT INTO `message` VALUES (2650, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:06:12');
INSERT INTO `message` VALUES (2651, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:06:12');
INSERT INTO `message` VALUES (2652, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:06:12');
INSERT INTO `message` VALUES (2720, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:06:12');
INSERT INTO `message` VALUES (2721, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:06:12');
INSERT INTO `message` VALUES (2722, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:06:12');
INSERT INTO `message` VALUES (2723, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:06:12');
INSERT INTO `message` VALUES (2724, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:06:12');
INSERT INTO `message` VALUES (2792, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:06:12');
INSERT INTO `message` VALUES (2793, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:06:12');
INSERT INTO `message` VALUES (2794, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:06:12');
INSERT INTO `message` VALUES (2795, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:06:12');
INSERT INTO `message` VALUES (2796, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:06:12');
INSERT INTO `message` VALUES (2864, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:06:12');
INSERT INTO `message` VALUES (2865, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:06:12');
INSERT INTO `message` VALUES (2866, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:06:12');
INSERT INTO `message` VALUES (2867, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:06:12');
INSERT INTO `message` VALUES (2868, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:06:12');
INSERT INTO `message` VALUES (2936, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:06:13');
INSERT INTO `message` VALUES (2937, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:06:13');
INSERT INTO `message` VALUES (2938, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:06:13');
INSERT INTO `message` VALUES (2939, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:06:13');
INSERT INTO `message` VALUES (2940, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:06:13');
INSERT INTO `message` VALUES (3012, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:06:46');
INSERT INTO `message` VALUES (3013, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:06:46');
INSERT INTO `message` VALUES (3014, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:06:46');
INSERT INTO `message` VALUES (3015, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:06:46');
INSERT INTO `message` VALUES (3016, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:06:46');
INSERT INTO `message` VALUES (3088, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:06:46');
INSERT INTO `message` VALUES (3089, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:06:46');
INSERT INTO `message` VALUES (3090, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:06:46');
INSERT INTO `message` VALUES (3091, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:06:46');
INSERT INTO `message` VALUES (3092, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:06:46');
INSERT INTO `message` VALUES (3164, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:06:47');
INSERT INTO `message` VALUES (3165, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:06:47');
INSERT INTO `message` VALUES (3166, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:06:47');
INSERT INTO `message` VALUES (3167, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:06:47');
INSERT INTO `message` VALUES (3168, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:06:47');
INSERT INTO `message` VALUES (3240, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:06:47');
INSERT INTO `message` VALUES (3241, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:06:47');
INSERT INTO `message` VALUES (3242, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:06:47');
INSERT INTO `message` VALUES (3243, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:06:47');
INSERT INTO `message` VALUES (3244, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:06:47');
INSERT INTO `message` VALUES (3316, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:06:47');
INSERT INTO `message` VALUES (3317, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:06:47');
INSERT INTO `message` VALUES (3318, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:06:47');
INSERT INTO `message` VALUES (3319, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:06:47');
INSERT INTO `message` VALUES (3320, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:06:47');
INSERT INTO `message` VALUES (3396, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:08:21');
INSERT INTO `message` VALUES (3397, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:08:21');
INSERT INTO `message` VALUES (3398, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:08:21');
INSERT INTO `message` VALUES (3399, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:08:21');
INSERT INTO `message` VALUES (3400, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:08:21');
INSERT INTO `message` VALUES (3476, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:08:22');
INSERT INTO `message` VALUES (3477, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:08:22');
INSERT INTO `message` VALUES (3478, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:08:22');
INSERT INTO `message` VALUES (3479, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:08:22');
INSERT INTO `message` VALUES (3480, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:08:22');
INSERT INTO `message` VALUES (3556, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:08:22');
INSERT INTO `message` VALUES (3557, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:08:22');
INSERT INTO `message` VALUES (3558, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:08:22');
INSERT INTO `message` VALUES (3559, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:08:22');
INSERT INTO `message` VALUES (3560, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:08:22');
INSERT INTO `message` VALUES (3636, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:08:22');
INSERT INTO `message` VALUES (3637, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:08:22');
INSERT INTO `message` VALUES (3638, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:08:22');
INSERT INTO `message` VALUES (3639, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:08:22');
INSERT INTO `message` VALUES (3640, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:08:22');
INSERT INTO `message` VALUES (3716, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:08:23');
INSERT INTO `message` VALUES (3717, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:08:23');
INSERT INTO `message` VALUES (3718, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:08:23');
INSERT INTO `message` VALUES (3719, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:08:23');
INSERT INTO `message` VALUES (3720, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:08:23');
INSERT INTO `message` VALUES (3800, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:09:15');
INSERT INTO `message` VALUES (3801, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:09:15');
INSERT INTO `message` VALUES (3802, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:09:15');
INSERT INTO `message` VALUES (3803, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:09:15');
INSERT INTO `message` VALUES (3804, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥100.00，请及时处理', 0, '2026-06-23 02:09:15');
INSERT INTO `message` VALUES (3884, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:09:15');
INSERT INTO `message` VALUES (3885, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:09:15');
INSERT INTO `message` VALUES (3886, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:09:15');
INSERT INTO `message` VALUES (3887, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:09:15');
INSERT INTO `message` VALUES (3888, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥88.00，请及时处理', 0, '2026-06-23 02:09:15');
INSERT INTO `message` VALUES (3968, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:09:16');
INSERT INTO `message` VALUES (3969, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:09:16');
INSERT INTO `message` VALUES (3970, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 1, '2026-06-23 02:09:16');
INSERT INTO `message` VALUES (3971, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:09:16');
INSERT INTO `message` VALUES (3972, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥66.00，请及时处理', 0, '2026-06-23 02:09:16');
INSERT INTO `message` VALUES (4052, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:09:16');
INSERT INTO `message` VALUES (4053, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:09:16');
INSERT INTO `message` VALUES (4054, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 1, '2026-06-23 02:09:16');
INSERT INTO `message` VALUES (4055, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:09:16');
INSERT INTO `message` VALUES (4056, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥77.00，请及时处理', 0, '2026-06-23 02:09:16');
INSERT INTO `message` VALUES (4136, 23, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:09:16');
INSERT INTO `message` VALUES (4137, 6, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:09:16');
INSERT INTO `message` VALUES (4138, 1, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:09:16');
INSERT INTO `message` VALUES (4139, 3, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:09:16');
INSERT INTO `message` VALUES (4140, 2, 'order', '新订单提醒', '您有一笔新订单等待接单，订单金额：¥50.00，请及时处理', 0, '2026-06-23 02:09:16');
INSERT INTO `message` VALUES (4141, 1, 'order', '订单已接单', '您已成功接单，订单号：157，请尽快前往商家取货', 1, '2026-06-23 02:15:38');
INSERT INTO `message` VALUES (4142, 1, 'order', '订单已接单', '您已成功接单，订单号：154，请尽快前往商家取货', 0, '2026-06-23 02:37:59');
INSERT INTO `message` VALUES (4143, 1, 'order', '开始取货', '您已到达商家并开始取货，订单号：157', 0, '2026-06-23 02:38:02');
INSERT INTO `message` VALUES (4144, 1, 'income', '收入到账', '您完成了一笔配送订单，配送收入：¥8.00已到账', 0, '2026-06-23 02:38:04');

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
) ENGINE = InnoDB AUTO_INCREMENT = 174 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '操作日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of operation_log
-- ----------------------------
INSERT INTO `operation_log` VALUES (68, 1, 'admin', '管理员', 'LOGIN', '用户登录', 'admin(管理员) 登录成功', '127.0.0.1', '2026-06-23 00:33:19');
INSERT INTO `operation_log` VALUES (69, 1, 'admin', '管理员', 'LOGOUT', '用户退出', 'admin(管理员) 退出登录', '0:0:0:0:0:0:0:1', '2026-06-23 00:38:50');
INSERT INTO `operation_log` VALUES (70, 0, '', '用户', 'LOGOUT', '用户退出', '(用户) 退出登录', '0:0:0:0:0:0:0:1', '2026-06-23 00:38:52');
INSERT INTO `operation_log` VALUES (71, 3, 'admin1', '用户', 'LOGIN', '用户登录', 'admin1(用户) 登录成功', '127.0.0.1', '2026-06-23 00:42:41');
INSERT INTO `operation_log` VALUES (72, 3, 'admin1', '用户', 'LOGOUT', '用户退出', 'admin1(用户) 退出登录', '0:0:0:0:0:0:0:1', '2026-06-23 00:42:42');
INSERT INTO `operation_log` VALUES (73, 0, '', '用户', 'LOGOUT', '用户退出', '(用户) 退出登录', '0:0:0:0:0:0:0:1', '2026-06-23 00:42:44');
INSERT INTO `operation_log` VALUES (74, 1, 'admin', '管理员', 'LOGIN', '用户登录', 'admin(管理员) 登录成功', '127.0.0.1', '2026-06-23 00:42:53');
INSERT INTO `operation_log` VALUES (75, 1, 'admin', '管理员', 'LOGOUT', '用户退出', 'admin(管理员) 退出登录', '0:0:0:0:0:0:0:1', '2026-06-23 01:03:06');
INSERT INTO `operation_log` VALUES (76, 0, '(用户)', '用户', 'LOGOUT', '用户退出', '(用户)(用户) 退出登录', '0:0:0:0:0:0:0:1', '2026-06-23 01:03:14');
INSERT INTO `operation_log` VALUES (77, 0, 'system', '系统', 'CLEAN', '日志管理', '自动清理历史日志，共清理 64 条记录', NULL, '2026-06-23 01:04:15');
INSERT INTO `operation_log` VALUES (78, 1, 'admin', '管理员', 'LOGIN', '用户登录', 'admin(管理员) 登录成功', '127.0.0.1', '2026-06-23 01:04:15');
INSERT INTO `operation_log` VALUES (79, 1, 'admin', '管理员', 'LOGOUT', '用户退出', 'admin(管理员) 退出登录', '0:0:0:0:0:0:0:1', '2026-06-23 01:06:14');
INSERT INTO `operation_log` VALUES (80, 1, 'admin', '管理员', 'LOGIN', '用户登录', 'admin(管理员) 登录成功', '127.0.0.1', '2026-06-23 01:06:28');
INSERT INTO `operation_log` VALUES (81, 1, 'admin', '管理员', 'LOGOUT', '用户退出', 'admin(管理员) 退出登录', '0:0:0:0:0:0:0:1', '2026-06-23 01:07:18');
INSERT INTO `operation_log` VALUES (82, 24, 'test_user_1782177384201', '用户', 'LOGIN', '用户登录', 'test_user_1782177384201(用户) 登录成功', '127.0.0.1', '2026-06-23 01:16:27');
INSERT INTO `operation_log` VALUES (83, 0, 'test_user_1782177384201', '用户', 'LOGOUT', '用户退出', 'test_user_1782177384201(用户) 退出登录', '127.0.0.1', '2026-06-23 01:16:27');
INSERT INTO `operation_log` VALUES (84, 25, 'test_user_1782177422661', '用户', 'LOGIN', '用户登录', 'test_user_1782177422661(用户) 登录成功', '127.0.0.1', '2026-06-23 01:17:05');
INSERT INTO `operation_log` VALUES (85, 0, 'test_user_1782177422661', '用户', 'LOGOUT', '用户退出', 'test_user_1782177422661(用户) 退出登录', '127.0.0.1', '2026-06-23 01:17:05');
INSERT INTO `operation_log` VALUES (86, 26, 'test_user_1782177532342', '用户', 'LOGIN', '用户登录', 'test_user_1782177532342(用户) 登录成功', '127.0.0.1', '2026-06-23 01:18:52');
INSERT INTO `operation_log` VALUES (87, 0, 'test_user_1782177532342', '用户', 'LOGOUT', '用户退出', 'test_user_1782177532342(用户) 退出登录', '127.0.0.1', '2026-06-23 01:18:52');
INSERT INTO `operation_log` VALUES (88, 27, 'test_user_1782177535398', '用户', 'LOGIN', '用户登录', 'test_user_1782177535398(用户) 登录成功', '127.0.0.1', '2026-06-23 01:18:58');
INSERT INTO `operation_log` VALUES (89, 0, 'test_user_1782177535398', '用户', 'LOGOUT', '用户退出', 'test_user_1782177535398(用户) 退出登录', '127.0.0.1', '2026-06-23 01:18:58');
INSERT INTO `operation_log` VALUES (90, 28, 'test_user_1782177659286', '用户', 'LOGIN', '用户登录', 'test_user_1782177659286(用户) 登录成功', '127.0.0.1', '2026-06-23 01:20:59');
INSERT INTO `operation_log` VALUES (91, 0, 'test_user_1782177659286', '用户', 'LOGOUT', '用户退出', 'test_user_1782177659286(用户) 退出登录', '127.0.0.1', '2026-06-23 01:20:59');
INSERT INTO `operation_log` VALUES (92, 29, 'test_user_1782177844408', '用户', 'LOGIN', '用户登录', 'test_user_1782177844408(用户) 登录成功', '127.0.0.1', '2026-06-23 01:24:04');
INSERT INTO `operation_log` VALUES (93, 0, 'test_user_1782177844408', '用户', 'LOGOUT', '用户退出', 'test_user_1782177844408(用户) 退出登录', '127.0.0.1', '2026-06-23 01:24:04');
INSERT INTO `operation_log` VALUES (94, 30, 'test_user_1782178009920', '用户', 'LOGIN', '用户登录', 'test_user_1782178009920(用户) 登录成功', '127.0.0.1', '2026-06-23 01:26:50');
INSERT INTO `operation_log` VALUES (95, 0, 'test_user_1782178009920', '用户', 'LOGOUT', '用户退出', 'test_user_1782178009920(用户) 退出登录', '127.0.0.1', '2026-06-23 01:26:50');
INSERT INTO `operation_log` VALUES (96, 31, 'test_user_1782178147869', '用户', 'LOGIN', '用户登录', 'test_user_1782178147869(用户) 登录成功', '127.0.0.1', '2026-06-23 01:29:08');
INSERT INTO `operation_log` VALUES (97, 0, 'test_user_1782178147869', '用户', 'LOGOUT', '用户退出', 'test_user_1782178147869(用户) 退出登录', '127.0.0.1', '2026-06-23 01:29:08');
INSERT INTO `operation_log` VALUES (98, 1, 'admin', '管理员', 'UPDATE', '订单管理', '订单发货 ID: 86', NULL, '2026-06-23 01:35:48');
INSERT INTO `operation_log` VALUES (99, 1, 'admin', '管理员', 'UPDATE', '订单管理', '修改配送费 ID: 86, 金额: 8.0', NULL, '2026-06-23 01:35:49');
INSERT INTO `operation_log` VALUES (100, 1, 'admin', '管理员', 'DELETE', '订单管理', '删除订单 ID: 88', NULL, '2026-06-23 01:35:49');
INSERT INTO `operation_log` VALUES (101, 1, 'admin', '管理员', 'UPDATE', '订单管理', '订单发货 ID: 91', NULL, '2026-06-23 01:36:02');
INSERT INTO `operation_log` VALUES (102, 1, 'admin', '管理员', 'UPDATE', '订单管理', '修改配送费 ID: 92, 金额: 8.0', NULL, '2026-06-23 01:36:02');
INSERT INTO `operation_log` VALUES (103, 1, 'admin', '管理员', 'DELETE', '订单管理', '删除订单 ID: 93', NULL, '2026-06-23 01:36:02');
INSERT INTO `operation_log` VALUES (104, 32, 'test_user_1782178561718', '用户', 'LOGIN', '用户登录', 'test_user_1782178561718(用户) 登录成功', '127.0.0.1', '2026-06-23 01:36:02');
INSERT INTO `operation_log` VALUES (105, 0, 'test_user_1782178561718', '用户', 'LOGOUT', '用户退出', 'test_user_1782178561718(用户) 退出登录', '127.0.0.1', '2026-06-23 01:36:02');
INSERT INTO `operation_log` VALUES (106, 1, 'admin', '管理员', 'UPDATE', '订单管理', '订单发货 ID: 94', NULL, '2026-06-23 01:37:07');
INSERT INTO `operation_log` VALUES (107, 1, 'admin', '管理员', 'UPDATE', '订单管理', '修改配送费 ID: 94, 金额: 8.0', NULL, '2026-06-23 01:37:08');
INSERT INTO `operation_log` VALUES (108, 1, 'admin', '管理员', 'DELETE', '订单管理', '删除订单 ID: 98', NULL, '2026-06-23 01:37:08');
INSERT INTO `operation_log` VALUES (109, 33, 'test_user_1782178627655', '用户', 'LOGIN', '用户登录', 'test_user_1782178627655(用户) 登录成功', '127.0.0.1', '2026-06-23 01:37:08');
INSERT INTO `operation_log` VALUES (110, 0, 'test_user_1782178627655', '用户', 'LOGOUT', '用户退出', 'test_user_1782178627655(用户) 退出登录', '127.0.0.1', '2026-06-23 01:37:08');
INSERT INTO `operation_log` VALUES (111, 1, 'admin', '管理员', 'UPDATE', '订单管理', '订单发货 ID: 99', NULL, '2026-06-23 02:00:56');
INSERT INTO `operation_log` VALUES (112, 1, 'admin', '管理员', 'UPDATE', '订单管理', '修改配送费 ID: 102, 金额: 8.0', NULL, '2026-06-23 02:00:56');
INSERT INTO `operation_log` VALUES (113, 1, 'admin', '管理员', 'DELETE', '订单管理', '删除订单 ID: 102', NULL, '2026-06-23 02:00:56');
INSERT INTO `operation_log` VALUES (114, 34, 'test_user_1782180056245', '用户', 'LOGIN', '用户登录', 'test_user_1782180056245(用户) 登录成功', '127.0.0.1', '2026-06-23 02:00:56');
INSERT INTO `operation_log` VALUES (115, 0, 'test_user_1782180056245', '用户', 'LOGOUT', '用户退出', 'test_user_1782180056245(用户) 退出登录', '127.0.0.1', '2026-06-23 02:00:56');
INSERT INTO `operation_log` VALUES (116, 1, 'admin', '管理员', 'UPDATE', '订单管理', '订单发货 ID: 105', NULL, '2026-06-23 02:03:43');
INSERT INTO `operation_log` VALUES (117, 1, 'admin', '管理员', 'UPDATE', '订单管理', '修改配送费 ID: 107, 金额: 8.0', NULL, '2026-06-23 02:03:43');
INSERT INTO `operation_log` VALUES (118, 1, 'admin', '管理员', 'DELETE', '订单管理', '删除订单 ID: 108', NULL, '2026-06-23 02:03:43');
INSERT INTO `operation_log` VALUES (119, 35, 'test_user_1782180223197', '用户', 'LOGIN', '用户登录', 'test_user_1782180223197(用户) 登录成功', '127.0.0.1', '2026-06-23 02:03:43');
INSERT INTO `operation_log` VALUES (120, 0, 'test_user_1782180223197', '用户', 'LOGOUT', '用户退出', 'test_user_1782180223197(用户) 退出登录', '127.0.0.1', '2026-06-23 02:03:43');
INSERT INTO `operation_log` VALUES (121, 1, 'admin', '管理员', 'UPDATE', '订单管理', '订单发货 ID: 111', NULL, '2026-06-23 02:04:19');
INSERT INTO `operation_log` VALUES (122, 1, 'admin', '管理员', 'UPDATE', '订单管理', '修改配送费 ID: 112, 金额: 8.0', NULL, '2026-06-23 02:04:19');
INSERT INTO `operation_log` VALUES (123, 1, 'admin', '管理员', 'DELETE', '订单管理', '删除订单 ID: 112', NULL, '2026-06-23 02:04:19');
INSERT INTO `operation_log` VALUES (124, 36, 'test_user_1782180259338', '用户', 'LOGIN', '用户登录', 'test_user_1782180259338(用户) 登录成功', '127.0.0.1', '2026-06-23 02:04:19');
INSERT INTO `operation_log` VALUES (125, 0, 'test_user_1782180259338', '用户', 'LOGOUT', '用户退出', 'test_user_1782180259338(用户) 退出登录', '127.0.0.1', '2026-06-23 02:04:19');
INSERT INTO `operation_log` VALUES (126, 1, 'admin', '管理员', 'UPDATE', '订单管理', '订单发货 ID: 115', NULL, '2026-06-23 02:04:44');
INSERT INTO `operation_log` VALUES (127, 1, 'admin', '管理员', 'UPDATE', '订单管理', '修改配送费 ID: 115, 金额: 8.0', NULL, '2026-06-23 02:04:44');
INSERT INTO `operation_log` VALUES (128, 1, 'admin', '管理员', 'DELETE', '订单管理', '删除订单 ID: 115', NULL, '2026-06-23 02:04:44');
INSERT INTO `operation_log` VALUES (129, 37, 'test_user_1782180284338', '用户', 'LOGIN', '用户登录', 'test_user_1782180284338(用户) 登录成功', '127.0.0.1', '2026-06-23 02:04:44');
INSERT INTO `operation_log` VALUES (130, 0, 'test_user_1782180284338', '用户', 'LOGOUT', '用户退出', 'test_user_1782180284338(用户) 退出登录', '127.0.0.1', '2026-06-23 02:04:44');
INSERT INTO `operation_log` VALUES (131, 1, 'admin', '管理员', 'UPDATE', '订单管理', '订单发货 ID: 119', NULL, '2026-06-23 02:05:04');
INSERT INTO `operation_log` VALUES (132, 1, 'admin', '管理员', 'UPDATE', '订单管理', '修改配送费 ID: 122, 金额: 8.0', NULL, '2026-06-23 02:05:05');
INSERT INTO `operation_log` VALUES (133, 1, 'admin', '管理员', 'DELETE', '订单管理', '删除订单 ID: 123', NULL, '2026-06-23 02:05:05');
INSERT INTO `operation_log` VALUES (134, 38, 'test_user_1782180304893', '用户', 'LOGIN', '用户登录', 'test_user_1782180304893(用户) 登录成功', '127.0.0.1', '2026-06-23 02:05:05');
INSERT INTO `operation_log` VALUES (135, 0, 'test_user_1782180304893', '用户', 'LOGOUT', '用户退出', 'test_user_1782180304893(用户) 退出登录', '127.0.0.1', '2026-06-23 02:05:05');
INSERT INTO `operation_log` VALUES (136, 1, 'admin', '管理员', 'UPDATE', '订单管理', '订单发货 ID: 126', NULL, '2026-06-23 02:05:16');
INSERT INTO `operation_log` VALUES (137, 1, 'admin', '管理员', 'UPDATE', '订单管理', '修改配送费 ID: 126, 金额: 8.0', NULL, '2026-06-23 02:05:16');
INSERT INTO `operation_log` VALUES (138, 1, 'admin', '管理员', 'DELETE', '订单管理', '删除订单 ID: 126', NULL, '2026-06-23 02:05:16');
INSERT INTO `operation_log` VALUES (139, 39, 'test_user_1782180316309', '用户', 'LOGIN', '用户登录', 'test_user_1782180316309(用户) 登录成功', '127.0.0.1', '2026-06-23 02:05:16');
INSERT INTO `operation_log` VALUES (140, 0, 'test_user_1782180316309', '用户', 'LOGOUT', '用户退出', 'test_user_1782180316309(用户) 退出登录', '127.0.0.1', '2026-06-23 02:05:16');
INSERT INTO `operation_log` VALUES (141, 1, 'admin', '管理员', 'UPDATE', '订单管理', '订单发货 ID: 131', NULL, '2026-06-23 02:05:47');
INSERT INTO `operation_log` VALUES (142, 1, 'admin', '管理员', 'UPDATE', '订单管理', '修改配送费 ID: 132, 金额: 8.0', NULL, '2026-06-23 02:05:47');
INSERT INTO `operation_log` VALUES (143, 1, 'admin', '管理员', 'DELETE', '订单管理', '删除订单 ID: 132', NULL, '2026-06-23 02:05:47');
INSERT INTO `operation_log` VALUES (144, 40, 'test_user_1782180347057', '用户', 'LOGIN', '用户登录', 'test_user_1782180347057(用户) 登录成功', '127.0.0.1', '2026-06-23 02:05:47');
INSERT INTO `operation_log` VALUES (145, 0, 'test_user_1782180347057', '用户', 'LOGOUT', '用户退出', 'test_user_1782180347057(用户) 退出登录', '127.0.0.1', '2026-06-23 02:05:47');
INSERT INTO `operation_log` VALUES (146, 1, 'admin', '管理员', 'UPDATE', '订单管理', '订单发货 ID: 135', NULL, '2026-06-23 02:06:02');
INSERT INTO `operation_log` VALUES (147, 1, 'admin', '管理员', 'UPDATE', '订单管理', '修改配送费 ID: 137, 金额: 8.0', NULL, '2026-06-23 02:06:02');
INSERT INTO `operation_log` VALUES (148, 1, 'admin', '管理员', 'DELETE', '订单管理', '删除订单 ID: 137', NULL, '2026-06-23 02:06:03');
INSERT INTO `operation_log` VALUES (149, 41, 'test_user_1782180362524', '用户', 'LOGIN', '用户登录', 'test_user_1782180362524(用户) 登录成功', '127.0.0.1', '2026-06-23 02:06:03');
INSERT INTO `operation_log` VALUES (150, 0, 'test_user_1782180362524', '用户', 'LOGOUT', '用户退出', 'test_user_1782180362524(用户) 退出登录', '127.0.0.1', '2026-06-23 02:06:03');
INSERT INTO `operation_log` VALUES (151, 1, 'admin', '管理员', 'UPDATE', '订单管理', '订单发货 ID: 141', NULL, '2026-06-23 02:06:12');
INSERT INTO `operation_log` VALUES (152, 1, 'admin', '管理员', 'UPDATE', '订单管理', '修改配送费 ID: 141, 金额: 8.0', NULL, '2026-06-23 02:06:12');
INSERT INTO `operation_log` VALUES (153, 1, 'admin', '管理员', 'DELETE', '订单管理', '删除订单 ID: 141', NULL, '2026-06-23 02:06:13');
INSERT INTO `operation_log` VALUES (154, 42, 'test_user_1782180372764', '用户', 'LOGIN', '用户登录', 'test_user_1782180372764(用户) 登录成功', '127.0.0.1', '2026-06-23 02:06:13');
INSERT INTO `operation_log` VALUES (155, 0, 'test_user_1782180372764', '用户', 'LOGOUT', '用户退出', 'test_user_1782180372764(用户) 退出登录', '127.0.0.1', '2026-06-23 02:06:13');
INSERT INTO `operation_log` VALUES (156, 1, 'admin', '管理员', 'UPDATE', '订单管理', '订单发货 ID: 144', NULL, '2026-06-23 02:06:47');
INSERT INTO `operation_log` VALUES (157, 1, 'admin', '管理员', 'UPDATE', '订单管理', '修改配送费 ID: 147, 金额: 8.0', NULL, '2026-06-23 02:06:47');
INSERT INTO `operation_log` VALUES (158, 1, 'admin', '管理员', 'DELETE', '订单管理', '删除订单 ID: 147', NULL, '2026-06-23 02:06:47');
INSERT INTO `operation_log` VALUES (159, 43, 'test_user_1782180407200', '用户', 'LOGIN', '用户登录', 'test_user_1782180407200(用户) 登录成功', '127.0.0.1', '2026-06-23 02:06:47');
INSERT INTO `operation_log` VALUES (160, 0, 'test_user_1782180407200', '用户', 'LOGOUT', '用户退出', 'test_user_1782180407200(用户) 退出登录', '127.0.0.1', '2026-06-23 02:06:47');
INSERT INTO `operation_log` VALUES (161, 1, 'admin', '管理员', 'UPDATE', '订单管理', '订单发货 ID: 151', NULL, '2026-06-23 02:08:22');
INSERT INTO `operation_log` VALUES (162, 1, 'admin', '管理员', 'UPDATE', '订单管理', '修改配送费 ID: 151, 金额: 8.0', NULL, '2026-06-23 02:08:22');
INSERT INTO `operation_log` VALUES (163, 1, 'admin', '管理员', 'DELETE', '订单管理', '删除订单 ID: 153', NULL, '2026-06-23 02:08:23');
INSERT INTO `operation_log` VALUES (164, 44, 'test_user_1782180502849', '用户', 'LOGIN', '用户登录', 'test_user_1782180502849(用户) 登录成功', '127.0.0.1', '2026-06-23 02:08:23');
INSERT INTO `operation_log` VALUES (165, 0, 'test_user_1782180502849', '用户', 'LOGOUT', '用户退出', 'test_user_1782180502849(用户) 退出登录', '127.0.0.1', '2026-06-23 02:08:23');
INSERT INTO `operation_log` VALUES (166, 1, 'admin', '管理员', 'UPDATE', '订单管理', '订单发货 ID: 155', NULL, '2026-06-23 02:09:16');
INSERT INTO `operation_log` VALUES (167, 1, 'admin', '管理员', 'UPDATE', '订单管理', '修改配送费 ID: 157, 金额: 8.0', NULL, '2026-06-23 02:09:16');
INSERT INTO `operation_log` VALUES (168, 1, 'admin', '管理员', 'DELETE', '订单管理', '删除订单 ID: 158', NULL, '2026-06-23 02:09:16');
INSERT INTO `operation_log` VALUES (169, 45, 'test_user_1782180556326', '用户', 'LOGIN', '用户登录', 'test_user_1782180556326(用户) 登录成功', '127.0.0.1', '2026-06-23 02:09:16');
INSERT INTO `operation_log` VALUES (170, 0, 'test_user_1782180556326', '用户', 'LOGOUT', '用户退出', 'test_user_1782180556326(用户) 退出登录', '127.0.0.1', '2026-06-23 02:09:16');
INSERT INTO `operation_log` VALUES (171, 1, 'admin', '管理员', 'LOGIN', '用户登录', 'admin(管理员) 登录成功', '127.0.0.1', '2026-06-23 02:13:11');
INSERT INTO `operation_log` VALUES (172, 1, 'admin', '管理员', 'LOGOUT', '用户退出', 'admin(管理员) 退出登录', '0:0:0:0:0:0:0:1', '2026-06-23 02:13:54');
INSERT INTO `operation_log` VALUES (173, 1, 'admin', '管理员', 'LOGIN', '用户登录', 'admin(管理员) 登录成功', '127.0.0.1', '2026-06-23 02:38:43');

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
) ENGINE = InnoDB AUTO_INCREMENT = 159 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

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
INSERT INTO `order` VALUES (56, 100.00, 2, 0, 0, '测试收件人', '13800138000', '测试地址', '2026-06-23 09:18:20', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (57, 50.00, 1, 0, 0, '删除测试', '13800138001', '删除测试地址', '2026-06-23 09:18:21', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (58, 100.00, 2, 0, 0, '测试收件人', '13800138000', '测试地址', '2026-06-23 09:18:52', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (59, 50.00, 1, 0, 0, '删除测试', '13800138001', '删除测试地址', '2026-06-23 09:18:52', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (60, 100.00, 2, 0, 0, '测试收件人', '13800138000', '测试地址', '2026-06-23 09:19:03', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (61, 50.00, 1, 0, 0, '删除测试', '13800138001', '删除测试地址', '2026-06-23 09:19:03', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (62, 100.00, 2, 0, 0, '测试收件人', '13800138000', '测试地址', '2026-06-23 09:20:59', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (63, 50.00, 1, 0, 0, '删除测试', '13800138001', '删除测试地址', '2026-06-23 09:20:59', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (64, 100.00, 2, 0, 0, '测试收件人', '13800138000', '测试地址', '2026-06-23 09:24:04', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (65, 50.00, 1, 0, 0, '删除测试', '13800138001', '删除测试地址', '2026-06-23 09:24:04', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (71, 100.00, 2, 0, 0, '测试收件人', '13800138000', '测试地址', '2026-06-23 09:29:07', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (72, 88.00, 1, 0, 0, '详情测试', '13800138001', '详情测试地址', '2026-06-23 09:29:08', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (73, 66.00, 1, 0, 0, '发货测试', '13800138002', '发货测试地址', '2026-06-23 09:29:08', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (74, 77.00, 1, 0, 0, '配送费测试', '13800138003', '配送费测试地址', '2026-06-23 09:29:08', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (75, 50.00, 1, 0, 0, '删除测试', '13800138004', '删除测试地址', '2026-06-23 09:29:08', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (76, 100.00, 2, 0, 0, '测试收件人', '13800138000', '测试地址', '2026-06-23 09:31:12', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (77, 100.00, 2, 0, 0, '测试收件人', '13800138000', '测试地址', '2026-06-23 09:31:54', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (78, 88.00, 1, 0, 0, '详情测试', '13800138001', '详情测试地址', '2026-06-23 09:31:54', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (79, 66.00, 1, 0, 0, '发货测试', '13800138002', '发货测试地址', '2026-06-23 09:31:55', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (80, 77.00, 1, 0, 0, '配送费测试', '13800138003', '配送费测试地址', '2026-06-23 09:31:55', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (81, 50.00, 1, 0, 0, '删除测试', '13800138004', '删除测试地址', '2026-06-23 09:31:55', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (82, 88.00, 1, 0, 0, '详情测试', '13800138001', '详情测试地址', '2026-06-23 09:33:49', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (83, 88.00, 1, 0, 0, '详情测试', '13800138001', '详情测试地址', '2026-06-23 09:35:35', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (84, 100.00, 2, 0, 0, '测试收件人', '13800138000', '测试地址', '2026-06-23 09:35:48', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (85, 88.00, 1, 0, 0, '详情测试', '13800138001', '详情测试地址', '2026-06-23 09:35:48', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (86, 66.00, 1, 1, 0, '发货测试', '13800138002', '发货测试地址', '2026-06-23 09:35:48', 1, NULL, NULL, NULL, 8.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (87, 77.00, 1, 0, 0, '配送费测试', '13800138003', '配送费测试地址', '2026-06-23 09:35:48', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (89, 100.00, 2, 0, 0, '测试收件人', '13800138000', '测试地址', '2026-06-23 09:36:01', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (90, 88.00, 1, 0, 0, '详情测试', '13800138001', '详情测试地址', '2026-06-23 09:36:01', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (91, 66.00, 1, 1, 0, '发货测试', '13800138002', '发货测试地址', '2026-06-23 09:36:01', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (92, 77.00, 1, 0, 0, '配送费测试', '13800138003', '配送费测试地址', '2026-06-23 09:36:02', 1, NULL, NULL, NULL, 8.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (94, 100.00, 2, 1, 0, '测试收件人', '13800138000', '测试地址', '2026-06-23 09:37:07', 1, NULL, NULL, NULL, 8.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (95, 88.00, 1, 0, 0, '详情测试', '13800138001', '详情测试地址', '2026-06-23 09:37:07', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (96, 66.00, 1, 0, 0, '发货测试', '13800138002', '发货测试地址', '2026-06-23 09:37:07', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (97, 77.00, 1, 0, 0, '配送费测试', '13800138003', '配送费测试地址', '2026-06-23 09:37:07', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (99, 100.00, 2, 1, 0, '测试收件人', '13800138000', '测试地址', '2026-06-23 10:00:56', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (100, 88.00, 1, 0, 0, '详情测试', '13800138001', '详情测试地址', '2026-06-23 10:00:56', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (101, 66.00, 1, 0, 0, '发货测试', '13800138002', '发货测试地址', '2026-06-23 10:00:56', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (103, 50.00, 1, 0, 0, '删除测试', '13800138004', '删除测试地址', '2026-06-23 10:00:56', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (104, 100.00, 2, 0, 0, '测试收件人', '13800138000', '测试地址', '2026-06-23 10:03:42', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (105, 88.00, 1, 1, 0, '详情测试', '13800138001', '详情测试地址', '2026-06-23 10:03:43', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (106, 66.00, 1, 0, 0, '发货测试', '13800138002', '发货测试地址', '2026-06-23 10:03:43', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (107, 77.00, 1, 0, 0, '配送费测试', '13800138003', '配送费测试地址', '2026-06-23 10:03:43', 1, NULL, NULL, NULL, 8.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (109, 100.00, 2, 0, 0, '测试收件人', '13800138000', '测试地址', '2026-06-23 10:04:18', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (110, 88.00, 1, 0, 0, '详情测试', '13800138001', '详情测试地址', '2026-06-23 10:04:18', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (111, 66.00, 1, 1, 0, '发货测试', '13800138002', '发货测试地址', '2026-06-23 10:04:19', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (113, 50.00, 1, 0, 0, '删除测试', '13800138004', '删除测试地址', '2026-06-23 10:04:19', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (114, 100.00, 2, 0, 0, '测试收件人', '13800138000', '测试地址', '2026-06-23 10:04:43', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (116, 66.00, 1, 0, 0, '发货测试', '13800138002', '发货测试地址', '2026-06-23 10:04:44', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (117, 77.00, 1, 0, 0, '配送费测试', '13800138003', '配送费测试地址', '2026-06-23 10:04:44', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (118, 50.00, 1, 0, 0, '删除测试', '13800138004', '删除测试地址', '2026-06-23 10:04:44', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (119, 100.00, 2, 1, 0, '测试收件人', '13800138000', '测试地址', '2026-06-23 10:05:04', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (120, 88.00, 1, 0, 0, '详情测试', '13800138001', '详情测试地址', '2026-06-23 10:05:04', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (121, 66.00, 1, 0, 0, '发货测试', '13800138002', '发货测试地址', '2026-06-23 10:05:04', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (122, 77.00, 1, 0, 0, '配送费测试', '13800138003', '配送费测试地址', '2026-06-23 10:05:04', 1, NULL, NULL, NULL, 8.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (124, 100.00, 2, 0, 0, '测试收件人', '13800138000', '测试地址', '2026-06-23 10:05:15', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (125, 88.00, 1, 0, 0, '详情测试', '13800138001', '详情测试地址', '2026-06-23 10:05:15', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (127, 77.00, 1, 0, 0, '配送费测试', '13800138003', '配送费测试地址', '2026-06-23 10:05:16', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (128, 50.00, 1, 0, 0, '删除测试', '13800138004', '删除测试地址', '2026-06-23 10:05:16', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (129, 100.00, 2, 0, 0, '测试收件人', '13800138000', '测试地址', '2026-06-23 10:05:46', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (130, 88.00, 1, 0, 0, '详情测试', '13800138001', '详情测试地址', '2026-06-23 10:05:46', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (131, 66.00, 1, 1, 0, '发货测试', '13800138002', '发货测试地址', '2026-06-23 10:05:46', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (133, 50.00, 1, 0, 0, '删除测试', '13800138004', '删除测试地址', '2026-06-23 10:05:47', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (134, 100.00, 2, 0, 0, '测试收件人', '13800138000', '测试地址', '2026-06-23 10:06:01', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (135, 88.00, 1, 1, 0, '详情测试', '13800138001', '详情测试地址', '2026-06-23 10:06:01', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (136, 66.00, 1, 0, 0, '发货测试', '13800138002', '发货测试地址', '2026-06-23 10:06:01', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (138, 50.00, 1, 0, 0, '删除测试', '13800138004', '删除测试地址', '2026-06-23 10:06:02', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (139, 100.00, 2, 0, 0, '测试收件人', '13800138000', '测试地址', '2026-06-23 10:06:11', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (140, 88.00, 1, 0, 0, '详情测试', '13800138001', '详情测试地址', '2026-06-23 10:06:12', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (142, 77.00, 1, 0, 0, '配送费测试', '13800138003', '配送费测试地址', '2026-06-23 10:06:12', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (143, 50.00, 1, 0, 0, '删除测试', '13800138004', '删除测试地址', '2026-06-23 10:06:12', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (144, 100.00, 2, 1, 0, '测试收件人', '13800138000', '测试地址', '2026-06-23 10:06:46', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (145, 88.00, 1, 0, 0, '详情测试', '13800138001', '详情测试地址', '2026-06-23 10:06:46', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (146, 66.00, 1, 0, 0, '发货测试', '13800138002', '发货测试地址', '2026-06-23 10:06:46', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (148, 50.00, 1, 0, 0, '删除测试', '13800138004', '删除测试地址', '2026-06-23 10:06:47', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (149, 100.00, 2, 0, 0, '测试收件人', '13800138000', '测试地址', '2026-06-23 10:08:21', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (150, 88.00, 1, 0, 0, '详情测试', '13800138001', '详情测试地址', '2026-06-23 10:08:21', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (151, 66.00, 1, 1, 0, '发货测试', '13800138002', '发货测试地址', '2026-06-23 10:08:22', 1, NULL, NULL, NULL, 8.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (152, 77.00, 1, 0, 0, '配送费测试', '13800138003', '配送费测试地址', '2026-06-23 10:08:22', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (154, 100.00, 2, 1, 0, '测试收件人', '13800138000', '测试地址', '2026-06-23 10:09:15', 1, 1, 'Rider Zhang', '13800138001', 5.00, '2026-06-23 10:37:59', NULL, NULL);
INSERT INTO `order` VALUES (155, 88.00, 1, 1, 0, '详情测试', '13800138001', '详情测试地址', '2026-06-23 10:09:15', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (156, 66.00, 1, 0, 0, '发货测试', '13800138002', '发货测试地址', '2026-06-23 10:09:15', 1, NULL, NULL, NULL, 5.00, NULL, NULL, NULL);
INSERT INTO `order` VALUES (157, 77.00, 1, 3, 0, '配送费测试', '13800138003', '配送费测试地址', '2026-06-23 10:09:16', 1, 1, 'Rider Zhang', '13800138001', 8.00, '2026-06-23 10:15:38', '2026-06-23 10:38:03', NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 130 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '骑手表' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_config
-- ----------------------------
INSERT INTO `system_config` VALUES (1, 'default_delivery_fee', '5.00', '默认配送费', '新订单的默认配送费金额（元）', '2026-06-17 19:53:51', '2026-06-23 09:02:23');
INSERT INTO `system_config` VALUES (2, 'stock_warning_threshold', '10', '库存预警阈值', '库存低于此数量时触发预警', '2026-06-17 19:55:06', '2026-06-17 19:55:06');
INSERT INTO `system_config` VALUES (4, 'log_clean_last_date', '2026-06-23', '日志清理最后执行日期', '记录上次执行日志清理的日期，用于确保每天只执行一次', '2026-06-23 09:02:23', '2026-06-23 09:04:15');

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
) ENGINE = InnoDB AUTO_INCREMENT = 46 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', '123456', '管理员', 'admin@vilicode.com', '1333333388', '中国北京市', b'1', b'0');
INSERT INTO `user` VALUES (2, 'vili', '654321', '普通用户', 'vili@vilicode.com', '1344444444', '中国福建省', b'1', b'0');
INSERT INTO `user` VALUES (3, 'admin1', '123456', '张三', '1214325@qq.com', '13800000000', '上海市浦东新区', b'0', b'0');
INSERT INTO `user` VALUES (9, '325346', '123456', '普通用户', 'vili@vilicode.com', '1344444444', '中国福建省', b'0', b'0');

SET FOREIGN_KEY_CHECKS = 1;
