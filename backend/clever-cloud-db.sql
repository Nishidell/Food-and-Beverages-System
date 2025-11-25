-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: b9wkqgu32onfqy0dvyva-mysql.services.clever-cloud.com:21917
-- Generation Time: Nov 25, 2025 at 04:13 AM
-- Server version: 8.4.6-6
-- PHP Version: 8.2.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `b9wkqgu32onfqy0dvyva`
--
CREATE DATABASE IF NOT EXISTS `b9wkqgu32onfqy0dvyva` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `b9wkqgu32onfqy0dvyva`;

-- --------------------------------------------------------

--
-- Table structure for table `accounting_users`
--

CREATE TABLE `accounting_users` (
  `user_id` int NOT NULL,
  `user_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `otp` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `otpExpiresAt` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_active` tinyint(1) DEFAULT '1',
  `otp_attempts` int DEFAULT '0',
  `last_login_at` timestamp NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `accounting_users`
--

INSERT INTO `accounting_users` (`user_id`, `user_name`, `password`, `role`, `otp`, `otpExpiresAt`, `created_at`, `updated_at`, `is_active`, `otp_attempts`, `last_login_at`, `email`) VALUES
(3, 'allen_gueta', '$2b$10$cUhfanawddm3VHTqnZ.whuCnGxjDn9o72HXRshyoWPEtWr9ddgNpS', 'Financial Manager', NULL, NULL, '2025-10-24 09:19:37', '2025-11-23 06:49:42', 1, 0, '2025-11-23 06:49:38', 'guetaallen@gmail.com'),
(8, 'john_doe_accounant', '$2b$10$2qatx7K1g04QK04DKJEey.aFRbHoXhe2X.DYgZqYuRmrnfKAHfo7K', 'Accountant', NULL, NULL, '2025-11-15 07:01:21', '2025-11-15 07:01:21', 1, 0, NULL, 'batallones.juannathaniel.kho@gmail.com'),
(9, 'joren_buagas', '$2b$10$3s1im1gi9f2zrNodJoHUhu9QWE1O/vlt2eAVeSn9g/KRqpCiK7lKW', 'Hotel Manager', NULL, NULL, '2025-11-15 07:02:56', '2025-11-16 02:24:29', 1, 0, '2025-11-16 02:24:32', 'jorenbuagas17@gmail.com'),
(10, 'joshua_delmundo', '$2b$10$pIqugHdUTJiZZk0uDlDGZucjeiVF9bQG.IpS7GMHisseLltew8gL.', 'Auditor', NULL, NULL, '2025-11-15 07:03:40', '2025-11-15 07:28:18', 1, 0, '2025-11-15 07:28:20', 'delmundo.joshua.barba@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `activity_logs`
--

CREATE TABLE `activity_logs` (
  `log_id` int NOT NULL,
  `user_id` int NOT NULL,
  `action` varchar(255) DEFAULT NULL,
  `module` varchar(100) DEFAULT NULL,
  `description` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `activity_logs`
--

INSERT INTO `activity_logs` (`log_id`, `user_id`, `action`, `module`, `description`, `created_at`, `created_by`) VALUES
(1, 1, 'CREATE', 'employees', 'Created employee record EMP-0013', '2024-09-01 10:00:00', 1),
(2, 2, 'UPDATE', 'employees', 'Updated employee record EMP-0008', '2024-09-15 11:30:00', 2),
(3, 3, 'CREATE', 'tickets', 'Created ticket TIC-0001', '2024-10-01 08:35:00', 3),
(4, 3, 'UPDATE', 'tickets', 'Resolved ticket TIC-0001', '2024-10-01 14:00:00', 3),
(5, 5, 'APPROVE', 'leaves', 'Approved leave request LEV-0001', '2024-09-29 09:00:00', 5),
(6, 6, 'APPROVE', 'leaves', 'Approved leave request LEV-0004', '2024-10-21 10:00:00', 6),
(7, 7, 'REJECT', 'leaves', 'Rejected leave request LEV-0008', '2024-10-30 14:00:00', 7),
(8, 1, 'CREATE', 'attendance', 'Clock in recorded for employee ID 1 (ATT-0001)', '2024-10-01 08:00:00', 1),
(9, 2, 'UPDATE', 'positions', 'Updated position POS-0002 salary', '2024-09-20 13:00:00', 2),
(10, 3, 'CREATE', 'departments', 'Created new department', '2024-08-15 09:00:00', 1),
(13, 12, 'CREATE', 'leaves', 'Created leave request LEV-0002', '2024-10-07 18:30:00', 12),
(14, 1, 'LOGIN', 'auth', 'User logged in successfully', '2024-10-09 07:55:00', 1),
(15, 2, 'LOGIN', 'auth', 'User logged in successfully', '2024-10-09 08:00:00', 2),
(16, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-11 05:47:45', 1),
(17, 1, 'DELETE', 'employees', 'Deleted employee Sarah Gomez (EMP-0011) and linked user account', '2025-11-11 05:48:18', 1),
(18, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-11 05:57:50', 1),
(19, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-11 06:47:44', 1),
(20, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-11 07:01:37', 1),
(21, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-11 08:54:33', 1),
(22, 1, 'CREATE', 'tickets', 'Created ticket \"boot issue\" (TIC-0009)', '2025-11-11 08:56:05', 1),
(23, 1, 'CREATE', 'departments', 'Created department Front of House (FOH) (DEP-0004)', '2025-11-11 09:01:02', 1),
(24, 1, 'UPDATE', 'departments', 'Updated department Front of House (FOH) (DEP-0004)', '2025-11-11 09:02:59', 1),
(25, 1, 'CREATE', 'departments', 'Created department Kitchen Operations (DEP-0005)', '2025-11-11 09:05:11', 1),
(26, 1, 'UPDATE', 'departments', 'Updated department Kitchen Operations (DEP-0005)', '2025-11-11 09:05:35', 1),
(27, 1, 'UPDATE', 'departments', 'Updated department Kitchen Operations (DEP-0005)', '2025-11-11 09:06:17', 1),
(28, 1, 'CREATE', 'departments', 'Created department Hotel Service (DEP-0006)', '2025-11-11 09:07:41', 1),
(29, 1, 'CREATE', 'departments', 'Created department Procurement and inventory department (DEP-0007)', '2025-11-11 09:08:53', 1),
(30, 1, 'CREATE', 'departments', 'Created department Finance & Control System (DEP-0008)', '2025-11-11 09:12:03', 1),
(31, 1, 'CREATE', 'departments', 'Created department Hotel maintenance  (DEP-0009)', '2025-11-11 09:16:56', 1),
(32, 1, 'CREATE', 'departments', 'Created department Parking Management (DEP-0010)', '2025-11-11 09:20:39', 1),
(33, 1, 'CREATE', 'departments', 'Created department House keeping (DEP-0011)', '2025-11-11 09:22:06', 1),
(34, 1, 'CREATE', 'positions', 'Created position Cashier (POS-0012)', '2025-11-11 10:21:17', 1),
(35, 1, 'CREATE', 'positions', 'Created position Server (POS-0013)', '2025-11-11 10:23:16', 1),
(36, 1, 'CREATE', 'positions', 'Created position Kitchen Staffs (POS-0014)', '2025-11-11 10:25:12', 1),
(37, 1, 'CREATE', 'positions', 'Created position F&B Manager (POS-0015)', '2025-11-11 10:39:19', 1),
(38, 1, 'CREATE', 'positions', 'Created position Administrator  (POS-0016)', '2025-11-11 10:41:59', 1),
(39, 1, 'UPDATE', 'positions', 'Updated position Administrator  (POS-0016)', '2025-11-11 10:43:20', 1),
(40, 1, 'CREATE', 'positions', 'Created position Housekeeping Manager (POS-0017)', '2025-11-11 10:44:20', 1),
(41, 1, 'UPDATE', 'positions', 'Updated position F&B Manager (POS-0015)', '2025-11-11 10:44:31', 1),
(42, 1, 'CREATE', 'positions', 'Created position Maintenance Manager (POS-0018)', '2025-11-11 10:54:28', 1),
(43, 1, 'CREATE', 'positions', 'Created position Inventory Manager (POS-0019)', '2025-11-11 10:58:35', 1),
(44, 1, 'CREATE', 'positions', 'Created position Parking Manager (POS-0020)', '2025-11-11 11:07:48', 1),
(45, 1, 'CREATE', 'positions', 'Created position House Keeping Staff (POS-0021)', '2025-11-11 11:08:48', 1),
(46, 1, 'UPDATE', 'positions', 'Updated position House Keeping Staff (POS-0021)', '2025-11-11 11:08:54', 1),
(47, 1, 'CREATE', 'positions', 'Created position Maintenance Staff (POS-0022)', '2025-11-11 11:09:12', 1),
(48, 1, 'CREATE', 'positions', 'Created position Hotel Reservation Manager (POS-0023)', '2025-11-11 11:10:24', 1),
(49, 1, 'CREATE', 'positions', 'Created position Hotel Manager (POS-0024)', '2025-11-11 11:11:42', 1),
(50, 1, 'CREATE', 'positions', 'Created position Financial Manager (POS-0025)', '2025-11-11 11:14:44', 1),
(51, 1, 'CREATE', 'departments', 'Created department Accounting (DEP-0012)', '2025-11-11 11:15:43', 1),
(52, 1, 'CREATE', 'positions', 'Created position Accountant (POS-0026)', '2025-11-11 11:16:11', 1),
(53, 1, 'CREATE', 'positions', 'Created position Concierge (POS-0027)', '2025-11-11 11:17:53', 1),
(54, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-11 11:36:57', 1),
(55, 1, 'CREATE', 'employees', 'Created employee Christian Ancog (EMP-0017) with role: employee', '2025-11-11 11:40:03', 1),
(56, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Christian Ancog (ID: 17) using fingerprint ID 1', '2025-11-11 11:40:07', 1),
(57, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Christian Ancog (ID: 17) using fingerprint ID 2', '2025-11-11 11:40:11', 1),
(58, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Christian Ancog (ID: 17) using fingerprint ID 3', '2025-11-11 11:40:18', 1),
(59, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Christian Ancog (ID: 17) using fingerprint ID 4', '2025-11-11 11:40:23', 1),
(60, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Christian Ancog (ID: 17) using fingerprint ID 4', '2025-11-11 11:40:36', 1),
(61, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Christian Ancog (ID: 17) using fingerprint ID 4', '2025-11-11 11:40:44', 1),
(68, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-11 14:47:24', 1),
(72, 1, 'CREATE', 'positions', 'Created position CRM Manager (POS-0028)', '2025-11-11 14:50:25', 1),
(73, 1, 'CREATE', 'departments', 'Created department Customer Service (DEP-0013)', '2025-11-11 14:52:46', 1),
(74, 1, 'UPDATE', 'positions', 'Updated position CRM Manager (POS-0028)', '2025-11-11 14:53:14', 1),
(78, 1, 'CREATE', 'employees', 'Created employee Nicole Mayo (EMP-0018) with role: employee', '2025-11-11 15:03:38', 1),
(80, 1, 'UPDATE', 'employees', 'Updated employee Nicole Mayo (EMP-0018)', '2025-11-11 15:05:36', 1),
(81, 1, 'UPDATE', 'employees', 'Updated employee Nicole Mayo (EMP-0018)', '2025-11-11 15:21:03', 1),
(82, 1, 'CREATE', 'employees', 'Created employee Vincent Torio (EMP-0019) with role: employee', '2025-11-11 15:31:19', 1),
(83, 3, 'LOGIN', 'auth', 'User itadmin logged in', '2025-11-11 15:33:05', 3),
(84, 19, 'LOGIN', 'auth', 'User vincent logged in', '2025-11-11 15:33:30', 19),
(85, 2, 'LOGIN', 'auth', 'User hradmin logged in', '2025-11-11 15:36:13', 2),
(86, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-11 15:36:30', 1),
(87, 1, 'CREATE', 'employees', 'Created employee John Wilmer Tima-an (EMP-0020) with role: employee', '2025-11-11 15:57:41', 1),
(88, 1, 'CREATE', 'employees', 'Created employee Gabriel Chavez (EMP-0021) with role: employee', '2025-11-11 17:25:45', 1),
(89, 1, 'CREATE', 'employees', 'Created employee Lawrence Savariz (EMP-0022) with role: admin', '2025-11-11 17:57:10', 1),
(90, 1, 'UPDATE', 'employees', 'Updated employee Gabriel Chavez (EMP-0021)', '2025-11-11 18:00:46', 1),
(91, 1, 'UPDATE', 'employees', 'Updated employee Gabriel Chavez (EMP-0021)', '2025-11-11 18:01:24', 1),
(92, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-11 18:07:35', 1),
(93, 1, 'UPDATE', 'employees', 'Updated employee Gabriel Chavez (EMP-0021)', '2025-11-11 18:10:00', 1),
(94, 1, 'UPDATE', 'employees', 'Updated employee Vincent Torio (EMP-0019)', '2025-11-11 18:10:27', 1),
(95, 1, 'UPDATE', 'employees', 'Updated employee Lawrence Savariz (EMP-0022)', '2025-11-11 18:16:53', 1),
(96, 1, 'UPDATE', 'employees', 'Updated employee Gabriel Chavez (EMP-0021)', '2025-11-11 18:44:51', 1),
(97, 1, 'UPDATE', 'employees', 'Updated employee Gabriel Chavez (EMP-0021) - Role changed from \'employee\' to \'admin\' with sub_role \'front_desk\'', '2025-11-11 19:14:55', 1),
(98, 1, 'UPDATE', 'employees', 'Updated employee Gabriel Chavez (EMP-0021) - Role changed from \'admin\' to \'employee\'', '2025-11-11 19:29:00', 1),
(99, 1, 'UPDATE', 'employees', 'Updated employee Gabriel Chavez (EMP-0021)', '2025-11-11 19:30:27', 1),
(100, 1, 'UPDATE', 'employees', 'Updated employee Gabriel Chavez (EMP-0021)', '2025-11-11 19:31:44', 1),
(101, 1, 'UPDATE', 'employees', 'Updated employee Gabriel Chavez (EMP-0021)', '2025-11-11 19:38:39', 1),
(102, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-11 19:44:28', 1),
(103, 1, 'UPDATE', 'employees', 'Updated employee Gabriel Chavez (EMP-0021)', '2025-11-11 19:45:04', 1),
(104, 1, 'UPDATE', 'employees', 'Updated employee Gabriel Chavez (EMP-0021)', '2025-11-11 19:56:25', 1),
(105, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-12 02:27:37', 1),
(106, 1, 'UPDATE', 'employees', 'Updated employee Gabriel Chavez (EMP-0021)', '2025-11-12 02:36:09', 1),
(107, 1, 'UPDATE', 'employees', 'Updated employee Gabriel Chavez (EMP-0021)', '2025-11-12 02:36:33', 1),
(108, 1, 'UPDATE', 'employees', 'Updated employee Vincent Torio (EMP-0019)', '2025-11-12 02:58:16', 1),
(109, 1, 'UPDATE', 'employees', 'Updated employee Vincent Torio (EMP-0019)', '2025-11-12 03:00:15', 1),
(110, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-12 03:04:41', 1),
(111, 1, 'UPDATE', 'employees', 'Updated employee Gabriel Chavez (EMP-0021) - Role changed from \'employee\' to \'admin\' with sub_role \'front_desk\'', '2025-11-12 03:06:56', 1),
(112, 1, 'UPDATE', 'employees', 'Updated employee Gabriel Chavez (EMP-0021) - Role changed from \'admin\' to \'employee\'', '2025-11-12 03:07:18', 1),
(113, 1, 'UPDATE', 'employees', 'Updated employee Gabriel Chavez (EMP-0021)', '2025-11-12 03:07:28', 1),
(114, 1, 'UPDATE', 'employees', 'Updated employee Gabriel Chavez (EMP-0021)', '2025-11-12 03:08:16', 1),
(115, 1, 'UPDATE', 'employees', 'Updated employee Gabriel Chavez (EMP-0021)', '2025-11-12 03:09:02', 1),
(116, 1, 'UPDATE', 'employees', 'Updated employee Gabriel Chavez (EMP-0021)', '2025-11-12 03:11:26', 1),
(117, 1, 'DELETE', 'employees', 'Deleted employee kurt Alicando (null) and linked user account', '2025-11-12 03:12:32', 1),
(118, 1, 'DELETE', 'employees', 'Deleted employee Test Admin (null) and linked user account', '2025-11-12 03:12:40', 1),
(119, 1, 'DELETE', 'employees', 'Deleted employee John Weak (null) and linked user account', '2025-11-12 03:12:46', 1),
(120, 1, 'UPDATE', 'employees', 'Updated employee Michael Reyes (EMP-0013)', '2025-11-12 03:14:23', 1),
(121, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-12 06:18:34', 1),
(122, 1, 'UPDATE', 'employees', 'Updated employee Gabriel Chavez (EMP-0021)', '2025-11-12 06:22:10', 1),
(123, 1, 'UPDATE', 'employees', 'Updated employee Gabriel Chavez (EMP-0021)', '2025-11-12 06:22:45', 1),
(124, 1, 'UPDATE', 'employees', 'Updated employee Gabriel Chavez (EMP-0021)', '2025-11-12 06:29:27', 1),
(125, 1, 'UPDATE', 'employees', 'Updated employee John Wilmer Tima-an (EMP-0020)', '2025-11-12 06:30:17', 1),
(126, 1, 'UPDATE', 'employees', 'Updated employee John Wilmer Tima-an (EMP-0020)', '2025-11-12 06:31:07', 1),
(127, 1, 'UPDATE', 'employees', 'Updated employee John Wilmer Tima-an (EMP-0020)', '2025-11-12 06:35:17', 1),
(128, 1, 'UPDATE', 'employees', 'Updated employee Gabriel Chavez (EMP-0021)', '2025-11-12 06:41:39', 1),
(129, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-12 13:48:51', 1),
(130, 1, 'UPDATE', 'employees', 'Updated employee Gabriel Aaron Chavez (EMP-0021)', '2025-11-12 14:06:15', 1),
(131, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-12 15:12:03', 1),
(132, 1, 'UPDATE', 'employees', 'Updated employee John Wilmer Tima-an (EMP-0020)', '2025-11-12 15:12:40', 1),
(133, 1, 'UPDATE', 'employees', 'Updated employee Michael Reyes (EMP-0013)', '2025-11-12 15:16:39', 1),
(134, 1, 'UPDATE', 'employees', 'Updated employee Vincent Torio (EMP-0019)', '2025-11-12 15:19:47', 1),
(135, 1, 'UPDATE', 'employees', 'Updated employee Michael Reyes (EMP-0013)', '2025-11-12 15:22:00', 1),
(136, 1, 'CREATE', 'employees', 'Created employee Emmanuel Frias (EMP-0023) with role: employee', '2025-11-12 15:32:06', 1),
(137, 1, 'CREATE', 'employees', 'Created employee Christian Ancog (EMP-0024) with role: employee', '2025-11-12 16:41:28', 1),
(138, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Christian Ancog (ID: 24) using fingerprint ID 1', '2025-11-12 16:41:33', 1),
(139, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Christian Ancog (ID: 24) using fingerprint ID 2', '2025-11-12 16:41:38', 1),
(140, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Christian Ancog (ID: 24) using fingerprint ID 9', '2025-11-12 16:41:46', 1),
(141, 1, 'UPDATE', 'attendance', 'Updated attendance status to on_leave for attendance ATT-0091', '2025-11-12 16:58:41', 1),
(142, 1, 'UPDATE', 'attendance', 'Updated attendance status to absent for attendance ATT-0091', '2025-11-12 16:58:44', 1),
(143, 1, 'UPDATE', 'attendance', 'Updated attendance status to on_leave for attendance ATT-0091', '2025-11-12 16:58:47', 1),
(144, 1, 'DELETE', 'employees', 'Deleted employee Christian Ancog (EMP-0024) and linked user account', '2025-11-12 16:59:53', 1),
(145, 1, 'CREATE', 'employees', 'Created employee Christian Ancog (EMP-0025) with role: employee', '2025-11-12 17:01:03', 1),
(146, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Christian Ancog (ID: 25) using fingerprint ID 1', '2025-11-12 17:01:09', 1),
(147, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Christian Ancog (ID: 25) using fingerprint ID 8', '2025-11-12 17:01:15', 1),
(148, 1, 'CREATE', 'employees', 'Created employee Matt Henry Buenaventura (EMP-0026) with role: employee', '2025-11-12 17:12:02', 1),
(149, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Matt Henry Buenaventura (ID: 26) using fingerprint ID 1', '2025-11-12 17:12:06', 1),
(150, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Matt Henry Buenaventura (ID: 26) using fingerprint ID 10', '2025-11-12 17:12:10', 1),
(151, 1, 'CREATE', 'employees', 'Created employee Shawn Cordero (EMP-0027) with role: employee', '2025-11-12 17:33:24', 1),
(152, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Shawn Cordero (ID: 27) using fingerprint ID 1', '2025-11-12 17:33:40', 1),
(153, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Shawn Cordero (ID: 27) using fingerprint ID 11', '2025-11-12 17:33:45', 1),
(154, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-13 01:35:24', 1),
(155, 1, 'DELETE', 'employees', 'Deleted employee F&B Admin User (null) and linked user account', '2025-11-13 02:19:43', 1),
(156, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-13 02:46:30', 1),
(157, 1, 'CREATE', 'employees', 'Created employee Ethan Atienza (EMP-0029) with role: employee', '2025-11-13 02:47:37', 1),
(158, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Ethan Atienza (ID: 29) using fingerprint ID 1', '2025-11-13 02:48:43', 1),
(159, 1, 'CREATE', 'employees', 'Created employee Testicles Tedst (EMP-0030) with role: employee', '2025-11-13 02:49:07', 1),
(161, 1, 'DELETE', 'employees', 'Deleted employee Christian Ancog (EMP-0025) and linked user account', '2025-11-13 03:09:17', 1),
(162, 1, 'CREATE', 'employees', 'Created employee Christian Ancog (EMP-0031) with role: employee', '2025-11-13 03:10:05', 1),
(164, 1, 'DELETE', 'employees', 'Deleted employee Christian Ancog (EMP-0031) and linked user account', '2025-11-13 03:10:22', 1),
(165, 1, 'CREATE', 'employees', 'Created employee Christian Ancog (EMP-0032) with role: employee', '2025-11-13 03:11:19', 1),
(166, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Christian Ancog (ID: 32) using fingerprint ID 2', '2025-11-13 03:11:21', 1),
(168, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-13 03:15:55', 1),
(169, 1, 'DELETE', 'employees', 'Deleted employee Matt Henry Buenaventura (EMP-0026) and linked user account', '2025-11-13 03:16:09', 1),
(170, 1, 'CREATE', 'employees', 'Created employee Matt Henry Buenaventura (EMP-0033) with role: employee', '2025-11-13 03:17:17', 1),
(171, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Matt Henry Buenaventura (ID: 33) using fingerprint ID 3', '2025-11-13 03:17:32', 1),
(173, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-13 04:57:43', 1),
(174, 1, 'CREATE', 'employees', 'Created employee Imma Esrada (EMP-0034) with role: employee', '2025-11-13 05:10:08', 1),
(175, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Imma Esrada (ID: 34) using fingerprint ID 4', '2025-11-13 05:10:14', 1),
(177, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-13 11:55:06', 1),
(178, 1, 'CREATE', 'employees', 'Created employee Meryl Alcantra (EMP-0036) with role: employee', '2025-11-13 11:57:24', 1),
(179, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Meryl Alcantra (ID: 36) using fingerprint ID 5', '2025-11-13 11:57:29', 1),
(181, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-13 12:15:27', 1),
(182, 1, 'CREATE', 'employees', 'Created employee Chong Huazai (EMP-0037) with role: employee', '2025-11-13 12:17:40', 1),
(183, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Chong Huazai (ID: 37) using fingerprint ID 6', '2025-11-13 12:17:47', 1),
(185, 1, 'CREATE', 'employees', 'Created employee Christian Abrantes (EMP-0038) with role: employee', '2025-11-13 12:22:38', 1),
(186, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Christian Abrantes (ID: 38) using fingerprint ID 7', '2025-11-13 12:22:42', 1),
(187, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Christian Abrantes (ID: 38) using fingerprint ID 7', '2025-11-13 12:22:52', 1),
(188, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Christian Abrantes (ID: 38) using fingerprint ID 7', '2025-11-13 12:23:09', 1),
(190, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-13 16:10:30', 1),
(191, 1, 'DELETE', 'employees', 'Deleted employee kurt Alicando (null) and linked user account', '2025-11-13 16:10:45', 1),
(192, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-14 01:28:52', 1),
(193, 1, 'CREATE', 'positions', 'Created position Waiter (POS-0029)', '2025-11-14 01:30:40', 1),
(194, 19, 'LOGIN', 'auth', 'User vincent logged in', '2025-11-14 01:39:42', 19),
(195, 19, 'LOGIN', 'auth', 'User Vincent logged in', '2025-11-14 01:43:10', 19),
(196, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-14 04:00:33', 1),
(199, 1, 'UPDATE', 'employees', 'Updated employee Christian Ancog (EMP-0032)', '2025-11-14 04:16:45', 1),
(202, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-14 04:46:40', 1),
(210, 1, 'DELETE', 'employees', 'Deleted employee Testicles Tedst (EMP-0030) and linked user account', '2025-11-14 06:23:49', 1),
(211, 1, 'DELETE', 'employees', 'Deleted employee Christian Abrantes (EMP-0038) and linked user account', '2025-11-14 06:23:58', 1),
(214, 3, 'LOGIN', 'auth', 'User itadmin logged in', '2025-11-14 06:29:08', 3),
(215, 3, 'UPDATE', 'positions', 'Updated position Waiter (POS-0029)', '2025-11-14 06:30:19', 3),
(216, 3, 'LOGIN', 'auth', 'User itadmin logged in', '2025-11-14 07:00:09', 3),
(217, 3, 'UPDATE', 'departments', 'Updated department Customer Service (DEP-0013)', '2025-11-14 07:02:10', 3),
(218, 3, 'UPDATE', 'departments', 'Updated department Customer Services (DEP-0013)', '2025-11-14 07:02:17', 3),
(219, 2, 'LOGIN', 'auth', 'User hradmin logged in', '2025-11-14 07:14:28', 2),
(221, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-14 13:27:37', 1),
(222, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-14 14:18:07', 1),
(223, 1, 'DELETE', 'employees', 'Deleted employee Chong Huazai (EMP-0037) and linked user account', '2025-11-14 14:18:13', 1),
(224, 1, 'DELETE', 'employees', 'Deleted employee Meryl Alcantra (EMP-0036) and linked user account', '2025-11-14 14:18:16', 1),
(225, 1, 'DELETE', 'employees', 'Deleted employee Imma Esrada (EMP-0034) and linked user account', '2025-11-14 14:18:19', 1),
(226, 1, 'DELETE', 'employees', 'Deleted employee Matt Henry Buenaventura (EMP-0033) and linked user account', '2025-11-14 14:18:22', 1),
(227, 1, 'DELETE', 'employees', 'Deleted employee Christian Ancog (EMP-0032) and linked user account', '2025-11-14 14:18:25', 1),
(228, 1, 'CREATE', 'employees', 'Created employee Christian Ancog (EMP-0039) with role: admin', '2025-11-14 14:23:11', 1),
(229, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Christian Ancog (ID: 39) using fingerprint ID 1', '2025-11-14 14:24:00', 1),
(233, 1, 'UPDATE', 'employees', 'Updated employee Christian Ancog (EMP-0039) - Role changed from \'admin\' to \'employee\'', '2025-11-14 14:51:20', 1),
(234, 1, 'UPDATE', 'employees', 'Updated employee Christian Ancog (EMP-0039)', '2025-11-14 14:51:35', 1),
(237, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-14 16:55:39', 1),
(240, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-14 17:00:24', 1),
(241, 6, 'LOGIN', 'auth', 'User itsupervisor logged in', '2025-11-14 17:00:44', 6),
(242, 6, 'UPDATE', 'leaves', 'Approved leave request LEV-0012 for employee ID 39; deducted 1 credit', '2025-11-14 17:00:50', 6),
(244, 6, 'LOGIN', 'auth', 'User itsupervisor logged in', '2025-11-14 17:03:27', 6),
(245, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-14 17:04:00', 1),
(246, 1, 'DELETE', 'leaves', 'Deleted leave request LEV-0012 for employee ID 39', '2025-11-14 17:04:48', 1),
(247, 3, 'LOGIN', 'auth', 'User itadmin logged in', '2025-11-14 17:12:37', 3),
(252, 3, 'LOGIN', 'auth', 'User itadmin logged in', '2025-11-15 01:37:44', 3),
(253, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-15 01:41:30', 1),
(254, 1, 'UPDATE', 'tickets', 'Updated ticket TIC-0010 status to resolved', '2025-11-15 01:42:01', 1),
(255, 2, 'LOGIN', 'auth', 'User hradmin logged in', '2025-11-15 01:42:25', 2),
(256, 5, 'LOGIN', 'auth', 'User hrsupervisor logged in', '2025-11-15 01:42:50', 5),
(257, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-15 02:01:00', 1),
(258, 1, 'CREATE', 'positions', 'Created position Cashier (POS-0030)', '2025-11-15 02:02:55', 1),
(259, 1, 'CREATE', 'positions', 'Created position Stock Controller (POS-0031)', '2025-11-15 02:03:25', 1),
(260, 1, 'UPDATE', 'positions', 'Updated position Cashier (POS-0030)', '2025-11-15 02:03:35', 1),
(261, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-15 03:30:46', 1),
(262, 1, 'UPDATE', 'users', 'Updated user superadmin (ID: 1)', '2025-11-15 03:31:17', 1),
(263, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-15 03:31:33', 1),
(265, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-15 03:33:17', 1),
(272, 40, 'CREATE', 'tickets', 'Public ticket created (TIC-0011) by anonymous', '2025-11-15 04:08:43', 40),
(273, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-15 04:09:07', 1),
(274, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-16 00:29:04', 1),
(275, 1, 'CREATE', 'attendance', 'Clock in recorded for employee ID 29 (ATT-0003)', '2025-11-16 00:32:42', 1),
(276, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-16 00:33:49', 1),
(277, 1, 'CREATE', 'attendance', 'Clock in recorded for employee ID 22 (ATT-0004)', '2025-11-16 00:40:36', 1),
(278, 1, 'CREATE', 'attendance', 'Clock in recorded for employee ID 18 (ATT-0005)', '2025-11-16 00:52:06', 1),
(279, 3, 'LOGIN', 'auth', 'User itadmin logged in', '2025-11-18 06:51:38', 3),
(280, 3, 'UPDATE', 'employees', 'Updated employee Juan Dela Cruz (EMP-0003)', '2025-11-18 06:54:28', 3),
(281, 3, 'UPDATE', 'auth', 'Password reset via OTP', '2025-11-18 11:07:57', 3),
(282, 3, 'LOGIN', 'auth', 'User itadmin logged in', '2025-11-18 11:08:20', 3),
(283, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-18 14:13:28', 1),
(284, 1, 'UPDATE', 'employees', 'Updated employee Christian Ancog (EMP-0039)', '2025-11-18 14:16:39', 1),
(285, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-18 14:41:26', 1),
(287, 6, 'LOGIN', 'auth', 'User itsupervisor logged in', '2025-11-19 09:18:21', 6),
(289, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-19 13:27:31', 1),
(294, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-19 17:26:42', 1),
(295, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-19 17:50:15', 1),
(296, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-19 18:21:02', 1),
(297, 2, 'LOGIN', 'auth', 'User hradmin logged in', '2025-11-20 01:47:12', 2),
(298, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-20 01:47:55', 1),
(299, 1, 'CREATE', 'employees', 'Created employee Ezekiel De Leon (EMP-0041) with role: employee', '2025-11-20 01:58:13', 1),
(300, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-20 02:13:12', 1),
(301, 1, 'CREATE', 'employees', 'Created employee Sophia Santos (EMP-0042) with role: employee', '2025-11-20 02:24:17', 1),
(302, 1, 'CREATE', 'employees', 'Created employee Genkei Domingo (EMP-0043) with role: employee', '2025-11-20 02:32:14', 1),
(303, 1, 'CREATE', 'employees', 'Created employee Hazel Lacson (EMP-0044) with role: employee', '2025-11-20 02:37:50', 1),
(304, 1, 'CREATE', 'employees', 'Created employee Theo Barrientos (EMP-0045) with role: employee', '2025-11-20 02:46:07', 1),
(305, 1, 'DELETE', 'employees', 'Deleted employee John Wilmer Tima-an (EMP-0020) and linked user account', '2025-11-20 03:11:37', 1),
(306, 1, 'CREATE', 'employees', 'Created employee John Wilmer Timaan (EMP-0046) with role: employee', '2025-11-20 03:23:17', 1),
(307, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-20 04:08:19', 1),
(308, 1, 'CREATE', 'employees', 'Created employee Ryan Marasigan (EMP-0047) with role: employee', '2025-11-20 04:44:49', 1),
(309, 1, 'UPDATE', 'employees', 'Updated employee Ryan Marasigan (EMP-0047)', '2025-11-20 04:50:18', 1),
(313, 1, 'DELETE', 'employees', 'Deleted employee Christian Ancog (EMP-0039) and linked user account', '2025-11-20 05:05:28', 1),
(314, 47, 'UPDATE', 'auth', 'Password reset via OTP', '2025-11-20 05:08:03', 47),
(315, 47, 'LOGIN', 'auth', 'User ryan878 logged in', '2025-11-20 05:08:19', 47),
(316, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-20 06:32:39', 1),
(317, 1, 'CREATE', 'employees', 'Created employee Tawsdfa Tasdas (EMP-0048) with role: employee', '2025-11-20 06:35:35', 1),
(318, 48, 'UPDATE', 'employees', 'Fingerprint enrolled for employee ID 48 (Fingerprint ID: 123)', '2025-11-20 06:35:46', 48),
(319, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-20 07:00:05', 1),
(320, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-20 07:00:20', 1),
(321, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-20 07:28:16', 1),
(322, 1, 'UPDATE', 'employees', 'Updated employee Ryan Marasigan (EMP-0047)', '2025-11-20 07:32:13', 1),
(323, 1, 'UPDATE', 'employees', 'Updated employee Ryan Marasigan (EMP-0047)', '2025-11-20 07:38:01', 1),
(324, 1, 'UPDATE', 'employees', 'Updated employee Tawsdfa Tasdas (EMP-0048)', '2025-11-20 07:41:01', 1),
(325, 1, 'UPDATE', 'employees', 'Updated employee Tawsdfa Tasdas (EMP-0048)', '2025-11-20 07:41:56', 1),
(326, 1, 'CREATE', 'employees', 'Created employee Paciano Rizal (EMP-0049) with role: employee', '2025-11-20 07:47:38', 1),
(327, 49, 'LOGIN', 'auth', 'User paciano963 logged in', '2025-11-20 07:50:46', 49),
(328, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-20 08:00:19', 1),
(329, 5, 'LOGIN', 'auth', 'User hrsupervisor logged in', '2025-11-20 08:08:34', 5),
(330, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-20 08:18:30', 1),
(331, 1, 'DELETE', 'leaves', 'Deleted leave request LEV-0008 for employee ID 13', '2025-11-20 08:18:59', 1),
(332, 1, 'UPDATE', 'tickets', 'Updated ticket TIC-0003 status to resolved', '2025-11-20 08:20:21', 1),
(333, 1, 'DELETE', 'employees', 'Deleted employee Lisa Tan (EMP-0008) and linked user account', '2025-11-20 08:21:12', 1),
(334, 1, 'DELETE', 'employees', 'Deleted employee Mark Villanueva (EMP-0009) and linked user account', '2025-11-20 08:21:17', 1),
(335, 49, 'LOGIN', 'auth', 'User paciano963 logged in', '2025-11-20 08:23:42', 49),
(336, 49, 'UPDATE', 'users', 'Updated user paciano963 (ID: 49)', '2025-11-20 08:25:08', 49),
(337, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-20 11:14:05', 1),
(338, 49, 'LOGIN', 'auth', 'User PacianoRizz logged in', '2025-11-20 11:15:42', 49),
(339, 49, 'UPDATE', 'employees', 'Updated employee Paciano Rizal (EMP-0049)', '2025-11-20 11:16:41', 49),
(340, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-20 13:49:14', 1),
(341, 1, 'UPDATE', 'employees', 'Updated employee Paciano Rizal (EMP-0049)', '2025-11-20 14:02:24', 1),
(342, 49, 'LOGIN', 'auth', 'User PacianoRizz logged in', '2025-11-20 14:47:07', 49),
(343, 49, 'UPDATE', 'users', 'Updated user PacianoRizz (ID: 49)', '2025-11-20 14:50:13', 49),
(344, 49, 'UPDATE', 'users', 'Updated user PacianoRiz (ID: 49)', '2025-11-20 14:51:45', 49),
(345, 49, 'UPDATE', 'users', 'Updated user PacianoRizz (ID: 49)', '2025-11-20 14:51:48', 49),
(346, 49, 'UPDATE', 'users', 'Updated user PacianoRizz (ID: 49)', '2025-11-20 14:51:50', 49),
(347, 49, 'UPDATE', 'users', 'Updated user PacianoRizz (ID: 49)', '2025-11-20 14:51:57', 49),
(348, 49, 'UPDATE', 'users', 'Updated user PacianoRiz (ID: 49)', '2025-11-20 14:53:32', 49),
(349, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-20 15:55:59', 1),
(350, 49, 'LOGIN', 'auth', 'User PacianoRiz logged in', '2025-11-20 15:58:29', 49),
(351, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-20 16:26:57', 1),
(352, 1, 'CREATE', 'employees', 'Created employee Christian Ancog (EMP-0050) with role: employee', '2025-11-20 16:30:16', 1),
(353, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Christian Ancog (ID: 50) using fingerprint ID 124', '2025-11-20 16:30:47', 1),
(354, 50, 'UPDATE', 'employees', 'Fingerprint enrolled for employee ID 50 (Fingerprint ID: 124)', '2025-11-20 16:31:00', 50),
(355, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-20 16:57:39', 1),
(356, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-20 17:03:26', 1),
(357, 1, 'CREATE', 'employees', 'Created employee Christian Ancog (EMP-0051) with role: employee', '2025-11-20 17:06:09', 1),
(358, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Christian Ancog (ID: 51) using fingerprint ID 1', '2025-11-20 17:06:17', 1),
(360, 1, 'CREATE', 'attendance', 'Clock in recorded for employee ID 47 (ATT-0007)', '2025-11-20 17:13:48', 1),
(361, 1, 'CREATE', 'attendance', 'Clock in recorded for employee ID 46 (ATT-0008)', '2025-11-20 17:13:59', 1),
(362, 1, 'CREATE', 'attendance', 'Clock in recorded for employee ID 45 (ATT-0009)', '2025-11-20 17:14:09', 1),
(363, 1, 'CREATE', 'attendance', 'Clock in recorded for employee ID 44 (ATT-0010)', '2025-11-20 17:14:17', 1),
(364, 1, 'CREATE', 'attendance', 'Clock in recorded for employee ID 43 (ATT-0011)', '2025-11-20 17:14:24', 1),
(365, 1, 'CREATE', 'attendance', 'Clock in recorded for employee ID 42 (ATT-0012)', '2025-11-20 17:14:33', 1),
(366, 1, 'CREATE', 'attendance', 'Clock in recorded for employee ID 41 (ATT-0013)', '2025-11-20 17:14:40', 1),
(367, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-20 17:15:18', 1),
(368, 5, 'LOGIN', 'auth', 'User hrsupervisor logged in', '2025-11-20 17:39:09', 5),
(369, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-20 17:55:17', 1),
(370, 1, 'DELETE', 'employees', 'Deleted employee Christian Ancog (EMP-0051) and linked user account', '2025-11-20 18:35:26', 1),
(371, 1, 'CREATE', 'employees', 'Created employee Christian Ancog (EMP-0052) with role: employee', '2025-11-20 18:42:00', 1),
(372, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Christian Ancog (ID: 52) using fingerprint ID 1', '2025-11-20 18:55:13', 1),
(374, 1, 'CREATE', 'employees', 'Created employee Matt Henry Buenaventura (EMP-0053) with role: employee', '2025-11-20 19:16:45', 1),
(375, 1, 'DELETE', 'employees', 'Deleted employee Matt Henry Buenaventura (EMP-0053) and linked user account', '2025-11-20 19:18:14', 1),
(376, 1, 'CREATE', 'employees', 'Created employee Matt Henry Buenaventura (EMP-0054) with role: employee', '2025-11-20 19:20:24', 1),
(377, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Matt Henry Buenaventura (ID: 54) using fingerprint ID 2', '2025-11-20 19:20:34', 1),
(379, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-20 19:22:03', 1),
(380, 1, 'DELETE', 'employees', 'Deleted employee Matt Henry Buenaventura (EMP-0054) and linked user account', '2025-11-20 19:22:33', 1),
(381, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-21 06:23:28', 1),
(382, 1, 'UPDATE', 'positions', 'Updated position Administrator  (POS-0016)', '2025-11-21 06:24:04', 1),
(383, 1, 'UPDATE', 'employees', 'Updated employee Theo Barrientos (EMP-0045)', '2025-11-21 06:27:11', 1),
(384, 1, 'UPDATE', 'employees', 'Updated employee Ryan Marasigan (EMP-0047)', '2025-11-21 06:28:35', 1),
(385, 1, 'UPDATE', 'attendance', 'Updated attendance status to absent for attendance ATT-0007', '2025-11-21 06:29:25', 1),
(386, 1, 'UPDATE', 'employees', 'Updated employee John Wilmer Timaan (EMP-0046)', '2025-11-21 06:35:14', 1),
(387, 1, 'UPDATE', 'employees', 'Updated employee Ryan Marasigan (EMP-0047)', '2025-11-21 06:36:01', 1),
(388, 1, 'UPDATE', 'employees', 'Updated employee Ryan Marasigan (EMP-0047)', '2025-11-21 06:39:40', 1),
(389, 1, 'DELETE', 'employees', 'Deleted employee John Wilmer Timaan (EMP-0046) and linked user account', '2025-11-21 06:42:57', 1),
(390, 1, 'CREATE', 'employees', 'Created employee John Wilmer Ti-maan (EMP-0056) with role: employee', '2025-11-21 06:46:47', 1),
(391, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee John Wilmer Ti-maan (ID: 56) using fingerprint ID 2', '2025-11-21 06:46:59', 1),
(392, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee John Wilmer Ti-maan (ID: 56) using fingerprint ID 4', '2025-11-21 06:47:25', 1),
(393, 56, 'UPDATE', 'employees', 'Fingerprint enrolled for employee ID 56 (Fingerprint ID: 4)', '2025-11-21 06:47:47', 56),
(394, 1, 'DELETE', 'employees', 'Deleted employee Marx Elis Suarez (EMP-0055) and linked user account', '2025-11-21 06:47:59', 1),
(395, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-21 15:10:13', 1),
(396, 1, 'CREATE', 'employees', 'Created employee Angelo Gallardo (EMP-0057) with role: employee', '2025-11-21 16:03:05', 1),
(397, 1, 'CREATE', 'employees', 'Created employee Morris Dalisay (EMP-0058) with role: employee', '2025-11-21 16:27:33', 1),
(398, 1, 'CREATE', 'employees', 'Created employee Louvel Navarro (EMP-0059) with role: employee', '2025-11-21 16:32:17', 1),
(399, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-21 16:32:34', 1),
(400, 1, 'CREATE', 'employees', 'Created employee Aaron Apostol (EMP-0060) with role: employee', '2025-11-21 16:53:46', 1),
(401, 1, 'CREATE', 'attendance', 'Clock in recorded for employee ID 57 (ATT-0016)', '2025-11-21 17:05:34', 1),
(402, 1, 'CREATE', 'attendance', 'Clock in recorded for employee ID 60 (ATT-0017)', '2025-11-21 17:07:28', 1),
(403, 1, 'CREATE', 'attendance', 'Clock in recorded for employee ID 59 (ATT-0018)', '2025-11-21 17:07:39', 1),
(404, 1, 'CREATE', 'attendance', 'Clock in recorded for employee ID 58 (ATT-0019)', '2025-11-21 17:07:43', 1),
(405, 1, 'UPDATE', 'attendance', 'Updated attendance status to absent for attendance ATT-0016', '2025-11-21 17:08:28', 1),
(406, 1, 'UPDATE', 'attendance', 'Updated attendance status to absent for attendance ATT-0017', '2025-11-21 17:08:45', 1),
(407, 1, 'CREATE', 'employees', 'Created employee Marx Elis Suarez (EMP-0061) with role: employee', '2025-11-21 17:38:59', 1),
(408, 1, 'CREATE', 'attendance', 'Auto-marked 25 employees absent for 2025-11-21', '2025-11-21 17:44:32', 1),
(409, 1, 'CREATE', 'attendance', 'Auto-marked 0 employees absent for 2025-11-21', '2025-11-21 17:50:35', 1),
(410, 5, 'LOGIN', 'auth', 'User hrsupervisor logged in', '2025-11-21 18:22:15', 5),
(411, 1, 'UPDATE', 'employees', 'Updated employee Marx Elis Suarez (EMP-0061)', '2025-11-21 18:45:01', 1),
(412, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-21 19:13:44', 1),
(413, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-22 02:56:07', 1),
(414, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-22 03:14:55', 1),
(415, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-22 06:01:08', 1),
(416, 1, 'UPDATE', 'employees', 'Updated employee Louvel Navarro (EMP-0059)', '2025-11-22 06:24:17', 1),
(417, 1, 'UPDATE', 'employees', 'Updated employee Aaron Apostol (EMP-0060)', '2025-11-22 06:27:50', 1),
(418, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-22 06:33:07', 1),
(419, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-22 15:33:08', 1),
(420, 1, 'UPDATE', 'employees', 'Updated employee Super Admin (EMP-0001)', '2025-11-22 16:11:12', 1),
(421, 1, 'UPDATE', 'employees', 'Updated employee Super Admin (EMP-0001) - Role changed from \'superadmin\' to \'employee\'', '2025-11-22 16:13:22', 1),
(422, 5, 'LOGIN', 'auth', 'User hrsupervisor logged in', '2025-11-22 16:16:07', 5),
(423, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-22 16:20:55', 1),
(424, 1, 'UPDATE', 'employees', 'Updated employee Super Admin (EMP-0001)', '2025-11-22 16:56:26', 1),
(425, 1, 'UPDATE', 'employees', 'Updated employee Super Admin (EMP-0001)', '2025-11-22 17:37:33', 1),
(426, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-22 17:49:12', 1),
(427, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Christian Ancog (ID: 52) using fingerprint ID 129', '2025-11-22 17:50:33', 1),
(428, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Christian Ancog (ID: 52) using fingerprint ID 129', '2025-11-22 17:59:38', 1),
(429, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Christian Ancog (ID: 52) using fingerprint ID 129', '2025-11-22 18:00:48', 1),
(430, 1, 'CREATE', 'employees', 'Created employee Imma Lastname (EMP-0062) with role: employee', '2025-11-22 18:06:43', 1),
(431, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Imma Lastname (ID: 62) using fingerprint ID 130', '2025-11-22 18:06:53', 1),
(432, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Imma Lastname (ID: 62) using fingerprint ID 130', '2025-11-22 18:06:54', 1),
(433, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Imma Lastname (ID: 62) using fingerprint ID 130', '2025-11-22 18:06:55', 1),
(434, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Imma Lastname (ID: 62) using fingerprint ID 130', '2025-11-22 18:06:56', 1),
(435, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Imma Lastname (ID: 62) using fingerprint ID 130', '2025-11-22 18:06:56', 1),
(436, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-22 18:16:23', 1),
(437, 1, 'DELETE', 'employees', 'Deleted employee Imma Lastname (EMP-0062) and linked user account', '2025-11-22 18:16:38', 1),
(438, 1, 'UPDATE', 'employees', 'Updated employee Christian Ancog (EMP-0052)', '2025-11-22 18:17:59', 1),
(441, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-22 18:21:42', 1),
(442, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-23 10:11:13', 1),
(443, 1, 'UPDATE', 'employees', 'Updated employee Paciano Rizal (EMP-0049)', '2025-11-23 10:33:39', 1),
(444, 1, 'CREATE', 'employees', 'Created employee Cristina Patulilic (EMP-0063) with role: employee', '2025-11-23 10:56:25', 1),
(445, 1, 'UPDATE', 'employees', 'Updated employee John Wilmer Ti-maan (EMP-0056)', '2025-11-23 10:58:05', 1),
(446, 1, 'UPDATE', 'employees', 'Updated employee John Wilmer Ti-maan (EMP-0056)', '2025-11-23 11:04:35', 1),
(447, 56, 'UPDATE', 'auth', 'Password reset via OTP', '2025-11-23 11:08:30', 56),
(448, 56, 'LOGIN', 'auth', 'User johnwilmer663 logged in', '2025-11-23 11:09:34', 56),
(449, 56, 'UPDATE', 'employees', 'Updated employee John Wilmer Ti-maan (EMP-0056)', '2025-11-23 11:10:07', 56),
(450, 56, 'UPDATE', 'employees', 'Updated employee John Wilmer Ti-maan (EMP-0056)', '2025-11-23 11:13:18', 56),
(451, 1, 'CREATE', 'employees', 'Created employee Dianne Mananghaya (EMP-0064) with role: employee', '2025-11-23 11:20:57', 1),
(452, 1, 'CREATE', 'employees', 'Created employee Vince Joseph Vargas (EMP-0065) with role: employee', '2025-11-23 11:39:22', 1),
(453, 1, 'CREATE', 'employees', 'Created employee Arjay Garabiag (EMP-0066) with role: employee', '2025-11-23 11:51:58', 1),
(454, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Aaron Apostol (ID: 60) using fingerprint ID 133', '2025-11-23 14:21:36', 1),
(455, 60, 'UPDATE', 'employees', 'Fingerprint enrolled for employee ID 60 (Fingerprint ID: 133)', '2025-11-23 14:22:24', 60),
(456, 1, 'DELETE', 'employees', 'Deleted employee Christian Ancog (EMP-0052) and linked user account', '2025-11-23 15:26:47', 1),
(457, 1, 'CREATE', 'employees', 'Created employee Christian Ancog (EMP-0067) with role: employee', '2025-11-23 15:29:26', 1),
(459, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-23 16:46:00', 1),
(460, 1, 'UPDATE', 'employees', 'Updated employee John Wilmer Ti-maan (EMP-0056)', '2025-11-23 16:47:18', 1),
(461, 1, 'DELETE', 'employees', 'Deleted employee Christian Ancog (EMP-0067) and linked user account', '2025-11-23 16:52:38', 1),
(462, 1, 'CREATE', 'employees', 'Created employee Christian Ancog (EMP-0068) with role: employee', '2025-11-23 16:59:38', 1),
(463, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Christian Ancog (ID: 68) using fingerprint ID 135', '2025-11-23 17:00:07', 1),
(464, 1, 'DELETE', 'employees', 'Deleted employee Christian Ancog (EMP-0068) and linked user account', '2025-11-23 17:01:02', 1),
(465, 1, 'CREATE', 'employees', 'Created employee Christian Ancog (EMP-0069) with role: employee', '2025-11-23 17:02:46', 1),
(466, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Christian Ancog (ID: 69) using fingerprint ID 135', '2025-11-23 17:02:49', 1),
(467, 1, 'DELETE', 'employees', 'Deleted employee Christian Ancog (EMP-0069) and linked user account', '2025-11-23 17:03:40', 1),
(468, 1, 'CREATE', 'employees', 'Created employee Christian Ancog (EMP-0070) with role: employee', '2025-11-23 17:04:29', 1),
(469, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Christian Ancog (ID: 70) using fingerprint ID 135', '2025-11-23 17:04:50', 1),
(470, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Christian Ancog (ID: 70) using fingerprint ID 135', '2025-11-23 17:04:51', 1),
(471, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Christian Ancog (ID: 70) using fingerprint ID 135', '2025-11-23 17:04:52', 1),
(472, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Christian Ancog (ID: 70) using fingerprint ID 135', '2025-11-23 17:04:53', 1),
(473, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Christian Ancog (ID: 70) using fingerprint ID 135', '2025-11-23 17:04:53', 1),
(474, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Christian Ancog (ID: 70) using fingerprint ID 135', '2025-11-23 17:04:54', 1),
(475, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Christian Ancog (ID: 70) using fingerprint ID 135', '2025-11-23 17:05:01', 1),
(476, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Christian Ancog (ID: 70) using fingerprint ID 135', '2025-11-23 17:05:02', 1),
(477, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Christian Ancog (ID: 70) using fingerprint ID 135', '2025-11-23 17:05:03', 1),
(478, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-23 17:20:38', 1),
(479, 1, 'UPDATE', 'attendance', 'Updated attendance status to absent for attendance ATT-0019', '2025-11-23 17:23:19', 1),
(480, 1, 'CREATE', 'attendance', 'Clock in recorded for employee ID 45 (ATT-0045)', '2025-11-23 17:25:19', 1),
(481, 1, 'CREATE', 'attendance', 'Clock in recorded for employee ID 57 (ATT-0046)', '2025-11-23 17:25:26', 1),
(482, 1, 'CREATE', 'employees', 'Created employee Christian Ancog (EMP-0071) with role: employee', '2025-11-23 17:27:58', 1),
(483, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Christian Ancog (ID: 71) using fingerprint ID 2', '2025-11-23 17:28:02', 1),
(485, 1, 'UPDATE', 'employees', 'Updated employee Christian Ancog (EMP-0071)', '2025-11-23 17:28:54', 1),
(486, 1, 'DELETE', 'employees', 'Deleted employee Christian Ancog (EMP-0071) and linked user account', '2025-11-23 17:29:09', 1),
(487, 1, 'CREATE', 'employees', 'Created employee Christian Ancog (EMP-0072) with role: employee', '2025-11-23 17:30:11', 1),
(488, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Christian Ancog (ID: 72) using fingerprint ID 2', '2025-11-23 17:30:15', 1),
(489, 72, 'UPDATE', 'employees', 'Fingerprint enrolled for employee ID 72 (Fingerprint ID: 2)', '2025-11-23 17:30:35', 72),
(490, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Gabriel Aaron Chavez (ID: 21) using fingerprint ID 3', '2025-11-23 17:36:59', 1),
(491, 21, 'UPDATE', 'employees', 'Fingerprint enrolled for employee ID 21 (Fingerprint ID: 3)', '2025-11-23 17:37:10', 21),
(492, 1, 'UPDATE', 'employees', 'Updated employee Gabriel Aaron Chavez (EMP-0021)', '2025-11-23 17:37:16', 1),
(493, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-24 05:05:35', 1),
(494, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Morris Dalisay (ID: 58) using fingerprint ID 4', '2025-11-24 05:05:55', 1),
(496, 1, 'UPDATE', 'employees', 'Updated employee Morris Dalisay (EMP-0058)', '2025-11-24 05:06:13', 1),
(497, 1, 'DELETE', 'employees', 'Deleted employee Morris Dalisay (EMP-0058) and linked user account', '2025-11-24 05:07:51', 1),
(498, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Aaron Apostol (ID: 60) using fingerprint ID 4', '2025-11-24 05:08:07', 1),
(499, 60, 'UPDATE', 'employees', 'Fingerprint enrolled for employee ID 60 (Fingerprint ID: 4)', '2025-11-24 05:08:14', 60),
(500, 1, 'UPDATE', 'employees', 'Updated employee Aaron Apostol (EMP-0060)', '2025-11-24 05:08:20', 1),
(501, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-24 06:04:47', 1),
(502, 72, 'LOGIN', 'auth', 'User christian959 logged in', '2025-11-24 06:13:10', 72),
(503, 72, 'UPDATE', 'employees', 'Updated employee Christian Ancog (EMP-0072)', '2025-11-24 06:13:26', 72),
(504, 72, 'UPDATE', 'employees', 'Updated employee Christian Ancog (EMP-0072)', '2025-11-24 06:13:33', 72),
(505, 72, 'UPDATE', 'employees', 'Updated employee Christian Ancog (EMP-0072)', '2025-11-24 06:13:41', 72),
(506, 72, 'UPDATE', 'employees', 'Updated employee Christian Ancog (EMP-0072)', '2025-11-24 06:14:04', 72),
(507, 72, 'UPDATE', 'employees', 'Updated employee Christian Ancog (EMP-0072)', '2025-11-24 06:36:04', 72),
(508, 72, 'UPDATE', 'employees', 'Updated employee Christian Ancog (EMP-0072)', '2025-11-24 06:36:17', 72),
(509, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-25 03:42:18', 1),
(510, 1, 'CREATE', 'positions', 'Created position Admin  (POS-0032)', '2025-11-25 03:44:48', 1),
(511, 1, 'CREATE', 'employees', 'Created employee Franc Randell Coton (EMP-0073) with role: employee', '2025-11-25 03:52:11', 1),
(512, 1, 'UPDATE', 'positions', 'Updated position Admin  (POS-0032)', '2025-11-25 03:52:49', 1),
(513, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Jamesa Lim (ID: 10) using fingerprint ID 6', '2025-11-25 04:01:19', 1),
(514, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Jamesa Lim (ID: 10) using fingerprint ID 6', '2025-11-25 04:01:24', 1),
(516, 1, 'UPDATE', 'employees', 'Updated employee Jamesa Lim (EMP-0010)', '2025-11-25 04:01:55', 1),
(517, 1, 'DELETE', 'employees', 'Deleted employee Jamesa Lim (EMP-0010) and linked user account', '2025-11-25 04:04:24', 1),
(518, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Louvel Navarro (ID: 59) using fingerprint ID 6', '2025-11-25 04:05:08', 1),
(519, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Louvel Navarro (ID: 59) using fingerprint ID 6', '2025-11-25 04:05:31', 1),
(520, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Louvel Navarro (ID: 59) using fingerprint ID 6', '2025-11-25 04:05:38', 1),
(522, 1, 'UPDATE', 'employees', 'Updated employee Louvel Navarro (EMP-0059)', '2025-11-25 04:06:08', 1),
(523, 1, 'DELETE', 'employees', 'Deleted employee Louvel Navarro (EMP-0059) and linked user account', '2025-11-25 04:08:26', 1),
(524, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Marx Elis Suarez (ID: 61) using fingerprint ID 6', '2025-11-25 04:11:14', 1),
(525, 1, 'CREATE', 'fingerprints', 'Initialized fingerprint enrollment for employee Marx Elis Suarez (ID: 61) using fingerprint ID 6', '2025-11-25 04:11:39', 1);
INSERT INTO `activity_logs` (`log_id`, `user_id`, `action`, `module`, `description`, `created_at`, `created_by`) VALUES
(526, 61, 'UPDATE', 'employees', 'Fingerprint enrolled for employee ID 61 (Fingerprint ID: 6)', '2025-11-25 04:11:41', 61),
(527, 1, 'UPDATE', 'employees', 'Updated employee Marx Elis Suarez (EMP-0061)', '2025-11-25 04:11:49', 1);

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `attendance_id` int NOT NULL,
  `attendance_code` varchar(10) DEFAULT NULL,
  `employee_id` int NOT NULL,
  `date` date DEFAULT NULL,
  `time_in` datetime DEFAULT NULL,
  `time_out` datetime DEFAULT NULL,
  `status` enum('present','absent','late','on_leave') DEFAULT 'present',
  `overtime_hours` decimal(5,2) DEFAULT '0.00',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL
) ;

--
-- Dumping data for table `attendance`
--

INSERT INTO `attendance` (`attendance_id`, `attendance_code`, `employee_id`, `date`, `time_in`, `time_out`, `status`, `overtime_hours`, `created_at`, `updated_at`, `created_by`, `updated_by`) VALUES
(3, 'ATT-0003', 29, '2025-11-16', '2025-11-16 08:32:42', '2025-11-16 23:36:17', 'present', 0.00, '2025-11-16 00:32:42', '2025-11-16 00:37:02', 1, NULL),
(4, 'ATT-0004', 22, '2025-11-16', '2025-11-16 08:40:37', '2025-11-16 18:30:10', 'late', 0.00, '2025-11-16 00:40:36', '2025-11-16 00:47:12', 1, NULL),
(5, 'ATT-0005', 18, '2025-11-16', '2025-11-16 08:52:06', '2025-11-16 18:56:30', 'late', 0.00, '2025-11-16 00:52:06', '2025-11-16 00:57:27', 1, NULL),
(7, 'ATT-0007', 47, '2025-11-21', '2025-11-21 01:13:48', NULL, 'absent', 0.00, '2025-11-20 17:13:48', '2025-11-21 06:29:25', 1, 1),
(9, 'ATT-0009', 45, '2025-11-20', '2025-11-21 01:14:09', NULL, 'present', 0.00, '2025-11-20 17:14:09', '2025-11-20 18:28:13', 1, NULL),
(10, 'ATT-0010', 44, '2025-11-21', '2025-11-21 01:14:17', NULL, 'present', 0.00, '2025-11-20 17:14:17', '2025-11-20 17:14:17', 1, NULL),
(11, 'ATT-0011', 43, '2025-11-21', '2025-11-21 01:14:24', NULL, 'present', 0.00, '2025-11-20 17:14:24', '2025-11-20 17:14:24', 1, NULL),
(12, 'ATT-0012', 42, '2025-11-21', '2025-11-21 01:14:33', NULL, 'present', 0.00, '2025-11-20 17:14:33', '2025-11-20 17:14:33', 1, NULL),
(13, 'ATT-0013', 41, '2025-11-21', '2025-11-21 01:14:40', NULL, 'present', 0.00, '2025-11-20 17:14:40', '2025-11-20 17:14:40', 1, NULL),
(15, 'ATT-0015', 56, '2025-11-21', '2025-11-21 14:48:14', NULL, 'present', 0.00, '2025-11-21 06:48:15', '2025-11-21 06:48:15', 56, NULL),
(16, 'ATT-0016', 57, '2025-11-22', '2025-11-22 01:05:33', NULL, 'absent', 0.00, '2025-11-21 17:05:34', '2025-11-21 17:08:28', 1, 1),
(17, 'ATT-0017', 60, '2025-11-22', '2025-11-22 01:07:27', NULL, 'absent', 0.00, '2025-11-21 17:07:28', '2025-11-21 17:08:45', 1, 1),
(20, 'ATT-0020', 1, '2025-11-21', NULL, NULL, 'absent', 0.00, '2025-11-21 17:44:24', '2025-11-21 17:44:24', 1, NULL),
(21, 'ATT-0021', 2, '2025-11-21', NULL, NULL, 'absent', 0.00, '2025-11-21 17:44:24', '2025-11-21 17:44:24', 1, NULL),
(22, 'ATT-0022', 3, '2025-11-21', NULL, NULL, 'absent', 0.00, '2025-11-21 17:44:24', '2025-11-21 17:44:24', 1, NULL),
(23, 'ATT-0023', 4, '2025-11-21', NULL, NULL, 'absent', 0.00, '2025-11-21 17:44:25', '2025-11-21 17:44:25', 1, NULL),
(24, 'ATT-0024', 5, '2025-11-21', NULL, NULL, 'absent', 0.00, '2025-11-21 17:44:25', '2025-11-21 17:44:25', 1, NULL),
(25, 'ATT-0025', 6, '2025-11-21', NULL, NULL, 'absent', 0.00, '2025-11-21 17:44:25', '2025-11-21 17:44:25', 1, NULL),
(26, 'ATT-0026', 7, '2025-11-21', NULL, NULL, 'absent', 0.00, '2025-11-21 17:44:26', '2025-11-21 17:44:26', 1, NULL),
(28, 'ATT-0028', 12, '2025-11-21', NULL, NULL, 'absent', 0.00, '2025-11-21 17:44:26', '2025-11-21 17:44:26', 1, NULL),
(29, 'ATT-0029', 13, '2025-11-21', NULL, NULL, 'absent', 0.00, '2025-11-21 17:44:27', '2025-11-21 17:44:27', 1, NULL),
(30, 'ATT-0030', 18, '2025-11-21', NULL, NULL, 'absent', 0.00, '2025-11-21 17:44:27', '2025-11-21 17:44:27', 1, NULL),
(31, 'ATT-0031', 19, '2025-11-21', NULL, NULL, 'absent', 0.00, '2025-11-21 17:44:27', '2025-11-21 17:44:27', 1, NULL),
(32, 'ATT-0032', 21, '2025-11-21', NULL, NULL, 'absent', 0.00, '2025-11-21 17:44:28', '2025-11-21 17:44:28', 1, NULL),
(33, 'ATT-0033', 22, '2025-11-21', NULL, NULL, 'absent', 0.00, '2025-11-21 17:44:28', '2025-11-21 17:44:28', 1, NULL),
(34, 'ATT-0034', 23, '2025-11-21', NULL, NULL, 'absent', 0.00, '2025-11-21 17:44:28', '2025-11-21 17:44:28', 1, NULL),
(35, 'ATT-0035', 27, '2025-11-21', NULL, NULL, 'absent', 0.00, '2025-11-21 17:44:28', '2025-11-21 17:44:28', 1, NULL),
(36, 'ATT-0036', 29, '2025-11-21', NULL, NULL, 'absent', 0.00, '2025-11-21 17:44:29', '2025-11-21 17:44:29', 1, NULL),
(37, 'ATT-0037', 40, '2025-11-21', NULL, NULL, 'absent', 0.00, '2025-11-21 17:44:29', '2025-11-21 17:44:29', 1, NULL),
(38, 'ATT-0038', 45, '2025-11-21', NULL, NULL, 'absent', 0.00, '2025-11-21 17:44:29', '2025-11-21 17:44:29', 1, NULL),
(39, 'ATT-0039', 48, '2025-11-21', NULL, NULL, 'absent', 0.00, '2025-11-21 17:44:30', '2025-11-21 17:44:30', 1, NULL),
(40, 'ATT-0040', 57, '2025-11-21', NULL, NULL, 'absent', 0.00, '2025-11-21 17:44:30', '2025-11-21 17:44:30', 1, NULL),
(43, 'ATT-0043', 60, '2025-11-21', NULL, NULL, 'absent', 0.00, '2025-11-21 17:44:31', '2025-11-21 17:44:31', 1, NULL),
(44, 'ATT-0044', 61, '2025-11-21', NULL, NULL, 'absent', 0.00, '2025-11-21 17:44:32', '2025-11-21 17:44:32', 1, NULL),
(45, 'ATT-0045', 45, '2025-11-24', '2025-11-24 01:25:18', NULL, 'present', 0.00, '2025-11-23 17:25:18', '2025-11-23 17:25:19', 1, NULL),
(46, 'ATT-0046', 57, '2025-11-24', '2025-11-24 01:25:26', NULL, 'present', 0.00, '2025-11-23 17:25:26', '2025-11-23 17:25:26', 1, NULL),
(48, 'ATT-0048', 72, '2025-11-24', '2025-11-24 01:31:08', '2025-11-24 01:31:45', 'late', 0.00, '2025-11-23 17:31:08', '2025-11-23 17:31:45', 72, 72),
(49, 'ATT-0049', 21, '2025-11-24', '2025-11-24 01:37:32', '2025-11-24 01:37:44', 'late', 0.00, '2025-11-23 17:37:32', '2025-11-23 17:37:44', 21, 21),
(50, 'ATT-0050', 60, '2025-11-24', '2025-11-24 13:08:37', '2025-11-24 13:11:06', 'late', 0.00, '2025-11-24 05:08:38', '2025-11-24 05:11:07', 60, 60),
(51, 'ATT-0051', 72, '2025-11-25', '2025-11-25 12:01:22', '2025-11-25 12:02:54', 'late', 0.00, '2025-11-25 04:01:22', '2025-11-25 04:02:55', 72, 72),
(53, 'ATT-0053', 21, '2025-11-25', '2025-11-25 12:03:08', '2025-11-25 12:03:20', 'late', 0.00, '2025-11-25 04:03:08', '2025-11-25 04:03:20', 21, 21),
(55, 'ATT-0055', 60, '2025-11-25', '2025-11-25 12:10:39', '2025-11-25 12:10:46', 'late', 0.00, '2025-11-25 04:10:40', '2025-11-25 04:10:46', 60, 60);

-- --------------------------------------------------------

--
-- Table structure for table `audit_log`
--

CREATE TABLE `audit_log` (
  `log_id` int NOT NULL,
  `users_id` int NOT NULL,
  `action_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `audit_log`
--

INSERT INTO `audit_log` (`log_id`, `users_id`, `action_type`, `description`, `ip_address`, `user_agent`, `created_at`) VALUES
(1, 3, 'BACKUP_CREATE', 'Created backup: backup_2025-11-15T02-18-57-606Z (38.93 KB)', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 02:18:56.333688'),
(2, 3, 'BACKUP_CREATE', 'Created backup: backup_2025-11-15T02-19-36-282Z (38.93 KB)', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 02:19:34.826219');

-- --------------------------------------------------------

--
-- Table structure for table `auth_tokens`
--

CREATE TABLE `auth_tokens` (
  `id` int NOT NULL,
  `selector` char(32) COLLATE utf8mb4_general_ci NOT NULL,
  `hashed_validator` char(255) COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` int NOT NULL,
  `expires` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_tokens`
--

INSERT INTO `auth_tokens` (`id`, `selector`, `hashed_validator`, `user_id`, `expires`) VALUES
(1, 'b25c6de43f4148da96199c7fc499fd6c', '$2y$10$IVrlpHnNisvApBcsKWhOr.FRGIR4MIhIGO6.X6fGqrrLSDhFIa17u', 1, '2025-11-20 11:21:39'),
(2, 'e9cfdd1564ca84bc5f391c4dbaccd82a', '$2y$10$j4IgDtgzCMyRfPZ9hDHlouDodNN2Q6AOo7rr9KXAUbFFt.ahHYBEa', 1, '2025-11-20 11:22:15'),
(3, '951ba576d478816b4b089007770e9ad8', '$2y$10$2rRZq9ZjCWNlyk81OTIQveeH2ghmY5jGRI1l7VJVk/YwkZdUQ8W3K', 1, '2025-11-20 11:24:45'),
(4, '037a5269db024aba8d37f8b9b0c5d57d', '$2y$10$fgsmLl18bgL1.1hoSESePe.PtXydnScDzGbVCmuX.GQ3K/aoBhXCG', 1, '2025-11-20 11:28:11'),
(5, '737ccd17b442cd280a2e63bd9e0e5353', '$2y$10$zvg.s9kqZWHHKtC0mho3YuEp0FpAjfMfeeNFjNBZAeUvrG.pDmy1i', 1, '2025-11-20 11:30:29'),
(6, 'b3c83cf9348fba6bfbdc95bf62846e8b', '$2y$10$zb.7rGa9GSXC/qAm5lqlZuOH7.ntsRdrToYKsWda7aLamXDQP2oxq', 1, '2025-11-20 11:38:07'),
(7, '8010b32db512ef8df57a0b9ef31c14d8', '$2y$10$SiZR5tOKDuGGh6fAFm3rWuqhl676CxHtL3Z/UorGp58U9Ho6XPi.W', 1, '2025-11-20 11:50:32'),
(8, '980b6a14cb6b535f1de2cb1eef3ed89f', '$2y$10$HsXHr.wk33qFrX8nqmuvM.gotUPaQbK0ZYDkanGdz24sMpHqf/1R2', 1, '2025-11-20 14:28:08'),
(9, '680070b8cc1f43c09d4169348edc0ba6', '$2y$10$eiTcj0syJkdpkWuj7k3xp.QkZeIpFlmyuOSvm3ThDeEFE/d9vY/te', 1, '2025-11-20 14:33:52');

-- --------------------------------------------------------

--
-- Table structure for table `backup_history`
--

CREATE TABLE `backup_history` (
  `backup_id` int NOT NULL,
  `backup_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `backup_type` enum('Manual','Automatic') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Manual',
  `file_path` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_size` bigint DEFAULT NULL,
  `status` enum('Success','Failed','In Progress') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'In Progress',
  `created_by` int NOT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `backup_history`
--

INSERT INTO `backup_history` (`backup_id`, `backup_name`, `backup_type`, `file_path`, `file_size`, `status`, `created_by`, `created_at`) VALUES
(6, 'backup_2025-11-12T12-42-03-465Z', 'Manual', 'C:\\Users\\Admin\\Documents\\GitHub\\sia-accountant-management-system-backend\\backups\\backup_2025-11-12T12-42-03-465Z.json', 39166, 'Success', 3, '2025-11-12 12:42:03.758644'),
(7, 'backup_2025-11-13T09-18-47-345Z', 'Manual', 'C:\\Users\\Admin\\Documents\\GitHub\\sia-accountant-management-system-backend\\backups\\backup_2025-11-13T09-18-47-345Z.json', 39800, 'Success', 3, '2025-11-13 09:18:47.164902'),
(8, 'backup_2025-11-14T05-30-10-681Z', 'Manual', NULL, NULL, 'Failed', 3, '2025-11-14 05:30:29.388422'),
(9, 'backup_2025-11-14T05-35-05-051Z', 'Manual', 'C:\\Users\\Admin\\Documents\\GitHub\\sia-accountant-management-system-backend\\backups\\backup_2025-11-14T05-35-05-051Z.json', 32989, 'Success', 3, '2025-11-14 05:35:04.852357'),
(10, 'backup_2025-11-14T05-36-52-540Z', 'Manual', 'C:\\Users\\Admin\\Documents\\GitHub\\sia-accountant-management-system-backend\\backups\\backup_2025-11-14T05-36-52-540Z.json', 32989, 'Success', 3, '2025-11-14 05:36:52.327421'),
(11, 'backup_2025-11-14T13-41-41-889Z', 'Manual', 'C:\\Users\\Admin\\Documents\\GitHub\\sia-accountant-management-system-backend\\backups\\backup_2025-11-14T13-41-41-889Z.json', 38506, 'Success', 3, '2025-11-14 13:41:40.736868'),
(12, 'backup_2025-11-15T02-09-19-535Z', 'Manual', 'C:\\Users\\Admin\\Documents\\GitHub\\sia-accountant-management-system-backend\\backups\\backup_2025-11-15T02-09-19-535Z.json', 39861, 'Success', 3, '2025-11-15 02:09:18.280214'),
(13, 'backup_2025-11-15T02-10-05-385Z', 'Manual', 'C:\\Users\\Admin\\Documents\\GitHub\\sia-accountant-management-system-backend\\backups\\backup_2025-11-15T02-10-05-385Z.json', 39861, 'Success', 3, '2025-11-15 02:10:03.699392'),
(14, 'backup_2025-11-15T02-18-57-606Z', 'Manual', 'C:\\Users\\Admin\\Documents\\GitHub\\sia-accountant-management-system-backend\\backups\\backup_2025-11-15T02-18-57-606Z.json', 39861, 'Success', 3, '2025-11-15 02:18:56.108141'),
(15, 'backup_2025-11-15T02-19-36-282Z', 'Manual', 'C:\\Users\\Admin\\Documents\\GitHub\\sia-accountant-management-system-backend\\backups\\backup_2025-11-15T02-19-36-282Z.json', 39861, 'Success', 3, '2025-11-15 02:19:34.576114'),
(16, 'backup_2025-11-15T02-20-01-869Z', 'Manual', 'C:\\Users\\Admin\\Documents\\GitHub\\sia-accountant-management-system-backend\\backups\\backup_2025-11-15T02-20-01-869Z.json', 39861, 'Success', 3, '2025-11-15 02:20:00.390931'),
(17, 'backup_2025-11-15T02-54-31-456Z', 'Manual', 'C:\\Users\\Admin\\Documents\\GitHub\\sia-accountant-management-system-backend\\backups\\backup_2025-11-15T02-54-31-456Z.json', 40759, 'Success', 3, '2025-11-15 02:54:29.768087'),
(18, 'backup_2025-11-15T02-55-38-380Z', 'Manual', 'C:\\Users\\Admin\\Documents\\GitHub\\sia-accountant-management-system-backend\\backups\\backup_2025-11-15T02-55-38-380Z.json', 40759, 'Success', 3, '2025-11-15 02:55:36.580926'),
(19, 'backup_2025-11-15T02-58-18-294Z', 'Manual', 'C:\\Users\\Admin\\Documents\\GitHub\\sia-accountant-management-system-backend\\backups\\backup_2025-11-15T02-58-18-294Z.json', 40759, 'Success', 3, '2025-11-15 02:58:16.502797'),
(20, 'backup_2025-11-15T07-28-39-370Z', 'Manual', 'C:\\Users\\Admin\\Documents\\GitHub\\sia-accountant-management-system-backend\\backups\\backup_2025-11-15T07-28-39-370Z.json', 42567, 'Success', 10, '2025-11-15 07:28:38.114262'),
(21, 'backup_2025-11-17T08-17-42-502Z', 'Manual', 'F:\\SIA\\Backend\\accountant-management-system\\backups\\backup_2025-11-17T08-17-42-502Z.json', 35941, 'Success', 3, '2025-11-17 08:17:43.894619');

-- --------------------------------------------------------

--
-- Table structure for table `backup_settings`
--

CREATE TABLE `backup_settings` (
  `id` int NOT NULL,
  `auto_backup_enabled` tinyint NOT NULL DEFAULT '1',
  `backup_time` time NOT NULL DEFAULT '03:00:00',
  `retention_days` int NOT NULL DEFAULT '30',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `backup_settings`
--

INSERT INTO `backup_settings` (`id`, `auto_backup_enabled`, `backup_time`, `retention_days`, `created_at`, `updated_at`) VALUES
(1, 1, '03:00:00', 30, '2025-11-10 17:28:16.466390', '2025-11-10 17:28:16.466390');

-- --------------------------------------------------------

--
-- Table structure for table `budget`
--

CREATE TABLE `budget` (
  `budget_id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `budget_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `period_type` enum('Monthly','Quarterly','Yearly') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('Active','Inactive','Completed') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `budget`
--

INSERT INTO `budget` (`budget_id`, `user_id`, `budget_name`, `start_date`, `end_date`, `description`, `period_type`, `status`, `created_at`, `updated_at`, `created_by`) VALUES
(16, NULL, 'November', '2025-11-04', '2025-11-30', NULL, 'Monthly', 'Active', '2025-11-04 23:25:27', '2025-11-04 23:25:27', NULL),
(17, NULL, 'New Budget', '2025-12-01', '2026-01-17', NULL, 'Monthly', 'Active', '2025-11-10 06:36:51', '2025-11-10 06:36:51', NULL),
(18, NULL, 'BABABDW', '2025-12-01', '2026-01-17', NULL, 'Monthly', 'Active', '2025-11-10 06:39:39', '2025-11-10 06:39:39', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `budget_category`
--

CREATE TABLE `budget_category` (
  `budget_category_id` int NOT NULL,
  `budget_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `budget_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `amount` decimal(10,2) DEFAULT NULL,
  `budget_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `budget_category`
--

INSERT INTO `budget_category` (`budget_category_id`, `budget_name`, `budget_description`, `amount`, `budget_id`) VALUES
(13, 'Revenue', 'Total expected revenue', 200000.00, 16),
(14, 'Payroll', 'Employee salaries and benefits', 85000.00, 16),
(15, 'Utilities', 'Electricity, water, gas', 15000.00, 16),
(16, 'Supplies', 'Cleaning, office, kitchen supplies', 12000.00, 16),
(17, 'Marketing', 'Advertising and promotions', 8000.00, 16),
(18, 'Maintenance', 'Repairs and maintenance', 10000.00, 16),
(19, 'Revenue', 'Total expected revenue', 200000.00, 18),
(20, 'Payroll', 'Employee salaries and benefits', 85000.00, 18),
(21, 'Utilities', 'Electricity, water, gas', 15000.00, 18),
(22, 'Supplies', 'Cleaning, office, kitchen supplies', 12000.00, 18),
(23, 'Marketing', 'Advertising and promotions', 8000.00, 18),
(24, 'Maintenance', 'Repairs and maintenance', 10000.00, 18);

-- --------------------------------------------------------

--
-- Table structure for table `budget_variance`
--

CREATE TABLE `budget_variance` (
  `budget_variance_id` int NOT NULL,
  `budget_category_id` int NOT NULL,
  `budget_id` int DEFAULT NULL,
  `expenses_id` int DEFAULT NULL,
  `total_expenses` decimal(10,2) NOT NULL DEFAULT '0.00',
  `variance` decimal(10,2) DEFAULT NULL,
  `variance_percentage` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` enum('On Track','Monitor','Alert') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Monitor'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `budget_variance`
--

INSERT INTO `budget_variance` (`budget_variance_id`, `budget_category_id`, `budget_id`, `expenses_id`, `total_expenses`, `variance`, `variance_percentage`, `created_at`, `updated_at`, `status`) VALUES
(4, 13, 16, NULL, 20000.00, 180000.00, 90.00, '2025-11-04 23:25:27', '2025-11-11 02:57:05', 'Monitor'),
(5, 14, 16, 1, 20000.00, 65000.00, 76.47, '2025-11-04 23:25:27', '2025-11-07 23:50:56', 'Monitor'),
(6, 15, 16, NULL, 0.00, -5000.00, -33.33, '2025-11-04 23:25:27', '2025-11-15 05:17:25', 'Alert'),
(7, 16, 16, NULL, 2000.00, 10000.00, 83.33, '2025-11-04 23:25:27', '2025-11-13 04:52:58', 'On Track'),
(8, 17, 16, NULL, 20000.00, -12000.00, -150.00, '2025-11-04 23:25:27', '2025-11-12 05:19:34', 'Monitor'),
(9, 18, 16, NULL, 0.00, 10000.00, 100.00, '2025-11-04 23:25:27', '2025-11-07 02:51:24', 'Monitor'),
(10, 19, 18, NULL, 0.00, 200000.00, 100.00, '2025-11-10 06:39:39', '2025-11-12 11:37:40', 'On Track'),
(11, 20, 18, NULL, 0.00, 85000.00, 100.00, '2025-11-10 06:39:39', '2025-11-10 06:39:39', 'On Track'),
(12, 21, 18, NULL, 0.00, 15000.00, 100.00, '2025-11-10 06:39:39', '2025-11-10 06:39:39', 'On Track'),
(13, 22, 18, NULL, 0.00, 12000.00, 100.00, '2025-11-10 06:39:39', '2025-11-10 06:39:39', 'On Track'),
(14, 23, 18, NULL, 0.00, 8000.00, 100.00, '2025-11-10 06:39:39', '2025-11-10 06:39:39', 'On Track'),
(15, 24, 18, NULL, 0.00, 10000.00, 100.00, '2025-11-10 06:39:39', '2025-11-10 06:39:39', 'On Track');

-- --------------------------------------------------------

--
-- Table structure for table `client`
--

CREATE TABLE `client` (
  `client_id` int NOT NULL,
  `full_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `company_deductions`
--

CREATE TABLE `company_deductions` (
  `deduction_id` int NOT NULL,
  `employee_id` int NOT NULL,
  `payroll_run_id` int NOT NULL,
  `leave_id` int DEFAULT NULL,
  `deduction_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_applied` date DEFAULT (curdate())
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `crm_users`
--

CREATE TABLE `crm_users` (
  `account_id` int NOT NULL,
  `employee_id` varchar(50) NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `full_name` varchar(150) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `crm_users`
--

INSERT INTO `crm_users` (`account_id`, `employee_id`, `username`, `email`, `full_name`, `password_hash`, `created_at`) VALUES
(1, 'EM1001', 'Emman', 'frias@gmail.com', 'Emman Frias', '$2b$10$H6UTTEEc1yXJ4aRjpfuQK.RKM71rqLK6n5NlfXpzkiYgKw94dmL5G', '2025-11-14 02:30:31'),
(3, 'EM1002', 'Jannnnn', 'johnjohnalfred05@gmail.com', 'John Alfred', 'f9aec44c860938459c0c9693e2aa7dc44d2e0adac5f45da0957f4ddd308ddea9', '2025-11-14 18:55:09'),
(4, 'EM1003', 'Emmanuu', 'emmanuelfrias.25@gmail.com', 'Emmanuu Frias', '32ccdfb2ecb82f978e110b51f42c9844558b554b73d3323c33930ab5df917323', '2025-11-20 13:47:59'),
(8, 'EM1005', 'Emmanwel', 'Emmanwel@gmail.com', 'Emmanwel Frias', '45803bcb0594197912b615d688eba7a474f5ecbd797904f1f7b82492a58e00c2', '2025-11-21 18:30:27');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_id` int NOT NULL,
  `first_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `last_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `first_name`, `last_name`, `email`, `password`, `phone`, `created_at`) VALUES
(1, 'Ran', 'Ran', 'ranran@example.com', '$2a$10$jgYuAa.n3i3LKGNSn14vjO7q5bczEf6WvlAFI.j0tsw86wIX2hg9u', NULL, '2025-10-17 16:00:25'),
(2, 'Franc Randell', 'Coton', 'nishidell04@gmail.com', '$2a$10$cK4DB.hGuNt0P1ZmCNy/puo50bZYfzyJH9upptLmkdCznE2hRMvJC', '09350756012', '2025-10-28 01:19:47'),
(3, 'Rylei', 'Abellera', 'rylei123@gmail.com', '$2a$10$IGwgnzzf1aXMqGfKgJdXg.0O1zZYo/ie3yXEhZAHYDCJv.cOgwxoq', NULL, '2025-11-01 05:41:56'),
(4, 'Roronoa', 'Zoro', 'roronoa123@gmail.com', '$2a$10$wrCcNC5UVfeT6IUfrHjvQOjU.2.RDZg2.a9ILwyBeA2OCa57AAcLG', NULL, '2025-11-01 11:13:24'),
(5, 'Crystal', 'Torio', 'crystal@example.com', '$2a$10$oBj84L6oe7bkbIMIs4GjU.hx3y9k77x5wTVF2QDyieZvXMzESA.de', '9171234567', '2025-11-02 16:24:24'),
(6, 'Hezel', 'Joy', 'hezel@example.com', '$2a$10$WOLN6WQlu9L5TIlJ0nQjreihh7jf.aZjiCPaOV8V8gHNqYP9.nCoa', '9283617283', '2025-11-05 18:20:13'),
(7, 'Borgy', 'Monotoc', 'mason123@gmail.com', '$2a$10$Uu7wbamF/wsVJeAzvds4GuHg8tGYeB2L94ujBmcIMvX1S6Zxh3Me2', NULL, '2025-11-13 01:10:31');

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `department_id` int NOT NULL,
  `department_code` varchar(10) DEFAULT NULL,
  `department_name` varchar(100) NOT NULL,
  `description` text,
  `supervisor_id` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL
) ;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`department_id`, `department_code`, `department_name`, `description`, `supervisor_id`, `created_at`, `updated_at`, `created_by`, `updated_by`) VALUES
(1, 'DEP-0001', 'Human Resources', 'Handles employee records, recruitment, and payroll', 5, '2025-11-09 10:18:52', '2025-11-09 10:18:54', 1, NULL),
(2, 'DEP-0002', 'IT', 'Maintains company systems and databases', 6, '2025-11-09 10:18:52', '2025-11-09 10:18:54', 1, NULL),
(3, 'DEP-0003', 'Front Desk', 'Handles reception, visitor management, and front office operations', 7, '2025-11-09 10:18:52', '2025-11-09 10:18:54', 1, NULL),
(4, 'DEP-0004', 'Front of House (FOH)', 'Responsible for the customer-facing activities of a business, primarily in the hospitality industry, that directly interact with guests.', NULL, '2025-11-11 09:01:01', '2025-11-11 09:02:59', 1, 1),
(5, 'DEP-0005', 'Kitchen Operations', 'refer to the comprehensive management of a kitchen, which includes organizing staff, ensuring safety and sanitation, managing inventory, and streamlining workflow to improve efficiency and profitability.', NULL, '2025-11-11 09:05:11', '2025-11-11 09:05:35', 1, 1),
(6, 'DEP-0006', 'Hotel Service', ' primarily the Front Office or Guest Services department, which acts as the central point of contact for guests, handling check-in/check-out, reservations, and guest requests. It also includes specialized roles like concierges, who help with travel and local recommendations, and porters/bellhops, who assist with luggage and room escorts', NULL, '2025-11-11 09:07:41', '2025-11-11 09:07:41', 1, NULL),
(7, 'DEP-0007', 'Procurement and inventory department', 'Responsible for acquiring goods and services for a business and managing the stock levels of those items.', NULL, '2025-11-11 09:08:53', '2025-11-11 09:08:53', 1, NULL),
(8, 'DEP-0008', 'Finance & Control System', ' a core organizational function responsible for managing an entity\'s monetary resources, ensuring financial integrity, mitigating risks, and providing strategic financial insights to guide decision-making.', NULL, '2025-11-11 09:12:03', '2025-11-11 09:12:03', 1, NULL),
(9, 'DEP-0009', 'Hotel maintenance ', 's responsible for ensuring the property\'s physical assets including building systems, equipment, and grounds—are in good working order.', NULL, '2025-11-11 09:16:56', '2025-11-11 09:16:56', 1, NULL),
(10, 'DEP-0010', 'Parking Management', 'Managed by the front office (for valet services) and the security/maintenance department (for overall traffic, safety, and lot management).', NULL, '2025-11-11 09:20:39', '2025-11-11 09:20:39', 1, NULL),
(11, 'DEP-0011', 'House keeping', ' responsible for a hotel\'s cleanliness, maintenance, and aesthetic appeal, ensuring both guest rooms and public areas are clean, hygienic, and comfortable.', NULL, '2025-11-11 09:22:06', '2025-11-11 09:22:06', 1, NULL),
(12, 'DEP-0012', 'Accounting', 'Responsible for managing the hotel\'s financial operations, including preparing financial statements, managing budgets, and processing payroll.', NULL, '2025-11-11 11:15:43', '2025-11-11 11:15:43', 1, NULL),
(13, 'DEP-0013', 'Customer Service', NULL, NULL, '2025-11-11 14:52:46', '2025-11-14 07:02:17', 1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `dependants`
--

CREATE TABLE `dependants` (
  `dependant_id` int NOT NULL,
  `dependant_code` varchar(10) DEFAULT NULL,
  `employee_id` int NOT NULL,
  `firstname` varchar(100) DEFAULT NULL,
  `lastname` varchar(100) DEFAULT NULL,
  `relationship` varchar(100) DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL
) ;

--
-- Dumping data for table `dependants`
--

INSERT INTO `dependants` (`dependant_id`, `dependant_code`, `employee_id`, `firstname`, `lastname`, `relationship`, `birth_date`, `created_at`, `updated_at`, `created_by`, `updated_by`) VALUES
(1, 'DEP-0001', 2, 'Miguel', 'Santos', 'Spouse', '1989-05-20', '2025-11-09 10:18:55', '2025-11-09 10:18:55', 1, NULL),
(2, 'DEP-0002', 2, 'Sofia', 'Santos', 'Child', '2015-08-12', '2025-11-09 10:18:55', '2025-11-09 10:18:55', 1, NULL),
(3, 'DEP-0003', 5, 'Carmen', 'Ramos', 'Spouse', '1990-02-14', '2025-11-09 10:18:55', '2025-11-09 10:18:55', 1, NULL),
(4, 'DEP-0004', 5, 'Luis', 'Ramos', 'Child', '2018-06-22', '2025-11-09 10:18:55', '2025-11-09 10:18:55', 1, NULL),
(5, 'DEP-0005', 6, 'Isabella', 'Mendoza', 'Spouse', '1988-11-30', '2025-11-09 10:18:55', '2025-11-09 10:18:55', 1, NULL),
(6, 'DEP-0006', 6, 'Diego', 'Mendoza', 'Child', '2016-03-15', '2025-11-09 10:18:55', '2025-11-09 10:18:55', 1, NULL),
(7, 'DEP-0007', 6, 'Elena', 'Mendoza', 'Child', '2019-09-08', '2025-11-09 10:18:55', '2025-11-09 10:18:55', 1, NULL),
(14, 'DEP-0014', 18, 'Skylar ', 'Catalan', 'Parent', NULL, '2025-11-11 15:21:03', '2025-11-11 15:21:03', 1, NULL),
(15, 'DEP-0015', 18, 'Leah', 'Ramirez', 'Sibling', NULL, '2025-11-11 15:21:03', '2025-11-11 15:21:03', 1, NULL),
(24, 'DEP-0024', 22, 'Ricardo', 'Villaflor', 'Spouse', NULL, '2025-11-11 18:16:53', '2025-11-11 18:16:53', 1, NULL),
(54, 'DEP-0054', 19, 'Benjamin', 'Montero', 'Parent', NULL, '2025-11-12 15:19:47', '2025-11-12 15:19:47', 1, NULL),
(55, 'DEP-0055', 13, 'Christian', 'Ancog', 'Parent', NULL, '2025-11-12 15:22:00', '2025-11-12 15:22:00', 1, NULL),
(56, 'DEP-0056', 23, 'John Carlo', 'Umali', 'Spouse', NULL, '2025-11-12 15:32:06', '2025-11-12 15:32:06', 1, NULL),
(60, 'DEP-0060', 27, 'Christian', 'Ancog', 'Child', NULL, '2025-11-12 17:33:24', '2025-11-12 17:33:24', 1, NULL),
(61, 'DEP-0061', 29, 'Joshua', 'Reyes', 'Relatives', NULL, '2025-11-13 02:47:37', '2025-11-13 02:47:37', 1, NULL),
(74, 'DEP-0074', 3, 'Teresa', 'Dela Cruz', 'Mother', NULL, '2025-11-18 06:54:28', '2025-11-18 06:54:28', 3, NULL),
(76, 'DEP-0076', 41, 'Dylan', 'De Leon', 'Sibling', NULL, '2025-11-20 01:58:13', '2025-11-20 01:58:13', 1, NULL),
(77, 'DEP-0077', 42, 'Bryan', 'Santos', 'Boyfriend', NULL, '2025-11-20 02:24:17', '2025-11-20 02:24:17', 1, NULL),
(78, 'DEP-0078', 43, 'Freia', 'Domingo', 'Spouse', NULL, '2025-11-20 02:32:14', '2025-11-20 02:32:14', 1, NULL),
(79, 'DEP-0079', 44, 'Karla', 'Lacson', 'Parent', NULL, '2025-11-20 02:37:50', '2025-11-20 02:37:50', 1, NULL),
(88, 'DEP-0088', 48, 'Matt', 'Henry', 'Child', NULL, '2025-11-20 07:41:55', '2025-11-20 07:41:55', 1, NULL),
(96, 'DEP-0096', 45, 'Wilfred', 'Acosta', 'Boardmates', NULL, '2025-11-21 06:27:10', '2025-11-21 06:27:10', 1, NULL),
(100, 'DEP-0100', 47, 'Ashley', 'Marasigan', 'Sibling', NULL, '2025-11-21 06:39:40', '2025-11-21 06:39:40', 1, NULL),
(102, 'DEP-0102', 57, 'Michael', 'Gallardo', 'Sibling', NULL, '2025-11-21 16:03:04', '2025-11-21 16:03:04', 1, NULL),
(112, 'DEP-0112', 1, 'Roberto', 'Admin', 'Parent', NULL, '2025-11-22 17:37:32', '2025-11-22 17:37:32', 1, NULL),
(115, 'DEP-0115', 49, 'Saturnina', 'Rizal', 'Sibling', NULL, '2025-11-23 10:33:39', '2025-11-23 10:33:39', 1, NULL),
(116, 'DEP-0116', 63, 'Shawn', 'Patulilic', 'Parent', NULL, '2025-11-23 10:56:25', '2025-11-23 10:56:25', 1, NULL),
(120, 'DEP-0120', 65, 'Alfred', 'Vargas', 'Parent', NULL, '2025-11-23 11:39:22', '2025-11-23 11:39:22', 1, NULL),
(121, 'DEP-0121', 66, 'John Ray', 'Garabiag', 'Child', NULL, '2025-11-23 11:51:58', '2025-11-23 11:51:58', 1, NULL),
(123, 'DEP-0123', 56, 'Christian', 'Ancog', 'Child', NULL, '2025-11-23 16:47:18', '2025-11-23 16:47:18', 1, NULL),
(130, 'DEP-0130', 21, 'Jonas', 'Dela Cruz', 'Parent', NULL, '2025-11-23 17:37:16', '2025-11-23 17:37:16', 1, NULL),
(132, 'DEP-0132', 60, 'Rodel', 'Apostol', 'Parent', NULL, '2025-11-24 05:08:20', '2025-11-24 05:08:20', 1, NULL),
(135, 'DEP-0135', 72, 'Christian', 'Ancog', 'spouse', NULL, '2025-11-24 06:36:16', '2025-11-24 06:36:16', 72, NULL),
(136, 'DEP-0136', 73, 'Nicole', 'Mayo', 'Parent', NULL, '2025-11-25 03:52:11', '2025-11-25 03:52:11', 1, NULL),
(139, 'DEP-0139', 61, 'Mark', 'Suarez', 'Parent', NULL, '2025-11-25 04:11:49', '2025-11-25 04:11:49', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `dependant_address`
--

CREATE TABLE `dependant_address` (
  `dependant_address_id` int NOT NULL,
  `dependant_id` int DEFAULT NULL,
  `region_name` varchar(100) DEFAULT NULL,
  `province_name` varchar(50) DEFAULT NULL,
  `city_name` varchar(50) DEFAULT NULL,
  `home_address` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `dependant_address`
--

INSERT INTO `dependant_address` (`dependant_address_id`, `dependant_id`, `region_name`, `province_name`, `city_name`, `home_address`, `created_at`, `updated_at`, `created_by`, `updated_by`) VALUES
(1, 1, 'NCR', 'Metro Manila', 'Makati City', '456 HR Ave, Brgy. Poblacion', '2025-11-09 10:18:55', '2025-11-09 10:18:55', 1, NULL),
(2, 3, 'NCR', 'Metro Manila', 'Quezon City', '654 Supervisor Ln, Brgy. Diliman', '2025-11-09 10:18:55', '2025-11-09 10:18:55', 1, NULL),
(3, 5, 'NCR', 'Metro Manila', 'Makati City', '789 IT Supervisor St, Brgy. Salcedo', '2025-11-09 10:18:55', '2025-11-09 10:18:55', 1, NULL),
(9, 14, 'Region IV-A (CALABARZON)', 'Rizal', 'City of Antipolo ', 'Unit 10, 2/F Molvina Commercial Complex, Marcos Highway', '2025-11-11 15:21:03', '2025-11-11 15:21:03', 1, NULL),
(10, 15, 'Region IV-A (CALABARZON)', 'Rizal', 'Cainta', ' Unit 10, 2/F Molvina Commercial Complex, Marcos Highway', '2025-11-11 15:21:03', '2025-11-11 15:21:03', 1, NULL),
(19, 24, 'National Capital Region (NCR)', 'NCR', 'Valenzuela City', '13 Oregano st. Palanas A Barangay Vasra', '2025-11-11 18:16:53', '2025-11-11 18:16:53', 1, NULL),
(49, 54, 'National Capital Region (NCR)', 'NCR', 'Taguig City', ' 10 Gen A Luna', '2025-11-12 15:19:47', '2025-11-12 15:19:47', 1, NULL),
(50, 55, 'National Capital Region (NCR)', 'NCR', 'Pateros', '13 Oregano st. Palanas A Barangay Vasra', '2025-11-12 15:22:00', '2025-11-12 15:22:00', 1, NULL),
(51, 56, 'National Capital Region (NCR)', 'NCR', 'Makati City', '15/F Export Bank Plaza Gil Puyat Avenue Cor. Chino Roces Avenue 1200', '2025-11-12 15:32:06', '2025-11-12 15:32:06', 1, NULL),
(55, 60, 'National Capital Region (NCR)', 'NCR', 'Pateros', '13 Oregano st. Palanas A Barangay Vasra', '2025-11-12 17:33:24', '2025-11-12 17:33:24', 1, NULL),
(56, 61, 'National Capital Region (NCR)', 'NCR', 'Quezon City', '1035 A Bonifacio Avenue', '2025-11-13 02:47:37', '2025-11-13 02:47:37', 1, NULL),
(70, 76, 'National Capital Region (NCR)', 'NCR', 'Valenzuela City', ' 36 Bonifacio Street Arty Subdivision 1440', '2025-11-20 01:58:13', '2025-11-20 01:58:13', 1, NULL),
(71, 77, 'National Capital Region (NCR)', 'NCR', 'Manila', '805 Sabino Padilla Street', '2025-11-20 02:24:17', '2025-11-20 02:24:17', 1, NULL),
(72, 78, 'National Capital Region (NCR)', 'NCR', 'Makati City', ' 7/F Citibank Center8741 Paseo De Roxas1200', '2025-11-20 02:32:14', '2025-11-20 02:32:14', 1, NULL),
(73, 79, 'National Capital Region (NCR)', 'NCR', 'Quezon City', '68 West Avenue', '2025-11-20 02:37:50', '2025-11-20 02:37:50', 1, NULL),
(82, 88, 'Cordillera Administrative Region (CAR)', 'Benguet', 'Tublay', 'DRN', '2025-11-20 07:41:56', '2025-11-20 07:41:56', 1, NULL),
(90, 96, 'National Capital Region (NCR)', 'NCR', 'San Juan City', ' 199-B E. Rodriguez Street', '2025-11-21 06:27:11', '2025-11-21 06:27:11', 1, NULL),
(94, 100, 'National Capital Region (NCR)', 'NCR', 'Manila', ' Hyatt Hotel And Casino Manila, 1558 Pedro Gil, Corner M.H. Del Pilar Street', '2025-11-21 06:39:40', '2025-11-21 06:39:40', 1, NULL),
(96, 102, 'National Capital Region (NCR)', 'NCR', 'Manila', '1241 Padre Faura Street Corner M.H. Del Pilar Street Ermita 1000', '2025-11-21 16:03:04', '2025-11-21 16:03:04', 1, NULL),
(106, 112, 'NCR', 'Metro Manila', 'Quezon City', '123 Admin St, Brgy. Central', '2025-11-22 17:37:33', '2025-11-22 17:37:33', 1, NULL),
(109, 115, 'Region IV-A (CALABARZON)', 'Rizal', 'Cainta', '  P. Burgos Street, Dyquiangco Building', '2025-11-23 10:33:39', '2025-11-23 10:33:39', 1, NULL),
(110, 116, 'National Capital Region (NCR)', 'NCR', 'Quezon City', '1130 Oroquieta Street 1000', '2025-11-23 10:56:25', '2025-11-23 10:56:25', 1, NULL),
(114, 120, 'National Capital Region (NCR)', 'NCR', 'Quezon City', '2/F Cluster Building IN-31 C.M. Recto Avenue Tutuban 1000', '2025-11-23 11:39:22', '2025-11-23 11:39:22', 1, NULL),
(115, 121, 'National Capital Region (NCR)', 'NCR', 'Manila', ' 6 Quiapo Underpass 1000', '2025-11-23 11:51:58', '2025-11-23 11:51:58', 1, NULL),
(117, 123, 'National Capital Region (NCR)', 'NCR', 'Quezon City', 'Palanas A', '2025-11-23 16:47:18', '2025-11-23 16:47:18', 1, NULL),
(124, 130, 'National Capital Region (NCR)', 'NCR', 'Makati City', ' 1047 Metropolitan Avenue, Sta Cruz', '2025-11-23 17:37:16', '2025-11-23 17:37:16', 1, NULL),
(126, 132, 'National Capital Region (NCR)', 'NCR', 'Manila', '  Madrigal Building', '2025-11-24 05:08:20', '2025-11-24 05:08:20', 1, NULL),
(129, 135, 'National Capital Region (NCR)', 'NCR', 'Pateros', '13 Oregano st. Palanas A Barangay Vasra', '2025-11-24 06:36:17', '2025-11-24 06:36:17', 72, NULL),
(130, 136, 'National Capital Region (NCR)', 'NCR', 'Quezon City', 'Novaliches', '2025-11-25 03:52:11', '2025-11-25 03:52:11', 1, NULL),
(133, 139, 'National Capital Region (NCR)', 'NCR', 'Quezon City', 'lock 2 Lot 5 & 6 Vico Subdivision Bgy Bahay Toro Project 8', '2025-11-25 04:11:49', '2025-11-25 04:11:49', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `dependant_contact`
--

CREATE TABLE `dependant_contact` (
  `dependant_contact_id` int NOT NULL,
  `dependant_id` int DEFAULT NULL,
  `contact_no` varchar(25) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `dependant_contact`
--

INSERT INTO `dependant_contact` (`dependant_contact_id`, `dependant_id`, `contact_no`, `created_at`, `updated_at`, `created_by`, `updated_by`) VALUES
(1, 1, '+63 917 555 1234', '2025-11-09 10:18:55', '2025-11-09 10:18:55', 1, NULL),
(2, 2, '+63 918 555 2345', '2025-11-09 10:18:55', '2025-11-09 10:18:55', 1, NULL),
(3, 3, '+63 919 555 3456', '2025-11-09 10:18:55', '2025-11-09 10:18:55', 1, NULL),
(4, 5, '+63 920 555 4567', '2025-11-09 10:18:55', '2025-11-09 10:18:55', 1, NULL),
(10, 14, '09123233232', '2025-11-11 15:21:03', '2025-11-11 15:21:03', 1, NULL),
(11, 15, '09123213323', '2025-11-11 15:21:03', '2025-11-11 15:21:03', 1, NULL),
(20, 24, '09242522255', '2025-11-11 18:16:53', '2025-11-11 18:16:53', 1, NULL),
(50, 54, '09232222213', '2025-11-12 15:19:47', '2025-11-12 15:19:47', 1, NULL),
(51, 55, '09123123223', '2025-11-12 15:22:00', '2025-11-12 15:22:00', 1, NULL),
(52, 56, '09343344334', '2025-11-12 15:32:06', '2025-11-12 15:32:06', 1, NULL),
(56, 60, '09766667744', '2025-11-12 17:33:24', '2025-11-12 17:33:24', 1, NULL),
(57, 61, '09012323223', '2025-11-13 02:47:37', '2025-11-13 02:47:37', 1, NULL),
(71, 76, '09232515556', '2025-11-20 01:58:13', '2025-11-20 01:58:13', 1, NULL),
(72, 77, '09412551566', '2025-11-20 02:24:17', '2025-11-20 02:24:17', 1, NULL),
(73, 78, '09251555733', '2025-11-20 02:32:14', '2025-11-20 02:32:14', 1, NULL),
(74, 79, '09452511555', '2025-11-20 02:37:50', '2025-11-20 02:37:50', 1, NULL),
(83, 88, '09123123122', '2025-11-20 07:41:56', '2025-11-20 07:41:56', 1, NULL),
(91, 96, '09515516662', '2025-11-21 06:27:10', '2025-11-21 06:27:10', 1, NULL),
(95, 100, '09415556166', '2025-11-21 06:39:40', '2025-11-21 06:39:40', 1, NULL),
(97, 102, '09515661666', '2025-11-21 16:03:04', '2025-11-21 16:03:04', 1, NULL),
(107, 112, '+639215555678', '2025-11-22 17:37:32', '2025-11-22 17:37:32', 1, NULL),
(110, 115, '09123551661', '2025-11-23 10:33:39', '2025-11-23 10:33:39', 1, NULL),
(111, 116, '09512566124', '2025-11-23 10:56:25', '2025-11-23 10:56:25', 1, NULL),
(115, 120, '09123661242', '2025-11-23 11:39:22', '2025-11-23 11:39:22', 1, NULL),
(116, 121, '09123512661', '2025-11-23 11:51:58', '2025-11-23 11:51:58', 1, NULL),
(118, 123, '09412314151', '2025-11-23 16:47:18', '2025-11-23 16:47:18', 1, NULL),
(125, 130, '09723232226', '2025-11-23 17:37:16', '2025-11-23 17:37:16', 1, NULL),
(127, 132, '09515251566', '2025-11-24 05:08:20', '2025-11-24 05:08:20', 1, NULL),
(130, 135, '09093123232', '2025-11-24 06:36:17', '2025-11-24 06:36:17', 72, NULL),
(131, 136, '09123155151', '2025-11-25 03:52:11', '2025-11-25 03:52:11', 1, NULL),
(134, 139, '09123512525', '2025-11-25 04:11:49', '2025-11-25 04:11:49', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `dependant_email`
--

CREATE TABLE `dependant_email` (
  `dependant_email_id` int NOT NULL,
  `dependant_id` int DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `dependant_email`
--

INSERT INTO `dependant_email` (`dependant_email_id`, `dependant_id`, `email`, `created_at`, `updated_at`, `created_by`, `updated_by`) VALUES
(1, 1, 'miguel.santos@email.com', '2025-11-09 10:18:55', '2025-11-09 10:18:55', 1, NULL),
(2, 3, 'carmen.ramos@email.com', '2025-11-09 10:18:55', '2025-11-09 10:18:55', 1, NULL),
(3, 5, 'isabella.mendoza@email.com', '2025-11-09 10:18:55', '2025-11-09 10:18:55', 1, NULL),
(8, 55, 'ancog.christian.ihao@gmail.com', '2025-11-12 15:22:00', '2025-11-12 15:22:00', 1, NULL),
(10, 60, 'ancog.christian.ihao@gmail.com', '2025-11-12 17:33:24', '2025-11-12 17:33:24', 1, NULL),
(24, 76, 'DelDylan@gmail.com', '2025-11-20 01:58:13', '2025-11-20 01:58:13', 1, NULL),
(27, 88, 'm@gmail.com', '2025-11-20 07:41:55', '2025-11-20 07:41:55', 1, NULL),
(30, 112, 'roberto.admin@email.com', '2025-11-22 17:37:32', '2025-11-22 17:37:32', 1, NULL),
(32, 116, 'ancog.christian.ihao@gmail.com', '2025-11-23 10:56:25', '2025-11-23 10:56:25', 1, NULL),
(40, 135, 'ancog.christian.ihao@gmail.com', '2025-11-24 06:36:16', '2025-11-24 06:36:16', 72, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `employee_id` int NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) NOT NULL,
  `extension_name` varchar(10) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `department_id` int DEFAULT NULL,
  `position` varchar(100) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`employee_id`, `first_name`, `middle_name`, `last_name`, `extension_name`, `email`, `department_id`, `position`, `is_active`) VALUES
(1, 'Juan', 'Dela', 'Cruz', 'Jr.', 'juan.delacruz@email.com', 2, 'IT Officer', 1),
(12, 'Juan', 'Dela', 'Cruz', 'Jr.', 'juan.pogiqtqt@email.com', 1, 'IT Officer', 1),
(13, 'Maria', 'Lopez', 'Santos', NULL, 'maria.santos@email.com', 2, 'HR Assistant', 1),
(14, 'Jose', 'Reyes', 'Fernandez', NULL, 'jose.fernandez@email.com', 1, 'System Administrator', 1),
(15, 'Ana', 'Torres', 'Garcia', NULL, 'ana.garcia@email.com', 3, 'Finance Officer', 1),
(16, 'Mark', 'Luis', 'Villanueva', NULL, 'mark.villanueva@email.com', 4, 'Logistics Coordinator', 1),
(17, 'Catherine', 'Mae', 'Rodriguez', NULL, 'catherine.rodriguez@email.com', 2, 'HR Supervisor', 1),
(18, 'David', 'Paul', 'Mendoza', NULL, 'david.mendoza@email.com', 1, 'Software Developer', 1),
(19, 'Liza', 'Grace', 'Navarro', NULL, 'liza.navarro@email.com', 3, 'Accountant', 1),
(20, 'Rico', 'Andres', 'Santiago', NULL, 'rico.santiago@email.com', 4, 'Warehouse Clerk', 1),
(21, 'Elaine', 'Joy', 'Cruz', NULL, 'elaine.cruz@email.com', 5, 'Procurement Officer', 1),
(22, 'Marx Elis', NULL, 'Suarez', NULL, 'ultimatemarxelis12@gmail.com', 1, 'System Administrator', 1);

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `employee_id` int NOT NULL,
  `employee_code` varchar(10) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `fingerprint_id` int DEFAULT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `middle_name` varchar(100) DEFAULT NULL,
  `extension_name` varchar(10) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `gender` enum('male','female','others') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'others',
  `civil_status` enum('single','married','divorced','widowed') DEFAULT 'single',
  `position_id` int DEFAULT NULL,
  `department_id` int DEFAULT NULL,
  `shift` enum('morning','night') DEFAULT 'morning',
  `salary` decimal(10,2) DEFAULT NULL,
  `hire_date` date DEFAULT NULL,
  `leave_credit` int DEFAULT '15',
  `supervisor_id` int DEFAULT NULL,
  `status` enum('active','resigned','terminated','on-leave') DEFAULT 'active',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL
) ;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`employee_id`, `employee_code`, `user_id`, `fingerprint_id`, `first_name`, `last_name`, `middle_name`, `extension_name`, `birthdate`, `gender`, `civil_status`, `position_id`, `department_id`, `shift`, `salary`, `hire_date`, `leave_credit`, `supervisor_id`, `status`, `created_at`, `updated_at`, `created_by`, `updated_by`) VALUES
(1, 'EMP-0001', 1, NULL, 'Super', 'Admin', 'System', NULL, '1985-01-01', 'male', 'single', 1, 1, 'morning', 80000.00, '2020-01-01', 15, NULL, 'active', '2025-11-11 05:40:40', '2025-11-22 16:13:21', 1, 1),
(2, 'EMP-0002', 2, NULL, 'Maria', 'Santos', 'Cruz', NULL, '1990-03-15', 'female', 'married', 1, 1, 'morning', 45000.00, '2021-02-01', 15, NULL, 'active', '2025-11-11 05:40:43', '2025-11-11 05:40:43', 1, NULL),
(3, 'EMP-0003', 3, NULL, 'Matt Henry', 'Buenaventura', 'Reyes', NULL, '1988-07-20', 'male', 'single', 5, 2, 'morning', 55000.00, '2021-03-01', 15, NULL, 'active', '2025-11-11 05:40:49', '2025-11-18 06:54:27', 1, 3),
(4, 'EMP-0004', 4, NULL, 'Ana', 'Garcia', 'Lopez', NULL, '1992-05-10', 'female', 'single', 9, 3, 'morning', 35000.00, '2021-04-01', 15, NULL, 'active', '2025-11-11 05:40:55', '2025-11-11 05:40:55', 1, NULL),
(5, 'EMP-0005', 5, NULL, 'Pedro', 'Ramos', 'Silva', NULL, '1987-11-25', 'male', 'married', 2, 1, 'morning', 40000.00, '2021-05-01', 15, 2, 'active', '2025-11-11 05:41:02', '2025-11-11 05:41:02', 1, NULL),
(6, 'EMP-0006', 6, NULL, 'Carlos', 'Mendoza', 'Torres', NULL, '1986-09-18', 'male', 'married', 5, 2, 'morning', 50000.00, '2021-05-15', 15, 3, 'active', '2025-11-11 05:41:08', '2025-11-11 05:41:08', 1, NULL),
(7, 'EMP-0007', 7, NULL, 'Rosa', 'Martinez', 'Fernandez', NULL, '1989-04-12', 'female', 'single', 9, 3, 'morning', 38000.00, '2021-06-01', 15, 4, 'active', '2025-11-11 05:41:14', '2025-11-11 05:41:14', 1, NULL),
(12, 'EMP-0012', 12, NULL, 'Jenny', 'Cruz', 'Bautista', NULL, '1997-10-08', 'female', 'single', 10, 3, 'morning', 25000.00, '2022-05-01', 15, 7, 'active', '2025-11-11 05:41:36', '2025-11-11 05:41:36', 1, NULL),
(13, 'EMP-0013', 13, NULL, 'Michael', 'Reyes', 'Santos', NULL, '1998-03-27', 'male', 'single', 19, 7, 'morning', 23000.00, '2022-06-01', 15, 7, 'active', '2025-11-11 05:41:40', '2025-11-12 15:22:00', 1, 1),
(18, 'EMP-0018', 18, NULL, 'Nicole', 'Mayo', NULL, NULL, '1995-03-01', 'female', 'single', 13, 4, 'morning', 1000.00, '2025-11-05', 15, NULL, 'active', '2025-11-11 15:03:38', '2025-11-11 15:05:36', 1, 1),
(19, 'EMP-0019', 19, NULL, 'Vincent', 'Torio', NULL, NULL, '1990-02-09', 'male', 'married', 14, 5, 'morning', 1000.00, '2025-11-03', 15, NULL, 'active', '2025-11-11 15:31:18', '2025-11-12 15:19:46', 1, 1),
(21, 'EMP-0021', 21, 3, 'Gabriel Aaron', 'Chavez', NULL, NULL, '2001-12-03', 'others', 'single', 27, 4, 'morning', 1023.00, '2025-10-30', 15, 7, 'active', '2025-11-11 17:25:45', '2025-11-23 17:37:16', 1, 1),
(22, 'EMP-0022', 22, NULL, 'Lawrence', 'Savariz', NULL, NULL, '0004-10-02', 'male', 'single', 1, 1, 'morning', 1000.00, '2025-10-29', 15, NULL, 'active', '2025-11-11 17:57:10', '2025-11-11 18:16:53', 1, 1),
(23, 'EMP-0023', 23, NULL, 'Emmanuel', 'Frias', NULL, NULL, '1991-11-11', 'male', 'single', 28, 13, 'morning', 20052.00, '2025-11-06', 15, NULL, 'active', '2025-11-12 15:32:06', '2025-11-12 15:32:06', 1, NULL),
(27, 'EMP-0027', 27, NULL, 'Shawn', 'Cordero', NULL, NULL, '2005-02-09', 'male', 'single', 22, 9, 'morning', 2000.00, '2025-11-06', 15, NULL, 'active', '2025-11-12 17:33:24', '2025-11-12 17:33:24', 1, NULL),
(29, 'EMP-0029', 29, NULL, 'Ethan', 'Atienza', NULL, NULL, '2001-12-29', 'male', 'single', 19, 7, 'night', 10000.00, '2025-11-03', 15, NULL, 'active', '2025-11-13 02:47:36', '2025-11-13 02:47:37', 1, NULL),
(40, 'EMP-0000', 40, NULL, 'Public', 'User', NULL, NULL, NULL, 'others', 'single', NULL, NULL, 'morning', NULL, NULL, 15, NULL, 'active', '2025-11-15 04:08:42', '2025-11-15 04:08:42', NULL, NULL),
(41, 'EMP-0041', 41, NULL, 'Ezekiel', 'De Leon', NULL, NULL, '1995-12-01', 'male', 'married', 18, 9, 'morning', 13000.00, '2025-11-14', 15, NULL, 'active', '2025-11-20 01:58:13', '2025-11-20 01:58:13', 1, NULL),
(42, 'EMP-0042', 42, NULL, 'Sophia', 'Santos', NULL, NULL, '1996-08-09', 'female', 'single', 17, 11, 'night', 20000.00, '2025-10-03', 15, NULL, 'active', '2025-11-20 02:24:17', '2025-11-20 02:24:17', 1, NULL),
(43, 'EMP-0043', 43, NULL, 'Genkei', 'Domingo', 'Liberal', NULL, '1990-05-23', 'male', 'married', 19, 7, 'night', 25000.00, '2023-02-14', 15, NULL, 'active', '2025-11-20 02:32:14', '2025-11-20 02:32:14', 1, NULL),
(44, 'EMP-0044', 44, NULL, 'Hazel', 'Lacson', NULL, NULL, '2000-01-13', 'female', 'single', 20, 10, 'morning', 24000.00, '2021-05-20', 15, NULL, 'active', '2025-11-20 02:37:50', '2025-11-20 02:37:50', 1, NULL),
(45, 'EMP-0045', 45, NULL, 'Theo', 'Barrientos', NULL, NULL, '1995-09-09', 'male', 'single', 22, 9, 'night', 18000.00, '2023-06-20', 15, NULL, 'active', '2025-11-20 02:46:07', '2025-11-21 06:27:08', 1, 1),
(47, 'EMP-0047', 47, NULL, 'Ryan', 'Marasigan', NULL, NULL, '1999-08-09', 'male', 'single', 16, 6, 'night', 45000.00, '2021-04-29', 15, NULL, 'active', '2025-11-20 04:44:49', '2025-11-21 06:28:30', 1, 1),
(48, 'EMP-0048', 48, NULL, 'Ernie', 'Catalan', NULL, NULL, '2005-10-05', 'male', 'single', 28, 13, 'morning', 20134.00, '2025-11-20', 15, NULL, 'active', '2025-11-20 06:35:30', '2025-11-21 17:03:19', 1, 1),
(49, 'EMP-0049', 49, NULL, 'Paciano', 'Rizal', 'Realonda', NULL, '2000-02-10', 'male', 'single', 26, 12, 'morning', 20000.00, '2023-10-19', 15, NULL, 'active', '2025-11-20 07:47:36', '2025-11-23 10:33:38', 1, 1),
(56, 'EMP-0056', 56, NULL, 'John Wilmer', 'Ti-maan', NULL, NULL, '2005-02-01', 'male', 'single', 18, 9, 'morning', 15000.00, '2022-02-13', 15, NULL, 'active', '2025-11-21 06:46:44', '2025-11-23 10:58:04', 1, 1),
(57, 'EMP-0057', 57, NULL, 'Angelo', 'Gallardo', NULL, NULL, '2005-05-01', 'male', 'single', 21, 11, 'morning', 20000.00, '2022-05-07', 15, NULL, 'active', '2025-11-21 16:03:04', '2025-11-21 17:31:13', 1, NULL),
(60, 'EMP-0060', 60, 4, 'Aaron', 'Apostol', 'Medina', NULL, '2000-10-01', 'male', 'single', 22, 9, 'morning', 19900.00, '2024-09-04', 15, NULL, 'active', '2025-11-21 16:53:46', '2025-11-24 05:08:19', 1, 1),
(61, 'EMP-0061', 61, 6, 'Marx Elis', 'Suarez', 'Mañginsay', NULL, '2005-01-02', 'male', 'single', 5, 2, 'morning', 10000.00, '2023-04-02', 15, NULL, 'on-leave', '2025-11-21 17:38:59', '2025-11-25 04:11:49', 1, 1),
(63, 'EMP-0063', 63, NULL, 'Cristina', 'Patulilic', NULL, NULL, '2001-12-02', 'female', 'single', 17, 11, 'morning', 20000.00, '2021-01-23', 15, NULL, 'active', '2025-11-23 10:56:24', '2025-11-23 17:07:11', 1, NULL),
(65, 'EMP-0065', 65, NULL, 'Vince Joseph', 'Vargas', 'G ', NULL, '1997-05-16', 'male', 'single', 22, 9, 'morning', 19000.00, '2022-07-07', 15, NULL, 'active', '2025-11-23 11:39:22', '2025-11-23 17:08:02', 1, NULL),
(66, 'EMP-0066', 66, NULL, 'Arjay', 'Garabiag', NULL, NULL, '1993-08-08', 'male', 'single', 19, 7, 'morning', 20000.00, '2021-08-12', 15, NULL, 'active', '2025-11-23 11:51:58', '2025-11-23 17:08:21', 1, NULL),
(72, 'EMP-0072', 72, 2, 'Christian', 'Ancog', 'Ihao', NULL, '2005-02-01', 'male', 'single', 6, 2, 'morning', 20000.00, '2022-01-13', 15, 6, 'active', '2025-11-23 17:30:10', '2025-11-23 17:30:35', 1, 72),
(73, 'EMP-0073', 73, 5, 'Franc Randell', 'Coton', NULL, NULL, '1997-02-01', 'male', 'single', 32, 8, 'morning', 21000.00, '2025-11-21', 15, NULL, 'active', '2025-11-25 03:52:10', '2025-11-25 03:52:10', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `employee_addresses`
--

CREATE TABLE `employee_addresses` (
  `address_id` int NOT NULL,
  `employee_id` int DEFAULT NULL,
  `region_name` varchar(100) DEFAULT NULL,
  `province_name` varchar(100) DEFAULT NULL,
  `city_name` varchar(100) DEFAULT NULL,
  `home_address` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `employee_addresses`
--

INSERT INTO `employee_addresses` (`address_id`, `employee_id`, `region_name`, `province_name`, `city_name`, `home_address`, `created_at`, `updated_at`, `created_by`, `updated_by`) VALUES
(1, 1, 'National Capital Region (NCR)', 'NCR', 'Manila', '123 Admin St', '2025-11-20 04:15:20', '2025-11-22 16:11:12', 1, 1),
(2, 2, 'NCR', 'Metro Manila', 'Makati City', '456 HR Ave', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, NULL),
(3, 3, 'NCR', 'Metro Manila', 'Pasig City', '789 Tech Blvd', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, 3),
(4, 4, 'NCR', 'Metro Manila', 'Manila', '321 Front St', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, NULL),
(5, 5, 'NCR', 'Metro Manila', 'Quezon City', '654 Supervisor Ln', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, NULL),
(6, 6, 'NCR', 'Metro Manila', 'Makati City', '789 IT Supervisor St', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, NULL),
(7, 7, 'NCR', 'Metro Manila', 'Manila', '321 Front Desk Supervisor Ave', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, NULL),
(8, 8, 'NCR', 'Metro Manila', 'Mandaluyong', '258 HR Plaza', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, NULL),
(9, 9, 'NCR', 'Metro Manila', 'Quezon City', '369 Recruitment St', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, NULL),
(10, 10, 'National Capital Region (NCR)', 'NCR', 'Quezon City', '741 Dev Center', '2025-11-20 04:15:20', '2025-11-25 04:01:54', 1, 1),
(11, 12, 'NCR', 'Metro Manila', 'Manila', '963 Lobby Ave', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, NULL),
(12, 13, 'Region XII (SOCCSKSARGEN)', 'Cotabato', 'Arakan', '159 Front Office', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, 1),
(13, 18, 'Region IV-A (CALABARZON)', 'Rizal', 'City of Antipolo ', 'Unit 10, 2/F Molvina Commercial Complex, Marcos Highway', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, 1),
(14, 19, 'National Capital Region (NCR)', 'NCR', 'Quezon City', ' 533 Commonwealth Avenue 1121', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, 1),
(15, 21, 'National Capital Region (NCR)', 'NCR', 'Pasig City', ' 700 Shaw Boulevard', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, 1),
(16, 22, 'National Capital Region (NCR)', 'NCR', 'Manila', 'Pasilio 2 Central Market 1000', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, 1),
(17, 23, 'National Capital Region (NCR)', 'NCR', 'Quezon City', '  2 San Bartolome St., Capitol 6,', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, NULL),
(18, 27, 'National Capital Region (NCR)', 'NCR', 'Quezon City', ' PDCP Bank Center', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, NULL),
(19, 29, 'National Capital Region (NCR)', 'NCR', 'Makati City', ' 8741 Paseo De Roxas', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, NULL),
(20, 39, 'National Capital Region (NCR)', 'NCR', 'Quezon City', '13 Oregano st. Palanas A Barangay Vasra', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, 1),
(22, 41, 'National Capital Region (NCR)', 'NCR', 'Valenzuela City', ' 1161 Jorenz Avenue Tanada Subdivision 1440', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, NULL),
(23, 42, 'National Capital Region (NCR)', 'NCR', 'Manila', ' 2176 Road 6', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, NULL),
(24, 43, 'National Capital Region (NCR)', 'NCR', 'Makati City', ' 7/F Citibank Center8741 Paseo De Roxas1200', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, NULL),
(25, 44, 'National Capital Region (NCR)', 'NCR', 'Quezon City', '68 West Avenue', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, NULL),
(26, 45, 'National Capital Region (NCR)', 'NCR', 'San Juan City', '199-B E. Rodriguez Street', '2025-11-20 04:15:20', '2025-11-21 06:27:08', 1, 1),
(27, 46, 'National Capital Region (NCR)', 'NCR', 'Quezon City', 'Quad Arcade 1 Ayala Avenue 1200', '2025-11-20 04:15:20', '2025-11-21 06:34:48', 1, 1),
(28, 48, 'Region III (Central Luzon)', 'Bulacan', 'Pulilan', 'DENR', '2025-11-20 06:35:32', '2025-11-20 07:40:59', 1, 1),
(29, 47, 'National Capital Region (NCR)', 'NCR', 'Makati City', ' 2288 Chino Roces Avenue Extension 1200', '2025-11-20 07:32:11', '2025-11-20 07:32:11', 1, 1),
(30, 49, 'Region IV-A (CALABARZON)', 'Rizal', 'Cainta', '  P. Burgos Street, Dyquiangco Building', '2025-11-20 07:47:37', '2025-11-20 14:02:22', 1, 1),
(31, 50, 'National Capital Region (NCR)', 'NCR', 'Quezon City', 'Palanas Vasra', '2025-11-20 16:30:16', '2025-11-20 16:30:16', 1, NULL),
(32, 51, 'National Capital Region (NCR)', 'NCR', 'Quezon City', 'Palanas A', '2025-11-20 17:06:08', '2025-11-20 17:06:08', 1, NULL),
(33, 52, 'National Capital Region (NCR)', 'NCR', 'Quezon City', 'Palanas A', '2025-11-20 18:42:00', '2025-11-22 18:17:58', 1, 1),
(34, 53, 'National Capital Region (NCR)', 'NCR', 'Quezon City', 'DENR', '2025-11-20 19:16:45', '2025-11-20 19:16:45', 1, NULL),
(35, 54, 'National Capital Region (NCR)', 'NCR', 'Quezon City', 'DENR', '2025-11-20 19:20:24', '2025-11-20 19:20:24', 1, NULL),
(36, 56, 'Region VI (Western Visayas)', 'Aklan', 'Numancia', 'Novaliches', '2025-11-21 06:46:45', '2025-11-23 10:58:04', 1, 1),
(37, 57, 'National Capital Region (NCR)', 'NCR', 'Manila', '1241 Padre Faura Street Corner M.H. Del Pilar Street Ermita 1000', '2025-11-21 16:03:04', '2025-11-21 16:03:04', 1, NULL),
(38, 58, 'National Capital Region (NCR)', 'NCR', 'Manila', ' 1233 United Nations Avenue, Paco', '2025-11-21 16:27:32', '2025-11-24 05:06:13', 1, 1),
(39, 59, 'National Capital Region (NCR)', 'NCR', 'Manila', '1617 Sisa Street 1200', '2025-11-21 16:32:17', '2025-11-22 06:24:12', 1, 1),
(40, 60, 'National Capital Region (NCR)', 'NCR', 'Manila', '  Madrigal Building', '2025-11-21 16:53:46', '2025-11-22 06:27:49', 1, 1),
(41, 61, 'National Capital Region (NCR)', 'NCR', 'Quezon City', 'lock 2 Lot 5 & 6 Vico Subdivision Bgy Bahay Toro Project 8', '2025-11-21 17:38:59', '2025-11-21 18:44:59', 1, 1),
(42, 62, 'National Capital Region (NCR)', 'NCR', 'Quezon City', ' Palanas A Barangay Vasra', '2025-11-22 18:06:43', '2025-11-22 18:06:43', 1, NULL),
(43, 63, 'National Capital Region (NCR)', 'NCR', 'Manila', '1130 Oroquieta Street 1000', '2025-11-23 10:56:25', '2025-11-23 10:56:25', 1, NULL),
(44, 64, 'National Capital Region (NCR)', 'NCR', 'Quezon City', ' 358 G Araneta Avenue 1100', '2025-11-23 11:20:57', '2025-11-23 11:20:57', 1, NULL),
(45, 65, 'National Capital Region (NCR)', 'NCR', 'Quezon City', '2/F Cluster Building IN-31 C.M. Recto Avenue Tutuban 1000', '2025-11-23 11:39:22', '2025-11-23 11:39:22', 1, NULL),
(46, 66, 'National Capital Region (NCR)', 'NCR', 'Manila', ' 6 Quiapo Underpass 1000', '2025-11-23 11:51:58', '2025-11-23 11:51:58', 1, NULL),
(47, 67, 'National Capital Region (NCR)', 'NCR', 'Quezon City', 'Palanas A', '2025-11-23 15:29:26', '2025-11-23 15:29:26', 1, NULL),
(48, 68, 'National Capital Region (NCR)', 'NCR', 'Quezon City', 'Palanas A', '2025-11-23 16:59:38', '2025-11-23 16:59:38', 1, NULL),
(49, 69, 'National Capital Region (NCR)', 'NCR', 'Quezon City', '13 Oregano st. Palanas A Barangay Vasra', '2025-11-23 17:02:46', '2025-11-23 17:02:46', 1, NULL),
(50, 70, 'National Capital Region (NCR)', 'NCR', 'Quezon City', '13 Oregano st. Palanas A Barangay Vasra', '2025-11-23 17:04:29', '2025-11-23 17:04:29', 1, NULL),
(51, 71, 'National Capital Region (NCR)', 'NCR', 'Quezon City', '13 Oregano st. Palanas A Barangay Vasra', '2025-11-23 17:27:58', '2025-11-23 17:28:54', 1, 1),
(52, 72, 'National Capital Region (NCR)', 'NCR', 'Quezon City', '13 Oregano st. Palanas A Barangay Vasra', '2025-11-23 17:30:10', '2025-11-24 06:14:04', 1, 72),
(53, 73, 'National Capital Region (NCR)', 'NCR', 'Quezon City', 'Novaliches', '2025-11-25 03:52:10', '2025-11-25 03:52:10', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `employee_addresses_backup`
--

CREATE TABLE `employee_addresses_backup` (
  `address_id` int NOT NULL DEFAULT '0',
  `employee_id` int DEFAULT NULL,
  `region_name` varchar(100) DEFAULT NULL,
  `province_name` varchar(100) DEFAULT NULL,
  `city_name` varchar(100) DEFAULT NULL,
  `home_address` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `employee_addresses_backup`
--

INSERT INTO `employee_addresses_backup` (`address_id`, `employee_id`, `region_name`, `province_name`, `city_name`, `home_address`, `created_at`, `updated_at`, `created_by`, `updated_by`) VALUES
(1, 1, 'NCR', 'Metro Manila', 'Quezon City', '123 Admin St', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, NULL),
(2, 2, 'NCR', 'Metro Manila', 'Makati City', '456 HR Ave', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, NULL),
(3, 3, 'NCR', 'Metro Manila', 'Pasig City', '789 Tech Blvd', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, 3),
(4, 4, 'NCR', 'Metro Manila', 'Manila', '321 Front St', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, NULL),
(5, 5, 'NCR', 'Metro Manila', 'Quezon City', '654 Supervisor Ln', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, NULL),
(6, 6, 'NCR', 'Metro Manila', 'Makati City', '789 IT Supervisor St', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, NULL),
(7, 7, 'NCR', 'Metro Manila', 'Manila', '321 Front Desk Supervisor Ave', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, NULL),
(8, 8, 'NCR', 'Metro Manila', 'Mandaluyong', '258 HR Plaza', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, NULL),
(9, 9, 'NCR', 'Metro Manila', 'Quezon City', '369 Recruitment St', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, NULL),
(10, 10, 'National Capital Region (NCR)', 'NCR', 'Quezon City', '741 Dev Center', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, 10),
(11, 12, 'NCR', 'Metro Manila', 'Manila', '963 Lobby Ave', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, NULL),
(12, 13, 'Region XII (SOCCSKSARGEN)', 'Cotabato', 'Arakan', '159 Front Office', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, 1),
(13, 18, 'Region IV-A (CALABARZON)', 'Rizal', 'City of Antipolo ', 'Unit 10, 2/F Molvina Commercial Complex, Marcos Highway', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, 1),
(14, 19, 'National Capital Region (NCR)', 'NCR', 'Quezon City', ' 533 Commonwealth Avenue 1121', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, 1),
(15, 21, 'National Capital Region (NCR)', 'NCR', 'Pasig City', ' 700 Shaw Boulevard', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, 1),
(16, 22, 'National Capital Region (NCR)', 'NCR', 'Manila', 'Pasilio 2 Central Market 1000', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, 1),
(17, 23, 'National Capital Region (NCR)', 'NCR', 'Quezon City', '  2 San Bartolome St., Capitol 6,', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, NULL),
(18, 27, 'National Capital Region (NCR)', 'NCR', 'Quezon City', ' PDCP Bank Center', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, NULL),
(19, 29, 'National Capital Region (NCR)', 'NCR', 'Makati City', ' 8741 Paseo De Roxas', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, NULL),
(20, 39, 'National Capital Region (NCR)', 'NCR', 'Quezon City', '13 Oregano st. Palanas A Barangay Vasra', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, 1),
(22, 41, 'National Capital Region (NCR)', 'NCR', 'Valenzuela City', ' 1161 Jorenz Avenue Tanada Subdivision 1440', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, NULL),
(23, 42, 'National Capital Region (NCR)', 'NCR', 'Manila', ' 2176 Road 6', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, NULL),
(24, 43, 'National Capital Region (NCR)', 'NCR', 'Makati City', ' 7/F Citibank Center8741 Paseo De Roxas1200', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, NULL),
(25, 44, 'National Capital Region (NCR)', 'NCR', 'Quezon City', '68 West Avenue', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, NULL),
(26, 45, 'National Capital Region (NCR)', 'NCR', 'San Juan City', '199-B E. Rodriguez Street', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, NULL),
(27, 46, 'National Capital Region (NCR)', 'NCR', 'Quezon City', 'Quad Arcade 1 Ayala Avenue 1200', '2025-11-20 04:15:20', '2025-11-20 04:15:20', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `employee_contact_numbers`
--

CREATE TABLE `employee_contact_numbers` (
  `contact_id` int NOT NULL,
  `employee_id` int NOT NULL,
  `contact_number` varchar(20) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `employee_contact_numbers`
--

INSERT INTO `employee_contact_numbers` (`contact_id`, `employee_id`, `contact_number`, `created_at`, `updated_at`, `created_by`, `updated_by`) VALUES
(2, 2, '+63 918 234 5678', '2025-11-11 05:41:47', '2025-11-11 05:41:47', 1, NULL),
(4, 4, '+63 920 456 7890', '2025-11-11 05:41:47', '2025-11-11 05:41:47', 1, NULL),
(5, 5, '+63 921 567 8901', '2025-11-11 05:41:47', '2025-11-11 05:41:47', 1, NULL),
(6, 6, '+63 922 678 9012', '2025-11-11 05:41:47', '2025-11-11 05:41:47', 1, NULL),
(7, 7, '+63 923 789 0123', '2025-11-11 05:41:47', '2025-11-11 05:41:47', 1, NULL),
(12, 12, '+63 928 234 5678', '2025-11-11 05:41:47', '2025-11-11 05:41:47', 1, NULL),
(20, 18, '09234234242', '2025-11-11 15:21:03', '2025-11-11 15:21:03', NULL, NULL),
(29, 22, '09971231232', '2025-11-11 18:16:53', '2025-11-11 18:16:53', NULL, NULL),
(59, 19, '09123233222', '2025-11-12 15:19:47', '2025-11-12 15:19:47', NULL, NULL),
(60, 13, '+639293456789', '2025-11-12 15:22:00', '2025-11-12 15:22:00', NULL, NULL),
(61, 23, '09424224244', '2025-11-12 15:32:06', '2025-11-12 15:32:06', NULL, NULL),
(65, 27, '09123233222', '2025-11-12 17:33:24', '2025-11-12 17:33:24', NULL, NULL),
(66, 29, '09322214141', '2025-11-13 02:47:37', '2025-11-13 02:47:37', NULL, NULL),
(83, 3, '+639193456789', '2025-11-18 06:54:27', '2025-11-18 06:54:27', NULL, NULL),
(86, 41, '09123123232', '2025-11-20 01:58:13', '2025-11-20 01:58:13', NULL, NULL),
(87, 42, '09277151515', '2025-11-20 02:24:17', '2025-11-20 02:24:17', NULL, NULL),
(88, 43, '09882455777', '2025-11-20 02:32:14', '2025-11-20 02:32:14', NULL, NULL),
(89, 44, '09455166125', '2025-11-20 02:37:50', '2025-11-20 02:37:50', NULL, NULL),
(98, 48, '09196593794', '2025-11-20 07:41:55', '2025-11-20 07:41:55', NULL, NULL),
(106, 45, '09415515155', '2025-11-21 06:27:09', '2025-11-21 06:27:09', NULL, NULL),
(110, 47, '09662781722', '2025-11-21 06:39:40', '2025-11-21 06:39:40', NULL, NULL),
(112, 57, '09516726771', '2025-11-21 16:03:04', '2025-11-21 16:03:04', NULL, NULL),
(120, 1, '09951515515', '2025-11-22 16:13:22', '2025-11-22 16:13:22', NULL, NULL),
(123, 49, '09151555611', '2025-11-23 10:33:38', '2025-11-23 10:33:38', NULL, NULL),
(124, 63, '09515241245', '2025-11-23 10:56:24', '2025-11-23 10:56:24', NULL, NULL),
(128, 65, '09123557152', '2025-11-23 11:39:22', '2025-11-23 11:39:22', NULL, NULL),
(129, 66, '09232516622', '2025-11-23 11:51:58', '2025-11-23 11:51:58', NULL, NULL),
(131, 56, '09123515151', '2025-11-23 16:47:17', '2025-11-23 16:47:17', NULL, NULL),
(137, 72, '09512516661', '2025-11-23 17:30:10', '2025-11-23 17:30:10', NULL, NULL),
(138, 21, '09123123321', '2025-11-23 17:37:16', '2025-11-23 17:37:16', NULL, NULL),
(140, 60, '09516167725', '2025-11-24 05:08:20', '2025-11-24 05:08:20', NULL, NULL),
(141, 73, '09123551615', '2025-11-25 03:52:10', '2025-11-25 03:52:10', NULL, NULL),
(144, 61, '09512416161', '2025-11-25 04:11:49', '2025-11-25 04:11:49', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `employee_emails`
--

CREATE TABLE `employee_emails` (
  `email_id` int NOT NULL,
  `employee_id` int NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `employee_emails`
--

INSERT INTO `employee_emails` (`email_id`, `employee_id`, `email`, `created_at`, `updated_at`, `created_by`, `updated_by`) VALUES
(2, 2, 'maria.santos@gmail.com', '2025-11-11 05:41:49', '2025-11-11 05:41:49', 1, NULL),
(4, 4, 'ana.garcia@gmail.com', '2025-11-11 05:41:49', '2025-11-11 05:41:49', 1, NULL),
(5, 5, 'pedro.ramos@gmail.com', '2025-11-11 05:41:49', '2025-11-11 05:41:49', 1, NULL),
(6, 6, 'carlos.mendoza@gmail.com', '2025-11-11 05:41:49', '2025-11-11 05:41:49', 1, NULL),
(7, 7, 'rosa.martinez@gmail.com', '2025-11-11 05:41:49', '2025-11-11 05:41:49', 1, NULL),
(12, 12, 'jenny.cruz@gmail.com', '2025-11-11 05:41:49', '2025-11-11 05:41:49', 1, NULL),
(21, 18, 'mayo.nicole@gmail.com', '2025-11-11 15:21:02', '2025-11-11 15:21:02', NULL, NULL),
(30, 22, 'savaeizlawrence@gmail.com', '2025-11-11 18:16:53', '2025-11-11 18:16:53', NULL, NULL),
(60, 19, 'torio.vincent@gmail.com', '2025-11-12 15:19:47', '2025-11-12 15:19:47', NULL, NULL),
(61, 13, 'michael.reyes@gmail.com', '2025-11-12 15:22:00', '2025-11-12 15:22:00', NULL, NULL),
(62, 23, 'friasemmanuel@gmail.com', '2025-11-12 15:32:06', '2025-11-12 15:32:06', NULL, NULL),
(66, 27, 'corderoshawn@gmail.com', '2025-11-12 17:33:24', '2025-11-12 17:33:24', NULL, NULL),
(68, 29, 'atienzaethan@gmail.com', '2025-11-13 02:47:37', '2025-11-13 02:47:37', NULL, NULL),
(92, 3, 'matthenry1005200@gmail.com', '2025-11-18 06:54:27', '2025-11-18 06:54:27', NULL, NULL),
(96, 41, 'ezekieldeleon@gmail.com', '2025-11-20 01:58:13', '2025-11-20 01:58:13', NULL, NULL),
(97, 42, 'santossophia@gmail.com', '2025-11-20 02:24:17', '2025-11-20 02:24:17', NULL, NULL),
(98, 43, 'keidomingo@gmail.com', '2025-11-20 02:32:14', '2025-11-20 02:32:14', NULL, NULL),
(99, 44, 'lacsonhazel@gmail.com', '2025-11-20 02:37:50', '2025-11-20 02:37:50', NULL, NULL),
(110, 48, 'matthenrys@gmail.com', '2025-11-20 07:41:55', '2025-11-20 07:41:55', NULL, NULL),
(122, 45, 'marasiganRyan@gmail.com', '2025-11-21 06:27:08', '2025-11-21 06:27:08', NULL, NULL),
(128, 47, 'bagayanjohnwilmertimaan@gmail.com', '2025-11-21 06:39:39', '2025-11-21 06:39:39', NULL, NULL),
(130, 57, 'gallardoangelo@gmail.com', '2025-11-21 16:03:04', '2025-11-21 16:03:04', NULL, NULL),
(139, 1, 'superadmin@gmail.com', '2025-11-22 16:13:22', '2025-11-22 16:13:22', NULL, NULL),
(142, 49, 'codeexecute2023@gmail.com', '2025-11-23 10:33:38', '2025-11-23 10:33:38', NULL, NULL),
(143, 49, 'christiianix37@gmail.com', '2025-11-23 10:33:38', '2025-11-23 10:33:38', NULL, NULL),
(144, 63, 'patulilichousekeepingmanager@gmail.com', '2025-11-23 10:56:25', '2025-11-23 10:56:25', NULL, NULL),
(156, 65, 'vargasmaintenance@gmail.com', '2025-11-23 11:39:22', '2025-11-23 11:39:22', NULL, NULL),
(157, 66, 'garabiaginventory@gmail.com', '2025-11-23 11:51:58', '2025-11-23 11:51:58', NULL, NULL),
(159, 56, 'bagayan.maintenancemanager@gmail.com', '2025-11-23 16:47:17', '2025-11-23 16:47:17', NULL, NULL),
(166, 21, 'chavezgabriel@gmail.com', '2025-11-23 17:37:16', '2025-11-23 17:37:16', NULL, NULL),
(168, 60, 'ronsapostol12@gmail.com', '2025-11-24 05:08:20', '2025-11-24 05:08:20', NULL, NULL),
(171, 72, 'ancog.christian.ihao@gmail.com', '2025-11-24 06:13:41', '2025-11-24 06:13:41', NULL, NULL),
(172, 73, 'cotonfrancrandell@gmail.com', '2025-11-25 03:52:10', '2025-11-25 03:52:10', NULL, NULL),
(175, 61, 'ultimatemarxelis12@gmail.com', '2025-11-25 04:11:49', '2025-11-25 04:11:49', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `expenses_id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `budget_category_id` int DEFAULT NULL,
  `revenue_category_id` int DEFAULT NULL,
  `budget_variance_id` int DEFAULT NULL,
  `expense_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `amount` decimal(10,2) NOT NULL,
  `status` enum('Paid','Pending','Overdue') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Pending',
  `receipt_filename` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receipt_file_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `tax_amount` decimal(10,2) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `paid_date` date DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `vendor_supplier` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `expenses`
--

INSERT INTO `expenses` (`expenses_id`, `user_id`, `budget_category_id`, `revenue_category_id`, `budget_variance_id`, `expense_name`, `description`, `amount`, `status`, `receipt_filename`, `receipt_file_path`, `notes`, `tax_amount`, `is_active`, `paid_date`, `due_date`, `created_at`, `updated_at`, `vendor_supplier`) VALUES
(1, 3, 14, 3, NULL, 'Payroll', '', 20000.00, 'Pending', NULL, NULL, NULL, NULL, 1, '2025-11-10', NULL, '2025-11-07 00:52:07', '2025-11-10 11:47:37', 'N/a'),
(2, 3, 13, 1, 4, 'Posters', 'N/a', 20000.00, 'Pending', NULL, NULL, NULL, NULL, 1, '2025-11-10', NULL, '2025-11-08 01:35:25', '2025-11-10 11:47:38', 'N/a'),
(3, 3, 23, 1, NULL, 'Elite Level posters', '', 20000.00, 'Pending', NULL, NULL, NULL, NULL, 0, '2025-11-11', NULL, '2025-11-11 02:38:01', '2025-11-11 02:43:05', 'Print shop na maangas'),
(4, 3, 16, 1, 7, 'Elite Posters', '', 20000.00, 'Paid', NULL, NULL, NULL, NULL, 1, '2025-11-11', NULL, '2025-11-11 02:43:55', '2025-11-11 03:47:13', 'Print shop na maangas'),
(5, 3, 13, 1, 4, 'Office Supplies in The events room', '', 20000.00, 'Paid', NULL, NULL, NULL, NULL, 0, '2025-11-11', NULL, '2025-11-11 02:56:47', '2025-11-11 02:57:18', 'Mass diddy'),
(6, NULL, 16, 1, 7, 'Office Supplies', 'KAKABILI LANG BOSS', 2000.00, 'Paid', NULL, NULL, NULL, NULL, 1, '2025-11-13', NULL, '2025-11-13 04:52:58', '2025-11-13 04:52:58', 'Manalansa'),
(7, 3, 15, 1, 6, 'Bills', 'boombayah', 20000.00, 'Pending', NULL, NULL, NULL, NULL, 1, '2025-11-15', NULL, '2025-11-15 05:17:24', '2025-11-15 05:17:25', 'Meralco');

-- --------------------------------------------------------

--
-- Table structure for table `expense_variance_view`
--

CREATE TABLE `expense_variance_view` (
  `expense_name` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `budget_name` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_name` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `budgeted_amount` decimal(10,2) DEFAULT NULL,
  `actual_expense` decimal(10,2) NOT NULL,
  `variance` decimal(11,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fb_categories`
--

CREATE TABLE `fb_categories` (
  `category_id` int NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fb_categories`
--

INSERT INTO `fb_categories` (`category_id`, `name`) VALUES
(1, 'Appetizer'),
(2, 'Main Dish'),
(3, 'Desserts'),
(4, 'Beverages'),
(5, 'Kids Menu');

-- --------------------------------------------------------

--
-- Table structure for table `fb_ingredients`
--

CREATE TABLE `fb_ingredients` (
  `ingredient_id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `stock_level` decimal(10,2) NOT NULL DEFAULT '0.00',
  `unit_of_measurement` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'e.g., g, ml, pcs',
  `reorder_point` decimal(10,2) NOT NULL DEFAULT '10.00',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fb_ingredients`
--

INSERT INTO `fb_ingredients` (`ingredient_id`, `name`, `stock_level`, `unit_of_measurement`, `reorder_point`, `created_at`) VALUES
(1, 'Beef', 5220.00, 'g', 10.00, '2025-11-01 03:45:10'),
(2, 'Bread', 9714.00, 'pcs', 10.00, '2025-11-01 11:32:01'),
(3, 'Cheese', 8979.00, 'g', 10.00, '2025-11-01 11:32:52'),
(4, 'Chicken', 896.00, 'g', 10.00, '2025-11-02 00:00:53'),
(5, 'Pork', 2000.00, 'g', 10.00, '2025-11-02 00:12:38'),
(6, 'Potato', 6.00, 'pcs', 10.00, '2025-11-02 00:19:30'),
(7, 'Tomato', 0.00, 'pcs', 10.00, '2025-11-02 00:20:53'),
(8, 'Fish', 9988.00, 'g', 10.00, '2025-11-02 00:24:58'),
(9, 'Lettuce', 10006.00, 'pcs', 10.00, '2025-11-02 00:29:37'),
(10, 'Onion', 5.00, 'pcs', 10.00, '2025-11-02 00:34:54'),
(11, 'mango', 978.00, 'pcs', 10.00, '2025-11-06 15:48:41');

-- --------------------------------------------------------

--
-- Table structure for table `fb_inventory_logs`
--

CREATE TABLE `fb_inventory_logs` (
  `log_id` int NOT NULL,
  `ingredient_id` int NOT NULL,
  `staff_id` int DEFAULT NULL,
  `action_type` enum('RESTOCK','WASTE','ADJUST_ADD','ADJUST_SUBTRACT','INITIAL','ORDER_DEDUCT','ORDER_RESTORE') COLLATE utf8mb4_general_ci NOT NULL,
  `quantity_change` decimal(10,2) NOT NULL,
  `new_stock_level` decimal(10,2) NOT NULL,
  `reason` text COLLATE utf8mb4_general_ci,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fb_inventory_logs`
--

INSERT INTO `fb_inventory_logs` (`log_id`, `ingredient_id`, `staff_id`, `action_type`, `quantity_change`, `new_stock_level`, `reason`, `timestamp`) VALUES
(1, 1, NULL, 'ORDER_DEDUCT', 100.00, 6928.00, 'Order ID: 7', '2025-11-14 10:50:47'),
(2, 2, NULL, 'ORDER_DEDUCT', 1.00, 9964.00, 'Order ID: 7', '2025-11-14 10:50:48'),
(3, 3, NULL, 'ORDER_DEDUCT', 50.00, 9449.00, 'Order ID: 7', '2025-11-14 10:50:48'),
(4, 9, NULL, 'ORDER_DEDUCT', 1.00, 10007.00, 'Order ID: 7', '2025-11-14 10:50:48'),
(5, 10, NULL, 'ORDER_DEDUCT', 1.00, 6.00, 'Order ID: 7', '2025-11-14 10:50:48'),
(6, 6, NULL, 'ORDER_DEDUCT', 1.00, 7.00, 'Order ID: 7', '2025-11-14 10:50:48'),
(7, 7, NULL, 'ORDER_DEDUCT', 1.00, 3.00, 'Order ID: 7', '2025-11-14 10:50:48'),
(8, 4, NULL, 'ORDER_DEDUCT', 1.00, 937.00, 'Order ID: 7', '2025-11-14 10:50:49'),
(9, 1, NULL, 'ORDER_DEDUCT', 100.00, 6828.00, 'Order ID: 7', '2025-11-14 10:54:39'),
(10, 2, NULL, 'ORDER_DEDUCT', 1.00, 9963.00, 'Order ID: 7', '2025-11-14 10:54:39'),
(11, 3, NULL, 'ORDER_DEDUCT', 50.00, 9399.00, 'Order ID: 7', '2025-11-14 10:54:40'),
(12, 9, NULL, 'ORDER_DEDUCT', 1.00, 10006.00, 'Order ID: 7', '2025-11-14 10:54:40'),
(13, 10, NULL, 'ORDER_DEDUCT', 1.00, 5.00, 'Order ID: 7', '2025-11-14 10:54:40'),
(14, 6, NULL, 'ORDER_DEDUCT', 1.00, 6.00, 'Order ID: 7', '2025-11-14 10:54:40'),
(15, 7, NULL, 'ORDER_DEDUCT', 1.00, 2.00, 'Order ID: 7', '2025-11-14 10:54:40'),
(16, 4, NULL, 'ORDER_DEDUCT', 1.00, 936.00, 'Order ID: 7', '2025-11-14 10:54:40'),
(17, 1, NULL, 'ORDER_DEDUCT', 100.00, 6682.00, 'Order ID: 6', '2025-11-14 10:55:58'),
(18, 2, NULL, 'ORDER_DEDUCT', 1.00, 9960.00, 'Order ID: 6', '2025-11-14 10:55:58'),
(19, 3, NULL, 'ORDER_DEDUCT', 50.00, 9349.00, 'Order ID: 6', '2025-11-14 10:55:58'),
(20, 2, NULL, 'ORDER_DEDUCT', 2.00, 9960.00, 'Order ID: 6', '2025-11-14 10:55:58'),
(21, 7, NULL, 'ORDER_DEDUCT', 2.00, 0.00, 'Order ID: 6', '2025-11-14 10:55:58'),
(22, 1, NULL, 'ORDER_DEDUCT', 46.00, 6682.00, 'Order ID: 6', '2025-11-14 10:55:58'),
(23, 1, NULL, 'ORDER_DEDUCT', 100.00, 6582.00, 'Order ID: 3', '2025-11-14 10:59:48'),
(24, 2, NULL, 'ORDER_DEDUCT', 1.00, 9959.00, 'Order ID: 3', '2025-11-14 10:59:48'),
(25, 3, NULL, 'ORDER_DEDUCT', 50.00, 9299.00, 'Order ID: 3', '2025-11-14 10:59:48'),
(26, 8, NULL, 'ORDER_DEDUCT', 4.00, 9996.00, 'Order ID: 8', '2025-11-14 11:09:15'),
(27, 4, NULL, 'ORDER_DEDUCT', 8.00, 928.00, 'Order ID: 8', '2025-11-14 11:09:15'),
(28, 3, NULL, 'ORDER_DEDUCT', 4.00, 9295.00, 'Order ID: 8', '2025-11-14 11:09:15'),
(29, 1, NULL, 'ORDER_DEDUCT', 33.00, 6549.00, 'Order ID: 2', '2025-11-14 12:03:31'),
(30, 1, NULL, 'ORDER_DEDUCT', 100.00, 6416.00, 'Order ID: 9', '2025-11-14 13:27:27'),
(31, 2, NULL, 'ORDER_DEDUCT', 1.00, 9958.00, 'Order ID: 9', '2025-11-14 13:27:27'),
(32, 3, NULL, 'ORDER_DEDUCT', 50.00, 9245.00, 'Order ID: 9', '2025-11-14 13:27:27'),
(33, 1, NULL, 'ORDER_DEDUCT', 33.00, 6416.00, 'Order ID: 9', '2025-11-14 13:27:27'),
(34, 1, NULL, 'ORDER_DEDUCT', 33.00, 6383.00, 'Order ID: 14', '2025-11-14 13:55:23'),
(35, 2, NULL, 'ORDER_DEDUCT', 7.00, 9951.00, 'Order ID: 19', '2025-11-14 14:30:47'),
(36, 2, NULL, 'ORDER_DEDUCT', 7.00, 9944.00, 'Order ID: 19', '2025-11-14 14:33:02'),
(37, 1, NULL, 'ORDER_DEDUCT', 100.00, 6283.00, 'Order ID: 20', '2025-11-14 14:33:23'),
(38, 2, NULL, 'ORDER_DEDUCT', 1.00, 9943.00, 'Order ID: 20', '2025-11-14 14:33:23'),
(39, 3, NULL, 'ORDER_DEDUCT', 50.00, 9195.00, 'Order ID: 20', '2025-11-14 14:33:23'),
(40, 2, NULL, 'ORDER_DEDUCT', 7.00, 9936.00, 'Order ID: 21', '2025-11-14 14:35:20'),
(41, 1, NULL, 'ORDER_DEDUCT', 33.00, 6250.00, 'Order ID: 1', '2025-11-14 14:47:04'),
(42, 2, NULL, 'ORDER_DEDUCT', 7.00, 9929.00, 'Order ID: 25', '2025-11-14 14:54:52'),
(43, 1, NULL, 'ORDER_DEDUCT', 33.00, 6217.00, 'Order ID: 28', '2025-11-15 00:57:06'),
(44, 4, NULL, 'ORDER_DEDUCT', 8.00, 920.00, 'Order ID: 29', '2025-11-15 01:28:52'),
(45, 3, NULL, 'ORDER_DEDUCT', 4.00, 9191.00, 'Order ID: 29', '2025-11-15 01:28:52'),
(46, 1, NULL, 'ORDER_DEDUCT', 33.00, 6184.00, 'Order ID: 30', '2025-11-15 01:42:10'),
(47, 1, NULL, 'ORDER_DEDUCT', 33.00, 6151.00, 'Order ID: 31', '2025-11-15 01:44:56'),
(48, 4, NULL, 'ORDER_DEDUCT', 8.00, 912.00, 'Order ID: 32', '2025-11-15 01:45:53'),
(49, 3, NULL, 'ORDER_DEDUCT', 4.00, 9187.00, 'Order ID: 32', '2025-11-15 01:45:53'),
(50, 4, NULL, 'ORDER_DEDUCT', 8.00, 904.00, 'Order ID: 32', '2025-11-15 01:46:17'),
(51, 3, NULL, 'ORDER_DEDUCT', 4.00, 9183.00, 'Order ID: 32', '2025-11-15 01:46:17'),
(52, 1, NULL, 'ORDER_DEDUCT', 33.00, 6118.00, 'Order ID: 31', '2025-11-15 01:46:21'),
(53, 11, NULL, 'ORDER_DEDUCT', 2.00, 994.00, 'Order ID: 34', '2025-11-15 02:15:23'),
(54, 8, NULL, 'ORDER_DEDUCT', 4.00, 9992.00, 'Order ID: 35', '2025-11-15 02:16:16'),
(55, 8, NULL, 'ORDER_DEDUCT', 4.00, 9988.00, 'Order ID: 37', '2025-11-15 03:36:50'),
(56, 1, NULL, 'ORDER_DEDUCT', 100.00, 6018.00, 'Order ID: 36', '2025-11-15 03:36:52'),
(57, 2, NULL, 'ORDER_DEDUCT', 1.00, 9928.00, 'Order ID: 36', '2025-11-15 03:36:52'),
(58, 3, NULL, 'ORDER_DEDUCT', 50.00, 9133.00, 'Order ID: 36', '2025-11-15 03:36:52'),
(59, 11, NULL, 'ORDER_DEDUCT', 2.00, 992.00, 'Order ID: 38', '2025-11-15 07:12:15'),
(60, 11, NULL, 'ORDER_DEDUCT', 2.00, 990.00, 'Order ID: 38', '2025-11-15 07:12:31'),
(61, 2, NULL, 'ORDER_DEDUCT', 4.00, 9717.00, 'Order ID: 42', '2025-11-15 08:24:54'),
(62, 2, NULL, 'ORDER_DEDUCT', 7.00, 9717.00, 'Order ID: 42', '2025-11-15 08:24:54'),
(63, 11, NULL, 'ORDER_DEDUCT', 2.00, 988.00, 'Order ID: 42', '2025-11-15 08:24:54'),
(64, 1, NULL, 'ORDER_DEDUCT', 300.00, 5718.00, 'Order ID: 42', '2025-11-15 08:24:55'),
(65, 2, NULL, 'ORDER_DEDUCT', 200.00, 9717.00, 'Order ID: 42', '2025-11-15 08:24:55'),
(66, 1, NULL, 'ORDER_DEDUCT', 66.00, 5452.00, 'Order ID: 41', '2025-11-15 08:25:09'),
(67, 1, NULL, 'ORDER_DEDUCT', 200.00, 5452.00, 'Order ID: 41', '2025-11-15 08:25:09'),
(68, 2, NULL, 'ORDER_DEDUCT', 2.00, 9715.00, 'Order ID: 41', '2025-11-15 08:25:09'),
(69, 3, NULL, 'ORDER_DEDUCT', 100.00, 9033.00, 'Order ID: 41', '2025-11-15 08:25:09'),
(70, 11, NULL, 'ORDER_DEDUCT', 2.00, 986.00, 'Order ID: 41', '2025-11-15 08:25:09'),
(71, 4, NULL, 'ORDER_DEDUCT', 8.00, 896.00, 'Order ID: 39', '2025-11-15 08:25:51'),
(72, 3, NULL, 'ORDER_DEDUCT', 4.00, 9029.00, 'Order ID: 39', '2025-11-15 08:25:51'),
(73, 11, NULL, 'ORDER_DEDUCT', 2.00, 982.00, 'Order ID: 10', '2025-11-15 08:26:34'),
(74, 11, NULL, 'ORDER_DEDUCT', 2.00, 982.00, 'Order ID: 10', '2025-11-15 08:26:35'),
(75, 11, NULL, 'ORDER_DEDUCT', 2.00, 978.00, 'Order ID: 11', '2025-11-15 08:26:53'),
(76, 11, NULL, 'ORDER_DEDUCT', 2.00, 978.00, 'Order ID: 11', '2025-11-15 08:26:53'),
(78, 1, NULL, 'ORDER_DEDUCT', 33.00, 5419.00, 'Order ID: 43', '2025-11-15 08:30:25'),
(79, 1, NULL, 'ORDER_DEDUCT', 100.00, 5286.00, 'Order ID: 44', '2025-11-15 08:31:33'),
(80, 2, NULL, 'ORDER_DEDUCT', 1.00, 9714.00, 'Order ID: 44', '2025-11-15 08:31:33'),
(81, 3, NULL, 'ORDER_DEDUCT', 50.00, 8979.00, 'Order ID: 44', '2025-11-15 08:31:33'),
(82, 1, NULL, 'ORDER_DEDUCT', 33.00, 5286.00, 'Order ID: 44', '2025-11-15 08:31:33'),
(83, 1, NULL, 'ORDER_DEDUCT', 33.00, 5253.00, 'Order ID: 13', '2025-11-15 08:34:22'),
(84, 1, NULL, 'ORDER_DEDUCT', 33.00, 5220.00, 'Order ID: 14', '2025-11-15 08:34:36');

-- --------------------------------------------------------

--
-- Table structure for table `fb_menu_items`
--

CREATE TABLE `fb_menu_items` (
  `item_id` int NOT NULL,
  `item_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `category_id` int DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `image_url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `is_promo` tinyint(1) NOT NULL DEFAULT '0',
  `promo_discount_percentage` int DEFAULT NULL,
  `promo_expiry_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fb_menu_items`
--

INSERT INTO `fb_menu_items` (`item_id`, `item_name`, `category_id`, `price`, `image_url`, `description`, `is_promo`, `promo_discount_percentage`, `promo_expiry_date`) VALUES
(1, 'Beef Steak', 2, 790.00, '/uploads\\image-1761969784106.jpg', 'Juicy Steak in the house!', 1, 10, '2025-11-15'),
(2, 'Cheese Burger', 1, 220.00, '/uploads\\image-1761996893473.jpg', 'A slice of cheese melted on top of the ground meat patty', 1, 15, '2025-11-11'),
(4, 'Bruschetta Trio', 1, 350.00, '/uploads\\image-1762442483719.jpeg', 'Toasted bread with tomato basil, mushroom, and tapenade.', 0, NULL, NULL),
(5, 'Classic Caesar Salad', 1, 380.00, '/uploads\\image-1762442760130.jpg', 'Romaine lettuce, parmesan, croutons, Caesar dressing', 0, NULL, NULL),
(6, 'Crispy Calamari', 1, 380.00, '/uploads\\image-1762443670734.jpeg', 'Lightly breaded squid rings with marinara sauce', 1, 10, '2025-11-11'),
(7, 'Buffalo Wings', 1, 360.00, '/uploads\\image-1762443753401.jpeg', '8 pieces of spicy chicken wings with blue cheese dip', 0, NULL, NULL),
(8, 'Spring Rolls', 1, 320.00, '/uploads\\image-1762443810407.jpeg', '6 pieces vegetable spring rolls with sweet chili sauce', 0, NULL, NULL),
(9, 'Mango shake', 4, 180.00, '/uploads\\image-1762444176596.jpg', 'Refreshing mango juice', 0, NULL, NULL),
(10, 'Lemon juice', 4, 180.00, '/uploads\\image-1762444258424.jpg', 'Refreshing lemon juice', 0, NULL, NULL),
(11, 'Watermelon Juice', 4, 170.00, '/uploads\\image-1762444340048.jpg', 'Fresh watermelon juice with mint', 0, NULL, NULL),
(12, 'Bubble Tea', 4, 195.00, '/uploads\\image-1762444399414.jpg', 'Milk tea with tapioca pearls', 1, 15, '2025-11-14'),
(13, 'Cappuccino', 4, 185.00, '/uploads\\image-1762444462113.jpeg', 'Espresso with steamed milk and foam', 0, NULL, NULL),
(14, 'Hot chocolate', 4, 190.00, '/uploads\\image-1762444509441.jpeg', 'Rich chocolate drink topped with marshmallows', 1, 50, '2025-11-14'),
(15, 'Chocolate Milkshake', 4, 196.00, '/uploads\\image-1762444576990.jpeg', 'Thick chocolate milkshake with whipped cream', 0, NULL, NULL),
(16, 'Grilled Salmon Steak', 2, 723.00, '/uploads\\image-1762444668183.jpeg', 'Fresh Atlantic salmon with herb butter and seasonal vegetables', 0, NULL, NULL),
(17, 'Wagyu Beef Burger', 2, 550.00, '/uploads\\image-1762444730701.jpg', 'Premium wagyu patty with caramelized onions and truffle aioli', 0, NULL, NULL),
(18, 'Pork Cordon Bleu', 2, 620.00, '/uploads\\image-1762444932219.jpg', 'Breaded Pork stuffed with ham and cheese', 0, NULL, NULL),
(19, 'Truffle Pasta', 2, 345.00, '/uploads\\image-1762445028588.jpg', 'Homemade pasta with black truffle and wild mushrooms', 0, NULL, NULL),
(20, 'Seafood Paella', 2, 749.00, '/uploads\\image-1762445105671.jpg', 'panish rice with assorted seafood and saffron', 1, 50, '2025-11-14'),
(21, 'Mango Cheesecake', 3, 280.00, '/uploads\\image-1762445289118.jpg', 'Creamy cheesecake with fresh mango compote', 0, NULL, NULL),
(22, 'Chocolate Lava Cake', 3, 180.00, '/uploads\\image-1762445355610.png', 'Warm chocolate cake with molten center and vanilla ice cream', 0, NULL, NULL),
(23, 'Tiramisu', 3, 130.00, '/uploads\\image-1762445416324.jpeg', 'Italian coffee-flavored dessert with mascarpone', 0, NULL, NULL),
(24, 'French Macarons', 3, 380.00, '/uploads\\image-1762445489084.jpg', 'Assorted flavors of delicate French macarons (6 pieces)', 0, NULL, NULL),
(25, 'Lemon Tart', 3, 285.00, '/uploads\\image-1762445537036.jpeg', 'Tangy lemon curd in a buttery pastry shell', 0, NULL, NULL),
(26, 'Chicken nuggets', 5, 247.00, '/uploads\\image-1762445654119.jpeg', 'Golden crispy chicken nuggets with fries', 1, 50, '2025-11-14'),
(27, 'French Fries', 5, 138.00, '/uploads\\image-1762445717744.jpg', 'Crispy golden french fries', 0, NULL, NULL),
(28, 'Mini Sliders', 5, 236.00, '/uploads\\image-1762445774757.jpeg', 'Three mini beef sliders with cheese', 0, NULL, NULL),
(29, 'Fluffy Pancakes', 5, 125.00, '/uploads\\image-1762445850625.jpeg', 'Three fluffy pancakes with syrup and butter', 1, 50, '2025-11-14'),
(32, 'batman', 5, 111.00, '', '', 1, 100, '2025-11-16');

-- --------------------------------------------------------

--
-- Table structure for table `fb_menu_item_ingredients`
--

CREATE TABLE `fb_menu_item_ingredients` (
  `recipe_id` int NOT NULL,
  `menu_item_id` int NOT NULL,
  `ingredient_id` int NOT NULL,
  `quantity_consumed` decimal(10,2) NOT NULL COMMENT 'Amount of ingredient used per 1 menu item'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fb_menu_item_ingredients`
--

INSERT INTO `fb_menu_item_ingredients` (`recipe_id`, `menu_item_id`, `ingredient_id`, `quantity_consumed`) VALUES
(10, 4, 2, 1.00),
(11, 4, 7, 1.00),
(12, 4, 1, 23.00),
(13, 5, 9, 1.00),
(14, 5, 10, 1.00),
(15, 5, 6, 1.00),
(16, 5, 7, 1.00),
(17, 5, 4, 1.00),
(21, 7, 4, 8.00),
(22, 7, 3, 4.00),
(23, 8, 6, 6.00),
(24, 8, 7, 6.00),
(25, 9, 11, 2.00),
(26, 10, 11, 2.00),
(27, 11, 11, 2.00),
(29, 13, 11, 2.00),
(31, 15, 11, 1.00),
(32, 16, 8, 6.00),
(33, 17, 1, 3.00),
(34, 17, 2, 2.00),
(35, 18, 5, 6.00),
(36, 18, 3, 4.00),
(37, 19, 1, 3.00),
(38, 19, 10, 4.00),
(39, 19, 9, 2.00),
(44, 21, 11, 4.00),
(45, 21, 2, 2.00),
(46, 22, 2, 4.00),
(47, 23, 2, 2.00),
(48, 24, 2, 6.00),
(49, 25, 11, 3.00),
(50, 25, 3, 3.00),
(51, 25, 2, 2.00),
(54, 27, 2, 6.00),
(55, 28, 5, 4.00),
(56, 28, 2, 4.00),
(57, 28, 7, 5.00),
(64, 2, 1, 100.00),
(65, 2, 2, 1.00),
(66, 2, 3, 50.00),
(67, 6, 8, 4.00),
(72, 1, 1, 33.00),
(73, 12, 11, 2.00),
(74, 20, 8, 5.00),
(75, 20, 10, 4.00),
(76, 20, 9, 2.00),
(77, 20, 6, 4.00),
(78, 29, 2, 7.00),
(79, 26, 4, 5.00),
(80, 26, 7, 5.00),
(81, 14, 11, 2.00),
(84, 32, 8, 12.00),
(85, 32, 1, 1.00);

-- --------------------------------------------------------

--
-- Table structure for table `fb_notifications`
--

CREATE TABLE `fb_notifications` (
  `notification_id` int NOT NULL,
  `client_id` int DEFAULT NULL,
  `order_id` int DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `message` text COLLATE utf8mb4_general_ci NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fb_orders`
--

CREATE TABLE `fb_orders` (
  `order_id` int NOT NULL,
  `client_id` int DEFAULT NULL,
  `employee_id` int DEFAULT NULL,
  `items_total` decimal(10,2) DEFAULT '0.00',
  `service_charge_amount` decimal(10,2) DEFAULT '0.00',
  `vat_amount` decimal(10,2) DEFAULT '0.00',
  `status` enum('pending','preparing','ready','served','cancelled') COLLATE utf8mb4_general_ci DEFAULT 'pending',
  `total_amount` decimal(10,2) DEFAULT NULL,
  `order_type` varchar(50) COLLATE utf8mb4_general_ci DEFAULT 'Dine-in',
  `delivery_location` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `order_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fb_orders`
--

INSERT INTO `fb_orders` (`order_id`, `client_id`, `employee_id`, `items_total`, `service_charge_amount`, `vat_amount`, `status`, `total_amount`, `order_type`, `delivery_location`, `order_date`) VALUES
(1, 1, 3, 789.00, 78.90, 104.15, 'served', 972.05, 'Dine-in', '2', '2025-11-13 05:12:32'),
(2, 1, 3, 789.00, 78.90, 104.15, 'served', 972.05, 'Dine-in', '2', '2025-11-13 05:14:48'),
(3, 1, 3, 220.00, 22.00, 29.04, 'served', 271.04, 'Dine-in', '2', '2025-11-13 06:11:58'),
(4, 1, 3, 350.00, 35.00, 46.20, 'cancelled', 431.20, 'Dine-in', '2', '2025-11-13 06:25:22'),
(6, 12, 3, 920.00, 92.00, 121.44, 'served', 1133.44, 'Room Dining', '201', '2025-11-13 13:42:35'),
(7, NULL, 3, 600.00, 60.00, 79.20, 'served', 739.20, 'Walk-in', 'Hezel', '2025-11-14 10:50:47'),
(8, 12, 3, 740.00, 74.00, 97.68, 'served', 911.68, 'Dine-in', '69', '2025-11-14 11:07:54'),
(9, 12, 3, 1010.00, 101.00, 133.32, 'served', 1244.32, 'Dine-in', '69', '2025-11-14 11:41:13'),
(10, 12, 3, 380.00, 38.00, 50.16, 'served', 468.16, 'Dine-in', '76', '2025-11-14 11:45:31'),
(11, 12, 3, 582.00, 58.20, 76.82, 'served', 717.02, 'Dine-in', '65', '2025-11-14 13:31:06'),
(12, 12, 3, 749.00, 74.90, 98.87, 'cancelled', 922.77, 'Dine-in', '70', '2025-11-14 13:41:03'),
(13, 12, 3, 790.00, 79.00, 104.28, 'served', 973.28, 'Dine-in', '69', '2025-11-14 13:51:35'),
(14, NULL, 3, 790.00, 79.00, 104.28, 'served', 973.28, 'Walk-in', 'John', '2025-11-14 13:55:23'),
(15, 12, NULL, 749.00, 74.90, 98.87, 'pending', 922.77, 'Dine-in', '1', '2025-11-14 14:05:14'),
(16, 12, NULL, 749.00, 74.90, 98.87, 'pending', 922.77, 'Dine-in', '2', '2025-11-14 14:11:24'),
(17, 12, NULL, 125.00, 12.50, 16.50, 'pending', 154.00, 'Dine-in', '3', '2025-11-14 14:13:46'),
(18, 12, NULL, 62.50, 6.25, 8.25, 'pending', 77.00, 'Dine-in', '4', '2025-11-14 14:20:13'),
(19, NULL, 3, 62.50, 6.25, 8.25, 'served', 77.00, 'Walk-in', 'Wena', '2025-11-14 14:30:46'),
(20, NULL, 3, 220.00, 22.00, 29.04, 'pending', 271.04, 'Walk-in', 'Counter', '2025-11-14 14:33:22'),
(21, NULL, 3, 62.50, 6.25, 8.25, 'pending', 77.00, 'Walk-in', 'Counter', '2025-11-14 14:35:19'),
(22, 12, NULL, 62.50, 6.25, 8.25, 'pending', 77.00, 'Dine-in', '6', '2025-11-14 14:37:02'),
(23, 12, NULL, 62.50, 6.25, 8.25, 'pending', 77.00, 'Dine-in', '7', '2025-11-14 14:37:56'),
(24, 12, NULL, 400.00, 40.00, 52.80, 'pending', 492.80, 'Dine-in', '8', '2025-11-14 14:49:59'),
(25, NULL, 3, 62.50, 6.25, 8.25, 'pending', 77.00, 'Walk-in', 'Counter', '2025-11-14 14:54:52'),
(26, 12, NULL, 711.00, 71.10, 93.85, 'pending', 875.95, 'Dine-in', '69', '2025-11-14 16:05:11'),
(27, 12, NULL, 138.00, 13.80, 18.22, 'pending', 170.02, 'Room Dining', '69', '2025-11-15 00:53:59'),
(28, NULL, 3, 711.00, 71.10, 93.85, 'pending', 875.95, 'Walk-in', 'Hezel', '2025-11-15 00:57:05'),
(29, NULL, 3, 360.00, 36.00, 47.52, 'pending', 443.52, 'Walk-in', 'Hezel', '2025-11-15 01:28:52'),
(30, 12, 3, 711.00, 71.10, 93.85, 'served', 875.95, 'Dine-in', '2', '2025-11-15 01:40:30'),
(31, NULL, 3, 711.00, 71.10, 93.85, 'served', 875.95, 'Walk-in', 'Lord', '2025-11-15 01:44:56'),
(32, NULL, 3, 360.00, 36.00, 47.52, 'served', 443.52, 'Phone Order', 'Pick-up on 3AM', '2025-11-15 01:45:53'),
(33, 12, NULL, 931.00, 93.10, 122.89, 'pending', 1146.99, 'Dine-in', '101', '2025-11-15 01:50:16'),
(34, 12, 3, 180.00, 18.00, 23.76, 'served', 221.76, 'Dine-in', '2', '2025-11-15 02:14:35'),
(35, 12, 3, 380.00, 38.00, 50.16, 'served', 468.16, 'Dine-in', '9', '2025-11-15 02:15:02'),
(36, 12, 3, 220.00, 22.00, 29.04, 'served', 271.04, 'Dine-in', '1', '2025-11-15 02:43:11'),
(37, 12, 3, 380.00, 38.00, 50.16, 'served', 468.16, 'Dine-in', '6', '2025-11-15 03:35:24'),
(38, NULL, 3, 180.00, 18.00, 23.76, 'served', 221.76, 'Walk-in', 'Counter', '2025-11-15 07:12:14'),
(39, 12, 3, 360.00, 36.00, 47.52, 'served', 443.52, 'Dine-in', '69', '2025-11-15 07:14:08'),
(40, 1, NULL, 3501.00, 350.10, 462.13, 'pending', 4313.23, 'Dine-in', '1', '2025-11-15 07:42:08'),
(41, 1, 3, 2032.00, 203.20, 268.22, 'served', 2503.42, 'Dine-in', 'lamesa ni batman', '2025-11-15 07:49:14'),
(42, 1, 3, 55475.00, 5547.50, 7322.70, 'served', 68345.20, 'Dine-in', '1', '2025-11-15 07:54:22'),
(43, NULL, 3, 711.00, 71.10, 93.85, 'pending', 875.95, 'Walk-in', 'Counter', '2025-11-15 08:30:24'),
(44, NULL, 3, 931.00, 93.10, 122.89, 'pending', 1146.99, 'Walk-in', 'Counter', '2025-11-15 08:31:31'),
(45, 1, NULL, 0.00, 0.00, 0.00, 'pending', 0.00, 'Dine-in', '1', '2025-11-15 08:46:29'),
(46, 1, NULL, 0.00, 0.00, 0.00, 'pending', 0.00, 'Dine-in', '1', '2025-11-15 08:48:10');

-- --------------------------------------------------------

--
-- Table structure for table `fb_order_details`
--

CREATE TABLE `fb_order_details` (
  `order_detail_id` int NOT NULL,
  `order_id` int DEFAULT NULL,
  `item_id` int DEFAULT NULL,
  `quantity` int NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `instructions` text COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fb_order_details`
--

INSERT INTO `fb_order_details` (`order_detail_id`, `order_id`, `item_id`, `quantity`, `subtotal`, `instructions`) VALUES
(1, 1, 1, 1, 789.00, ''),
(2, 2, 1, 1, 789.00, ''),
(3, 3, 2, 1, 220.00, ''),
(4, 4, 4, 1, 350.00, ''),
(5, 6, 2, 1, 220.00, ''),
(6, 6, 4, 2, 700.00, ''),
(7, 7, 2, 1, 220.00, ''),
(8, 7, 5, 1, 380.00, ''),
(9, 8, 6, 1, 380.00, ''),
(10, 8, 7, 1, 360.00, ''),
(11, 9, 2, 1, 220.00, ''),
(12, 9, 1, 1, 790.00, ''),
(13, 10, 12, 1, 195.00, ''),
(14, 10, 13, 1, 185.00, ''),
(15, 11, 14, 1, 190.00, ''),
(16, 11, 15, 2, 392.00, ''),
(17, 12, 20, 1, 749.00, 'test'),
(18, 13, 1, 1, 790.00, ''),
(19, 14, 1, 1, 790.00, ''),
(20, 15, 20, 1, 749.00, 'test1'),
(21, 16, 20, 1, 749.00, 'test2'),
(22, 17, 29, 1, 125.00, 'test3'),
(23, 18, 29, 1, 62.50, 'test4'),
(24, NULL, 29, 1, 62.50, 'test5'),
(25, 19, 29, 1, 125.00, 'test5'),
(26, NULL, 2, 1, 220.00, ''),
(27, 20, 2, 1, 220.00, ''),
(28, NULL, 29, 1, 62.50, ''),
(29, 21, 29, 1, 125.00, ''),
(30, 22, 29, 1, 62.50, 'test6'),
(31, 23, 29, 1, 62.50, 'test7'),
(32, 24, 9, 1, 180.00, 'test8'),
(33, 24, 2, 1, 220.00, 'test8'),
(34, NULL, 29, 1, 62.50, ''),
(35, 25, 29, 1, 125.00, ''),
(36, 26, 1, 1, 711.00, ''),
(37, 27, 27, 1, 138.00, 'TEST'),
(38, NULL, 1, 1, 711.00, ''),
(39, 28, 1, 1, 790.00, ''),
(40, 29, 7, 1, 360.00, ''),
(41, 30, 1, 1, 711.00, ''),
(42, 31, 1, 1, 711.00, ''),
(43, 32, 7, 1, 360.00, 'not extra spicy'),
(44, 33, 1, 1, 711.00, 'TEST'),
(45, 33, 2, 1, 220.00, 'TEST'),
(46, 34, 10, 1, 180.00, ''),
(47, 35, 6, 1, 380.00, ''),
(48, 36, 2, 1, 220.00, ''),
(49, 37, 6, 1, 380.00, ''),
(50, 38, 9, 1, 180.00, ''),
(51, 39, 7, 1, 360.00, ''),
(52, 40, 1, 3, 2133.00, ''),
(53, 40, 17, 1, 550.00, ''),
(54, 40, 10, 1, 180.00, ''),
(55, 40, 27, 1, 138.00, ''),
(56, 40, 2, 1, 220.00, ''),
(57, 40, 21, 1, 280.00, ''),
(58, 41, 1, 2, 1422.00, 'walang mais'),
(59, 41, 2, 2, 440.00, 'walang mais'),
(60, 41, 11, 1, 170.00, 'walang mais'),
(61, 42, 22, 1, 180.00, ''),
(62, 42, 29, 1, 125.00, ''),
(63, 42, 11, 1, 170.00, ''),
(64, 42, 17, 100, 55000.00, ''),
(65, 43, 1, 1, 711.00, ''),
(66, 44, 2, 1, 220.00, ''),
(67, 44, 1, 1, 711.00, ''),
(68, 45, 32, 1, 0.00, ''),
(69, 46, 32, 4, 0.00, '');

-- --------------------------------------------------------

--
-- Table structure for table `fb_payments`
--

CREATE TABLE `fb_payments` (
  `payment_id` int NOT NULL,
  `order_id` int DEFAULT NULL,
  `payment_method` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `payment_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `change_amount` decimal(10,2) DEFAULT '0.00',
  `payment_status` varchar(50) COLLATE utf8mb4_general_ci DEFAULT 'paid'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fb_payments`
--

INSERT INTO `fb_payments` (`payment_id`, `order_id`, `payment_method`, `amount`, `payment_date`, `change_amount`, `payment_status`) VALUES
(1, 7, 'Cash', 800.00, '2025-11-14 10:50:49', 60.80, 'paid'),
(2, 14, 'Cash', 900.00, '2025-11-14 13:55:23', 24.05, 'paid'),
(3, 19, 'Cash', 100.00, '2025-11-14 14:30:47', 23.00, 'paid'),
(4, 20, 'Cash', 300.00, '2025-11-14 14:33:23', 28.96, 'paid'),
(5, 21, 'Cash', 80.00, '2025-11-14 14:35:20', 3.00, 'paid'),
(6, 25, 'Cash', 77.00, '2025-11-14 14:54:52', 23.00, 'paid'),
(7, 28, 'Cash', 875.95, '2025-11-15 00:57:06', 24.05, 'paid'),
(8, 29, 'Cash', 443.52, '2025-11-15 01:28:52', 56.48, 'paid'),
(9, 31, 'Cash', 875.95, '2025-11-15 01:44:56', 24.05, 'paid'),
(10, 32, 'Cash', 443.52, '2025-11-15 01:45:53', 56.48, 'paid'),
(11, 38, 'Cash', 221.76, '2025-11-15 07:12:15', 78.24, 'paid'),
(12, 43, 'Cash', 875.95, '2025-11-15 08:30:25', 235.05, 'paid'),
(13, 44, 'Cash', 1146.99, '2025-11-15 08:31:33', 0.01, 'paid');

-- --------------------------------------------------------

--
-- Table structure for table `hotel_settings`
--

CREATE TABLE `hotel_settings` (
  `setting_id` int NOT NULL,
  `hotel_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'My Hotel',
  `registration_number` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `phone_number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `website` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hotel_settings`
--

INSERT INTO `hotel_settings` (`setting_id`, `hotel_name`, `registration_number`, `address`, `phone_number`, `email`, `website`, `logo_url`, `created_at`, `updated_at`) VALUES
(1, 'Celestia Hotel', 'REG-2024-001', '123 Main Street, City', '+1234567890', 'celestiaquezon@gmail.com', 'https://celestiaquezon.com', NULL, '2025-11-10 17:28:08.093236', '2025-11-10 17:28:08.093236');

-- --------------------------------------------------------

--
-- Table structure for table `invoice`
--

CREATE TABLE `invoice` (
  `invoice_id` int NOT NULL,
  `invoice_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `guest_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `room_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `check_in_date` date NOT NULL,
  `check_out_date` date NOT NULL,
  `email_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subtotal` decimal(12,2) DEFAULT '0.00',
  `tax_rate` decimal(5,2) DEFAULT '10.00',
  `tax_amount` decimal(12,2) DEFAULT '0.00',
  `total_amount` decimal(12,2) DEFAULT '0.00',
  `paid_amount` decimal(12,2) DEFAULT '0.00',
  `pending_amount` decimal(12,2) DEFAULT '0.00',
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Pending',
  `payment_method` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `invoice`
--

INSERT INTO `invoice` (`invoice_id`, `invoice_number`, `guest_name`, `room_number`, `check_in_date`, `check_out_date`, `email_address`, `phone_number`, `subtotal`, `tax_rate`, `tax_amount`, `total_amount`, `paid_amount`, `pending_amount`, `status`, `payment_method`, `notes`, `created_by`, `created_at`, `updated_at`) VALUES
(2, 'INV-202510-0001', 'John Doe', '305', '2025-01-27', '2025-01-30', 'john@example.com', '+1234567890', 450.00, 10.00, 45.00, 495.00, 0.00, 495.00, 'Pending', 'Credit Card', 'VIP guest', 3, '2025-10-28 11:56:55', '2025-10-29 00:18:41'),
(4, 'INV-202510-0002', 'John Doe', '305', '2025-01-27', '2025-01-30', 'john@example.com', '+1234567890', 0.00, 10.00, 0.00, 0.00, 0.00, 0.00, 'Pending', 'Credit Card', 'VIP guest', 3, '2025-10-28 11:58:29', '2025-10-28 11:58:29'),
(5, 'INV-202510-0003', 'John Anonuevo handsome', '305', '2025-01-27', '2025-01-30', 'johnandrewpogie@example.com', '+1234567890', 0.00, 10.00, 0.00, 0.00, 0.00, 0.00, 'Pending', 'Credit Card', 'VIP guest', 3, '2025-10-28 11:58:49', '2025-10-28 11:58:49'),
(6, 'INV-202510-0004', 'Stuart Mill', '302', '2025-01-27', '2025-01-30', 'john@example.com', '+1234567890', 0.00, 10.00, 0.00, 0.00, 0.00, 0.00, 'Pending', 'Credit Card', 'VIP guest', 3, '2025-10-28 12:16:58', '2025-10-28 12:16:58'),
(7, 'INV-202510-0005', 'Nat Kun', '3142', '2025-01-27', '2025-01-30', 'nathanbatallones@gmail.com', '+3720382710', 0.00, 10.00, 0.00, 0.00, 0.00, 0.00, 'Pending', 'Credit Card', 'VIP guest handsome', 3, '2025-10-29 00:12:54', '2025-10-29 00:12:54'),
(8, 'INV-202510-0006', 'Alice Johnson', '101', '2025-02-01', '2025-02-05', 'alice@example.com', '+1111111111', 1650.00, 10.00, 165.00, 1815.00, 800.00, 1015.00, 'Partially Paid', 'Credit Card', 'Business traveler', 3, '2025-10-29 00:20:15', '2025-10-29 00:26:08'),
(9, 'INV-202510-0007', 'Bob Smith', '202', '2025-02-03', '2025-02-07', 'bob@example.com', '+2222222222', 0.00, 10.00, 0.00, 0.00, 0.00, 0.00, 'Pending', 'Cash', 'Family vacation', 3, '2025-10-29 00:20:24', '2025-10-29 00:22:28'),
(10, 'INV-202510-0008', 'Carol White', '303', '2025-02-10', '2025-02-15', 'carol@example.com', '+3333333333', 0.00, 10.00, 0.00, 0.00, 0.00, 0.00, 'Pending', 'Credit Card', 'Anniversary celebration', 3, '2025-10-29 00:20:32', '2025-10-29 00:20:32'),
(11, 'INV-202511-0009', 'Yadayad', '223', '2025-11-07', '2025-11-21', 'roan20252@gmail.com', '131313213', 0.00, 10.00, 0.00, 0.00, 0.00, 0.00, 'Pending', '', '', 3, '2025-11-06 02:09:31', '2025-11-06 02:09:31'),
(12, 'INV-202511-0010', '213321', '321123', '2025-11-06', '2025-11-11', 'roan20252@gmail.com', '0999999', 0.00, 10.00, 0.00, 0.00, 0.00, 0.00, 'Pending', '', '', 3, '2025-11-06 02:28:58', '2025-11-06 02:28:58'),
(13, 'INV-202511-0011', '13213321', '13131', '2025-11-06', '2025-11-12', 'roan20252@gmail.com', '1312', 0.00, 10.00, 0.00, 0.00, 0.00, 0.00, 'Pending', '', '', 3, '2025-11-06 02:31:52', '2025-11-06 02:31:52'),
(14, 'INV-202511-0012', '213213', '321213', '2025-11-06', '2025-11-07', 'roan20252@gmail.com', '321321', 0.00, 10.00, 0.00, 0.00, 0.00, 0.00, 'Pending', '', '', 3, '2025-11-06 02:34:06', '2025-11-06 02:34:06'),
(15, 'INV-202511-0013', '13231', '123', '2025-11-06', '2025-11-07', 'roan20252@gmail.com', '1321321', 0.00, 10.00, 0.00, 0.00, 0.00, 0.00, 'Pending', '', '', 3, '2025-11-06 02:49:33', '2025-11-06 02:49:33'),
(16, 'INV-202511-0014', 'qeqwqw', '123123', '2025-11-07', '2025-11-07', 'roan20252@gmail.com', '131231323', 0.00, 10.00, 0.00, 0.00, 0.00, 0.00, 'Pending', '', '', 3, '2025-11-06 02:55:11', '2025-11-06 02:55:11'),
(18, 'INV-202511-0015', 'John Doe', '101', '2025-11-06', '2025-11-08', 'john.doe@example.com', '+1234567890', 0.00, 10.00, 0.00, 0.00, 0.00, 0.00, 'Pending', 'Credit Card', 'Guest requested late checkout', 3, '2025-11-06 03:10:31', '2025-11-06 03:10:31'),
(19, 'INV-202511-0016', 'John Doe', '101', '2025-11-06', '2025-11-08', 'john.doe@example.com', '+1234567890', 0.00, 10.00, 0.00, 0.00, 0.00, 0.00, 'Pending', 'Credit Card', 'Guest requested late checkout', 3, '2025-11-06 03:14:45', '2025-11-06 03:14:45'),
(317, 'INV-202511-0017', 'Johnny Bravo', '555', '2025-11-15', '2025-11-18', 'johnnybravo@gmail.com', '+63729103213', 0.00, 10.00, 0.00, 0.00, 0.00, 0.00, 'Pending', 'Cash', '', 3, '2025-11-14 03:20:47', '2025-11-14 03:20:47'),
(318, 'INV-202511-0018', 'Johnny Bravo', '531', '2025-11-15', '2025-11-11', 'johnnybravo@gmail.com', '+639994442179', 0.00, 10.00, 0.00, 0.00, 0.00, 0.00, 'Pending', 'Credit Card', 'Handsome Man', 3, '2025-11-14 03:35:35', '2025-11-14 03:35:35'),
(319, 'INV-202511-0019', 'Johnny Bravo', '531', '2025-11-15', '2025-11-11', 'johnnybravo@gmail.com', '+639994442179', 0.00, 10.00, 0.00, 0.00, 0.00, 0.00, 'Pending', 'Credit Card', 'Handsome Man', 3, '2025-11-14 03:36:57', '2025-11-14 03:36:57'),
(332, 'INV-202511-0020', 'gelo m kambe', 'RES-1', '2025-10-25', '2025-10-27', 'cambe.angelos@gmail.com', '09984663089', 200.00, 10.00, 20.00, 220.00, 7000.00, -6780.00, 'Paid', 'Credit Card', 'Need extra pillows and late checkout', NULL, '2025-11-14 05:17:59', '2025-11-15 00:05:42'),
(333, 'INV-202511-0021', 'gelo m kambe', 'RES-1', '2025-10-25', '2025-10-27', 'cambe.angelos@gmail.com', '09984663089', 200.00, 10.00, 20.00, 220.00, 7000.00, -6780.00, 'Paid', 'Credit Card', 'Need extra pillows and late checkout', NULL, '2025-11-14 05:18:00', '2025-11-14 05:18:01'),
(335, 'INV-202511-0022', 'cambe cambe cambe', 'RES-2', '2025-11-20', '2025-11-22', 'cambe.angelo.12162003@gmail.com', '0998785', 400.00, 10.00, 40.00, 440.00, 5000.00, -4560.00, 'Paid', 'Credit Card', 'Reservation for 3 adults, 2 children. Rooms: 101, 102', NULL, '2025-11-14 05:18:00', '2025-11-22 18:00:04'),
(336, 'INV-202511-0023', 'AllenJohn', '331', '2025-11-15', '2025-11-16', 'allenjohn@gmail.com', '+63291273123', 0.00, 10.00, 0.00, 0.00, 0.00, 0.00, 'Pending', '', '', 3, '2025-11-14 05:21:52', '2025-11-14 05:21:52'),
(337, 'INV-202511-0024', 'TESTINVOICE', '696', '2025-11-14', '2025-11-16', 'testinvoice@gmail.com', '+6369696969696', 0.00, 10.00, 0.00, 0.00, 0.00, 0.00, 'Pending', 'Credit Card', 'BDO', 3, '2025-11-14 06:41:04', '2025-11-14 06:41:04'),
(338, 'INV-202511-0025', 'Maak', '21', '2025-11-14', '2025-11-20', 'roan20252@gmail.com', '099988333', 0.00, 10.00, 0.00, 0.00, 0.00, 0.00, 'Pending', 'Cash', '', 3, '2025-11-14 07:03:02', '2025-11-14 07:03:02'),
(339, 'INV-202511-0026', 'Maak', '21', '2025-11-14', '2025-11-20', 'roan20252@gmail.com', '099988333', 2000.00, 10.00, 200.00, 2200.00, 0.00, 2200.00, 'Pending', 'Digital Wallet', '', 3, '2025-11-14 07:04:52', '2025-11-14 07:04:53'),
(340, 'INV-202511-0027', 'John Mark ALlen', '783', '2025-11-15', '2025-11-16', 'johnmarkallen@gmail.com', '+63827391231', 23000.00, 10.00, 2300.00, 25300.00, 0.00, 25300.00, 'Pending', 'Credit Card', 'TEST ROOM QUICK ACTION', 3, '2025-11-15 03:50:26', '2025-11-15 03:50:27');

-- --------------------------------------------------------

--
-- Table structure for table `invoice_activity`
--

CREATE TABLE `invoice_activity` (
  `activity_id` int NOT NULL,
  `invoice_id` int NOT NULL,
  `activity_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `performed_by` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `invoice_item`
--

CREATE TABLE `invoice_item` (
  `item_id` int NOT NULL,
  `invoice_id` int NOT NULL,
  `item_description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int DEFAULT '1',
  `unit_price` decimal(12,2) DEFAULT '0.00',
  `total_price` decimal(12,2) DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `revenue_category_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `invoice_item`
--

INSERT INTO `invoice_item` (`item_id`, `invoice_id`, `item_description`, `quantity`, `unit_price`, `total_price`, `created_at`, `revenue_category_id`) VALUES
(1, 2, 'Deluxe Room - 3 nights', 3, 150.00, 450.00, '2025-10-29 00:18:41', NULL),
(2, 8, 'Standard Room - 4 nights', 4, 120.00, 480.00, '2025-10-29 00:21:22', NULL),
(3, 8, 'Airport Transfer', 2, 35.00, 70.00, '2025-10-29 00:21:33', NULL),
(4, 8, 'Business Center Access', 1, 50.00, 50.00, '2025-10-29 00:21:38', NULL),
(5, 8, 'Family Suite - 4 nights', 4, 200.00, 800.00, '2025-10-29 00:21:42', NULL),
(6, 8, 'Kids Activities Package', 2, 75.00, 150.00, '2025-10-29 00:21:46', NULL),
(7, 8, 'Pool Access', 4, 25.00, 100.00, '2025-10-29 00:21:51', NULL),
(8, 317, 'Luxary Deluxe', 1, 24000.00, 24000.00, '2025-11-14 03:20:47', NULL),
(9, 318, 'Luxary Test', 2, 2300.00, 4600.00, '2025-11-14 03:35:36', NULL),
(10, 319, 'Luxary Test', 2, 2300.00, 4600.00, '2025-11-14 03:36:58', NULL),
(11, 332, 'Charlotte - Room (Room 101) - 2 night(s)', 2, 100.00, 200.00, '2025-11-14 05:18:00', NULL),
(12, 333, 'Charlotte - Room (Room 101) - 2 night(s)', 2, 100.00, 200.00, '2025-11-14 05:18:00', NULL),
(13, 335, 'Charlotte - Room (Room 101) - 2 night(s)', 2, 100.00, 200.00, '2025-11-14 05:18:00', NULL),
(14, 335, 'bahay kubo - Room (Room 102) - 2 night(s)', 2, 100.00, 200.00, '2025-11-14 05:18:01', NULL),
(15, 336, 'Luxary Deluxe', 1, 2300.00, 2300.00, '2025-11-14 05:21:53', NULL),
(16, 337, 'Luxary Room', 1, 6000.00, 6000.00, '2025-11-14 06:41:04', NULL),
(17, 338, 'qiqiiq', 1, 2000.00, 2000.00, '2025-11-14 07:03:03', NULL),
(18, 339, 'qiqiiq', 1, 2000.00, 2000.00, '2025-11-14 07:04:52', NULL),
(19, 340, 'Test Room', 1, 23000.00, 23000.00, '2025-11-15 03:50:26', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `job_positions`
--

CREATE TABLE `job_positions` (
  `position_id` int NOT NULL,
  `position_name` varchar(100) NOT NULL,
  `position_code` varchar(10) DEFAULT NULL,
  `position_desc` varchar(255) DEFAULT NULL,
  `department_id` int NOT NULL,
  `salary` decimal(10,2) DEFAULT NULL,
  `availability` int DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL
) ;

--
-- Dumping data for table `job_positions`
--

INSERT INTO `job_positions` (`position_id`, `position_name`, `position_code`, `position_desc`, `department_id`, `salary`, `availability`, `created_at`, `updated_at`, `created_by`, `updated_by`) VALUES
(1, 'HR Manager', 'POS-0001', 'Oversees HR operations and employee management', 1, 45000.00, 1, '2025-11-11 05:40:36', '2025-11-11 05:40:36', 1, NULL),
(2, 'HR Specialist', 'POS-0002', 'Handles recruitment and employee relations', 1, 35000.00, 1, '2025-11-11 05:40:36', '2025-11-11 05:40:36', 1, NULL),
(3, 'Recruiter', 'POS-0003', 'Sources and screens job candidates', 1, 32000.00, 1, '2025-11-11 05:40:36', '2025-11-11 05:40:36', 1, NULL),
(4, 'HR Assistant', 'POS-0004', 'Provides administrative support to HR department', 1, 28000.00, 1, '2025-11-11 05:40:36', '2025-11-11 05:40:36', 1, NULL),
(5, 'IT Manager', 'POS-0005', 'Oversees IT infrastructure and projects', 2, 55000.00, 1, '2025-11-11 05:40:36', '2025-11-11 05:40:36', 1, NULL),
(6, 'Software Developer', 'POS-0006', 'Develops and maintains software applications', 2, 45000.00, 1, '2025-11-11 05:40:36', '2025-11-11 05:40:36', 1, NULL),
(7, 'IT Support Specialist', 'POS-0007', 'Maintains hardware and software systems', 2, 38000.00, 1, '2025-11-11 05:40:36', '2025-11-11 05:40:36', 1, NULL),
(8, 'System Administrator', 'POS-0008', 'Manages servers and network infrastructure', 2, 42000.00, 1, '2025-11-11 05:40:36', '2025-11-11 05:40:36', 1, NULL),
(9, 'Front Desk Manager', 'POS-0009', 'Oversees front desk operations and staff', 3, 35000.00, 1, '2025-11-11 05:40:36', '2025-11-11 05:40:36', 1, NULL),
(10, 'Receptionist', 'POS-0010', 'Greets visitors and handles front desk duties', 3, 25000.00, 1, '2025-11-11 05:40:36', '2025-11-11 05:40:36', 1, NULL),
(11, 'Front Desk Associate', 'POS-0011', 'Assists with reception and administrative tasks', 3, 23000.00, 1, '2025-11-11 05:40:36', '2025-11-11 05:40:36', 1, NULL),
(12, 'Cashier', 'POS-0012', NULL, 4, NULL, 5, '2025-11-11 10:21:17', '2025-11-11 10:21:17', 1, NULL),
(13, 'Server', 'POS-0013', NULL, 4, NULL, 3, '2025-11-11 10:23:15', '2025-11-11 10:23:15', 1, NULL),
(14, 'Kitchen Staffs', 'POS-0014', NULL, 5, NULL, 1, '2025-11-11 10:25:12', '2025-11-11 10:25:12', 1, NULL),
(15, 'F&B Manager', 'POS-0015', NULL, 8, NULL, 1, '2025-11-11 10:39:19', '2025-11-11 10:44:31', 1, 1),
(16, 'Administrator', 'POS-0016', NULL, 6, NULL, 1, '2025-11-11 10:41:59', '2025-11-21 06:24:04', 1, 1),
(17, 'Housekeeping Manager', 'POS-0017', NULL, 11, NULL, 1, '2025-11-11 10:44:20', '2025-11-11 10:44:20', 1, NULL),
(18, 'Maintenance Manager', 'POS-0018', NULL, 9, NULL, 1, '2025-11-11 10:54:28', '2025-11-11 10:54:28', 1, NULL),
(19, 'Inventory Manager', 'POS-0019', NULL, 7, NULL, 1, '2025-11-11 10:58:35', '2025-11-11 10:58:35', 1, NULL),
(20, 'Parking Manager', 'POS-0020', NULL, 10, NULL, 1, '2025-11-11 11:07:48', '2025-11-11 11:07:48', 1, NULL),
(21, 'House Keeping Staff', 'POS-0021', NULL, 11, NULL, 1, '2025-11-11 11:08:48', '2025-11-11 11:08:54', 1, 1),
(22, 'Maintenance Staff', 'POS-0022', NULL, 9, NULL, 3, '2025-11-11 11:09:12', '2025-11-11 11:09:12', 1, NULL),
(23, 'Hotel Reservation Manager', 'POS-0023', NULL, 6, NULL, 1, '2025-11-11 11:10:24', '2025-11-11 11:10:24', 1, NULL),
(24, 'Hotel Manager', 'POS-0024', NULL, 6, NULL, 1, '2025-11-11 11:11:42', '2025-11-11 11:11:42', 1, NULL),
(25, 'Financial Manager', 'POS-0025', NULL, 8, NULL, 1, '2025-11-11 11:14:44', '2025-11-11 11:14:44', 1, NULL),
(26, 'Accountant', 'POS-0026', NULL, 12, NULL, 5, '2025-11-11 11:16:10', '2025-11-11 11:16:11', 1, NULL),
(27, 'Concierge', 'POS-0027', NULL, 4, NULL, 7, '2025-11-11 11:17:53', '2025-11-11 11:17:53', 1, NULL),
(28, 'CRM Manager', 'POS-0028', NULL, 13, NULL, 1, '2025-11-11 14:50:25', '2025-11-11 14:53:14', 1, 1),
(29, 'Waiter', 'POS-0029', NULL, 4, NULL, 5, '2025-11-14 01:30:40', '2025-11-14 06:30:19', 1, 3),
(30, 'Cashier', 'POS-0030', NULL, 5, NULL, 5, '2025-11-15 02:02:55', '2025-11-15 02:03:35', 1, 1),
(31, 'Stock Controller', 'POS-0031', NULL, 5, NULL, 5, '2025-11-15 02:03:25', '2025-11-15 02:03:25', 1, NULL),
(32, 'F&B Admin ', 'POS-0032', 'Administrator for F&B', 8, NULL, 1, '2025-11-25 03:44:48', '2025-11-25 03:52:49', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `leaves`
--

CREATE TABLE `leaves` (
  `leave_id` int NOT NULL,
  `leave_code` varchar(10) DEFAULT NULL,
  `employee_id` int NOT NULL,
  `leave_type` enum('vacation','sick','emergency','others') DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `status` enum('pending','approved','rejected','cancelled') DEFAULT 'pending',
  `remarks` text,
  `approved_by` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL
) ;

--
-- Dumping data for table `leaves`
--

INSERT INTO `leaves` (`leave_id`, `leave_code`, `employee_id`, `leave_type`, `start_date`, `end_date`, `status`, `remarks`, `approved_by`, `created_at`, `updated_at`, `created_by`, `updated_by`) VALUES
(2, 'LEV-0002', 12, 'sick', '2024-10-08', '2024-10-08', 'approved', 'Flu symptoms', 7, '2024-10-07 18:30:00', '2025-11-11 05:41:55', 12, NULL),
(5, 'LEV-0005', 4, 'emergency', '2024-10-25', '2024-10-25', 'approved', 'Family emergency', 7, '2024-10-24 08:00:00', '2025-11-11 05:41:55', 4, NULL),
(7, 'LEV-0007', 2, 'sick', '2024-11-12', '2024-11-13', 'pending', 'Scheduled medical procedure', NULL, '2024-10-30 15:00:00', '2025-11-11 05:41:55', 2, NULL),
(9, 'LEV-0009', 5, 'others', '2024-09-15', '2024-09-15', 'approved', 'Training seminar', 2, '2024-09-10 09:00:00', '2025-11-11 05:41:55', 5, NULL),
(10, 'LEV-0010', 7, 'vacation', '2024-12-23', '2024-12-27', 'pending', 'Christmas holiday', NULL, '2024-11-01 08:00:00', '2025-11-11 05:41:55', 7, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `manual_payment`
--

CREATE TABLE `manual_payment` (
  `payment_id` int NOT NULL,
  `invoice_id` int NOT NULL,
  `payment_method` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount_paid` decimal(12,2) NOT NULL,
  `payment_date` date NOT NULL,
  `reference_number` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `processed_by` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notification_settings`
--

CREATE TABLE `notification_settings` (
  `notification_id` int NOT NULL,
  `users_id` int NOT NULL,
  `daily_revenue_reports` tinyint NOT NULL DEFAULT '1',
  `expense_approvals` tinyint NOT NULL DEFAULT '1',
  `bill_payment_reminders` tinyint NOT NULL DEFAULT '1',
  `payroll_processing` tinyint NOT NULL DEFAULT '1',
  `budget_variance_alerts` tinyint NOT NULL DEFAULT '1',
  `system_updates` tinyint NOT NULL DEFAULT '1',
  `backup_alerts` tinyint NOT NULL DEFAULT '1',
  `security_alerts` tinyint NOT NULL DEFAULT '1',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notification_settings`
--

INSERT INTO `notification_settings` (`notification_id`, `users_id`, `daily_revenue_reports`, `expense_approvals`, `bill_payment_reminders`, `payroll_processing`, `budget_variance_alerts`, `system_updates`, `backup_alerts`, `security_alerts`, `created_at`, `updated_at`) VALUES
(1, 3, 1, 1, 1, 1, 1, 1, 1, 1, '2025-11-12 02:03:53.695026', '2025-11-12 02:03:53.695026'),
(2, 10, 1, 1, 1, 1, 1, 1, 1, 1, '2025-11-15 07:18:21.892358', '2025-11-15 07:18:21.892358');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_otps`
--

CREATE TABLE `password_reset_otps` (
  `otp_id` int NOT NULL,
  `user_id` int NOT NULL,
  `identifier` varchar(255) NOT NULL,
  `purpose` varchar(50) NOT NULL,
  `code_hash` varchar(255) NOT NULL,
  `delivery_channel` varchar(50) DEFAULT 'email',
  `expires_at` datetime NOT NULL,
  `consumed_at` datetime DEFAULT NULL,
  `attempts` int DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `password_reset_otps`
--

INSERT INTO `password_reset_otps` (`otp_id`, `user_id`, `identifier`, `purpose`, `code_hash`, `delivery_channel`, `expires_at`, `consumed_at`, `attempts`, `created_at`, `updated_at`) VALUES
(1, 3, 'matthenry1005200@gmail.com', 'password_reset', '$2b$10$9D7/Nc2IzZ2AjgyqtTSE2.VfHFVFpvLxI.nsrTBj8iKNuz36J2.TK', 'email', '2025-11-18 07:00:08', NULL, 0, '2025-11-18 06:55:06', '2025-11-18 06:55:06'),
(2, 3, 'matthenry1005200@gmail.com', 'password_reset', '$2b$10$hOOlNsglUpMhvuu0Gc8qZeiuzFgratXjbOVdCiu.9c18tAvcpsyi2', 'email', '2025-11-18 07:02:26', NULL, 0, '2025-11-18 06:57:24', '2025-11-18 06:57:24'),
(3, 3, 'matthenry1005200@gmail.com', 'password_reset', '$2b$10$qxgnRj1sXl.gvxX9SkH2XOU1bg8Dwm1c6SOuBOos8bryH25K7/iRy', 'email', '2025-11-18 09:39:42', NULL, 0, '2025-11-18 09:34:39', '2025-11-18 09:34:39'),
(4, 3, 'matthenry1005200@gmail.com', 'password_reset', '$2b$10$jnXxbDPBRABLrJgvEiIGeeUGK1IEEtubuuGtPZM0Tf/aAr1Nj8uee', 'email', '2025-11-18 09:44:35', NULL, 0, '2025-11-18 09:39:33', '2025-11-18 09:39:33'),
(5, 3, 'matthenry1005200@gmail.com', 'password_reset', '$2b$10$Q4yuR7AevXvWIF38u8wpJu3VNJXx6w.MYZEa/lIrKL7xMHLYk3eki', 'email', '2025-11-18 19:12:00', '2025-11-18 19:07:44', 1, '2025-11-18 11:06:57', '2025-11-18 11:07:41'),
(15, 47, 'christianix37@gmail.com', 'password_reset', '$2b$10$DcIwnLoc1c5a9XksZfOnXuqA3QZCeaAmhTAl/nIe86O6ozFmg6r6m', 'email', '2025-11-20 13:12:16', '2025-11-20 13:07:49', 1, '2025-11-20 05:07:15', '2025-11-20 05:07:48'),
(17, 56, 'bagayan.maintenancemanager@gmail.com', 'password_reset', '$2b$10$bP/T8iPj148G82Lt0/6rI.7ijDYAQN8joeKCP2DkTUZweNS4m77lO', 'email', '2025-11-23 19:06:51', NULL, 0, '2025-11-23 11:01:52', '2025-11-23 11:01:52'),
(18, 56, 'shockuy450@gmail.com', 'password_reset', '$2b$10$i8b1t70oH3gpNtWWTyY7.er2pHGOOJM1FTO0EKGCSLyJKompn3Sjy', 'email', '2025-11-23 19:11:03', '2025-11-23 19:06:48', 1, '2025-11-23 11:06:05', '2025-11-23 11:06:49');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `token_id` int NOT NULL,
  `user_id` int NOT NULL,
  `token_hash` varchar(255) NOT NULL,
  `expires_at` datetime NOT NULL,
  `consumed_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `password_reset_tokens`
--

INSERT INTO `password_reset_tokens` (`token_id`, `user_id`, `token_hash`, `expires_at`, `consumed_at`, `created_at`) VALUES
(1, 3, '$2b$10$iOsXcPDgswYGcAcB9msNVeiGPtZPW6X9ORR7XObMtKFr8QMfwHV6u', '2025-11-18 19:37:44', '2025-11-18 19:08:01', '2025-11-18 11:07:41'),
(4, 47, '$2b$10$39ZE7muOLE7n786rAoAn5emgjH9BG29NCU0z5LU2ZWSFNcQKXY2hO', '2025-11-20 13:37:49', '2025-11-20 13:08:04', '2025-11-20 05:07:48'),
(6, 56, '$2b$10$5rgyNFiiC0NCWaGtyjMBT.CloiIU9RQwy0A39VkJr.2k.lavQQIvG', '2025-11-23 19:36:48', '2025-11-23 19:08:28', '2025-11-23 11:06:49');

-- --------------------------------------------------------

--
-- Table structure for table `payroll_run`
--

CREATE TABLE `payroll_run` (
  `payroll_run_id` int NOT NULL,
  `payroll_start_date` date NOT NULL,
  `payroll_end_date` date NOT NULL,
  `status` enum('pending','processing','completed') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `period` enum('monthly','weekly','yearly') COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `payroll_slip`
--

CREATE TABLE `payroll_slip` (
  `payroll_id` int NOT NULL,
  `employee_id` int DEFAULT NULL,
  `payroll_run_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `company_deduction_id` int DEFAULT NULL,
  `total_company_deductions` decimal(10,2) NOT NULL DEFAULT '0.00',
  `base_salary` decimal(10,2) DEFAULT NULL,
  `overtime_hours` decimal(10,2) DEFAULT NULL,
  `overtime_pay` decimal(10,2) DEFAULT NULL,
  `gross_pay` decimal(12,2) DEFAULT NULL,
  `sss_deduction` decimal(10,2) DEFAULT NULL,
  `pagibig_deduction` decimal(10,2) DEFAULT NULL,
  `philhealth_deduction` decimal(10,2) DEFAULT NULL,
  `withholding_tax` decimal(10,2) DEFAULT NULL,
  `net_pay` decimal(12,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pms_housekeeping_logs`
--

CREATE TABLE `pms_housekeeping_logs` (
  `LogID` int NOT NULL,
  `TaskID` int DEFAULT NULL,
  `RoomID` int DEFAULT NULL,
  `UserID` int DEFAULT NULL COMMENT 'User who performed the action',
  `Action` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `Details` text COLLATE utf8mb4_general_ci,
  `Timestamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pms_housekeeping_logs`
--

INSERT INTO `pms_housekeeping_logs` (`LogID`, `TaskID`, `RoomID`, `UserID`, `Action`, `Details`, `Timestamp`) VALUES
(1, 1, 2, 34, 'ASSIGNED', 'Task assigned to staff s s (ID: 41) by manager (ID: 34). Tasks: Bed and Linen Care', '2025-11-13 07:48:09'),
(2, 1, 2, 34, 'CANCELLED', 'Task cancelled by manager (ID: 34).', '2025-11-13 07:48:43'),
(3, 2, 2, 34, 'ASSIGNED', 'Task assigned to staff s s (ID: 41) by manager (ID: 34). Tasks: General Cleaning, Bed and Linen Care, Bathroom Cleaning, Restocking Supplies, Trash Removal, Window & Curtains Care', '2025-11-13 08:11:36'),
(4, 2, 2, 34, 'CANCELLED', 'Task cancelled by manager (ID: 34).', '2025-11-13 08:12:39'),
(5, 3, 2, 34, 'ASSIGNED', 'Task assigned to staff s s (ID: 41) by manager (ID: 34). Tasks: Bed and Linen Care', '2025-11-13 08:14:47'),
(6, 3, 2, 34, 'CANCELLED', 'Task cancelled by manager (ID: 34).', '2025-11-13 08:24:00'),
(7, 4, 2, 34, 'ASSIGNED', 'Task assigned to staff s s (ID: 41) by manager (ID: 34). Tasks: Bed and Linen Care', '2025-11-13 08:24:33'),
(8, 4, 2, 34, 'CANCELLED', 'Task cancelled by manager (ID: 34).', '2025-11-13 08:26:11'),
(9, 5, 2, 34, 'ASSIGNED', 'Task assigned to staff s s (ID: 41) by manager (ID: 34). Tasks: General Cleaning, Bed and Linen Care, Bathroom Cleaning, Restocking Supplies, Trash Removal, Window & Curtains Care', '2025-11-13 08:26:22'),
(10, 5, 2, 34, 'CANCELLED', 'Task cancelled by manager (ID: 34).', '2025-11-13 08:27:42'),
(11, 6, 2, 34, 'ASSIGNED', 'Task assigned to staff s s (ID: 41) by manager (ID: 34). Tasks: Bed and Linen Care, Restocking Supplies', '2025-11-13 08:27:52'),
(12, 6, 2, 41, 'IN PROGRESS', 'Status set to \'In Progress\' by staff (ID: 41). Remarks: s', '2025-11-13 08:28:03'),
(13, 6, 2, 41, 'COMPLETED', 'Task completed by staff (ID: 41). Remarks: s', '2025-11-13 08:28:14'),
(14, 7, 4, 34, 'ASSIGNED', 'Task assigned to staff s s (ID: 41) by manager (ID: 34). Tasks: General Cleaning', '2025-11-14 14:28:06'),
(15, 7, 4, 34, 'CANCELLED', 'Task cancelled by manager (ID: 34).', '2025-11-14 14:28:22'),
(16, 8, 1, 34, 'ASSIGNED', 'Task assigned to staff s s (ID: 41) by manager (ID: 34). Tasks: Window & Curtains Care', '2025-11-14 14:36:25'),
(17, 8, 1, 34, 'CANCELLED', 'Task cancelled by manager (ID: 34).', '2025-11-14 14:53:44'),
(18, 9, 1, 34, 'ASSIGNED', 'Task assigned to staff s s (ID: 41) by manager (ID: 34). Tasks: General Cleaning', '2025-11-14 17:05:11'),
(19, 9, 1, 34, 'CANCELLED', 'Task cancelled by manager (ID: 34).', '2025-11-14 17:09:51'),
(20, 10, 1, 34, 'ASSIGNED', 'Task assigned to staff s s (ID: 41) by manager (ID: 34). Tasks: General Cleaning, Bathroom Cleaning', '2025-11-14 17:38:02'),
(21, 10, 1, 41, 'IN PROGRESS', 'Status set to \'In Progress\' by staff (ID: 41). Remarks: asd', '2025-11-14 17:38:09'),
(22, 10, 1, 41, 'COMPLETED', 'Task completed by staff (ID: 41). Remarks: asd', '2025-11-14 17:38:18'),
(23, 11, 7, 34, 'ASSIGNED', 'Task assigned to staff Angelo Gallardo (ID: 75) by manager (ID: 34). Tasks: Window & Curtains Care', '2025-11-24 01:31:09'),
(24, 11, 7, 34, 'CANCELLED', 'Task cancelled by manager (ID: 34).', '2025-11-24 01:31:22'),
(25, 12, 7, 34, 'ASSIGNED', 'Task assigned to staff Angelo Gallardo (ID: 75) by manager (ID: 34). Tasks: Window & Curtains Care', '2025-11-24 01:35:44'),
(26, 12, 7, 34, 'CANCELLED', 'Task cancelled by manager (ID: 34).', '2025-11-24 01:39:46'),
(27, 13, 7, 34, 'ASSIGNED', 'Task assigned to staff Angelo Gallardo (ID: 75) by manager (ID: 34). Tasks: Window & Curtains Care', '2025-11-24 01:42:11'),
(28, 13, 7, 34, 'CANCELLED', 'Task cancelled by manager (ID: 34).', '2025-11-24 01:46:02'),
(29, 14, 7, 34, 'ASSIGNED', 'Task assigned to staff Angelo Gallardo (ID: 75) by manager (ID: 34). Tasks: Window & Curtains Care', '2025-11-24 02:00:15');

-- --------------------------------------------------------

--
-- Table structure for table `pms_housekeeping_tasks`
--

CREATE TABLE `pms_housekeeping_tasks` (
  `TaskID` int NOT NULL,
  `RoomID` int NOT NULL,
  `UserID` int DEFAULT NULL COMMENT 'Manager who created the task',
  `AssignedUserID` int DEFAULT NULL COMMENT 'Staff member assigned to the task',
  `TaskType` varchar(255) COLLATE utf8mb4_general_ci DEFAULT 'Not Specified',
  `Status` varchar(50) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Pending',
  `DateRequested` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `DateCompleted` datetime DEFAULT NULL,
  `Remarks` text COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pms_housekeeping_tasks`
--

INSERT INTO `pms_housekeeping_tasks` (`TaskID`, `RoomID`, `UserID`, `AssignedUserID`, `TaskType`, `Status`, `DateRequested`, `DateCompleted`, `Remarks`) VALUES
(1, 2, 34, 41, 'Bed and Linen Care', 'Cancelled', '2025-11-13 07:48:05', NULL, 'Cancelled by Manager'),
(2, 2, 34, 41, 'General Cleaning, Bed and Linen Care, Bathroom Cleaning, Restocking Supplies, Trash Removal, Window & Curtains Care', 'Cancelled', '2025-11-13 08:11:33', NULL, 'Cancelled by Manager'),
(3, 2, 34, 41, 'Bed and Linen Care', 'Cancelled', '2025-11-13 08:14:45', NULL, 'Cancelled by Manager'),
(4, 2, 34, 41, 'Bed and Linen Care', 'Cancelled', '2025-11-13 08:24:30', NULL, 'Cancelled by Manager'),
(5, 2, 34, 41, 'General Cleaning, Bed and Linen Care, Bathroom Cleaning, Restocking Supplies, Trash Removal, Window & Curtains Care', 'Cancelled', '2025-11-13 08:26:19', NULL, 'Cancelled by Manager'),
(6, 2, 34, 41, 'Bed and Linen Care, Restocking Supplies', 'Completed', '2025-11-13 08:27:49', '2025-11-13 08:28:14', 's'),
(7, 4, 34, 41, 'General Cleaning', 'Cancelled', '2025-11-14 14:28:00', NULL, 'Cancelled by Manager'),
(8, 1, 34, 41, 'Window & Curtains Care', 'Cancelled', '2025-11-14 14:36:22', NULL, 'Cancelled by Manager'),
(9, 1, 34, 41, 'General Cleaning', 'Cancelled', '2025-11-14 17:05:08', NULL, 'Cancelled by Manager'),
(10, 1, 34, 41, 'General Cleaning, Bathroom Cleaning', 'Completed', '2025-11-14 17:37:59', '2025-11-14 17:38:18', 'asd'),
(11, 7, 34, 75, 'Window & Curtains Care', 'Cancelled', '2025-11-24 01:31:04', NULL, 'Cancelled by Manager'),
(12, 7, 34, 75, 'Window & Curtains Care', 'Cancelled', '2025-11-24 01:35:39', NULL, 'Cancelled by Manager'),
(13, 7, 34, 75, 'Window & Curtains Care', 'Cancelled', '2025-11-24 01:42:07', NULL, 'Cancelled by Manager'),
(14, 7, 34, 75, 'Window & Curtains Care', 'Pending', '2025-11-24 02:00:11', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pms_inventory`
--

CREATE TABLE `pms_inventory` (
  `ItemID` int NOT NULL,
  `ItemName` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `ItemCategoryID` int NOT NULL,
  `ItemQuantity` decimal(15,2) NOT NULL,
  `ItemDescription` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ItemStatus` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `DateofStockIn` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pms_inventory`
--

INSERT INTO `pms_inventory` (`ItemID`, `ItemName`, `ItemCategoryID`, `ItemQuantity`, `ItemDescription`, `ItemStatus`, `DateofStockIn`) VALUES
(11, 'Electrical Tape', 2, 12.00, 'asd', 'In Stock', '2025-11-23 17:21:27'),
(12, 'g', 3, 0.00, 's', 'Out of Stock', '2025-11-14 09:48:15'),
(15, 'Zondrox', 1, 20.00, 'asdcf', 'In Stock', '2025-11-23 16:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `pms_inventorylog`
--

CREATE TABLE `pms_inventorylog` (
  `InvLogID` int NOT NULL,
  `UserID` int NOT NULL,
  `ItemID` int NOT NULL,
  `Quantity` int NOT NULL,
  `InventoryLogReason` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `DateofRelease` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pms_inventorylog`
--

INSERT INTO `pms_inventorylog` (`InvLogID`, `UserID`, `ItemID`, `Quantity`, `InventoryLogReason`, `DateofRelease`) VALUES
(59, 38, 11, 4, 'Initial Stock In', '2025-11-10 13:36:50'),
(60, 38, 12, 2, 'Initial Stock In', '2025-11-10 13:37:01'),
(80, 39, 12, -2, 'Item Issued', '2025-11-14 09:48:15'),
(83, 39, 11, -4, 'Item Issued', '2025-11-23 17:18:43'),
(84, 38, 15, 20, 'Initial Stock In', '2025-11-23 17:20:35'),
(85, 38, 11, 12, 'Stock Added', '2025-11-23 17:21:12');

-- --------------------------------------------------------

--
-- Table structure for table `pms_itemcategory`
--

CREATE TABLE `pms_itemcategory` (
  `ItemCategoryID` int NOT NULL,
  `ItemCategoryName` varchar(255) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pms_itemcategory`
--

INSERT INTO `pms_itemcategory` (`ItemCategoryID`, `ItemCategoryName`) VALUES
(1, 'Cleaning Solution'),
(2, 'Electrical'),
(3, 'Furniture & Fixtures'),
(4, 'Room Amenities');

-- --------------------------------------------------------

--
-- Table structure for table `pms_maintenance_logs`
--

CREATE TABLE `pms_maintenance_logs` (
  `LogID` int NOT NULL,
  `RequestID` int DEFAULT NULL,
  `RoomID` int NOT NULL,
  `UserID` int DEFAULT NULL COMMENT 'User who performed the action (e.g., manager, staff)',
  `Timestamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Action` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'e.g., CREATED, ASSIGNED, STATUS_CHANGED, COMPLETED, CANCELLED',
  `Details` text COLLATE utf8mb4_general_ci COMMENT 'e.g., Status changed to In Progress by StaffID 5. Assigned to StaffID 5.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pms_maintenance_logs`
--

INSERT INTO `pms_maintenance_logs` (`LogID`, `RequestID`, `RoomID`, `UserID`, `Timestamp`, `Action`, `Details`) VALUES
(1, 1, 1, 35, '2025-11-14 14:23:00', 'ASSIGNED', 'Task assigned to staff Emily Chen (ID: 39) by manager (ID: 35). Issues: HVAC'),
(2, 1, 1, 39, '2025-11-14 14:26:04', 'IN PROGRESS', 'Status set to \'In Progress\' by staff (ID: 39). Remarks: sdf'),
(3, 1, 1, 39, '2025-11-14 14:26:07', 'COMPLETED', 'Task completed by staff (ID: 39). Remarks: sdf'),
(4, 2, 5, 35, '2025-11-14 14:26:32', 'ASSIGNED', 'Task assigned to staff Emily Chen (ID: 39) by manager (ID: 35). Issues: Doors & Windows'),
(5, 2, 5, 35, '2025-11-14 14:26:37', 'CANCELLED', 'Request cancelled by manager (ID: 35).'),
(6, 3, 5, 35, '2025-11-14 17:09:28', 'ASSIGNED', 'Task assigned to staff Emily Chen (ID: 39) by manager (ID: 35). Issues: Furniture & Fixtures, HVAC, Doors & Windows'),
(7, 3, 5, 35, '2025-11-14 17:09:41', 'CANCELLED', 'Request cancelled by manager (ID: 35).'),
(8, 4, 5, 35, '2025-11-14 17:37:03', 'ASSIGNED', 'Task assigned to staff Emily Chen (ID: 39) by manager (ID: 35). Issues: Plumbing'),
(9, 4, 5, 39, '2025-11-14 17:37:21', 'IN PROGRESS', 'Status set to \'In Progress\' by staff (ID: 39). Remarks: sdf'),
(10, 4, 5, 39, '2025-11-14 17:37:33', 'COMPLETED', 'Task completed by staff (ID: 39). Remarks: sdf'),
(11, 5, 1, 35, '2025-11-19 03:30:31', 'ASSIGNED', 'Task assigned to staff Emily Chen (ID: 39) by manager (ID: 35). Issues: Electrical & Lighting, Plumbing, Furniture & Fixtures, HVAC, Doors & Windows, Bathroom Area, Safety & Security, Flooring & Walls, Windows, Curtains, & Blinds'),
(12, 5, 1, 35, '2025-11-19 03:31:07', 'CANCELLED', 'Request cancelled by manager (ID: 35).'),
(13, 6, 1, 35, '2025-11-20 02:14:13', 'ASSIGNED', 'Task assigned to staff Emily Chen (ID: 39) by manager (ID: 35). Issues: Electrical & Lighting, Plumbing, Furniture & Fixtures, HVAC, Doors & Windows, Bathroom Area, Safety & Security, Flooring & Walls, Windows, Curtains, & Blinds'),
(14, 7, 6, 35, '2025-11-20 10:37:06', 'ASSIGNED', 'Task assigned to staff Theo Barrientos (ID: 52) by manager (ID: 35). Issues: Electrical & Lighting, Plumbing, Furniture & Fixtures, HVAC, Doors & Windows, Bathroom Area, Safety & Security, Flooring & Walls, Windows, Curtains, & Blinds'),
(15, 7, 6, 52, '2025-11-20 10:38:17', 'COMPLETED', 'Task completed by staff (ID: 52). Remarks: <h1 style=\"color:ffffff; \">WIlms<h1>'),
(16, 6, 1, 35, '2025-11-20 11:13:03', 'CANCELLED', 'Request cancelled by manager (ID: 35).'),
(17, 8, 1, 35, '2025-11-21 13:06:47', 'ASSIGNED', 'Task assigned to staff Theo Barrientos (ID: 62) by manager (ID: 35). Issues: Flooring & Walls'),
(18, 8, 1, 35, '2025-11-21 14:28:30', 'CANCELLED', 'Request cancelled by manager (ID: 35).'),
(19, 9, 1, 35, '2025-11-21 14:29:46', 'ASSIGNED', 'Task assigned to staff Theo Barrientos (ID: 62) by manager (ID: 35). Issues: Flooring & Walls'),
(20, 9, 1, 35, '2025-11-21 14:29:57', 'CANCELLED', 'Request cancelled by manager (ID: 35).'),
(21, 10, 1, 35, '2025-11-22 08:01:15', 'ASSIGNED', 'Task assigned to staff Louvel Navarro (ID: 77) by manager (ID: 35). Issues: Electrical & Lighting'),
(22, 10, 1, 35, '2025-11-24 00:32:07', 'CANCELLED', 'Request cancelled by manager (ID: 35).'),
(23, 11, 6, 35, '2025-11-24 01:30:12', 'ASSIGNED', 'Task assigned to staff Theo Barrientos (ID: 71) by manager (ID: 35). Issues: Flooring & Walls');

-- --------------------------------------------------------

--
-- Table structure for table `pms_maintenance_requests`
--

CREATE TABLE `pms_maintenance_requests` (
  `RequestID` int NOT NULL,
  `RoomID` int NOT NULL,
  `UserID` int NOT NULL,
  `IssueType` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `Status` varchar(50) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Pending',
  `Remarks` text COLLATE utf8mb4_general_ci,
  `DateRequested` datetime NOT NULL,
  `DateCompleted` datetime DEFAULT NULL,
  `AssignedUserID` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pms_maintenance_requests`
--

INSERT INTO `pms_maintenance_requests` (`RequestID`, `RoomID`, `UserID`, `IssueType`, `Status`, `Remarks`, `DateRequested`, `DateCompleted`, `AssignedUserID`) VALUES
(1, 1, 35, 'HVAC', 'Completed', 'sdf', '2025-11-14 14:22:51', '2025-11-14 14:26:07', 39),
(2, 5, 35, 'Doors & Windows', 'Cancelled', 'Cancelled by Manager', '2025-11-14 14:26:23', NULL, 39),
(3, 5, 35, 'Furniture & Fixtures, HVAC, Doors & Windows', 'Cancelled', 'Cancelled by Manager', '2025-11-14 17:09:25', NULL, 39),
(4, 5, 35, 'Plumbing', 'Completed', 'sdf', '2025-11-14 17:37:00', '2025-11-14 17:37:33', 39),
(5, 1, 35, 'Electrical & Lighting, Plumbing, Furniture & Fixtures, HVAC, Doors & Windows, Bathroom Area, Safety & Security, Flooring & Walls, Windows, Curtains, & Blinds', 'Cancelled', 'Cancelled by Manager', '2025-11-19 03:30:27', NULL, 39),
(6, 1, 35, 'Electrical & Lighting, Plumbing, Furniture & Fixtures, HVAC, Doors & Windows, Bathroom Area, Safety & Security, Flooring & Walls, Windows, Curtains, & Blinds', 'Cancelled', 'Cancelled by Manager', '2025-11-20 02:14:09', NULL, 39),
(7, 6, 35, 'Electrical & Lighting, Plumbing, Furniture & Fixtures, HVAC, Doors & Windows, Bathroom Area, Safety & Security, Flooring & Walls, Windows, Curtains, & Blinds', 'Completed', '<h1 style=\"color:ffffff; \">WIlms<h1>', '2025-11-20 10:37:00', '2025-11-20 10:38:16', 52),
(8, 1, 35, 'Flooring & Walls', 'Cancelled', 'Cancelled by Manager', '2025-11-21 13:06:42', NULL, 62),
(9, 1, 35, 'Flooring & Walls', 'Cancelled', 'Cancelled by Manager', '2025-11-21 14:29:41', NULL, 62),
(10, 1, 35, 'Electrical & Lighting', 'Cancelled', 'Cancelled by Manager', '2025-11-22 08:01:10', NULL, 77),
(11, 6, 35, 'Flooring & Walls', 'Pending', NULL, '2025-11-24 01:30:08', NULL, 71);

-- --------------------------------------------------------

--
-- Table structure for table `pms_parkingarea`
--

CREATE TABLE `pms_parkingarea` (
  `AreaID` int NOT NULL,
  `AreaName` varchar(100) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pms_parkingarea`
--

INSERT INTO `pms_parkingarea` (`AreaID`, `AreaName`) VALUES
(1, 'Area A'),
(2, 'Area B'),
(3, 'Area C'),
(4, 'Area D'),
(5, 'Area E');

-- --------------------------------------------------------

--
-- Table structure for table `pms_parkingslot`
--

CREATE TABLE `pms_parkingslot` (
  `SlotID` int NOT NULL,
  `AreaID` int NOT NULL,
  `SlotName` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `AllowedVehicleTypeID` int NOT NULL,
  `Status` enum('available','occupied','reserved','maintenance') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'available'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pms_parkingslot`
--

INSERT INTO `pms_parkingslot` (`SlotID`, `AreaID`, `SlotName`, `AllowedVehicleTypeID`, `Status`) VALUES
(51, 1, 'A-01', 1, 'occupied'),
(52, 1, 'A-02', 1, 'available'),
(53, 1, 'A-03', 1, 'available'),
(54, 1, 'A-04', 1, 'available'),
(55, 1, 'A-05', 1, 'available'),
(56, 1, 'A-06', 1, 'available'),
(57, 1, 'A-07', 1, 'available'),
(58, 1, 'A-08', 1, 'available'),
(59, 1, 'A-09', 1, 'available'),
(60, 1, 'A-10', 1, 'available'),
(61, 2, 'B-01', 2, 'available'),
(62, 2, 'B-02', 2, 'available'),
(63, 2, 'B-03', 2, 'available'),
(64, 2, 'B-04', 2, 'available'),
(65, 2, 'B-05', 2, 'available'),
(66, 2, 'B-06', 2, 'available'),
(67, 2, 'B-07', 2, 'available'),
(68, 2, 'B-08', 2, 'available'),
(69, 2, 'B-09', 2, 'available'),
(70, 2, 'B-10', 2, 'available'),
(71, 3, 'C-01', 2, 'available'),
(72, 3, 'C-02', 2, 'available'),
(73, 3, 'C-03', 2, 'available'),
(74, 3, 'C-04', 2, 'available'),
(75, 3, 'C-05', 2, 'available'),
(76, 3, 'C-06', 2, 'available'),
(77, 3, 'C-07', 2, 'available'),
(78, 3, 'C-08', 2, 'available'),
(79, 3, 'C-09', 2, 'available'),
(80, 3, 'C-10', 2, 'available'),
(81, 4, 'D-01', 2, 'available'),
(82, 4, 'D-02', 2, 'available'),
(83, 4, 'D-03', 2, 'available'),
(84, 4, 'D-04', 2, 'available'),
(85, 4, 'D-05', 2, 'available'),
(86, 4, 'D-06', 2, 'available'),
(87, 4, 'D-07', 2, 'available'),
(88, 4, 'D-08', 2, 'available'),
(89, 4, 'D-09', 2, 'available'),
(90, 4, 'D-10', 2, 'available'),
(91, 5, 'E-01', 2, 'available'),
(92, 5, 'E-02', 2, 'available'),
(93, 5, 'E-03', 2, 'available'),
(94, 5, 'E-04', 2, 'available'),
(95, 5, 'E-05', 2, 'available'),
(96, 5, 'E-06', 2, 'available'),
(97, 5, 'E-07', 2, 'available'),
(98, 5, 'E-08', 2, 'available'),
(99, 5, 'E-09', 2, 'available'),
(100, 5, 'E-10', 2, 'available');

-- --------------------------------------------------------

--
-- Table structure for table `pms_parking_sessions`
--

CREATE TABLE `pms_parking_sessions` (
  `SessionID` int NOT NULL,
  `SlotID` int NOT NULL,
  `PlateNumber` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `GuestName` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `RoomNumber` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `VehicleTypeID` int NOT NULL,
  `VehicleCategoryID` int NOT NULL,
  `EntryTime` datetime NOT NULL,
  `ExitTime` datetime DEFAULT NULL,
  `TotalFee` decimal(10,2) DEFAULT NULL,
  `StaffID_Entry` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pms_parking_sessions`
--

INSERT INTO `pms_parking_sessions` (`SessionID`, `SlotID`, `PlateNumber`, `GuestName`, `RoomNumber`, `VehicleTypeID`, `VehicleCategoryID`, `EntryTime`, `ExitTime`, `TotalFee`, `StaffID_Entry`) VALUES
(1, 51, 'QW4E12', 'asd', 's', 2, 9, '2025-11-07 16:08:27', '2025-11-07 16:08:36', NULL, 40),
(2, 51, 'WQE', 'wqe', 's', 1, 11, '2025-11-07 16:08:59', '2025-11-07 16:11:48', NULL, 40),
(3, 51, 'QWE', 'wqe', 'qwe', 1, 11, '2025-11-07 16:12:35', '2025-11-14 13:01:59', NULL, 40),
(4, 61, 'WE', 'wea', 'e', 2, 9, '2025-11-07 16:12:45', '2025-11-14 13:01:58', NULL, 40),
(5, 71, 'SDA', 'ad', 'asdasd', 1, 11, '2025-11-07 16:12:55', '2025-11-14 13:01:56', NULL, 40),
(6, 82, 'AS', 'asd', 'd', 1, 11, '2025-11-07 16:13:02', '2025-11-14 13:01:54', NULL, 40),
(7, 91, 'S', 'd', 'asd', 1, 11, '2025-11-07 16:13:14', '2025-11-07 17:00:50', NULL, 40),
(8, 52, 'QW4E12E', 'w', 'q1', 1, 11, '2025-11-08 02:48:34', '2025-11-08 02:48:37', NULL, 40),
(9, 52, 'D', 's', 'd', 1, 11, '2025-11-14 12:51:42', '2025-11-14 12:51:46', NULL, 40),
(10, 51, 'QWW', 'e', 'wqw', 1, 11, '2025-11-14 17:38:57', '2025-11-14 17:39:01', NULL, 40),
(11, 51, 'K210MO', '<h1 style=\"color: Blue; \">Wilms</h1>', '101', 2, 9, '2025-11-20 16:38:09', '2025-11-20 16:46:08', NULL, 40),
(12, 51, '<H1>SKIRT SKIRT</H1>', '<h1 style=\"color: Blue; \">Wilms</h1>', '101', 2, 9, '2025-11-20 16:56:26', NULL, NULL, 40),
(13, 52, 'LLKK', 'nn', '101', 1, 11, '2025-11-22 17:38:55', '2025-11-22 17:44:49', NULL, 40);

-- --------------------------------------------------------

--
-- Table structure for table `pms_room_status`
--

CREATE TABLE `pms_room_status` (
  `StatusID` int NOT NULL,
  `RoomNumber` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `RoomStatus` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `LastClean` timestamp NULL DEFAULT NULL,
  `LastMaintenance` timestamp NULL DEFAULT NULL,
  `UserID` int DEFAULT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pms_room_status`
--

INSERT INTO `pms_room_status` (`StatusID`, `RoomNumber`, `RoomStatus`, `LastClean`, `LastMaintenance`, `UserID`, `LastUpdated`) VALUES
(1, '101', 'Needs Maintenance', '2025-11-14 09:38:18', '2025-11-14 06:26:07', 35, '2025-11-19 03:30:16'),
(2, '102', 'Needs Maintenance', NULL, NULL, 35, '2025-11-22 09:47:14'),
(3, '103', 'Needs Maintenance', NULL, '2025-11-20 10:38:17', 35, '2025-11-22 09:46:52'),
(4, '104', 'Needs Cleaning', NULL, NULL, 79, '2025-11-23 16:38:36'),
(5, '105', 'Available', NULL, '2025-11-14 09:37:33', 35, '2025-11-14 09:37:33'),
(6, '201', 'Available', NULL, NULL, 1, '2025-11-14 06:27:19'),
(7, '202', 'Available', NULL, NULL, 35, '2025-11-14 06:05:49'),
(8, '203', 'Available', NULL, NULL, 35, '2025-11-14 06:05:51'),
(9, '204', 'Available', NULL, NULL, 35, '2025-11-14 06:05:52'),
(10, '205', 'Available', NULL, NULL, 35, '2025-11-14 06:05:54'),
(11, '301', 'Available', NULL, NULL, 35, '2025-11-14 06:05:57'),
(22, '302', 'Available', NULL, NULL, 35, '2025-11-14 06:06:26'),
(23, '303', 'Available', NULL, NULL, 35, '2025-11-14 06:06:29'),
(24, '405', 'Available', NULL, NULL, 35, '2025-11-14 06:06:31'),
(25, '404', 'Available', NULL, NULL, 35, '2025-11-14 06:06:34'),
(26, '403', 'Available', NULL, NULL, 35, '2025-11-14 06:06:36'),
(27, '402', 'Available', NULL, NULL, 35, '2025-11-14 06:06:40'),
(28, '401', 'Available', NULL, NULL, 35, '2025-11-14 06:06:42'),
(29, '305', 'Available', NULL, NULL, 35, '2025-11-14 06:06:45'),
(30, '304', 'Available', NULL, NULL, 35, '2025-11-14 06:06:47');

-- --------------------------------------------------------

--
-- Table structure for table `pms_users`
--

CREATE TABLE `pms_users` (
  `UserID` int NOT NULL,
  `EmployeeID` varchar(50) DEFAULT NULL,
  `Fname` varchar(255) NOT NULL,
  `Lname` varchar(255) NOT NULL,
  `Mname` varchar(255) DEFAULT NULL,
  `Birthday` date NOT NULL,
  `AccountType` varchar(255) NOT NULL,
  `AvailabilityStatus` varchar(20) NOT NULL DEFAULT 'Available',
  `Username` varchar(255) NOT NULL,
  `Password` varchar(255) DEFAULT NULL,
  `EmailAddress` varchar(255) NOT NULL,
  `Shift` varchar(255) NOT NULL,
  `Address` varchar(255) NOT NULL,
  `ContactNumber` varchar(50) DEFAULT NULL,
  `ActivationToken` varchar(64) DEFAULT NULL,
  `TokenExpiry` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `pms_users`
--

INSERT INTO `pms_users` (`UserID`, `EmployeeID`, `Fname`, `Lname`, `Mname`, `Birthday`, `AccountType`, `AvailabilityStatus`, `Username`, `Password`, `EmailAddress`, `Shift`, `Address`, `ContactNumber`, `ActivationToken`, `TokenExpiry`) VALUES
(1, NULL, 'vincew', 'vargas', 'gonzales', '2025-10-01', 'admin', 'Available', 'admin', '$2y$10$iZ6eUM/sMo1dmZGvFE5AGuYB8yLQidcRds9tk9zcXzx.2ySanAUUC', 'vincevargas90@gmail.com', 'Night', 'asd', NULL, NULL, NULL),
(34, 'E1011', 'house', 'keeping', 'manager', '2015-11-10', 'housekeeping_manager', 'Available', 'housekeeping', '$2y$10$iZ6eUM/sMo1dmZGvFE5AGuYB8yLQidcRds9tk9zcXzx.2ySanAUUC', 'asd@gmail.com', 'asd', 'asd', '324', NULL, NULL),
(35, 'E1012', 'maintain', 'nance', 'manager', '2015-11-02', 'maintenance_manager', 'Available', 'maintenance', '$2y$10$iZ6eUM/sMo1dmZGvFE5AGuYB8yLQidcRds9tk9zcXzx.2ySanAUUC', 'asd@sf.com', 'ss', 'asd', 'asd', NULL, NULL),
(38, '1009', 'Michael', 'Brown', 'F', '1992-09-18', 'inventory_manager', 'Available', 'mmanager', '$2y$10$w4.C1/HvHtUHdWCbhiHSL.U3oP8mnYQELkObEjhoy13JB9n76vQQK', 'michael.brown@example.com', 'Morning', '606 Parking Way, Taguig', '09220001009', '6543fd95970924b4af1da17b312e6fd145c34424ee1f999d858778fdbd2a65ee', '2025-11-08 03:25:04'),
(39, '1008', 'Emily', 'Chen', 'E', '2001-06-20', 'maintenance_staff', 'Available', 'mstaff', '$2y$10$iZ6eUM/sMo1dmZGvFE5AGuYB8yLQidcRds9tk9zcXzx.2ySanAUUC', 'farmersday96@gmail.com', 'Morning', '505 Repair Ln, Makati', '09210001008', '8a9a372ed04b1ab93f4e1d7b4eb9ed67f56b3e8941812b5dfe4f26741226afb6', '2025-11-08 03:28:56'),
(40, '1023', 'sadas', 'ssss', 'nase', '2015-11-03', 'parking_manager', 'Available', 'pmanager', '$2y$10$iZ6eUM/sMo1dmZGvFE5AGuYB8yLQidcRds9tk9zcXzx.2ySanAUUC', 'as', 'Morning', 'asd', 'asd', NULL, NULL),
(41, '1011', 's', 's', 's', '2025-11-01', 'housekeeping_staff', 'Available', 's.1011', '$2y$10$616gfHtMdprxzuO3.7nUjOlX3oU.6tB7PoY8n/LXFZK0aOMVJ.xrC', 'farmday26@gmail.com', 'Morning', 'ss', 'sdsd', '83706a98a81c800faf0d8d1bab418e146b9a9b8be04568079a88d9673798b6ad', '2025-11-14 00:47:36'),
(49, 'EMP-0013', 'Michael', 'Reyes', 'Santos', '1998-03-27', 'inventory_manager', 'Available', 'reyes.emp-0013', '$2y$10$6tfMIPOFkyvpbUB9EwCBJ.tMdgHlxnvqoNnWdAnzsBVWPaZ0HcpUu', 'michael.reyes@gmail.com', 'morning', '159 Front Office', '+639293456789', 'd386df87b3ceb85cbd2aa92d913c0ce71b6d56d9b786922e3135c1265b993a93', '2025-11-21 05:31:14'),
(67, 'EMP-0041', 'Ezekiel', 'De Leon', NULL, '1995-12-01', 'maintenance_manager', 'Offline', 'de leon.emp-0041', '$2y$10$cWkQZRyJ5K5Z43kemfxl7Ojl.0CMBP22Vn/rDffJvSd5Vtq6lFV7W', 'ezekieldeleon@gmail.com', 'morning', ' 1161 Jorenz Avenue Tanada Subdivision 1440', '09123123232', 'e38feae793b3679bcafd161342762081592da8da9c7573925a978d557f77ec18', '2025-11-23 01:23:00'),
(68, 'EMP-0042', 'Sophia', 'Santos', NULL, '1996-08-09', 'housekeeping_manager', 'Offline', 'santos.emp-0042', '$2y$10$E8ArCC0hCsy0n9ve/9DxJeYZjtVLwcRrbWj4Ux1byYpjW2OSaH8Bm', 'santossophia@gmail.com', 'night', ' 2176 Road 6', '09277151515', 'def15c3c0cc9796ef26d1df8cd38754ebad14889e4e58b0987cc1a9a18cb8553', '2025-11-23 01:23:09'),
(69, 'EMP-0043', 'Genkei', 'Domingo', 'Liberal', '1990-05-23', 'inventory_manager', 'Offline', 'domingo.emp-0043', '$2y$10$mtvIDTSuh6c3NjV0klnI6eXaiKuGbQosVRk/SZdQFPS8HpJcHvVjS', 'keidomingo@gmail.com', 'night', ' 7/F Citibank Center8741 Paseo De Roxas1200', '09882455777', '780285032a0786f898d4da042ed3b00c29569304e4f7d72dcad44b32cc4c1796', '2025-11-23 01:23:21'),
(70, 'EMP-0044', 'Hazel', 'Lacson', NULL, '2000-01-13', 'parking_manager', 'Offline', 'lacson.emp-0044', '$2y$10$FUTc6SdVFM5QrKci6zkYJesWpDfWILP7uPchWmWeIbD.78piinFn6', 'lacsonhazel@gmail.com', 'morning', '68 West Avenue', '09455166125', '2ae6e0f529dddb25a551cfc3c855debcce9efbde8d36444496cd02771e6222c3', '2025-11-23 01:23:29'),
(71, 'EMP-0045', 'Theo', 'Barrientos', NULL, '1995-09-09', 'maintenance_staff', 'Assigned', 'barrientos.emp-0045', '$2y$10$G7UD5CTY3dFBaeSMIYDZBeAa.nvPEDvo741oBtdK3Jkze2MK5QTPO', 'marasiganRyan@gmail.com', 'night', '199-B E. Rodriguez Street', '09415515155', '474f8328598e004c26412750063fd14b27d576e97ecb45abc44a4de8f9b21bd6', '2025-11-23 01:23:38'),
(72, 'EMP-0047', 'Ryan', 'Marasigan', NULL, '1999-08-09', 'admin', 'Offline', 'marasigan.emp-0047', '$2y$10$0PzFUs9JaB2sQyZfi.4MdOKM.Xj187RH1NodMOaXybeqe5ZEby68K', 'bagayanjohnwilmertimaan@gmail.com', 'night', ' 2288 Chino Roces Avenue Extension 1200', '09662781722', '52393bd1cde5bbe1ba5fb7d94141628195bd10a1309d13c198e898896ac561a3', '2025-11-23 01:23:53'),
(73, 'EMP-0027', 'Shawn', 'Cordero', NULL, '2005-02-09', 'maintenance_staff', 'Offline', 'cordero.emp-0027', '$2y$10$BJv3dxZKTM53dZ57TYPTCeBKjGjba/BIf6y1pu1O/7a.9TGxjOL3.', 'corderoshawn@gmail.com', 'morning', ' PDCP Bank Center', '09123233222', '04c1f5d940ef0558ed513365804921c00754391fa3be46cdc8d6efc455c0a5c5', '2025-11-23 01:27:11'),
(74, 'EMP-0029', 'Ethan', 'Atienza', NULL, '2001-12-29', 'inventory_manager', 'Offline', 'atienza.emp-0029', '$2y$10$mraTR4U9phkqzLx7vp4w5O44kp75YaCX5C.z5PxO7Qb9jfiFfWUaa', 'atienzaethan@gmail.com', 'night', ' 8741 Paseo De Roxas', '09322214141', 'bf92fec09937578a5364497911fb11a497b69f09cae813fecb433692c724692a', '2025-11-23 01:27:31'),
(75, 'EMP-0057', 'Angelo', 'Gallardo', NULL, '2005-05-01', 'housekeeping_staff', 'Assigned', 'gallardo.emp-0057', '$2y$10$dbeENrwvdW21QGc/F9vI9uiRKMTyCgEXvW3GDni7kReIonlVqxLMu', 'gallardoangelo@gmail.com', 'morning', '1241 Padre Faura Street Corner M.H. Del Pilar Street Ermita 1000', '09516726771', '4b895ec9c9cfed006ac6e5e3bf82c36895479c2434e053239dd466f9e9d482d8', '2025-11-23 01:32:53'),
(76, 'EMP-0058', 'Morris', 'Dalisay', NULL, '1992-02-16', 'housekeeping_staff', 'Offline', 'dalisay.emp-0058', '$2y$10$uBpEThWukMYIPMoZgqH.6O4Ocx6CWMIPDYxTo/KB7KzqG7WvXGEda', 'dalisaymors@gmail.com', 'morning', ' 1233 United Nations Avenue, Paco', '09626367778', 'edf82a3c73c57c0275c6e22ef52ee3d3d6d05092f5fe310d6118ca041ef82d7e', '2025-11-23 01:33:02'),
(77, 'EMP-0059', 'Louvel', 'Navarro', NULL, '2001-12-06', 'maintenance_staff', 'Available', 'navarro.emp-0059', '$2y$10$xJyHOKVyI7R7cPAbiKKJ4ekVvsTDhNw6Ea97YCdbyB0T2SsJzgwNC', 'velnavarro20@gmail.com', 'morning', '1617 Sisa Street 1200', '09514414555', '51b46108e78afba8e86a2e5e4b2bb5c0d8280078a0f754707a21988d1e9adde7', '2025-11-23 01:33:11'),
(78, 'EMP-0060', 'Aaron', 'Apostol', NULL, '2000-10-01', 'maintenance_staff', 'Offline', 'apostol.emp-0060', '$2y$10$yr0uZsQIfi/sDxL2dQZAHuTvwOK4RtYTxgrItB/M7MZceUr1rRBqS', 'ronsapostol12@gmail.com', 'morning', '  Madrigal Building', '09516167725', '2139e896d8bc92844f69dc306f571d09d7906cb14acb57d0ab3bf03b7dcc6b8d', '2025-11-23 01:33:21'),
(79, 'EMP-0063', 'Cristina', 'Patulilic', NULL, '2001-12-02', 'housekeeping_manager', 'Offline', 'patulilic.emp-0063', '$2y$10$NLpC0pnuUnqquBxzPz6Ws.JjIUaQBA29.T3bb58EwBW/6vdoiGtKm', 'patulilichousekeepingmanager@gmail.com', 'morning', '1130 Oroquieta Street 1000', '09515241245', NULL, NULL),
(81, 'EMP-0056', 'John Wilmer', 'Ti-maan', NULL, '2005-02-01', 'maintenance_manager', 'Offline', 'ti-maan.emp-0056', '$2y$10$wa2eapORwHxq7peZpTPOJ.sfT1UpuIuLy/7k6Esd37JB8pVSvpmYi', 'bagayan.maintenancemanager@gmail.com', 'morning', 'Novaliches', '09123515151', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pms_user_logs`
--

CREATE TABLE `pms_user_logs` (
  `LogID` int NOT NULL,
  `UserID` int DEFAULT NULL,
  `ActionType` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pms_user_logs`
--

INSERT INTO `pms_user_logs` (`LogID`, `UserID`, `ActionType`, `Timestamp`) VALUES
(1, 1, 'Logged Out', '2025-11-10 10:43:28'),
(2, 1, 'Logged Out', '2025-11-10 10:43:46'),
(3, 34, 'Logged Out', '2025-11-10 10:43:53'),
(4, 1, 'Logged Out', '2025-11-10 10:44:39'),
(5, 1, 'Logged Out', '2025-11-10 10:45:12'),
(6, 1, 'Logged Out', '2025-11-10 10:45:54'),
(7, 34, 'Logged Out', '2025-11-10 10:46:00'),
(8, 1, 'Logged Out', '2025-11-10 10:46:41'),
(9, 1, 'Logged Out', '2025-11-10 10:46:54'),
(10, 34, 'Logged Out', '2025-11-10 10:46:59'),
(11, 1, 'Logged Out', '2025-11-10 10:50:09'),
(12, 1, 'Logged Out', '2025-11-10 10:50:26'),
(13, 39, 'Logged Out', '2025-11-10 10:50:37'),
(14, 1, 'Logged Out', '2025-11-10 10:54:52'),
(15, 1, 'Logged Out', '2025-11-10 10:55:29'),
(16, 38, 'Logged Out', '2025-11-10 10:55:50'),
(17, 1, 'Logged Out', '2025-11-10 10:57:37'),
(18, 1, 'Logged Out', '2025-11-10 10:57:55'),
(19, 1, 'Logged Out', '2025-11-10 10:58:16'),
(20, 1, 'Logged Out', '2025-11-10 10:59:35'),
(21, 1, 'Logged Out', '2025-11-10 11:01:43'),
(22, 1, 'Logged Out', '2025-11-10 11:02:44'),
(23, 1, 'Logged Out', '2025-11-10 11:04:56'),
(24, 1, 'Logged Out', '2025-11-10 11:06:27'),
(25, 1, 'Logged Out', '2025-11-10 11:11:59'),
(26, 1, 'Logged Out', '2025-11-10 11:12:20'),
(27, 1, 'Logged Out', '2025-11-10 11:15:36'),
(28, 1, 'Logged Out', '2025-11-10 11:17:57'),
(29, 1, 'Logged Out', '2025-11-10 11:28:05'),
(30, 1, 'Logged In', '2025-11-10 11:28:10'),
(31, 1, 'Logged Out', '2025-11-10 11:28:20'),
(32, 38, 'Logged In', '2025-11-10 11:28:24'),
(33, 38, 'Logged Out', '2025-11-10 11:28:28'),
(34, 34, 'Logged In', '2025-11-10 11:28:36'),
(35, 34, 'Logged Out', '2025-11-10 11:28:40'),
(36, 35, 'Logged In', '2025-11-10 11:28:51'),
(37, 35, 'Logged Out', '2025-11-10 11:28:54'),
(38, 40, 'Logged In', '2025-11-10 11:29:00'),
(39, 40, 'Logged Out', '2025-11-10 11:29:03'),
(40, 39, 'Logged In', '2025-11-10 11:29:15'),
(41, 39, 'Logged Out', '2025-11-10 11:29:18'),
(42, 1, 'Logged In', '2025-11-10 11:29:25'),
(43, 1, 'Logged Out', '2025-11-10 11:31:36'),
(44, 40, 'Logged In', '2025-11-10 11:31:41'),
(45, 40, 'Logged Out', '2025-11-10 11:31:57'),
(46, 1, 'Logged In', '2025-11-10 11:32:03'),
(47, 1, 'Logged Out', '2025-11-10 11:32:40'),
(48, 40, 'Logged In', '2025-11-10 11:32:44'),
(49, 40, 'Logged Out', '2025-11-10 11:32:50'),
(50, 1, 'Logged In', '2025-11-10 11:32:54'),
(51, 1, 'Logged Out', '2025-11-10 11:35:47'),
(52, 38, 'Logged In', '2025-11-10 11:35:53'),
(53, 38, 'Logged Out', '2025-11-10 13:38:11'),
(54, 39, 'Logged In', '2025-11-10 13:38:16'),
(55, 39, 'Logged Out', '2025-11-10 13:39:40'),
(56, 38, 'Logged In', '2025-11-10 13:39:45'),
(57, 38, 'Logged Out', '2025-11-10 14:00:03'),
(58, 34, 'Logged In', '2025-11-10 14:00:08'),
(59, 34, 'Logged Out', '2025-11-10 14:00:12'),
(60, 39, 'Logged In', '2025-11-10 14:00:17'),
(61, 39, 'Logged Out', '2025-11-10 14:00:31'),
(62, 38, 'Logged In', '2025-11-10 14:00:43'),
(63, 38, 'Logged Out', '2025-11-10 14:08:45'),
(64, 39, 'Logged In', '2025-11-10 14:08:49'),
(65, 39, 'Logged Out', '2025-11-10 14:08:59'),
(66, 38, 'Logged In', '2025-11-10 14:09:03'),
(67, 38, 'Logged Out', '2025-11-10 14:20:30'),
(68, 39, 'Logged In', '2025-11-10 14:20:34'),
(69, 39, 'Logged Out', '2025-11-10 14:20:47'),
(70, 38, 'Logged In', '2025-11-10 14:20:51'),
(71, 38, 'Logged Out', '2025-11-10 14:27:58'),
(72, 40, 'Logged In', '2025-11-10 14:28:09'),
(73, 40, 'Logged Out', '2025-11-10 14:28:25'),
(74, 40, 'Logged In', '2025-11-10 14:28:33'),
(75, 40, 'Logged Out', '2025-11-10 14:28:36'),
(76, 38, 'Logged In', '2025-11-10 14:28:41'),
(77, 38, 'Logged Out', '2025-11-10 14:28:49'),
(78, 39, 'Logged In', '2025-11-10 14:29:15'),
(79, 39, 'Logged Out', '2025-11-10 14:29:22'),
(80, 38, 'Logged In', '2025-11-10 14:29:26'),
(81, 38, 'Logged Out', '2025-11-10 14:39:50'),
(82, 39, 'Logged In', '2025-11-10 14:40:00'),
(83, 39, 'Logged Out', '2025-11-10 14:40:08'),
(84, 38, 'Logged In', '2025-11-10 14:40:14'),
(85, 38, 'Logged Out', '2025-11-10 14:40:19'),
(86, 38, 'Logged In', '2025-11-10 14:40:26'),
(87, 38, 'Logged Out', '2025-11-10 14:40:42'),
(88, 1, 'Logged In', '2025-11-10 14:41:00'),
(89, 1, 'Logged Out', '2025-11-10 16:04:26'),
(90, 1, 'Logged In', '2025-11-10 16:04:31'),
(91, 1, 'Logged Out', '2025-11-10 16:06:59'),
(92, 35, 'Logged In', '2025-11-10 16:07:05'),
(93, 38, 'Logged In', '2025-11-10 17:14:55'),
(94, 35, 'Logged Out', '2025-11-10 17:49:50'),
(95, 35, 'Logged In', '2025-11-10 17:49:59'),
(96, 35, 'Logged Out', '2025-11-10 18:22:49'),
(97, 38, 'Logged In', '2025-11-10 18:22:54'),
(98, 38, 'Logged Out', '2025-11-10 18:43:02'),
(99, 35, 'Logged In', '2025-11-10 18:43:08'),
(100, 35, 'Logged Out', '2025-11-10 19:49:28'),
(101, 1, 'Logged In', '2025-11-10 19:49:31'),
(102, 1, 'Logged Out', '2025-11-10 19:49:59'),
(103, 35, 'Logged In', '2025-11-10 19:50:07'),
(104, 35, 'Logged Out', '2025-11-10 20:11:50'),
(105, 1, 'Logged In', '2025-11-10 20:12:00'),
(106, 1, 'Logged Out', '2025-11-10 20:17:18'),
(107, 35, 'Logged In', '2025-11-10 20:17:22'),
(108, 35, 'Logged Out', '2025-11-10 20:32:33'),
(109, 1, 'Logged In', '2025-11-10 20:32:37'),
(110, 1, 'Logged Out', '2025-11-10 20:33:42'),
(111, 35, 'Logged In', '2025-11-10 20:33:46'),
(112, 1, 'Logged In', '2025-11-10 20:35:47'),
(113, 1, 'Logged Out', '2025-11-10 21:02:14'),
(114, 35, 'Logged In', '2025-11-10 21:02:18'),
(115, 35, 'Logged Out', '2025-11-10 21:23:59'),
(116, 35, 'Logged Out', '2025-11-10 21:39:09'),
(117, 35, 'Logged In', '2025-11-10 21:39:18'),
(118, 35, 'Logged In', '2025-11-10 21:57:05'),
(119, 1, 'Logged In', '2025-11-10 23:30:19'),
(120, 1, 'Logged Out', '2025-11-10 23:30:21'),
(121, 35, 'Logged In', '2025-11-10 23:30:26'),
(122, 35, 'Logged Out', '2025-11-10 23:31:16'),
(123, 1, 'Logged In', '2025-11-10 23:31:20'),
(124, 1, 'Logged Out', '2025-11-10 23:32:08'),
(125, 35, 'Logged In', '2025-11-10 23:32:16'),
(126, 35, 'Logged Out', '2025-11-10 23:35:11'),
(127, 1, 'Logged In', '2025-11-10 23:35:15'),
(128, 1, 'Logged Out', '2025-11-10 23:35:32'),
(129, 35, 'Logged In', '2025-11-10 23:35:37'),
(130, 35, 'Logged Out', '2025-11-10 23:49:04'),
(131, 1, 'Logged In', '2025-11-10 23:49:17'),
(132, 1, 'Logged Out', '2025-11-11 00:00:25'),
(133, 35, 'Logged In', '2025-11-11 00:00:29'),
(134, 39, 'Logged In', '2025-11-11 00:21:09'),
(135, 35, 'Logged Out', '2025-11-11 00:28:25'),
(136, 35, 'Logged In', '2025-11-11 00:28:35'),
(137, 35, 'Logged Out', '2025-11-11 00:29:06'),
(138, 1, 'Logged In', '2025-11-11 00:29:12'),
(139, 1, 'Logged Out', '2025-11-11 00:30:03'),
(140, 35, 'Logged In', '2025-11-11 00:30:09'),
(141, 39, 'Logged Out', '2025-11-11 00:35:43'),
(142, 39, 'Logged In', '2025-11-11 00:35:48'),
(143, 39, 'Logged Out', '2025-11-11 00:37:29'),
(144, 39, 'Logged In', '2025-11-11 00:37:35'),
(145, 35, 'Logged Out', '2025-11-11 01:04:44'),
(146, 1, 'Logged In', '2025-11-11 01:05:19'),
(147, 1, 'Logged Out', '2025-11-11 01:12:08'),
(148, 39, 'Logged In', '2025-11-11 01:12:15'),
(149, 39, 'Logged Out', '2025-11-11 01:12:21'),
(150, 35, 'Logged In', '2025-11-11 01:12:25'),
(151, 39, 'Logged Out', '2025-11-11 01:17:08'),
(152, 1, 'Logged In', '2025-11-11 01:17:12'),
(153, 1, 'Logged Out', '2025-11-11 01:42:55'),
(154, 1, 'Logged In', '2025-11-11 01:42:58'),
(155, 1, 'Logged Out', '2025-11-11 01:43:00'),
(156, 1, 'Logged In', '2025-11-11 01:43:10'),
(157, 1, 'Logged Out', '2025-11-11 01:43:11'),
(158, 1, 'Logged In', '2025-11-11 02:13:43'),
(159, 1, 'Logged Out', '2025-11-11 02:43:09'),
(160, 35, 'Logged In', '2025-11-11 02:43:19'),
(161, 35, 'Logged Out', '2025-11-11 02:57:05'),
(162, 1, 'Logged In', '2025-11-11 02:57:09'),
(163, 1, 'Logged In', '2025-11-11 15:07:21'),
(164, 1, 'Logged Out', '2025-11-11 15:07:31'),
(165, 35, 'Logged In', '2025-11-11 15:07:35'),
(166, 35, 'Logged Out', '2025-11-11 15:36:07'),
(167, 38, 'Logged In', '2025-11-11 15:36:12'),
(168, 38, 'Logged Out', '2025-11-11 15:36:28'),
(169, 39, 'Logged In', '2025-11-11 15:36:39'),
(170, 39, 'Logged Out', '2025-11-11 15:36:43'),
(171, 34, 'Logged In', '2025-11-11 15:36:48'),
(172, 34, 'Logged Out', '2025-11-11 15:39:25'),
(173, 35, 'Logged In', '2025-11-11 15:39:29'),
(174, 1, 'Logged In', '2025-11-11 15:58:34'),
(175, 1, 'Logged Out', '2025-11-11 16:03:02'),
(176, 35, 'Logged In', '2025-11-11 16:03:09'),
(177, 34, 'Logged In', '2025-11-11 16:14:58'),
(178, 34, 'Logged Out', '2025-11-11 16:15:06'),
(179, 35, 'Logged In', '2025-11-11 16:15:22'),
(180, 35, 'Logged Out', '2025-11-11 17:21:11'),
(181, 1, 'Logged In', '2025-11-11 17:21:14'),
(182, 1, 'Logged Out', '2025-11-11 17:21:31'),
(183, 35, 'Logged In', '2025-11-11 17:21:35'),
(184, 35, 'Logged Out', '2025-11-11 19:50:24'),
(185, 1, 'Logged In', '2025-11-11 19:50:37'),
(186, 1, 'Logged Out', '2025-11-11 19:50:45'),
(187, 1, 'Logged In', '2025-11-11 19:50:48'),
(188, 1, 'Logged Out', '2025-11-11 19:52:10'),
(189, 35, 'Logged In', '2025-11-11 19:52:15'),
(190, 35, 'Logged Out', '2025-11-11 20:06:09'),
(191, 35, 'Logged In', '2025-11-11 20:06:14'),
(192, 35, 'Logged Out', '2025-11-11 20:56:33'),
(193, 1, 'Logged In', '2025-11-11 20:56:37'),
(194, 1, 'Logged Out', '2025-11-11 20:59:09'),
(195, 35, 'Logged In', '2025-11-11 20:59:15'),
(196, 1, 'Logged In', '2025-11-11 21:01:50'),
(197, 35, 'Logged Out', '2025-11-11 21:05:09'),
(198, 35, 'Logged In', '2025-11-11 21:05:15'),
(199, 35, 'Logged In', '2025-11-11 21:13:41'),
(200, 35, 'Logged Out', '2025-11-11 21:13:51'),
(201, 35, 'Logged In', '2025-11-11 21:16:20'),
(202, 35, 'Logged Out', '2025-11-11 21:36:06'),
(203, 35, 'Logged In', '2025-11-12 17:45:06'),
(204, 35, 'Logged Out', '2025-11-12 18:50:32'),
(205, 35, 'Logged In', '2025-11-12 18:50:36'),
(206, 35, 'Logged In', '2025-11-12 18:51:30'),
(207, 35, 'Logged Out', '2025-11-12 18:55:08'),
(208, 35, 'Logged In', '2025-11-12 18:55:16'),
(209, 35, 'Logged In', '2025-11-12 20:39:19'),
(210, 35, 'Logged Out', '2025-11-12 20:47:06'),
(211, 35, 'Logged In', '2025-11-12 20:47:19'),
(212, 35, 'Logged In', '2025-11-12 20:54:49'),
(213, 35, 'Logged Out', '2025-11-12 22:53:28'),
(214, 34, 'Logged In', '2025-11-12 22:53:32'),
(215, 34, 'Logged Out', '2025-11-12 23:17:01'),
(216, 35, 'Logged In', '2025-11-12 23:17:09'),
(217, 35, 'Logged Out', '2025-11-12 23:19:14'),
(218, 34, 'Logged In', '2025-11-12 23:19:20'),
(219, 34, 'Logged Out', '2025-11-12 23:23:03'),
(220, 35, 'Logged In', '2025-11-12 23:23:07'),
(221, 35, 'Logged Out', '2025-11-12 23:24:43'),
(222, 34, 'Logged In', '2025-11-12 23:24:46'),
(223, 34, 'Logged Out', '2025-11-12 23:24:57'),
(224, 35, 'Logged In', '2025-11-12 23:25:01'),
(225, 35, 'Logged Out', '2025-11-12 23:27:02'),
(226, 34, 'Logged In', '2025-11-12 23:27:05'),
(227, 34, 'Logged Out', '2025-11-12 23:47:16'),
(228, 1, 'Logged In', '2025-11-12 23:47:21'),
(229, 1, 'Logged Out', '2025-11-12 23:47:46'),
(230, 34, 'Logged In', '2025-11-12 23:47:49'),
(231, 35, 'Logged In', '2025-11-12 23:51:40'),
(232, 34, 'Logged Out', '2025-11-13 00:24:06'),
(233, 1, 'Logged In', '2025-11-13 00:24:09'),
(234, 1, 'Logged Out', '2025-11-13 00:24:19'),
(235, 34, 'Logged In', '2025-11-13 00:24:23'),
(236, 34, 'Logged Out', '2025-11-13 00:27:15'),
(237, 1, 'Logged In', '2025-11-13 00:27:20'),
(238, 1, 'Logged Out', '2025-11-13 00:27:34'),
(239, 34, 'Logged In', '2025-11-13 00:27:39'),
(240, 34, 'Logged Out', '2025-11-13 00:29:28'),
(241, 1, 'Logged In', '2025-11-13 00:29:32'),
(242, 35, 'Logged In', '2025-11-13 00:48:45'),
(243, 35, 'Logged Out', '2025-11-13 00:58:51'),
(244, 1, 'Logged In', '2025-11-13 00:58:54'),
(245, 1, 'Logged In', '2025-11-14 04:15:12');

-- --------------------------------------------------------

--
-- Table structure for table `pms_vehiclecategory`
--

CREATE TABLE `pms_vehiclecategory` (
  `VehicleCategoryID` int NOT NULL,
  `VehicleTypeID` int NOT NULL,
  `CategoryName` varchar(100) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pms_vehiclecategory`
--

INSERT INTO `pms_vehiclecategory` (`VehicleCategoryID`, `VehicleTypeID`, `CategoryName`) VALUES
(7, 2, 'Sedan'),
(8, 2, 'SUV'),
(9, 2, 'Pickup'),
(10, 2, 'Van'),
(11, 1, 'Motorcycle'),
(12, 2, 'Truck');

-- --------------------------------------------------------

--
-- Table structure for table `pms_vehicletype`
--

CREATE TABLE `pms_vehicletype` (
  `VehicleTypeID` int NOT NULL,
  `TypeName` varchar(50) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pms_vehicletype`
--

INSERT INTO `pms_vehicletype` (`VehicleTypeID`, `TypeName`) VALUES
(1, '2 Wheeled'),
(2, '4 Wheeled');

-- --------------------------------------------------------

--
-- Table structure for table `public_ticket_emails`
--

CREATE TABLE `public_ticket_emails` (
  `id` int NOT NULL,
  `ticket_id` int NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `revenue_analytics`
--

CREATE TABLE `revenue_analytics` (
  `analytics_id` int NOT NULL,
  `period` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Daily, Weekly, Monthly',
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `streams` json NOT NULL COMMENT 'Revenue breakdown by category',
  `trend_data` json NOT NULL COMMENT 'Time series data',
  `total_revenue` decimal(12,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `revenue_category`
--

CREATE TABLE `revenue_category` (
  `revenue_category_id` int NOT NULL,
  `revenue_category` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `revenue_category`
--

INSERT INTO `revenue_category` (`revenue_category_id`, `revenue_category`, `status`, `created_at`, `updated_at`, `description`) VALUES
(1, 'Room Bookings', 'active', '2025-11-02 04:02:18', '2025-11-02 04:02:18', NULL),
(2, 'Event & Conferences', 'active', '2025-11-02 04:02:18', '2025-11-02 04:02:18', NULL),
(3, 'Spa Services', 'active', '2025-11-02 04:02:18', '2025-11-02 04:02:18', NULL),
(4, 'Food & Beverage', 'active', '2025-11-02 04:02:18', '2025-11-02 04:02:18', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `revenue_entry`
--

CREATE TABLE `revenue_entry` (
  `revenue_entry_id` int NOT NULL,
  `revenue_category_id` int DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guest_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `room_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` date NOT NULL,
  `additional_notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `category` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `revenue_entry`
--

INSERT INTO `revenue_entry` (`revenue_entry_id`, `revenue_category_id`, `amount`, `source`, `payment_method`, `guest_name`, `room_number`, `date`, `additional_notes`, `is_active`, `created_at`, `updated_at`, `category`) VALUES
(1, 4, 972.05, 'order-2', NULL, NULL, NULL, '2025-11-13', 'Auto-synced from Dine-in', 1, '2025-11-15 00:05:42', '2025-11-15 00:05:42', NULL),
(2, 4, 271.04, 'order-3', NULL, NULL, NULL, '2025-11-13', 'Auto-synced from Dine-in', 1, '2025-11-15 00:05:42', '2025-11-15 00:05:42', NULL),
(3, 4, 1133.44, 'order-6', NULL, NULL, NULL, '2025-11-13', 'Auto-synced from Room Dining', 1, '2025-11-15 00:05:42', '2025-11-15 00:05:42', NULL),
(4, 4, 739.20, 'order-7', 'Cash', NULL, NULL, '2025-11-14', 'Auto-synced from Walk-in', 1, '2025-11-15 00:05:42', '2025-11-15 00:05:42', NULL),
(5, 4, 911.68, 'order-8', NULL, NULL, NULL, '2025-11-14', 'Auto-synced from Dine-in', 1, '2025-11-15 00:05:43', '2025-11-15 00:05:43', NULL),
(6, 4, 77.00, 'order-19', 'Cash', NULL, NULL, '2025-11-14', 'Auto-synced from Walk-in', 1, '2025-11-15 00:05:43', '2025-11-15 00:05:43', NULL),
(7, 1, 5000.00, 'payment-3', 'Credit Card', 'cambe cambe cambe', '2', '2025-11-07', 'Auto-synced from reservation #2. Ref: REF123456', 1, '2025-11-15 00:05:43', '2025-11-15 00:05:43', NULL),
(8, 1, 7000.00, 'payment-1', 'Credit Card', 'gelo m kambe', '1', '2025-10-24', 'Auto-synced from reservation #1. Ref: REF-20251023-001', 1, '2025-11-15 00:05:43', '2025-11-15 00:05:43', NULL),
(9, 4, 875.95, 'order-30', NULL, NULL, NULL, '2025-11-15', 'Auto-synced from Dine-in', 1, '2025-11-15 01:50:02', '2025-11-15 01:50:02', NULL),
(10, 4, 443.52, 'order-32', 'Cash', NULL, NULL, '2025-11-15', 'Auto-synced from Phone Order', 1, '2025-11-15 01:50:02', '2025-11-15 01:50:02', NULL),
(11, 4, 221.76, 'order-34', NULL, NULL, NULL, '2025-11-15', 'Auto-synced from Dine-in', 1, '2025-11-15 02:20:02', '2025-11-15 02:20:02', NULL),
(12, 4, 468.16, 'order-35', NULL, NULL, NULL, '2025-11-15', 'Auto-synced from Dine-in', 1, '2025-11-15 02:20:03', '2025-11-15 02:20:03', NULL),
(13, 4, 271.04, 'order-36', NULL, NULL, NULL, '2025-11-15', 'Auto-synced from Dine-in', 1, '2025-11-15 03:40:03', '2025-11-15 03:40:03', NULL),
(14, 4, 1244.32, 'order-9', NULL, NULL, NULL, '2025-11-14', 'Auto-synced from Dine-in', 1, '2025-11-16 01:49:59', '2025-11-16 01:49:59', NULL),
(15, 4, 468.16, 'order-10', NULL, NULL, NULL, '2025-11-14', 'Auto-synced from Dine-in', 1, '2025-11-16 01:49:59', '2025-11-16 01:49:59', NULL),
(16, 4, 717.02, 'order-11', NULL, NULL, NULL, '2025-11-14', 'Auto-synced from Dine-in', 1, '2025-11-16 01:50:00', '2025-11-16 01:50:00', NULL),
(17, 4, 973.28, 'order-13', NULL, NULL, NULL, '2025-11-14', 'Auto-synced from Dine-in', 1, '2025-11-16 01:50:00', '2025-11-16 01:50:00', NULL),
(18, 4, 2503.42, 'order-41', NULL, NULL, NULL, '2025-11-15', 'Auto-synced from Dine-in', 1, '2025-11-16 01:50:01', '2025-11-16 01:50:01', NULL),
(19, 4, 68345.20, 'order-42', NULL, NULL, NULL, '2025-11-15', 'Auto-synced from Dine-in', 1, '2025-11-16 01:50:01', '2025-11-16 01:50:01', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `revenue_trends`
--

CREATE TABLE `revenue_trends` (
  `trend_id` int NOT NULL,
  `revenue_id` int DEFAULT NULL,
  `date` date NOT NULL,
  `total_revenue` decimal(12,2) NOT NULL,
  `period_type` enum('daily','weekly','monthly','yearly') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `staff_id` int NOT NULL,
  `first_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `last_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `role` enum('admin','waiter','cashier') COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `shift_schedule` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`staff_id`, `first_name`, `last_name`, `email`, `password`, `role`, `created_at`, `shift_schedule`) VALUES
(2, 'Wena', 'Cutie', 'wena123@gmail.com', '$2a$10$Mjh7DnsCAw5vL88cMpGS7ubGbkC.6zuqP2nZEFBJT6IFJI1UgP6Mm', 'admin', '2025-10-28 02:31:40', NULL),
(4, 'Nico', 'Robin', 'robin123@gmail.com', '$2a$10$N/vBRaRs6lpUjSnmb1ekZuZwKmwM8HfpwawSsTJAYgnuAUKye8cTS', 'cashier', '2025-11-01 15:57:00', NULL),
(5, 'vincent', 'torio', 'vincent@example.com', '$2a$10$e0moOTJ0aDFYDea9s27YTu4Uttw9KIX1sa/5N3OF..ukpCRTTjQMi', 'admin', '2025-11-02 16:40:08', NULL),
(6, 'kurt', 'mateo', 'kurt@example.com', '$2a$10$qChqvUv/NIJp3S6X4WbE3.LiCj/hH1ekBTPLPlEHDDKeybqYqhHt2', 'waiter', '2025-11-02 16:53:10', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_client_users`
--

CREATE TABLE `tbl_client_users` (
  `client_id` int NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) NOT NULL,
  `extension_name` varchar(10) DEFAULT NULL,
  `nationality` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_archived` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tbl_client_users`
--

INSERT INTO `tbl_client_users` (`client_id`, `first_name`, `middle_name`, `last_name`, `extension_name`, `nationality`, `password`, `email`, `phone`, `created_at`, `is_archived`) VALUES
(1, 'gelo', 'm', 'kambe', NULL, 'Filipino', '$2y$10$bWuC3VDn/oqRjjM.gtxW1OUMjUoVb.UtI5X7eIMtY7zH4WXJWSNbO', 'cambe.angelos@gmail.com', '09984663089', '2025-10-23 06:44:41', 0),
(2, 'cambe', 'cambe', 'cambe', NULL, 'Filipino', '$2y$10$jALZfdMpL36veYa1L1nzeeJ1kitTHiSOFQ/mNKq5JpAECnJnbkYM2', 'cambe.angelo.12162003@gmail.com', '0998785', '2025-10-26 16:01:07', 0),
(8, 'gelo', 'gelo', 'gelo', NULL, 'Filipino', '$2b$10$X203pWbOLW6YOW.1Qo911OZwmrGjs6GuQsmWbPVKBPQGp0mQWBieO', 'blazecambe56@gmail.com', '09984663089', '2025-11-06 18:03:48', 0),
(9, 'Marxsu Elisu', NULL, 'Suarez', NULL, 'Filipino', '$2a$12$UJUiPxQVyO86Az8a/cMsGeDEzTFxeYDn9S.sM4qcEDKY1n5Lpb/FW', 'marxsuelisu12@gmail.com', NULL, '2025-11-11 05:38:32', 0),
(10, 'Vincent', NULL, 'Torio', NULL, 'Filipino', '$2a$10$155aqkaR1zQUvhd13d9JCeiaFQNT0nO1GwpYs/RBpUsODcHyWkugq', 'vincent@example.com', '9489299132', '2025-11-11 08:20:07', 0),
(11, 'John', NULL, 'Muslim', NULL, 'Filipino', '$2a$10$/iVole5wPtCJXQfR5ek98.Xh1SC3YURiyUL95nZdJJ.dIluhcCzki', 'John@example.com', '09239273182', '2025-11-11 08:22:41', 0),
(12, 'Randell', NULL, 'Coton', NULL, 'Filipino', '$2a$10$Zb937VvUPt3dsNhD/Xu5nucS1sPj/DOFzh4hObX8B8pon58buA8sy', 'Randell@example.com', '093212382132', '2025-11-11 08:25:48', 0),
(13, 'Jeff', NULL, 'Torio', NULL, 'Filipino', '$2a$10$IPqmfJ3peNUy/UYFW/D5..r7/eHbHCv.fNazFFIP1NknM0AwcCFra', 'jeff@example.com', '09239273182', '2025-11-11 10:28:34', 0),
(14, 'wena', NULL, 'bryant', NULL, 'Filipino', '$2a$10$ogzmsmF0sY3vCcVLTAroCuNNfXS5GsDOCBC4Ri8SJ6TsZaeZ8n2am', 'wena123@gmail.com', NULL, '2025-11-12 04:21:38', 0),
(15, 'Test', NULL, 'customer', NULL, 'Filipino', '$2a$10$8LiDi8HLekDZ/P8tLK6BwefbQRDrIN3UJwNkhpD8sWBmIv/sqDFtG', 'customer@example.com', '09239273182', '2025-11-13 04:08:09', 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_feedbacks`
--

CREATE TABLE `tbl_feedbacks` (
  `feedback_id` int NOT NULL,
  `customer_name` varchar(100) NOT NULL,
  `customer_email` varchar(100) NOT NULL,
  `room_no` varchar(20) NOT NULL,
  `room_type` varchar(50) NOT NULL,
  `overall_emoji_rating` enum('sad','neutral','happy') NOT NULL,
  `experience_text` text,
  `cleanliness_rating` int DEFAULT NULL,
  `comfort_rating` int DEFAULT NULL,
  `staff_rating` int DEFAULT NULL,
  `service_rating` int DEFAULT NULL,
  `amenities_rating` int DEFAULT NULL,
  `food_rating` int DEFAULT NULL,
  `has_complaint` enum('Yes','No') DEFAULT 'No',
  `complaint_type` varchar(50) DEFAULT NULL,
  `complaint_details` text,
  `submitted_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ;

--
-- Dumping data for table `tbl_feedbacks`
--

INSERT INTO `tbl_feedbacks` (`feedback_id`, `customer_name`, `customer_email`, `room_no`, `room_type`, `overall_emoji_rating`, `experience_text`, `cleanliness_rating`, `comfort_rating`, `staff_rating`, `service_rating`, `amenities_rating`, `food_rating`, `has_complaint`, `complaint_type`, `complaint_details`, `submitted_at`) VALUES
(1, 'emman', 'emman@gmail.com', '123', 'Deluxe', 'happy', 'malopit ser', 5, 5, 5, 5, 5, NULL, 'Yes', 'Comfort', 'ang bango ser', '2025-11-12 18:31:33'),
(2, 'Emmanuel', 'Monkey@gmail.com', '321', 'Deluxe', 'happy', 'wow di mapanghe', 5, 5, 5, 5, 5, NULL, 'Yes', 'Comfort', 'wwow di mapanghe\n', '2025-11-13 14:58:38'),
(3, 'Emman', 'frias@gmail.com', '098', 'Deluxe', 'neutral', 'galing lopit', 5, 5, 5, 5, 5, NULL, 'Yes', 'Noise', 'ingay ya', '2025-11-13 17:59:25'),
(4, 'matoy', 'mathew@gmail.com', '203', 'Deluxe', 'happy', 'what ano daw mapanghe', 4, 4, 4, 4, 4, NULL, 'Yes', 'Food', 'what sobrang panghe', '2025-11-14 06:12:20'),
(5, 'lizzy', 'lizzy@gmail.com', '5432', ' Suite', 'sad', 'waaah ano dawwww', 4, 3, 2, 5, 5, NULL, 'Yes', 'Wifi', 'wat bakit ginanon yon', '2025-11-21 18:09:38');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_password_resets`
--

CREATE TABLE `tbl_password_resets` (
  `email` varchar(255) NOT NULL,
  `code` varchar(10) NOT NULL,
  `expires_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tbl_password_resets`
--

INSERT INTO `tbl_password_resets` (`email`, `code`, `expires_at`) VALUES
('marxsuelisu12@gmail.com', '825014', '2025-11-16 08:49:49');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_payments`
--

CREATE TABLE `tbl_payments` (
  `payment_id` int NOT NULL,
  `reservation_id` int NOT NULL,
  `method_id` int DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `reference_number` varchar(100) DEFAULT NULL,
  `status` enum('Completed','Refunded') DEFAULT 'Completed',
  `is_archived` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tbl_payments`
--

INSERT INTO `tbl_payments` (`payment_id`, `reservation_id`, `method_id`, `amount`, `payment_date`, `reference_number`, `status`, `is_archived`) VALUES
(1, 1, 1, 7000.00, '2025-10-24 00:24:38', 'REF-20251023-001', 'Completed', 0),
(3, 2, 1, 5000.00, '2025-11-06 20:27:40', 'REF123456', 'Completed', 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_payment_methods`
--

CREATE TABLE `tbl_payment_methods` (
  `method_id` int NOT NULL,
  `method_name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tbl_payment_methods`
--

INSERT INTO `tbl_payment_methods` (`method_id`, `method_name`, `description`, `is_active`) VALUES
(1, 'Credit Card', 'Visa/Mastercard accepted', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_reservations`
--

CREATE TABLE `tbl_reservations` (
  `reservation_id` int NOT NULL,
  `client_id` int NOT NULL,
  `num_adults` int DEFAULT '1',
  `num_children` int DEFAULT '0',
  `special_requests` text,
  `check_in` date NOT NULL,
  `check_out` date NOT NULL,
  `status` enum('Pending','Confirmed','Checked_In','Checked_Out','Cancelled','Approved','Declined','Completed') DEFAULT 'Pending',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_archived` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tbl_reservations`
--

INSERT INTO `tbl_reservations` (`reservation_id`, `client_id`, `num_adults`, `num_children`, `special_requests`, `check_in`, `check_out`, `status`, `created_at`, `is_archived`) VALUES
(1, 1, 2, 1, 'Need extra pillows and late checkout', '2025-10-25', '2025-10-27', 'Approved', '2025-10-23 16:24:19', 0),
(2, 2, 3, 2, '', '2025-11-20', '2025-11-22', 'Approved', '2025-11-03 17:50:43', 0),
(3, 2, 1, 0, '', '2025-11-09', '2025-11-15', 'Cancelled', '2025-11-06 12:00:31', 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_reservation_rooms`
--

CREATE TABLE `tbl_reservation_rooms` (
  `reservation_id` int NOT NULL,
  `room_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tbl_reservation_rooms`
--

INSERT INTO `tbl_reservation_rooms` (`reservation_id`, `room_id`) VALUES
(1, 1),
(2, 1),
(2, 3),
(3, 6),
(3, 7);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_rooms`
--

CREATE TABLE `tbl_rooms` (
  `room_id` int NOT NULL,
  `room_num` int NOT NULL,
  `floor_num` int DEFAULT NULL,
  `room_name` varchar(225) NOT NULL,
  `room_type` varchar(50) DEFAULT NULL,
  `capacity` int NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `description` varchar(800) DEFAULT '',
  `status` enum('Available','Occupied','Reserved','Unavailable') DEFAULT 'Available',
  `image_url` mediumblob,
  `is_archived` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tbl_rooms`
--

INSERT INTO `tbl_rooms` (`room_id`, `room_num`, `floor_num`, `room_name`, `room_type`, `capacity`, `price`, `description`, `status`, `image_url`, `is_archived`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES
(1, 101, 4, 'Charlotte', 'Room', 5, 100.00, '“Stylishly furnished room featuring plush bedding, sleek décor, and panoramic city views — perfect for business or leisure.”', 'Reserved', 0x687474703a2f2f6c6f63616c686f73743a353030302f75706c6f6164732f726f6f6d2d313736313939323431363936302d3434323933383938392e77656270, 0, '2025-10-23 14:46:02', NULL, '2025-11-06 16:01:00', NULL),
(3, 102, 4, 'bahay kubo', 'Room', 4, 100.00, NULL, 'Reserved', 0x52494646201d00005745425056503820141d00003077009d012ae200b4003e9d40994a25a3a2292cb41d41201389636cf3581a0575baab3ebbf6da657c0303cf505fdbfd2eba4af3aeeeccfad8ef547f92f5e6bfe4d42f0ffcbe7c4a68d729f6ff3b9fe1781bc023d99c07b6cbd053da1fb67fd0f515fc6f377f9aff43af39f7affa1ec09fcfffbfffd9f690ff4fc93fec9fee3d853f62bd39bd927ee67ffff757fdb07303ab6c978ebdba05bdf922b9532d7aea4d2526cde76baaca0a531f3ef4dd68ae376b6be891ac2727bf380dfff3dd5bf6da278025b74ae7e0f2facc436f46230efde6bfa55eeeef759f9afecb579391ef680b703487581c198d0d707f5dddef98f6863fabca890411c562ccd59b707b91a6dcb9bee5fbf6e79635f9b3b4bc121f8c7869c6f3d3510e023723d5893438955d3d4ebf8033b7472af1c52f244702561f5a4ad236b4d8c60266c7241a09bb5dfc8786dd0cbd77d0fa6ac9d1de589cffadcb16cd8d659f289529a539f30e9bf074e7e12b59d631fd347e20779a96ecea7ed233a07dff7b4e3b0c1a6692d37854ab4b69db5d4e26cf8b97e43da47768bab16d390e815f85ce67be150fa847259cf9204f6491a76e74469f6f4ada07314319171eb5259f0ea5450ed1a65dd92961d52e6b0a17f3abcbca8359ae39979fe8c4ba3071a3077e5db1451f96cba719dc3f0a226dd430e78df7ee2656d5439da7fea065f06c27ea8cc12b97d75c7aeedb192abbeb29f7e3d21b30ac03dd2d43398738253993bcefb9d6aa8d08690b2945a38da6e2da015ea35a35a40de6779a7f66ae46a82f3a36cf49084e21e70feef4304e4c168c29e5afc48dd8ff8b5627efee404eb2156c429467fae6a4a1f7412fb0505ebf557f8897af6c9536db43ce2186d0355912ddd9927b46438f3ed2686c600d5b8bcc0190a839af1636f6718dc811473b4e9e58d45e4b48c9b4b4e71d66005500395d9b9027d3e844c763695ecc5ca7c1931ce2644ecc806664ea30aa00cbac7c0c66d08fd4ab783691f6ea7042daa0f3ca37968c3e240221c100b3ad89db8a638a5581de837474de8d631686b144a5876112034325934a7e9fefb2d7371701fdf8c9f66db9759bac00e072873c49b14e7266021e0fe25effe9e634a1d38cc5804eb0f37ff79825559a78641034625243aaeb0198514dcff5406b1533df9f8191e6c8a16e28b409af218ae6759bf884dbae96aa71c149d5c08042bb3184d1671c85d07851d69cd9dc17c57dbca82aeceec08e9e267b67d18d930ccb3394eb93220bd8e6ba2f7e1448cb4dab5ce9893b65936181333132ef984db43a3497daf8d538e46ba74fb7d75780d9cbb29697bc2c73e9a8a0f4296d031e0f3f2b846ec000fefa0afcf7a61087a7596da19a9330a7edb485fa763901f527af0eb286614101d02bd4bffc1958c79357877b0726c42c5cab1253e28ca267f927e524785cc7d8d16be13e30d6ae7cf222cf8c8b9c6b738bbe24fbddfb3eeeab69937a0ea76dea83c331e9878afa24e6d8486b8371abad959059e2ba0c0518f5b2d95fc6e683084756924328ff8da999cc65fac1634aa666f72ec9c54c042a05d9e16ee77de5f73ccb6ae04787830c47240239edd6d3a464a13f0d1278aaec9022516b46f1bcc89472201abd45e7c716e7a5e094f4566ce8ab5023b445120273f885a47b1a64d162dae5d762cf3d70054ecbd6152ea6f58f2b5d77eeeccd6a96f90f059502af9bb10a50b486c012f273a952340eda97f14b8ee661c067cf83649d26e1349b9d0bfc7c5d6aff18ec9cf397f87ffa2d7ab3cf0a8297368873125efbe65fda800c86ca845d671f7ad2d73af3f6e7bbcb291cb44c3f20c1faa248153b3253ff0360e1c06861b63666a093fd08d5ee9b5381787ef8f5b83b4527b1c6547e70a401a49119f83ac2f2fd429e7ae87b1229ac1f535509d6fe3c48b86955ceb38ead04914717a3088b8aa6ce426ee2f362f5a943fb89bac4b6cb16b08e5f7c5e06a19360cdbea11f77ff1f606f8828f1a1e3120c24bdb98b5c0e31d14fab0bdd4f6437f619119f3fe3c5452bbb33d72f50329a16f4972b568a52884566851f1bcce80636acbdbe2699f2d0d5705b448f8e8a593cca42bb1fb88e68e3ef118ad958c7934bee2cae06d0d90cbd6b8570c6c3e843c7531b6241d1d4ade73c0ced9380a3b925d4a27c2bfe739bf4e02d4a2f7516e016bfccde5797318fffc453da2737c9574b972c2723273b50f732833e22f0b1d65381f3b45e4e65df9fa833386f8c7304bc086f5293c80aec52fabc0892e490a2ec2563edf8bfdc1a14eff05670a7b838207d356cee5f1cea775efe0f48b3e24332da668427b71ba53e2214fa7347e57961e8e7d724f3e7d3bc317ff00d9fd108c7c1b6f2b1110c06bf815dfae09b011a0c797e1a0e88210aefc5517e0bfae0c60026255ccb90158d1927a6bc76811ff2eb3cc35a695991eb39ae0ce270867813b9b4f36a758a71d6737cd8c117c327ba56095e4ce0f42fcb9ee071a70e4e939f799b064aece9aeaa4bc660366f257d9332a352da4e42dd083aa5ef348476787b18c72954aaa39bd893cf65f4b190ab8ef19c598a20c3701f9a22da3453204b08c02583a197a98877b14a71305a5b93e54e4d6c0d21eeb92080787d4ac7e68c1bde2f4c1f5becc210b74eb9943024888b28b543c21fae4d306f63d169a925332bb15ff6b5faa96e259b8fb20f5eb1fe2e6fd10d89eea0e31ce28951731b2c1d9bcdf655616f6d4d4e4b3f1a6cfd1c1ed8387600250d7607789edcd85dbff8ffa53e3c3249982b0e6ff0aca8f66eb47f43ff6ff75a971f269cd1f15869dcd021cb1aab1108263609bbeea2a799151b275abab20dfe3fb9391d5268940921481eafc9de26cdbc9e5a201e99386aee77014d5cdac9f358880a355bcfa6ceea4b13d87457779a5acf6b838b49a07e8a0ca3efa96df344002031aaec33c583b44d5a5a459cf1de006572d7d22721d7de702a449653819d9f6c8852ea53e52a0999b3661b97ab4be7ea2e99cfbf7b750d5e5eb4711dcd5a682e36a789976f910e3642cd6f58745583ffe95200a6728564beb302898b690dfc25b814f0b80d6ac158a03e8f7b506d02ba7422d4bc02e316b3357ab9ac46048c1f8dd40afa2c6c9f2eace407dda288303e2611cddf49f14d86241364a7b34659eac4f6190e0e45dd848100e3cdcafcf5d9a3a0f8995520730907ea5a262b97b9b500df5dc81229a93dde6b3300ef109f5e9cce0690a1c030b8f985298cd7e0e95b41d16f1cfd7e883633c8da2725d11947537b6dd964ec36e87970c43931fbeb0f4fb35e114c5417345ee58d4a4d27f090e86f6762302d651477d00df39c5192c077522809bfa2077913f141e401a8f6c70677ff8e550f591696c32b332664418391e56fa42d514d169d648599f026f04fd98284e1a3f9130c086bb0a654a888deb15c9c4bac98e6d5ac6b6945c84f357951351e8ba3af24b6c4d390431f0ae44e26cbfa284f258b506241ae0a0a280ddafb4c9aedeaa6a9e454a5a6e73c9c1945e3e37b10cb69d5ea7453274e8e5a76c836f3c1813ec8f0edb3de792b1be3adcc82ac4728392290ce3c118c99cf73def5e9ca72adffdd418c686ca3d923ebdec1c4d758b23706a0ed7a653141860ec7a243cb4e96ddff890a3030682aac320fb2d1005f66473c7eee18d6dcc73e88145195a5432dc701fb788eb0d3d9263675961de1a5db38f0547b584ed9b07c5e2d97b4ef9d526c15633a1a020e30916932032d4e4458e0ca7479aaf11c5cc28168e97ca1ae3ae0eba92e20fdedc76a9efe8d3e567bdace72dad4e1698ef51c24c37503c6a40e5368b79db5fbde8e7a8a97e575fe78cc0c40eac1a16589acdff2bbb62a357250a3d10cc0ef20847695778f24535f91e7e59fbbb5f4e965e44db5b309cdb994fa3d31de639e233869ce5a59f6ec31f53ef732497fa4b329a945e0eeca85ab85bedb655e089ef228fb877ae35d9c84043c0744b22aa241a7a88cb3e130a67afe8c96e526df0ff14e0b8030476eca9ed83ff451bc962bed4193ee35c86385e4d11d7af231e9576627c8f4e654039aafa3607ece49b5dc29dbb8b478ff3fbaa88526ac7d993c2a418acc90096117fb9a92057aca192fdbb97d9cfea19976cee5273c3baafbddd92a9d7180e462e4aef7e99719d767e6fc244d7f2499f9428d5fe820868ff3f8ba0ebf8c8a1bc11ec24fb4550b4e2d6d3f26b3da677e294e99820b65eabefc4c625a3976ec70063edc3f3bccc9d6e35a38b8476a06cd067bfb3204a56238457b12d1eda9c7b7463a13ff1820aff7e20ea01d76bf10c86c709a660325637d9095e5b90d0d6b5333c719abc2ee9d32100cad02ead8d945827749513825056c8900ea227962e602bc1c736c226646aa53c386fbdaef0e8fe132becac4dc43cf1421c19cf1be4e261390f7ce333a30b877c5b1658c60716cf19450c88c4523bbf743b80979796a950827785199366fb8d5c7f0c0baaf87cb4d9d9fe6b8fafcd03855d94a2f6f812e93a367bf9f1294caefaae4df956561f0e161c3410578f3b8181629daa288fe04516b96cb5e4ed66d7ceab4c76ca8ccbfa70a4034ccb55a030d49822881082d6fd9301cbdfd66c99a871123175a87d1c8171b2556a73cfa6830eef0dbbf6ae8b38a6f7a872df1a9a85d58c7c475bfa9de394d0b0806bfd22d64693877ffeb7cfe7ffcd411ad4e06654aa4a6789b38a8a4585d81e5f6e000a2857657214273eec21e58204339691e10f1ed7cc8b91d9685e0d8c9e8f28495ddd71a287761158f1558d897f26b9b3274b8e14db0f502485b31dabf839af1778ff65315368a6bb7fa40f68313390117ee36eb4e3587056d975dab98691e17ed16e12e3f0a7f4479f7b282bc8976fc8593b33c42d8bee3290ae0c6d4f79173061256cae3efdedb8967d4b5be8ac4a7d97309ab7e7ed9ac0851f5ba94c9b8685500c458a3ace0f89c15bc3181c824898799cdf6bc0ce85eaa0529ed1b132bd14d47c2c5332c3a8a30e682a2e02b18b8992438c530dcd6ff7ef5921b848ef7d305bfa4614d0e65997c3edcf26ff2c9f3616196b03cf33f5d70d8725b5121970ff66e905e74115d9a4d46f2cb0de2c7361d39b5d03c98273cd5559a728262288c2db26092f63fc1204386eccef17a543113d7a32cb1e6bd7d74b2bf0b865b59d5bb8832413fefbbdc742c94504f666da640a5071c6a2523bf995da049caeedb8c96038ac81d1405bcf44916574ea6265a67eaa89724756e5de1b2bdc6ac8864c1b505885f20d2e3d135ee312b7fcc58c906eddfa7ac0de050c18e76d231640984175721da781d7dc4e3e6aa698925d0cb7a6635a88d90599ebae382ed3d0039bf440a7f1c63c831a3e93a8139b3f3db68333ced749c78528411a50d8a8a29561fece39c9f20eff6d01aaf4635f16eb9d0f509f85bf243c3eee34c3ce42b9b01c1c1800867ce9320b6f5eb137007906b5092b929a8326aeaa49f7a7155edc12afd9fc48bda6ec8ffe2596765939a301b262b826168c66809fa7bd2597e403c40fe17760bd2043c5ac6cee7c622b3f8de5a06667d8bfa6b79f467cef7bb861ea31c35fd02ca607660d0aa312871680cb2e6a530e2d77e997af3733c3423ee6a1888a07b83784a14389e583c3c9b0839f8b1c8de27d4730b012ae4ab6c528acf6ba55f587efb6de5a819dcdb3f0a198f0fbfb9d6b816f2b7d376d3cddedb3d227b3b4779b75efe006c4f8dfdb898771aec7785ebceb4b575323a6ca77cfe9acc5bd33b995d75417db7172a33328905353d233258cfaf8b087230bd31ac59cb1733cc40f67ed4228d3d3b9a35a786fc5f4e10e2ef2d9890f648f8031fb5c6193a37630be1fba5ef19b10df093c99be4dfa5936f80066a8240820334a89f64919315fc0abd87a77e79f27654ff9daa432e6496ddb2783c12d1abfa8d6657fbf39be68f3da7163c11af14bd596814082b7a04aae3473e8273dbf6fa8c1197b394ca7040740346f012b0c28e916b6497aaf5a63437770c7b847fc0bdf4c7c268b95d9f405192a3aee8336c651678b255a48c937a9323a72aefa82cd0b360219c4efb12d118ad5a13cec6e65f5f3df2700de8367073fcbaae9a220706064ec66422254c221bb2669cbb238a1f782f697148efe0c078afbba7f98052a3731e0f13cb330413a2347ae0e16e194bf6ca15e26279b587aa41d8889f63ab5cea8b62f9775b36a0b20410fd51234c22d8fc05619ad3a2528e5016384d7b3ba7fc54014b1ee973b6e9aa435161307b699541fd2a2562530e8bbe3f0dcd7446d47ee7621a6ab8f97f56286ade697c7e521e31903cf691e1e8d85540fee22cb71433c6db122a255f8a2f5715af0f3102cabb88d63a9e6ea71bf77aa0a8775bb98b31bbe7f02852db0a99e4d80961a4f41982b7a0deb13a75415ccff6a23c6192e1f698924330b037c71a0228e5d06cfeb8fbf3fe096daf33908afd31cf2a0a0b42478c146c0b65b4e4ada872392a872a7a33102d345f2f03d6362f5990e16dd00cddc6fb8a2a590f26e16ab5d192edcc398c05d1863db219c850622416d9863967aede53d8c8613b04eb2fcaa4e229402e4cfe6c5dd6cd097f128f91cde34052213fffff3aa18f0c915ee832fe4edd0f65a8ca90e879f376f8feb3d98e752b717e6d1eebc4056c93f76f9ce6a65710a1bc89f8db7833c45f3055ee2113f74b808c93a2dbd04cb145baef70075169a63f65f5b4e10627cfe46f251ecaf0320e7f1e666818bb0748bd28bf5e4093119dfc5f32486bc4253882f1aed4d1bb6f93bad974535d32331ced609028f1effeff563682e9821dc6d2e41a70b3fd254a9cfcfcddeeb69a51c3643f7e6e2707d317af835c4c253284a0311b7453ff0ed2e040b03ae926483b62511254bcf7d67ee172eaecd7b086c39d0b3fc4a18bea27d96fdfbf63ebaf0fd892ea5379f17282ed3a3e4ae7be730ab1f67bcb11103166f5d611ed2d3e689c813ee849952d830ebfdad6c9701e6634c8ec3788233825b963fcb64e71d2eee8f0a06d2f2f43cb5914c9f3de4e27efbcee48eaed78b4e55ad9385b7ae0c67efd8b69af5380beccd065e012dc8e1d2a0694f5f57d373ab0df9005c981fa89f2a3a557c0ee698b7d48316f6b89925d420129a9d2f123ddb68ec74c6b29299adcf2be4f649445e255cd3a0644fc8bdf13f2eb1ae0c0fc4f43e14dbf348ef45802c4c0a7a0ffb433d73b78e6624aa8802fb8f433f70d0504dde24a812b087d3c806b3c6d726b795011de730e682d061b67863ec04e446f30263fa868c9db5d6b05805b7af66146906af6dbc0ee4767e72ba5b06b72d7167e9fe61e66322b6fca8edbfa499d2323ee422894435c042dde171869d4cb12e9fad69bc885554852bd9463f5243756ed3a614bd1da13acb73473b11736899075346815b4001b4259ec889ed0ee3ee4be8749f5ff5173196cbf57c388d8f6ff73d61c48c71befc50a4a947726e6689962c9a8d111ba624579c21a9a99f9c545198884f6244f9a3af838e28f0dac37a04ecba2b6a06db3fc6db213d7adcd82e89527d2b2663ffb39d4091e05e27aec19b900bf450a1ba481b4dfa4f5111ab3078326b9332e9e758a6ca3f970415a3702bcb2143ac1294f7f46544866905ac894d502d0bb924cfbaaa49df008d9784ae1e021f78fad550a0c28094a1d330e08f3e40cb598eb3da041033a25d1b3a5252d623bc59ed90a0bf3cf560636fccb1ba5fef789a0ed6dbd5e67e90eba306f56a385e062df9c138fb3fb79753ea58e156dd40b8a02a779fc73f0947d5cfa9a96f8ddf4389f55697364438025a9ed78b83a76fe15088daf17371c5172af4e78a71322c6bf5e2bc4b63be7a16422b78bed3ff1be5a527e0851aeb211ed46655895bc931aee572bb79cb9550a94b78db48ff1c471b95452c372d07fb9aa24c36beedb8da6130218c3589ce3f7325501aeb0900a806d4f0d39b0e4a99ee6f440aac476bd0cb2105360ff7e95944b114d31518ec2d574f7dcdf0417ac0905206d85a6eb02fbefcd19b004df61e3e9b9dd41a73c8e56851fe8f9a3f9a7e815d06c2c3948acf65f48ef4e5a4e1755ffe8cf194567d2d6c3df1624148f6787180f9100c54e92bc709f3749bebe08050671d6b9705d255be046efa13b72cb04f2c3335e3b2e6f3b79759a7635b63d823d3ff9b24a7fddf81c10c59b09e80c80f083d345ae02fd6a9997f1253f72c95dbd20c4e43c5bf5e9aad8600521104821960f1a19b8eeb95ffc7e96770c21fb69d3bf460fa574dc58c31b184932a7dc63edbb311978ede49cd1a4a3d6215eda71f6c321828cd5b01704e03259adfcf62a4b5826f3e0791be7933bdd128d5637b63cba5abecd4590f00de9bafbbe99c10e58d1414621ff7668c1307777bd3824540791533e8249907d48bbf23a1a3ba817d269e81d761b89859a8d6d76beadd8aaefc64c98e2e332c9079971963345bb88ddc73ea9f668bcc47c50ac8d5d26cfdb9a71cdace33f2b63e5bd5cd5a7ff42fbb38aa7dc5bbac1b4fcad63698755aca2c4d097a7868cc5f758629a77646aba6a086d0ff05cc80ba7d9d5053d5bbcab104aa651fa47792e277b9183603f7916a53d3b6f91f123227ae9b40a1481ec78d3ec6a68ffd7a8ac90500ce77eb8c6b5fb2e04752ec0325871ecb165a29497d45f0de6180bdbc3eee9830fb8c0f07dc2099e97936fd2e1a42a2ca14c73d03024f9998c7fb8a33d891f177a1b21b2e521d3f7f4bd057c0a210f71074c972a5a35d673eb53cbcf0d5279cc183dcc40e4e9dec8ad717cdec3af1972fa997fdbd14db455885dfb25115346c8495f32fd6607060fbc0a60507d9a7f3e841994f01918c8e79633acb2158c83ec958255c41b0c3e0f4ed2e1b1e7f76b2c939550ad97e0755a60b964c0b0deb1c118bf9c228295849d2991343f1d780f469dc89e1f7542318de39e4a8a6151f63dcabbc42094a56b1b0399ca04660d33cbf42ba8dc1a50a0dfb877e5024e8370a5c54aff7a56f27bd4b7e8a0226e57f541d8ce5e6a9e9cb597b21be27183d1db0fd7bd35972ea2f3b233677dc27180563160ac20921191060e33ce279067db9f1b4960971405aaba23793c8deb7dd022c28c72275ef7a745900802461bbfadd60731a58f0ed32cc990fd6bc193b257ef98e9608a33056d38df9b0f5a11c016a9eb42e65397f86a6023753e1bb34cb14c794ae0216fd5ef5a6a8b58ad5f0e69ab98c8eed53210ed05ebcdde32b0c68674ce9e56d1abda3918617fba50a134b995149dbc1a5c371ac5a7208bd4ad7970f4322255c49d45ca722878e124637b4577efd8c0577c6f014e56ce0693c0d037ae89fa1d316fb69c51f759d0dc6ec0b37fae179edeaa8090cf6d977ea7e54ea3d18fed617e98ec94665bdd377c389cb34953e0586534f05d5dfdab6e26d8e197a4c64e6c24dc913fd6d6edbd3d2c0ecb02840b3679c15de6956b02f21d42665daa9964dd04c2af39649b3c83f20ea7d89c71112a49042d13be420baff01a03a9e5963af816ef02c36f37b4f20b2dc05509c02b989d3cf8ba071f41409547cc084be4498845336875a6c3b78bfa6a35d9cddb499dfbddfde5f63454178534bb8fbdcc7203a42fcb61cd98d62da8de982f9c3aa2b931d5f736e5a778a5e32fea1d2b6004458dd3cf086cfac25c3d784f21cd515338ed66899219509d747c44286eee938f50af54799a06b448ccefb3ef13b7654e361965953c96dad0c3733f7704ea4630f64f0031e4e34d6b7bf04624f1c7013c6b15740219242399e3a4535413165cced953c4fd460c6becaa4d550ec5bd9c8e5b966da6353024eb21188028659a029d6dbd6452578716187a2d910ae256f93ab073526bc3c392f7fd1441aee0b8d5b27e6eb643a6103c93da52cd55ad771d1ced9e39eb2a12993dc24cbe09ab0d6bd8e82741f18a4912d4d7db6536229de94fd451f50eef7c28c3f37876d27773b28ece351c4f73b57a0a980d8c4e3f79372af783fd4b637d653df02337c0939e3e661f96b6e33144b1f6af1700559bbaf71e29189cd66ba7657f9cdcd28568b98a59890e8f361b5517a879340da619447784441156e795467659a1a636ad48aa82c077cddbd7551071bfd2fab17bb799756d60d6e4e1f082ab52ca4d6f97774d97b68fa02494653c766a8709869d92ed56b5b106a72158804d97341f9e5000d0483ff5250723c89c394a2068ac98599f27cb98e8343ba5aaaa69151f23258ff8701f9a05496457563e43444deca3297ec3b08849e3db41504ca909ceb40611d50c875cd3e73cc1cdfc91ff1d253c13d27ff7dfa0a6ba26f672fb4c540f733c7200397801987163742e890bb05e8235813149931ede7cca9b6b84f523ac18803fbb7b7204006808665632f57cb4092140142a043ff193617dbf1676af16ef1182885d70542fc1242e78864cd47fec3ba2038da2c126bc4b7a0ead7541974602c78823f94ce0756e715bb88f009f578076329af5000000, 0, '2025-10-23 17:25:49', NULL, '2025-11-22 17:24:35', NULL),
(6, 103, 3, 'Sweet Homes', 'Deluxe', 8, 12000.00, ' modern amenities, and a stylish en-suite bathroom with a rainfall shower. Perfect for both business and leisure, this room includes a 50-inch TV, high-speed Wi-Fi, and a minibar for your convenience.', 'Available', 0x524946466619000057454250565038205a190000f06e009d012afe00b4003e9d489d4aa5a422a9a597cc013013896300ca3a80dddf58bdd9dcc8f8e371d719e5d8efd42ee2fe782bcaff4b0b60c6d26c83f13d77f0eff1fe06f650fecfc17f8eda847b53c19f7b26e7fb9fea29edffddffe0fdbb7c85fe5f9c9fd2ff99e5c5f1a3fbcffcff609fd2feb23fe97972fda3fdffb0b74a4f46efd803694b7b26d77065f98ddeeee264e3e6b75245ec42d272fdfb3742b63ec9c6583dbacc0a9d35f0facc9d5ecd6a9d0eb782fd3c274c3cf145671be818f12a07d38f30804dbb6a592501e03fbe65db349a008d76b9d189a9631b4d4c8082aefcf05798875cade964dd9bb09fa32768177c76be71ecc78272fb2b70f02c4ca0217125ac00255a071d00f5b783bb7d386be3f19284d487b6f5d95ea8fc8cb47b87a97d7479abc4853db690271a14c252b52724ee91bcd885637c35d76d239a446275054102357e04a1a2a535569a71e3a296d66f922262a756381f8997e01b08ed0aa16826812442ae21aa7866508272dcbe512d4da100163aea19997e2b79ee61b384864d125d6729dcc5f2f289118808b9f1be735fac2224804e84f1e224f15cbcc0c1c0e5315a8220d22216062f411d9b693640cb7f8ecc00be8a320953c9df4054a084b526b7fd35e2283dae6b05f53033367e4c6f341dc6565c1cbf81bff3b80ef6a98edfd543a625e628c6714a2c23b8aca8b291804e7ba58206b14ba243902e71db5b23a758cef221a6576d5539218e5100b794b7015d313b77b6a9aaa3e4a04ca7d5cd8758896f206f9442657a4be6906c5d2f22e3bda4fece4c391a01185a243f98039e6e56d2ce14ae97bb593a943b735860fb78c6093abfc64da7a432ae13132b5b9d342ba6f8ea63afe1e1f294c9d7948fce7ea27f2f5fda877d2c7f12524e1ab3de7ad5990bc6e142a0305307cc52a64053d72e6a3c4a918d97d33a91e9717133e4d68f60f3ce953a44f6c7d2f6194d8c57bf9c3313cec63f03baa730e8d14c0036593ccb59fc933167d0699a94be4bae695d0435aeb9f9c7092f546bbc9544d6bbf5d56d5d436cc13d0bd5b2b8bebc7a948eeb12450c2873a6cd851affb0338366b765368e15414b9f01c72d120f8b679cb85bb7733defac23fb0e92659961bc8eea34fe2bd7c97fa721b043e7f0ee77705eccfccb53b6314ec88eb2f8b30402a10a56af3203a7b4e11b1e5bb7e16cee283f3ae73730611caf2d9cc2f81fbdcbd7b26f73953a24c96f3ef2b38e22b5867846cca5cc2000fef02524b5bfaa448ca79c0155e2ab7dd57ed03f5de0d905ce323fbff142e7e36af5f0554429a0c2aba2c077b4db9580401690cf1606c1f9b300f4338617a45a672b792174dbd06c71557b95e51efea4facec156b13d99db1af3a2b44d03a942278194870cb351541f8778d2c6ccad6a4ae8d1cf02f801fec5fac5f0680e05dd13a565f85ca0272d608e34f9a8abd8b8c476145db6dbcda72af5a7b43f8bcbf30b21f23559d59e142dbf8b5960537af7a7b7b918172dd7fde7a270c4cfecf2b1f146ffc5ccd85254fbf8a4817b05a4738ee5c8b251fc11b5b8d8cb8cc20912c732a0c843166a7852fe727dd4af836d5715a942736cd7cc6d29833e77fc942db125365c8e646822dd0de7a268c8ebf543ff4c395b2089cd6197c5e2fffb788626258215364045d337b660fdd884dd7ed1523af35da9dbc33e3c5c226077c8445d604731b112bbbdb9d7a1a19c0a7d4e5946a14076a6b1880d36b29ed71f74441cf338c2a45b098396a9e1018008f21eb0c803008c21639827e4715eeafd18dcb7abd8942fc686230a551731bc01a61b4b77260a7e890c049adcdde2317f7150ed38b69665bb3198acac38e21e88699d39a733a5ddfde1f716e87020101d81cbcc90a811eb7f7d23a407f5420126e54e2a70c7db881ef63ab7f4d3ece8f207887d595303edef4ac7ba5643950f07f8b27ab40d9b984c8ac34c77511b86bee992e00c8cd809a35202327eabbe5c991119a4848185d5b2a80e4a081ea22af2ee1872ebc2c79eb0ce62d293c10ad3c020ae93d3be6d38c4c8e89ea49fa485c43952d24ff0735438a16a1f59e92eaf073b58d42b11d0a30eb3afd5d6c06f11cdae6c09d4fcb0455dfc1f9f6f05a9cb7109dc2465671a2322055a8611fee82b15b35df619a035d7c2ba72b8d80341f133413f0586cb35251864bc716b83d64eb1da4cb89a13e916fc506cf07864582e081a3e327aa4b0b8e1823fa73f094ffce4acaf83d522f39f6e95639a172c3ccb0af9cde530a7203db12d97ed5a74e3d5af68cd8f402a4c01032ea23054c70f96964d65e99794246d9ef10c14fdf949334d8e047a6f1f4186d0300dabf2099553143778a889694770b0ab5332ca4ab1ee390b76ed5409a3f20b0fb906878b06a98e60c01649516c81cd047c2eba003a4393ac7a40ecbc56050de0f5e14316f6ef29707f9688a429c1cc63785ddbf5f4580914870db1a3e8d56150b6bb9fa0a51667eb4beec0c0486e08059547b181167452e33e350131510a9d2709ce5d90711c79525d68d9c987afb7d0e356d48f71a85191651b045ce00685f6a680f4e6bcadd85ba99455eef3547725ed6b16bccdafb9b38a1e3c8621b364b712aa77c4455541f090696a9afcb7e5dc643458c64d13b7b94d61783ef320b99d80e035ce6927318803291a8a06333481f69f7983ed580acd9dc24ebbcbeb2408dcff00ef0f1fd777a7e6a2992e769ed5a2679badf0c897b3f66406af9be65ed91c8654c6eca21d3ee8bc7a8e3d90bffce5d10e46e9d5a895db171ed9d32437d466ef1ebb6b2f1a5ec246dc9ef9107e3f77d2ba43ec0d966c97d4e0947a6817a66c738d66de87f3870686af7ae1ac554965407ac823424486c2556bef4a2689b81340d739aed6f180c053f6f80284cc9f3fa805544cf885460a278b1c4bd480b68511da863a064a1defef78dbcc619ede57fa26e33072c2df3c157359beacb908a730a9c335c88ebaacc22a3a3abac92c7d6bd778649b66c5d2e66a11f563b965025acccf2a3ef4f3478c8db49fb9757a74f5291bc154dbdc4f79f6ed0f4f1331d24d4f6b9ebdaa1cc854259d4d6bd16ecb749b360166b9d62c38a8d86ec338f512e565c14372bb23893a61197141a07434c35e7f0e6402f5f70993f6336a252a1d97db5f7a066a4be4dd8f69743d08c7c87526f3d376a674dc94fef02e18222ca601c526ba59433ccb81f82c6eef68c2aa5907161699e7df45b1f56ae372e2b7d5dfd6ceb48704aa5607b0fdeaf6436e170e5588fd554e632dc89a77e08b517998440ec9a32de94f1c919886ac348228eeaa8fc7bf8351b4c45c5db94ad19a8a30c9bcde2aeb98eb7b3ffc953a6aeabbbc93ac2c572ce3ee91f4b0a3aca8a6c438718c9c7f0cfd2694fe522211f89742b53e7ec4bc7a0e590c3c7b8c06b5d40b348580a95571011a0c930d681f38f2c171db05127c781bb8a20d8c1029aa82b4789845ef375c696a1939d61507e526e50aebec88e4ad3bfaa81b26fb3f6fc08fffa1913209543d98aae2888de2f301e4b8981cbd0859dfdb92af42ee7f823dda8c8a30a2edf4bbb9bdc15e14af2f75ab82004dcade2491f661a1a18b80fa68dc0e0cddce9fc5a8e585b75e909d4588c1a40a97983f0bbe113b52ee885fc260e3512dd616ac1dc5c4ab80106cbb63b80ac6e7fb9d69acc38a68ed4fb6d90c8cc3bf9529c18cdd4ca2bc4f233372225e8e09f3489ffea88f3c9d5587162b5851e0bf37dbfcd843667c716fdd781a8a5d2eaf63bf9a4e119c72313fb92b9c59d3f1fc40bba1030a6375c20cf711fa2ab37b9ad5e8cf6e217a6e6a00a36acb07c497015ca093f76c5fb718c87fafade2a9251b6a4743c55363175b130292a96b1ecbd5a3759ad727648711cc2602150f6046ba486f4040298256d3609dbd09de3bf1ef0036f021b3550b4537ac09e00faf03793f00ab80b04e900ef434e2414cc4ffb0347e9b053ad7068c7b8066c8498720087bb5117488fe8e5aa5613d271fb69b8004a7dd595116ce788de866279ac2028e32624019de10c5eb75db061e864fb3cf9e2e770c607e5ca875d1e2932a07a547845b7aa14c96a99233f7790cd8a0d0be34048a89d32c0eaaa5118b82ad773033da22a26d92a40a74400bc48161629464f42018300c2b1129ebb2082ab6406e328a79b3fdd11e882fdb81a8a9974c7ebc08ba00a2aef7ce1ae7532830189c78e77775a4424ed43d4d3baf11f763dd2011db109d4bcf31e7a5b78c363403c5f910f4dbaa56cb9417d234e582bf21a9c2011dcc1c1f0fb785fb48a3f7d8828aca4057a58789c24e3e02385198e0084094c4c6908ea95e52087fcb761ed2dc8370fb48a167fd81f1bc57620d255e8c20d81312d9a7b1b04e1d8c499f1b79db63d86388c4a78ff7ad0bcdcb6e7dc759ad20ad622be44a87375cf22b5e2f51ad49455659287711001f2bce0bcb04de8d7aabfa1e52d036f6a435618ddd8c8fd36615fd648447622a679d2a3d0409d9a4ee94f0fd8652b5f914ab298c96aecb8a32a1c3db99bcf0492602cc6b82a9145f91350f64ea63b6ba68b972d71b9b2202ea0265b80c25f9e7234d2c20f7ed8c4b6012485fbbb44155e4b73dad1c19229723bf209a1ea71b9aa0b0c854a9a2df5639da17fb50faf1f1a151817310d0bec4ffa1a91dff27670009cec0401559d37d83fe805720952888502a36900229297c2af2e0ba8e3a42df6f50be493709fc1f044d2eb51b51462e76229cbda1cb8d6a5a4858ce0cf0415e646c9e1461cf957ee07b758d880e2b9848ab33872a3a868208d1c612774e74396d9f97e176e1fa6d7ae44c831f26711d82e47b51d9171738f54c0a9d87066bb4a766551d9da6b3498b25d78ed7166c1e7b0d10ba81a271713856893ef467a7c01c4b9bdcff6f58bd81b66eca3b93b0d59d595f2d109797a86df69408688201affd5b1ccbe6e652b6a07ffdaf37e6247b3e7677acef846f5c2befb58734aff389fa0ebb490de30e1c4c0972ed88e9537de0a295d171ca77193857e478fc914876e167762424cf6d240329ea857a43cffc31d7a16f2997467b4cc6a9b6b06c4845f7a66eec770821e329d47b79c4641b856375d181d7ddb9924a9dc19b6a42c1c4b2e5e96e5e6d3b4baebfecc5cb1381436f2de741aeec8c16740c665de4495005626862c56f15757ef60b7d74b40feaffcb1dfb043ce3a0043e85a934788bf393e64f164a12ad3848f0d3e1cdcf47d478625953f931191cd8a37159d717f2359b492bafa577ce9d353a17de9651bc8222eac7f7419f097c25491ff8a5ac6e60f97fb0f38cfbc028f6a92c8b2f33782f457b2fb8cb4985bc3a827da2614d26ef88cdd62b3b98449e811dcfcfc59d1525b0c59e495345bfec3f03c1eae2a580fb1c8c2c70a58a3ad3335b75716c7b8223a7bad5966acc2b04102d1fbce089b39110d7d34539c9bec7f9230d50d1a99193e2a17697f3bea060c7a151e5c1e230068d1cb07b95b563f9efafb2bf05199598c12836f51e885857bf76a974f59b6a62595ac76de3827a82599caa0b3ca2493be27f5db9a4244028e4f03570a8f51ce42771b6466d27fb9bc0649689b29a0a02b9b3baa90b4e04e7795a51af41cba785a88bf97e079b6f9fe5bab70b2151296ff895059312add6975e314f81e062986efa670b17465f03637b2585b476e7a630174d14d33cc8dff0d0674626a2ff6b4bdca9ced4a958f800deab337e0bbd04398903200ad71225258c1161f7ce882b542aaa7e9b92d5b6c6af86d0c1821acadf683dcb3519cce9e5d14ddb83598d4bd143568ccb915132a739bf5377c650fee82ad7012f8003de10d210bb5703b9bf24928e203917955c24164e0889dd8e186eca381025863c9ce09e4b13621299fd91b8687755a11df25633e66b7ebe41b1dae3613ba032bb8a6604ebeae3d4d08d4f106511fc1cc5c7d024d8189c9c791606f6414c7635ed1f562ac8a4ae64dfaafec1a54fd2462fe4ad6dfc3eb2318189ca4ab0cdb1996cfc6eafead9242a0c6475f1715c5730644d1e5e1c724a50c118be8692f45217a2759479b98d434d2822d4d205b3074e16eefb5353bdeda9c294986f9f3841df3e9bf45a37ebbdd73189136dc33be314dac1813f0342d585af0810ed29447f17d0e71efcd3aa5e95573cfe80461c2351d7d8844b07b6db2dbb544f2b11881c32035cbdf83f63dae08502c81a9465af6f0ba0f1895af1047289e7aa70971f8cab1b14ee2930813f9ddd3962bed6f84a3eec330f4ff9918bbc602f6ddbc2108ddecc5a057d9be637fac496a694b8c8aba31f31216fc374a6200fd0f68e57cd03d8b0672039cebd1a25b9a4e2039d85c96ccef4debe1776de9b13eb66b9eb500cc30ba1d7f33a02029590a1eec597c1bfe54aa375d884c22f2b6c41d5d335843d167a11d289021fad17fddf3d6d358b5738988d52b76d82c5137d05f69c98906bd5ba09e3decbc43fcf369818be4918cb76243f9bbf7ddb4e1888529815e1ce6a7159569072b263dc840e87bca97f4a49dc18e8e543ff5e1468c6be88ef2308b696dd65eab377fb18a62a68ed3b260cae69c9b5c35abf0512e9f325f16b6ab4dfa2f90d36e11ee5e88bc3f0f7d3da197c9b416783e8688bf55ac822d4a7449daa34d7adf9fc1c6dc3af9fda500562e188a75dfa565245151c20205b316901a9a9c894bbfed6f69f22f5cb0a31580fefa7f8ef751ec25f24501e305f75b66bac75a38d53a271e459c65173d1a447258b8bba1e72be88b09f07653ad28fd40d9b18a0d9762b4284d355f8a1c53e3f1c345544c6edf8b38a69ef7113aed9cb0c95327afb22583504d73810f0abec2b8176256c9cb50e1e01b91c09495917e0ca614e3a96f762480820889e7fe540dc086713c041c9891feacb47f7b03a893ac9718fc86957b0054e08b8a0c45bebea8c18d5936c71b4b7f45ab1202639b33bbf8ae6a96cb4fe03a0a35186f6c223d5c297ec5c102e820e08e3653ca493c14c2e1695d61c54cd9bb3a85d94940003864ff4bc237d1ab856ec4f5f559713adff4adc94b01728fec4891381cccb3ffadf160973577195a8b93c0707132f5fd9ddc491c7d9c15d4dee9968ce9128dd9f8ae85a4397a3ca5de177a8e820c4520c4f170b233e61c88a39ee88a691a9d3b23f8f946ae8168a30be6efd1ba9830c9cd2528d09a58eeff84ef2bcc67cb9a1a1c26fdf622fd815da8f87743295ffd56abef41afe672abd0baf5a1de5ab45eaf76df9ae757e24512fca256553e4e98ade63d24f1cd35eb4f95265d57ecb653be673239f4d9989c57fce42bcbbb54d128978fcf8f02fef24f38beffc04f7dc6885d947698df2a6c68c46d0c5a3aa22a0444242630b3b503ce05111d4a3fc58ce2131fb98399b8808e72c5e866bed8c3be2c0d1017ef6717c58a54161586c84c49d270bca3fdc796793e9cacb43761408a77d5cc3f2bac1714617040d15bb0f81307066ea65bcd3c444294700c61692ddbe234101c3c8ceccc03a85dcfa0962b000bd87e8d09a28d6554a2f9518b7a2db7d8311ad4d1f6a5fdb4ef615c8438ea49a1589edd087fabdcbe54e80eecc471082e177f2a6b1068969251fb3422cf4e7c265d9747201df505e6da4d161c906825210eac2352b6d9e2a4314e2d6f00a94512f60825e77922bb64049092676704ca444257e8291940260a61c3312584b26117e0bb4c02457b483d2ba90cf8ac8f18477471248c42f7ed4597b5e59266b80bad240e33da765861cc776adf8c014adca54a33e84bd1e43e604509606a98785b0588a2c073379cfa5ded7c71f89ce91899a878f3a10590dd6f5c476becb771c30aec25589fba333c71c440d25e4e01614bd66e3e5f03b0d37bf894993f59eb5180c50dc78dd318bae3663cc57d4aa1ac90e438a08827f011634f8595c1efc182bd81abccebecc1bb73c480d5b743de62da9b7024b9332543f5ee06018a3ef69cdd52c811fd4094c153c15b76fb032b376f4991368900a0933a5ce7638cc87a5140f22aa26b9e32604aaa33fbc1bc46fc4918fa8d6eaeb0214d26e55a979abc8acfc8cdfc66f669a52bd7c98191450012dc6eaa9c6d16b24b85b0c4a7b97b1bff2c7139a3114855abbc88af3c60a742123a6ee549bf96a206a9a1787e046f382e5034721ceb2d48ed7867db6fdc8ea2623ed652630f7e0f454020c67860d04b2f20087140d572d505ee13cf9dd38cfad18110dba68ab2efa3b0471c1f37c6665308b204cfae2866f5ac338987b196ab30ab3a791ba954cec20af9c29e1ce9f84c8f9d82345944cf92878f01114cd24bba1a64c58f67ab8957bfc559e1dc6b72445cf8e8fde022655eb018f0f5dd00915a161a773e36e4d7f4c19ad890b6ddc15a8d2a37b7eb2614b55ca13bf67159a9bfbf0cdd1c01f42b4e6672a0e1f4220137a6c6620381e08bb616dcac0a05a3046482143c88fa71ff8d690db1ed1ab4f390e0ee85d39f1ceda337e4d5ce1215d49e83685595868420063c723aa035b4c1c817f5853f2d2b808207a9ffa78b5f0d63d08d2f057e6d2a89da4e2078b3e78996d03be3f9ced7447b329bc401074000bfc1bed7d41e014c1b7645d23d72c4415b6b288c05572e729a9c7af93d3b4174907d2ef8b046a59d54394b08fcfca85c5d68fba9f49aa6c5b0fbf22f37ac97184008ec9a5c4d5842b63ee66929021c339675883e4fdf48c50b21372e55f011fea16821bbaf8bf9dbd69957cd5140e366c463e9c20cfacbefb589fef767cabb43758d89a76cb9026a6012daffceeaa2bd388d8b8d58765bf43a73d38f9690ed1a964820c7bf125cbb91ba7318dde4947fe3530dab3850fb245d2a86c70a69b7ff471a50d52d090829a3ce14da64026f8ae42241a72d2874c623bc527412eed0d4f2888c9b556d629d4d727a31a422ff924ec97e629b12c57d3ea992df0e123841ba7718651d51eaa88f548f5a866da6aa62b76f12780c01cfefcfad0562a59c0450364e8c1ba5843c02a5973af0891c0f26e46e351c3122e3caa0246f11a3b597cda2813e8a3d09ba3629d4925c58c1c8a2276a78bf7e5d06316cb8f34da0e0c5321986aee335c8f09e41f47961b3fd82f936fd5e77a4a2b3a899a966931da06f024ebe8e47850ccc84ab122a2000000, 0, '2025-11-01 10:21:06', NULL, '2025-11-22 17:24:16', NULL),
(7, 104, 4, 'Ocean View', 'Suite', 10, 15000.00, 'King bed with walk-in shower and floor-to-ceiling windows. Best available rate with complimentary amenities.\r\n\r\nBest Available Rate — Amenities include:\r\nHigh-speed wireless internet\r\nMinibar snacks and soft drinks\r\nNespresso or tea presentations on request\r\nPacking/unpacking services', 'Available', 0x52494646ac1600005745425056503820a0160000f070009d012afc00b4003e9d469c4b25a3ac2a2534ace98013896506f81b6eee857a6d0f24db4e396359af745db13157f21e0a765aff1fc3be010ff3e60fa0be13f839fd4726d78ab7e07a24bfd8f2c1fb57fc4f619f2e2f643fbc3ecd1fb7879f5dd12c84b9233901f5e0abc4e5d502d1658baef1fa0bdf08178ac4d6763b8e7f65d37323b1de8d25f9f35ac34ff05b712e99f368b632aea3250680c482fd5c4dc83c64bd32b6c61a798e219b53bf00154cde30e18bcb5653a67dbceaba2fadbc25f645b59c8a2ea9059465ca79fb632f6e5f1ee086d1c83e55d44d1a2d013d352c0fd130b9088dff8fc9c055dd71f9e2e5f887ef38eb24a0620d490d51478da2d15f1a6a27010f880c1d6a5ae348112b50c7beaf082c83453c8d342be4d1190d16f3ed512cdbbc3a08c24fcad6d462b1e0a73b2f26e6da4b7e3d6a143ee210e1e1d9d9a9d5cbc5ad9af5b5f2fa09c0b39b8edf3dfc122e27744d58c7d32313091a510240432185803a2b5f54cea981d41abba2c08f44bebc39294007d0823c3cc6f4e9d6e0d38e68c1f72b80a02e57fed617657e9823c7b01e63ae19d11a1fc37286c5100097a32544f1ebe3b248b3cca9e0a4d2058361a4fb0fcee67b5561b5fc477e769152292715da12687dffaee0f143f1b60b5002180cf04cdc82d8da8e118f2df81f8aa8fef6a32f57c633e461ff55d72c213da72e58bafe07810293504c963c57e3db1ce49daa7ee14a1c3e655a10a7468aa1350431cd439bbc786a4032ab576416eb6a5f7351b1b178ec58a57a293130f1099a9a7735ccec63139b3f71f338c386e9e41c930316fd94fc2cadb5c5a1b6933c63542a46bbee3f1861125cba7083558966966658d59caa268bd99b987812cb0b0a549e9ed2838b2482a6d48f0198ea2b744ad01052e0c31946e5e49efe653e56fb0336015d807a99d3ffe11ac8fd990afa81c9da6b5de807a3575a43d7b05fa12729133ecdaae912d41b31e416be42854983edd1d8c51cd30b86bda12c0e5b5bc62ae3a6d507e01208e26a828948acf80c110a59051ef27e94165c7721e9c5a3f44c99e3598402e726e65b23798ee37d869a95db895a4168b4c530e3537097daf0ab85945a71a465954b833bc123a839a33d638626bab047e7ef8aebc8aaa47ab5cb101ea86a77785843c16d8de93c336a73c1dca06246301af5c203d31f020a3fa144b3ba25197db7b169fc7b31e67de346a4013e6491008e64f123afed8185933bc832108d6198951540eb136629dd85e5aea7280e9b630800fef958295e16021707a4aab54159897f102a5dced2e099dbd00aa0ce0ce032a7422d332eff795085050d31851135a1e7d2d38e1eadb9296015e026641e1d359674f93a789463801d23d33498f0d1f263462dff11b12c4713dedc461660924870c295bcb85e2bd140aa7d2d37834681c7283c078f481eea329c449cf041dbdb3ebe2091efa9fa2a1bb464443349cfa6326164d5c00048972ff6905433d2b2d7fb47814baaab72e05f15f4e3069dc1ea999d9385456bd6674165376765335c10eec0f3944b03592c0f8a6d9269ae5185a83c58aa6f87031faa4404f05d76e836221f1f668aaa00448ae967e9d4c4bb51c088e40a71635e4ea06c64aade3d378b40aadf4e011b8ad40cf94fa779d4240cc35f2fbf557d54e27301161c795fe36b763be92a7879df37812a24467afec1062eb773342078c021f015a4e908c7839ceb9c732991b6356985474409a5f82f1c1151a709cdb32ef3829e9aa4a5290245c7530c97cefd849f2b49473e1eeef83afcc3f7bd24f91e928dbe8b8ff6e7df92095fe7f56f5a56e51cc64321b69a5169e16647932b472028a0567e4d816404801e5681743fe7d53f507782efd8de46e7d29282849b54ced4537b58bea8587680f8902018732789083840eaa80331bf359cbfedc82e39a12f5e38bcc30ec979f968ca25ead500ac6f799668935e23592f6ab51cbfc8fe0c1ec5fcd40a4204c6f4904f9d7db2f0642a541052cabf4dde87996cb6e29b640d9884b24a953df0335db594ffed5eb476d7b64ccbb6accf8819cefaa7eaac104a2a37b5b29d832f95217927265ea71d41355a49e7f9a898bad40980a7f799856cc6de0c646c36911363ef6548701112a02704ee36d1ee5cb41fdad5da68dc3409611bb44c0c596d0aedb28c2ce315aa24feeb4c523f6c2a4a6653f2e6698e588c6d9b78dffcea6918297b00caa20a706b2d19f2c1472f64b4547cecf4c9847ecbf1f90c8fe47304cb21ce0ea47b64dda3c463fe784b2f010d371278c25c1f45813d27e997bb114f5485cc70d390f3980a6b8320ce3a237e93447e3969779b187bcfebbb963a3ce2bbc1d6c4c71c0cc7ffec64aeba89d3ec09b1ab19703dcf94aac13a567e34e93c8d492e30522cedfd5b96ce8384eb5c9bc407366996afa1383c7d0ce3430541b57b74719ac8d9c6aa5d3079ce3d20a467c600ae6477f9e0bffd986ea45d3558fe09b6c1c5603c8db7c5fca27eae64e73f3626059f41221f8f3502baabe439012438a23c408863939e263ce594c053257270613236b578b9fbf4233c126960aeee9c9597aef19c142e072d8e1dd071750ee30d6550a277a06a82e817391304866b865757226ca910153da0e9f10beb9a64ca1f7a3c3c4accbd5955949ad0d1a54341ea8de497eb2b226ebc2fd5b477d16bee47129ec52c122382bcdb7e6463d5505bcd276c14573e3fc3639b39b5226047f3c1531108c08896b203630d2f73fb40f0f287c5af8dadf96a271f64bdc6e8b8c010637995d6e9236ff98d37f2e58e0e34e5b03f4f44546ea30a5e6b57bb89a8734cc135a80917884cddca40b0b53602e83bcc961daf80bd9351de4a522c132ff970d5df774f8a987c03a3177174e809a6dc447effe2dde412327ab0567d83e2115bf88f226d8c0efbf832dbbd728e1b510c93eb7fb9b1ff06fb5a315bc1a99eab00d6ac5bb45bc005ce0c2a9210ea86575f05922fb34f9e3a1746b8ac1c1c7644c8caeff8d4dacb58f3fd0a36bc939ea3608d0c922667b5d6189b03b5f2277f12dc5578dfea9ce6c8ec07cbeec48ea291bdd0bd977e5ba8ed30436dfd42b2c31f7ad833962e125977bde22f87deb6319ee42f998fd3705088061320c71d0feead06ea32a11a120b4be68f6bd32a0d4a4d97e14d6c06a4a3dc0fb6179592c1afaab5e2544cf3ff2062c434374c30af53e0ead4567aa068bd501d1b088f92ad127e16cac987b88c7cf19ca985cb2f800e71c1da6aebc2de40b12e83b56c9c53b5bd7e13eea258b101da4bd38112f0da8ff11d1931e6f8f51718efcdbe6b897c7f92f5fb157ed0861eb2c70c854f1dffb1304371c456135410b89b67e8de3f290c2edc3a07266b15f6d64692e92f8df9d008ad28dbc3340e66a2f8b8d7d179f92b9f70446f13456002f9a477b2d39f9c65abf0c987f2d388585acdc6a0ee35294c4ae1e55d72ef3aa2b0a4a99b43212e0f3d6073c0574a12a784e26ee4bf5b1b8c15ad815601efe261076ea64495f67f94c531ad22f2a9a1bb2a17e777b56603b098e9e174d4cdcb51f7bcf609fc19ac2a5734a726d6ccb6f9bb97ff3562b1323bb150cb0844f5a4021ea76ccbc41bce83dff5e5378df5298b55ed970f6fe812dff977da017cf161f25a16915ae36f6c9f98097705c1f20f65ab645b73951b786048c0c527984d81b637f400a2010de1ae7736bc4fbb0e58e9408960d798d356415e55c85e4027013cacb5bc78487595b4bb3c8d85d548a4147e1579f901603df25ec7c0f2885c9a0964a4f5a585059212d5b6b1da12403ba2331afaa2d9e7e714f9e765e875af5084dfcf11cb88185a0c3c7625aace2faaa47e25658685e179362df28a1cdf84910ffb41e83b0185189ea99998e2fc517fd0c9a67aa9ce84f94e1ae04cc370f2bd94a40ab8cde1c9513c25b8b42448e427cd0cb53b1a4d24828d9a1827210e5d705aabc5eb5cd8bc2ea1df903583480425c33812104718b2b0d8de884a90f89ba9f9eef32888e30194dea4654ee949b98973073747c20bb948762202b724f35a2d1e349df3aac0a686a82e99cc97be930bb78e9bd3806ae91a384369da8c787c5bb5a4739c168fb728464b6f1f7601d41f88cf74da2b8b2c9dfbfeb1f2eb9c67826c34abd172c5b33c6134f6cf7cedb15b1e99f08ea73a96d4c5d2fc469f580f3b588ebe87e7858567952e1e1f9d6ec940cf4d28bb4cee90527edf997f5f5ffa259ebaec89eb53130c3b8d42bc28aa66803fa14a26615006025ba2e4364f1cd96be88db002bda503aeb4d2b04349b3fb770ffc16bd11b68a8d09755a4251d6e3216cdd553d96e134c550b5a1f8b6e96520810f073cee894567ff3b56cc4f15eed2e5190acc7af2e0d3aa78199d15f6affd55b9c7a8416ff4cd4fe46569d15d9d927934e96162051b94a4dd90c366899324c3c773b39104a232872d8fe22c934532606cb5773c8bf874535d7d893b2df832b0c1e0c81380845e1ce911b5643ba92014ff488ff33ca0535df52ed1f3e5aed7938ea581f7cc265e6d5fbc834a0721704b4a41346d899f8d8cae56b86e99866460b7d8ea2af131b8ab1a09cbfbbe57ad3e8ce82b08675de69691d17f315e59069d9307ed50047a10c86c7ab74c9d49673333693ffeac543e8346db2e8b6c00d3293b8bff96c3e22be34a81ad9f58cefd24871ab714e6758b2a5d1fecedd0d9f6a83df23ecbe9f46641f9e1b364be392e196bc7864e2c5c7556461baafdb8dbda6bbdaaa9a77f5595324d628a2698ddce0c5710f01b0abc6b8cfac91783c07e13d319be3c00378460ddebd9d2f83e85c72b1f31c2283852bd7a7235532e9111e4257ef9e9df9e438f2175a4c728d574612176b29a1acd522d7f8ad2340176d0e77ae16dbb320e765beb8ec65959fd8e1c4da86a9072937e1a83f3bf3fe513672ed0ac8542b1f035acd30b39fe927a9b8cf37ddf0a1363f215f5f56b5bd947dfcdbf950f974efe5f45a3ecea370b769801267b88c13e7f4143966eef5fff2ae6196a9a290d828aea2a48694d4909bf646ed53edd8ecc064653a876b31f9549901ead00563e15ab524bd7b6a62c7d6c63a8d9b34f9e276068110f82264f824e9ed7b84b7c7fb734cb93780ce7c4eec1d8b147a61b7d87c3fcb6e26773dbbc796589f606726fc9df67a468c8485de3172e34485f7dae162821498802551a8c849a0110294b5b1242da55ad49fc03908967448c443b1b8e02e2d6a52411fbf6e30f4d9e749e15856e9f041fe285db8f6ca968eb53ab6810ac88c28355cb1c894ad206b3ca0ccce451957abe0abbaf07a0e3e4011679dff923eb062f37c0f61382a199231ee0c6c4fa8194bbae0e8fc3c635996884bc2d069de7dada81fbcc05e412cc6bc02ec3f01adddeaf9562bdfa5bbdf950c413b7103533fe533b544c398b0965ef123763d05874d0149dab713d7d1b171e4a3ed0c2a331c2a51301e6dbd6b83353f92bc7c5847c7b0077f0153d19510ceb063a5920afa84f4a25829e6d4510358298ae708ecf93f4b69eca1a7804db45e57002e04d0b08aeeaa194845183471f8b671471ac28f6566536d42f8a90bb594962c40ee013f06bac164754c5740b12be278d38df2dd74c0fa7d0a5382d4c29c69cc48c58fcb4c5f67b5123ab8b38b690075ea8b99316127a11b02c3cdb261f455a08caf8baf4dccc0ecfee9b253472742ebd24e39b6df6cd45e16a92fe5a3f2c76ce0801e62d62db81fad3fe2810c6be301712e55fe6cf1e07542e946565c05d92f4eccbde020621fb84633618f072eca581cca8a44b033e64ebf2d896d4e1182b965eb70b08015f517a0447bbaa6b8663bce13d62ab9023cccacc9b8e65deba3f623bbc52e16e80fb56eedf8d36a30deaa6f0666ef28b6587f5c154e7307f825af034f5e758bd9e5ef5dcc5abdcef5dc27a88dc6c0e38f398b66a8b2bf5bdeb6524b194db99ebee3e2e801b2e615443362457724d44f38d9c76611fdf46dcad06eb07f25ec3e6e54198479f62048ffec8d6da93ea5fda68bdcfc491d481f9efa26375a2ee662730b0874956c91e7752fce356d6a92fbdcab0a530718ec62a3107b586cc519f70c8e0419c0765faabf9fdbeaceb96581c131e4cf9457ccf4f9a97949d29ae31ed8e326b64e8a783a2216011db9aa9509e158a7aa22acdf9a0c885524e2c7f38c3dc2e565160ac8d73df8816d28e5a2d6daec63d6fda517564c8ae7417bc8d4ac81b486bf4bcd2c6ebd03ea708028e727d45b23c2afed92b3edd4114b341ef9be86f7e9742b83904f26a88f6f06b85c53de6a8e36db644723cf758dcfb19f4f37b662ecaa65bc0cec5e207124d2cdc687c9ddad11d9ea0756c81e2f3db9bf194c44e3a9d0c4013314bc9317056e656e9123cebf4f8ae3808d9f90fe1dd29f73f2cef302dba04d5684a922f7a5d7fa1d66c512d8463c81e5d65ccc8d7e7402bbf0c2d8a175476e55f9ade05e78f8349311313b000bcdcd04482cc2d4a74365c5a32b57f749d13a2dc3c3ef658ac22bf2ab9b21aa151b43c4c43ce837f23e23544c7bfc1030aeaf1854b6f61d28d86d5b1c924ac0afc505247badb64d059e3f9494937749bff51a0b7ba4f5c8d27a22905d109c94e8428f34bbfa6ccdfdc409b281f12af67cbb19b2cef3bacb093781e902f9cf9bab3da810bda1b3b8ea64fabca1ad91948fdb66163f54400a2a9e6d775cd41099f4f720e561f0ce6b21c53515dc904a104e5afce650a3b4325ca0ae9ca823aea938adcc894f9d3f008415d942433f2c67df96b3ca05caeb7e48f1865996f4ce03631b63aec0d1d06b7083cde40f5686f4ba5f883dbc8ae50fc9d3c5c0ebc97d23e76adbb1372555df604125e0816a7ae4d9a5542737f186431415b396ef7fbbd009a8fa9252b754adf76b8cb140f87e9fb821c7d7c97effa4ff577c058958a74624435edb185903da1d70cf92c796c4b42165ceca82de246302499de55cc1624d9081290d66c3c31444ef1f1a4f85aa02a7796547aacdec09dcfeeb3d7105bf6f00d3a4becd10f9512d06d475d047d8b95bdc481f53b676a856a87b31db138b4af551db2cf07a63ca79ba82e9ff50f138762f8438ee80a74144a11345121ea0dad3ad9af2e18ce72fef4d735b507b7b17019e8117c1c7c77c481cb1ed9bb5327a77a08a43046f2c5ffa625fb89c7e707cc00d8753f7f7facef2231222107e7b70c81e58e4bf90a2569362488f89eecc9e776a8144c79322f4c896a1507fd15995ff86dbd0162c84c9861b82d4e829c8235c5cd399951ce99051a3c950f00c2487f66f839234dfa2ac42299a0af19b4a1d801bae53324e9897a860d583fb924b4a56631041ead9beb827d7c9f1b3ccba3ba0772ad7ba87b9907279842348debd4e5269cba7bd4dee57247e4f13c3d2bffe2beb8f2832eba86a5a12da49cde3bab44ddff74a794ea67bf93e865b6668a8b2880be37fcbbfb2aeae132917e7b16d823c3c104bc06642c3aa3b9326b9fbb8483df3eec7d6e78e9862e3972928f7e51f85d89fd30addb11fbb387742278b3f7dbfdff383c2cf7d39b132b832d94d777ed653c93b94a474c7e7cf67f5b3b744bcc26a475cb9846cbed4d21892f8a75f6755c104d70bd50114a5e92dae98630c39f3c1953ec1e65aa043d13d6adc3f89e3ef1b42b83b21cbcd0266afef5121c3cb040cc9de53f5181e5c9738b7db48c04813f8287cbe005f9c0ec29e63491778a6531fc15ce6463f4a9b1ca25eee57cf21fcbf7950610d4b6231ba3dfd1d36de09e0917449c8241b562160ea73caa7026d5f855c4574f664fb04367adc4ed133340950da2656b0d58c93dc334ea1624e26ca40095b45849a075fc7d7b75477b608ec5259d78ea964b25dfbee2ce93f9e009f04c4bd57dbaf421a8f8039b53126ed767a841a5b5159d490dddc3ef367bc5118d50287b618c5e82e7b599a18c0eb8ba47dc2951bde4c3816c852e5f6d8468394b1dce54e37907fb48b8002064520ab8ddc550b1ab6622785ad1ac24a54fb154b829eb907b3821f6b5c392c1b5b8e55ba97fd270ddd46e28ab4e6e42605e898536c0629cfb434b6cbc01069e5b8d034107f407db809ecc2f69a78b72e189db6a0c617c57fed1545231e34d0ffde5000ceef5e02fc4672c0871604385f7a00000, 0, '2025-11-01 14:50:20', NULL, '2025-11-22 17:23:54', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_users`
--

CREATE TABLE `tbl_users` (
  `user_id` int NOT NULL,
  `employee_id` int DEFAULT NULL,
  `password` varchar(100) NOT NULL,
  `role` enum('Admin','Staff','Manager') DEFAULT 'Staff',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  `is_archived` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tbl_users`
--

INSERT INTO `tbl_users` (`user_id`, `employee_id`, `password`, `role`, `created_at`, `updated_at`, `created_by`, `updated_by`, `is_archived`) VALUES
(1, 1, '$2y$10$PeaRDIt7I9vvxb/Mqqf4OeAUFaTT.vcPsBo.MLpriG/O6qpBFCxVC', 'Admin', '2025-11-05 22:35:50', '2025-11-05 22:41:34', NULL, NULL, 0),
(2, 18, '$2b$10$iz6/.VZeIehQOmSHaMKZNunvgrGvBZ2dpteKN9ZSj3Aa6PhnIsT/a', 'Staff', '2025-11-05 22:58:19', '2025-11-05 22:58:19', 1, NULL, 0),
(3, 22, '$2a$12$UJUiPxQVyO86Az8a/cMsGeDEzTFxeYDn9S.sM4qcEDKY1n5Lpb/FW', 'Admin', '2025-11-11 05:38:30', '2025-11-11 05:38:30', NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tickets`
--

CREATE TABLE `tickets` (
  `ticket_id` int NOT NULL,
  `ticket_code` varchar(10) DEFAULT NULL,
  `user_id` int NOT NULL,
  `fixed_by` int DEFAULT NULL,
  `title` varchar(100) NOT NULL,
  `description` text,
  `status` enum('open','in_progress','resolved','closed') DEFAULT 'open',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL
) ;

--
-- Dumping data for table `tickets`
--

INSERT INTO `tickets` (`ticket_id`, `ticket_code`, `user_id`, `fixed_by`, `title`, `description`, `status`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES
(2, 'TIC-0002', 12, 3, 'Email access issue', 'Cannot access company email account', 'resolved', '2024-10-02 09:15:00', 12, '2025-11-11 05:42:06', NULL),
(4, 'TIC-0004', 4, 3, 'Password reset request', 'Forgot my system password', 'resolved', '2024-10-03 14:20:00', 4, '2025-11-11 05:42:06', NULL),
(5, 'TIC-0005', 13, NULL, 'Network connectivity', 'Slow internet connection at front desk', 'open', '2024-10-09 11:30:00', 13, '2025-11-11 05:42:06', NULL),
(7, 'TIC-0007', 7, NULL, 'Phone system issue', 'Extension not receiving calls', 'open', '2024-10-08 15:45:00', 7, '2025-11-11 05:42:06', NULL),
(9, 'TIC-0009', 1, NULL, 'boot issue', 'walang os yung pc ya', 'open', '2025-11-11 08:56:04', 1, '2025-11-11 08:56:04', NULL),
(11, 'TIC-0011', 40, NULL, 'Forgot Password Request (Employee): No username provided', 'Employee unknown user has forgotten their password.\n\nI forgot my password \n\nancog.christian.ihao@gmail.com', 'open', '2025-11-15 04:08:43', 40, '2025-11-15 04:08:43', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('employee','admin','supervisor','superadmin') DEFAULT 'employee',
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `password`, `role`, `is_active`, `created_at`, `updated_at`, `created_by`, `updated_by`) VALUES
(1, 'superadmin', '$2b$10$YQ/3hUlrmiMMYUV0kK9JeeR5wlUTncXxQTAbxpxTTmD1FUQzhuH/a', 'superadmin', 1, '2025-11-11 05:40:38', '2025-11-22 16:20:09', 1, 1),
(2, 'hradmin', '$2a$10$P4d0WRBcLHPwPHwM2ys60.8VkOpwnzAeMXmbTg1.tOLoMJUIKbNfG', 'admin', 1, '2025-11-11 05:40:41', '2025-11-11 05:40:41', 1, NULL),
(3, 'itadmin', '$2b$10$y.uhRU9Pj0xcLMxWjFwHtegG9ezTbEqFpTHnSjrCfh3HMoN4iFH76', 'admin', 1, '2025-11-11 05:40:47', '2025-11-18 11:07:57', 1, 3),
(4, 'frontdeskadmin', '$2a$10$P4d0WRBcLHPwPHwM2ys60.8VkOpwnzAeMXmbTg1.tOLoMJUIKbNfG', 'admin', 1, '2025-11-11 05:40:53', '2025-11-11 05:40:53', 1, NULL),
(5, 'hrsupervisor', '$2a$10$P4d0WRBcLHPwPHwM2ys60.8VkOpwnzAeMXmbTg1.tOLoMJUIKbNfG', 'supervisor', 1, '2025-11-11 05:40:59', '2025-11-11 05:40:59', 1, NULL),
(6, 'itsupervisor', '$2a$10$P4d0WRBcLHPwPHwM2ys60.8VkOpwnzAeMXmbTg1.tOLoMJUIKbNfG', 'supervisor', 1, '2025-11-11 05:41:06', '2025-11-11 05:41:06', 1, NULL),
(7, 'frontdesksupervisor', '$2a$10$P4d0WRBcLHPwPHwM2ys60.8VkOpwnzAeMXmbTg1.tOLoMJUIKbNfG', 'supervisor', 1, '2025-11-11 05:41:12', '2025-11-11 05:41:12', 1, NULL),
(12, 'receptionist1', '$2a$10$P4d0WRBcLHPwPHwM2ys60.8VkOpwnzAeMXmbTg1.tOLoMJUIKbNfG', 'employee', 1, '2025-11-11 05:41:34', '2025-11-11 05:41:34', 1, NULL),
(13, 'receptionist2', '$2a$10$P4d0WRBcLHPwPHwM2ys60.8VkOpwnzAeMXmbTg1.tOLoMJUIKbNfG', 'employee', 1, '2025-11-11 05:41:38', '2025-11-12 03:14:22', 1, 1),
(18, 'nicole', '$2b$10$1x3fpLTuRoAqgEc1oiEi/Oh2DqQujHc7m4gD8daxEYf5aO/8BWLXC', 'employee', 1, '2025-11-11 15:03:38', '2025-11-11 15:05:36', 1, 1),
(19, 'vincent', '$2b$10$9u6qVwQ9cRpp0HjGUM43IOkTOr10rAtVuFOgeRf00nJc8uCQTwN0u', 'employee', 1, '2025-11-11 15:31:18', '2025-11-11 18:10:27', 1, 1),
(21, 'gabriel', '$2b$10$bzUejioe35qIf2pRdcKPM.mlobWjC7sNqYik0nXT25QhiTh9EUqtC', 'employee', 1, '2025-11-11 17:25:45', '2025-11-12 03:07:18', 1, 1),
(22, 'lawrence', '$2b$10$mUxKGGp.5no6ZcyLpxTx1.cWTB.MqYgkQWWEr/aGngjafVKOnKEIi', 'admin', 1, '2025-11-11 17:57:10', '2025-11-11 18:16:53', 1, 1),
(23, 'emmanuel', '$2b$10$9cQJbh8PljN54y5gRd7vmuYNE3fDqgS49jr8mRvivBSVLmJhIZBxG', 'employee', 1, '2025-11-12 15:32:06', '2025-11-12 15:32:06', 1, NULL),
(27, 'shawn', '$2b$10$fxAP7JLjTO6khkJzpjQlBOzB9QJXAMA3Vxmx4GCw9QXnA/6CPa/ou', 'employee', 1, '2025-11-12 17:33:24', '2025-11-12 17:33:24', 1, NULL),
(29, 'ethan', '$2b$10$oQOD3mFB3O6FUbocJLbD/.gsKTveFSmnbLHwhk5mRn08bAwqqe9XS', 'employee', 1, '2025-11-13 02:47:36', '2025-11-13 02:47:36', 1, NULL),
(40, 'public_user', 'public_user', 'employee', 1, '2025-11-15 04:08:42', '2025-11-15 04:08:42', NULL, NULL),
(41, 'ezekiel893', '$2b$10$FW.8iYeibSRzQJft30UFbOvI.1bRJdfDP3xIz..wyCbS0UkyO6M0O', 'employee', 1, '2025-11-20 01:58:13', '2025-11-20 01:58:13', 1, NULL),
(42, 'sophia910', '$2b$10$O0LyWi.T19b9G21naegj4uZKsg7tCMQtvC88zoZWnX61vJSiBejX2', 'employee', 1, '2025-11-20 02:24:17', '2025-11-20 02:24:17', 1, NULL),
(43, 'genkei607', '$2b$10$pzR/k2FrQExc89idcko37eg33X6q1qaVQ3ZowoOt.evWbPsTcytE2', 'employee', 1, '2025-11-20 02:32:14', '2025-11-20 02:32:14', 1, NULL),
(44, 'hazel171', '$2b$10$d9ZzqpFV/GaTpvy9dqULmup.ebZAlWpYCyXFyaWFmlzejujEAYP2a', 'employee', 1, '2025-11-20 02:37:50', '2025-11-20 02:37:50', 1, NULL),
(45, 'theo565', '$2b$10$F5IBvYWwR6dx1CnIqyec6unPN7G1QPm2LnRLRPLXRd4GS0dL4TMvu', 'employee', 1, '2025-11-20 02:46:07', '2025-11-21 06:27:09', 1, 1),
(47, 'ryan878', '$2b$10$gRN3P8DxhzM3jhhF9xy27u/VpxaU5BkXJRBHy9tE3SnWhotivEvA2', 'employee', 1, '2025-11-20 04:44:49', '2025-11-20 05:08:03', 1, 1),
(48, 'Tkieara', '$2b$10$7DtNn5R3D/PcWxE13JrgTeRq9bFR7ApF6MfiXKv.RQ0OLCFYEgN.q', 'employee', 1, '2025-11-20 06:35:29', '2025-11-20 07:41:00', 1, 1),
(49, 'PacianoRiz', '$2b$10$AB3LPq/xR2fKq7fIh7N/c.Cy4CniovS7O7U9DNFRhzsDxvBANZbya', 'employee', 1, '2025-11-20 07:47:36', '2025-11-23 10:33:38', 1, 1),
(50, 'christian255', '$2b$10$UpMVx4kwL8DEu5D/K3xykujHh4QrW3UPYah620txJHkJMcRlL/7sC', 'employee', 1, '2025-11-20 16:30:15', '2025-11-20 16:30:15', 1, NULL),
(56, 'johnwilmer663', '$2b$10$LGNro75LYzcOZJ/gCj59XeGrCamY0VBA/up.XbDT4VoIHRFD.bl8i', 'employee', 1, '2025-11-21 06:46:44', '2025-11-23 11:08:29', 1, 1),
(57, 'angelo356', '$2b$10$ZLa04xTR9YC/Thb7tjuILuFzar3gVrVW13edRzpc5KOjpEocPb0uG', 'employee', 1, '2025-11-21 16:03:04', '2025-11-21 16:03:04', 1, NULL),
(60, 'aaron523', '$2b$10$goj2rCzqCA7XQw.ioASoA.teHnK.Q8Csg1AvRTAU1N8RyrwLm6h4C', 'employee', 1, '2025-11-21 16:53:45', '2025-11-22 06:27:49', 1, 1),
(61, 'marxelis915', '$2a$12$UJUiPxQVyO86Az8a/cMsGeDEzTFxeYDn9S.sM4qcEDKY1n5Lpb/FW', 'employee', 1, '2025-11-21 17:38:59', '2025-11-21 18:44:59', 1, 1),
(63, 'cristina270', '$2b$10$xewvrY.AoPYGlxdiNiIadOKEjf969WpHj0blJEHsay.mCFBX34N72', 'employee', 1, '2025-11-23 10:56:24', '2025-11-23 10:56:24', 1, NULL),
(64, 'dianne736', '$2b$10$XyuGTuXVtivYMoh9WA5vjeHSPWjtDXOOw2EajQLn9PVQfaK5Xy/SG', 'employee', 1, '2025-11-23 11:20:56', '2025-11-23 11:20:56', 1, NULL),
(65, 'vincejoseph916', '$2b$10$HSE1cvNaZG0vPBfHsE/UGesAMv717FOrqNtTpzHqYugSPyC/7oDNu', 'employee', 1, '2025-11-23 11:39:22', '2025-11-23 11:39:22', 1, NULL),
(66, 'arjay906', '$2b$10$qXfUxsXG/D4eijC6ZzZirOaDRIaISNf1NalZPDChNRiuczUMXB6NC', 'employee', 1, '2025-11-23 11:51:58', '2025-11-23 11:51:58', 1, NULL),
(70, 'christian710', '$2b$10$NmhQeAq3efru.Qnb4Hf4mO6pPLPQnH0HhptJ7YC../jq8HUjmgc5O', 'employee', 1, '2025-11-23 17:04:29', '2025-11-23 17:04:29', 1, NULL),
(72, 'christian959', '$2b$10$K.vpKsuUzX9Hj6eFM5WCeOJ0Z6/41mkJ3pYyd5wc03e0KDzfNBnci', 'employee', 1, '2025-11-23 17:30:10', '2025-11-23 17:30:10', 1, NULL),
(73, 'francrandell730', '$2b$10$NDwssmxl6N5IUxhsKLnLV.e5/zHueEtac7ngQHpe5/uDcJoD3T2yy', 'employee', 1, '2025-11-25 03:52:10', '2025-11-25 03:52:10', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_roles`
--

CREATE TABLE `user_roles` (
  `user_role_id` int NOT NULL,
  `user_id` int NOT NULL,
  `sub_role` enum('hr','it','front_desk') DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user_roles`
--

INSERT INTO `user_roles` (`user_role_id`, `user_id`, `sub_role`, `created_at`, `updated_at`, `created_by`, `updated_by`) VALUES
(1, 2, 'hr', '2025-11-11 05:40:45', '2025-11-11 05:40:45', 1, NULL),
(2, 3, 'it', '2025-11-11 05:40:51', '2025-11-18 06:54:28', 1, 3),
(4, 5, 'hr', '2025-11-11 05:41:04', '2025-11-11 05:41:04', 1, NULL),
(5, 6, 'it', '2025-11-11 05:41:10', '2025-11-11 05:41:10', 1, NULL),
(7, 22, 'hr', '2025-11-11 17:57:10', '2025-11-11 18:16:53', 1, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounting_users`
--
ALTER TABLE `accounting_users`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`attendance_id`),
  ADD UNIQUE KEY `attendance_code` (`attendance_code`),
  ADD KEY `employee_id` (`employee_id`);

--
-- Indexes for table `audit_log`
--
ALTER TABLE `audit_log`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `IDX_audit_users` (`users_id`),
  ADD KEY `IDX_audit_created` (`created_at`),
  ADD KEY `IDX_audit_action` (`action_type`);

--
-- Indexes for table `backup_history`
--
ALTER TABLE `backup_history`
  ADD PRIMARY KEY (`backup_id`),
  ADD KEY `IDX_backup_status` (`status`),
  ADD KEY `IDX_backup_created` (`created_at`),
  ADD KEY `IDX_backup_created_by` (`created_by`);

--
-- Indexes for table `backup_settings`
--
ALTER TABLE `backup_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `budget`
--
ALTER TABLE `budget`
  ADD PRIMARY KEY (`budget_id`),
  ADD KEY `fk_users_budget` (`user_id`);

--
-- Indexes for table `budget_category`
--
ALTER TABLE `budget_category`
  ADD PRIMARY KEY (`budget_category_id`),
  ADD KEY `fk_budget_id` (`budget_id`);

--
-- Indexes for table `budget_variance`
--
ALTER TABLE `budget_variance`
  ADD PRIMARY KEY (`budget_variance_id`),
  ADD KEY `idx_budget_category_id` (`budget_category_id`),
  ADD KEY `idx_budget_variance_budget` (`budget_id`),
  ADD KEY `FK_expenses_varience_id` (`expenses_id`);

--
-- Indexes for table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`client_id`);

--
-- Indexes for table `company_deductions`
--
ALTER TABLE `company_deductions`
  ADD PRIMARY KEY (`deduction_id`),
  ADD KEY `fk_company_deductions_employee` (`employee_id`),
  ADD KEY `fk_company_deductions_payroll_run` (`payroll_run_id`),
  ADD KEY `fk_company_deductions_leave` (`leave_id`);

--
-- Indexes for table `crm_users`
--
ALTER TABLE `crm_users`
  ADD PRIMARY KEY (`account_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`department_id`),
  ADD UNIQUE KEY `department_name` (`department_name`),
  ADD UNIQUE KEY `department_code` (`department_code`),
  ADD KEY `fk_dept_supervisor` (`supervisor_id`);

--
-- Indexes for table `dependants`
--
ALTER TABLE `dependants`
  ADD PRIMARY KEY (`dependant_id`),
  ADD UNIQUE KEY `dependant_code` (`dependant_code`),
  ADD KEY `employee_id` (`employee_id`);

--
-- Indexes for table `dependant_address`
--
ALTER TABLE `dependant_address`
  ADD PRIMARY KEY (`dependant_address_id`),
  ADD UNIQUE KEY `dependant_id` (`dependant_id`);

--
-- Indexes for table `dependant_contact`
--
ALTER TABLE `dependant_contact`
  ADD PRIMARY KEY (`dependant_contact_id`),
  ADD UNIQUE KEY `dependant_id` (`dependant_id`);

--
-- Indexes for table `dependant_email`
--
ALTER TABLE `dependant_email`
  ADD PRIMARY KEY (`dependant_email_id`),
  ADD UNIQUE KEY `dependant_id` (`dependant_id`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`employee_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`employee_id`),
  ADD UNIQUE KEY `employee_code` (`employee_code`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD UNIQUE KEY `fingerprint_id` (`fingerprint_id`),
  ADD KEY `position_id` (`position_id`),
  ADD KEY `department_id` (`department_id`),
  ADD KEY `supervisor_id` (`supervisor_id`);

--
-- Indexes for table `employee_addresses`
--
ALTER TABLE `employee_addresses`
  ADD PRIMARY KEY (`address_id`),
  ADD UNIQUE KEY `employee_id` (`employee_id`);

--
-- Indexes for table `employee_contact_numbers`
--
ALTER TABLE `employee_contact_numbers`
  ADD PRIMARY KEY (`contact_id`),
  ADD KEY `employee_id` (`employee_id`);

--
-- Indexes for table `employee_emails`
--
ALTER TABLE `employee_emails`
  ADD PRIMARY KEY (`email_id`),
  ADD KEY `employee_id` (`employee_id`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`expenses_id`),
  ADD KEY `fk_users_expenses` (`user_id`),
  ADD KEY `fk_budget_category_expenses` (`budget_category_id`),
  ADD KEY `fk_revenue_category_expenses` (`revenue_category_id`),
  ADD KEY `fk_budget_expenses_variance` (`budget_variance_id`);

--
-- Indexes for table `fb_categories`
--
ALTER TABLE `fb_categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `fb_ingredients`
--
ALTER TABLE `fb_ingredients`
  ADD PRIMARY KEY (`ingredient_id`);

--
-- Indexes for table `fb_inventory_logs`
--
ALTER TABLE `fb_inventory_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `ingredient_id` (`ingredient_id`),
  ADD KEY `staff_id` (`staff_id`);

--
-- Indexes for table `fb_menu_items`
--
ALTER TABLE `fb_menu_items`
  ADD PRIMARY KEY (`item_id`),
  ADD KEY `fk_menu_category` (`category_id`);

--
-- Indexes for table `fb_menu_item_ingredients`
--
ALTER TABLE `fb_menu_item_ingredients`
  ADD PRIMARY KEY (`recipe_id`),
  ADD KEY `menu_item_id` (`menu_item_id`),
  ADD KEY `ingredient_id` (`ingredient_id`);

--
-- Indexes for table `fb_notifications`
--
ALTER TABLE `fb_notifications`
  ADD PRIMARY KEY (`notification_id`),
  ADD KEY `idx_order_id` (`order_id`),
  ADD KEY `idx_client_id` (`client_id`);

--
-- Indexes for table `fb_orders`
--
ALTER TABLE `fb_orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `client_id` (`client_id`),
  ADD KEY `fk_order_employee` (`employee_id`);

--
-- Indexes for table `fb_order_details`
--
ALTER TABLE `fb_order_details`
  ADD PRIMARY KEY (`order_detail_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `item_id` (`item_id`);

--
-- Indexes for table `fb_payments`
--
ALTER TABLE `fb_payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `hotel_settings`
--
ALTER TABLE `hotel_settings`
  ADD PRIMARY KEY (`setting_id`);

--
-- Indexes for table `invoice`
--
ALTER TABLE `invoice`
  ADD PRIMARY KEY (`invoice_id`),
  ADD UNIQUE KEY `invoice_number` (`invoice_number`),
  ADD UNIQUE KEY `idx_invoice_number` (`invoice_number`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_guest_name` (`guest_name`),
  ADD KEY `idx_dates` (`check_in_date`,`check_out_date`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `invoice_activity`
--
ALTER TABLE `invoice_activity`
  ADD PRIMARY KEY (`activity_id`),
  ADD KEY `idx_invoice` (`invoice_id`),
  ADD KEY `idx_activity_type` (`activity_type`),
  ADD KEY `performed_by` (`performed_by`);

--
-- Indexes for table `invoice_item`
--
ALTER TABLE `invoice_item`
  ADD PRIMARY KEY (`item_id`),
  ADD KEY `idx_invoice` (`invoice_id`),
  ADD KEY `fk_category_id` (`revenue_category_id`);

--
-- Indexes for table `job_positions`
--
ALTER TABLE `job_positions`
  ADD PRIMARY KEY (`position_id`),
  ADD UNIQUE KEY `position_code` (`position_code`),
  ADD KEY `department_id` (`department_id`);

--
-- Indexes for table `leaves`
--
ALTER TABLE `leaves`
  ADD PRIMARY KEY (`leave_id`),
  ADD UNIQUE KEY `leave_code` (`leave_code`),
  ADD KEY `employee_id` (`employee_id`),
  ADD KEY `approved_by` (`approved_by`);

--
-- Indexes for table `manual_payment`
--
ALTER TABLE `manual_payment`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `idx_invoice` (`invoice_id`),
  ADD KEY `idx_payment_date` (`payment_date`),
  ADD KEY `processed_by` (`processed_by`);

--
-- Indexes for table `notification_settings`
--
ALTER TABLE `notification_settings`
  ADD PRIMARY KEY (`notification_id`),
  ADD UNIQUE KEY `UK_notification_users` (`users_id`),
  ADD KEY `IDX_notification_users` (`users_id`);

--
-- Indexes for table `password_reset_otps`
--
ALTER TABLE `password_reset_otps`
  ADD PRIMARY KEY (`otp_id`),
  ADD KEY `idx_user_purpose` (`user_id`,`purpose`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`token_id`),
  ADD KEY `idx_token_user` (`user_id`);

--
-- Indexes for table `payroll_run`
--
ALTER TABLE `payroll_run`
  ADD PRIMARY KEY (`payroll_run_id`),
  ADD UNIQUE KEY `payroll_start_date` (`payroll_start_date`),
  ADD UNIQUE KEY `payroll_end_date` (`payroll_end_date`);

--
-- Indexes for table `payroll_slip`
--
ALTER TABLE `payroll_slip`
  ADD PRIMARY KEY (`payroll_id`),
  ADD KEY `fk_users_payroll` (`user_id`),
  ADD KEY `fk_payroll_run` (`payroll_run_id`),
  ADD KEY `FK_payroll_slip_hotel_management.employees` (`employee_id`),
  ADD KEY `fk_company_deductions` (`company_deduction_id`);

--
-- Indexes for table `pms_housekeeping_logs`
--
ALTER TABLE `pms_housekeeping_logs`
  ADD PRIMARY KEY (`LogID`),
  ADD KEY `TaskID` (`TaskID`),
  ADD KEY `RoomID` (`RoomID`),
  ADD KEY `UserID` (`UserID`);

--
-- Indexes for table `pms_housekeeping_tasks`
--
ALTER TABLE `pms_housekeeping_tasks`
  ADD PRIMARY KEY (`TaskID`),
  ADD KEY `RoomID` (`RoomID`),
  ADD KEY `AssignedUserID` (`AssignedUserID`),
  ADD KEY `UserID` (`UserID`);

--
-- Indexes for table `pms_inventory`
--
ALTER TABLE `pms_inventory`
  ADD PRIMARY KEY (`ItemID`),
  ADD KEY `ItemCategoryID` (`ItemCategoryID`);

--
-- Indexes for table `pms_inventorylog`
--
ALTER TABLE `pms_inventorylog`
  ADD PRIMARY KEY (`InvLogID`),
  ADD KEY `UserID` (`UserID`),
  ADD KEY `ItemID` (`ItemID`);

--
-- Indexes for table `pms_itemcategory`
--
ALTER TABLE `pms_itemcategory`
  ADD PRIMARY KEY (`ItemCategoryID`);

--
-- Indexes for table `pms_maintenance_logs`
--
ALTER TABLE `pms_maintenance_logs`
  ADD PRIMARY KEY (`LogID`),
  ADD KEY `idx_request_id` (`RequestID`),
  ADD KEY `idx_room_id` (`RoomID`),
  ADD KEY `idx_user_id` (`UserID`);

--
-- Indexes for table `pms_maintenance_requests`
--
ALTER TABLE `pms_maintenance_requests`
  ADD PRIMARY KEY (`RequestID`),
  ADD KEY `FK_MaintRequest_Room` (`RoomID`),
  ADD KEY `FK_MaintRequest_User` (`UserID`),
  ADD KEY `FK_MaintRequest_AssignedUser` (`AssignedUserID`);

--
-- Indexes for table `pms_parkingarea`
--
ALTER TABLE `pms_parkingarea`
  ADD PRIMARY KEY (`AreaID`);

--
-- Indexes for table `pms_parkingslot`
--
ALTER TABLE `pms_parkingslot`
  ADD PRIMARY KEY (`SlotID`),
  ADD UNIQUE KEY `UK_Area_SlotName` (`AreaID`,`SlotName`),
  ADD KEY `FK_Slot_Area` (`AreaID`),
  ADD KEY `FK_Slot_VehicleType` (`AllowedVehicleTypeID`);

--
-- Indexes for table `pms_parking_sessions`
--
ALTER TABLE `pms_parking_sessions`
  ADD PRIMARY KEY (`SessionID`),
  ADD KEY `FK_Session_Slot` (`SlotID`),
  ADD KEY `FK_Session_VehicleType` (`VehicleTypeID`),
  ADD KEY `FK_Session_VehicleCategory` (`VehicleCategoryID`),
  ADD KEY `FK_Session_Staff` (`StaffID_Entry`),
  ADD KEY `idx_plate_number` (`PlateNumber`);

--
-- Indexes for table `pms_room_status`
--
ALTER TABLE `pms_room_status`
  ADD PRIMARY KEY (`StatusID`),
  ADD UNIQUE KEY `RoomNumber` (`RoomNumber`),
  ADD KEY `UserID` (`UserID`);

--
-- Indexes for table `pms_users`
--
ALTER TABLE `pms_users`
  ADD PRIMARY KEY (`UserID`),
  ADD UNIQUE KEY `Username` (`Username`),
  ADD UNIQUE KEY `EmployeeID` (`EmployeeID`),
  ADD UNIQUE KEY `idx_activation_token` (`ActivationToken`),
  ADD KEY `idx_employee_id` (`EmployeeID`);

--
-- Indexes for table `pms_user_logs`
--
ALTER TABLE `pms_user_logs`
  ADD PRIMARY KEY (`LogID`),
  ADD KEY `idx_userid` (`UserID`),
  ADD KEY `idx_actiontype` (`ActionType`),
  ADD KEY `idx_timestamp` (`Timestamp`);

--
-- Indexes for table `pms_vehiclecategory`
--
ALTER TABLE `pms_vehiclecategory`
  ADD PRIMARY KEY (`VehicleCategoryID`),
  ADD KEY `FK_Category_VehicleType` (`VehicleTypeID`);

--
-- Indexes for table `pms_vehicletype`
--
ALTER TABLE `pms_vehicletype`
  ADD PRIMARY KEY (`VehicleTypeID`);

--
-- Indexes for table `public_ticket_emails`
--
ALTER TABLE `public_ticket_emails`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ticket_id` (`ticket_id`);

--
-- Indexes for table `revenue_analytics`
--
ALTER TABLE `revenue_analytics`
  ADD PRIMARY KEY (`analytics_id`),
  ADD KEY `idx_period` (`period`),
  ADD KEY `idx_dates` (`start_date`,`end_date`);

--
-- Indexes for table `revenue_category`
--
ALTER TABLE `revenue_category`
  ADD PRIMARY KEY (`revenue_category_id`),
  ADD UNIQUE KEY `revenue_category` (`revenue_category`);

--
-- Indexes for table `revenue_entry`
--
ALTER TABLE `revenue_entry`
  ADD PRIMARY KEY (`revenue_entry_id`),
  ADD KEY `revenue_category_id` (`revenue_category_id`);

--
-- Indexes for table `revenue_trends`
--
ALTER TABLE `revenue_trends`
  ADD PRIMARY KEY (`trend_id`),
  ADD KEY `revenue_id` (`revenue_id`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`staff_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `tbl_client_users`
--
ALTER TABLE `tbl_client_users`
  ADD PRIMARY KEY (`client_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `tbl_feedbacks`
--
ALTER TABLE `tbl_feedbacks`
  ADD PRIMARY KEY (`feedback_id`);

--
-- Indexes for table `tbl_password_resets`
--
ALTER TABLE `tbl_password_resets`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `tbl_payments`
--
ALTER TABLE `tbl_payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `fk_payment_reservation` (`reservation_id`),
  ADD KEY `fk_payment_method` (`method_id`);

--
-- Indexes for table `tbl_payment_methods`
--
ALTER TABLE `tbl_payment_methods`
  ADD PRIMARY KEY (`method_id`),
  ADD UNIQUE KEY `method_name` (`method_name`);

--
-- Indexes for table `tbl_reservations`
--
ALTER TABLE `tbl_reservations`
  ADD PRIMARY KEY (`reservation_id`),
  ADD KEY `fk_reservation_client` (`client_id`);

--
-- Indexes for table `tbl_reservation_rooms`
--
ALTER TABLE `tbl_reservation_rooms`
  ADD PRIMARY KEY (`reservation_id`,`room_id`),
  ADD KEY `fk_rr_room` (`room_id`);

--
-- Indexes for table `tbl_rooms`
--
ALTER TABLE `tbl_rooms`
  ADD PRIMARY KEY (`room_id`),
  ADD UNIQUE KEY `room_num` (`room_num`);

--
-- Indexes for table `tbl_users`
--
ALTER TABLE `tbl_users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `employee_id` (`employee_id`);

--
-- Indexes for table `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`ticket_id`),
  ADD UNIQUE KEY `ticket_code` (`ticket_code`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `fixed_by` (`fixed_by`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `updated_by` (`updated_by`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`user_role_id`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounting_users`
--
ALTER TABLE `accounting_users`
  MODIFY `user_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `log_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=528;

--
-- AUTO_INCREMENT for table `attendance`
--
ALTER TABLE `attendance`
  MODIFY `attendance_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `audit_log`
--
ALTER TABLE `audit_log`
  MODIFY `log_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `backup_history`
--
ALTER TABLE `backup_history`
  MODIFY `backup_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `backup_settings`
--
ALTER TABLE `backup_settings`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `budget`
--
ALTER TABLE `budget`
  MODIFY `budget_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `budget_category`
--
ALTER TABLE `budget_category`
  MODIFY `budget_category_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `budget_variance`
--
ALTER TABLE `budget_variance`
  MODIFY `budget_variance_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `company_deductions`
--
ALTER TABLE `company_deductions`
  MODIFY `deduction_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `crm_users`
--
ALTER TABLE `crm_users`
  MODIFY `account_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `department_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dependants`
--
ALTER TABLE `dependants`
  MODIFY `dependant_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dependant_address`
--
ALTER TABLE `dependant_address`
  MODIFY `dependant_address_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=134;

--
-- AUTO_INCREMENT for table `dependant_contact`
--
ALTER TABLE `dependant_contact`
  MODIFY `dependant_contact_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=135;

--
-- AUTO_INCREMENT for table `dependant_email`
--
ALTER TABLE `dependant_email`
  MODIFY `dependant_email_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `employee_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `employee_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employee_addresses`
--
ALTER TABLE `employee_addresses`
  MODIFY `address_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `employee_contact_numbers`
--
ALTER TABLE `employee_contact_numbers`
  MODIFY `contact_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=145;

--
-- AUTO_INCREMENT for table `employee_emails`
--
ALTER TABLE `employee_emails`
  MODIFY `email_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=176;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `expenses_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `fb_categories`
--
ALTER TABLE `fb_categories`
  MODIFY `category_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `fb_ingredients`
--
ALTER TABLE `fb_ingredients`
  MODIFY `ingredient_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `fb_inventory_logs`
--
ALTER TABLE `fb_inventory_logs`
  MODIFY `log_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;

--
-- AUTO_INCREMENT for table `fb_menu_items`
--
ALTER TABLE `fb_menu_items`
  MODIFY `item_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `fb_menu_item_ingredients`
--
ALTER TABLE `fb_menu_item_ingredients`
  MODIFY `recipe_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;

--
-- AUTO_INCREMENT for table `fb_notifications`
--
ALTER TABLE `fb_notifications`
  MODIFY `notification_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;

--
-- AUTO_INCREMENT for table `fb_orders`
--
ALTER TABLE `fb_orders`
  MODIFY `order_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `fb_order_details`
--
ALTER TABLE `fb_order_details`
  MODIFY `order_detail_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT for table `fb_payments`
--
ALTER TABLE `fb_payments`
  MODIFY `payment_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `hotel_settings`
--
ALTER TABLE `hotel_settings`
  MODIFY `setting_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `invoice`
--
ALTER TABLE `invoice`
  MODIFY `invoice_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=341;

--
-- AUTO_INCREMENT for table `invoice_activity`
--
ALTER TABLE `invoice_activity`
  MODIFY `activity_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `invoice_item`
--
ALTER TABLE `invoice_item`
  MODIFY `item_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `job_positions`
--
ALTER TABLE `job_positions`
  MODIFY `position_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `leaves`
--
ALTER TABLE `leaves`
  MODIFY `leave_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `manual_payment`
--
ALTER TABLE `manual_payment`
  MODIFY `payment_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `notification_settings`
--
ALTER TABLE `notification_settings`
  MODIFY `notification_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `password_reset_otps`
--
ALTER TABLE `password_reset_otps`
  MODIFY `otp_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  MODIFY `token_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `payroll_run`
--
ALTER TABLE `payroll_run`
  MODIFY `payroll_run_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payroll_slip`
--
ALTER TABLE `payroll_slip`
  MODIFY `payroll_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pms_housekeeping_logs`
--
ALTER TABLE `pms_housekeeping_logs`
  MODIFY `LogID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `pms_housekeeping_tasks`
--
ALTER TABLE `pms_housekeeping_tasks`
  MODIFY `TaskID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `pms_inventory`
--
ALTER TABLE `pms_inventory`
  MODIFY `ItemID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `pms_inventorylog`
--
ALTER TABLE `pms_inventorylog`
  MODIFY `InvLogID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;

--
-- AUTO_INCREMENT for table `pms_itemcategory`
--
ALTER TABLE `pms_itemcategory`
  MODIFY `ItemCategoryID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `pms_maintenance_logs`
--
ALTER TABLE `pms_maintenance_logs`
  MODIFY `LogID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `pms_maintenance_requests`
--
ALTER TABLE `pms_maintenance_requests`
  MODIFY `RequestID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `pms_parkingarea`
--
ALTER TABLE `pms_parkingarea`
  MODIFY `AreaID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `pms_parkingslot`
--
ALTER TABLE `pms_parkingslot`
  MODIFY `SlotID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT for table `pms_parking_sessions`
--
ALTER TABLE `pms_parking_sessions`
  MODIFY `SessionID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `pms_room_status`
--
ALTER TABLE `pms_room_status`
  MODIFY `StatusID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `pms_users`
--
ALTER TABLE `pms_users`
  MODIFY `UserID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

--
-- AUTO_INCREMENT for table `pms_user_logs`
--
ALTER TABLE `pms_user_logs`
  MODIFY `LogID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=246;

--
-- AUTO_INCREMENT for table `pms_vehiclecategory`
--
ALTER TABLE `pms_vehiclecategory`
  MODIFY `VehicleCategoryID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `pms_vehicletype`
--
ALTER TABLE `pms_vehicletype`
  MODIFY `VehicleTypeID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `public_ticket_emails`
--
ALTER TABLE `public_ticket_emails`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `revenue_analytics`
--
ALTER TABLE `revenue_analytics`
  MODIFY `analytics_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `revenue_category`
--
ALTER TABLE `revenue_category`
  MODIFY `revenue_category_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `revenue_entry`
--
ALTER TABLE `revenue_entry`
  MODIFY `revenue_entry_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `revenue_trends`
--
ALTER TABLE `revenue_trends`
  MODIFY `trend_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `staff_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `tbl_client_users`
--
ALTER TABLE `tbl_client_users`
  MODIFY `client_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `tbl_feedbacks`
--
ALTER TABLE `tbl_feedbacks`
  MODIFY `feedback_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_payments`
--
ALTER TABLE `tbl_payments`
  MODIFY `payment_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tbl_payment_methods`
--
ALTER TABLE `tbl_payment_methods`
  MODIFY `method_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_reservations`
--
ALTER TABLE `tbl_reservations`
  MODIFY `reservation_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tbl_rooms`
--
ALTER TABLE `tbl_rooms`
  MODIFY `room_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `tbl_users`
--
ALTER TABLE `tbl_users`
  MODIFY `user_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tickets`
--
ALTER TABLE `tickets`
  MODIFY `ticket_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT for table `user_roles`
--
ALTER TABLE `user_roles`
  MODIFY `user_role_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD CONSTRAINT `activity_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `attendance`
--
ALTER TABLE `attendance`
  ADD CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE CASCADE;

--
-- Constraints for table `budget_category`
--
ALTER TABLE `budget_category`
  ADD CONSTRAINT `fk_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `budget` (`budget_id`);

--
-- Constraints for table `budget_variance`
--
ALTER TABLE `budget_variance`
  ADD CONSTRAINT `fk_budget_variance_budget` FOREIGN KEY (`budget_id`) REFERENCES `budget` (`budget_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_budget_variance_category` FOREIGN KEY (`budget_category_id`) REFERENCES `budget_category` (`budget_category_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_expenses_varience_id` FOREIGN KEY (`expenses_id`) REFERENCES `expenses` (`expenses_id`);

--
-- Constraints for table `company_deductions`
--
ALTER TABLE `company_deductions`
  ADD CONSTRAINT `fk_company_deductions_employee` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_company_deductions_leave` FOREIGN KEY (`leave_id`) REFERENCES `leaves` (`leave_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_company_deductions_payroll_run` FOREIGN KEY (`payroll_run_id`) REFERENCES `payroll_run` (`payroll_run_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `departments`
--
ALTER TABLE `departments`
  ADD CONSTRAINT `fk_dept_supervisor` FOREIGN KEY (`supervisor_id`) REFERENCES `employees` (`employee_id`) ON DELETE SET NULL;

--
-- Constraints for table `dependants`
--
ALTER TABLE `dependants`
  ADD CONSTRAINT `dependants_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE CASCADE;

--
-- Constraints for table `dependant_address`
--
ALTER TABLE `dependant_address`
  ADD CONSTRAINT `dependant_address_ibfk_1` FOREIGN KEY (`dependant_id`) REFERENCES `dependants` (`dependant_id`) ON DELETE CASCADE;

--
-- Constraints for table `dependant_contact`
--
ALTER TABLE `dependant_contact`
  ADD CONSTRAINT `dependant_contact_ibfk_1` FOREIGN KEY (`dependant_id`) REFERENCES `dependants` (`dependant_id`) ON DELETE CASCADE;

--
-- Constraints for table `dependant_email`
--
ALTER TABLE `dependant_email`
  ADD CONSTRAINT `dependant_email_ibfk_1` FOREIGN KEY (`dependant_id`) REFERENCES `dependants` (`dependant_id`) ON DELETE CASCADE;

--
-- Constraints for table `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `employees_ibfk_2` FOREIGN KEY (`position_id`) REFERENCES `job_positions` (`position_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `employees_ibfk_3` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `employees_ibfk_4` FOREIGN KEY (`supervisor_id`) REFERENCES `employees` (`employee_id`) ON DELETE SET NULL;

--
-- Constraints for table `employee_contact_numbers`
--
ALTER TABLE `employee_contact_numbers`
  ADD CONSTRAINT `employee_contact_numbers_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE CASCADE;

--
-- Constraints for table `employee_emails`
--
ALTER TABLE `employee_emails`
  ADD CONSTRAINT `employee_emails_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE CASCADE;

--
-- Constraints for table `expenses`
--
ALTER TABLE `expenses`
  ADD CONSTRAINT `fk_budget_category_expenses` FOREIGN KEY (`budget_category_id`) REFERENCES `budget_category` (`budget_category_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_budget_expenses_variance` FOREIGN KEY (`budget_variance_id`) REFERENCES `budget_variance` (`budget_variance_id`),
  ADD CONSTRAINT `fk_revenue_category_expenses` FOREIGN KEY (`revenue_category_id`) REFERENCES `revenue_category` (`revenue_category_id`),
  ADD CONSTRAINT `fk_users_expenses` FOREIGN KEY (`user_id`) REFERENCES `accounting_users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `fb_inventory_logs`
--
ALTER TABLE `fb_inventory_logs`
  ADD CONSTRAINT `fk_log_ingredient` FOREIGN KEY (`ingredient_id`) REFERENCES `fb_ingredients` (`ingredient_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_log_staff` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`) ON DELETE SET NULL;

--
-- Constraints for table `fb_menu_items`
--
ALTER TABLE `fb_menu_items`
  ADD CONSTRAINT `fk_menu_category` FOREIGN KEY (`category_id`) REFERENCES `fb_categories` (`category_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `fb_menu_item_ingredients`
--
ALTER TABLE `fb_menu_item_ingredients`
  ADD CONSTRAINT `fk_ingredient` FOREIGN KEY (`ingredient_id`) REFERENCES `fb_ingredients` (`ingredient_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_menu_item` FOREIGN KEY (`menu_item_id`) REFERENCES `fb_menu_items` (`item_id`) ON DELETE CASCADE;

--
-- Constraints for table `fb_notifications`
--
ALTER TABLE `fb_notifications`
  ADD CONSTRAINT `fk_notification_client` FOREIGN KEY (`client_id`) REFERENCES `tbl_client_users` (`client_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_notification_order` FOREIGN KEY (`order_id`) REFERENCES `fb_orders` (`order_id`) ON DELETE SET NULL;

--
-- Constraints for table `fb_orders`
--
ALTER TABLE `fb_orders`
  ADD CONSTRAINT `fk_order_employee` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_orders_client` FOREIGN KEY (`client_id`) REFERENCES `tbl_client_users` (`client_id`) ON DELETE SET NULL;

--
-- Constraints for table `fb_order_details`
--
ALTER TABLE `fb_order_details`
  ADD CONSTRAINT `fb_order_details_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `fb_orders` (`order_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fb_order_details_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `fb_menu_items` (`item_id`) ON DELETE CASCADE;

--
-- Constraints for table `fb_payments`
--
ALTER TABLE `fb_payments`
  ADD CONSTRAINT `fb_payments_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `fb_orders` (`order_id`) ON DELETE CASCADE;

--
-- Constraints for table `invoice`
--
ALTER TABLE `invoice`
  ADD CONSTRAINT `invoice_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `accounting_users` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `invoice_activity`
--
ALTER TABLE `invoice_activity`
  ADD CONSTRAINT `invoice_activity_ibfk_1` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`invoice_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `invoice_activity_ibfk_2` FOREIGN KEY (`performed_by`) REFERENCES `accounting_users` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `invoice_item`
--
ALTER TABLE `invoice_item`
  ADD CONSTRAINT `fk_category_id` FOREIGN KEY (`revenue_category_id`) REFERENCES `revenue_category` (`revenue_category_id`),
  ADD CONSTRAINT `invoice_item_ibfk_1` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`invoice_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `job_positions`
--
ALTER TABLE `job_positions`
  ADD CONSTRAINT `job_positions_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`) ON DELETE CASCADE;

--
-- Constraints for table `leaves`
--
ALTER TABLE `leaves`
  ADD CONSTRAINT `leaves_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `leaves_ibfk_2` FOREIGN KEY (`approved_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `manual_payment`
--
ALTER TABLE `manual_payment`
  ADD CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`invoice_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `payment_ibfk_2` FOREIGN KEY (`processed_by`) REFERENCES `accounting_users` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `password_reset_otps`
--
ALTER TABLE `password_reset_otps`
  ADD CONSTRAINT `fk_password_reset_otps_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD CONSTRAINT `fk_password_reset_tokens_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `payroll_slip`
--
ALTER TABLE `payroll_slip`
  ADD CONSTRAINT `fk_company_deductions` FOREIGN KEY (`company_deduction_id`) REFERENCES `company_deductions` (`deduction_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_payroll_run` FOREIGN KEY (`payroll_run_id`) REFERENCES `payroll_run` (`payroll_run_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_payroll_slip_hotel_management.employees` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_users_payroll` FOREIGN KEY (`user_id`) REFERENCES `accounting_users` (`user_id`) ON UPDATE CASCADE;

--
-- Constraints for table `public_ticket_emails`
--
ALTER TABLE `public_ticket_emails`
  ADD CONSTRAINT `public_ticket_emails_ibfk_1` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`ticket_id`) ON DELETE CASCADE;

--
-- Constraints for table `revenue_entry`
--
ALTER TABLE `revenue_entry`
  ADD CONSTRAINT `revenue_entry_ibfk_1` FOREIGN KEY (`revenue_category_id`) REFERENCES `revenue_category` (`revenue_category_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `revenue_trends`
--
ALTER TABLE `revenue_trends`
  ADD CONSTRAINT `revenue_trends_ibfk_1` FOREIGN KEY (`revenue_id`) REFERENCES `revenue_entry` (`revenue_entry_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tbl_payments`
--
ALTER TABLE `tbl_payments`
  ADD CONSTRAINT `fk_payment_method` FOREIGN KEY (`method_id`) REFERENCES `tbl_payment_methods` (`method_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_payment_reservation` FOREIGN KEY (`reservation_id`) REFERENCES `tbl_reservations` (`reservation_id`) ON DELETE CASCADE;

--
-- Constraints for table `tbl_reservations`
--
ALTER TABLE `tbl_reservations`
  ADD CONSTRAINT `fk_reservation_client` FOREIGN KEY (`client_id`) REFERENCES `tbl_client_users` (`client_id`) ON DELETE CASCADE;

--
-- Constraints for table `tbl_reservation_rooms`
--
ALTER TABLE `tbl_reservation_rooms`
  ADD CONSTRAINT `fk_rr_reservation` FOREIGN KEY (`reservation_id`) REFERENCES `tbl_reservations` (`reservation_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_rr_room` FOREIGN KEY (`room_id`) REFERENCES `tbl_rooms` (`room_id`) ON DELETE CASCADE;

--
-- Constraints for table `tbl_users`
--
ALTER TABLE `tbl_users`
  ADD CONSTRAINT `fk_employee_user` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`);

--
-- Constraints for table `tickets`
--
ALTER TABLE `tickets`
  ADD CONSTRAINT `tickets_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tickets_ibfk_2` FOREIGN KEY (`fixed_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `tickets_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `tickets_ibfk_4` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD CONSTRAINT `user_roles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
