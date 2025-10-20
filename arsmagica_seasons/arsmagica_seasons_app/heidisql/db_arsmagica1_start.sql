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


-- Dumping database structure for db_arsmagica1
CREATE DATABASE IF NOT EXISTS `db_arsmagica1` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `db_arsmagica1`;

-- Dumping structure for table db_arsmagica1.arsmagica_seasons_app_seasonalwork
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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table db_arsmagica1.arsmagica_seasons_app_seasonalwork: ~4 rows (approximately)
INSERT INTO `arsmagica_seasons_app_seasonalwork` (`id`, `name`, `character_type`, `year`, `season`, `summary`, `description`, `time_created`, `user_id`) VALUES
	(8, 'Nero', 'Magi', 1223, 'Summer', 'He created 3 Vim vis. He had a score of CrVim 22. He got 1 xp in MT.', 'He made 3 Vim vis. He had a score of CrVim 22. He got 1 xp in MT. Otherwise it was a relatively uneventful season.', '2025-10-16 00:34:33.637733', 12),
	(9, 'Gunnar', 'Companion', 1224, 'Winter', 'He trained in archery with Marcus in the woods, earning 2 experience points. The season was rather peaceful.', 'He trained bow with Marcus. They were in the woods. He got 2 xp on bow. The season was rather peaceful.', '2025-10-16 01:11:30.664953', 12),
	(16, 'Nero', 'Magi', 1222, 'Spring', 'He created a wand with arrows that can locate a person that you have arcane connection to. He made it for the village he oversees. He earned 1 experience point in Magic Theory (MT) and 1 in Intellego (In). Other companions and magi were away on a trip to England.', 'He made an artifact in the form of a wand with arrows that can point in different directions. It is used to find persons you have arcane connection to. The labtotal was InCo(Vim) 25. He earned 1 xp on MT and 1 xp on In. The artifact cost 1 In and 4 Co vis. This artifact is for the village he takes care of. Other companion and magi were on a trip to England. It was a rather quiet season on the covenant.', '2025-10-17 00:31:24.581391', 12),
	(20, 'Nero', 'Magi', 1225, 'Autumn', 'He invented the spell \'Restore the Lost Limb\' (CrCo 25) to help a general who lost his leg during a magical mishap. Despite all preparations, the general was offered to Oden before the much needed help could be provided, resulting in a wasted season. Meanwhile, the covenant was attack by northern Vikings, but it was a rather harmless attack.', 'He invented the spell \'Restore the lost limb\' CrCo 25. He did not gain any xp. He wanted to help the general who he teleported away without his leg during a magical botch. He had safely put away 1 Cr and 4 Co vis for this task, but the general was offered to Oden before the much needed help could be recieved. So this became another wasted season when he invented this spell. The covenant were attacked by other vikings from the north, but everything went fine.', '2025-10-17 00:36:49.751575', 12);

-- Dumping structure for table db_arsmagica1.auth_group
CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table db_arsmagica1.auth_group: ~0 rows (approximately)

-- Dumping structure for table db_arsmagica1.auth_group_permissions
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

-- Dumping data for table db_arsmagica1.auth_group_permissions: ~0 rows (approximately)

-- Dumping structure for table db_arsmagica1.auth_permission
CREATE TABLE IF NOT EXISTS `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table db_arsmagica1.auth_permission: ~28 rows (approximately)
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

-- Dumping structure for table db_arsmagica1.auth_user
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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table db_arsmagica1.auth_user: ~5 rows (approximately)
INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
	(10, 'pbkdf2_sha256$1000000$zu6KyG2T6p9kjTt2oOJvjF$JZBaznYoq5qPmMBK/+HsjBRmD/Kwg+SPABIII7Kkyx0=', NULL, 1, 'admin', '', '', 'joakim.kvistholm@gmail.com', 1, 1, '2025-10-16 00:17:59.641648'),
	(11, 'pbkdf2_sha256$1000000$wbai0srcNffCZ2ZLLUENXv$oOh4SL9AWzTtP5MFyNUWB42rtulS4Y7rGfbn2JpxxYQ=', '2025-10-19 22:15:17.188010', 1, 'joakim', '', '', 'joakim.kvistholm@gmail.com', 1, 1, '2025-10-16 00:18:47.692141'),
	(12, 'pbkdf2_sha256$1000000$PnBjbRBgzVjIKMxRB2rXvQ$/tzIW/VgJ2yx3fDskzmQFwXHbclsiWzlS2b+M07Dlqk=', '2025-10-16 01:15:05.041207', 0, 'kalle', '', '', 'kalle@hotmail.com', 0, 1, '2025-10-16 00:31:20.068509'),
	(16, 'pbkdf2_sha256$1000000$Bh3CO6CExJZLSBoZrrEANg$QvKC2aPJeN+Vq1qQ/Uu/JQeqk7R9KVKKQBBmRoJbLic=', '2025-10-17 05:10:54.676595', 0, 'test_user_intruder', '', '', 'intruder@hotmail.com', 0, 1, '2025-10-16 01:27:10.291600'),
	(29, 'pbkdf2_sha256$1000000$2BHgxXhxvn7rEGYAbEVxla$z/Gocvlx9+WW8DN9erLW6nlNEbu2dyM7y0P0lv4EH3k=', '2025-10-17 05:10:53.414516', 0, 'test_user_gpt_real', '', '', 'test_user_gpt_real@hotmail.com', 0, 1, '2025-10-17 05:10:52.187013');

-- Dumping structure for table db_arsmagica1.auth_user_groups
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

-- Dumping data for table db_arsmagica1.auth_user_groups: ~0 rows (approximately)

-- Dumping structure for table db_arsmagica1.auth_user_user_permissions
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

-- Dumping data for table db_arsmagica1.auth_user_user_permissions: ~0 rows (approximately)

-- Dumping structure for table db_arsmagica1.django_admin_log
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

-- Dumping data for table db_arsmagica1.django_admin_log: ~0 rows (approximately)

-- Dumping structure for table db_arsmagica1.django_content_type
CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table db_arsmagica1.django_content_type: ~7 rows (approximately)
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(22, 'admin', 'logentry'),
	(23, 'auth', 'permission'),
	(24, 'auth', 'group'),
	(25, 'auth', 'user'),
	(26, 'contenttypes', 'contenttype'),
	(27, 'sessions', 'session'),
	(28, 'arsmagica_seasons_app', 'seasonalwork');

-- Dumping structure for table db_arsmagica1.django_migrations
CREATE TABLE IF NOT EXISTS `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table db_arsmagica1.django_migrations: ~18 rows (approximately)
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(1, 'contenttypes', '0001_initial', '2025-10-06 21:22:16.857238'),
	(2, 'auth', '0001_initial', '2025-10-06 21:22:19.452139'),
	(3, 'admin', '0001_initial', '2025-10-06 21:22:19.999007'),
	(4, 'admin', '0002_logentry_remove_auto_add', '2025-10-06 21:22:20.014715'),
	(5, 'admin', '0003_logentry_add_action_flag_choices', '2025-10-06 21:22:20.031497'),
	(6, 'contenttypes', '0002_remove_content_type_name', '2025-10-06 21:22:20.280849'),
	(7, 'auth', '0002_alter_permission_name_max_length', '2025-10-06 21:22:20.520024'),
	(8, 'auth', '0003_alter_user_email_max_length', '2025-10-06 21:22:20.559991'),
	(9, 'auth', '0004_alter_user_username_opts', '2025-10-06 21:22:20.575276'),
	(10, 'auth', '0005_alter_user_last_login_null', '2025-10-06 21:22:20.743846'),
	(11, 'auth', '0006_require_contenttypes_0002', '2025-10-06 21:22:20.755561'),
	(12, 'auth', '0007_alter_validators_add_error_messages', '2025-10-06 21:22:20.772443'),
	(13, 'auth', '0008_alter_user_username_max_length', '2025-10-06 21:22:20.999482'),
	(14, 'auth', '0009_alter_user_last_name_max_length', '2025-10-06 21:22:21.210669'),
	(15, 'auth', '0010_alter_group_name_max_length', '2025-10-06 21:22:21.267207'),
	(16, 'auth', '0011_update_proxy_permissions', '2025-10-06 21:22:21.287444'),
	(17, 'auth', '0012_alter_user_first_name_max_length', '2025-10-06 21:22:21.486209'),
	(18, 'sessions', '0001_initial', '2025-10-06 21:22:21.636255'),
	(19, 'arsmagica_seasons_app', '0001_initial', '2025-10-07 21:37:31.835090'),
	(20, 'arsmagica_seasons_app', '0002_alter_seasonalwork_summary', '2025-10-13 01:03:37.431765');

-- Dumping structure for table db_arsmagica1.django_session
CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table db_arsmagica1.django_session: ~16 rows (approximately)
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('169vt1vo0azks819aai4q6sbpy69bn84', '.eJxVjEEOwiAQRe_C2hBg6ARcuvcMhIFBqgaS0q6Md9cmXej2v_f-S4S4rTVsg5cwZ3EWGsXpd6SYHtx2ku-x3bpMva3LTHJX5EGHvPbMz8vh_h3UOOq3Rib2VAwhW6XspA1D1gUVsPFgweHki9MMaDXbbBxAIqDiASwSgHh_APuKN0c:1v9YUe:1-zs9oveJ13bFTK0gYWS4UE9Q3fpfnW5pB_mrv31dN0', '2025-10-31 00:38:52.581715'),
	('34i56nbs4ycvir6o8e0w9hyt5tme2lte', '.eJxVjEEOwiAQRe_C2hAYIAwu3XsGMsBUqgaS0q6Md9cmXej2v_f-S0Ta1hq3wUucizgL7cXpd0yUH9x2Uu7Ubl3m3tZlTnJX5EGHvPbCz8vh_h1UGvVbh-C0wZTAMLqMjpU1oDwH73TWnspElhANO5unBKgVQADN1iWE7IN4fwDnazci:1v9Y6o:oPjR3QelU_dTOm65J3K184PTWnfiBj7MZlX0hS8HeoM', '2025-10-31 00:14:14.568171'),
	('6cg4ff5948cp9to6s6npfxuh9tac8zuu', '.eJxVjDsOwjAQBe_iGlm7_saU9JzBWnttHECJFCcV4u4QKQW0b2beS0Ta1ha3XpY4sjgL1OL0OybKjzLthO803WaZ52ldxiR3RR60y-vM5Xk53L-DRr19a1sdedApQUAajK_aF1OQC7HJDAxYA2QwkNkiOwys9JCNVS4pDJXE-wMPojgc:1v9Cll:OywJ-8FAUuU7jeDsdPJstSjYPnP4uD0DJ5-wOzRtIus', '2025-10-30 01:27:05.811660'),
	('8qjbqzyp1rc19jvytxc8nbdmrl61cdae', '.eJxVjDsOwjAQBe_iGllrO_5R0nMGa73e4ABypDipEHeHSCmgfTPzXiLhtta0dV7SVMRZaC1Ov2NGenDbSblju82S5rYuU5a7Ig_a5XUu_Lwc7t9BxV6_NTuMGghtBhMUKx5C9ADOgi2GXFARrB6UycxhBMuK2JMZPWAkMFGL9wfnjzc4:1v9YCG:s0ej62nF3-hz80vzwUARk7SO5fW9MmN9Q6mCIKYF5bc', '2025-10-31 00:19:52.271996'),
	('a7l2yj8aabrruvq01j1mrho5rppt04sz', '.eJxVjMsOwiAQRf-FtSE8B3Dp3m8gAwxSNTQp7cr479qkC93ec859sYjb2uI2aIlTYWcmgZ1-x4T5QX0n5Y79NvM893WZEt8VftDBr3Oh5-Vw_w4ajvatURmZwUN1aH0GhSSCLJJq8sa5SkV4MErLKoKmaq32IgEJMio7HWph7w8C_Tfl:1v9Clr:Iwd4EvWf60LIjOzgNx1JqHSQY979MbQf9iXHcUF3jMc', '2025-10-30 01:27:11.501262'),
	('adxvjdeez4baw9huqhol0n1iqxfsdqs2', '.eJxVjEEOwiAQRe_C2pCBQgGX7j0DGWYmUjU0Ke3KeHdt0oVu_3vvv1TGba1567LkidVZ2ahOv2NBekjbCd-x3WZNc1uXqehd0Qft-jqzPC-H-3dQsddvPbpoRys4DMDkI7EF66kkRuEQjUdjUCQQFRCPUoIDKzGAg5AooVPvDxKDOFg:1v9cjs:jBrRfp2etVjvUCjMp-IOX4q4ebrKdanohxv6cBhy24A', '2025-10-31 05:10:52.079670'),
	('c6bfcm8uzjhhnew6cnpz3envidzao4mg', '.eJxVjDEOgzAQBP_iOrIwBmOnTM8b0PluHZNEIGGoovw9skSRtDsz-1YTHXuejoJtmkVdlenU5XeMxE8slciDlvuqeV32bY66KvqkRY-r4HU73b-DTCXXmihaEc8DgnNNYqTQsiX2xpJ3EMfSOgdYJO47NINpEIOEvjcWbVSfL0oMOV0:1v9Clo:JgHivGpAdtiGss3e_Ew9mFf1JkoedUc8tVF2QWwdDP0', '2025-10-30 01:27:08.899508'),
	('d9r6ohakmzgkg2plxkiadtezt4063k0i', '.eJxVjDsOwjAQBe_iGln-EH8o6XMGa3e9JgFkS3FSIe4OkVJA-2bmvUSCbZ3S1nlJcxYXYQZx-h0R6MF1J_kO9dYktbouM8pdkQftcmyZn9fD_TuYoE_f2kEISIHIYCwQ3XkoAyrwzmtkZCrsyYdMOQRnNFqOES14MIq18mDF-wM3LTkC:1v9YUb:11vmG5dMT3x7ER4FW-jq42ApeYQH4gXKbd3OAiD3fx4', '2025-10-31 00:38:49.913622'),
	('jusoxnp37vrp78qwr0ze3uyz0r865zed', '.eJxVjMEOwiAQRP-FsyELyLJ49N5vILCgVA1NSnsy_rtt0oMeZ96beYsQ16WGtZc5jFlchCJx-i1T5GdpO8mP2O6T5Kkt85jkrsiDdjlMubyuh_t3UGOv2_pmEjhW6kxW62j8Fhy4qBOy0QbQoiX0pCyAImSlvTOMgOB19kRWfL7BtDWb:1v9Y6s:495v-TSoaVRCRsshjYuKjRfYf9oOsxgvVUeDPNAeVwQ', '2025-10-31 00:14:18.613026'),
	('jy35423qvwvp307slvdkewcp9b82k76z', '.eJxVjDsOwjAQBe_iGlmJ8SdLSc8ZrF3vGgeQI8VJhbg7iZQC2jcz760irkuJa5M5jqwuygR1-h0J01PqTviB9T7pNNVlHknvij5o07eJ5XU93L-Dgq1stVjgATkbCtxxYI-dS9D3aIAAxBE7L7gxS0yeQgaX_Rl9HqyxlJ36fAEzyjkM:1v9cjo:CALFTZD4NWA4cHPr8_ZI3YN7Qq2CkU_A9NyAlGO1ncA', '2025-10-31 05:10:48.968174'),
	('moheua0ynd9usbxuzkghubgr7zene5bl', '.eJxVjEEOwiAQRe_C2hBhKAWX7nsGMsxMpWpoUtqV8e7apAvd_vfef6mE21rS1mRJE6uLsk6dfseM9JC6E75jvc2a5rouU9a7og_a9DCzPK-H-3dQsJVvHYVDIHByhgw2SEZ0AYwxzBmAiMR0o8s9iEdvqEfLsbMUREbyzkf1_gAf2jjF:1v9YUY:Z8vPRYslVGZXW5Zz61wBRQg8W8ThlB2lcsWFkPrsNio', '2025-10-31 00:38:46.230055'),
	('pw3ocldb0l5xrmguu8j82xqenkdzhv2y', '.eJxVjEEOwiAQRe_C2hBgEDou3fcMBJhBqoYmpV0Z765NutDtf-_9lwhxW2vYOi9hInER2onT75hifnDbCd1ju80yz21dpiR3RR60y3Emfl4P9--gxl6_NfjMhRAUsHUIVDx4nSxqVwoaTCoZP4DzznqjyZ7LoDgzFdIJwVkQ7w_5DzeW:1v9cju:f7CefeSeaM9TotWCDHVBZQb47qNJ32TWIIKY0kgbEdc', '2025-10-31 05:10:54.695595'),
	('q8xfm4yrhvsbl43x1hjgpeww2hh677ph', '.eJxVjEsOAiEQBe_C2hAbkI9L956BNHQjowaSYWZlvLtOMgvdvqp6LxFxXWpcB89xInEWEMThd0yYH9w2Qndsty5zb8s8JbkpcqdDXjvx87K7fwcVR_3WBYG8UqwclZIpgDsFZijFMCJhNtoxauuSTQQpe4fWaO_oGAIozyDeH0RIOQc:1v9Y6t:sm-alAKk9ntrElIWY_pGM-G-NRiC2OM9DGBEo5pCcvs', '2025-10-31 00:14:19.974351'),
	('qi13yddptdouh8dwe16svmnv1d7jps6y', '.eJxVjDsOwjAQBe_iGll2vEBMSZ8zRM-7axJAtpRPhbg7REoB7ZuZ9zI91mXo11mnfhRzMY03h98xgR9aNiJ3lFu1XMsyjcluit3pbLsq-rzu7t_BgHn41hRaUiTnGj0HMBEho03qXcqZIMApqidtOEjg5Bni2cWjy1HAEs37Ay0DOY0:1v9YCB:UyoG2bwas3EuUN0IcJtFsy3ss5fLt0qUuH8EXE_ZiTE', '2025-10-31 00:19:47.540870'),
	('vfnzrrqvilww0m9tyh9ranc5nk7h9qhb', '.eJxVjMsOwiAQRf-FtSEdGHm4dN9vIDADUjU0Ke3K-O_apAvd3nPOfYkQt7WGreclTCwuAow4_Y4p0iO3nfA9ttssaW7rMiW5K_KgXY4z5-f1cP8Oauz1W5MjGyEBOzB45pIHY5CKY-sBU2ZdQOnigDEx0OCYHKIp6LVWXlkr3h8Xhzfm:1v9YCI:fvd-PWAL5Of9S9jlQQRMl8X9l8_oshEveGlrt8cyAf4', '2025-10-31 00:19:54.895801'),
	('vs9dzwu8bi4nyivu9xfuisp5biz0hioz', '.eJxVjEEOwiAQRe_C2hDolIG6dO8ZCAOMVA0kpV0Z765NutDtf-_9l_BhW4vfel78nMRZaC1OvyOF-Mh1J-ke6q3J2Oq6zCR3RR60y2tL-Xk53L-DEnr51pF41IMBlUZSwNpmzWTAERIRMpIDsDQNZDRMCpJCl6PCiMayywzi_QEH2Tf9:1vAbgL:66Y0aHTl_F5AGiBKHV3TLbnULCqzRfn9xH9uwbQN2HM', '2025-11-02 22:15:17.200612');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
