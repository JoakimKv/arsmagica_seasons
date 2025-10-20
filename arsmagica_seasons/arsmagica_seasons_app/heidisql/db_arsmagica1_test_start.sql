-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.1.0 - MySQL Community Server - GPL
-- Server OS:                    Linux
-- HeidiSQL Version:             12.12.0.7122
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for db_arsmagica1_test
CREATE DATABASE IF NOT EXISTS `db_arsmagica1_test` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `db_arsmagica1_test`;

-- Dumping structure for table db_arsmagica1_test.arsmagica_seasons_app_seasonalwork
CREATE TABLE IF NOT EXISTS `arsmagica_seasons_app_seasonalwork` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `character_type` varchar(12) NOT NULL,
  `year` int unsigned NOT NULL,
  `season` varchar(12) NOT NULL,
  `summary` varchar(455) NOT NULL,
  `description` longtext NOT NULL,
  `time_created` datetime(6) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `arsmagica_seasons_ap_user_id_aeea372c_fk_auth_user` (`user_id`),
  CONSTRAINT `arsmagica_seasons_ap_user_id_aeea372c_fk_auth_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `arsmagica_seasons_app_seasonalwork_chk_1` CHECK ((`year` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table db_arsmagica1_test.arsmagica_seasons_app_seasonalwork: ~0 rows (approximately)

-- Dumping structure for table db_arsmagica1_test.auth_group
CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table db_arsmagica1_test.auth_group: ~0 rows (approximately)

-- Dumping structure for table db_arsmagica1_test.auth_group_permissions
CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table db_arsmagica1_test.auth_group_permissions: ~0 rows (approximately)

-- Dumping structure for table db_arsmagica1_test.auth_permission
CREATE TABLE IF NOT EXISTS `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table db_arsmagica1_test.auth_permission: ~28 rows (approximately)
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(85, 'Can add log entry', 22, 'add_logentry'),
	(86, 'Can change log entry', 22, 'change_logentry'),
	(87, 'Can delete log entry', 22, 'delete_logentry'),
	(88, 'Can view log entry', 22, 'view_logentry'),
	(89, 'Can add permission', 23, 'add_permission'),
	(90, 'Can change permission', 23, 'change_permission'),
	(91, 'Can delete permission', 23, 'delete_permission'),
	(92, 'Can view permission', 23, 'view_permission'),
	(93, 'Can add group', 24, 'add_group'),
	(94, 'Can change group', 24, 'change_group'),
	(95, 'Can delete group', 24, 'delete_group'),
	(96, 'Can view group', 24, 'view_group'),
	(97, 'Can add user', 25, 'add_user'),
	(98, 'Can change user', 25, 'change_user'),
	(99, 'Can delete user', 25, 'delete_user'),
	(100, 'Can view user', 25, 'view_user'),
	(101, 'Can add content type', 26, 'add_contenttype'),
	(102, 'Can change content type', 26, 'change_contenttype'),
	(103, 'Can delete content type', 26, 'delete_contenttype'),
	(104, 'Can view content type', 26, 'view_contenttype'),
	(105, 'Can add session', 27, 'add_session'),
	(106, 'Can change session', 27, 'change_session'),
	(107, 'Can delete session', 27, 'delete_session'),
	(108, 'Can view session', 27, 'view_session'),
	(109, 'Can add seasonal work', 28, 'add_seasonalwork'),
	(110, 'Can change seasonal work', 28, 'change_seasonalwork'),
	(111, 'Can delete seasonal work', 28, 'delete_seasonalwork'),
	(112, 'Can view seasonal work', 28, 'view_seasonalwork');

-- Dumping structure for table db_arsmagica1_test.auth_user
CREATE TABLE IF NOT EXISTS `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table db_arsmagica1_test.auth_user: ~5 rows (approximately)
INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
	(10, 'pbkdf2_sha256$1000000$zu6KyG2T6p9kjTt2oOJvjF$JZBaznYoq5qPmMBK/+HsjBRmD/Kwg+SPABIII7Kkyx0=', NULL, 1, 'admin', '', '', 'joakim.kvistholm@gmail.com', 1, 1, '2025-10-16 00:17:59.641648'),
	(11, 'pbkdf2_sha256$1000000$wbai0srcNffCZ2ZLLUENXv$oOh4SL9AWzTtP5MFyNUWB42rtulS4Y7rGfbn2JpxxYQ=', NULL, 1, 'joakim', '', '', 'joakim.kvistholm@gmail.com', 1, 1, '2025-10-16 00:18:47.692141'),
	(12, 'pbkdf2_sha256$1000000$PnBjbRBgzVjIKMxRB2rXvQ$/tzIW/VgJ2yx3fDskzmQFwXHbclsiWzlS2b+M07Dlqk=', '2025-10-16 00:43:55.346897', 0, 'kalle', '', '', 'kalle@hotmail.com', 0, 1, '2025-10-16 00:31:20.068509'),
	(16, 'pbkdf2_sha256$1000000$OQft9fD7UIwXAyvHsEzyMJ$PVwIrb1wIDUm7/5Y8PestUbgAShKU0wZhyLJL9GP1Is=', NULL, 0, 'test_user_intruder', '', '', 'intruder@hotmail.com', 0, 1, '2025-10-16 01:27:10.689956'),
	(28, 'pbkdf2_sha256$1000000$0gLhmsnzM8YMMIIymIkbAz$3VdVe8vspAOVCquUjj0yQpjGIM52iz1d9IoDDSwJdoU=', NULL, 0, 'test_user_gpt_real', '', '', 'test_user_gpt_real@hotmail.com', 0, 1, '2025-10-17 05:10:52.581530');

-- Dumping structure for table db_arsmagica1_test.auth_user_groups
CREATE TABLE IF NOT EXISTS `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table db_arsmagica1_test.auth_user_groups: ~0 rows (approximately)

-- Dumping structure for table db_arsmagica1_test.auth_user_user_permissions
CREATE TABLE IF NOT EXISTS `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table db_arsmagica1_test.auth_user_user_permissions: ~0 rows (approximately)

-- Dumping structure for table db_arsmagica1_test.django_admin_log
CREATE TABLE IF NOT EXISTS `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table db_arsmagica1_test.django_admin_log: ~0 rows (approximately)

-- Dumping structure for table db_arsmagica1_test.django_content_type
CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table db_arsmagica1_test.django_content_type: ~7 rows (approximately)
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(22, 'admin', 'logentry'),
	(23, 'auth', 'permission'),
	(24, 'auth', 'group'),
	(25, 'auth', 'user'),
	(26, 'contenttypes', 'contenttype'),
	(27, 'sessions', 'session'),
	(28, 'arsmagica_seasons_app', 'seasonalwork');

-- Dumping structure for table db_arsmagica1_test.django_migrations
CREATE TABLE IF NOT EXISTS `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table db_arsmagica1_test.django_migrations: ~19 rows (approximately)
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(1, 'contenttypes', '0001_initial', '2025-10-08 03:48:23.473430'),
	(2, 'auth', '0001_initial', '2025-10-08 03:48:26.629827'),
	(3, 'admin', '0001_initial', '2025-10-08 03:48:27.170450'),
	(4, 'admin', '0002_logentry_remove_auto_add', '2025-10-08 03:48:27.197210'),
	(5, 'admin', '0003_logentry_add_action_flag_choices', '2025-10-08 03:48:27.230453'),
	(6, 'arsmagica_seasons_app', '0001_initial', '2025-10-08 03:48:27.544501'),
	(7, 'contenttypes', '0002_remove_content_type_name', '2025-10-08 03:48:27.812365'),
	(8, 'auth', '0002_alter_permission_name_max_length', '2025-10-08 03:48:28.014600'),
	(9, 'auth', '0003_alter_user_email_max_length', '2025-10-08 03:48:28.061912'),
	(10, 'auth', '0004_alter_user_username_opts', '2025-10-08 03:48:28.077877'),
	(11, 'auth', '0005_alter_user_last_login_null', '2025-10-08 03:48:28.308376'),
	(12, 'auth', '0006_require_contenttypes_0002', '2025-10-08 03:48:28.320592'),
	(13, 'auth', '0007_alter_validators_add_error_messages', '2025-10-08 03:48:28.338483'),
	(14, 'auth', '0008_alter_user_username_max_length', '2025-10-08 03:48:28.533783'),
	(15, 'auth', '0009_alter_user_last_name_max_length', '2025-10-08 03:48:28.742517'),
	(16, 'auth', '0010_alter_group_name_max_length', '2025-10-08 03:48:28.783183'),
	(17, 'auth', '0011_update_proxy_permissions', '2025-10-08 03:48:28.801479'),
	(18, 'auth', '0012_alter_user_first_name_max_length', '2025-10-08 03:48:29.010498'),
	(19, 'sessions', '0001_initial', '2025-10-08 03:48:29.198900'),
	(20, 'arsmagica_seasons_app', '0002_alter_seasonalwork_summary', '2025-10-13 01:08:25.019342');

-- Dumping structure for table db_arsmagica1_test.django_session
CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table db_arsmagica1_test.django_session: ~0 rows (approximately)

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
