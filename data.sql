/*
 Navicat Premium Data Transfer


 Target Server Type    : MySQL
 Target Server Version : 50727
 File Encoding         : 65001

 Date: 04/08/2021 11:30:46
*/

SET NAMES utf8mb4;
SET
FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for ltwlpb_ad_order
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_ad_order`;
CREATE TABLE `ltwlpb_ad_order`
(
    `id`         int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `orderno`    varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单编号',
    `user_id`    int(11) NOT NULL DEFAULT 0 COMMENT '用户id',
    `top_id`     int(11) NOT NULL DEFAULT 0 COMMENT '广告位id',
    `price`      decimal(10, 2)                                                NOT NULL DEFAULT 0.00 COMMENT '广告位价格',
    `num`        int(11) NULL DEFAULT 0 COMMENT '购买数量',
    `top_type`   tinyint(3) NOT NULL DEFAULT 0 COMMENT '置顶类型:0=首页,1=分类',
    `date_type`  tinyint(3) NOT NULL DEFAULT 0 COMMENT '日期类型:1=日,2=周,3=月',
    `date_nums`  int(10) NULL DEFAULT 0 COMMENT '日期数量',
    `start_time` timestamp NULL DEFAULT NULL,
    `end_time`   timestamp NULL DEFAULT NULL,
    `status`     tinyint(3) NOT NULL DEFAULT 0 COMMENT '订单状态:-1=已取消,0=待支付,1=已支付',
    `goods_id`   int(11) NOT NULL DEFAULT 0 COMMENT '商品id',
    `is_over`    tinyint(3) NOT NULL DEFAULT 0 COMMENT '是否过期:0=未过期,1=已过期',
    `is_del`     int(11) NOT NULL DEFAULT 0 COMMENT '是否删除',
    `zf_type`    varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '支付类型',
    `title`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '购买广告位名称',
    `is_wx_pay`  tinyint(3) NULL DEFAULT 0 COMMENT '是否是微信支付',
    `paid_at`    varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付日期',
    `site_id`    int(11) UNSIGNED NULL DEFAULT NULL,
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
    `updated_at` timestamp NULL DEFAULT NULL COMMENT '修改日期',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '广告位订单' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ltwlpb_ad_order
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_ad_top
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_ad_top`;
CREATE TABLE `ltwlpb_ad_top`
(
    `id`         int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `date_type`  tinyint(3) NULL DEFAULT 0 COMMENT '日期类型:1=日,2=周,3=月',
    `date_nums`  int(10) NULL DEFAULT 0 COMMENT '日期数量',
    `price`      decimal(10, 2) NULL DEFAULT NULL COMMENT '日期单价',
    `top_type`   tinyint(255) NULL DEFAULT 0 COMMENT '置顶类型:0=首页,1=分类',
    `content`    longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '内容',
    `is_del`     int(11) NULL DEFAULT 0,
    `site_id`    int(11) UNSIGNED NULL DEFAULT NULL,
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
    `updated_at` timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '广告位价格' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ltwlpb_ad_top
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_advert
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_advert`;
CREATE TABLE `ltwlpb_advert`
(
    `id`         int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `title`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `slug`       varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '标识',
    `images`     text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
    `order`      int(10) UNSIGNED NOT NULL DEFAULT 0,
    `site_id`    int(10) UNSIGNED NOT NULL,
    `updated_at` timestamp NULL DEFAULT NULL,
    `created_at` timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_advert
-- ----------------------------
INSERT INTO `ltwlpb_advert`
VALUES (1, '转发默认图(尺寸：100px*100px)', 'default_images', '[\"home/images/logo.png\"]', 0, 1, NULL, NULL);
INSERT INTO `ltwlpb_advert`
VALUES (2, '拍卖规则图(宽度最小750px)', 'auction_rule', '[\"home/images/process.png\"]', 0, 1, NULL, NULL);
INSERT INTO `ltwlpb_advert`
VALUES (3, '店铺升级对比图(宽度最小750px)', 'shops_upgrade', '[\"home/images/upgrade.png\"]', 0, 1, NULL, NULL);
INSERT INTO `ltwlpb_advert`
VALUES (4, '转发背景图(尺寸：500px*800px)', 'forwarding_background', '[\"home/images/bg.jpg\"]', 0, 1, '2020-12-24 11:33:07',
        NULL);
INSERT INTO `ltwlpb_advert`
VALUES (5, '公众号二维码(尺寸：750*350)', 'qrcode_photo', '[\"home/images/focus.png\"]', 0, 1, NULL, NULL);

-- ----------------------------
-- Table structure for ltwlpb_after_sale
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_after_sale`;
CREATE TABLE `ltwlpb_after_sale`
(
    `id`             int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id`        int(10) NULL DEFAULT NULL COMMENT '用户id',
    `goods_shop_id`  int(10) NULL DEFAULT NULL COMMENT '商户id',
    `apply`          text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '申请原因',
    `images`         text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '上传的附件',
    `goods_order_id` int(10) NULL DEFAULT NULL COMMENT '订单id',
    `status`         int(1) NULL DEFAULT NULL COMMENT '状态：0=>申请，1=>已回复，2=>处理中，3=>已结束',
    `site_id`        int(10) UNSIGNED NULL DEFAULT NULL COMMENT '站点id',
    `reply`          varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '卖家回复',
    `type`           int(1) NULL DEFAULT 1 COMMENT '1退货，2投诉',
    `express_name`   varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '快递名称',
    `express_code`   varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '快递号',
    `seller_name`    varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `seller_phone`   varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `seller_address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `created_at`     timestamp NULL DEFAULT NULL,
    `updated_at`     timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_after_sale
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_article
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_article`;
CREATE TABLE `ltwlpb_article`
(
    `id`              int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `title`           varchar(88) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `article_type_id` int(2) NULL DEFAULT NULL,
    `content`         mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '简介',
    `site_id`         int(10) NULL DEFAULT NULL,
    `created_at`      timestamp NULL DEFAULT NULL,
    `updated_at`      timestamp NULL DEFAULT NULL,
    `cover`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文章封面',
    `order`           int(11) NULL DEFAULT 0,
    `views`           int(10) NULL DEFAULT 0 COMMENT '浏览次数',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_article
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_article_type
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_article_type`;
CREATE TABLE `ltwlpb_article_type`
(
    `id`         int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `name`       varchar(88) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `site_id`    int(10) NULL DEFAULT NULL,
    `created_at` timestamp NULL DEFAULT NULL,
    `updated_at` timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_article_type
-- ----------------------------
INSERT INTO `ltwlpb_article_type`
VALUES (1, '人文', 1, '2019-08-06 08:41:29', '2019-08-06 08:41:44');
INSERT INTO `ltwlpb_article_type`
VALUES (2, '山水', 1, '2019-08-06 08:41:55', '2019-08-06 08:41:55');
INSERT INTO `ltwlpb_article_type`
VALUES (3, '历史', 1, '2019-08-06 15:26:20', '2019-08-06 15:26:20');
INSERT INTO `ltwlpb_article_type`
VALUES (4, '社会', 1, '2019-08-06 15:26:36', '2019-08-06 15:26:36');
INSERT INTO `ltwlpb_article_type`
VALUES (5, '书画', 1, '2019-08-06 15:27:01', '2020-05-29 11:53:20');

-- ----------------------------
-- Table structure for ltwlpb_assemble_order
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_assemble_order`;
CREATE TABLE `ltwlpb_assemble_order`
(
    `id`            int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `serial_number` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '订单号',
    `goods_user_id` int(10) NULL DEFAULT NULL,
    `user_id`       int(10) NULL DEFAULT NULL,
    `goods_id`      int(10) NULL DEFAULT NULL,
    `price`         decimal(10, 2) NULL DEFAULT NULL,
    `status`        int(1) NULL DEFAULT NULL,
    `refundtime`    varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '退款时间',
    `site_id`       int(10) NULL DEFAULT NULL,
    `created_at`    timestamp NULL DEFAULT NULL,
    `updated_at`    timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_assemble_order
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_auth
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_auth`;
CREATE TABLE `ltwlpb_auth`
(
    `auth_id`     bigint(100) NOT NULL AUTO_INCREMENT,
    `auth_name`   varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `auth_pid`    int(11) NULL DEFAULT NULL,
    `module_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `auth_c`      varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `auth_a`      varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `is_menu`     int(11) NULL DEFAULT NULL,
    `style`       varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `auth_sort`   int(11) NULL DEFAULT 0,
    `site_id`     int(11) NULL DEFAULT NULL,
    `created_at`  timestamp NULL DEFAULT NULL,
    `updated_at`  timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`auth_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ltwlpb_auth
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_authenticate_belong
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_authenticate_belong`;
CREATE TABLE `ltwlpb_authenticate_belong`
(
    `id`         int(10) NOT NULL AUTO_INCREMENT,
    `name`       varchar(125) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '分类名称',
    `icon`       varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图标',
    `sort`       int(10) NOT NULL DEFAULT 0 COMMENT '排序越大越靠前',
    `site_id`    int(5) NOT NULL COMMENT '站点',
    `created_at` timestamp NULL DEFAULT NULL,
    `updated_at` timestamp NULL DEFAULT NULL,
    `status`     tinyint(1) NOT NULL DEFAULT 1 COMMENT '1正常2隐藏',
    `is_index`   tinyint(1) NOT NULL DEFAULT 1 COMMENT '1首页显示2首页不显示',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '鉴定订单归属类别' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ltwlpb_authenticate_belong
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_authenticate_classify
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_authenticate_classify`;
CREATE TABLE `ltwlpb_authenticate_classify`
(
    `id`         int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `classify`   varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '鉴定类型',
    `memo`       varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '类型备注',
    `price`      decimal(10, 1) NOT NULL DEFAULT 0.0 COMMENT '鉴定费用',
    `order`      int(10) UNSIGNED NULL DEFAULT 0 COMMENT '排序',
    `site_id`    int(10) NULL DEFAULT NULL,
    `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
    `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '鉴定类型' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ltwlpb_authenticate_classify
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_authenticate_order
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_authenticate_order`;
CREATE TABLE `ltwlpb_authenticate_order`
(
    `id`               int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `serial_number`    varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单号',
    `desc`             text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
    `user_id`          int(10) UNSIGNED NULL DEFAULT 0 COMMENT '购买者id',
    `zjuser_id`        int(10) NOT NULL DEFAULT 0 COMMENT '专家uid',
    `title`            varchar(125) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标题',
    `goods_type_id`    int(10) NULL DEFAULT NULL,
    `is_gongkai`       int(1) UNSIGNED NULL DEFAULT 1 COMMENT '是否公开，1是0否',
    `images`           text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '图片',
    `phone`            varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `jian_title`       varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `jian_type`        int(10) NULL DEFAULT 1 COMMENT '鉴定类型',
    `actual_money`     decimal(10, 2) NULL DEFAULT NULL,
    `price`            decimal(10, 2) NULL DEFAULT NULL COMMENT '支付价格',
    `paid_at`          varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付时间',
    `advise`           text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '意见',
    `evaluation_price` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '估价',
    `is_really`        int(1) NULL DEFAULT 0 COMMENT '0 => \' 未鉴定\', 1 => \' 真品\',         2 => \' 存疑\', 3 => \' 赝品\'',
    `status`           tinyint(4) NULL DEFAULT 0 COMMENT '-1 => \' 交易关闭\',0  => \' 待支付\', 1  => \' 已支付，待鉴定\', 2  => \' 鉴定完成\',',
    `virtual_order`    int(1) NULL DEFAULT 0 COMMENT '是否为虚拟订单',
    `is_wx_pay`        int(1) NULL DEFAULT 1 COMMENT '是否微信支付，1是0否',
    `zf_type`          varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `is_zj`            tinyint(1) NULL DEFAULT 0 COMMENT '等于1，专家鉴定',
    `site_id`          int(10) NULL DEFAULT NULL COMMENT '站点',
    `created_at`       timestamp NULL DEFAULT NULL,
    `updated_at`       timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    INDEX              `zjuser_id`(`zjuser_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ltwlpb_authenticate_order
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_banner
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_banner`;
CREATE TABLE `ltwlpb_banner`
(
    `id`         int(10) NOT NULL AUTO_INCREMENT,
    `picture`    varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图片',
    `url`        varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '跳转地址',
    `slug`       varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标记',
    `order`      int(10) NULL DEFAULT 0 COMMENT '排序',
    `tz_type`    varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '跳转类型，1拍品，2文章，3店铺，4后台登录背景',
    `site_id`    int(10) NULL DEFAULT NULL COMMENT '站点id',
    `created_at` timestamp NULL DEFAULT NULL,
    `updated_at` timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_banner
-- ----------------------------
INSERT INTO `ltwlpb_banner`
VALUES (1, 'home/images/banner-1.jpg', '', 'home_banner', 0, NULL, 1, '2019-08-23 10:39:46', '2019-11-04 09:59:57');
INSERT INTO `ltwlpb_banner`
VALUES (2, 'home/images/banner-2.jpg', '', 'home_banner', 1, NULL, 1, '2019-08-23 10:40:17', '2019-11-04 09:59:47');
INSERT INTO `ltwlpb_banner`
VALUES (3, 'home/images/banner-1.jpg', '', 'type_banner', 0, NULL, 1, '2019-08-23 10:39:46', '2019-08-30 16:35:33');
INSERT INTO `ltwlpb_banner`
VALUES (4, 'home/images/banner-2.jpg', '', 'type_banner', 1, NULL, 1, '2019-08-23 10:40:17', '2019-08-30 16:35:20');
INSERT INTO `ltwlpb_banner`
VALUES (5, 'admin/banner/img/5.jpg', '', 'login_banner', 0, NULL, 1, '2020-12-04 09:41:48', '2020-12-04 09:41:48');

-- ----------------------------
-- Table structure for ltwlpb_bondorder
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_bondorder`;
CREATE TABLE `ltwlpb_bondorder`
(
    `id`              int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `serial_number`   varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单号',
    `refund_number`   varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `user_id`         int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户id',
    `goods_id`        int(10) NOT NULL,
    `sid`             int(10) UNSIGNED NOT NULL COMMENT '站点',
    `status`          tinyint(4) NOT NULL DEFAULT 0 COMMENT '状态：[-1:客户取消订单，0:未支付，1:已支付待发货，2:已发货待签收，3 =>已签收订单完成]',
    `paid_at`         varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
    `price`           varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `bond_price`      varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `refundtime`      int(10) NOT NULL COMMENT '退款时间',
    `zf_type`         varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
    `special_show_ib` int(10) NULL DEFAULT 0,
    `id_special_shob` int(10) NULL DEFAULT 0,
    `created_at`      timestamp NULL DEFAULT NULL,
    `updated_at`      timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_bondorder
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_browse
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_browse`;
CREATE TABLE `ltwlpb_browse`
(
    `id`         int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id`    int(10) NULL DEFAULT NULL COMMENT '浏览人',
    `goods_id`   int(10) NULL DEFAULT NULL,
    `date_at`    varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `site_id`    int(10) NULL DEFAULT NULL,
    `created_at` timestamp NULL DEFAULT NULL,
    `updated_at` timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_browse
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_commission_rate
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_commission_rate`;
CREATE TABLE `ltwlpb_commission_rate`
(
    `id`              int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `commission_rate` decimal(10, 2) UNSIGNED NULL DEFAULT NULL,
    `rate`            varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `xid`             int(10) UNSIGNED NULL DEFAULT 0,
    `site_id`         int(10) NULL DEFAULT NULL COMMENT '站点id',
    `created_at`      timestamp NULL DEFAULT NULL,
    `updated_at`      timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_commission_rate
-- ----------------------------
INSERT INTO `ltwlpb_commission_rate`
VALUES (1, 0.01, NULL, 1, 1, NULL, NULL);
INSERT INTO `ltwlpb_commission_rate`
VALUES (2, 0.03, NULL, 2, 1, NULL, NULL);
INSERT INTO `ltwlpb_commission_rate`
VALUES (3, 0.05, NULL, 3, 1, NULL, NULL);
INSERT INTO `ltwlpb_commission_rate`
VALUES (4, 0.10, NULL, 4, 1, NULL, NULL);
INSERT INTO `ltwlpb_commission_rate`
VALUES (5, 0.20, NULL, 5, 1, NULL, NULL);

-- ----------------------------
-- Table structure for ltwlpb_contents
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_contents`;
CREATE TABLE `ltwlpb_contents`
(
    `id`         int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `title`      varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '标题',
    `discount`   decimal(10, 2) NULL DEFAULT NULL COMMENT '概要',
    `content`    mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '简介',
    `xid`        int(10) NULL DEFAULT NULL,
    `site_id`    int(10) NULL DEFAULT NULL,
    `created_at` timestamp NULL DEFAULT NULL,
    `updated_at` timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_contents
-- ----------------------------
INSERT INTO `ltwlpb_contents`
VALUES (1, '用户隐私协议', NULL, '<p>请填写用户隐私协议</p>', 1, 1, '2020-05-14 12:18:14', '2020-05-14 12:18:44');
INSERT INTO `ltwlpb_contents`
VALUES (2, '商铺升级说明', NULL, '<p>请填写商铺升级说明</p>', 2, 1, '2020-05-14 12:18:21', '2020-09-17 11:09:20');
INSERT INTO `ltwlpb_contents`
VALUES (3, '帮助中心', NULL, '<p>请填写帮助中心</p>', 4, 1, '2020-05-14 12:18:21', '2020-05-14 12:19:04');
INSERT INTO `ltwlpb_contents`
VALUES (4, '拍品发布协议', NULL, '<p>请填写发布协议</p>', 5, 1, '2020-05-14 12:18:21', '2020-05-14 12:18:21');
INSERT INTO `ltwlpb_contents`
VALUES (5, '开通店铺协议', NULL, '<p>请填写店铺协议</p>', 6, 1, '2020-05-14 12:18:21', '2020-05-14 12:18:21');
INSERT INTO `ltwlpb_contents`
VALUES (6, '竞拍规则', NULL, '<p>请填写竞拍规则</p>', 8, 1, '2020-07-30 17:18:37', '2020-07-30 17:18:39');
INSERT INTO `ltwlpb_contents`
VALUES (7, '提现说明', NULL, '<p>提现手续费比例为0.6%</p>', 9, 1, '2020-06-11 18:43:28', '2020-07-07 10:58:24');
INSERT INTO `ltwlpb_contents`
VALUES (8, '用户注册协议', NULL, '<p>请填写用户注册协议</p>', 10, 1, '2020-07-30 15:45:37', '2021-03-19 20:30:33');

-- ----------------------------
-- Table structure for ltwlpb_custom_link
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_custom_link`;
CREATE TABLE `ltwlpb_custom_link`
(
    `id`           int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `name`         varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '分类名称',
    `url`          varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图标',
    `custom_links` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `site_id`      int(10) UNSIGNED NULL DEFAULT NULL,
    `created_at`   timestamp NULL DEFAULT NULL,
    `updated_at`   timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_custom_link
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_department
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_department`;
CREATE TABLE `ltwlpb_department`
(
    `id`         int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `name`       varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '部门',
    `site_id`    int(10) NULL DEFAULT NULL,
    `created_at` timestamp NULL DEFAULT NULL,
    `updated_at` timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_department
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_diamonds
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_diamonds`;
CREATE TABLE `ltwlpb_diamonds`
(
    `id`            int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `serial_number` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单号',
    `user_id`       int(10) UNSIGNED NULL DEFAULT 0 COMMENT '用户id',
    `status`        tinyint(4) NULL DEFAULT 0 COMMENT '状态：[-1:客户取消订单，0:未支付，1:已支付待发货，2:已发货待签收，3 =>已签收订单完成]',
    `paid_at`       timestamp NULL DEFAULT NULL,
    `price`         varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `level`         int(2) NULL DEFAULT NULL,
    `zf_type`       varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `sid`           int(10) UNSIGNED NULL DEFAULT NULL COMMENT '站点',
    `created_at`    timestamp NULL DEFAULT NULL,
    `updated_at`    timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_diamonds
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_employee
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_employee`;
CREATE TABLE `ltwlpb_employee`
(
    `id`            int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `name`          varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '姓名',
    `sex`           int(1) NULL DEFAULT 0,
    `phone`         varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `address`       varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `age`           varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `start_work`    varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `end_work`      varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `is_quit`       int(1) NULL DEFAULT 0,
    `work`          varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `department_id` int(10) NULL DEFAULT NULL,
    `site_id`       int(10) NULL DEFAULT NULL,
    `created_at`    timestamp NULL DEFAULT NULL,
    `updated_at`    timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_employee
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_evaluate_shops
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_evaluate_shops`;
CREATE TABLE `ltwlpb_evaluate_shops`
(
    `id`               int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id`          int(10) NULL DEFAULT NULL,
    `seller_id`        int(10) NULL DEFAULT NULL,
    `evaluate_word_id` int(10) NULL DEFAULT NULL,
    `order_id`         int(10) NULL DEFAULT NULL,
    `site_id`          int(10) NULL DEFAULT NULL,
    `created_at`       timestamp NULL DEFAULT NULL,
    `updated_at`       timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_evaluate_shops
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_evaluate_word
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_evaluate_word`;
CREATE TABLE `ltwlpb_evaluate_word`
(
    `id`         int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `name`       varchar(88) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `site_id`    int(10) NULL DEFAULT NULL,
    `created_at` timestamp NULL DEFAULT NULL,
    `updated_at` timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_evaluate_word
-- ----------------------------
INSERT INTO `ltwlpb_evaluate_word`
VALUES (1, '服务贴心', 1, '2019-07-23 15:55:26', '2019-07-23 15:57:51');
INSERT INTO `ltwlpb_evaluate_word`
VALUES (2, '值得信赖', 1, '2019-07-23 15:55:38', '2019-07-23 15:55:38');
INSERT INTO `ltwlpb_evaluate_word`
VALUES (3, '物超所值', 1, '2019-07-23 15:55:53', '2019-07-23 15:55:53');
INSERT INTO `ltwlpb_evaluate_word`
VALUES (4, '物流给力', 1, '2019-07-23 15:56:39', '2019-07-23 15:56:39');
INSERT INTO `ltwlpb_evaluate_word`
VALUES (5, '包装精美', 1, '2019-07-23 15:56:53', '2019-07-23 15:56:53');
INSERT INTO `ltwlpb_evaluate_word`
VALUES (6, '捡到漏了', 1, '2019-07-23 15:57:06', '2019-07-23 15:57:06');

-- ----------------------------
-- Table structure for ltwlpb_express
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_express`;
CREATE TABLE `ltwlpb_express`
(
    `id`         int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `name`       varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '快递名称',
    `code`       varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '快递公司编码',
    `site_id`    int(10) NULL DEFAULT NULL,
    `created_at` timestamp NULL DEFAULT NULL,
    `updated_at` timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_express
-- ----------------------------
INSERT INTO `ltwlpb_express`
VALUES (1, '顺丰速运', 'SF', 1, '2021-06-08 18:56:25', '2021-06-08 18:56:25');
INSERT INTO `ltwlpb_express`
VALUES (2, '百世快递', 'HTKY', 1, '2021-06-08 18:56:25', '2021-06-08 18:56:25');
INSERT INTO `ltwlpb_express`
VALUES (3, '中通快递', 'ZTO', 1, '2021-06-08 18:56:25', '2021-06-08 18:56:25');
INSERT INTO `ltwlpb_express`
VALUES (4, '申通快递', 'STO', 1, '2021-06-08 18:56:25', '2021-06-08 18:56:25');
INSERT INTO `ltwlpb_express`
VALUES (5, '圆通快递', 'YTO', 1, '2021-06-08 18:56:25', '2021-06-08 18:56:25');
INSERT INTO `ltwlpb_express`
VALUES (6, '韵达快递', 'YD', 1, '2021-06-08 18:56:25', '2021-06-08 18:56:25');
INSERT INTO `ltwlpb_express`
VALUES (7, '邮政快递', 'YZPY', 1, '2021-06-08 18:56:25', '2021-06-08 18:56:25');
INSERT INTO `ltwlpb_express`
VALUES (8, 'EMS', 'EMS', 1, '2021-06-08 18:56:25', '2021-06-08 18:56:25');
INSERT INTO `ltwlpb_express`
VALUES (9, '天天快递', 'HHTT', 1, '2021-06-08 18:56:25', '2021-06-08 18:56:25');
INSERT INTO `ltwlpb_express`
VALUES (10, '京东快递', 'JD', 1, '2021-06-08 18:56:25', '2021-06-08 18:56:25');
INSERT INTO `ltwlpb_express`
VALUES (11, '优速快递', 'UC', 1, '2021-06-08 18:56:25', '2021-06-08 18:56:25');
INSERT INTO `ltwlpb_express`
VALUES (12, '德邦快递', 'DBL', 1, '2021-06-08 18:56:25', '2021-06-08 18:56:25');
INSERT INTO `ltwlpb_express`
VALUES (13, '宅急送', 'ZJS', 1, '2021-06-08 18:56:25', '2021-06-08 18:56:25');

-- ----------------------------
-- Table structure for ltwlpb_goods
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_goods`;
CREATE TABLE `ltwlpb_goods`
(
    `id`                 int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `name`               varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商品名称',
    `brief`              text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '简介',
    `goods_type_id`      int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '商品类别 id',
    `images`             text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `user_id`            int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '卖家id',
    `buyuser_id`         int(10) NOT NULL DEFAULT 0 COMMENT '指定买家id',
    `start_price`        int(10) UNSIGNED NOT NULL DEFAULT 0,
    `each_add`           int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '加价幅度 （每次加价的数额）',
    `top_price`          int(10) UNSIGNED NULL DEFAULT 0 COMMENT '保底价（最高成交价）',
    `retain`             int(11) NULL DEFAULT 0 COMMENT '0元拍保底价',
    `likes`              int(10) UNSIGNED NULL DEFAULT 0,
    `views`              int(10) UNSIGNED NULL DEFAULT 0 COMMENT '浏览量',
    `stock_num`          int(10) UNSIGNED NOT NULL DEFAULT 1 COMMENT '库存数',
    `detail`             text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '商品详情',
    `order`              int(10) UNSIGNED NULL DEFAULT 0 COMMENT '排序（越大靠前）',
    `status`             tinyint(3) NOT NULL DEFAULT 0 COMMENT '状态（0:待审核，1：审核通过；-1：审核不通过）',
    `start_auction_time` timestamp NULL DEFAULT NULL COMMENT '拍卖开始时间',
    `cut_off_time`       timestamp NULL DEFAULT NULL COMMENT '下架时间（截止时间）',
    `is_need_bond`       int(10) NULL DEFAULT 0 COMMENT '是否需要保证金',
    `keyword`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关键字',
    `tag_id`             int(5) NULL DEFAULT 0 COMMENT '模块标识',
    `video`              varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `issale`             int(1) NULL DEFAULT 1 COMMENT '是否上架，0下架1上架',
    `excellent`          int(1) NULL DEFAULT NULL,
    `retail`             int(2) NULL DEFAULT NULL COMMENT '佣金',
    `service_charge`     decimal(10, 2) NULL DEFAULT NULL COMMENT '报价手续费',
    `people`             int(10) NULL DEFAULT 0 COMMENT '预拍人数',
    `price`              decimal(10, 2) NULL DEFAULT NULL COMMENT '拼团支付价格',
    `hours`              int(10) NULL DEFAULT 0 COMMENT '竞拍维持时间',
    `remaining_num`      int(10) NULL DEFAULT 0 COMMENT '拼团名额剩余数量',
    `postage`            int(1) NULL DEFAULT 0 COMMENT '是否包邮，1包邮',
    `postage_money`      decimal(10, 2) NULL DEFAULT NULL COMMENT '邮费',
    `is_delay`           int(1) NULL DEFAULT 0,
    `is_live`            int(1) NOT NULL DEFAULT 0 COMMENT '是否直播拍品',
    `live_status`        int(1) NOT NULL DEFAULT 0 COMMENT '直播状态，0未讲解1讲解中2已结束',
    `online_time`        int(10) NULL DEFAULT 5 COMMENT '直播内发布拍品竞拍时间',
    `special_show_id`    int(10) NULL DEFAULT 0 COMMENT '专场id',
    `isspecialshow`      int(1) NULL DEFAULT 0,
    `site_id`            int(10) UNSIGNED NOT NULL,
    `created_at`         timestamp NULL DEFAULT NULL,
    `updated_at`         timestamp NULL DEFAULT NULL,
    `delay_time`         int(5) NULL DEFAULT 0 COMMENT '出价延迟时间',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_goods
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_goods_orders
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_goods_orders`;
CREATE TABLE `ltwlpb_goods_orders`
(
    `id`                int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `serial_number`     varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单号',
    `goods_user_id`     int(10) NULL DEFAULT NULL COMMENT '商品卖家id',
    `user_id`           int(10) UNSIGNED NULL DEFAULT 0 COMMENT '购买者id',
    `goods_id`          int(10) UNSIGNED NULL DEFAULT 0 COMMENT '商品id',
    `images`            text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '图片',
    `goods_title`       varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '商品标题',
    `auctioner_price`   decimal(10, 2) UNSIGNED NULL DEFAULT NULL COMMENT '拍卖者支付价格',
    `commission`        varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `actual_money`      decimal(10, 2) NULL DEFAULT NULL,
    `price`             decimal(10, 2) NULL DEFAULT NULL COMMENT '支付价格',
    `paid_at`           varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付时间',
    `send_at`           varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发货时间',
    `confirm_at`        varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '确认收货时间',
    `auto_confirm_time` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '自动确认收货时间',
    `cut_off_time`      timestamp NULL DEFAULT NULL COMMENT '支付截止时间',
    `status`            tinyint(4) NULL DEFAULT 0 COMMENT '状态：[-2:订单未支付关闭，-1:客户取消订单，0:未支付，1:已支付待发货，2:已发货待签收，3:已签收订单完成]',
    `s_name`            varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收货姓名',
    `s_phone`           varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收货电话',
    `s_address`         varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收货详细地址',
    `express_code`      varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '快递单号',
    `express_name`      varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '快递名称',
    `commission_rate`   varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单佣金比例',
    `share_parent_id`   int(11) NULL DEFAULT 0 COMMENT '买家上级',
    `share_money`       varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分享佣金',
    `virtual_order`     int(1) NULL DEFAULT 0 COMMENT '是否为虚拟订单',
    `postage`           int(1) NULL DEFAULT 0 COMMENT '是否包邮，1是0否',
    `postage_money`     decimal(10, 2) NULL DEFAULT NULL COMMENT '邮费',
    `express_id`        int(11) NULL DEFAULT 0 COMMENT '快递id',
    `is_wx_pay`         int(1) NULL DEFAULT 1 COMMENT '是否微信支付，1是0否',
    `is_no_express`     int(1) NULL DEFAULT 0 COMMENT '是否无需物流',
    `refundtime`        varchar(65) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '退货退款时间',
    `toast_num`         int(11) NULL DEFAULT 2 COMMENT '自动收货通知次数',
    `is_sale`           varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '是否售后',
    `is_delete`         varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0',
    `zf_type`           varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `is_complete`       varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '是否退完所有保证金',
    `special_show_is`   int(1) NULL DEFAULT 0,
    `id_special_show`   int(10) NULL DEFAULT NULL,
    `site_id`           int(10) NOT NULL COMMENT '站点',
    `created_at`        timestamp NULL DEFAULT NULL,
    `updated_at`        timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_goods_orders
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_goods_tag
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_goods_tag`;
CREATE TABLE `ltwlpb_goods_tag`
(
    `goods_id`   int(10) UNSIGNED NOT NULL,
    `tag_id`     int(10) UNSIGNED NOT NULL,
    `site_id`    int(10) UNSIGNED NOT NULL,
    `created_at` timestamp NULL DEFAULT NULL,
    `updated_at` timestamp NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_goods_tag
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_goods_type
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_goods_type`;
CREATE TABLE `ltwlpb_goods_type`
(
    `id`           int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `pid`          int(10) NULL DEFAULT NULL,
    `name`         varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '分类名称',
    `url`          varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图标',
    `urltwo`       varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `order`        int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序（越大靠前）',
    `specialfield` int(1) NULL DEFAULT 0 COMMENT '是否首页专场',
    `site_id`      int(10) UNSIGNED NOT NULL,
    `created_at`   timestamp NULL DEFAULT NULL,
    `updated_at`   timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_goods_type
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_integral
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_integral`;
CREATE TABLE `ltwlpb_integral`
(
    `id`         int(11) NOT NULL AUTO_INCREMENT,
    `title`      varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `desc`       varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `image`      varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `integral`   int(11) NOT NULL,
    `xid`        int(1) NOT NULL,
    `site_id`    int(11) NOT NULL,
    `created_at` timestamp NULL DEFAULT NULL,
    `updated_at` timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ltwlpb_integral
-- ----------------------------
INSERT INTO `ltwlpb_integral`
VALUES (1, '订单支付获取积分', '完成订单，获取相应积分(比例)', 'home/images/cart.png', 1, 1, 1, '2020-02-26 11:57:40',
        '2020-02-26 12:02:04');
INSERT INTO `ltwlpb_integral`
VALUES (2, '邀请用户获取积分', '邀请新用户，且新用户完善个人信息', 'home/images/invite.png', 100, 2, 1, '2020-02-26 11:58:41',
        '2020-04-16 20:38:03');
INSERT INTO `ltwlpb_integral`
VALUES (3, '填写资料获取积分', '完善个人资料获得积分', 'home/images/phone.png', 100, 3, 1, '2020-02-26 11:58:55', '2020-04-16 20:38:34');
INSERT INTO `ltwlpb_integral`
VALUES (4, '签到获取积分', '每天在个人中心签到，获取积分', 'home/images/invite.png', 50, 4, 1, '2020-03-20 14:07:53',
        '2020-03-24 01:02:19');

-- ----------------------------
-- Table structure for ltwlpb_integral_goods
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_integral_goods`;
CREATE TABLE `ltwlpb_integral_goods`
(
    `id`            int(11) NOT NULL AUTO_INCREMENT,
    `name`          varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商品名称',
    `goods_type_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '商品类别 id',
    `images`        text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `detail`        text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '商品详情',
    `issale`        int(1) NULL DEFAULT 1 COMMENT '是否上架，0下架1上架',
    `marker_price`  decimal(10, 2) NULL DEFAULT NULL COMMENT '市场价格',
    `price`         decimal(10, 2)                                                NOT NULL,
    `integral`      int(11) NULL DEFAULT 0 COMMENT '所需积分',
    `number`        int(11) NOT NULL,
    `stock`         int(11) NOT NULL DEFAULT 1,
    `site_id`       int(11) NULL DEFAULT NULL,
    `created_at`    timestamp NULL DEFAULT NULL,
    `updated_at`    timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ltwlpb_integral_goods
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_integral_goods_type
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_integral_goods_type`;
CREATE TABLE `ltwlpb_integral_goods_type`
(
    `id`         int(11) NOT NULL AUTO_INCREMENT,
    `name`       varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `pid`        int(11) NOT NULL DEFAULT 0,
    `url`        varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `site_id`    int(11) NULL DEFAULT NULL,
    `created_at` timestamp NULL DEFAULT NULL,
    `updated_at` timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ltwlpb_integral_goods_type
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_integral_orders
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_integral_orders`;
CREATE TABLE `ltwlpb_integral_orders`
(
    `id`                int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `serial_number`     varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NOT NULL COMMENT '订单号',
    `user_id`           int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '购买者id',
    `goods_id`          int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '商品id',
    `integral`          int(11) NOT NULL,
    `images`            text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '图片',
    `goods_title`       varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '商品标题',
    `price`             decimal(10, 2)                                                NOT NULL COMMENT '支付价格',
    `paid_at`           varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付时间',
    `send_at`           varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发货时间',
    `confirm_at`        varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '确认收货时间',
    `auto_confirm_time` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '自动确认收货时间',
    `status`            tinyint(4) NOT NULL DEFAULT 0 COMMENT '状态：[-2:订单未支付关闭，-1:客户取消订单，0:未支付，1:已支付待发货，2:已发货待签收，3:已签收订单完成]',
    `cut_off_time`      timestamp                                                     NOT NULL COMMENT '支付截止时间',
    `s_name`            varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收货人姓名',
    `s_phone`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收货人号码',
    `s_address`         varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收货人地址',
    `express_code`      varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '快递单号',
    `express_name`      varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '快递名称',
    `express_id`        int(11) NULL DEFAULT 0 COMMENT '快递id',
    `is_wx_pay`         int(1) NULL DEFAULT 1 COMMENT '是否微信支付，1是0否',
    `is_no_express`     int(1) NULL DEFAULT 0 COMMENT '是否无需物流，1是0否',
    `remarks`           text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '备注',
    `site_id`           int(11) NULL DEFAULT NULL,
    `zf_type`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'xcx,wx,ye,zfb',
    `created_at`        timestamp NULL DEFAULT NULL,
    `updated_at`        timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ltwlpb_integral_orders
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_key_word
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_key_word`;
CREATE TABLE `ltwlpb_key_word`
(
    `id`         int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `name`       varchar(88) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `number`     int(1) NULL DEFAULT NULL,
    `site_id`    int(10) NULL DEFAULT NULL,
    `created_at` timestamp NULL DEFAULT NULL,
    `updated_at` timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_key_word
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_key_word_replace
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_key_word_replace`;
CREATE TABLE `ltwlpb_key_word_replace`
(
    `id`           int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `name`         varchar(88) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `default_name` varchar(88) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `xid`          int(10) NULL DEFAULT 0,
    `site_id`      int(10) NULL DEFAULT NULL,
    `created_at`   timestamp NULL DEFAULT NULL,
    `updated_at`   timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_key_word_replace
-- ----------------------------
INSERT INTO `ltwlpb_key_word_replace`
VALUES (1, '拍品', '如：拍品推荐', 1, 1, '2019-10-26 17:50:26', '2019-10-30 15:04:43');
INSERT INTO `ltwlpb_key_word_replace`
VALUES (2, '竞拍', '如：正在竞拍', 2, 1, '2019-10-26 17:50:26', '2019-10-28 10:46:01');
INSERT INTO `ltwlpb_key_word_replace`
VALUES (3, '拍卖', '如：拍卖头条', 3, 1, '2019-10-26 17:50:26', '2019-10-28 10:45:51');
INSERT INTO `ltwlpb_key_word_replace`
VALUES (4, '起拍', '如：起拍价', 4, 1, '2019-10-26 17:50:26', '2019-10-28 10:45:11');
INSERT INTO `ltwlpb_key_word_replace`
VALUES (5, '参拍', '如：预约参拍', 5, 1, '2019-10-26 17:50:26', '2019-10-28 10:45:02');
INSERT INTO `ltwlpb_key_word_replace`
VALUES (6, '开拍', '如：满x人开拍', 6, 1, '2019-10-26 17:50:26', '2019-10-28 10:44:50');
INSERT INTO `ltwlpb_key_word_replace`
VALUES (7, '直播', '如：直播拍场', 7, 1, '2020-09-27 18:16:05', '2020-09-27 18:16:05');

-- ----------------------------
-- Table structure for ltwlpb_like_comment
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_like_comment`;
CREATE TABLE `ltwlpb_like_comment`
(
    `id`         int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `comment_id` int(10) NULL DEFAULT NULL COMMENT '评论id',
    `user_id`    int(10) NULL DEFAULT NULL,
    `goods_num`  int(1) NULL DEFAULT NULL COMMENT '点赞数量',
    `type`       int(10) NULL DEFAULT NULL COMMENT '类型，1喜欢2不喜欢',
    `site_id`    int(10) NULL DEFAULT NULL,
    `created_at` timestamp NULL DEFAULT NULL,
    `updated_at` timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_like_comment
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_like_goods
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_like_goods`;
CREATE TABLE `ltwlpb_like_goods`
(
    `id`         int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `goods_id`   int(10) NOT NULL COMMENT '商品id',
    `user_id`    int(10) NOT NULL,
    `images`     varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户图像',
    `goods_num`  int(10) NOT NULL COMMENT '点赞数量',
    `type`       int(10) NOT NULL COMMENT '类型，1点赞2关注',
    `site_id`    int(10) NOT NULL,
    `created_at` timestamp NULL DEFAULT NULL,
    `updated_at` timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_like_goods
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_live_apply
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_live_apply`;
CREATE TABLE `ltwlpb_live_apply`
(
    `id`                        int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `user_id`                   int(10) NULL DEFAULT NULL COMMENT '申请人',
    `apply_reason`              text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '申请原因',
    `type`                      int(1) NULL DEFAULT 1 COMMENT '申请直播类型，1阿里云',
    `status`                    int(1) NULL DEFAULT 0 COMMENT '申请状态，2拒绝0未审核，1审核通过',
    `appname`                   varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `streamname`                varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `t_address`                 varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `l_address`                 varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `l_address_origin`          varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '拉流地址正常',
    `l_address_lhd`             varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '拉流地址高清',
    `l_address_lld`             varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '拉流地址流畅',
    `l_address_lsd`             varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '拉流地址标清',
    `l_address_lud`             varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '拉流地址超清',
    `tencent_push_address`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '腾讯云快直播播流地址',
    `tencent_pull_address`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '腾讯云快直播拉流地址',
    `tencent_pull_rtmp_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '腾讯云rtmp拉流地址',
    `tencent_pull_hls_address`  varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '腾讯云hls拉流地址',
    `yy_room_number`            varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'yy直播房间号',
    `serial_number`             varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '直播申请付费订单号',
    `zb_price`                  varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '直播申请价格',
    `zf_type`                   varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `price`                     varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '已支付的价格',
    `pay_status`                varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '支付状态，1已支付，0未支付',
    `pay_time`                  varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付时间',
    `site_id`                   int(10) NULL DEFAULT NULL COMMENT '站点',
    `created_at`                timestamp NULL DEFAULT NULL,
    `updated_at`                timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_live_apply
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_live_room
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_live_room`;
CREATE TABLE `ltwlpb_live_room`
(
    `id`           int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `user_id`      int(10) NULL DEFAULT NULL COMMENT '申请人',
    `title`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标题',
    `picture`      varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '预告封面',
    `play_time`    datetime(0) NULL DEFAULT NULL COMMENT '开播时间',
    `play_summary` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '开播预告',
    `status`       int(1) NULL DEFAULT 0 COMMENT '当前直播状态，0未开始1正在直播2直播结束',
    `order`        int(10) NULL DEFAULT 0 COMMENT '排序',
    `views`        int(10) UNSIGNED NULL DEFAULT 0 COMMENT '观看人数',
    `recommend`    int(10) NULL DEFAULT 0 COMMENT '是否推荐',
    `talks_id`     varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '群聊id',
    `site_id`      int(10) NULL DEFAULT NULL COMMENT '站点',
    `created_at`   timestamp NULL DEFAULT NULL,
    `updated_at`   timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_live_room
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_manager
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_manager`;
CREATE TABLE `ltwlpb_manager`
(
    `mg_id`      int(11) NOT NULL AUTO_INCREMENT,
    `mg_name`    varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `real_name`  varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `photo`      varchar(180) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `sex`        int(1) NOT NULL DEFAULT 1,
    `mg_pwd`     varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `phone`      varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `email`      varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `site_id`    int(11) NULL DEFAULT NULL,
    `created_at` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NOT NULL,
    `updated_at` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NOT NULL,
    `mg_role_id` int(11) NULL DEFAULT NULL,
    PRIMARY KEY (`mg_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ltwlpb_manager
-- ----------------------------
INSERT INTO `ltwlpb_manager`
VALUES (1, 'admin', NULL, NULL, 1, 'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, 1, '2019-05-29 00:00:00',
        '2019-05-29 00:00:00', 1);
INSERT INTO `ltwlpb_manager`
VALUES (2, 'ltadmin', NULL, NULL, 1, 'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, 1, '2020-11-06 11:06:50',
        '2020-11-06 11:06:50', 1);

-- ----------------------------
-- Table structure for ltwlpb_messages
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_messages`;
CREATE TABLE `ltwlpb_messages`
(
    `id`             int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `seller_id`      int(10) NULL DEFAULT NULL COMMENT '卖家id',
    `user_id`        int(10) NULL DEFAULT NULL COMMENT '评论人',
    `avatar`         varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '提问者头像',
    `content`        varbinary(500) NULL DEFAULT NULL COMMENT '消息内容',
    `update_user_id` int(10) NULL DEFAULT NULL COMMENT '更新人id',
    `status`         int(1) NULL DEFAULT NULL COMMENT '0表示未回复，1表示已经回复',
    `type`           int(1) NULL DEFAULT NULL COMMENT '1标识卖家，2标识买家',
    `site_id`        int(10) UNSIGNED NULL DEFAULT NULL,
    `created_at`     timestamp NULL DEFAULT NULL,
    `updated_at`     timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_messages
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_nav
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_nav`;
CREATE TABLE `ltwlpb_nav`
(
    `id`             int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `title`          varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '导航标题',
    `desc`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '说明',
    `icon`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '默认图标',
    `icon_active`    varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '激活图标',
    `url`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '导航url',
    `order`          int(10) NULL DEFAULT 0 COMMENT '权重（排序）',
    `show`           int(1) NULL DEFAULT 0 COMMENT '是否显示',
    `xid`            int(10) NULL DEFAULT NULL COMMENT '标识',
    `type`           varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '类型',
    `is_custom_link` int(1) NULL DEFAULT 0 COMMENT '是否自定义链接',
    `site_id`        int(10) NOT NULL COMMENT '站点id',
    `created_at`     timestamp NULL DEFAULT NULL,
    `updated_at`     timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_nav
-- ----------------------------
INSERT INTO `ltwlpb_nav`
VALUES (1, '首页', NULL, 'home/images/navs/home.png', 'home/images/navs/home-active.png', '/pages/index/index', 0, 1, 1,
        '', 0, 1, '2021-06-08 18:56:25', '2021-06-08 18:56:25');
INSERT INTO `ltwlpb_nav`
VALUES (2, '分类', NULL, 'home/images/navs/category.png', 'home/images/navs/category-active.png', '/pages/goods/category',
        0, 1, 2, '', 0, 1, '2021-06-08 18:56:25', '2021-06-08 18:56:25');
INSERT INTO `ltwlpb_nav`
VALUES (3, '头条', NULL, 'home/images/navs/news.png', 'home/images/navs/news-active.png', '/pages/article/article', 0, 1,
        3, '', 0, 1, '2021-06-08 18:56:25', '2021-06-08 18:56:25');
INSERT INTO `ltwlpb_nav`
VALUES (4, '消息', NULL, 'home/images/navs/msg.png', 'home/images/navs/msg-active.png', '/pages/msg/msg', 0, 1, 4, 'msg',
        0, 13, '2021-06-08 18:56:25', '2021-06-08 18:56:25');
INSERT INTO `ltwlpb_nav`
VALUES (5, '发布', NULL, 'home/images/navs/upload.png', 'home/images/navs/upload-active.png', '/pages/upload/upload', 0,
        0, 5, 'upload', 0, 1, '2021-06-08 18:56:25', '2021-06-08 18:56:25');
INSERT INTO `ltwlpb_nav`
VALUES (6, '我的', NULL, 'home/images/navs/center.png', 'home/images/navs/center-active.png', '/pages/center/index', 0, 1,
        6, 'center', 0, 1, '2021-06-08 18:56:25', '2021-06-08 18:56:25');

-- ----------------------------
-- Table structure for ltwlpb_open_set
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_open_set`;
CREATE TABLE `ltwlpb_open_set`
(
    `id`                           int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `open_talk`                    int(1) NULL DEFAULT 1 COMMENT '是否开启咨询入口',
    `open_identify_talk`           int(1) NULL DEFAULT 0 COMMENT '是否开启认证卖家咨询入口',
    `open_identify_offer`          int(1) NULL DEFAULT 0 COMMENT '是否开启未认证卖家，拍品无法出价',
    `open_people_fee`              int(1) NULL DEFAULT 0 COMMENT '是否开启个人认证费用',
    `open_news`                    int(1) NULL DEFAULT 1 COMMENT '是否开启头条模块',
    `open_price_fee`               int(1) NULL DEFAULT 0 COMMENT '是否开启出价手续费',
    `open_zero_fb`                 int(1) NULL DEFAULT 0 COMMENT '是否开启前端0元起发布',
    `open_one_price`               int(1) NULL DEFAULT 0 COMMENT '是否开启前端一口价发布',
    `open_preview`                 int(1) NULL DEFAULT 1 COMMENT '是否开启前台发布预展功能',
    `open_notice_seller`           int(1) NULL DEFAULT 1 COMMENT '是否开启出价通知卖家',
    `open_deal_list`               int(1) NULL DEFAULT 1 COMMENT '是否开启首页成交记录展示',
    `open_find_employee`           int(1) NULL DEFAULT 0 COMMENT '是否开启员工查询功能',
    `open_special_offer`           int(1) NULL DEFAULT 0 COMMENT '是否开启自定义专栏',
    `open_goods_fee`               int(1) NULL DEFAULT 0 COMMENT '是否开启拍品免审核',
    `open_user_fee`                int(1) NULL DEFAULT 0 COMMENT '是否开启用户认证免审核',
    `open_shops_fee`               int(1) NULL DEFAULT 0 COMMENT '是否开启店铺认证免审核',
    `open_seller_center`           int(1) NULL DEFAULT 1 COMMENT '是否开启卖家中心入口',
    `open_activity`                int(1) NULL DEFAULT 0 COMMENT '是否特价活动模块',
    `open_assemble`                int(1) NULL DEFAULT 0 COMMENT '是否开启拼团',
    `open_can_release`             int(1) NULL DEFAULT 0 COMMENT '是否开启免认证发布',
    `open_p_link`                  int(1) NULL DEFAULT 0 COMMENT '是否开启转发活动链接',
    `open_perfect_infor`           int(1) NULL DEFAULT 0 COMMENT '是否开启出价前完善个人信息',
    `open_hide_name`               int(1) NULL DEFAULT 0 COMMENT '是否开启隐藏出价人头像和昵称',
    `open_wx_check`                int(1) NULL DEFAULT 0 COMMENT '是否开启小程序审核模式',
    `open_send_fans_infor`         int(1) NULL DEFAULT 0 COMMENT '是否开启上新品推送消息给粉丝',
    `open_reminder_time`           int(1) NULL DEFAULT 0 COMMENT '是否开启截拍剩余时间提醒',
    `open_payment_code`            int(1) NULL DEFAULT 0 COMMENT '是否开启提现上传收款码',
    `views_set`                    int(1) NULL DEFAULT 0 COMMENT '浏览量自增设置：0关，1开',
    `open_list_badge`              int(1) NULL DEFAULT 1 COMMENT '是否开启列表标签',
    `open_retain_set`              int(1) NULL DEFAULT 1 COMMENT '0元保底价开关：0是开，1是关',
    `open_new_theme`               int(1) NULL DEFAULT 0 COMMENT '是否启动新主题',
    `open_attention`               int(1) NULL DEFAULT 0 COMMENT '是否开启强制关注',
    `open_phone`                   int(1) NULL DEFAULT 0 COMMENT '是否开启强制手机登录',
    `open_delay`                   int(1) NULL DEFAULT 0 COMMENT '是否开启延迟拍卖',
    `open_xcxzb`                   tinyint(1) NULL DEFAULT 0 COMMENT '是否开启小程序直播推流',
    `open_tencent_udp`             int(1) NULL DEFAULT 0 COMMENT '是否开启腾讯云快直播通道',
    `open_wx_tencent_udp`          int(1) NULL DEFAULT 0 COMMENT '是否开启小程序快直播播放',
    `open_lives_view`              int(1) NULL DEFAULT 0 COMMENT '是否开启直播间浏览量自动增加',
    `open_wx_uid`                  int(1) NULL DEFAULT 0 COMMENT '是否开启微信体系开放平台账号绑定',
    `show_ended_goods`             int(1) NULL DEFAULT 0 COMMENT '是否显示已结束未下架拍品',
    `open_refresh_rule`            int(1) NULL DEFAULT NULL COMMENT '是否开启首页列表刷新机制',
    `open_jd_price`                int(1) NULL DEFAULT 0 COMMENT '是否开启jd价格时间显示',
    `open_expert_mode`             int(1) NULL DEFAULT 0 COMMENT '是否开启jd专家选择模式',
    `open_expert_apply`            int(1) NULL DEFAULT 0 COMMENT '是否开启前台jd专家申请入口',
    `open_expert_offline_order`    int(1) NULL DEFAULT 0 COMMENT '是否开启jd定专家线下约见入口',
    `open_expert_offline_msg`      int(1) NULL DEFAULT 0 COMMENT '是否显示jd专家设置的线下约见信息',
    `site_id`                      int(10) NULL DEFAULT NULL COMMENT '站点id',
    `created_at`                   timestamp NULL DEFAULT NULL,
    `updated_at`                   timestamp NULL DEFAULT NULL,
    `open_expert_withdraw_offline` int(1) NULL DEFAULT 0 COMMENT '是否开启专家提现上传收款码',
    `open_zc_upload`               int(1) NULL DEFAULT 0 COMMENT '是否开启专场拍品前台上传',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_open_set
-- ----------------------------
INSERT INTO `ltwlpb_open_set`
VALUES (1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, '2019-08-10 09:31:36', '2021-04-02 16:35:55', 0, 0);

-- ----------------------------
-- Table structure for ltwlpb_plugin
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_plugin`;
CREATE TABLE `ltwlpb_plugin`
(
    `id`         int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `xid`        int(10) NOT NULL COMMENT '标识',
    `value`      int(1) NOT NULL DEFAULT 0 COMMENT '值',
    `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
    `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE INDEX `xid`(`xid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_plugin
-- ----------------------------
INSERT INTO `ltwlpb_plugin`
VALUES (1, 1001, 1, '2020-04-21 15:55:54', '2020-04-21 15:55:56');
INSERT INTO `ltwlpb_plugin`
VALUES (2, 2001, 1, '2021-05-17 11:20:15', '2021-05-17 11:20:25');
INSERT INTO `ltwlpb_plugin`
VALUES (3, 3001, 1, '2021-05-17 11:20:15', '2021-05-17 11:20:25');
INSERT INTO `ltwlpb_plugin`
VALUES (4, 4001, 1, '2021-05-17 11:20:15', '2021-05-17 11:20:25');
INSERT INTO `ltwlpb_plugin`
VALUES (5, 5001, 1, '2021-05-17 11:20:15', '2021-05-17 11:20:25');
INSERT INTO `ltwlpb_plugin`
VALUES (6, 6001, 1, '2021-05-17 11:20:15', '2021-05-17 11:20:25');
INSERT INTO `ltwlpb_plugin`
VALUES (7, 7001, 1, '2021-05-17 11:20:15', '2021-05-17 11:20:25');
INSERT INTO `ltwlpb_plugin`
VALUES (8, 8001, 1, '2021-05-17 11:20:15', '2021-05-17 11:20:25');

-- ----------------------------
-- Table structure for ltwlpb_premium
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_premium`;
CREATE TABLE `ltwlpb_premium`
(
    `id`            int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `serial_number` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单号',
    `sid`           int(10) UNSIGNED NULL DEFAULT NULL COMMENT '站点',
    `status`        tinyint(4) NULL DEFAULT 0 COMMENT '状态：[-1:客户取消订单，0:未支付，1:已支付待发货，2:已发货待签收，3 =>已签收订单完成]',
    `paid_at`       timestamp NULL DEFAULT NULL,
    `price`         varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `user_id`       int(10) UNSIGNED NULL DEFAULT 0 COMMENT '用户id',
    `refundtime`    int(10) NULL DEFAULT NULL COMMENT '退款时间',
    `level`         int(2) NULL DEFAULT NULL,
    `zf_type`       varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `created_at`    timestamp NULL DEFAULT NULL,
    `updated_at`    timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_premium
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_preview_people
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_preview_people`;
CREATE TABLE `ltwlpb_preview_people`
(
    `id`         int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `goods_id`   int(10) NULL DEFAULT 0 COMMENT '预约商品id',
    `user_id`    int(10) NULL DEFAULT 0 COMMENT '预约人',
    `is_pay`     int(1) NULL DEFAULT 0 COMMENT '是否支付',
    `price`      decimal(10, 2) NULL DEFAULT NULL,
    `site_id`    int(10) UNSIGNED NULL DEFAULT NULL,
    `created_at` timestamp NULL DEFAULT NULL,
    `updated_at` timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_preview_people
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_price_offer
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_price_offer`;
CREATE TABLE `ltwlpb_price_offer`
(
    `id`         int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `goods_id`   int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '商品 id',
    `user_id`    int(10) UNSIGNED NOT NULL DEFAULT 0,
    `price`      int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '出价',
    `site_id`    int(10) UNSIGNED NULL DEFAULT NULL,
    `max_id`     int(2) NOT NULL COMMENT '是否最高，1是0否',
    `is_order`   varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '已生成订单',
    `created_at` timestamp NULL DEFAULT NULL,
    `updated_at` timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    INDEX        `user_id`(`user_id`) USING BTREE,
    INDEX        `goods_id`(`goods_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_price_offer
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_role
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_role`;
CREATE TABLE `ltwlpb_role`
(
    `role_id`          int(11) NOT NULL AUTO_INCREMENT,
    `role_name`        varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `role_auth_ids`    text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
    `role_auth_action` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
    `site_id`          int(11) NULL DEFAULT NULL,
    `created_at`       varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `updated_at`       varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ltwlpb_role
-- ----------------------------
INSERT INTO `ltwlpb_role`
VALUES (1, '超级管理员', NULL, NULL, 1, '2020-11-02 15:19:20', '2020-11-02 15:19:20');

-- ----------------------------
-- Table structure for ltwlpb_shops
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_shops`;
CREATE TABLE `ltwlpb_shops`
(
    `id`           int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id`      int(10) NULL DEFAULT NULL COMMENT '用户id',
    `level`        int(2) NULL DEFAULT NULL COMMENT '等级id',
    `auth_type`    int(1) NULL DEFAULT NULL COMMENT '认证类型',
    `bond_price`   decimal(10, 2) NULL DEFAULT NULL COMMENT '保证金金额',
    `shops_grade`  decimal(5, 2) UNSIGNED NULL DEFAULT 0.00 COMMENT '店铺评分',
    `fans_number`  int(10) NULL DEFAULT 0 COMMENT '粉丝数量',
    `images`       varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '营业执照',
    `company`      varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '公司名称',
    `identity`     varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '身份证',
    `store`        varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '店铺名称',
    `desc`         varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '店铺描述',
    `cover`        varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '店铺logo',
    `agreement`    int(1) NULL DEFAULT 0 COMMENT '是否同意店铺协议',
    `is_excellent` int(1) NULL DEFAULT 0 COMMENT '是否优店，1是0否',
    `site_id`      int(10) NULL DEFAULT 0,
    `created_at`   timestamp NULL DEFAULT NULL,
    `updated_at`   timestamp NULL DEFAULT NULL,
    `cut_off_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '店铺到期时间',
    `status`       int(11) NULL DEFAULT 1 COMMENT '1上架，2下架',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_shops
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_shops_level
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_shops_level`;
CREATE TABLE `ltwlpb_shops_level`
(
    `id`                int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `name`              varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '会员等级名称',
    `xid`               int(10) NULL DEFAULT NULL,
    `order`             int(10) UNSIGNED NULL DEFAULT 0 COMMENT '排序（越大靠前）',
    `goods_online_max`  int(10) UNSIGNED NULL DEFAULT 0 COMMENT '该等级发布的商品同时在线最大数量限制',
    `goods_online_hour` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '该等级发布的商品最大有效时长（小时）',
    `price`             decimal(10, 2) NULL DEFAULT NULL COMMENT '升级价格',
    `is_default`        tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '是否默认等级 0否1是',
    `score`             varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `excellent_num`     int(10) NULL DEFAULT NULL COMMENT '精选数量',
    `image`             varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `fans`              int(10) NULL DEFAULT NULL,
    `is_hidden`         varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '是否隐藏，1是0否',
    `site_id`           int(10) UNSIGNED NULL DEFAULT NULL,
    `bond_price`        decimal(10, 2) NULL DEFAULT NULL,
    `created_at`        timestamp NULL DEFAULT NULL,
    `updated_at`        timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_shops_level
-- ----------------------------
INSERT INTO `ltwlpb_shops_level`
VALUES (1, '普通店铺', 1, 0, 10, 12, 300.00, 1, '4.6', 0, 'home/images/v-1.png', 0, '0', 1, 1000.00, NULL, NULL);
INSERT INTO `ltwlpb_shops_level`
VALUES (2, '青铜店铺', 2, 0, 40, 24, 998.00, 0, '4.7', 2, 'home/images/v-2.png', 100, '0', 1, 2000.00, NULL, NULL);
INSERT INTO `ltwlpb_shops_level`
VALUES (3, '白银店铺', 3, 0, 60, 36, 2998.00, 0, '4.8', 4, 'home/images/v-3.png', 300, '0', 1, 3000.00, NULL, NULL);
INSERT INTO `ltwlpb_shops_level`
VALUES (4, '黄金店铺', 4, 0, 80, 48, 4998.00, 0, '4.8', 6, 'home/images/v-4.png', 600, '0', 1, 4000.00, NULL, NULL);
INSERT INTO `ltwlpb_shops_level`
VALUES (5, '钻石店铺', 5, 0, 100, 60, 6998.00, 0, '5', 10, 'home/images/v-5.png', 1000, '0', 1, 5000.00, NULL, NULL);

-- ----------------------------
-- Table structure for ltwlpb_shops_set
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_shops_set`;
CREATE TABLE `ltwlpb_shops_set`
(
    `id`              int(11) NOT NULL AUTO_INCREMENT,
    `n`               int(11) NULL DEFAULT NULL COMMENT 'n次订单未付款',
    `m`               int(11) NULL DEFAULT NULL COMMENT '保证金提高m元',
    `viewsone`        int(11) NULL DEFAULT 1 COMMENT '从x开始',
    `viewstwo`        int(11) NULL DEFAULT 10 COMMENT '到y结束',
    `min_live_view`   int(10) NULL DEFAULT 1000 COMMENT '最低访问量',
    `live_view_start` int(10) NULL DEFAULT 1 COMMENT '随机开始数字',
    `live_view_end`   int(10) NULL DEFAULT 10 COMMENT '随机结束数字',
    `site_id`         int(10) NULL DEFAULT NULL COMMENT '站点',
    `created_at`      timestamp NULL DEFAULT NULL,
    `updated_at`      timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_shops_set
-- ----------------------------
INSERT INTO `ltwlpb_shops_set`
VALUES (1, 10, 0, 1, 10, 1000, 1, 10, 1, '2020-04-27 14:46:23', '2020-04-27 14:46:23');

-- ----------------------------
-- Table structure for ltwlpb_site
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_site`;
CREATE TABLE `ltwlpb_site`
(
    `id`                     int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `uniacid`                int(10) UNSIGNED NOT NULL COMMENT '微擎系统公众号标识',
    `name`                   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '站点名称',
    `appid`                  varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '公众号appID',
    `appsecret`              varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '公众号AppSecret',
    `merchantid`             varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商户号id',
    `keys`                   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商户号支付密钥',
    `beoverduetime`          varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单支付时间',
    `chargemoney`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '提现手续费比例',
    `zjchargemoney`          char(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '专家提现手续费',
    `zjmin_money`            int(10) NOT NULL DEFAULT 10 COMMENT '专家最小提现申请金额',
    `zj_bg_image`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '专家详情背景图',
    `goodstip`               varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '鉴定商品描述提示',
    `pictip`                 varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '鉴定图片上传提示',
    `commission`             varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商家佣金比例',
    `share_title`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '自定义分享标题',
    `share_msg`              varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '默认微信分享信息',
    `min_people`             int(10) NULL DEFAULT 5 COMMENT '最小预展人数',
    `min_preview_time`       varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '10' COMMENT '最短预展时间',
    `home_item_num`          int(10) NULL DEFAULT 40 COMMENT '首页推荐拍品数量',
    `phone`                  varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '平台客服电话',
    `certificate_one`        varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '证书一',
    `certificate_two`        varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '证书二',
    `businessId`             varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '快递商户id',
    `apiKey`                 varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '快递apikey',
    `businessCode`           varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1002' COMMENT '快递鸟商户套餐编码,免费套餐1002，付费套餐8001',
    `mini_appid`             varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '小程序appID',
    `mini_appsecret`         varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '小程序AppSecret',
    `mini_old_id`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '小程序原始id',
    `automatic`              int(10) NULL DEFAULT 168 COMMENT '自动确认收货时间',
    `delayed_end`            int(10) NULL DEFAULT 5 COMMENT '拍品延迟结束（分钟）',
    `reminder`               int(10) NULL DEFAULT 2 COMMENT '截拍给粉丝提醒（小时）',
    `thirty_reminder`        int(10) NULL DEFAULT NULL COMMENT '截拍给粉丝第二次提醒（分钟）',
    `min_cz_money`           int(10) NULL DEFAULT 100 COMMENT '最小充值金额',
    `min_money`              int(10) NULL DEFAULT 10 COMMENT '最小提现金额',
    `mimc_sign`              varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '小米云消息App标识',
    `auth_time`              timestamp NULL DEFAULT '0000-00-00 00:00:00' COMMENT '授权时间',
    `auth_day`               int(10) NULL DEFAULT 0 COMMENT '授权间隔天数',
    `kfpt_appid`             varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '开放平台appid',
    `ali_appid`              varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `ali_regionid`           varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `ali_secret`             varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `t_domain`               varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `l_domain`               varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `tencent_push_domain`    varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `tencent_pull_domain`    varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `zb_type`                varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '2' COMMENT '直播类型，1阿里云，2yy，3花椒，4腾讯云快直播',
    `zb_money`               varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '直播价格',
    `tag_id`                 varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `zfb_app_id`             varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `zfb_rsaprivatekey`      text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
    `zfb_alipayrsapublickey` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
    `unidentify_num`         int(10) NULL DEFAULT 3 COMMENT '开启免认证发布后，未认证卖家发布拍品数量',
    `attention_photo`        varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `shop_share_bond`        varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商家所得的保证金比例',
    `cache_name`             varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '缓存相关',
    `offer_cache`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '出价缓存名称',
    `upload_days`            int(5) NULL DEFAULT 5 COMMENT '发布拍品可选天数，默认为5',
    `dx_id`                  varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '短信配置企业id',
    `dx_name`                varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '短信配置用户名',
    `dx_pwd`                 varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '短信配置密码',
    `jd_bt`                  varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `jd_zy`                  varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `jd_picture`             varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `jd_jsj`                 int(10) NULL DEFAULT 0,
    `jd_pingtai`             varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `jd_tip`                 varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '鉴定详情页底部提示',
    `goods_detail_line`      int(10) NULL DEFAULT 4 COMMENT '拍品详情页，描述默认显示行数，',
    `ad_top_num`             int(10) NULL DEFAULT NULL COMMENT '置顶广告数量',
    `zc_zftime`              int(10) NULL DEFAULT 7,
    `zc_tx_sx`               varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0.05',
    `zc_fx_title`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '专场列表分享标题',
    `zc_fx_desc`             varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '专场列表分享描述',
    `zc_fx_brief`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '专场内容分享描述',
    `zc_bzj_ts`              text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
    `created_at`             timestamp NULL DEFAULT NULL,
    `updated_at`             timestamp NULL DEFAULT NULL,
    `plugin_modules`         varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '当前权限',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_site
-- ----------------------------
INSERT INTO `ltwlpb_site`
VALUES (1, 1, '独立版测试', '', '', '', '', '36000', '0', '0', 10, NULL, NULL, NULL, '0', '', '', 10, '10', 40, '', '', '',
        '', '', '1002', '', '', NULL, 168, 5, 2, 30, 100, 10, '', '2021-01-01 00:00:00', 1, NULL, '', NULL, '', '', '',
        NULL, NULL, '1', NULL, NULL, NULL, NULL, NULL, 3, '', NULL, '', '', 5, NULL, NULL, NULL, NULL, NULL, NULL, 0,
        NULL, NULL, 4, NULL, 7, '0.05', NULL, NULL, NULL, NULL, '2020-01-01 00:00:00', '2020-01-01 00:00:00',
        'eyJ1aWQiOjAsInVzZXJuYW1lIjoiIiwiZ3JvdXBfaWQiOjAsImFjaWQiOjEsInVuaWFjaWQiOjEsInBsdWdpbiI6eyJwbHVnaW5femIiOjEsInBsdWdpbl9pbnQiOjEsInBsdWdpbl93YXAiOjEsInBsdWdpbl9qZCI6MSwicGx1Z2luX2FkIjoxLCJwbHVnaW5fc3AiOjEsInBsdWdpbl96YyI6MX19');

-- ----------------------------
-- Table structure for ltwlpb_special_show
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_special_show`;
CREATE TABLE `ltwlpb_special_show`
(
    `id`               int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `title`            varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '专场标题',
    `issales`          int(1) NULL DEFAULT 1,
    `picture`          varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图像',
    `bond`             decimal(10, 2) UNSIGNED NULL DEFAULT 0.00 COMMENT '保证金',
    `overtime_payment` int(10) NULL DEFAULT 48,
    `brokerage`        decimal(10, 2) NULL DEFAULT NULL COMMENT '佣金',
    `brokerage_two`    decimal(10, 2) NULL DEFAULT NULL,
    `views`            int(10) NULL DEFAULT 0,
    `order`            int(10) NULL DEFAULT 0,
    `start_time`       timestamp NULL DEFAULT NULL COMMENT '开始时间',
    `end_time`         timestamp NULL DEFAULT NULL COMMENT '结束时间',
    `site_id`          int(10) UNSIGNED NULL DEFAULT NULL,
    `created_at`       timestamp NULL DEFAULT NULL,
    `updated_at`       timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ltwlpb_special_show
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_staff
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_staff`;
CREATE TABLE `ltwlpb_staff`
(
    `id`         int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `avatar`     varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `username`   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '姓名',
    `mobile`     varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '手机号',
    `site_id`    int(10) UNSIGNED NOT NULL,
    `created_at` timestamp NULL DEFAULT NULL,
    `updated_at` timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_staff
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_tag
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_tag`;
CREATE TABLE `ltwlpb_tag`
(
    `id`             int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `title`          varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '标签名',
    `picture`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标签图标',
    `order`          int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序',
    `xid`            int(1) NULL DEFAULT NULL,
    `show`           int(1) NULL DEFAULT 0,
    `url`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '自定义链接地址',
    `is_custom_link` int(1) NULL DEFAULT 0 COMMENT '是否自定义链接',
    `site_id`        int(10) UNSIGNED NOT NULL,
    `created_at`     timestamp NULL DEFAULT NULL,
    `updated_at`     timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_tag
-- ----------------------------
INSERT INTO `ltwlpb_tag`
VALUES (1, '优店', 'home/images/tags/t_01.png', 4, 1, 1, NULL, 0, 1, '2019-07-19 09:00:05', '2021-06-03 13:03:45');
INSERT INTO `ltwlpb_tag`
VALUES (2, '0元起', 'home/images/tags/t_02.png', 2, 2, 1, NULL, 0, 1, '2019-07-19 09:00:57', '2021-04-25 15:59:54');
INSERT INTO `ltwlpb_tag`
VALUES (3, '一口价', 'home/images/tags/t_03.png', 1, 3, 1, NULL, 0, 1, '2021-06-03 13:03:42', '2021-06-03 13:03:42');
INSERT INTO `ltwlpb_tag`
VALUES (4, '精品', 'home/images/tags/t_04.png', 3, 4, 1, NULL, 0, 1, '2019-07-19 09:14:06', '2021-06-03 13:01:09');
INSERT INTO `ltwlpb_tag`
VALUES (5, '预展', 'home/images/tags/t_05.png', 1, 5, 1, NULL, 0, 1, '2019-07-19 09:02:15', '2021-06-03 13:03:39');
INSERT INTO `ltwlpb_tag`
VALUES (6, '专栏', 'home/images/tags/t_06.png', 0, 6, 1, NULL, 0, 1, '2019-08-27 16:47:16', '2021-06-03 13:04:52');
INSERT INTO `ltwlpb_tag`
VALUES (7, '资讯', 'home/images/tags/t_96.png', 0, 96, 1, NULL, 0, 1, '2021-05-06 15:36:14', '2021-06-03 13:01:04');

-- ----------------------------
-- Table structure for ltwlpb_template
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_template`;
CREATE TABLE `ltwlpb_template`
(
    `id`                               int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `template_fahuo`                   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `mini_template_fahuo`              varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `template_chujia`                  varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `mini_template_chujia`             varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `template_order`                   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `mini_template_order`              varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `template_shouhuo`                 varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `mini_template_shouhuo`            varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `template_daifahuo`                varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `mini_template_daifahuo`           varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `template_tellseller`              varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '出价通知卖家',
    `mini_template_tellseller`         varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `template_sendmessage`             varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '消息通知模板',
    `mini_template_sendmessage`        varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `template_endpaimai`               varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '竞拍结束',
    `mini_template_endpaimai`          varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `template_shopnewgoods`            varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '店铺上新',
    `mini_template_shopnewgoods`       varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `template_order_auto_confirm`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单自动确认收货提醒',
    `mini_template_order_auto_confirm` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '小程序订单自动收货提现模板',
    `template_zjsendmessage`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '公众号发消息给鉴定专家模板',
    `mini_template_zjsendmessage`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '小程序发消息给鉴定专家模板',
    `template_zjapplymessage`          varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '公众号回馈鉴定结果模板',
    `mini_template_zjapplymessage`     varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '小程序回馈鉴定结果模板',
    `template_mrsale`                  varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '售后通知',
    `site_id`                          int(10) NULL DEFAULT NULL,
    `created_at`                       timestamp NULL DEFAULT NULL,
    `updated_at`                       timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_template
-- ----------------------------
INSERT INTO `ltwlpb_template`
VALUES (1, '42dlcOCOvtLxwjzZuCGTHfOeobJf-D2ksjORSTd2raw', 'jAoHmXukjPfpLftGePjlmE1LB3p41gyBDop6tIra1So',
        'xuxOWNjmdpzHTesL0PIAen9ftq8eBP7H25Kh7ZP2_EQ', 'dALkSWaQ4fnCfzMwoCNL65MNyP-pwDeSDywgWDPYAGY',
        'vgF5hocjeaCEQwQpVVne-EH7BpF2LTVWjUtXHrA-oQI', 'cExRIRO49huaix0ofN9Q7lBTzqjq6yOPi3rLPixDjTk',
        'O9TzGdx8CzJrK8ZCAzH14m3khZbMiCfq09R9V2GABKc', 'SEorMmfnqxdZA7oO9TPgsDCyCshHTzncj2A4gfOBZa8',
        'kRHRVrxDZ8JqreQjD5twPFgo8qVTsHWBXlejmoMOrCY', 'EU1dHZqzh0q5C78n2QPcEWoaIYY03tAo-_sZfD-8t0s',
        'gQnJg44_G-Yl9RKvbw6iwWeHFyV6qau1u6-g9Ti0Z9g', 'dALkSWaQ4fnCfzMwoCNL65MNyP-pwDeSDywgWDPYAGY',
        'fYZp5RuMkGgqx6mfLu8GsIBRueJEnp5BRBxh48iw3M0', 'WrvLsDbZwMy2-M8otI7On5eevzZKcTHPT74naGBMoW4',
        'irXOdWNZ4TUxdFO0L16YMKezPW2pmjhXtYBTH-WZ5h0', 'CN37gcRWK91jPs_ayNpHJhaqHLKQBhy0N3Bh1zrpBV4',
        '2qSOau_p1HCa37UV_gjWGounKpuUTchqiND1apyBPuU', 'k1D9i0E0vL6aqn1z09MIABGRFiOkZnho12L0Zn_97HY',
        'lry5v5uQGYJjBui5skhzpOA-lJqI319SJ3RvDtpZf_4', '', 'iFJTzsnAKXoJOtE4F_ccggpk1oE8g-J9Lrn5WnhVK_s',
        'XJXoKYYQoVHkXZyxspWUnGd3B4Kid198NcD0JHi41Hw', 'DJvY3VEhNw56_y-No8qzWXt7GwPk441V2cKbdsnly0I',
        'kmdB2EnjZiJcy9Jn6meSjbnNKOJChL3a0DKYyQIJFU8', '08Lft14jNYGXFI_Flbc_u8S_eGPF1ZPf5T7K8jR-Cpc', 1,
        '2019-06-05 17:29:12', '2021-06-17 14:49:25');

-- ----------------------------
-- Table structure for ltwlpb_user
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_user`;
CREATE TABLE `ltwlpb_user`
(
    `id`                int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `openid`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '微信openid',
    `mini_openid`       varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '小程序openid',
    `app_openid`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'app_openid',
    `unionid`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '微信体系账号唯一id',
    `nick_name`         varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '微信昵称',
    `avatar`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像',
    `u_avatar`          varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '自定义头像',
    `name`              varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '姓名',
    `password`          varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '密码',
    `pay_pwd`           varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付密码',
    `phone`             varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机号',
    `level`             int(10) UNSIGNED NULL DEFAULT 0 COMMENT '会员等级',
    `is_insider`        tinyint(3) UNSIGNED NULL DEFAULT 0 COMMENT '是否为内部人员',
    `status`            tinyint(3) NULL DEFAULT 0 COMMENT '状态',
    `id_card_num`       varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '身份证号',
    `id_card_front`     varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '身份证正面',
    `id_card_back`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '身份证反面',
    `auth_status`       tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '认证状态:0未认证',
    `province`          varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '省',
    `city`              varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '市',
    `district`          varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '区',
    `address`           varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '地址',
    `s_name`            varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收货姓名(弃用)',
    `s_phone`           varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收货电话(弃用)',
    `s_province`        varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收货所在省(弃用)',
    `s_city`            varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收货所在城市(弃用)',
    `s_district`        varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收货所在地区(弃用)',
    `s_address`         varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收货详细地址(弃用)',
    `parent_id`         int(10) NULL DEFAULT 0 COMMENT '父级id',
    `identity_fee`      int(1) NULL DEFAULT NULL COMMENT '实名认证是否缴费，0->未缴纳，1=>已缴纳',
    `activity_new_user` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '是否活动新用户',
    `frozen_seller`     int(1) NULL DEFAULT 0 COMMENT '是否固定入口为卖家中心，0否，1是',
    `forzen`            int(11) NULL DEFAULT 1 COMMENT '用户状态：1是正常，2是冻结，3是禁止出价',
    `is_anchor`         int(1) NULL DEFAULT 0 COMMENT '是否主播，1标识主播权限',
    `is_first_update`   int(1) NULL DEFAULT 1 COMMENT '是否首次完善信息，1首次，0已完善',
    `is_expert`         int(1) NULL DEFAULT 0 COMMENT '是否是jd专家',
    `cid`               varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `cit`               varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `site_id`           int(10) UNSIGNED NULL DEFAULT 1,
    `created_at`        timestamp NULL DEFAULT NULL,
    `updated_at`        timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_user
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_user_address
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_user_address`;
CREATE TABLE `ltwlpb_user_address`
(
    `id`         int(11) NOT NULL AUTO_INCREMENT,
    `user_id`    int(11) NOT NULL,
    `s_name`     varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NOT NULL COMMENT '收货姓名',
    `s_phone`    varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NOT NULL COMMENT '收货电话',
    `s_province` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NOT NULL COMMENT '收货所在省',
    `s_city`     varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NOT NULL COMMENT '收货所在城市',
    `s_district` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NOT NULL COMMENT '收货所在地区',
    `s_address`  varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '收货详细地址',
    `is_default` int(10) NULL DEFAULT 0 COMMENT '是否默认地址',
    `site_id`    int(10) UNSIGNED NOT NULL,
    `created_at` timestamp NULL DEFAULT NULL,
    `updated_at` timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_user_address
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_user_appraiser_list
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_user_appraiser_list`;
CREATE TABLE `ltwlpb_user_appraiser_list`
(
    `id`                int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `user_id`           int(10) NOT NULL COMMENT '会员表id',
    `avatar`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '专家头像',
    `name`              char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '专家姓名',
    `actual_money`      decimal(10, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '鉴定价格',
    `meet_tip`          varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '约见提示',
    `expertise`         varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '专长（,分隔的字符串）',
    `introduction`      text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '简介',
    `content`           longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '专家详情介绍',
    `balance`           decimal(10, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '余额',
    `status`            tinyint(1) NOT NULL DEFAULT 1 COMMENT '1：正常2：禁用',
    `auth_state`        tinyint(1) NOT NULL DEFAULT 1 COMMENT '1：待审核2：审核通过3拒绝',
    `auth_avatar`       varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '待审核专家头像',
    `auth_name`         char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '待审核专家姓名',
    `auth_actual_money` decimal(10, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '待审核鉴定价格',
    `auth_meet_tip`     varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '待审核约见提示',
    `auth_expertise`    varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '待审核专长（,分隔的字符串）',
    `auth_introduction` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '待审核简介',
    `appraiser_order`   int(10) NULL DEFAULT 0,
    `site_id`           int(10) NOT NULL DEFAULT 0 COMMENT '站点',
    `created_at`        timestamp NULL DEFAULT NULL COMMENT '创建时间',
    `updated_at`        timestamp NULL DEFAULT NULL COMMENT '审核时间',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE INDEX `user_id`(`user_id`) USING BTREE,
    INDEX               `expertise`(`expertise`) USING BTREE,
    INDEX               `site_id`(`site_id`) USING BTREE,
    INDEX               `status`(`status`) USING BTREE,
    INDEX               `auth_state`(`auth_state`) USING BTREE,
    INDEX               `name`(`name`) USING BTREE,
    INDEX               `created_at`(`created_at`) USING BTREE,
    INDEX               `updated_at`(`updated_at`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '鉴定专家信息列表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ltwlpb_user_appraiser_list
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_user_benefits
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_user_benefits`;
CREATE TABLE `ltwlpb_user_benefits`
(
    `id`         int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `user_id`    int(10) UNSIGNED NULL DEFAULT NULL COMMENT '用户id',
    `parent_id`  int(10) NULL DEFAULT NULL,
    `orders_id`  int(10) NULL DEFAULT NULL,
    `site_id`    int(10) UNSIGNED NULL DEFAULT NULL COMMENT '站点',
    `money`      decimal(10, 2) NULL DEFAULT NULL,
    `status`     int(1) NULL DEFAULT NULL,
    `created_at` timestamp NULL DEFAULT NULL,
    `updated_at` timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_user_benefits
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_user_expertise_list
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_user_expertise_list`;
CREATE TABLE `ltwlpb_user_expertise_list`
(
    `id`         int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `name`       char(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '专长名称',
    `sort`       int(10) NOT NULL DEFAULT 0 COMMENT '排序',
    `status`     tinyint(1) NOT NULL DEFAULT 1 COMMENT '1正常2隐藏',
    `created_at` timestamp                                                 NOT NULL COMMENT '添加时间',
    `updated_at` timestamp                                                 NOT NULL COMMENT '修改时间',
    `site_id`    int(10) NOT NULL DEFAULT 0 COMMENT '站点',
    PRIMARY KEY (`id`) USING BTREE,
    INDEX        `site_id`(`site_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '鉴定专家专长列表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ltwlpb_user_expertise_list
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_user_interal
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_user_interal`;
CREATE TABLE `ltwlpb_user_interal`
(
    `id`         int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id`    int(10) UNSIGNED NULL DEFAULT NULL,
    `total_in`   int(10) NULL DEFAULT NULL,
    `total_out`  int(10) NULL DEFAULT NULL,
    `info`       varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `site_id`    int(11) NULL DEFAULT NULL COMMENT '站点id',
    `created_at` timestamp NULL DEFAULT NULL,
    `updated_at` timestamp NULL DEFAULT NULL,
    `days`       int(10) NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_user_interal
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_user_interal_lists
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_user_interal_lists`;
CREATE TABLE `ltwlpb_user_interal_lists`
(
    `id`         int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id`    int(10) UNSIGNED NULL DEFAULT NULL,
    `info`       varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `brief`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `amount`     int(10) UNSIGNED NULL DEFAULT 0 COMMENT '积分值',
    `type`       int(2) NULL DEFAULT NULL COMMENT '积分获取类型。正数增加，负数扣除。',
    `site_id`    int(11) NULL DEFAULT NULL COMMENT '站点id',
    `created_at` timestamp NULL DEFAULT NULL,
    `updated_at` timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_user_interal_lists
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_user_level
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_user_level`;
CREATE TABLE `ltwlpb_user_level`
(
    `id`         int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `name`       varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '会员等级名称',
    `integral`   int(10) NULL DEFAULT 0 COMMENT '升级积分',
    `is_default` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '是否默认用户等级 0否1是',
    `xid`        int(1) NULL DEFAULT NULL,
    `site_id`    int(10) UNSIGNED NULL DEFAULT NULL,
    `created_at` timestamp NULL DEFAULT NULL,
    `updated_at` timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_user_level
-- ----------------------------
INSERT INTO `ltwlpb_user_level`
VALUES (1, '白丁', 0, 1, 1, 1, NULL, NULL);
INSERT INTO `ltwlpb_user_level`
VALUES (2, '秀才', 1000, 0, 2, 1, NULL, NULL);
INSERT INTO `ltwlpb_user_level`
VALUES (3, '举人', 3000, 0, 3, 1, NULL, NULL);
INSERT INTO `ltwlpb_user_level`
VALUES (4, '进士', 6000, 0, 4, 1, NULL, NULL);
INSERT INTO `ltwlpb_user_level`
VALUES (5, '状元', 10000, 0, 5, 1, NULL, NULL);
INSERT INTO `ltwlpb_user_level`
VALUES (6, '尚书', 30000, 0, 6, 1, NULL, NULL);
INSERT INTO `ltwlpb_user_level`
VALUES (7, '太傅', 50000, 0, 7, 1, NULL, NULL);
INSERT INTO `ltwlpb_user_level`
VALUES (8, '圣贤', 100000, 0, 8, 1, NULL, NULL);

-- ----------------------------
-- Table structure for ltwlpb_video
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_video`;
CREATE TABLE `ltwlpb_video`
(
    `id`            int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `user_id`       int(10) NOT NULL DEFAULT 0 COMMENT '用户id',
    `goods_id`      int(10) NOT NULL DEFAULT 0 COMMENT '商品id',
    `video_type_id` int(10) NOT NULL DEFAULT 0 COMMENT '视频分类id',
    `title`         varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标题',
    `image`         varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '封面',
    `video`         varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '视频',
    `desc`          text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '视频描述',
    `status`        tinyint(3) NOT NULL DEFAULT 0 COMMENT '订单状态:-1=审核驳回,0=待审核,1=审核通过',
    `is_frontend`   tinyint(1) NULL DEFAULT 0 COMMENT '发布端口:0=前端,1=后台',
    `is_sale`       tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否上架:0=否,1=是',
    `site_id`       int(10) UNSIGNED NULL DEFAULT NULL COMMENT '站点编号',
    `is_del`        int(10) NOT NULL DEFAULT 0 COMMENT '是否删除',
    `created_at`    timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
    `updated_at`    timestamp NULL DEFAULT NULL COMMENT '修改日期',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '视频列表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ltwlpb_video
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_video_type
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_video_type`;
CREATE TABLE `ltwlpb_video_type`
(
    `id`          int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `name`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分类名称',
    `small_image` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分类小图标',
    `big_image`   varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分类大图标',
    `order`       int(10) UNSIGNED NULL DEFAULT NULL COMMENT '排序',
    `site_id`     int(10) UNSIGNED NULL DEFAULT NULL COMMENT '站点编号',
    `created_at`  timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
    `updated_at`  timestamp NULL DEFAULT NULL COMMENT '修改日期',
    `is_del`      tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '视频分类' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ltwlpb_video_type
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_wallet_lists
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_wallet_lists`;
CREATE TABLE `ltwlpb_wallet_lists`
(
    `id`               int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `goods_id`         varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `user_id`          int(10) UNSIGNED NOT NULL COMMENT '用户编号',
    `order_id`         int(10) UNSIGNED NULL DEFAULT 0 COMMENT '订单id',
    `info`             varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '流水概要',
    `type`             tinyint(4) NOT NULL COMMENT '出入账类型：{1，收入；2，退款；}',
    `account`          varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `amount`           decimal(10, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '数额（单位:元）',
    `file`             varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收款码',
    `actual_amount`    decimal(10, 2) UNSIGNED NULL DEFAULT NULL COMMENT '实际金额',
    `status`           tinyint(4) NOT NULL DEFAULT 0 COMMENT '状态:（-1：失败 ；0：待处理 ；1：成功；）',
    `buyer_or_seller`  int(1) NULL DEFAULT NULL,
    `partner_trade_no` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '提现订单号',
    `payment_time`     varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '提现时间',
    `brief`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
    `is_onlineoff`     varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '是否通过线下打款',
    `zf_type`          varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `site_id`          int(11) NULL DEFAULT NULL COMMENT '站点id',
    `created_at`       timestamp NULL DEFAULT NULL,
    `updated_at`       timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_wallet_lists
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_wallet_lists_zc
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_wallet_lists_zc`;
CREATE TABLE `ltwlpb_wallet_lists_zc`
(
    `id`               int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `goods_id`         varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `user_id`          int(10) UNSIGNED NOT NULL COMMENT '用户编号',
    `order_id`         int(10) UNSIGNED NULL DEFAULT 0 COMMENT '订单id',
    `info`             varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '流水概要',
    `type`             tinyint(4) NOT NULL COMMENT '出入账类型：{1，收入；2，退款；}',
    `account`          varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `amount`           decimal(10, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '数额（单位:元）',
    `file`             varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收款码',
    `actual_amount`    decimal(10, 2) UNSIGNED NULL DEFAULT NULL COMMENT '实际金额',
    `status`           tinyint(4) NOT NULL DEFAULT 0 COMMENT '状态:（-1：失败 ；0：待处理 ；1：成功；）',
    `buyer_or_seller`  int(1) NULL DEFAULT NULL,
    `partner_trade_no` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '提现订单号',
    `payment_time`     varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '提现时间',
    `brief`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
    `is_onlineoff`     varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '是否通过线下打款',
    `zf_type`          varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `site_id`          int(11) NULL DEFAULT NULL COMMENT '站点id',
    `created_at`       timestamp NULL DEFAULT NULL,
    `updated_at`       timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ltwlpb_wallet_lists_zc
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_wallet_recharge_orders
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_wallet_recharge_orders`;
CREATE TABLE `ltwlpb_wallet_recharge_orders`
(
    `id`              int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `user_id`         int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '充值的用户id',
    `rule_id`         int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '充值规则id',
    `rule_title`      varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '充值活动的标题',
    `price`           decimal(8, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '价格，单位：元',
    `gift_amount`     decimal(8, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '赠送数额，单位：元',
    `status`          tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态：[0:未支付，1:已支付]',
    `serial_number`   varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `buyer_or_seller` int(1) NULL DEFAULT NULL,
    `zf_type`         varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '微信充值wx，支付宝充值zfb',
    `site_id`         int(11) NULL DEFAULT NULL,
    `created_at`      timestamp NULL DEFAULT NULL,
    `updated_at`      timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_wallet_recharge_orders
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_wallets
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_wallets`;
CREATE TABLE `ltwlpb_wallets`
(
    `id`               int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id`          int(10) UNSIGNED NOT NULL COMMENT '用户编号',
    `total_in`         decimal(14, 2) UNSIGNED NULL DEFAULT NULL COMMENT '钱包入账累积总额（单位元）',
    `total_out`        decimal(14, 2) UNSIGNED NULL DEFAULT NULL COMMENT '钱包已出账总额（单位元）',
    `site_id`          int(10) NULL DEFAULT NULL COMMENT '站点id',
    `settlement_money` decimal(14, 2) NULL DEFAULT NULL COMMENT '未结算金额',
    `withdrawal`       decimal(14, 2) NULL DEFAULT NULL COMMENT '已经提现金额',
    `frozen_money`     varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `created_at`       timestamp NULL DEFAULT NULL,
    `updated_at`       timestamp NULL DEFAULT NULL,
    `buyer_or_seller`  int(1) NULL DEFAULT NULL COMMENT '卖家或买家【疑似无用】',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ltwlpb_wallets
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_walletszc
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_walletszc`;
CREATE TABLE `ltwlpb_walletszc`
(
    `id`               int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id`          int(10) UNSIGNED NOT NULL COMMENT '用户编号',
    `total_in`         decimal(14, 2) UNSIGNED NULL DEFAULT NULL COMMENT '钱包入账累积总额（单位元）',
    `total_out`        decimal(14, 2) UNSIGNED NULL DEFAULT NULL COMMENT '钱包已出账总额（单位元）',
    `site_id`          int(10) NULL DEFAULT NULL COMMENT '站点id',
    `settlement_money` decimal(14, 2) NULL DEFAULT NULL COMMENT '未结算金额',
    `withdrawal`       decimal(14, 2) NULL DEFAULT NULL COMMENT '已经提现金额',
    `frozen_money`     varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `created_at`       timestamp NULL DEFAULT NULL,
    `updated_at`       timestamp NULL DEFAULT NULL,
    `buyer_or_seller`  int(1) NULL DEFAULT NULL COMMENT '卖家或买家【疑似无用】',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ltwlpb_walletszc
-- ----------------------------

-- ----------------------------
-- Table structure for ltwlpb_zjwallet_lists
-- ----------------------------
DROP TABLE IF EXISTS `ltwlpb_zjwallet_lists`;
CREATE TABLE `ltwlpb_zjwallet_lists`
(
    `id`               int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `goods_id`         varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `user_id`          int(10) UNSIGNED NOT NULL COMMENT '用户编号',
    `order_id`         int(10) UNSIGNED NULL DEFAULT 0 COMMENT '订单id',
    `info`             varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '流水概要',
    `type`             tinyint(4) NOT NULL COMMENT '-1提现1收入',
    `account`          varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `amount`           decimal(10, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '数额（单位:元）',
    `before_money`     decimal(10, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '余额变动前的金额',
    `file`             varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收款码',
    `actual_amount`    decimal(10, 2) UNSIGNED NULL DEFAULT NULL COMMENT '实际金额',
    `status`           tinyint(4) NOT NULL DEFAULT 0 COMMENT '状态:（-1：失败 ；0：待处理 ；1：成功；）',
    `buyer_or_seller`  int(1) NULL DEFAULT NULL,
    `partner_trade_no` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '提现订单号',
    `payment_time`     varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '提现时间',
    `brief`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
    `is_onlineoff`     varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '是否通过线下打款',
    `zf_type`          varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `site_id`          int(11) NULL DEFAULT NULL COMMENT '站点id',
    `created_at`       timestamp NULL DEFAULT NULL,
    `updated_at`       timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '鉴定专家提现表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ltwlpb_zjwallet_lists
-- ----------------------------

-- ----------------------------
--  2021-11-11 同步4.8.5
-- ----------------------------

ALTER TABLE `ltwlpb_open_set`
    ADD COLUMN `open_virtual_fans` int(1) NOT NULL DEFAULT 0 COMMENT '是否开启虚拟粉丝功能' AFTER `open_zc_upload`;

ALTER TABLE `ltwlpb_open_set`
    ADD COLUMN `open_wechat_pay` int(1) NOT NULL DEFAULT 1 COMMENT '订单微信支付0关闭1开启' AFTER `open_virtual_fans`;

ALTER TABLE `ltwlpb_open_set`
    ADD COLUMN `open_balance_pay` int(1) NOT NULL DEFAULT 1 COMMENT '订单余额支付0关闭1开启' AFTER `open_wechat_pay`;

ALTER TABLE `ltwlpb_open_set`
    ADD COLUMN `open_type_pay` int(1) NOT NULL DEFAULT 0 COMMENT '保证金支付方式0微信1余额' AFTER `open_balance_pay`;

ALTER TABLE `ltwlpb_open_set`
    ADD COLUMN `open_balance_recharge` int(1) NOT NULL DEFAULT 1 COMMENT '余额充值1开启2关闭' AFTER `open_type_pay`;

ALTER TABLE `ltwlpb_open_set`
    ADD COLUMN `upload_type` int(1) NULL DEFAULT 1 COMMENT '1本地上传2阿里云上传3七牛上传' AFTER `open_balance_recharge`;

ALTER TABLE `ltwlpb_price_offer`
    ADD COLUMN `pay_type` int(1) NOT NULL DEFAULT -1 COMMENT '支付方式-1零支付1余额2微信3支付宝' AFTER `is_order`;

ALTER TABLE `ltwlpb_site`
    ADD COLUMN `alioss_access_key_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '阿里云oss的keyid' AFTER `plugin_modules`;

ALTER TABLE `ltwlpb_site`
    ADD COLUMN `alioss_access_key_secret` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '阿里云oss的keysecret' AFTER `alioss_access_key_id`;

ALTER TABLE `ltwlpb_site`
    ADD COLUMN `alioss_endpoint` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '阿里云oss的endPoint' AFTER `alioss_access_key_secret`;

ALTER TABLE `ltwlpb_site`
    ADD COLUMN `alioss_bucket` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '阿里云oss的bucket' AFTER `alioss_endpoint`;

ALTER TABLE `ltwlpb_site`
    ADD COLUMN `qnoss_access_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '七牛云oss的keyid' AFTER `alioss_bucket`;

ALTER TABLE `ltwlpb_site`
    ADD COLUMN `qnoss_secret_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '七牛云oss的keysecret' AFTER `qnoss_access_key`;

ALTER TABLE `ltwlpb_site`
    ADD COLUMN `qnoss_domain` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '七牛云oss的域名' AFTER `qnoss_secret_key`;

ALTER TABLE `ltwlpb_site`
    ADD COLUMN `qnoss_bucket` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '七牛云oss的bucket' AFTER `qnoss_domain`;


-- ----------------------------
-- 同步4.7.8

ALTER TABLE `ltwlpb_user`
    ADD COLUMN `fans` int(11) NOT NULL DEFAULT 0 COMMENT '虚拟粉丝数';

ALTER TABLE `ltwlpb_user`
    ADD COLUMN `is_fans` int(2) NOT NULL DEFAULT 2 COMMENT '虚拟粉丝开关1是2否' AFTER `fans`;

DROP TABLE IF EXISTS `ltwlpb_user_chat`;
CREATE TABLE `ltwlpb_user_chat`
(
    `id`         int(11) NOT NULL AUTO_INCREMENT COMMENT 'No.',
    `uid`        int(11) NULL DEFAULT NULL COMMENT '卖家',
    `sid`        int(11) NULL DEFAULT NULL COMMENT '卖家',
    `cid`        int(11) NULL DEFAULT NULL COMMENT '当前用户',
    `site_id`    int(11) NULL DEFAULT NULL COMMENT '站点id',
    `content`    varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '内容',
    `status`     int(11) NOT NULL DEFAULT 2 COMMENT '状态1已读2未读',
    `type`       int(2) NOT NULL DEFAULT 1 COMMENT '类型1单2群',
    `created_at` timestamp NULL DEFAULT NULL COMMENT '创建',
    `updated_at` timestamp NULL DEFAULT NULL COMMENT '修改',
    `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除',
    PRIMARY KEY (`id`) USING BTREE,
    INDEX        `uid`(`uid`) USING BTREE,
    INDEX        `sid`(`sid`) USING BTREE,
    INDEX        `cid`(`cid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户聊天表' ROW_FORMAT = Dynamic;

DROP TABLE IF EXISTS `ltwlpb_user_fans`;
CREATE TABLE `ltwlpb_user_fans`
(
    `id`         int(11) NOT NULL AUTO_INCREMENT COMMENT 'No.',
    `uid`        int(11) NULL DEFAULT NULL COMMENT '用户id',
    `type`       int(11) NULL DEFAULT -1 COMMENT '类型1关注2拉黑-1取消',
    `sid`        int(11) NULL DEFAULT NULL COMMENT '关联用户id',
    `site_id`    int(11) NULL DEFAULT NULL COMMENT '站点id',
    `expire`     int(2) NULL DEFAULT 2 COMMENT '有效性1是2否',
    `remarks`    varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
    `created_at` timestamp NULL DEFAULT NULL COMMENT '创建',
    `updated_at` timestamp NULL DEFAULT NULL COMMENT '修改',
    PRIMARY KEY (`id`) USING BTREE,
    INDEX        `type`(`type`) USING BTREE,
    INDEX        `uid`(`uid`) USING BTREE,
    INDEX        `sid`(`sid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

DROP TABLE IF EXISTS `ltwlpb_user_history`;
CREATE TABLE `ltwlpb_user_history`
(
    `id`         int(11) NOT NULL AUTO_INCREMENT COMMENT 'No.',
    `uid`        int(11) NULL DEFAULT NULL COMMENT '用户id',
    `sid`        int(11) NULL DEFAULT NULL COMMENT '查看人',
    `gid`        int(11) NULL DEFAULT NULL COMMENT '商品id',
    `expire`     int(2) NULL DEFAULT 2 COMMENT '有效性1是2否',
    `created_at` timestamp NULL DEFAULT NULL COMMENT '创建',
    `updated_at` timestamp NULL DEFAULT NULL COMMENT '修改',
    `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

--  2021-12-09 同步4.8.8
-- ----------------------------

-- ----------------------------
--  2021-12-27 同步4.8.10 开始

ALTER TABLE ltwlpb_open_set
    ADD `open_home_show` int(1) DEFAULT 0 COMMENT '是否打开首页展示，1是0否';
ALTER TABLE ltwlpb_goods
    ADD `home_show` int(1) DEFAULT 0 COMMENT '是否首页展示商品';
ALTER TABLE ltwlpb_shops_level
    ADD `home_number` int(10) DEFAULT 10 COMMENT '首页置顶数量';

--  2021-12-27 同步4.8.10 结束
-- ----------------------------

-- ----------------------------
--  2022-01-05 同步4.8.11 开始
ALTER TABLE ltwlpb_shops ADD `shops_order` int(10) DEFAULT 0 COMMENT '店铺排序';
--  同步4.8.10 结束
-- ----------------------------

SET
FOREIGN_KEY_CHECKS=1;
