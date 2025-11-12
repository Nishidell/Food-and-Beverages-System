-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: b9wkqgu32onfqy0dvyva-mysql.services.clever-cloud.com:21917
-- Generation Time: Nov 12, 2025 at 03:01 AM
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
(3, 'john_doe', '$2b$10$cUhfanawddm3VHTqnZ.whuCnGxjDn9o72HXRshyoWPEtWr9ddgNpS', 'Financial Manager', NULL, NULL, '2025-10-24 09:19:37', '2025-11-12 02:05:11', 1, 0, '2025-11-12 02:05:11', 'guetaallen@gmail.com');

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
(11, 8, 'CREATE', 'tickets', 'Created ticket TIC-0001', '2024-10-01 08:30:00', 8),
(12, 10, 'UPDATE', 'attendance', 'Clock out recorded for employee ID 10 (ATT-0010)', '2024-10-01 21:00:00', 10),
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
(62, 10, 'LOGIN', 'auth', 'User itemployee1 logged in', '2025-11-11 14:38:34', 10),
(63, 10, 'UPDATE', 'employees', 'Updated employee James Lim (EMP-0010)', '2025-11-11 14:40:06', 10),
(64, 10, 'UPDATE', 'employees', 'Updated employee Jamesa Lim (EMP-0010)', '2025-11-11 14:40:47', 10),
(65, 10, 'UPDATE', 'employees', 'Updated employee Jamesa Lim (EMP-0010)', '2025-11-11 14:41:43', 10),
(66, 10, 'CREATE', 'tickets', 'Created ticket \"issue1\" (TIC-0010)', '2025-11-11 14:43:21', 10),
(67, 10, 'LOGIN', 'auth', 'User itemployee1 logged in', '2025-11-11 14:44:31', 10),
(68, 1, 'LOGIN', 'auth', 'User superadmin logged in', '2025-11-11 14:47:24', 1),
(69, 10, 'UPDATE', 'employees', 'Updated employee Jamesa Lim (EMP-0010)', '2025-11-11 14:48:34', 10),
(70, 10, 'UPDATE', 'employees', 'Updated employee Jamesa Lim (EMP-0010)', '2025-11-11 14:48:44', 10),
(71, 10, 'UPDATE', 'employees', 'Updated employee Jamesa Lim (EMP-0010)', '2025-11-11 14:48:55', 10),
(72, 1, 'CREATE', 'positions', 'Created position CRM Manager (POS-0028)', '2025-11-11 14:50:25', 1),
(73, 1, 'CREATE', 'departments', 'Created department Customer Service (DEP-0013)', '2025-11-11 14:52:46', 1),
(74, 1, 'UPDATE', 'positions', 'Updated position CRM Manager (POS-0028)', '2025-11-11 14:53:14', 1),
(75, 10, 'LOGIN', 'auth', 'User itemployee1 logged in', '2025-11-11 14:53:44', 10),
(76, 10, 'UPDATE', 'users', 'Updated user itemployee1 (ID: 10)', '2025-11-11 14:58:48', 10),
(77, 10, 'UPDATE', 'users', 'Updated user itemployee1 (ID: 10)', '2025-11-11 14:58:51', 10),
(78, 1, 'CREATE', 'employees', 'Created employee Nicole Mayo (EMP-0018) with role: employee', '2025-11-11 15:03:38', 1),
(79, 10, 'LOGIN', 'auth', 'User it.jamesa logged in', '2025-11-11 15:05:26', 10),
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
(109, 1, 'UPDATE', 'employees', 'Updated employee Vincent Torio (EMP-0019)', '2025-11-12 03:00:15', 1);

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
(1, 'ATT-0001', 1, '2024-10-01', '2024-10-01 08:00:00', '2024-10-01 17:00:00', 'present', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(2, 'ATT-0002', 2, '2024-10-01', '2024-10-01 08:15:00', '2024-10-01 17:00:00', 'late', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(3, 'ATT-0003', 3, '2024-10-01', '2024-10-01 08:00:00', '2024-10-01 19:30:00', 'present', 2.50, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(4, 'ATT-0004', 4, '2024-10-01', '2024-10-01 08:00:00', '2024-10-01 17:00:00', 'present', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(5, 'ATT-0005', 5, '2024-10-01', '2024-10-01 08:30:00', '2024-10-01 17:00:00', 'late', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(6, 'ATT-0006', 6, '2024-10-01', '2024-10-01 08:00:00', '2024-10-01 20:00:00', 'present', 3.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(7, 'ATT-0007', 7, '2024-10-01', '2024-10-01 08:00:00', '2024-10-01 17:00:00', 'present', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(8, 'ATT-0008', 8, '2024-10-01', '2024-10-01 08:00:00', '2024-10-01 17:00:00', 'present', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(9, 'ATT-0009', 9, '2024-10-01', '2024-10-01 08:00:00', '2024-10-01 18:30:00', 'present', 1.50, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(10, 'ATT-0010', 10, '2024-10-01', '2024-10-01 08:00:00', '2024-10-01 21:00:00', 'present', 4.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(12, 'ATT-0012', 12, '2024-10-01', '2024-10-01 08:00:00', '2024-10-01 17:00:00', 'present', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(13, 'ATT-0013', 13, '2024-10-01', '2024-10-01 20:00:00', '2024-10-02 04:00:00', 'present', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(14, 'ATT-0014', 1, '2024-10-02', '2024-10-02 08:00:00', '2024-10-02 17:00:00', 'present', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(15, 'ATT-0015', 2, '2024-10-02', '2024-10-02 08:00:00', '2024-10-02 17:00:00', 'present', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(16, 'ATT-0016', 3, '2024-10-02', '2024-10-02 08:00:00', '2024-10-02 18:00:00', 'present', 1.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(17, 'ATT-0017', 4, '2024-10-02', '2024-10-02 08:20:00', '2024-10-02 17:00:00', 'late', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(18, 'ATT-0018', 5, '2024-10-02', '2024-10-02 08:00:00', '2024-10-02 17:00:00', 'present', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(19, 'ATT-0019', 6, '2024-10-02', '2024-10-02 08:00:00', '2024-10-02 19:00:00', 'present', 2.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(20, 'ATT-0020', 7, '2024-10-02', '2024-10-02 08:10:00', '2024-10-02 17:00:00', 'late', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(21, 'ATT-0021', 8, '2024-10-02', '2024-10-02 08:00:00', '2024-10-02 17:00:00', 'present', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(22, 'ATT-0022', 10, '2024-10-02', '2024-10-02 08:00:00', '2024-10-02 20:30:00', 'present', 3.50, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(24, 'ATT-0024', 12, '2024-10-02', '2024-10-02 08:00:00', '2024-10-02 17:00:00', 'present', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(25, 'ATT-0025', 13, '2024-10-02', '2024-10-02 20:00:00', '2024-10-03 04:00:00', 'present', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(26, 'ATT-0026', 1, '2024-10-03', '2024-10-03 08:00:00', '2024-10-03 19:00:00', 'present', 2.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(27, 'ATT-0027', 2, '2024-10-03', '2024-10-03 08:00:00', '2024-10-03 17:00:00', 'present', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(28, 'ATT-0028', 3, '2024-10-03', '2024-10-03 08:00:00', '2024-10-03 22:00:00', 'present', 5.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(29, 'ATT-0029', 4, '2024-10-03', '2024-10-03 08:00:00', '2024-10-03 17:00:00', 'present', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(30, 'ATT-0030', 5, '2024-10-03', '2024-10-03 08:25:00', '2024-10-03 17:00:00', 'late', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(31, 'ATT-0031', 6, '2024-10-03', '2024-10-03 08:00:00', '2024-10-03 18:30:00', 'present', 1.50, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(32, 'ATT-0032', 7, '2024-10-03', '2024-10-03 08:00:00', '2024-10-03 17:00:00', 'present', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(33, 'ATT-0033', 8, '2024-10-03', '2024-10-03 08:00:00', '2024-10-03 17:00:00', 'present', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(34, 'ATT-0034', 9, '2024-10-03', '2024-10-03 08:00:00', '2024-10-03 17:00:00', 'present', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(35, 'ATT-0035', 10, '2024-10-03', '2024-10-03 08:00:00', '2024-10-03 19:30:00', 'present', 2.50, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(37, 'ATT-0037', 12, '2024-10-03', '2024-10-03 08:00:00', '2024-10-03 17:00:00', 'present', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(38, 'ATT-0038', 13, '2024-10-03', '2024-10-03 20:00:00', '2024-10-04 04:00:00', 'present', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(39, 'ATT-0039', 1, '2024-10-04', '2024-10-04 08:00:00', '2024-10-04 17:00:00', 'present', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(40, 'ATT-0040', 2, '2024-10-04', '2024-10-04 08:00:00', '2024-10-04 17:00:00', 'present', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(41, 'ATT-0041', 3, '2024-10-04', '2024-10-04 08:00:00', '2024-10-04 20:00:00', 'present', 3.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(42, 'ATT-0042', 4, '2024-10-04', '2024-10-04 08:00:00', '2024-10-04 17:00:00', 'present', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(43, 'ATT-0043', 5, '2024-10-04', '2024-10-04 08:00:00', '2024-10-04 17:00:00', 'present', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(44, 'ATT-0044', 6, '2024-10-04', '2024-10-04 08:00:00', '2024-10-04 19:30:00', 'present', 2.50, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(45, 'ATT-0045', 7, '2024-10-04', '2024-10-04 08:00:00', '2024-10-04 17:00:00', 'present', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(46, 'ATT-0046', 8, '2024-10-04', '2024-10-04 08:35:00', '2024-10-04 17:00:00', 'late', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(47, 'ATT-0047', 9, '2024-10-04', NULL, NULL, 'on_leave', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(48, 'ATT-0048', 10, '2024-10-04', '2024-10-04 08:00:00', '2024-10-04 18:00:00', 'present', 1.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(50, 'ATT-0050', 12, '2024-10-04', '2024-10-04 08:00:00', '2024-10-04 17:00:00', 'present', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(51, 'ATT-0051', 13, '2024-10-04', '2024-10-04 20:00:00', '2024-10-05 04:00:00', 'present', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(52, 'ATT-0052', 1, '2024-10-07', '2024-10-07 08:00:00', '2024-10-07 17:00:00', 'present', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(53, 'ATT-0053', 2, '2024-10-07', '2024-10-07 08:00:00', '2024-10-07 17:00:00', 'present', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(54, 'ATT-0054', 3, '2024-10-07', '2024-10-07 08:00:00', '2024-10-07 21:00:00', 'present', 4.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(55, 'ATT-0055', 4, '2024-10-07', '2024-10-07 08:00:00', '2024-10-07 17:00:00', 'present', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(56, 'ATT-0056', 5, '2024-10-07', '2024-10-07 08:00:00', '2024-10-07 17:00:00', 'present', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(57, 'ATT-0057', 6, '2024-10-07', '2024-10-07 08:00:00', '2024-10-07 18:00:00', 'present', 1.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(58, 'ATT-0058', 7, '2024-10-07', '2024-10-07 08:20:00', '2024-10-07 17:00:00', 'late', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(59, 'ATT-0059', 8, '2024-10-07', '2024-10-07 08:00:00', '2024-10-07 17:00:00', 'present', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(60, 'ATT-0060', 9, '2024-10-07', '2024-10-07 08:00:00', '2024-10-07 17:00:00', 'present', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(61, 'ATT-0061', 10, '2024-10-07', '2024-10-07 08:00:00', '2024-10-07 22:00:00', 'present', 5.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(63, 'ATT-0063', 12, '2024-10-07', '2024-10-07 08:00:00', '2024-10-07 17:00:00', 'present', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(64, 'ATT-0064', 13, '2024-10-07', '2024-10-07 20:00:00', '2024-10-08 04:00:00', 'present', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(65, 'ATT-0065', 1, '2024-10-08', '2024-10-08 08:00:00', '2024-10-08 17:00:00', 'present', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(66, 'ATT-0066', 2, '2024-10-08', '2024-10-08 08:00:00', '2024-10-08 17:00:00', 'present', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(67, 'ATT-0067', 3, '2024-10-08', '2024-10-08 08:00:00', '2024-10-08 19:00:00', 'present', 2.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(68, 'ATT-0068', 4, '2024-10-08', '2024-10-08 08:15:00', '2024-10-08 17:00:00', 'late', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(69, 'ATT-0069', 5, '2024-10-08', '2024-10-08 08:00:00', '2024-10-08 17:00:00', 'present', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(70, 'ATT-0070', 6, '2024-10-08', '2024-10-08 08:00:00', '2024-10-08 20:00:00', 'present', 3.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(71, 'ATT-0071', 7, '2024-10-08', '2024-10-08 08:00:00', '2024-10-08 17:00:00', 'present', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(72, 'ATT-0072', 8, '2024-10-08', '2024-10-08 08:00:00', '2024-10-08 17:00:00', 'present', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(73, 'ATT-0073', 9, '2024-10-08', '2024-10-08 08:00:00', '2024-10-08 18:30:00', 'present', 1.50, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(74, 'ATT-0074', 10, '2024-10-08', '2024-10-08 08:00:00', '2024-10-08 19:00:00', 'present', 2.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(76, 'ATT-0076', 12, '2024-10-08', NULL, NULL, 'absent', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(77, 'ATT-0077', 13, '2024-10-08', '2024-10-08 20:00:00', '2024-10-09 04:00:00', 'present', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(78, 'ATT-0078', 1, '2024-10-09', '2024-10-09 08:00:00', '2024-10-09 17:00:00', 'present', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(79, 'ATT-0079', 2, '2024-10-09', '2024-10-09 08:30:00', '2024-10-09 17:00:00', 'late', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(80, 'ATT-0080', 3, '2024-10-09', '2024-10-09 08:00:00', '2024-10-09 18:30:00', 'present', 1.50, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(81, 'ATT-0081', 4, '2024-10-09', '2024-10-09 08:45:00', '2024-10-09 17:00:00', 'late', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(82, 'ATT-0082', 5, '2024-10-09', '2024-10-09 08:20:00', '2024-10-09 17:00:00', 'late', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(83, 'ATT-0083', 6, '2024-10-09', '2024-10-09 08:00:00', '2024-10-09 19:30:00', 'present', 2.50, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(84, 'ATT-0084', 7, '2024-10-09', '2024-10-09 08:15:00', '2024-10-09 17:00:00', 'late', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(85, 'ATT-0085', 8, '2024-10-09', '2024-10-09 08:00:00', '2024-10-09 17:00:00', 'present', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(86, 'ATT-0086', 9, '2024-10-09', '2024-10-09 08:00:00', '2024-10-09 17:00:00', 'present', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(87, 'ATT-0087', 10, '2024-10-09', '2024-10-09 08:00:00', '2024-10-09 21:30:00', 'present', 4.50, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(89, 'ATT-0089', 12, '2024-10-09', '2024-10-09 08:00:00', '2024-10-09 17:00:00', 'present', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL),
(90, 'ATT-0090', 13, '2024-10-09', '2024-10-09 20:00:00', '2024-10-10 04:00:00', 'present', 0.00, '2025-11-11 05:41:53', '2025-11-11 05:41:53', 1, NULL);

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
  `users_id` int DEFAULT NULL,
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

INSERT INTO `budget` (`budget_id`, `users_id`, `budget_name`, `start_date`, `end_date`, `description`, `period_type`, `status`, `created_at`, `updated_at`, `created_by`) VALUES
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
(6, 15, 16, NULL, 0.00, 15000.00, 100.00, '2025-11-04 23:25:27', '2025-11-07 02:51:18', 'Monitor'),
(7, 16, 16, NULL, 20000.00, -8000.00, -66.67, '2025-11-04 23:25:27', '2025-11-11 03:47:13', 'On Track'),
(8, 17, 16, NULL, 20000.00, -12000.00, -150.00, '2025-11-04 23:25:27', '2025-11-11 03:33:20', 'On Track'),
(9, 18, 16, NULL, 0.00, 10000.00, 100.00, '2025-11-04 23:25:27', '2025-11-07 02:51:24', 'Monitor'),
(10, 19, 18, NULL, 0.00, 200000.00, 100.00, '2025-11-10 06:39:39', '2025-11-10 06:39:39', 'On Track'),
(11, 20, 18, NULL, 0.00, 85000.00, 100.00, '2025-11-10 06:39:39', '2025-11-10 06:39:39', 'On Track'),
(12, 21, 18, NULL, 0.00, 15000.00, 100.00, '2025-11-10 06:39:39', '2025-11-10 06:39:39', 'On Track'),
(13, 22, 18, NULL, 0.00, 12000.00, 100.00, '2025-11-10 06:39:39', '2025-11-10 06:39:39', 'On Track'),
(14, 23, 18, NULL, 0.00, 8000.00, 100.00, '2025-11-10 06:39:39', '2025-11-10 06:39:39', 'On Track'),
(15, 24, 18, NULL, 0.00, 10000.00, 100.00, '2025-11-10 06:39:39', '2025-11-10 06:39:39', 'On Track');

-- --------------------------------------------------------

--
-- Table structure for table `cleaninglog`
--

CREATE TABLE `cleaninglog` (
  `CleaningLogID` int NOT NULL,
  `UserID` int NOT NULL,
  `CleaningID` int NOT NULL,
  `TimeDateCleaned` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cleaningtask`
--

CREATE TABLE `cleaningtask` (
  `CleaningID` int NOT NULL,
  `RoomID` int NOT NULL,
  `UserID` int NOT NULL,
  `CleaningType` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `Status` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `DateTimeAssigned` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `DateTimeCompleted` timestamp NULL DEFAULT NULL,
  `CleaningRemarks` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `StatusUpdateToken` varchar(255) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

--
-- Dumping data for table `company_deductions`
--

INSERT INTO `company_deductions` (`deduction_id`, `employee_id`, `payroll_run_id`, `leave_id`, `deduction_name`, `amount`, `remarks`, `date_applied`) VALUES
(1, 5, 1, 1, 'Nag-Leave', 500.00, 'Unpaid leave deductions', '2025-11-10'),
(2, 5, 1, 2, 'Nag-Leave', 500.00, 'Unpaid leave deductions', '2025-11-10'),
(3, 5, 1, 1, 'Nag-Leave', 500.00, 'Unpaid leave deductions', '2025-11-10'),
(4, 5, 1, 2, 'Nag-Leave', 500.00, 'Unpaid leave deductions', '2025-11-10'),
(5, 5, 1, 1, 'Nag-Leave', 500.00, 'Unpaid leave deductions', '2025-11-10'),
(6, 5, 1, 2, 'Nag-Leave', 500.00, 'Unpaid leave deductions', '2025-11-10'),
(7, 5, 1, 1, 'Nag-Leave', 500.00, 'Unpaid leave deductions', '2025-11-10'),
(8, 5, 1, 2, 'Nag-Leave', 500.00, 'Unpaid leave deductions', '2025-11-10');

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
(6, 'Hezel', 'Joy', 'hezel@example.com', '$2a$10$WOLN6WQlu9L5TIlJ0nQjreihh7jf.aZjiCPaOV8V8gHNqYP9.nCoa', '9283617283', '2025-11-05 18:20:13');

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
(13, 'DEP-0013', 'Customer Service', NULL, NULL, '2025-11-11 14:52:46', '2025-11-11 14:52:46', 1, NULL);

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
(8, 'DEP-0008', 1, 'Roberto', 'Admin', 'Parent', '1960-04-10', '2025-11-09 10:18:55', '2025-11-09 10:18:55', 1, NULL),
(9, 'DEP-0009', 3, 'Teresa', 'Dela Cruz', 'Mother', '1965-07-25', '2025-11-09 10:18:55', '2025-11-09 10:18:55', 1, NULL),
(10, 'DEP-0010', 10, 'Patricia', 'Lim', 'Spouse', '1994-01-18', '2025-11-09 10:18:55', '2025-11-09 10:18:55', 1, NULL),
(14, 'DEP-0014', 18, 'Skylar ', 'Catalan', 'Parent', NULL, '2025-11-11 15:21:03', '2025-11-11 15:21:03', 1, NULL),
(15, 'DEP-0015', 18, 'Leah', 'Ramirez', 'Sibling', NULL, '2025-11-11 15:21:03', '2025-11-11 15:21:03', 1, NULL),
(17, 'DEP-0017', 20, 'John Rey ', 'Vidal', 'Parent', NULL, '2025-11-11 15:57:41', '2025-11-11 15:57:41', 1, NULL),
(24, 'DEP-0024', 22, 'Ricardo', 'Villaflor', 'Spouse', NULL, '2025-11-11 18:16:53', '2025-11-11 18:16:53', 1, NULL),
(34, 'DEP-0034', 21, 'Jonas', 'Dela Cruz', 'Parent', NULL, '2025-11-12 02:36:32', '2025-11-12 02:36:32', 1, NULL),
(36, 'DEP-0036', 19, 'Benjamin', 'Montero', 'Parent', NULL, '2025-11-12 03:00:15', '2025-11-12 03:00:15', 1, NULL);

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
(4, 8, 'NCR', 'Metro Manila', 'Quezon City', '123 Admin St, Brgy. Central', '2025-11-09 10:18:55', '2025-11-09 10:18:55', 1, NULL),
(5, 10, 'NCR', 'Metro Manila', 'Makati City', '741 Dev Center, Brgy. Bel-Air', '2025-11-09 10:18:55', '2025-11-09 10:18:55', 1, NULL),
(9, 14, 'Region IV-A (CALABARZON)', 'Rizal', 'City of Antipolo ', 'Unit 10, 2/F Molvina Commercial Complex, Marcos Highway', '2025-11-11 15:21:03', '2025-11-11 15:21:03', 1, NULL),
(10, 15, 'Region IV-A (CALABARZON)', 'Rizal', 'Cainta', ' Unit 10, 2/F Molvina Commercial Complex, Marcos Highway', '2025-11-11 15:21:03', '2025-11-11 15:21:03', 1, NULL),
(12, 17, 'National Capital Region (NCR)', 'NCR', 'Manila', '1580 Taft Avenue, Pedro Gil Arcade, Ermita', '2025-11-11 15:57:41', '2025-11-11 15:57:41', 1, NULL),
(19, 24, 'National Capital Region (NCR)', 'NCR', 'Valenzuela City', '13 Oregano st. Palanas A Barangay Vasra', '2025-11-11 18:16:53', '2025-11-11 18:16:53', 1, NULL),
(29, 34, 'National Capital Region (NCR)', 'NCR', 'Makati City', ' 1047 Metropolitan Avenue, Sta Cruz', '2025-11-12 02:36:33', '2025-11-12 02:36:33', 1, NULL),
(31, 36, 'National Capital Region (NCR)', 'NCR', 'Taguig City', ' 10 Gen A Luna', '2025-11-12 03:00:15', '2025-11-12 03:00:15', 1, NULL);

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
(5, 8, '+63 921 555 5678', '2025-11-09 10:18:55', '2025-11-09 10:18:55', 1, NULL),
(6, 10, '+63 922 555 6789', '2025-11-09 10:18:55', '2025-11-09 10:18:55', 1, NULL),
(10, 14, '09123233232', '2025-11-11 15:21:03', '2025-11-11 15:21:03', 1, NULL),
(11, 15, '09123213323', '2025-11-11 15:21:03', '2025-11-11 15:21:03', 1, NULL),
(13, 17, '09912312313', '2025-11-11 15:57:41', '2025-11-11 15:57:41', 1, NULL),
(20, 24, '09242522255', '2025-11-11 18:16:53', '2025-11-11 18:16:53', 1, NULL),
(30, 34, '09723232226', '2025-11-12 02:36:33', '2025-11-12 02:36:33', 1, NULL),
(32, 36, '09232222213', '2025-11-12 03:00:15', '2025-11-12 03:00:15', 1, NULL);

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
(4, 8, 'roberto.admin@email.com', '2025-11-09 10:18:55', '2025-11-09 10:18:55', 1, NULL),
(5, 10, 'patricia.lim@email.com', '2025-11-09 10:18:55', '2025-11-09 10:18:55', 1, NULL);

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
  `home_address` text,
  `city` varchar(100) DEFAULT NULL,
  `region` varchar(100) DEFAULT NULL,
  `province` varchar(100) DEFAULT NULL,
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

INSERT INTO `employees` (`employee_id`, `employee_code`, `user_id`, `fingerprint_id`, `first_name`, `last_name`, `middle_name`, `extension_name`, `birthdate`, `gender`, `civil_status`, `home_address`, `city`, `region`, `province`, `position_id`, `department_id`, `shift`, `salary`, `hire_date`, `leave_credit`, `supervisor_id`, `status`, `created_at`, `updated_at`, `created_by`, `updated_by`) VALUES
(1, 'EMP-0001', 1, NULL, 'Super', 'Admin', 'System', NULL, '1985-01-01', 'male', 'single', '123 Admin St', 'Quezon City', 'NCR', 'Metro Manila', 1, 1, 'morning', 80000.00, '2020-01-01', 15, NULL, 'active', '2025-11-11 05:40:40', '2025-11-11 05:40:40', 1, NULL),
(2, 'EMP-0002', 2, NULL, 'Maria', 'Santos', 'Cruz', NULL, '1990-03-15', 'female', 'married', '456 HR Ave', 'Makati City', 'NCR', 'Metro Manila', 1, 1, 'morning', 45000.00, '2021-02-01', 15, NULL, 'active', '2025-11-11 05:40:43', '2025-11-11 05:40:43', 1, NULL),
(3, 'EMP-0003', 3, NULL, 'Juan', 'Dela Cruz', 'Reyes', NULL, '1988-07-20', 'male', 'single', '789 Tech Blvd', 'Pasig City', 'NCR', 'Metro Manila', 5, 2, 'morning', 55000.00, '2021-03-01', 15, NULL, 'active', '2025-11-11 05:40:49', '2025-11-11 05:40:49', 1, NULL),
(4, 'EMP-0004', 4, NULL, 'Ana', 'Garcia', 'Lopez', NULL, '1992-05-10', 'female', 'single', '321 Front St', 'Manila', 'NCR', 'Metro Manila', 9, 3, 'morning', 35000.00, '2021-04-01', 15, NULL, 'active', '2025-11-11 05:40:55', '2025-11-11 05:40:55', 1, NULL),
(5, 'EMP-0005', 5, NULL, 'Pedro', 'Ramos', 'Silva', NULL, '1987-11-25', 'male', 'married', '654 Supervisor Ln', 'Quezon City', 'NCR', 'Metro Manila', 2, 1, 'morning', 40000.00, '2021-05-01', 15, 2, 'active', '2025-11-11 05:41:02', '2025-11-11 05:41:02', 1, NULL),
(6, 'EMP-0006', 6, NULL, 'Carlos', 'Mendoza', 'Torres', NULL, '1986-09-18', 'male', 'married', '789 IT Supervisor St', 'Makati City', 'NCR', 'Metro Manila', 5, 2, 'morning', 50000.00, '2021-05-15', 15, 3, 'active', '2025-11-11 05:41:08', '2025-11-11 05:41:08', 1, NULL),
(7, 'EMP-0007', 7, NULL, 'Rosa', 'Martinez', 'Fernandez', NULL, '1989-04-12', 'female', 'single', '321 Front Desk Supervisor Ave', 'Manila', 'NCR', 'Metro Manila', 9, 3, 'morning', 38000.00, '2021-06-01', 15, 4, 'active', '2025-11-11 05:41:14', '2025-11-11 05:41:14', 1, NULL),
(8, 'EMP-0008', 8, NULL, 'Lisa', 'Tan', 'Wong', NULL, '1995-06-22', 'female', 'single', '258 HR Plaza', 'Mandaluyong', 'NCR', 'Metro Manila', 4, 1, 'morning', 28000.00, '2022-01-15', 15, 5, 'active', '2025-11-11 05:41:20', '2025-11-11 05:41:20', 1, NULL),
(9, 'EMP-0009', 9, NULL, 'Mark', 'Villanueva', 'Castro', NULL, '1994-08-30', 'male', 'single', '369 Recruitment St', 'Quezon City', 'NCR', 'Metro Manila', 3, 1, 'morning', 32000.00, '2022-02-01', 15, 5, 'active', '2025-11-11 05:41:24', '2025-11-11 05:41:24', 1, NULL),
(10, 'EMP-0010', 10, NULL, 'Jamesa', 'Lim', 'Chen', NULL, '1993-12-05', 'female', 'single', '741 Dev Center', 'Quezon City', 'National Capital Region (NCR)', 'NCR', 6, 2, 'morning', 45000.00, '2022-03-01', 15, 6, 'active', '2025-11-11 05:41:28', '2025-11-11 14:40:47', 1, 10),
(12, 'EMP-0012', 12, NULL, 'Jenny', 'Cruz', 'Bautista', NULL, '1997-10-08', 'female', 'single', '963 Lobby Ave', 'Manila', 'NCR', 'Metro Manila', 10, 3, 'morning', 25000.00, '2022-05-01', 15, 7, 'active', '2025-11-11 05:41:36', '2025-11-11 05:41:36', 1, NULL),
(13, 'EMP-0013', 13, NULL, 'Michael', 'Reyes', 'Santos', NULL, '1998-03-27', 'male', 'single', '159 Front Office', 'Pasay City', 'NCR', 'Metro Manila', 11, 3, 'night', 23000.00, '2022-06-01', 15, 7, 'active', '2025-11-11 05:41:40', '2025-11-11 05:41:40', 1, NULL),
(14, NULL, 14, NULL, 'John', 'Weak', NULL, NULL, NULL, 'others', 'single', NULL, NULL, NULL, NULL, NULL, NULL, 'morning', NULL, NULL, 15, NULL, 'active', '2025-11-11 09:42:42', '2025-11-11 09:42:42', NULL, NULL),
(15, NULL, 15, NULL, 'Test', 'Admin', NULL, NULL, NULL, 'others', 'single', NULL, NULL, NULL, NULL, NULL, NULL, 'morning', NULL, NULL, 15, NULL, 'active', '2025-11-11 09:46:01', '2025-11-11 09:46:01', NULL, NULL),
(16, NULL, 16, NULL, 'kurt', 'Alicando', NULL, NULL, NULL, 'others', 'single', NULL, NULL, NULL, NULL, NULL, NULL, 'morning', NULL, NULL, 15, NULL, 'active', '2025-11-11 10:15:26', '2025-11-11 10:15:26', 1, NULL),
(18, 'EMP-0018', 18, NULL, 'Nicole', 'Mayo', NULL, NULL, '1995-03-01', 'female', 'single', 'Unit 10, 2/F Molvina Commercial Complex, Marcos Highway', 'City of Antipolo ', 'Region IV-A (CALABARZON)', 'Rizal', 13, 4, 'morning', 1000.00, '2025-11-05', 15, NULL, 'active', '2025-11-11 15:03:38', '2025-11-11 15:05:36', 1, 1),
(19, 'EMP-0019', 19, NULL, 'Vincent', 'Torio', NULL, NULL, '1990-02-09', 'male', 'married', ' 533 Commonwealth Avenue 1121', 'Quezon City', 'National Capital Region (NCR)', 'NCR', 21, 5, 'morning', 1000.00, '2025-11-03', 15, NULL, 'active', '2025-11-11 15:31:18', '2025-11-12 02:58:15', 1, 1),
(20, 'EMP-0020', 20, NULL, 'John Wilmer', 'Tima-an', NULL, NULL, '2000-02-01', 'male', 'single', 'House Of Precast, 1850 E. Rodriguez Sr. Blvd, Cubao', 'Quezon City', 'National Capital Region (NCR)', 'NCR', 18, 9, 'morning', 10000.00, '2025-10-30', 15, NULL, 'active', '2025-11-11 15:57:41', '2025-11-11 15:57:41', 1, NULL),
(21, 'EMP-0021', 21, NULL, 'Gabriel', 'Chavez', NULL, NULL, '2001-12-03', 'others', 'single', ' 700 Shaw Boulevard', 'Pasig City', 'National Capital Region (NCR)', 'NCR', 25, 3, 'morning', 1023.00, '2025-10-30', 15, 7, 'active', '2025-11-11 17:25:45', '2025-11-12 02:36:32', 1, 1),
(22, 'EMP-0022', 22, NULL, 'Lawrence', 'Savariz', NULL, NULL, '0004-10-02', 'male', 'single', 'Pasilio 2 Central Market 1000', 'Manila', 'National Capital Region (NCR)', 'NCR', 1, 1, 'morning', 1000.00, '2025-10-29', 15, NULL, 'active', '2025-11-11 17:57:10', '2025-11-11 18:16:53', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `employee_addresses`
--

CREATE TABLE `employee_addresses` (
  `address_id` int NOT NULL,
  `employee_id` int DEFAULT NULL,
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
-- Dumping data for table `employee_addresses`
--

INSERT INTO `employee_addresses` (`address_id`, `employee_id`, `region_name`, `province_name`, `city_name`, `home_address`, `created_at`, `updated_at`, `created_by`, `updated_by`) VALUES
(1, 1, 'NCR', 'Metro Manila', 'Quezon City', '123 Admin St, Brgy. Central', '2025-11-11 05:41:51', '2025-11-11 05:41:51', 1, NULL),
(2, 2, 'NCR', 'Metro Manila', 'Makati City', '456 HR Ave, Brgy. Poblacion', '2025-11-11 05:41:51', '2025-11-11 05:41:51', 1, NULL),
(3, 3, 'NCR', 'Metro Manila', 'Pasig City', '789 Tech Blvd, Brgy. Kapitolyo', '2025-11-11 05:41:51', '2025-11-11 05:41:51', 1, NULL),
(4, 4, 'NCR', 'Metro Manila', 'Manila', '321 Front St, Brgy. Ermita', '2025-11-11 05:41:51', '2025-11-11 05:41:51', 1, NULL),
(5, 5, 'NCR', 'Metro Manila', 'Quezon City', '654 Supervisor Ln, Brgy. Diliman', '2025-11-11 05:41:51', '2025-11-11 05:41:51', 1, NULL),
(6, 6, 'NCR', 'Metro Manila', 'Makati City', '789 IT Supervisor St, Brgy. Salcedo', '2025-11-11 05:41:51', '2025-11-11 05:41:51', 1, NULL),
(7, 7, 'NCR', 'Metro Manila', 'Manila', '321 Front Desk Supervisor Ave, Brgy. Malate', '2025-11-11 05:41:51', '2025-11-11 05:41:51', 1, NULL),
(8, 8, 'NCR', 'Metro Manila', 'Mandaluyong', '258 HR Plaza, Brgy. Highway Hills', '2025-11-11 05:41:51', '2025-11-11 05:41:51', 1, NULL),
(9, 9, 'NCR', 'Metro Manila', 'Quezon City', '369 Recruitment St, Brgy. Cubao', '2025-11-11 05:41:51', '2025-11-11 05:41:51', 1, NULL),
(10, 10, 'NCR', 'Metro Manila', 'Makati City', '741 Dev Center, Brgy. Bel-Air', '2025-11-11 05:41:51', '2025-11-11 05:41:51', 1, NULL),
(12, 12, 'NCR', 'Metro Manila', 'Manila', '963 Lobby Ave, Brgy. Intramuros', '2025-11-11 05:41:51', '2025-11-11 05:41:51', 1, NULL),
(13, 13, 'NCR', 'Metro Manila', 'Pasay City', '159 Front Office, Brgy. Baclaran', '2025-11-11 05:41:51', '2025-11-11 05:41:51', 1, NULL);

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
(1, 1, '+63 917 123 4567', '2025-11-11 05:41:47', '2025-11-11 05:41:47', 1, NULL),
(2, 2, '+63 918 234 5678', '2025-11-11 05:41:47', '2025-11-11 05:41:47', 1, NULL),
(3, 3, '+63 919 345 6789', '2025-11-11 05:41:47', '2025-11-11 05:41:47', 1, NULL),
(4, 4, '+63 920 456 7890', '2025-11-11 05:41:47', '2025-11-11 05:41:47', 1, NULL),
(5, 5, '+63 921 567 8901', '2025-11-11 05:41:47', '2025-11-11 05:41:47', 1, NULL),
(6, 6, '+63 922 678 9012', '2025-11-11 05:41:47', '2025-11-11 05:41:47', 1, NULL),
(7, 7, '+63 923 789 0123', '2025-11-11 05:41:47', '2025-11-11 05:41:47', 1, NULL),
(8, 8, '+63 924 890 1234', '2025-11-11 05:41:47', '2025-11-11 05:41:47', 1, NULL),
(9, 9, '+63 925 901 2345', '2025-11-11 05:41:47', '2025-11-11 05:41:47', 1, NULL),
(12, 12, '+63 928 234 5678', '2025-11-11 05:41:47', '2025-11-11 05:41:47', 1, NULL),
(13, 13, '+63 929 345 6789', '2025-11-11 05:41:47', '2025-11-11 05:41:47', 1, NULL),
(17, 10, '09912121230', '2025-11-11 14:48:55', '2025-11-11 14:48:55', NULL, NULL),
(20, 18, '09234234242', '2025-11-11 15:21:03', '2025-11-11 15:21:03', NULL, NULL),
(22, 20, '09922322515', '2025-11-11 15:57:41', '2025-11-11 15:57:41', NULL, NULL),
(29, 22, '09971231232', '2025-11-11 18:16:53', '2025-11-11 18:16:53', NULL, NULL),
(39, 21, '09123123321', '2025-11-12 02:36:32', '2025-11-12 02:36:32', NULL, NULL),
(41, 19, '09123233222', '2025-11-12 03:00:15', '2025-11-12 03:00:15', NULL, NULL);

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
(1, 1, 'superadmin@gmail.com', '2025-11-11 05:41:49', '2025-11-11 05:41:49', 1, NULL),
(2, 2, 'maria.santos@gmail.com', '2025-11-11 05:41:49', '2025-11-11 05:41:49', 1, NULL),
(3, 3, 'juan.delacruz@gmail.com', '2025-11-11 05:41:49', '2025-11-11 05:41:49', 1, NULL),
(4, 4, 'ana.garcia@gmail.com', '2025-11-11 05:41:49', '2025-11-11 05:41:49', 1, NULL),
(5, 5, 'pedro.ramos@gmail.com', '2025-11-11 05:41:49', '2025-11-11 05:41:49', 1, NULL),
(6, 6, 'carlos.mendoza@gmail.com', '2025-11-11 05:41:49', '2025-11-11 05:41:49', 1, NULL),
(7, 7, 'rosa.martinez@gmail.com', '2025-11-11 05:41:49', '2025-11-11 05:41:49', 1, NULL),
(8, 8, 'lisa.tan@gmail.com', '2025-11-11 05:41:49', '2025-11-11 05:41:49', 1, NULL),
(9, 9, 'mark.villanueva@gmail.com', '2025-11-11 05:41:49', '2025-11-11 05:41:49', 1, NULL),
(12, 12, 'jenny.cruz@gmail.com', '2025-11-11 05:41:49', '2025-11-11 05:41:49', 1, NULL),
(13, 13, 'michael.reyes@gmail.com', '2025-11-11 05:41:49', '2025-11-11 05:41:49', 1, NULL),
(14, 14, 'John@example.com', '2025-11-11 09:42:43', '2025-11-11 09:42:43', NULL, NULL),
(15, 15, 'admin@example.com', '2025-11-11 09:46:01', '2025-11-11 09:46:01', NULL, NULL),
(16, 16, 'kurt@example.com', '2025-11-11 10:15:27', '2025-11-11 10:15:27', 1, NULL),
(18, 10, 'jamesa.lim@gmail.com', '2025-11-11 14:48:44', '2025-11-11 14:48:44', NULL, NULL),
(21, 18, 'mayo.nicole@gmail.com', '2025-11-11 15:21:02', '2025-11-11 15:21:02', NULL, NULL),
(23, 20, 'tima-anjohnwilmer@gmail.com', '2025-11-11 15:57:41', '2025-11-11 15:57:41', NULL, NULL),
(30, 22, 'savaeizlawrence@gmail.com', '2025-11-11 18:16:53', '2025-11-11 18:16:53', NULL, NULL),
(40, 21, 'chavezgabriel@gmail.com', '2025-11-12 02:36:32', '2025-11-12 02:36:32', NULL, NULL),
(42, 19, 'torio.vincent@gmail.com', '2025-11-12 03:00:15', '2025-11-12 03:00:15', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `expenses_id` int NOT NULL,
  `users_id` int DEFAULT NULL,
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

INSERT INTO `expenses` (`expenses_id`, `users_id`, `budget_category_id`, `revenue_category_id`, `budget_variance_id`, `expense_name`, `description`, `amount`, `status`, `receipt_filename`, `receipt_file_path`, `notes`, `tax_amount`, `is_active`, `paid_date`, `due_date`, `created_at`, `updated_at`, `vendor_supplier`) VALUES
(1, 3, 14, 3, NULL, 'Payroll', '', 20000.00, 'Pending', NULL, NULL, NULL, NULL, 1, '2025-11-10', NULL, '2025-11-07 00:52:07', '2025-11-10 11:47:37', 'N/a'),
(2, 3, 13, 1, 4, 'Posters', 'N/a', 20000.00, 'Pending', NULL, NULL, NULL, NULL, 1, '2025-11-10', NULL, '2025-11-08 01:35:25', '2025-11-10 11:47:38', 'N/a'),
(3, 3, 23, 1, NULL, 'Elite Level posters', '', 20000.00, 'Pending', NULL, NULL, NULL, NULL, 0, '2025-11-11', NULL, '2025-11-11 02:38:01', '2025-11-11 02:43:05', 'Print shop na maangas'),
(4, 3, 16, 1, 7, 'Elite Posters', '', 20000.00, 'Paid', NULL, NULL, NULL, NULL, 1, '2025-11-11', NULL, '2025-11-11 02:43:55', '2025-11-11 03:47:13', 'Print shop na maangas'),
(5, 3, 13, 1, 4, 'Office Supplies in The events room', '', 20000.00, 'Paid', NULL, NULL, NULL, NULL, 0, '2025-11-11', NULL, '2025-11-11 02:56:47', '2025-11-11 02:57:18', 'Mass diddy');

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
(1, 'Beef', 7028.00, 'g', 10.00, '2025-11-01 03:45:10'),
(2, 'Bread', 9965.00, 'pcs', 10.00, '2025-11-01 11:32:01'),
(3, 'Cheese', 9499.00, 'g', 10.00, '2025-11-01 11:32:52'),
(4, 'Chicken', 938.00, 'g', 10.00, '2025-11-02 00:00:53'),
(5, 'Pork', 2000.00, 'g', 10.00, '2025-11-02 00:12:38'),
(6, 'Potato', 8.00, 'pcs', 10.00, '2025-11-02 00:19:30'),
(7, 'Tomato', 4.00, 'pcs', 10.00, '2025-11-02 00:20:53'),
(8, 'Fish', 10000.00, 'g', 10.00, '2025-11-02 00:24:58'),
(9, 'Lettuce', 10008.00, 'pcs', 10.00, '2025-11-02 00:29:37'),
(10, 'Onion', 7.00, 'pcs', 10.00, '2025-11-02 00:34:54'),
(11, 'mango', 996.00, 'pcs', 10.00, '2025-11-06 15:48:41');

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
(1, 1, NULL, 'INITIAL', 5000.00, 5000.00, 'Ingredient created', '2025-11-01 03:45:10'),
(2, 1, NULL, 'ORDER_DEDUCT', 150.00, 4850.00, 'Order ID: 1', '2025-11-01 04:13:09'),
(3, 1, NULL, 'ORDER_DEDUCT', 300.00, 4550.00, 'Order ID: 2', '2025-11-01 04:18:34'),
(4, 1, NULL, 'ORDER_DEDUCT', 450.00, 4100.00, 'Order ID: 3', '2025-11-01 04:30:23'),
(5, 1, NULL, 'ORDER_DEDUCT', 600.00, 3500.00, 'Order ID: 4', '2025-11-01 05:43:18'),
(6, 1, NULL, 'ORDER_DEDUCT', 300.00, 3200.00, 'Order ID: 5', '2025-11-01 10:50:39'),
(7, 1, NULL, 'ORDER_DEDUCT', 300.00, 2900.00, 'Order ID: 6', '2025-11-01 10:51:09'),
(8, 1, NULL, 'ORDER_DEDUCT', 300.00, 2600.00, 'Order ID: 7', '2025-11-01 10:55:17'),
(9, 1, NULL, 'ORDER_DEDUCT', 450.00, 2150.00, 'Order ID: 8', '2025-11-01 11:14:39'),
(10, 2, 2, 'INITIAL', 100.00, 100.00, 'Ingredient created', '2025-11-01 11:32:01'),
(11, 3, 2, 'INITIAL', 1000.00, 1000.00, 'Ingredient created', '2025-11-01 11:32:52'),
(12, 1, NULL, 'ORDER_DEDUCT', 200.00, 1950.00, 'Order ID: 9', '2025-11-01 11:37:32'),
(13, 2, NULL, 'ORDER_DEDUCT', 2.00, 98.00, 'Order ID: 9', '2025-11-01 11:37:32'),
(14, 3, NULL, 'ORDER_DEDUCT', 100.00, 900.00, 'Order ID: 9', '2025-11-01 11:37:32'),
(15, 1, NULL, 'ORDER_DEDUCT', 150.00, 1700.00, 'Order ID: 10', '2025-11-01 16:23:38'),
(16, 1, NULL, 'ORDER_DEDUCT', 100.00, 1700.00, 'Order ID: 10', '2025-11-01 16:23:38'),
(17, 2, NULL, 'ORDER_DEDUCT', 1.00, 97.00, 'Order ID: 10', '2025-11-01 16:23:38'),
(18, 3, NULL, 'ORDER_DEDUCT', 50.00, 850.00, 'Order ID: 10', '2025-11-01 16:23:38'),
(19, 1, NULL, 'ORDER_DEDUCT', 450.00, 1250.00, 'Order ID: 3', '2025-11-01 16:26:10'),
(20, 1, NULL, 'ORDER_DEDUCT', 300.00, 950.00, 'Order ID: 2', '2025-11-01 16:37:09'),
(21, 1, NULL, 'ORDER_DEDUCT', 600.00, 350.00, 'Order ID: 4', '2025-11-01 16:37:10'),
(22, 1, NULL, 'ORDER_DEDUCT', 300.00, 50.00, 'Order ID: 5', '2025-11-01 16:37:11'),
(23, 1, NULL, 'RESTOCK', 3000.00, 3050.00, 'New Delivery', '2025-11-01 16:37:49'),
(24, 1, NULL, 'ORDER_DEDUCT', 300.00, 2750.00, 'Order ID: 7', '2025-11-01 16:39:29'),
(25, 1, NULL, 'ORDER_DEDUCT', 300.00, 2450.00, 'Order ID: 6', '2025-11-01 16:39:30'),
(26, 1, NULL, 'ORDER_DEDUCT', 450.00, 1700.00, 'Order ID: 11', '2025-11-01 16:41:11'),
(27, 1, NULL, 'ORDER_DEDUCT', 300.00, 1700.00, 'Order ID: 11', '2025-11-01 16:41:11'),
(28, 2, NULL, 'ORDER_DEDUCT', 3.00, 94.00, 'Order ID: 11', '2025-11-01 16:41:11'),
(29, 3, NULL, 'ORDER_DEDUCT', 150.00, 700.00, 'Order ID: 11', '2025-11-01 16:41:11'),
(30, 1, NULL, 'ORDER_DEDUCT', 300.00, 1400.00, 'Order ID: 12', '2025-11-01 17:02:05'),
(31, 2, NULL, 'ORDER_DEDUCT', 3.00, 91.00, 'Order ID: 12', '2025-11-01 17:02:05'),
(32, 3, NULL, 'ORDER_DEDUCT', 150.00, 550.00, 'Order ID: 12', '2025-11-01 17:02:05'),
(33, 1, NULL, 'ORDER_DEDUCT', 100.00, 1300.00, 'Order ID: 13', '2025-11-01 23:54:12'),
(34, 2, NULL, 'ORDER_DEDUCT', 1.00, 90.00, 'Order ID: 13', '2025-11-01 23:54:12'),
(35, 3, NULL, 'ORDER_DEDUCT', 50.00, 500.00, 'Order ID: 13', '2025-11-01 23:54:12'),
(36, 4, 2, 'INITIAL', 3000.00, 3000.00, 'Ingredient created', '2025-11-02 00:00:53'),
(37, 5, 2, 'INITIAL', 2000.00, 2000.00, 'Ingredient created', '2025-11-02 00:12:38'),
(38, 6, 2, 'INITIAL', 100.00, 100.00, 'Ingredient created', '2025-11-02 00:19:30'),
(39, 6, 2, 'RESTOCK', 10.00, 110.00, 'New Delivery', '2025-11-02 00:19:54'),
(40, 7, 2, 'INITIAL', 50.00, 50.00, 'Ingredient created', '2025-11-02 00:20:53'),
(41, 8, 2, 'INITIAL', 2000.00, 2000.00, 'Ingredient created', '2025-11-02 00:24:58'),
(42, 9, 2, 'INITIAL', 20.00, 20.00, 'Ingredient created', '2025-11-02 00:29:37'),
(43, 10, NULL, 'INITIAL', 20.00, 20.00, 'Ingredient created', '2025-11-02 00:34:54'),
(44, 7, 2, 'WASTE', -20.00, 30.00, 'Rotten', '2025-11-02 00:51:06'),
(45, 10, NULL, 'ORDER_DEDUCT', 5.00, 15.00, 'Order ID: 14', '2025-11-02 16:34:57'),
(46, 4, NULL, 'ORDER_DEDUCT', 3.00, 2997.00, 'Order ID: 14', '2025-11-02 16:34:57'),
(47, 10, NULL, 'ORDER_DEDUCT', 5.00, 10.00, 'Order ID: 16', '2025-11-03 00:59:57'),
(48, 4, NULL, 'ORDER_DEDUCT', 3.00, 2994.00, 'Order ID: 16', '2025-11-03 00:59:57'),
(49, 1, NULL, 'ORDER_DEDUCT', 100.00, 1200.00, 'Order ID: 16', '2025-11-03 00:59:57'),
(50, 2, NULL, 'ORDER_DEDUCT', 1.00, 89.00, 'Order ID: 16', '2025-11-03 00:59:57'),
(51, 3, NULL, 'ORDER_DEDUCT', 50.00, 450.00, 'Order ID: 16', '2025-11-03 00:59:57'),
(52, 1, NULL, 'ORDER_DEDUCT', 150.00, 950.00, 'Order ID: 18', '2025-11-03 02:00:26'),
(53, 1, NULL, 'ORDER_DEDUCT', 100.00, 950.00, 'Order ID: 18', '2025-11-03 02:00:26'),
(54, 2, NULL, 'ORDER_DEDUCT', 1.00, 88.00, 'Order ID: 18', '2025-11-03 02:00:26'),
(55, 3, NULL, 'ORDER_DEDUCT', 50.00, 400.00, 'Order ID: 18', '2025-11-03 02:00:26'),
(56, 10, NULL, 'ORDER_DEDUCT', 5.00, 5.00, 'Order ID: 18', '2025-11-03 02:00:26'),
(57, 4, NULL, 'ORDER_DEDUCT', 3.00, 2991.00, 'Order ID: 18', '2025-11-03 02:00:26'),
(58, 1, NULL, 'ORDER_RESTORE', 450.00, 1700.00, 'Order ID: 11', '2025-11-03 02:05:52'),
(59, 1, NULL, 'ORDER_RESTORE', 300.00, 1700.00, 'Order ID: 11', '2025-11-03 02:05:52'),
(60, 2, NULL, 'ORDER_RESTORE', 3.00, 91.00, 'Order ID: 11', '2025-11-03 02:05:52'),
(61, 3, NULL, 'ORDER_RESTORE', 150.00, 550.00, 'Order ID: 11', '2025-11-03 02:05:52'),
(62, 10, NULL, 'ORDER_DEDUCT', 5.00, 0.00, 'Order ID: 19', '2025-11-03 02:08:56'),
(63, 4, NULL, 'ORDER_DEDUCT', 3.00, 2988.00, 'Order ID: 19', '2025-11-03 02:08:56'),
(64, 10, 6, 'RESTOCK', 99.00, 99.00, NULL, '2025-11-03 02:13:58'),
(65, 1, NULL, 'ORDER_DEDUCT', 200.00, 1500.00, 'Order ID: 21', '2025-11-03 02:14:20'),
(66, 2, NULL, 'ORDER_DEDUCT', 2.00, 89.00, 'Order ID: 21', '2025-11-03 02:14:20'),
(67, 3, NULL, 'ORDER_DEDUCT', 100.00, 450.00, 'Order ID: 21', '2025-11-03 02:14:20'),
(68, 1, NULL, 'ORDER_DEDUCT', 200.00, 1300.00, 'Order ID: 20', '2025-11-03 02:23:20'),
(69, 2, NULL, 'ORDER_DEDUCT', 2.00, 87.00, 'Order ID: 20', '2025-11-03 02:23:20'),
(70, 3, NULL, 'ORDER_DEDUCT', 100.00, 350.00, 'Order ID: 20', '2025-11-03 02:23:20'),
(71, 1, NULL, 'ORDER_DEDUCT', 300.00, 1000.00, 'Order ID: 23', '2025-11-03 02:33:09'),
(72, 10, NULL, 'ORDER_DEDUCT', 5.00, 94.00, 'Order ID: 25', '2025-11-03 03:14:37'),
(73, 4, NULL, 'ORDER_DEDUCT', 3.00, 2985.00, 'Order ID: 25', '2025-11-03 03:14:37'),
(74, 10, NULL, 'ORDER_DEDUCT', 5.00, 89.00, 'Order ID: 26', '2025-11-03 03:24:04'),
(75, 4, NULL, 'ORDER_DEDUCT', 3.00, 2982.00, 'Order ID: 26', '2025-11-03 03:24:04'),
(76, 1, NULL, 'ORDER_DEDUCT', 100.00, 900.00, 'Order ID: 26', '2025-11-03 03:24:04'),
(77, 2, NULL, 'ORDER_DEDUCT', 1.00, 86.00, 'Order ID: 26', '2025-11-03 03:24:04'),
(78, 3, NULL, 'ORDER_DEDUCT', 50.00, 300.00, 'Order ID: 26', '2025-11-03 03:24:04'),
(79, 10, NULL, 'ORDER_DEDUCT', 5.00, 84.00, 'Order ID: 29', '2025-11-03 03:38:48'),
(80, 4, NULL, 'ORDER_DEDUCT', 3.00, 2979.00, 'Order ID: 29', '2025-11-03 03:38:48'),
(81, 10, NULL, 'ORDER_DEDUCT', 5.00, 79.00, 'Order ID: 29', '2025-11-03 03:46:47'),
(82, 4, NULL, 'ORDER_DEDUCT', 3.00, 2976.00, 'Order ID: 29', '2025-11-03 03:46:47'),
(83, 1, NULL, 'ORDER_DEDUCT', 150.00, 750.00, 'Order ID: 30', '2025-11-03 03:50:05'),
(84, 10, NULL, 'ORDER_DEDUCT', 5.00, 74.00, 'Order ID: 32', '2025-11-03 03:57:14'),
(85, 4, NULL, 'ORDER_DEDUCT', 3.00, 2973.00, 'Order ID: 32', '2025-11-03 03:57:14'),
(86, 1, NULL, 'ORDER_DEDUCT', 150.00, 600.00, 'Order ID: 30', '2025-11-03 03:59:41'),
(87, 1, NULL, 'ORDER_DEDUCT', 150.00, 350.00, 'Order ID: 33', '2025-11-05 04:54:02'),
(88, 1, NULL, 'ORDER_DEDUCT', 100.00, 350.00, 'Order ID: 33', '2025-11-05 04:54:02'),
(89, 2, NULL, 'ORDER_DEDUCT', 1.00, 85.00, 'Order ID: 33', '2025-11-05 04:54:02'),
(90, 3, NULL, 'ORDER_DEDUCT', 50.00, 250.00, 'Order ID: 33', '2025-11-05 04:54:02'),
(91, 1, NULL, 'ORDER_DEDUCT', 300.00, -50.00, 'Order ID: 35', '2025-11-05 05:11:22'),
(92, 1, NULL, 'ORDER_DEDUCT', 100.00, -50.00, 'Order ID: 35', '2025-11-05 05:11:22'),
(93, 2, NULL, 'ORDER_DEDUCT', 1.00, 84.00, 'Order ID: 35', '2025-11-05 05:11:22'),
(94, 3, NULL, 'ORDER_DEDUCT', 50.00, 200.00, 'Order ID: 35', '2025-11-05 05:11:22'),
(95, 1, 5, 'RESTOCK', 999.00, 949.00, NULL, '2025-11-05 05:12:00'),
(96, 1, NULL, 'ORDER_DEDUCT', 300.00, 549.00, 'Order ID: 35', '2025-11-05 05:12:07'),
(97, 1, NULL, 'ORDER_DEDUCT', 100.00, 549.00, 'Order ID: 35', '2025-11-05 05:12:07'),
(98, 2, NULL, 'ORDER_DEDUCT', 1.00, 83.00, 'Order ID: 35', '2025-11-05 05:12:07'),
(99, 3, NULL, 'ORDER_DEDUCT', 50.00, 150.00, 'Order ID: 35', '2025-11-05 05:12:07'),
(100, 1, NULL, 'ORDER_DEDUCT', 150.00, 299.00, 'Order ID: 36', '2025-11-05 05:42:47'),
(101, 1, NULL, 'ORDER_DEDUCT', 100.00, 299.00, 'Order ID: 36', '2025-11-05 05:42:47'),
(102, 2, NULL, 'ORDER_DEDUCT', 1.00, 82.00, 'Order ID: 36', '2025-11-05 05:42:47'),
(103, 3, NULL, 'ORDER_DEDUCT', 50.00, 100.00, 'Order ID: 36', '2025-11-05 05:42:47'),
(104, 1, 6, 'ADJUST_SUBTRACT', 9.00, 290.00, NULL, '2025-11-05 06:00:21'),
(105, 1, 6, 'ADJUST_SUBTRACT', 281.00, 9.00, NULL, '2025-11-05 06:00:55'),
(106, 10, NULL, 'ORDER_DEDUCT', 5.00, 69.00, 'Order ID: 38', '2025-11-05 06:58:35'),
(107, 4, NULL, 'ORDER_DEDUCT', 3.00, 2970.00, 'Order ID: 38', '2025-11-05 06:58:35'),
(108, 10, NULL, 'ORDER_DEDUCT', 5.00, 64.00, 'Order ID: 39', '2025-11-05 07:01:37'),
(109, 4, NULL, 'ORDER_DEDUCT', 3.00, 2967.00, 'Order ID: 39', '2025-11-05 07:01:37'),
(110, 10, NULL, 'ORDER_DEDUCT', 10.00, 54.00, 'Order ID: 42', '2025-11-05 07:19:31'),
(111, 4, NULL, 'ORDER_DEDUCT', 6.00, 2961.00, 'Order ID: 42', '2025-11-05 07:19:31'),
(112, 10, NULL, 'ORDER_DEDUCT', 5.00, 49.00, 'Order ID: 39', '2025-11-05 07:26:23'),
(113, 4, NULL, 'ORDER_DEDUCT', 3.00, 2958.00, 'Order ID: 39', '2025-11-05 07:26:23'),
(114, 2, 6, 'ADJUST_SUBTRACT', 70.00, 12.00, NULL, '2025-11-05 07:35:41'),
(115, 3, 6, 'ADJUST_SUBTRACT', 90.00, 10.00, NULL, '2025-11-05 07:35:49'),
(116, 4, 6, 'ADJUST_SUBTRACT', 2940.00, 18.00, NULL, '2025-11-05 07:36:04'),
(117, 8, 6, 'ADJUST_SUBTRACT', 1990.00, 10.00, NULL, '2025-11-05 07:36:16'),
(118, 2, 6, 'ADJUST_SUBTRACT', 3.00, 9.00, NULL, '2025-11-05 07:36:48'),
(119, 3, 6, 'ADJUST_SUBTRACT', 3.00, 7.00, NULL, '2025-11-05 07:37:00'),
(120, 4, 6, 'ADJUST_SUBTRACT', 9.00, 9.00, NULL, '2025-11-05 07:37:08'),
(121, 1, 6, 'RESTOCK', 20.00, 29.00, NULL, '2025-11-05 18:11:10'),
(122, 1, 6, 'RESTOCK', 500.00, 529.00, NULL, '2025-11-05 18:11:43'),
(123, 1, NULL, 'ORDER_DEDUCT', 150.00, 379.00, 'Order ID: 45', '2025-11-05 18:11:48'),
(124, 1, NULL, 'ORDER_DEDUCT', 300.00, 79.00, 'Order ID: 46', '2025-11-05 18:17:30'),
(125, 1, 6, 'RESTOCK', 1000.00, 1079.00, NULL, '2025-11-05 18:18:02'),
(126, 1, NULL, 'ORDER_DEDUCT', 300.00, 779.00, 'Order ID: 46', '2025-11-05 18:18:06'),
(127, 2, 6, 'RESTOCK', 100.00, 109.00, NULL, '2025-11-05 18:19:01'),
(128, 3, 6, 'RESTOCK', 1000.00, 1007.00, NULL, '2025-11-05 18:19:10'),
(129, 4, 6, 'RESTOCK', 1000.00, 1009.00, NULL, '2025-11-05 18:19:18'),
(130, 2, 6, 'ADJUST_SUBTRACT', 100.00, 9.00, NULL, '2025-11-05 18:55:34'),
(131, 9, 6, 'ADJUST_SUBTRACT', 11.00, 9.00, NULL, '2025-11-05 18:56:03'),
(132, 10, 6, 'ADJUST_SUBTRACT', 40.00, 9.00, NULL, '2025-11-05 18:56:14'),
(133, 10, NULL, 'ORDER_DEDUCT', 5.00, 4.00, 'Order ID: 38', '2025-11-06 01:54:47'),
(134, 4, NULL, 'ORDER_DEDUCT', 3.00, 1006.00, 'Order ID: 38', '2025-11-06 01:54:47'),
(135, 10, 6, 'RESTOCK', 100.00, 104.00, NULL, '2025-11-06 01:56:52'),
(136, 1, NULL, 'ORDER_DEDUCT', 100.00, 679.00, 'Order ID: 48', '2025-11-06 01:57:30'),
(137, 2, NULL, 'ORDER_DEDUCT', 1.00, 8.00, 'Order ID: 48', '2025-11-06 01:57:30'),
(138, 3, NULL, 'ORDER_DEDUCT', 50.00, 957.00, 'Order ID: 48', '2025-11-06 01:57:30'),
(139, 10, NULL, 'ORDER_DEDUCT', 5.00, 99.00, 'Order ID: 48', '2025-11-06 01:57:30'),
(140, 4, NULL, 'ORDER_DEDUCT', 3.00, 1003.00, 'Order ID: 48', '2025-11-06 01:57:30'),
(141, 1, NULL, 'ORDER_DEDUCT', 100.00, 579.00, 'Order ID: 49', '2025-11-06 02:00:28'),
(142, 2, NULL, 'ORDER_DEDUCT', 1.00, 7.00, 'Order ID: 49', '2025-11-06 02:00:28'),
(143, 3, NULL, 'ORDER_DEDUCT', 50.00, 907.00, 'Order ID: 49', '2025-11-06 02:00:28'),
(144, 10, NULL, 'ORDER_DEDUCT', 5.00, 94.00, 'Order ID: 49', '2025-11-06 02:00:28'),
(145, 4, NULL, 'ORDER_DEDUCT', 3.00, 1000.00, 'Order ID: 49', '2025-11-06 02:00:28'),
(146, 1, NULL, 'ORDER_DEDUCT', 100.00, 479.00, 'Order ID: 49', '2025-11-06 02:01:38'),
(147, 2, NULL, 'ORDER_DEDUCT', 1.00, 6.00, 'Order ID: 49', '2025-11-06 02:01:38'),
(148, 3, NULL, 'ORDER_DEDUCT', 50.00, 857.00, 'Order ID: 49', '2025-11-06 02:01:38'),
(149, 10, NULL, 'ORDER_DEDUCT', 5.00, 89.00, 'Order ID: 49', '2025-11-06 02:01:38'),
(150, 4, NULL, 'ORDER_DEDUCT', 3.00, 997.00, 'Order ID: 49', '2025-11-06 02:01:38'),
(151, 1, NULL, 'ORDER_DEDUCT', 150.00, 229.00, 'Order ID: 50', '2025-11-06 02:21:13'),
(152, 1, NULL, 'ORDER_DEDUCT', 100.00, 229.00, 'Order ID: 50', '2025-11-06 02:21:13'),
(153, 2, NULL, 'ORDER_DEDUCT', 1.00, 5.00, 'Order ID: 50', '2025-11-06 02:21:13'),
(154, 3, NULL, 'ORDER_DEDUCT', 50.00, 807.00, 'Order ID: 50', '2025-11-06 02:21:13'),
(155, 1, NULL, 'ORDER_DEDUCT', 100.00, 129.00, 'Order ID: 51', '2025-11-06 02:30:35'),
(156, 2, NULL, 'ORDER_DEDUCT', 1.00, 4.00, 'Order ID: 51', '2025-11-06 02:30:35'),
(157, 3, NULL, 'ORDER_DEDUCT', 50.00, 757.00, 'Order ID: 51', '2025-11-06 02:30:35'),
(158, 10, NULL, 'ORDER_DEDUCT', 5.00, 84.00, 'Order ID: 51', '2025-11-06 02:30:35'),
(159, 4, NULL, 'ORDER_DEDUCT', 3.00, 994.00, 'Order ID: 51', '2025-11-06 02:30:35'),
(160, 1, 6, 'RESTOCK', 10000.00, 10129.00, NULL, '2025-11-06 03:17:41'),
(161, 1, NULL, 'ORDER_DEDUCT', 150.00, 9879.00, 'Order ID: 52', '2025-11-06 03:17:53'),
(162, 1, NULL, 'ORDER_DEDUCT', 100.00, 9879.00, 'Order ID: 52', '2025-11-06 03:17:53'),
(163, 2, NULL, 'ORDER_DEDUCT', 1.00, 3.00, 'Order ID: 52', '2025-11-06 03:17:53'),
(164, 3, NULL, 'ORDER_DEDUCT', 50.00, 707.00, 'Order ID: 52', '2025-11-06 03:17:53'),
(165, 10, NULL, 'ORDER_DEDUCT', 5.00, 79.00, 'Order ID: 52', '2025-11-06 03:17:53'),
(166, 4, NULL, 'ORDER_DEDUCT', 3.00, 991.00, 'Order ID: 52', '2025-11-06 03:17:53'),
(167, 1, NULL, 'ORDER_DEDUCT', 100.00, 9779.00, 'Order ID: 13', '2025-11-06 03:18:37'),
(168, 2, NULL, 'ORDER_DEDUCT', 1.00, 2.00, 'Order ID: 13', '2025-11-06 03:18:37'),
(169, 3, NULL, 'ORDER_DEDUCT', 50.00, 657.00, 'Order ID: 13', '2025-11-06 03:18:37'),
(170, 10, NULL, 'ORDER_DEDUCT', 5.00, 74.00, 'Order ID: 16', '2025-11-06 03:18:38'),
(171, 4, NULL, 'ORDER_DEDUCT', 3.00, 988.00, 'Order ID: 16', '2025-11-06 03:18:38'),
(172, 1, NULL, 'ORDER_DEDUCT', 100.00, 9679.00, 'Order ID: 16', '2025-11-06 03:18:38'),
(173, 2, NULL, 'ORDER_DEDUCT', 1.00, 1.00, 'Order ID: 16', '2025-11-06 03:18:38'),
(174, 3, NULL, 'ORDER_DEDUCT', 50.00, 607.00, 'Order ID: 16', '2025-11-06 03:18:38'),
(175, 10, NULL, 'ORDER_DEDUCT', 5.00, 69.00, 'Order ID: 19', '2025-11-06 03:18:39'),
(176, 4, NULL, 'ORDER_DEDUCT', 3.00, 985.00, 'Order ID: 19', '2025-11-06 03:18:39'),
(177, 2, 6, 'RESTOCK', 10000.00, 10001.00, NULL, '2025-11-06 03:19:00'),
(178, 8, 6, 'RESTOCK', 10000.00, 10010.00, NULL, '2025-11-06 03:19:07'),
(179, 9, 6, 'RESTOCK', 10000.00, 10009.00, NULL, '2025-11-06 03:19:16'),
(180, 1, NULL, 'ORDER_DEDUCT', 200.00, 9479.00, 'Order ID: 21', '2025-11-06 03:19:24'),
(181, 2, NULL, 'ORDER_DEDUCT', 2.00, 9999.00, 'Order ID: 21', '2025-11-06 03:19:24'),
(182, 3, NULL, 'ORDER_DEDUCT', 100.00, 507.00, 'Order ID: 21', '2025-11-06 03:19:24'),
(183, 1, NULL, 'ORDER_DEDUCT', 100.00, 9379.00, 'Order ID: 22', '2025-11-06 03:19:25'),
(184, 2, NULL, 'ORDER_DEDUCT', 1.00, 9998.00, 'Order ID: 22', '2025-11-06 03:19:25'),
(185, 3, NULL, 'ORDER_DEDUCT', 50.00, 457.00, 'Order ID: 22', '2025-11-06 03:19:25'),
(186, 1, NULL, 'ORDER_DEDUCT', 100.00, 9279.00, 'Order ID: 24', '2025-11-06 03:19:26'),
(187, 2, NULL, 'ORDER_DEDUCT', 1.00, 9997.00, 'Order ID: 24', '2025-11-06 03:19:26'),
(188, 3, NULL, 'ORDER_DEDUCT', 50.00, 407.00, 'Order ID: 24', '2025-11-06 03:19:26'),
(189, 1, NULL, 'ORDER_DEDUCT', 100.00, 9179.00, 'Order ID: 27', '2025-11-06 03:19:27'),
(190, 2, NULL, 'ORDER_DEDUCT', 1.00, 9996.00, 'Order ID: 27', '2025-11-06 03:19:27'),
(191, 3, NULL, 'ORDER_DEDUCT', 50.00, 357.00, 'Order ID: 27', '2025-11-06 03:19:27'),
(192, 10, NULL, 'ORDER_DEDUCT', 5.00, 64.00, 'Order ID: 28', '2025-11-06 03:19:27'),
(193, 4, NULL, 'ORDER_DEDUCT', 3.00, 982.00, 'Order ID: 28', '2025-11-06 03:19:27'),
(194, 1, NULL, 'ORDER_DEDUCT', 150.00, 9029.00, 'Order ID: 31', '2025-11-06 03:19:28'),
(195, 10, NULL, 'ORDER_DEDUCT', 5.00, 59.00, 'Order ID: 32', '2025-11-06 03:19:28'),
(196, 4, NULL, 'ORDER_DEDUCT', 3.00, 979.00, 'Order ID: 32', '2025-11-06 03:19:28'),
(197, 1, NULL, 'ORDER_DEDUCT', 150.00, 8779.00, 'Order ID: 34', '2025-11-06 03:19:29'),
(198, 1, NULL, 'ORDER_DEDUCT', 100.00, 8779.00, 'Order ID: 34', '2025-11-06 03:19:29'),
(199, 2, NULL, 'ORDER_DEDUCT', 1.00, 9995.00, 'Order ID: 34', '2025-11-06 03:19:29'),
(200, 3, NULL, 'ORDER_DEDUCT', 50.00, 307.00, 'Order ID: 34', '2025-11-06 03:19:29'),
(201, 1, NULL, 'ORDER_DEDUCT', 200.00, 8579.00, 'Order ID: 53', '2025-11-06 03:19:55'),
(202, 2, NULL, 'ORDER_DEDUCT', 2.00, 9993.00, 'Order ID: 53', '2025-11-06 03:19:55'),
(203, 3, NULL, 'ORDER_DEDUCT', 100.00, 207.00, 'Order ID: 53', '2025-11-06 03:19:55'),
(204, 10, NULL, 'ORDER_DEDUCT', 5.00, 54.00, 'Order ID: 53', '2025-11-06 03:19:55'),
(205, 4, NULL, 'ORDER_DEDUCT', 3.00, 976.00, 'Order ID: 53', '2025-11-06 03:19:55'),
(206, 1, NULL, 'ORDER_DEDUCT', 100.00, 8479.00, 'Order ID: 54', '2025-11-06 03:20:04'),
(207, 2, NULL, 'ORDER_DEDUCT', 1.00, 9992.00, 'Order ID: 54', '2025-11-06 03:20:04'),
(208, 3, NULL, 'ORDER_DEDUCT', 50.00, 157.00, 'Order ID: 54', '2025-11-06 03:20:04'),
(209, 10, NULL, 'ORDER_DEDUCT', 5.00, 49.00, 'Order ID: 54', '2025-11-06 03:20:04'),
(210, 4, NULL, 'ORDER_DEDUCT', 3.00, 973.00, 'Order ID: 54', '2025-11-06 03:20:04'),
(211, 10, NULL, 'ORDER_DEDUCT', 5.00, 44.00, 'Order ID: 55', '2025-11-06 03:20:16'),
(212, 4, NULL, 'ORDER_DEDUCT', 3.00, 970.00, 'Order ID: 55', '2025-11-06 03:20:16'),
(213, 1, NULL, 'ORDER_DEDUCT', 200.00, 8279.00, 'Order ID: 55', '2025-11-06 03:20:16'),
(214, 2, NULL, 'ORDER_DEDUCT', 2.00, 9990.00, 'Order ID: 55', '2025-11-06 03:20:16'),
(215, 3, NULL, 'ORDER_DEDUCT', 100.00, 57.00, 'Order ID: 55', '2025-11-06 03:20:16'),
(216, 3, 6, 'RESTOCK', 10000.00, 10057.00, NULL, '2025-11-06 03:20:44'),
(217, 10, NULL, 'ORDER_DEDUCT', 5.00, 39.00, 'Order ID: 56', '2025-11-06 03:20:57'),
(218, 4, NULL, 'ORDER_DEDUCT', 3.00, 967.00, 'Order ID: 56', '2025-11-06 03:20:57'),
(219, 1, NULL, 'ORDER_DEDUCT', 100.00, 8179.00, 'Order ID: 56', '2025-11-06 03:20:57'),
(220, 2, NULL, 'ORDER_DEDUCT', 1.00, 9989.00, 'Order ID: 56', '2025-11-06 03:20:57'),
(221, 3, NULL, 'ORDER_DEDUCT', 50.00, 10007.00, 'Order ID: 56', '2025-11-06 03:20:57'),
(222, 1, NULL, 'ORDER_DEDUCT', 200.00, 7979.00, 'Order ID: 53', '2025-11-06 03:21:49'),
(223, 2, NULL, 'ORDER_DEDUCT', 2.00, 9987.00, 'Order ID: 53', '2025-11-06 03:21:49'),
(224, 3, NULL, 'ORDER_DEDUCT', 100.00, 9907.00, 'Order ID: 53', '2025-11-06 03:21:49'),
(225, 10, NULL, 'ORDER_DEDUCT', 5.00, 34.00, 'Order ID: 53', '2025-11-06 03:21:49'),
(226, 4, NULL, 'ORDER_DEDUCT', 3.00, 964.00, 'Order ID: 53', '2025-11-06 03:21:49'),
(227, 1, NULL, 'ORDER_DEDUCT', 100.00, 7879.00, 'Order ID: 54', '2025-11-06 03:21:50'),
(228, 2, NULL, 'ORDER_DEDUCT', 1.00, 9986.00, 'Order ID: 54', '2025-11-06 03:21:50'),
(229, 3, NULL, 'ORDER_DEDUCT', 50.00, 9857.00, 'Order ID: 54', '2025-11-06 03:21:50'),
(230, 10, NULL, 'ORDER_DEDUCT', 5.00, 29.00, 'Order ID: 54', '2025-11-06 03:21:50'),
(231, 4, NULL, 'ORDER_DEDUCT', 3.00, 961.00, 'Order ID: 54', '2025-11-06 03:21:50'),
(232, 10, NULL, 'ORDER_DEDUCT', 5.00, 24.00, 'Order ID: 55', '2025-11-06 03:21:50'),
(233, 4, NULL, 'ORDER_DEDUCT', 3.00, 958.00, 'Order ID: 55', '2025-11-06 03:21:50'),
(234, 1, NULL, 'ORDER_DEDUCT', 200.00, 7679.00, 'Order ID: 55', '2025-11-06 03:21:50'),
(235, 2, NULL, 'ORDER_DEDUCT', 2.00, 9984.00, 'Order ID: 55', '2025-11-06 03:21:50'),
(236, 3, NULL, 'ORDER_DEDUCT', 100.00, 9757.00, 'Order ID: 55', '2025-11-06 03:21:50'),
(237, 10, NULL, 'ORDER_DEDUCT', 5.00, 19.00, 'Order ID: 56', '2025-11-06 03:21:51'),
(238, 4, NULL, 'ORDER_DEDUCT', 3.00, 955.00, 'Order ID: 56', '2025-11-06 03:21:51'),
(239, 1, NULL, 'ORDER_DEDUCT', 100.00, 7579.00, 'Order ID: 56', '2025-11-06 03:21:51'),
(240, 2, NULL, 'ORDER_DEDUCT', 1.00, 9983.00, 'Order ID: 56', '2025-11-06 03:21:51'),
(241, 3, NULL, 'ORDER_DEDUCT', 50.00, 9707.00, 'Order ID: 56', '2025-11-06 03:21:51'),
(242, 11, 6, 'INITIAL', 1000.00, 1000.00, 'Ingredient created', '2025-11-06 15:48:41'),
(243, 10, 5, 'ADJUST_SUBTRACT', 11.00, 8.00, NULL, '2025-11-07 07:00:29'),
(244, 7, 5, 'ADJUST_SUBTRACT', 21.00, 9.00, NULL, '2025-11-07 07:00:44'),
(245, 6, 5, 'ADJUST_SUBTRACT', 101.00, 9.00, NULL, '2025-11-07 07:01:21'),
(246, 10, 6, 'RESTOCK', 100.00, 108.00, 'New Delivery', '2025-11-08 03:17:12'),
(247, 1, NULL, 'ORDER_DEDUCT', 23.00, 7556.00, 'Order ID: 62', '2025-11-08 03:26:53'),
(248, 2, NULL, 'ORDER_DEDUCT', 1.00, 9982.00, 'Order ID: 61', '2025-11-08 03:38:34'),
(249, 7, NULL, 'ORDER_DEDUCT', 1.00, 8.00, 'Order ID: 61', '2025-11-08 03:38:34'),
(250, 1, NULL, 'ORDER_DEDUCT', 23.00, 7533.00, 'Order ID: 61', '2025-11-08 03:38:34'),
(251, 10, 6, 'ADJUST_SUBTRACT', 100.00, 8.00, NULL, '2025-11-08 03:42:24'),
(252, 10, 6, 'RESTOCK', 100.00, 108.00, NULL, '2025-11-08 03:44:17'),
(253, 10, 6, 'ADJUST_SUBTRACT', 100.00, 8.00, NULL, '2025-11-08 03:45:21'),
(254, 1, NULL, 'ORDER_DEDUCT', 33.00, 7500.00, 'Order ID: 64', '2025-11-11 08:20:08'),
(255, 1, NULL, 'ORDER_DEDUCT', 100.00, 7400.00, 'Order ID: 63', '2025-11-11 08:20:08'),
(256, 2, NULL, 'ORDER_DEDUCT', 1.00, 9981.00, 'Order ID: 63', '2025-11-11 08:20:08'),
(257, 3, NULL, 'ORDER_DEDUCT', 50.00, 9657.00, 'Order ID: 63', '2025-11-11 08:20:08'),
(258, 1, NULL, 'ORDER_DEDUCT', 100.00, 7297.00, 'Order ID: 58', '2025-11-11 08:20:10'),
(259, 2, NULL, 'ORDER_DEDUCT', 1.00, 9970.00, 'Order ID: 58', '2025-11-11 08:20:10'),
(260, 3, NULL, 'ORDER_DEDUCT', 50.00, 9603.00, 'Order ID: 58', '2025-11-11 08:20:10'),
(261, 1, NULL, 'ORDER_DEDUCT', 3.00, 7297.00, 'Order ID: 58', '2025-11-11 08:20:10'),
(262, 2, NULL, 'ORDER_DEDUCT', 2.00, 9970.00, 'Order ID: 58', '2025-11-11 08:20:10'),
(263, 4, NULL, 'ORDER_DEDUCT', 8.00, 947.00, 'Order ID: 58', '2025-11-11 08:20:10'),
(264, 3, NULL, 'ORDER_DEDUCT', 4.00, 9603.00, 'Order ID: 58', '2025-11-11 08:20:10'),
(265, 8, NULL, 'ORDER_DEDUCT', 6.00, 10004.00, 'Order ID: 58', '2025-11-11 08:20:10'),
(266, 2, NULL, 'ORDER_DEDUCT', 2.00, 9970.00, 'Order ID: 58', '2025-11-11 08:20:10'),
(267, 11, NULL, 'ORDER_DEDUCT', 2.00, 998.00, 'Order ID: 58', '2025-11-11 08:20:10'),
(268, 2, NULL, 'ORDER_DEDUCT', 6.00, 9970.00, 'Order ID: 58', '2025-11-11 08:20:10'),
(269, 4, NULL, 'ORDER_DEDUCT', 8.00, 939.00, 'Order ID: 60', '2025-11-11 08:20:11'),
(270, 3, NULL, 'ORDER_DEDUCT', 4.00, 9599.00, 'Order ID: 60', '2025-11-11 08:20:11'),
(271, 8, NULL, 'ORDER_DEDUCT', 4.00, 10000.00, 'Order ID: 60', '2025-11-11 08:20:11'),
(272, 1, NULL, 'ORDER_DEDUCT', 100.00, 7174.00, 'Order ID: 59', '2025-11-11 08:20:11'),
(273, 2, NULL, 'ORDER_DEDUCT', 1.00, 9968.00, 'Order ID: 59', '2025-11-11 08:20:11'),
(274, 3, NULL, 'ORDER_DEDUCT', 50.00, 9549.00, 'Order ID: 59', '2025-11-11 08:20:11'),
(275, 2, NULL, 'ORDER_DEDUCT', 1.00, 9968.00, 'Order ID: 59', '2025-11-11 08:20:12'),
(276, 7, NULL, 'ORDER_DEDUCT', 1.00, 7.00, 'Order ID: 59', '2025-11-11 08:20:12'),
(277, 1, NULL, 'ORDER_DEDUCT', 23.00, 7174.00, 'Order ID: 59', '2025-11-11 08:20:12'),
(278, 2, NULL, 'ORDER_DEDUCT', 1.00, 9967.00, 'Order ID: 65', '2025-11-11 08:21:30'),
(279, 7, NULL, 'ORDER_DEDUCT', 1.00, 5.00, 'Order ID: 65', '2025-11-11 08:21:30'),
(280, 1, NULL, 'ORDER_DEDUCT', 23.00, 7151.00, 'Order ID: 65', '2025-11-11 08:21:30'),
(281, 9, NULL, 'ORDER_DEDUCT', 1.00, 10008.00, 'Order ID: 65', '2025-11-11 08:21:31'),
(282, 10, NULL, 'ORDER_DEDUCT', 1.00, 7.00, 'Order ID: 65', '2025-11-11 08:21:31'),
(283, 6, NULL, 'ORDER_DEDUCT', 1.00, 8.00, 'Order ID: 65', '2025-11-11 08:21:31'),
(284, 7, NULL, 'ORDER_DEDUCT', 1.00, 5.00, 'Order ID: 65', '2025-11-11 08:21:31'),
(285, 4, NULL, 'ORDER_DEDUCT', 1.00, 938.00, 'Order ID: 65', '2025-11-11 08:21:31'),
(286, 11, NULL, 'ORDER_DEDUCT', 2.00, 996.00, 'Order ID: 66', '2025-11-11 08:23:45'),
(287, 2, NULL, 'ORDER_DEDUCT', 1.00, 9965.00, 'Order ID: 66', '2025-11-11 08:23:45'),
(288, 7, NULL, 'ORDER_DEDUCT', 1.00, 4.00, 'Order ID: 66', '2025-11-11 08:23:45'),
(289, 1, NULL, 'ORDER_DEDUCT', 23.00, 7028.00, 'Order ID: 66', '2025-11-11 08:23:46'),
(290, 1, NULL, 'ORDER_DEDUCT', 100.00, 7028.00, 'Order ID: 66', '2025-11-11 08:23:46'),
(291, 2, NULL, 'ORDER_DEDUCT', 1.00, 9965.00, 'Order ID: 66', '2025-11-11 08:23:46'),
(292, 3, NULL, 'ORDER_DEDUCT', 50.00, 9499.00, 'Order ID: 66', '2025-11-11 08:23:46');

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
(1, 'Beef Steak', 2, 789.00, '/uploads\\image-1761969784106.jpg', 'Juicy Steak in the house!', 1, 10, '2025-11-11'),
(2, 'Cheese Burger', 1, 220.00, '/uploads\\image-1761996893473.jpg', 'A slice of cheese melted on top of the ground meat patty', 1, 15, '2025-11-11'),
(4, 'Bruschetta Trio', 1, 350.00, '/uploads\\image-1762442483719.jpeg', 'Toasted bread with tomato basil, mushroom, and tapenade.', 0, NULL, NULL),
(5, 'Classic Caesar Salad', 1, 380.00, '/uploads\\image-1762442760130.jpg', 'Romaine lettuce, parmesan, croutons, Caesar dressing', 0, NULL, NULL),
(6, 'Crispy Calamari', 1, 380.00, '/uploads\\image-1762443670734.jpeg', 'Lightly breaded squid rings with marinara sauce', 1, 10, '2025-11-11'),
(7, 'Buffalo Wings', 1, 360.00, '/uploads\\image-1762443753401.jpeg', '8 pieces of spicy chicken wings with blue cheese dip', 0, NULL, NULL),
(8, 'Spring Rolls', 1, 320.00, '/uploads\\image-1762443810407.jpeg', '6 pieces vegetable spring rolls with sweet chili sauce', 0, NULL, NULL),
(9, 'Mango shake', 4, 180.00, '/uploads\\image-1762444176596.jpg', 'Refreshing mango juice', 0, NULL, NULL),
(10, 'Lemon juice', 4, 180.00, '/uploads\\image-1762444258424.jpg', 'Refreshing lemon juice', 0, NULL, NULL),
(11, 'Watermelon Juice', 4, 170.00, '/uploads\\image-1762444340048.jpg', 'Fresh watermelon juice with mint', 0, NULL, NULL),
(12, 'Bubble Tea', 4, 195.00, '/uploads\\image-1762444399414.jpg', 'Milk tea with tapioca pearls', 0, NULL, NULL),
(13, 'Cappuccino', 4, 185.00, '/uploads\\image-1762444462113.jpeg', 'Espresso with steamed milk and foam', 0, NULL, NULL),
(14, 'Hot chocolate', 4, 190.00, '/uploads\\image-1762444509441.jpeg', 'Rich chocolate drink topped with marshmallows', 0, NULL, NULL),
(15, 'Chocolate Milkshake', 4, 196.00, '/uploads\\image-1762444576990.jpeg', 'Thick chocolate milkshake with whipped cream', 0, NULL, NULL),
(16, 'Grilled Salmon Steak', 2, 723.00, '/uploads\\image-1762444668183.jpeg', 'Fresh Atlantic salmon with herb butter and seasonal vegetables', 0, NULL, NULL),
(17, 'Wagyu Beef Burger', 2, 550.00, '/uploads\\image-1762444730701.jpg', 'Premium wagyu patty with caramelized onions and truffle aioli', 0, NULL, NULL),
(18, 'Pork Cordon Bleu', 2, 620.00, '/uploads\\image-1762444932219.jpg', 'Breaded Pork stuffed with ham and cheese', 0, NULL, NULL),
(19, 'Truffle Pasta', 2, 345.00, '/uploads\\image-1762445028588.jpg', 'Homemade pasta with black truffle and wild mushrooms', 0, NULL, NULL),
(20, 'Seafood Paella', 2, 749.00, '/uploads\\image-1762445105671.jpg', 'panish rice with assorted seafood and saffron', 0, NULL, NULL),
(21, 'Mango Cheesecake', 3, 280.00, '/uploads\\image-1762445289118.jpg', 'Creamy cheesecake with fresh mango compote', 0, NULL, NULL),
(22, 'Chocolate Lava Cake', 3, 180.00, '/uploads\\image-1762445355610.png', 'Warm chocolate cake with molten center and vanilla ice cream', 0, NULL, NULL),
(23, 'Tiramisu', 3, 130.00, '/uploads\\image-1762445416324.jpeg', 'Italian coffee-flavored dessert with mascarpone', 0, NULL, NULL),
(24, 'French Macarons', 3, 380.00, '/uploads\\image-1762445489084.jpg', 'Assorted flavors of delicate French macarons (6 pieces)', 0, NULL, NULL),
(25, 'Lemon Tart', 3, 285.00, '/uploads\\image-1762445537036.jpeg', 'Tangy lemon curd in a buttery pastry shell', 0, NULL, NULL),
(26, 'Chicken nuggets', 5, 247.00, '/uploads\\image-1762445654119.jpeg', 'Golden crispy chicken nuggets with fries', 0, NULL, NULL),
(27, 'French Fries', 5, 138.00, '/uploads\\image-1762445717744.jpg', 'Crispy golden french fries', 0, NULL, NULL),
(28, 'Mini Sliders', 5, 236.00, '/uploads\\image-1762445774757.jpeg', 'Three mini beef sliders with cheese', 0, NULL, NULL),
(29, 'Fluffy Pancakes', 5, 125.00, '/uploads\\image-1762445850625.jpeg', 'Three fluffy pancakes with syrup and butter', 0, NULL, NULL);

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
(28, 12, 11, 2.00),
(29, 13, 11, 2.00),
(30, 14, 11, 2.00),
(31, 15, 11, 1.00),
(32, 16, 8, 6.00),
(33, 17, 1, 3.00),
(34, 17, 2, 2.00),
(35, 18, 5, 6.00),
(36, 18, 3, 4.00),
(37, 19, 1, 3.00),
(38, 19, 10, 4.00),
(39, 19, 9, 2.00),
(40, 20, 8, 5.00),
(41, 20, 10, 4.00),
(42, 20, 9, 2.00),
(43, 20, 6, 4.00),
(44, 21, 11, 4.00),
(45, 21, 2, 2.00),
(46, 22, 2, 4.00),
(47, 23, 2, 2.00),
(48, 24, 2, 6.00),
(49, 25, 11, 3.00),
(50, 25, 3, 3.00),
(51, 25, 2, 2.00),
(52, 26, 4, 5.00),
(53, 26, 7, 5.00),
(54, 27, 2, 6.00),
(55, 28, 5, 4.00),
(56, 28, 2, 4.00),
(57, 28, 7, 5.00),
(58, 29, 2, 7.00),
(64, 2, 1, 100.00),
(65, 2, 2, 1.00),
(66, 2, 3, 50.00),
(67, 6, 8, 4.00),
(69, 1, 1, 33.00);

-- --------------------------------------------------------

--
-- Table structure for table `fb_notifications`
--

CREATE TABLE `fb_notifications` (
  `notification_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `order_id` int DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `message` text COLLATE utf8mb4_general_ci NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fb_notifications`
--

INSERT INTO `fb_notifications` (`notification_id`, `customer_id`, `order_id`, `title`, `message`, `is_read`, `created_at`) VALUES
(4, 5, 62, 'Order On Its Way!', 'Your order #62 is on its way for delivery!', 1, '2025-11-08 03:27:18'),
(7, 5, 61, 'Order On Its Way!', 'Your order #61 is on its way for delivery!', 1, '2025-11-08 03:38:34'),
(10, 5, 64, 'Order Preparing!', 'Your order #64 is now being prepared.', 0, '2025-11-11 08:20:08'),
(11, 5, 63, 'Order Preparing!', 'Your order #63 is now being prepared.', 0, '2025-11-11 08:20:08'),
(13, 5, 60, 'Order Preparing!', 'Your order #60 is now being prepared.', 0, '2025-11-11 08:20:11'),
(17, 2, 65, 'Order Preparing!', 'Your order #65 is now being prepared.', 0, '2025-11-11 08:21:31'),
(20, 5, 59, 'Order Ready!', 'Your order #59 is ready for pickup/delivery!', 0, '2025-11-11 09:19:49'),
(21, 5, 58, 'Order Ready!', 'Your order #58 is ready for pickup/delivery!', 0, '2025-11-11 09:19:52');

-- --------------------------------------------------------

--
-- Table structure for table `fb_orders`
--

CREATE TABLE `fb_orders` (
  `order_id` int NOT NULL,
  `customer_id` int DEFAULT NULL,
  `staff_id` int DEFAULT NULL,
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

INSERT INTO `fb_orders` (`order_id`, `customer_id`, `staff_id`, `items_total`, `service_charge_amount`, `vat_amount`, `status`, `total_amount`, `order_type`, `delivery_location`, `order_date`) VALUES
(1, 2, NULL, 0.00, 0.00, 0.00, 'served', 1218.78, 'Dine-in', '1', '2025-11-01 04:13:09'),
(2, 2, NULL, 0.00, 0.00, 0.00, 'served', 2437.56, 'Dine-in', '2', '2025-11-01 04:18:34'),
(3, 2, NULL, 0.00, 0.00, 0.00, 'served', 3656.34, 'Dine-in', '3', '2025-11-01 04:30:23'),
(4, 3, NULL, 0.00, 0.00, 0.00, 'served', 4875.12, 'Room Service', '101', '2025-11-01 05:43:18'),
(5, 3, NULL, 0.00, 0.00, 0.00, 'served', NULL, 'Room Service', '102', '2025-11-01 10:50:39'),
(6, 3, NULL, 0.00, 0.00, 0.00, 'served', NULL, 'Room Service', '102', '2025-11-01 10:51:09'),
(7, 3, NULL, 1998.00, 199.80, 263.74, 'served', 2461.54, 'Room Service', '102', '2025-11-01 10:55:17'),
(8, 4, NULL, 2997.00, 299.70, 395.60, 'served', 3692.30, 'Room Service', '103', '2025-11-01 11:13:50'),
(9, 4, NULL, 440.00, 44.00, 58.08, 'served', 542.08, 'Room Service', '105', '2025-11-01 11:36:41'),
(10, NULL, 4, 1219.00, 121.90, 160.91, 'served', 1501.81, 'Walk-in', 'Counter', '2025-11-01 16:23:38'),
(11, 3, NULL, 3657.00, 365.70, 482.72, '', 4505.42, 'Room Service', '106', '2025-11-01 16:40:37'),
(12, NULL, 6, 660.00, 66.00, 87.12, 'served', 813.12, 'Walk-in', 'Counter', '2025-11-01 17:02:05'),
(13, NULL, 6, 220.00, 22.00, 29.04, 'served', 271.04, 'Walk-in', 'Counter', '2025-11-01 23:54:12'),
(14, 5, 2, 150.00, 15.00, 19.80, 'served', 184.80, 'Dine-in', '5', '2025-11-02 16:31:38'),
(15, 5, NULL, 590.00, 59.00, 77.88, '', 726.88, 'Dine-in', '5', '2025-11-03 00:49:50'),
(16, NULL, 6, 370.00, 37.00, 48.84, 'served', 455.84, 'Walk-in', 'Counter', '2025-11-03 00:59:56'),
(17, 5, NULL, 220.00, 22.00, 29.04, '', 271.04, 'Dine-in', '5', '2025-11-03 01:31:10'),
(18, 5, 6, 1369.00, 136.90, 180.71, 'served', 1686.61, 'Room Service', '101', '2025-11-03 01:58:40'),
(19, NULL, 6, 150.00, 15.00, 19.80, 'served', 184.80, 'Walk-in', 'Counter', '2025-11-03 02:08:56'),
(20, 5, 6, 440.00, 44.00, 58.08, 'served', 542.08, 'Dine-in', '1', '2025-11-03 02:11:01'),
(21, NULL, 6, 440.00, 44.00, 58.08, 'served', 542.08, 'Walk-in', 'John', '2025-11-03 02:14:20'),
(22, 5, 6, 220.00, 22.00, 29.04, 'served', 271.04, 'Dine-in', '3', '2025-11-03 02:21:11'),
(23, 5, 6, 1998.00, 199.80, 263.74, 'served', 2461.54, 'Room Service', '101', '2025-11-03 02:32:01'),
(24, 5, 6, 220.00, 22.00, 29.04, 'served', 271.04, 'Dine-in', '5', '2025-11-03 02:53:13'),
(25, 5, 6, 150.00, 15.00, 19.80, 'served', 184.80, 'Dine-in', '2', '2025-11-03 03:09:29'),
(26, 5, 6, 370.00, 37.00, 48.84, 'served', 455.84, 'Dine-in', '69', '2025-11-03 03:23:34'),
(27, 5, 6, 220.00, 22.00, 29.04, 'served', 271.04, 'Room Service', '101', '2025-11-03 03:32:31'),
(28, 5, 6, 150.00, 15.00, 19.80, 'served', 184.80, 'Dine-in', '3', '2025-11-03 03:36:29'),
(29, NULL, 6, 150.00, 15.00, 19.80, 'served', 184.80, 'Walk-in', 'Hezel', '2025-11-03 03:38:48'),
(30, NULL, 6, 999.00, 99.90, 131.87, 'served', 1230.77, 'Walk-in', 'Hezel', '2025-11-03 03:50:05'),
(31, 5, 6, 999.00, 99.90, 131.87, 'served', 1230.77, 'Dine-in', '101', '2025-11-03 03:51:39'),
(32, NULL, 6, 150.00, 15.00, 19.80, 'served', 184.80, 'Walk-in', 'Hezel', '2025-11-03 03:57:14'),
(33, 5, 5, 1219.00, 121.90, 160.91, 'served', 1501.81, 'Room Service', '101', '2025-11-05 04:53:21'),
(34, 5, 6, 1219.00, 121.90, 160.91, 'served', 1501.81, 'Dine-in', '5', '2025-11-05 05:10:35'),
(35, NULL, 5, 2218.00, 221.80, 292.78, 'served', 2732.58, 'Walk-in', 'Hezel', '2025-11-05 05:11:22'),
(36, 5, 6, 1219.00, 121.90, 160.91, 'served', 1501.81, 'Dine-in', '5', '2025-11-05 05:41:18'),
(37, 5, NULL, 370.00, 37.00, 48.84, '', 455.84, 'Dine-in', '4', '2025-11-05 06:54:30'),
(38, NULL, 6, 150.00, 15.00, 19.80, 'served', 184.80, 'Walk-in', 'John', '2025-11-05 06:58:35'),
(39, NULL, 6, 150.00, 15.00, 19.80, 'served', 184.80, 'Walk-in', 'sample', '2025-11-05 07:01:37'),
(41, 5, NULL, 300.00, 30.00, 39.60, '', 369.60, 'Dine-in', '4', '2025-11-05 07:12:13'),
(42, NULL, 6, 300.00, 30.00, 39.60, '', 369.60, 'Walk-in', 'kurt', '2025-11-05 07:19:31'),
(43, 5, NULL, 150.00, 15.00, 19.80, 'cancelled', 184.80, 'Dine-in', '9', '2025-11-05 07:29:27'),
(44, 5, NULL, 150.00, 15.00, 19.80, 'cancelled', 184.80, 'Dine-in', '9', '2025-11-05 07:31:30'),
(45, 5, 6, 999.00, 99.90, 131.87, 'served', 1230.77, 'Room Service', '12', '2025-11-05 18:09:09'),
(46, NULL, 6, 1998.00, 199.80, 263.74, 'served', 2461.54, 'Walk-in', 'Hezel', '2025-11-05 18:17:30'),
(47, 5, NULL, 999.00, 99.90, 131.87, 'cancelled', 1230.77, 'Room Service', '101', '2025-11-06 01:18:24'),
(48, 5, 6, 370.00, 37.00, 48.84, 'served', 455.84, 'Room Service', '101', '2025-11-06 01:56:18'),
(49, NULL, 6, 370.00, 37.00, 48.84, 'served', 455.84, 'Walk-in', 'Hezel', '2025-11-06 02:00:28'),
(50, NULL, 6, 1219.00, 121.90, 160.91, 'cancelled', 1501.81, 'Walk-in', 'Kurt', '2025-11-06 02:21:13'),
(51, 5, 6, 370.00, 37.00, 48.84, 'served', 455.84, 'Dine-in', '6', '2025-11-06 02:30:05'),
(52, 5, 6, 1369.00, 136.90, 180.71, 'served', 1686.61, 'Dine-in', '69', '2025-11-06 03:17:01'),
(53, NULL, 5, 590.00, 59.00, 77.88, 'served', 726.88, 'Walk-in', 'Counter', '2025-11-06 03:19:55'),
(54, NULL, 5, 370.00, 37.00, 48.84, 'served', 455.84, 'Walk-in', 'Counter', '2025-11-06 03:20:04'),
(55, NULL, 5, 590.00, 59.00, 77.88, 'served', 726.88, 'Walk-in', 'Counter', '2025-11-06 03:20:16'),
(56, NULL, 5, 370.00, 37.00, 48.84, 'served', 455.84, 'Walk-in', 'Counter', '2025-11-06 03:20:57'),
(57, 5, 6, 1369.00, 136.90, 180.71, 'cancelled', 1686.61, 'Room Service', '69', '2025-11-06 04:00:23'),
(58, 5, 2, 2311.00, 231.10, 305.05, 'ready', 2847.15, 'Dine-in', '97', '2025-11-06 16:21:08'),
(59, 5, 2, 570.00, 57.00, 75.24, 'ready', 702.24, 'Dine-in', '6', '2025-11-07 07:06:19'),
(60, 5, 4, 740.00, 74.00, 97.68, 'preparing', 911.68, 'Dine-in', '69', '2025-11-07 07:09:54'),
(61, 5, 6, 350.00, 35.00, 46.20, 'served', 431.20, 'Room Service', '27', '2025-11-07 07:19:46'),
(62, 5, 6, 280.00, 28.00, 36.96, 'served', 344.96, 'Dine-in', '9', '2025-11-08 03:25:42'),
(63, 5, 4, 220.00, 22.00, 29.04, 'preparing', 271.04, 'Room Dining', '2', '2025-11-08 03:40:21'),
(64, 5, 4, 789.00, 78.90, 104.15, 'preparing', 972.05, 'Dine-in', '2', '2025-11-08 03:40:35'),
(65, 2, 4, 730.00, 73.00, 96.36, 'preparing', 899.36, 'Room Dining', '303', '2025-11-11 08:20:37'),
(66, 4, 4, 750.00, 75.00, 99.00, 'preparing', 924.00, 'Dine-in', '87', '2025-11-11 08:22:42');

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
(1, 1, 1, 1, 999.00, ''),
(2, 2, 1, 2, 1998.00, ''),
(3, 3, 1, 3, 2997.00, ''),
(4, 4, 1, 4, 3996.00, ''),
(5, 5, 1, 2, 1998.00, ''),
(6, 6, 1, 2, 1998.00, ''),
(7, 7, 1, 2, 1998.00, ''),
(8, 8, 1, 3, 2997.00, ''),
(9, 9, 2, 2, 440.00, ''),
(10, 10, 1, 1, 999.00, ''),
(11, 10, 2, 1, 220.00, ''),
(12, 11, 1, 3, 2997.00, ''),
(13, 11, 2, 3, 660.00, ''),
(14, 12, 2, 3, 660.00, ''),
(15, 13, 2, 1, 220.00, ''),
(17, 15, 2, 2, 440.00, ''),
(20, 16, 2, 1, 220.00, ''),
(21, 17, 2, 1, 220.00, ''),
(22, 18, 1, 1, 999.00, 'extra garlic plsss'),
(23, 18, 2, 1, 220.00, 'extra garlic plsss'),
(26, 20, 2, 2, 440.00, ''),
(27, 21, 2, 2, 440.00, ''),
(28, 22, 2, 1, 220.00, 'xample'),
(29, 23, 1, 2, 1998.00, ''),
(30, 24, 2, 1, 220.00, 'alsd;ajwpodjaskjdwalkdnlaskw'),
(33, 26, 2, 1, 220.00, ''),
(34, 27, 2, 1, 220.00, 'xample'),
(37, 30, 1, 1, 999.00, 'do not overcooked'),
(38, 31, 1, 1, 999.00, ''),
(40, 33, 1, 1, 999.00, ''),
(41, 33, 2, 1, 220.00, ''),
(42, 34, 1, 1, 999.00, ''),
(43, 34, 2, 1, 220.00, ''),
(44, 35, 1, 2, 1998.00, ''),
(45, 35, 2, 1, 220.00, ''),
(46, 36, 1, 1, 999.00, ''),
(47, 36, 2, 1, 220.00, ''),
(48, 37, 2, 1, 220.00, ''),
(57, 45, 1, 1, 999.00, ''),
(58, 46, 1, 2, 1998.00, ''),
(59, 47, 1, 1, 999.00, ''),
(60, 48, 2, 1, 220.00, 'hi.example'),
(62, 49, 2, 1, 220.00, ''),
(64, 50, 1, 1, 999.00, ''),
(65, 50, 2, 1, 220.00, ''),
(66, 51, 2, 1, 220.00, ''),
(68, 52, 1, 1, 999.00, ''),
(69, 52, 2, 1, 220.00, ''),
(71, 53, 2, 2, 440.00, ''),
(73, 54, 2, 1, 220.00, ''),
(76, 55, 2, 2, 440.00, ''),
(78, 56, 2, 1, 220.00, ''),
(79, 57, 1, 1, 999.00, ''),
(80, 57, 2, 1, 220.00, ''),
(82, 58, 2, 1, 220.00, ''),
(83, 58, 17, 1, 550.00, ''),
(84, 58, 7, 1, 360.00, ''),
(85, 58, 16, 1, 723.00, ''),
(86, 58, 23, 1, 130.00, ''),
(87, 58, 14, 1, 190.00, ''),
(88, 58, 27, 1, 138.00, ''),
(89, 59, 2, 1, 220.00, ''),
(90, 59, 4, 1, 350.00, ''),
(91, 60, 7, 1, 360.00, ''),
(92, 60, 6, 1, 380.00, ''),
(93, 61, 4, 1, 350.00, ''),
(95, 63, 2, 1, 220.00, ''),
(96, 64, 1, 1, 789.00, ''),
(97, 65, 4, 1, 350.00, ''),
(98, 65, 5, 1, 380.00, ''),
(99, 66, 9, 1, 180.00, 'Flowers'),
(100, 66, 4, 1, 350.00, 'Flowers'),
(101, 66, 2, 1, 220.00, 'Flowers');

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
-- Table structure for table `hvacmaintenance`
--

CREATE TABLE `hvacmaintenance` (
  `UnitID` int NOT NULL,
  `UnitName` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `RoomID` int NOT NULL,
  `UnitType` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `Manufacturer` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `ModelNumber` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `InstallDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `UnitStatus` varchar(255) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `ItemID` int NOT NULL,
  `ItemName` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `ItemCategoryID` int NOT NULL,
  `ItemQuantity` decimal(15,2) NOT NULL,
  `ItemDescription` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ItemStatus` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `DateofStockIn` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`ItemID`, `ItemName`, `ItemCategoryID`, `ItemQuantity`, `ItemDescription`, `ItemStatus`, `DateofStockIn`) VALUES
(10, 'asd', 1, 5.00, 'qwe', 'Low Stock', '2025-11-11 00:24:36'),
(11, 'd', 2, 4.00, 'asd', 'Low Stock', '2025-10-31 16:00:00'),
(12, 'g', 3, 2.00, 's', 'Low Stock', '2025-10-09 16:00:00'),
(13, 'k', 4, 2.00, 's', 'Low Stock', '2025-10-03 16:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `inventorylog`
--

CREATE TABLE `inventorylog` (
  `InvLogID` int NOT NULL,
  `UserID` int NOT NULL,
  `ItemID` int NOT NULL,
  `Quantity` int NOT NULL,
  `InventoryLogReason` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `DateofRelease` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inventorylog`
--

INSERT INTO `inventorylog` (`InvLogID`, `UserID`, `ItemID`, `Quantity`, `InventoryLogReason`, `DateofRelease`) VALUES
(58, 38, 10, 2, 'Initial Stock In', '2025-11-10 13:36:40'),
(59, 38, 11, 4, 'Initial Stock In', '2025-11-10 13:36:50'),
(60, 38, 12, 2, 'Initial Stock In', '2025-11-10 13:37:01'),
(61, 38, 13, 2, 'Initial Stock In', '2025-11-10 13:37:13'),
(62, 38, 10, 2, 'Stock Added', '2025-11-10 13:50:28'),
(63, 38, 10, 1, 'Stock Added', '2025-11-10 13:59:49'),
(64, 39, 10, -1, 'Item Issued', '2025-11-10 14:08:53'),
(65, 39, 10, -4, 'Item Issued', '2025-11-10 14:20:44'),
(66, 38, 10, 1, 'Stock Added', '2025-11-10 14:27:48'),
(67, 39, 10, -1, 'Item Issued', '2025-11-10 14:29:18'),
(68, 38, 10, 3, 'Stock Added', '2025-11-10 14:29:32'),
(69, 38, 10, 2, 'Stock Added', '2025-11-10 14:30:56'),
(70, 38, 10, 1, 'Stock Added', '2025-11-10 14:35:09'),
(71, 38, 10, 1, 'Stock Added', '2025-11-10 14:39:44'),
(72, 39, 10, -1, 'Item Issued', '2025-11-10 14:40:03'),
(73, 39, 10, -1, 'Item Issued', '2025-11-11 00:24:36');

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
  `created_by` int NOT NULL,
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
(20, 'INV-202511-0017', 'John Doe', '101', '2025-11-06', '2025-11-08', 'john.doe@example.com', '+1234567890', 0.00, 10.00, 0.00, 0.00, 0.00, 0.00, 'Pending', 'Credit Card', 'Guest requested late checkout', 3, '2025-11-06 03:16:21', '2025-11-06 03:16:21');

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
(7, 8, 'Pool Access', 4, 25.00, 100.00, '2025-10-29 00:21:51', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `itemcategory`
--

CREATE TABLE `itemcategory` (
  `ItemCategoryID` int NOT NULL,
  `ItemCategoryName` varchar(255) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `itemcategory`
--

INSERT INTO `itemcategory` (`ItemCategoryID`, `ItemCategoryName`) VALUES
(1, 'Cleaning Solution'),
(2, 'Electrical'),
(3, 'Furniture & Fixtures'),
(4, 'Room Amenities');

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
(16, 'Administrator ', 'POS-0016', NULL, 6, NULL, 1, '2025-11-11 10:41:59', '2025-11-11 10:43:20', 1, 1),
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
(28, 'CRM Manager', 'POS-0028', NULL, 13, NULL, 1, '2025-11-11 14:50:25', '2025-11-11 14:53:14', 1, 1);

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
(1, 'LEV-0001', 9, 'vacation', '2024-10-04', '2024-10-04', 'approved', 'Family event', 5, '2024-09-28 10:00:00', '2025-11-11 05:41:55', 9, NULL),
(2, 'LEV-0002', 12, 'sick', '2024-10-08', '2024-10-08', 'approved', 'Flu symptoms', 7, '2024-10-07 18:30:00', '2025-11-11 05:41:55', 12, NULL),
(3, 'LEV-0003', 8, 'vacation', '2024-10-15', '2024-10-16', 'approved', 'Personal matters', 5, '2024-10-01 09:00:00', '2025-11-11 05:41:55', 8, NULL),
(5, 'LEV-0005', 4, 'emergency', '2024-10-25', '2024-10-25', 'approved', 'Family emergency', 7, '2024-10-24 08:00:00', '2025-11-11 05:41:55', 4, NULL),
(6, 'LEV-0006', 10, 'vacation', '2024-11-05', '2024-11-07', 'pending', 'Planned vacation', NULL, '2024-10-28 11:00:00', '2025-11-11 05:41:55', 10, NULL),
(7, 'LEV-0007', 2, 'sick', '2024-11-12', '2024-11-13', 'pending', 'Scheduled medical procedure', NULL, '2024-10-30 15:00:00', '2025-11-11 05:41:55', 2, NULL),
(8, 'LEV-0008', 13, 'vacation', '2024-11-20', '2024-11-22', 'rejected', 'Insufficient leave credits', 7, '2024-10-29 10:30:00', '2025-11-11 05:41:55', 13, NULL),
(9, 'LEV-0009', 5, 'others', '2024-09-15', '2024-09-15', 'approved', 'Training seminar', 2, '2024-09-10 09:00:00', '2025-11-11 05:41:55', 5, NULL),
(10, 'LEV-0010', 7, 'vacation', '2024-12-23', '2024-12-27', 'pending', 'Christmas holiday', NULL, '2024-11-01 08:00:00', '2025-11-11 05:41:55', 7, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `maintenancelog`
--

CREATE TABLE `maintenancelog` (
  `MaintenanceLogID` int NOT NULL,
  `WorkOrderID` int NOT NULL,
  `UserID` int NOT NULL,
  `PartReplace` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ResolutionRemarks` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `TimeDateMaintenance` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `maintenance_requests`
--

CREATE TABLE `maintenance_requests` (
  `RequestID` int NOT NULL,
  `RoomID` int NOT NULL,
  `UserID` int NOT NULL,
  `IssueType` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `Description` text COLLATE utf8mb4_general_ci,
  `Status` varchar(50) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Pending',
  `DateRequested` datetime NOT NULL,
  `DateCompleted` datetime DEFAULT NULL,
  `AssignedUserID` int DEFAULT NULL,
  `Notes` text COLLATE utf8mb4_general_ci,
  `Remarks` text COLLATE utf8mb4_general_ci,
  `WorkType` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `UnitType` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `WorkDescription` text COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `maintenance_requests`
--

INSERT INTO `maintenance_requests` (`RequestID`, `RoomID`, `UserID`, `IssueType`, `Description`, `Status`, `DateRequested`, `DateCompleted`, `AssignedUserID`, `Notes`, `Remarks`, `WorkType`, `UnitType`, `WorkDescription`) VALUES
(12, 1, 35, 'Appliance', 'Appliance reported as \'Needs Repair\' or \'Out of Service\'.', 'Pending', '2025-11-11 10:57:27', NULL, 39, NULL, NULL, NULL, NULL, NULL);

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
(1, 3, 1, 1, 1, 1, 1, 1, 1, 1, '2025-11-12 02:03:53.695026', '2025-11-12 02:03:53.695026');

-- --------------------------------------------------------

--
-- Table structure for table `parkingarea`
--

CREATE TABLE `parkingarea` (
  `AreaID` int NOT NULL,
  `AreaName` varchar(100) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `parkingarea`
--

INSERT INTO `parkingarea` (`AreaID`, `AreaName`) VALUES
(1, 'Area A'),
(2, 'Area B'),
(3, 'Area C'),
(4, 'Area D'),
(5, 'Area E');

-- --------------------------------------------------------

--
-- Table structure for table `parkingslot`
--

CREATE TABLE `parkingslot` (
  `SlotID` int NOT NULL,
  `AreaID` int NOT NULL,
  `SlotName` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `AllowedVehicleTypeID` int NOT NULL,
  `Status` enum('available','occupied','reserved','maintenance') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'available'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `parkingslot`
--

INSERT INTO `parkingslot` (`SlotID`, `AreaID`, `SlotName`, `AllowedVehicleTypeID`, `Status`) VALUES
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
(61, 2, 'B-01', 2, 'occupied'),
(62, 2, 'B-02', 2, 'available'),
(63, 2, 'B-03', 2, 'available'),
(64, 2, 'B-04', 2, 'available'),
(65, 2, 'B-05', 2, 'available'),
(66, 2, 'B-06', 2, 'available'),
(67, 2, 'B-07', 2, 'available'),
(68, 2, 'B-08', 2, 'available'),
(69, 2, 'B-09', 2, 'available'),
(70, 2, 'B-10', 2, 'available'),
(71, 3, 'C-01', 2, 'occupied'),
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
(82, 4, 'D-02', 2, 'occupied'),
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
-- Table structure for table `parking_sessions`
--

CREATE TABLE `parking_sessions` (
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
-- Dumping data for table `parking_sessions`
--

INSERT INTO `parking_sessions` (`SessionID`, `SlotID`, `PlateNumber`, `GuestName`, `RoomNumber`, `VehicleTypeID`, `VehicleCategoryID`, `EntryTime`, `ExitTime`, `TotalFee`, `StaffID_Entry`) VALUES
(1, 51, 'QW4E12', 'asd', 's', 2, 9, '2025-11-07 16:08:27', '2025-11-07 16:08:36', NULL, 40),
(2, 51, 'WQE', 'wqe', 's', 1, 11, '2025-11-07 16:08:59', '2025-11-07 16:11:48', NULL, 40),
(3, 51, 'QWE', 'wqe', 'qwe', 1, 11, '2025-11-07 16:12:35', NULL, NULL, 40),
(4, 61, 'WE', 'wea', 'e', 2, 9, '2025-11-07 16:12:45', NULL, NULL, 40),
(5, 71, 'SDA', 'ad', 'asdasd', 1, 11, '2025-11-07 16:12:55', NULL, NULL, 40),
(6, 82, 'AS', 'asd', 'd', 1, 11, '2025-11-07 16:13:02', NULL, NULL, 40),
(7, 91, 'S', 'd', 'asd', 1, 11, '2025-11-07 16:13:14', '2025-11-07 17:00:50', NULL, 40),
(8, 52, 'QW4E12E', 'w', 'q1', 1, 11, '2025-11-08 02:48:34', '2025-11-08 02:48:37', NULL, 40);

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `payment_id` int NOT NULL,
  `order_id` int DEFAULT NULL,
  `payment_method` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `payment_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `change_amount` decimal(10,2) DEFAULT '0.00',
  `payment_status` varchar(50) COLLATE utf8mb4_general_ci DEFAULT 'paid'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`payment_id`, `order_id`, `payment_method`, `amount`, `payment_date`, `change_amount`, `payment_status`) VALUES
(1, 1, 'GCash', 1218.78, '2025-11-01 04:13:09', 0.00, 'pending'),
(2, 2, 'Debit Card', 2437.56, '2025-11-01 04:18:34', 0.00, 'pending'),
(3, 3, 'GCash', 3656.34, '2025-11-01 04:30:24', 0.00, 'pending'),
(4, 4, 'GCash', 4875.12, '2025-11-01 05:43:18', 0.00, 'pending'),
(5, 7, 'GCash', 2461.54, '2025-11-01 10:55:18', 0.00, 'pending'),
(6, 8, 'GCash', 3692.30, '2025-11-01 11:13:50', 0.00, 'pending'),
(7, 9, 'GCash', 542.08, '2025-11-01 11:36:42', 0.00, 'pending'),
(8, 10, 'Cash', 1501.81, '2025-11-01 16:23:38', 0.00, 'paid'),
(9, 11, 'GCash', 4505.42, '2025-11-01 16:40:38', 0.00, 'pending'),
(10, 12, 'Cash', 1000.00, '2025-11-01 17:02:05', 186.88, 'paid'),
(11, 13, 'Cash', 500.00, '2025-11-01 23:54:12', 228.96, 'paid'),
(12, 14, 'GCash', 184.80, '2025-11-02 16:31:38', 0.00, 'pending'),
(13, 15, 'Credit Card', 726.88, '2025-11-03 00:49:50', 0.00, 'pending'),
(14, 16, 'Cash', 500.00, '2025-11-03 00:59:57', 44.16, 'paid'),
(15, 17, 'GCash', 271.04, '2025-11-03 01:31:10', 0.00, 'pending'),
(16, 18, 'GCash', 1686.61, '2025-11-03 01:58:40', 0.00, 'pending'),
(17, 19, 'Cash', 200.00, '2025-11-03 02:08:56', 15.20, 'paid'),
(18, 20, 'GCash', 542.08, '2025-11-03 02:11:01', 0.00, 'pending'),
(19, 21, 'Cash', 600.00, '2025-11-03 02:14:20', 57.92, 'paid'),
(20, 22, 'GCash', 271.04, '2025-11-03 02:21:13', 0.00, 'pending'),
(21, 23, 'GCash', 2461.54, '2025-11-03 02:32:01', 0.00, 'pending'),
(22, 24, 'GCash', 271.04, '2025-11-03 02:53:13', 0.00, 'pending'),
(23, 25, 'GCash', 184.80, '2025-11-03 03:09:30', 0.00, 'pending'),
(24, 26, 'GCash', 455.84, '2025-11-03 03:23:34', 0.00, 'pending'),
(25, 27, 'GCash', 271.04, '2025-11-03 03:32:31', 0.00, 'pending'),
(26, 28, 'GCash', 184.80, '2025-11-03 03:36:29', 0.00, 'pending'),
(27, 29, 'Cash', 200.00, '2025-11-03 03:38:48', 15.20, 'paid'),
(28, 30, 'Cash', 1300.00, '2025-11-03 03:50:05', 69.23, 'paid'),
(29, 31, 'GCash', 1230.77, '2025-11-03 03:51:39', 0.00, 'pending'),
(30, 32, 'Cash', 200.00, '2025-11-03 03:57:14', 15.20, 'paid'),
(31, 33, 'GCash', 1501.81, '2025-11-05 04:53:21', 0.00, 'pending'),
(32, 35, 'Cash', 3000.00, '2025-11-05 05:11:22', 267.42, 'paid'),
(33, 36, 'GCash', 1501.81, '2025-11-05 05:41:27', 0.00, 'pending'),
(34, 37, 'Online', 455.84, '2025-11-05 06:54:30', 0.00, 'pending'),
(35, 38, 'Cash', 200.00, '2025-11-05 06:58:35', 15.20, 'paid'),
(36, 39, 'Cash', 184.80, '2025-11-05 07:01:37', NULL, 'paid'),
(37, 41, 'Online', 369.60, '2025-11-05 07:12:13', 0.00, 'pending'),
(38, 42, 'Cash', 400.00, '2025-11-05 07:19:31', 30.40, 'paid'),
(39, 43, 'GCash', 184.80, '2025-11-05 07:29:28', 0.00, 'pending'),
(40, 45, 'GCash', 1230.77, '2025-11-05 18:09:09', 0.00, 'pending'),
(41, 46, 'Cash', 2461.54, '2025-11-05 18:17:30', 0.00, 'paid'),
(42, 47, 'GCash', 1230.77, '2025-11-06 01:18:24', 0.00, 'pending'),
(43, 48, 'GCash', 455.84, '2025-11-06 01:56:19', 0.00, 'pending'),
(44, 49, 'Cash', 500.00, '2025-11-06 02:00:28', 44.16, 'paid'),
(45, 50, 'Cash', 1600.00, '2025-11-06 02:21:13', 98.19, 'paid'),
(46, 51, 'GCash', 455.84, '2025-11-06 02:30:05', 0.00, 'pending'),
(47, 52, 'GCash', 1686.61, '2025-11-06 03:17:01', 0.00, 'pending'),
(48, 53, 'Cash', 800.00, '2025-11-06 03:19:55', 73.12, 'paid'),
(49, 54, 'Cash', 500.00, '2025-11-06 03:20:04', 44.16, 'paid'),
(50, 55, 'Cash', 900.00, '2025-11-06 03:20:16', 173.12, 'paid'),
(51, 56, 'Cash', 500.00, '2025-11-06 03:20:57', 44.16, 'paid'),
(52, 57, 'GCash', 1686.61, '2025-11-06 04:00:24', 0.00, 'pending'),
(53, 58, 'GCash', 2847.15, '2025-11-06 16:21:08', 0.00, 'pending'),
(54, 59, 'Credit Card', 702.24, '2025-11-07 07:06:20', 0.00, 'pending'),
(55, 60, 'Debit Card', 911.68, '2025-11-07 07:09:57', 0.00, 'pending'),
(56, 61, 'GCash', 431.20, '2025-11-07 07:19:59', 0.00, 'pending'),
(57, 62, 'GCash', 344.96, '2025-11-08 03:25:43', 0.00, 'pending'),
(58, 63, 'GCash', 271.04, '2025-11-08 03:40:21', 0.00, 'pending'),
(59, 64, 'GCash', 972.05, '2025-11-08 03:40:35', 0.00, 'pending');

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
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ;

--
-- Dumping data for table `payroll_run`
--

INSERT INTO `payroll_run` (`payroll_run_id`, `payroll_start_date`, `payroll_end_date`, `status`, `created_at`, `updated_at`) VALUES
(1, '2025-11-01', '2025-11-15', 'pending', '2025-11-09 10:45:10', '2025-11-09 10:45:10'),
(2, '2025-12-01', '2025-12-13', 'pending', '2025-11-10 06:35:51', '2025-11-10 06:35:51');

-- --------------------------------------------------------

--
-- Table structure for table `payroll_slip`
--

CREATE TABLE `payroll_slip` (
  `payroll_id` int NOT NULL,
  `employee_id` int DEFAULT NULL,
  `payroll_run_id` int DEFAULT NULL,
  `users_id` int DEFAULT NULL,
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

--
-- Dumping data for table `payroll_slip`
--

INSERT INTO `payroll_slip` (`payroll_id`, `employee_id`, `payroll_run_id`, `users_id`, `company_deduction_id`, `total_company_deductions`, `base_salary`, `overtime_hours`, `overtime_pay`, `gross_pay`, `sss_deduction`, `pagibig_deduction`, `philhealth_deduction`, `withholding_tax`, `net_pay`, `created_at`, `updated_at`) VALUES
(74, 2, 1, 3, NULL, 0.00, 45000.00, 10.50, 1575.00, 46575.00, 1350.00, 100.00, 1125.00, 500.00, 43500.00, '2025-11-09 10:45:10', '2025-11-09 10:45:10'),
(75, 1, 1, 3, NULL, 0.00, 80000.00, 10.50, 1575.00, 81575.00, 1350.00, 100.00, 2000.00, 500.00, 77625.00, '2025-11-09 10:45:10', '2025-11-09 10:45:10'),
(76, 3, 1, 3, NULL, 0.00, 55000.00, 10.50, 1575.00, 56575.00, 1350.00, 100.00, 1375.00, 500.00, 53250.00, '2025-11-09 10:45:10', '2025-11-09 10:45:10'),
(77, 4, 1, 3, NULL, 0.00, 35000.00, 10.50, 1575.00, 36575.00, 1350.00, 100.00, 875.00, 500.00, 33750.00, '2025-11-09 10:45:10', '2025-11-09 10:45:10'),
(78, 5, 1, 3, NULL, 1000.00, 40000.00, 10.50, 1575.00, 41575.00, 1350.00, 100.00, 1000.00, 500.00, 37625.00, '2025-11-09 10:45:10', '2025-11-10 03:05:15'),
(79, 7, 2, 3, NULL, 0.00, 38000.00, 0.00, 0.00, 38000.00, 1350.00, 100.00, 950.00, 0.00, 35600.00, '2025-11-10 06:35:51', '2025-11-10 06:35:51'),
(80, 5, 2, 3, NULL, 0.00, 40000.00, 0.00, 0.00, 40000.00, 1350.00, 100.00, 1000.00, 0.00, 37550.00, '2025-11-10 06:35:51', '2025-11-10 06:35:51'),
(81, 8, 2, 3, NULL, 0.00, 28000.00, 0.00, 0.00, 28000.00, 1260.00, 100.00, 700.00, 0.00, 25940.00, '2025-11-10 06:35:51', '2025-11-10 06:35:51'),
(82, 9, 2, 3, NULL, 0.00, 32000.00, 0.00, 0.00, 32000.00, 1350.00, 100.00, 800.00, 0.00, 29750.00, '2025-11-10 06:35:51', '2025-11-10 06:35:51'),
(83, 6, 2, 3, NULL, 0.00, 50000.00, 0.00, 0.00, 50000.00, 1350.00, 100.00, 1250.00, 0.00, 47300.00, '2025-11-10 06:35:51', '2025-11-10 06:35:51'),
(84, 3, 2, 3, NULL, 0.00, 55000.00, 0.00, 0.00, 55000.00, 1350.00, 100.00, 1375.00, 0.00, 52175.00, '2025-11-10 06:35:51', '2025-11-10 06:35:51'),
(85, 4, 2, 3, NULL, 0.00, 35000.00, 0.00, 0.00, 35000.00, 1350.00, 100.00, 875.00, 0.00, 32675.00, '2025-11-10 06:35:51', '2025-11-10 06:35:51'),
(86, 1, 2, 3, NULL, 0.00, 80000.00, 0.00, 0.00, 80000.00, 1350.00, 100.00, 2000.00, 0.00, 76550.00, '2025-11-10 06:35:51', '2025-11-10 06:35:51'),
(87, 10, 2, 3, NULL, 0.00, 45000.00, 0.00, 0.00, 45000.00, 1350.00, 100.00, 1125.00, 0.00, 42425.00, '2025-11-10 06:35:51', '2025-11-10 06:35:51'),
(88, 2, 2, 3, NULL, 0.00, 45000.00, 0.00, 0.00, 45000.00, 1350.00, 100.00, 1125.00, 0.00, 42425.00, '2025-11-10 06:35:51', '2025-11-10 06:35:51'),
(89, 11, 2, 3, NULL, 0.00, 38000.00, 0.00, 0.00, 38000.00, 1350.00, 100.00, 950.00, 0.00, 35600.00, '2025-11-10 06:35:51', '2025-11-10 06:35:51'),
(90, 12, 2, 3, NULL, 0.00, 25000.00, 0.00, 0.00, 25000.00, 1125.00, 100.00, 625.00, 0.00, 23150.00, '2025-11-10 06:35:51', '2025-11-10 06:35:51'),
(91, 13, 2, 3, NULL, 0.00, 23000.00, 0.00, 0.00, 23000.00, 1035.00, 100.00, 575.00, 0.00, 21290.00, '2025-11-10 06:35:51', '2025-11-10 06:35:51');

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
-- Table structure for table `rate`
--

CREATE TABLE `rate` (
  `RateID` int NOT NULL,
  `AreaID` int NOT NULL,
  `VehicleCategoryID` int NOT NULL,
  `VehicleTypeID` int NOT NULL,
  `HourlyRate` decimal(15,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(56, 4, 184.80, 'Order #29', NULL, NULL, NULL, '2025-11-07', 'Auto-synced from Walk-in', 1, '2025-11-07 16:19:20', '2025-11-07 17:50:55', NULL),
(57, 4, 1230.77, 'Order #30', NULL, NULL, NULL, '2025-11-07', 'Auto-synced from Walk-in', 1, '2025-11-07 16:19:20', '2025-11-07 17:50:57', NULL),
(58, 4, 1686.61, 'Order #18', NULL, NULL, NULL, '2025-11-07', 'Auto-synced from Room Service', 1, '2025-11-07 16:19:30', '2025-11-07 17:50:52', NULL),
(59, 2, 542.08, 'Order #20', NULL, NULL, NULL, '2025-11-08', 'Auto-synced from Dine-in', 1, '2025-11-08 06:07:50', '2025-11-08 06:07:50', NULL),
(60, 2, 542.08, 'Order #20', NULL, NULL, NULL, '2025-11-08', 'Auto-synced from Dine-in', 1, '2025-11-08 06:07:50', '2025-11-08 06:07:50', NULL),
(61, 2, 184.80, 'Order #25', NULL, NULL, NULL, '2025-11-08', 'Auto-synced from Dine-in', 1, '2025-11-08 06:07:50', '2025-11-08 06:07:50', NULL),
(62, 2, 184.80, 'Order #25', NULL, NULL, NULL, '2025-11-08', 'Auto-synced from Dine-in', 1, '2025-11-08 06:07:50', '2025-11-08 06:07:50', NULL),
(63, 2, 2437.56, 'Order #2', NULL, NULL, NULL, '2025-11-08', 'Auto-synced from Dine-in', 1, '2025-11-08 06:07:51', '2025-11-08 06:07:51', NULL),
(64, 2, 2437.56, 'Order #2', NULL, NULL, NULL, '2025-11-08', 'Auto-synced from Dine-in', 1, '2025-11-08 06:07:51', '2025-11-08 06:07:51', NULL),
(65, 2, 3656.34, 'Order #3', NULL, NULL, NULL, '2025-11-08', 'Auto-synced from Dine-in', 1, '2025-11-08 06:07:51', '2025-11-08 06:07:51', NULL),
(66, 2, 3656.34, 'Order #3', NULL, NULL, NULL, '2025-11-08', 'Auto-synced from Dine-in', 1, '2025-11-08 06:07:51', '2025-11-08 06:07:51', NULL),
(67, 2, 4875.12, 'Order #4', NULL, NULL, NULL, '2025-11-08', 'Auto-synced from Room Service', 1, '2025-11-08 06:07:51', '2025-11-08 06:07:51', NULL),
(68, 2, 4875.12, 'Order #4', NULL, NULL, NULL, '2025-11-08', 'Auto-synced from Room Service', 1, '2025-11-08 06:07:51', '2025-11-08 06:07:51', NULL),
(69, 2, 2461.54, 'Order #7', NULL, NULL, NULL, '2025-11-08', 'Auto-synced from Room Service', 1, '2025-11-09 09:04:50', '2025-11-09 09:04:50', NULL),
(70, 2, 2461.54, 'Order #7', NULL, NULL, NULL, '2025-11-08', 'Auto-synced from Room Service', 1, '2025-11-09 09:04:50', '2025-11-09 09:04:50', NULL),
(71, 2, 3692.30, 'Order #8', NULL, NULL, NULL, '2025-11-08', 'Auto-synced from Room Service', 1, '2025-11-09 09:04:50', '2025-11-09 09:04:50', NULL),
(72, 2, 3692.30, 'Order #8', NULL, NULL, NULL, '2025-11-08', 'Auto-synced from Room Service', 1, '2025-11-09 09:04:50', '2025-11-09 09:04:50', NULL),
(73, 2, 542.08, 'Order #9', NULL, NULL, NULL, '2025-11-08', 'Auto-synced from Room Service', 1, '2025-11-09 09:04:50', '2025-11-09 09:04:50', NULL),
(74, 2, 542.08, 'Order #9', NULL, NULL, NULL, '2025-11-08', 'Auto-synced from Room Service', 1, '2025-11-09 09:04:50', '2025-11-09 09:04:50', NULL),
(75, 2, 1501.81, 'Order #10', NULL, NULL, NULL, '2025-11-09', 'Auto-synced from Walk-in', 1, '2025-11-09 09:04:50', '2025-11-09 09:04:50', NULL),
(76, 2, 1501.81, 'Order #10', NULL, NULL, NULL, '2025-11-09', 'Auto-synced from Walk-in', 1, '2025-11-09 09:04:50', '2025-11-09 09:04:50', NULL),
(77, 2, 184.80, 'Order #14', NULL, NULL, NULL, '2025-11-09', 'Auto-synced from Dine-in', 1, '2025-11-09 09:04:50', '2025-11-09 09:04:50', NULL),
(78, 2, 184.80, 'Order #14', NULL, NULL, NULL, '2025-11-09', 'Auto-synced from Dine-in', 1, '2025-11-09 09:04:50', '2025-11-09 09:04:50', NULL),
(79, 2, 1000.00, 'Order #5', NULL, NULL, NULL, '2025-11-08', 'Auto-synced from Room Service', 1, '2025-11-09 09:57:10', '2025-11-09 09:57:10', NULL),
(80, 2, 1000.00, 'Order #5', NULL, NULL, NULL, '2025-11-08', 'Auto-synced from Room Service', 1, '2025-11-09 09:57:10', '2025-11-09 09:57:10', NULL),
(81, 2, 10000.00, 'Order #6', NULL, NULL, NULL, '2025-11-08', 'Auto-synced from Room Service', 1, '2025-11-09 09:57:50', '2025-11-09 09:57:50', NULL),
(82, 2, 10000.00, 'Order #6', NULL, NULL, NULL, '2025-11-08', 'Auto-synced from Room Service', 1, '2025-11-09 09:57:50', '2025-11-09 09:57:50', NULL);

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
-- Table structure for table `room`
--

CREATE TABLE `room` (
  `RoomID` int NOT NULL,
  `UserID` int NOT NULL,
  `RoomNumber` int NOT NULL,
  `RoomType` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `GuestCapacity` varchar(50) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '1-2 guests',
  `Rate` decimal(10,2) NOT NULL DEFAULT '0.00',
  `RoomStatus` varchar(50) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'available',
  `LastClean` timestamp NULL DEFAULT NULL,
  `LastMaintenance` timestamp NULL DEFAULT NULL,
  `FloorNumber` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `room_appliances`
--

CREATE TABLE `room_appliances` (
  `ApplianceID` int NOT NULL,
  `RoomID` int NOT NULL,
  `ApplianceType` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `ApplianceName` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `Manufacturer` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ModelNumber` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `InstalledDate` date NOT NULL,
  `Status` varchar(50) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Working',
  `Remarks` text COLLATE utf8mb4_general_ci,
  `LastMaintainedDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `room_appliances`
--

INSERT INTO `room_appliances` (`ApplianceID`, `RoomID`, `ApplianceType`, `ApplianceName`, `Manufacturer`, `ModelNumber`, `InstalledDate`, `Status`, `Remarks`, `LastMaintainedDate`) VALUES
(5, 4, 'HVAC', 'sad', 'asda', 'dasd', '2025-11-01', 'Working', '', '2025-11-11'),
(9, 4, 'Electric', 'sad', 'wq', 'hghhjgg', '2025-11-01', 'Working', '', NULL),
(14, 1, 'Electric', 'sad', 'asd', 'asds', '2025-11-01', 'Needs Repair', '', '2025-11-11'),
(15, 4, 'Electric', 'asd', 'sadd', 'sddd', '2025-11-01', 'Working', '', '2025-11-11'),
(16, 5, 'Electric', 'asde', 's', 'bab', '2025-11-01', 'Working', '', NULL),
(17, 2, 'Electric', 'sad', 'sadas', 'asd', '2025-11-01', 'Working', '', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `room_status`
--

CREATE TABLE `room_status` (
  `StatusID` int NOT NULL,
  `RoomNumber` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `RoomStatus` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `LastClean` timestamp NULL DEFAULT NULL,
  `LastMaintenance` timestamp NULL DEFAULT NULL,
  `UserID` int DEFAULT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `room_status`
--

INSERT INTO `room_status` (`StatusID`, `RoomNumber`, `RoomStatus`, `LastClean`, `LastMaintenance`, `UserID`, `LastUpdated`) VALUES
(1, '101', 'Maintenance', NULL, '2025-11-11 02:57:27', 35, '2025-11-11 02:57:27'),
(3, '102', 'Available', NULL, NULL, 35, '2025-11-11 01:25:44'),
(9, '103', 'Available', NULL, NULL, 1, '2025-11-10 23:54:25'),
(10, '201', 'Available', NULL, '2025-11-11 01:12:47', 1, '2025-11-11 01:17:29'),
(15, '202', 'Available', NULL, NULL, 1, '2025-11-10 23:54:33');

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
(13, 'Jeff', NULL, 'Torio', NULL, 'Filipino', '$2a$10$IPqmfJ3peNUy/UYFW/D5..r7/eHbHCv.fNazFFIP1NknM0AwcCFra', 'jeff@example.com', '09239273182', '2025-11-11 10:28:34', 0);

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
('marxsuelisu12@gmail.com', '681641', '2025-11-11 13:48:29');

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
  `status` enum('Pending','Completed','Failed','Refunded') DEFAULT 'Completed',
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
  `image_url` longtext,
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
(1, 101, 4, 'Charlotte', 'Room', 5, 100.00, '“Stylishly furnished room featuring plush bedding, sleek décor, and panoramic city views — perfect for business or leisure.”', 'Reserved', 'http://localhost:5000/uploads/room-1761992416960-442938989.webp', 0, '2025-10-23 14:46:02', NULL, '2025-11-06 16:01:00', NULL),
(3, 102, 4, 'bahay kubo', 'Room', 4, 100.00, NULL, 'Reserved', 'http://localhost:5000/uploads/room-1762008650148-416620145.webp', 0, '2025-10-23 17:25:49', NULL, '2025-11-06 16:01:00', NULL),
(6, 103, 3, 'Sweet Homes', 'Deluxe', 8, 12000.00, ' modern amenities, and a stylish en-suite bathroom with a rainfall shower. Perfect for both business and leisure, this room includes a 50-inch TV, high-speed Wi-Fi, and a minibar for your convenience.', 'Available', 'http://localhost:5000/uploads/room-1761992539377-716069616.webp', 0, '2025-11-01 10:21:06', NULL, '2025-11-05 23:32:10', NULL),
(7, 104, 4, 'Ocean View', 'Suite', 10, 15000.00, 'King bed with walk-in shower and floor-to-ceiling windows. Best available rate with complimentary amenities.\n\nBest Available Rate — Amenities include:\nHigh-speed wireless internet\nMinibar snacks and soft drinks\nNespresso or tea presentations on request\nPacking/unpacking services', 'Available', 'http://localhost:5000/uploads/room-1762008620893-532302090.webp', 0, '2025-11-01 14:50:20', NULL, '2025-11-05 23:56:19', NULL);

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
(1, 'TIC-0001', 8, 3, 'Computer not starting', 'My workstation won\'t boot up this morning', 'resolved', '2024-10-01 08:30:00', 8, '2025-11-11 05:42:06', NULL),
(2, 'TIC-0002', 12, 3, 'Email access issue', 'Cannot access company email account', 'resolved', '2024-10-02 09:15:00', 12, '2025-11-11 05:42:06', NULL),
(3, 'TIC-0003', 9, NULL, 'Printer not working', 'Office printer shows error message', 'in_progress', '2024-10-07 10:00:00', 9, '2025-11-11 05:42:06', NULL),
(4, 'TIC-0004', 4, 3, 'Password reset request', 'Forgot my system password', 'resolved', '2024-10-03 14:20:00', 4, '2025-11-11 05:42:06', NULL),
(5, 'TIC-0005', 13, NULL, 'Network connectivity', 'Slow internet connection at front desk', 'open', '2024-10-09 11:30:00', 13, '2025-11-11 05:42:06', NULL),
(6, 'TIC-0006', 10, 3, 'Software installation', 'Need development tools installed', 'resolved', '2024-10-04 13:00:00', 10, '2025-11-11 05:42:06', NULL),
(7, 'TIC-0007', 7, NULL, 'Phone system issue', 'Extension not receiving calls', 'open', '2024-10-08 15:45:00', 7, '2025-11-11 05:42:06', NULL),
(9, 'TIC-0009', 1, NULL, 'boot issue', 'walang os yung pc ya', 'open', '2025-11-11 08:56:04', 1, '2025-11-11 08:56:04', NULL),
(10, 'TIC-0010', 10, NULL, 'issue1', 'emp', 'open', '2025-11-11 14:43:20', 10, '2025-11-11 14:43:21', NULL);

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
(1, 'superadmin', '$2b$10$oTgzQ4u5puIYcLTrzMwbmOaALazu4MFwkGA.2L9gJWBirc/Xnf.ry', 'superadmin', 1, '2025-11-11 05:40:38', '2025-11-11 05:40:38', 1, NULL),
(2, 'hradmin', '$2a$10$P4d0WRBcLHPwPHwM2ys60.8VkOpwnzAeMXmbTg1.tOLoMJUIKbNfG', 'admin', 1, '2025-11-11 05:40:41', '2025-11-11 05:40:41', 1, NULL),
(3, 'itadmin', '$2a$10$P4d0WRBcLHPwPHwM2ys60.8VkOpwnzAeMXmbTg1.tOLoMJUIKbNfG', 'admin', 1, '2025-11-11 05:40:47', '2025-11-11 05:40:47', 1, NULL),
(4, 'frontdeskadmin', '$2a$10$P4d0WRBcLHPwPHwM2ys60.8VkOpwnzAeMXmbTg1.tOLoMJUIKbNfG', 'admin', 1, '2025-11-11 05:40:53', '2025-11-11 05:40:53', 1, NULL),
(5, 'hrsupervisor', '$2a$10$P4d0WRBcLHPwPHwM2ys60.8VkOpwnzAeMXmbTg1.tOLoMJUIKbNfG', 'supervisor', 1, '2025-11-11 05:40:59', '2025-11-11 05:40:59', 1, NULL),
(6, 'itsupervisor', '$2a$10$P4d0WRBcLHPwPHwM2ys60.8VkOpwnzAeMXmbTg1.tOLoMJUIKbNfG', 'supervisor', 1, '2025-11-11 05:41:06', '2025-11-11 05:41:06', 1, NULL),
(7, 'frontdesksupervisor', '$2a$10$P4d0WRBcLHPwPHwM2ys60.8VkOpwnzAeMXmbTg1.tOLoMJUIKbNfG', 'supervisor', 1, '2025-11-11 05:41:12', '2025-11-11 05:41:12', 1, NULL),
(8, 'hremployee1', '$2a$10$P4d0WRBcLHPwPHwM2ys60.8VkOpwnzAeMXmbTg1.tOLoMJUIKbNfG', 'employee', 1, '2025-11-11 05:41:18', '2025-11-11 05:41:18', 1, NULL),
(9, 'hremployee2', '$2a$10$P4d0WRBcLHPwPHwM2ys60.8VkOpwnzAeMXmbTg1.tOLoMJUIKbNfG', 'employee', 1, '2025-11-11 05:41:22', '2025-11-11 05:41:22', 1, NULL),
(10, 'it.jamesa', '$2b$10$nSPws4pMoyLZnAgcoPmzi.QTGE71WO1j5Ov8TpdRzf3RdJ5MCb36a', 'employee', 1, '2025-11-11 05:41:26', '2025-11-11 14:58:51', 1, 10),
(12, 'receptionist1', '$2a$10$P4d0WRBcLHPwPHwM2ys60.8VkOpwnzAeMXmbTg1.tOLoMJUIKbNfG', 'employee', 1, '2025-11-11 05:41:34', '2025-11-11 05:41:34', 1, NULL),
(13, 'receptionist2', '$2a$10$P4d0WRBcLHPwPHwM2ys60.8VkOpwnzAeMXmbTg1.tOLoMJUIKbNfG', 'employee', 1, '2025-11-11 05:41:38', '2025-11-11 05:41:38', 1, NULL),
(14, 'supertest', '$2a$10$OWNAuE1fiCaB4p.jh9VkoeNAUZXOvqS1nQzeE3h7F1X5V6bjDw9Ta', 'admin', 1, '2025-11-11 09:42:42', '2025-11-11 09:42:42', NULL, NULL),
(15, 'test_admin', '$2a$10$xjQ83sAIUTbagVB2R8LMgO.rSHSKvB9Gi91QUXpjJi5s3hIojJ3f.', 'admin', 1, '2025-11-11 09:46:01', '2025-11-11 09:46:01', NULL, NULL),
(16, 'testAdmin', '$2a$10$pea7kJS6f0ElLpa6G4oOt.uuKkzNSdCn1if79jmTHfmhKdgP9Cy/S', 'admin', 1, '2025-11-11 10:15:26', '2025-11-11 10:15:26', 1, NULL),
(18, 'nicole', '$2b$10$1x3fpLTuRoAqgEc1oiEi/Oh2DqQujHc7m4gD8daxEYf5aO/8BWLXC', 'employee', 1, '2025-11-11 15:03:38', '2025-11-11 15:05:36', 1, 1),
(19, 'vincent', '$2b$10$9u6qVwQ9cRpp0HjGUM43IOkTOr10rAtVuFOgeRf00nJc8uCQTwN0u', 'employee', 1, '2025-11-11 15:31:18', '2025-11-11 18:10:27', 1, 1),
(20, 'johnwilmer', '$2b$10$.a8zt7nTta7K22A0le66p.xGsYxSyw/CXtFKX5Vc1PEotUYnbDbB.', 'employee', 1, '2025-11-11 15:57:40', '2025-11-11 15:57:40', 1, NULL),
(21, 'gabriel', '$2b$10$bzUejioe35qIf2pRdcKPM.mlobWjC7sNqYik0nXT25QhiTh9EUqtC', 'employee', 1, '2025-11-11 17:25:45', '2025-11-11 19:29:00', 1, 1),
(22, 'lawrence', '$2b$10$mUxKGGp.5no6ZcyLpxTx1.cWTB.MqYgkQWWEr/aGngjafVKOnKEIi', 'admin', 1, '2025-11-11 17:57:10', '2025-11-11 18:16:53', 1, 1);

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
(2, 3, 'it', '2025-11-11 05:40:51', '2025-11-11 05:40:51', 1, NULL),
(3, 4, 'front_desk', '2025-11-11 05:40:57', '2025-11-11 05:40:57', 1, NULL),
(4, 5, 'hr', '2025-11-11 05:41:04', '2025-11-11 05:41:04', 1, NULL),
(5, 6, 'it', '2025-11-11 05:41:10', '2025-11-11 05:41:10', 1, NULL),
(6, 7, 'front_desk', '2025-11-11 05:41:16', '2025-11-11 05:41:16', 1, NULL),
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
  ADD KEY `fk_users_budget` (`users_id`);

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
  ADD KEY `fk_users_expenses` (`users_id`),
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
  ADD KEY `idx_customer_id` (`customer_id`),
  ADD KEY `idx_order_id` (`order_id`);

--
-- Indexes for table `fb_orders`
--
ALTER TABLE `fb_orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `fk_order_staff` (`staff_id`);

--
-- Indexes for table `fb_order_details`
--
ALTER TABLE `fb_order_details`
  ADD PRIMARY KEY (`order_detail_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `item_id` (`item_id`);

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
-- Indexes for table `notification_settings`
--
ALTER TABLE `notification_settings`
  ADD PRIMARY KEY (`notification_id`),
  ADD UNIQUE KEY `UK_notification_users` (`users_id`),
  ADD KEY `IDX_notification_users` (`users_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `order_id` (`order_id`);

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
  ADD KEY `fk_users_payroll` (`users_id`),
  ADD KEY `fk_payroll_run` (`payroll_run_id`),
  ADD KEY `FK_payroll_slip_hotel_management.employees` (`employee_id`),
  ADD KEY `fk_company_deductions` (`company_deduction_id`);

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
  MODIFY `user_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `log_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=110;

--
-- AUTO_INCREMENT for table `attendance`
--
ALTER TABLE `attendance`
  MODIFY `attendance_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `audit_log`
--
ALTER TABLE `audit_log`
  MODIFY `log_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `backup_history`
--
ALTER TABLE `backup_history`
  MODIFY `backup_id` int NOT NULL AUTO_INCREMENT;

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
  MODIFY `deduction_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

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
  MODIFY `dependant_address_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `dependant_contact`
--
ALTER TABLE `dependant_contact`
  MODIFY `dependant_contact_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `dependant_email`
--
ALTER TABLE `dependant_email`
  MODIFY `dependant_email_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
  MODIFY `address_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `employee_contact_numbers`
--
ALTER TABLE `employee_contact_numbers`
  MODIFY `contact_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `employee_emails`
--
ALTER TABLE `employee_emails`
  MODIFY `email_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `expenses_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `fb_categories`
--
ALTER TABLE `fb_categories`
  MODIFY `category_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `fb_ingredients`
--
ALTER TABLE `fb_ingredients`
  MODIFY `ingredient_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `fb_inventory_logs`
--
ALTER TABLE `fb_inventory_logs`
  MODIFY `log_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=293;

--
-- AUTO_INCREMENT for table `fb_menu_items`
--
ALTER TABLE `fb_menu_items`
  MODIFY `item_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `fb_menu_item_ingredients`
--
ALTER TABLE `fb_menu_item_ingredients`
  MODIFY `recipe_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT for table `fb_notifications`
--
ALTER TABLE `fb_notifications`
  MODIFY `notification_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `fb_orders`
--
ALTER TABLE `fb_orders`
  MODIFY `order_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT for table `fb_order_details`
--
ALTER TABLE `fb_order_details`
  MODIFY `order_detail_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=102;

--
-- AUTO_INCREMENT for table `hotel_settings`
--
ALTER TABLE `hotel_settings`
  MODIFY `setting_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `invoice`
--
ALTER TABLE `invoice`
  MODIFY `invoice_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `invoice_activity`
--
ALTER TABLE `invoice_activity`
  MODIFY `activity_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `invoice_item`
--
ALTER TABLE `invoice_item`
  MODIFY `item_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

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
-- AUTO_INCREMENT for table `notification_settings`
--
ALTER TABLE `notification_settings`
  MODIFY `notification_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `payroll_run`
--
ALTER TABLE `payroll_run`
  MODIFY `payroll_run_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payroll_slip`
--
ALTER TABLE `payroll_slip`
  MODIFY `payroll_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=92;

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
  MODIFY `revenue_entry_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

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
  MODIFY `client_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

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
  MODIFY `user_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `user_roles`
--
ALTER TABLE `user_roles`
  MODIFY `user_role_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

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
-- Constraints for table `employee_addresses`
--
ALTER TABLE `employee_addresses`
  ADD CONSTRAINT `employee_addresses_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE CASCADE;

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
  ADD CONSTRAINT `fk_users_expenses` FOREIGN KEY (`users_id`) REFERENCES `accounting_users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE;

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
  ADD CONSTRAINT `fk_notification_customer` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_notification_order` FOREIGN KEY (`order_id`) REFERENCES `fb_orders` (`order_id`) ON DELETE SET NULL;

--
-- Constraints for table `fb_orders`
--
ALTER TABLE `fb_orders`
  ADD CONSTRAINT `fb_orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_order_staff` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`) ON DELETE SET NULL;

--
-- Constraints for table `fb_order_details`
--
ALTER TABLE `fb_order_details`
  ADD CONSTRAINT `fb_order_details_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `fb_orders` (`order_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fb_order_details_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `fb_menu_items` (`item_id`) ON DELETE CASCADE;

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
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `fb_orders` (`order_id`) ON DELETE CASCADE;

--
-- Constraints for table `payroll_slip`
--
ALTER TABLE `payroll_slip`
  ADD CONSTRAINT `fk_company_deductions` FOREIGN KEY (`company_deduction_id`) REFERENCES `company_deductions` (`deduction_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_payroll_run` FOREIGN KEY (`payroll_run_id`) REFERENCES `payroll_run` (`payroll_run_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_payroll_slip_hotel_management.employees` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_users_payroll` FOREIGN KEY (`users_id`) REFERENCES `accounting_users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE;

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
