/*
 Navicat Premium Data Transfer

 Source Server         : Localhost
 Source Server Type    : MySQL
 Source Server Version : 50717
 Source Host           : localhost
 Source Database       : cAuth

 Target Server Type    : MySQL
 Target Server Version : 50717
 File Encoding         : utf-8

 Date: 08/10/2017 22:22:52 PM

 5.5以下版本mysql需要修改的地方
 1、需要把utf8mb4改成utf8
 2、utf8mb4_unicode_ci 需要改成utf8_general_ci
 3、USING BTREE前面括号里面的内容移到USING BTREE后面(5.0以下版本)
 4、有多个timestamp且字段默认均为CURRENT_TIMESTAMP时会报错，解决方法是将
 其中一个改为datatime NOT NULL（5.5以下版本）
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `cSessionInfo`
-- ----------------------------
DROP TABLE IF EXISTS `cSessionInfo`;
CREATE TABLE `cSessionInfo` (
  `open_id` varchar(100) COLLATE utf8_general_ci NOT NULL,
  `uuid` varchar(100) COLLATE utf8_general_ci NOT NULL,
  `skey` varchar(100) COLLATE utf8_general_ci NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_visit_time` datetime NOT NULL,
  `session_key` varchar(100) COLLATE utf8_general_ci NOT NULL,
  `user_info` varchar(2048) COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`open_id`),
  KEY `openid` USING BTREE (`open_id`),
  KEY `skey` USING BTREE (`skey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='会话管理用户信息';

SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE `books` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `isbn` VARCHAR(20) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `openId` VARCHAR(50) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `title` VARCHAR(100) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `image` VARCHAR(100) COLLATE utf8_general_ci DEFAULT NULL,
  `alt` VARCHAR(100) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `publisher` VARCHAR(100) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `summary` VARCHAR(1000) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `price` VARCHAR(100) COLLATE utf8_general_ci DEFAULT NULL,
  `rate` FLOAT DEFAULT NULL,
  `tags` VARCHAR(100) COLLATE utf8_general_ci DEFAULT NULL,
  `author` VARCHAR(100) COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY USING BTREE (`id`)
) ENGINE=InnoDB
AUTO_INCREMENT=7 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT='InnoDB free: 3072 kB';


-- CREATE TABLE `comments` (
--   `id` int NOT NULL AUTO_INCREMENT,
--   `openId` VARCHAR(100) COLLATE utf8_general_ci NOT NULL DEFAULT '',
--   `bookid` VARCHAR(10) COLLATE utf8_general_ci NOT NULL DEFAULT '',
--   `comment` VARCHAR(200) COLLATE utf8_general_ci NOT NULL DEFAULT '',
--   `phone` VARCHAR(50) COLLATE utf8_general_ci DEFAULT '',
--   `location` VARCHAR(50) COLLATE utf8_general_ci DEFAULT '',
--   PRIMARY KEY USING BTREE (`id`)
-- );