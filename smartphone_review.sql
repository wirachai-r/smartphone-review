-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 15, 2025 at 04:34 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `smartphone_review`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `brand_image_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `brand_image_url`, `created_at`, `updated_at`) VALUES
(2, 'vivo (วีโว่)', '/storage/categories/VHBFpEbK2aubUbmaDuTpeqyFdUTvWxNa9lyVhjEr.jpg', '2025-10-07 09:18:06', '2025-10-09 18:48:38'),
(5, 'Honor (ออเนอร์)', '/storage/categories/fAyJkjnuyvq3xP527ktg60ppokRuiGTGNsWjzz8i.jpg', '2025-10-08 22:25:59', '2025-10-09 18:47:47'),
(6, 'Samsung (ซัมซุง)', '/storage/categories/YDGVoC4hdoi7ZHAAkvQVofHfxEDCdaeluI718SI8.jpg', '2025-10-08 22:26:00', '2025-10-09 18:52:07'),
(7, 'Infinix (อินฟินิกซ์)', '/storage/categories/dIdNjTookUxZu7kDjG8kGAsIW2OuCX8xdBV6lQK3.jpg', '2025-10-08 22:26:04', '2025-10-09 18:53:39'),
(8, 'TECNO (เทคโนโมบาย)', '/storage/categories/wpMzQnGDe9rBok6aYp8gleSgkG9VuKCf304fgwOo.jpg', '2025-10-08 22:26:09', '2025-10-09 18:56:09'),
(9, 'Xiaomi (เสียวหมี่)', '/storage/categories/RYAZ3kGhJnLh6QeiXab1K9HBrU47msy6TDAKFs7G.jpg', '2025-10-09 18:43:48', '2025-10-09 18:59:18'),
(10, 'OPPO (ออปโป้)', '/storage/categories/khUVFauRPgBVttRlMU6XRjHx8FWKWuiHcK1WJxuY.jpg', '2025-10-09 18:54:42', '2025-10-09 18:54:42'),
(12, 'Huawei (หัวเว่ย)', '/storage/categories/5ilQSIGBErkGCnOzWQd2VeH0Kci5uY8dSFIcl5W3.jpg', '2025-10-09 19:01:32', '2025-10-09 19:01:32'),
(13, 'POCO (โพโค่)', '/storage/categories/BrgfnQGg2WAbDB9dFYS3tAa47yRZzbDfuP0kpyPS.jpg', '2025-10-09 19:03:26', '2025-10-09 19:03:26'),
(14, 'Redmi (เรดหมี่)', '/storage/categories/kgvfqLupSJmkPTYibSrjrWNoJcITm5eDpkdyMEMD.jpg', '2025-10-09 19:05:26', '2025-10-09 19:06:13'),
(15, 'Apple (แอปเปิ้ล)', '/storage/categories/A4ZVGmFVvqEZ86lM6BVIEF2CmywteYqkK186wBjW.jpg', '2025-10-09 19:08:21', '2025-10-09 19:09:38'),
(17, 'realme (เรียวมี)', '/storage/categories/wfLwo7QrpHlUiXDnp9Tpoe2rq3btF6X2dK3auuEK.jpg', '2025-10-09 21:49:04', '2025-10-09 21:49:04');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `review_id` bigint(20) UNSIGNED NOT NULL,
  `body` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `images`
--

CREATE TABLE `images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `phone_id` bigint(20) UNSIGNED NOT NULL,
  `url` varchar(255) NOT NULL,
  `order` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `images`
--

INSERT INTO `images` (`id`, `phone_id`, `url`, `order`, `created_at`, `updated_at`) VALUES
(39, 5, '/storage/Phones/ciwRK8bBt93VwxNwXbnJkx8XvN73e1WLRwegZ6hu.jpg', 1, '2025-10-09 19:41:04', '2025-10-09 19:50:38'),
(40, 5, '/storage/Phones/M71unJyt0nJyY3dgOFzym0u4s8v8E1Clmd2IUnrr.jpg', 2, '2025-10-09 19:41:04', '2025-10-09 19:50:38'),
(41, 5, '/storage/Phones/vAYsjx3hhgsMWKU2TgYAosNIDipW1XwguqwxXlO1.jpg', 3, '2025-10-09 19:41:04', '2025-10-09 19:50:38'),
(42, 5, '/storage/Phones/NTawvkJCjxRMJBggsY52UhobEvNi1tYdMASdUUTt.jpg', 4, '2025-10-09 19:41:04', '2025-10-09 19:50:38'),
(43, 5, '/storage/Phones/VjP3P5chBGrLZoPYlkkNjVNkt83bpbgqHXnxilk6.jpg', 5, '2025-10-09 19:41:04', '2025-10-09 19:50:38'),
(44, 5, '/storage/Phones/ZdsxZobPxTRrM9e5KklWl2gLRkfPdqrnEdQhAYaY.jpg', 6, '2025-10-09 19:41:04', '2025-10-09 19:50:38'),
(45, 5, '/storage/Phones/63tPsKij5sKMc6JEDDJQ6Jm15wJOMCGI8lMlhRDi.jpg', 7, '2025-10-09 19:41:04', '2025-10-09 19:50:38'),
(46, 5, '/storage/Phones/8oms3ED0kzWmoxyUZijEmtdM6pftgjh4LPnDjSNJ.jpg', 8, '2025-10-09 19:41:04', '2025-10-09 19:50:38'),
(47, 5, '/storage/Phones/kuUspT2TPxhMrfaIQKaVfQGdocEXeQTpmHTlEp8P.jpg', 0, '2025-10-09 19:41:04', '2025-10-09 19:50:38'),
(48, 13, '/storage/Phones/t5FnO8IodrhscnlNIfIVJGR256zNd0OfTRh5afkR.jpg', 0, '2025-10-09 19:49:29', '2025-10-09 19:49:29'),
(49, 13, '/storage/Phones/JnCrONPbq7Ywz3C9OG4TQKjTk1iPnlajeKEIo4BH.jpg', 1, '2025-10-09 19:49:29', '2025-10-09 19:49:29'),
(50, 13, '/storage/Phones/mfrVGmeR9QQZbtcTswewl4iCziEZyV4Hnlno5Xxo.jpg', 2, '2025-10-09 19:49:29', '2025-10-09 19:49:29'),
(51, 13, '/storage/Phones/X2g2mTSIDa3BvElemh1NZUwRgj0gH85pldqL6zr2.jpg', 3, '2025-10-09 19:49:29', '2025-10-09 19:49:29'),
(52, 13, '/storage/Phones/XBpduXkG2PdcnMeb3Qcc7UWUb3P3VNyaWUGFABac.jpg', 4, '2025-10-09 19:49:29', '2025-10-09 19:49:29'),
(53, 13, '/storage/Phones/dEo1BoLRW5svzD3T36WRc86e2ftff4bXwXYgwlz4.jpg', 5, '2025-10-09 19:49:29', '2025-10-09 19:49:29'),
(54, 14, '/storage/Phones/LGuQyVwUOH4hOO3JtIB5WbbdMpWmKKaMpuultfkd.jpg', 0, '2025-10-09 19:57:04', '2025-10-09 19:57:04'),
(55, 14, '/storage/Phones/ahmLqFsIKiEtxVY6OJjd3TNI07N0aGsniIhUMPH6.jpg', 1, '2025-10-09 19:57:04', '2025-10-09 19:57:04'),
(56, 14, '/storage/Phones/4uyVh1WcBQAG6be0hromgZS96r5rwDsqxWi8jYou.jpg', 2, '2025-10-09 19:57:04', '2025-10-09 19:57:04'),
(57, 14, '/storage/Phones/NomTpWqLdMorbk6Zvm51IZXmUOPkgOo9wTwz71Ad.jpg', 3, '2025-10-09 19:57:04', '2025-10-09 19:57:04'),
(58, 14, '/storage/Phones/wNhuZUX9ZD8dzbTwXf2hJYkqvrtfyJIRUawIxXWQ.jpg', 4, '2025-10-09 19:57:04', '2025-10-09 19:57:04'),
(59, 14, '/storage/Phones/A5M4CTm6F4P2ooSxWe4LgmfqMG9tMQtGaLNNM2r4.jpg', 5, '2025-10-09 19:57:04', '2025-10-09 19:57:04'),
(60, 14, '/storage/Phones/AZW66na7yXovoV4DLAmGh7mCd2tpu7IiD2gnY7nq.jpg', 6, '2025-10-09 19:57:04', '2025-10-09 19:57:04'),
(61, 14, '/storage/Phones/uefsTwKflWRd5QR0UUyv6s6WKzPxhQRQJiuOnVU3.jpg', 7, '2025-10-09 19:57:04', '2025-10-09 19:57:04'),
(62, 15, '/storage/Phones/DKvIFufIwKNP8gFChGpjrEDmWdnq11TFjwTNCRju.jpg', 0, '2025-10-09 20:02:51', '2025-10-09 20:02:51'),
(63, 15, '/storage/Phones/zdtur4cEJ4GSnkRQrZPpCJL4COFD6bCoiTw3bhLq.jpg', 1, '2025-10-09 20:02:51', '2025-10-09 20:02:51'),
(64, 15, '/storage/Phones/rQdMl5qpv2YppIlfZzUYQKFPeKgQWZEnLy03p4Ol.jpg', 2, '2025-10-09 20:02:51', '2025-10-09 20:02:51'),
(65, 15, '/storage/Phones/PpOFReilHZzLdk3QcVGrBFcWt06zso8pvFHnauy7.jpg', 3, '2025-10-09 20:02:51', '2025-10-09 20:02:51'),
(66, 15, '/storage/Phones/yQgtvqr0BiSiks2E243ZRXPJ7DtGxxgtsamlGmK0.jpg', 4, '2025-10-09 20:02:51', '2025-10-09 20:02:51'),
(67, 15, '/storage/Phones/pBj0GFxIdnb1xyDnAi1MDWeAwnr0GEz3IWhk0iY8.jpg', 5, '2025-10-09 20:02:51', '2025-10-09 20:02:51'),
(68, 15, '/storage/Phones/FChWf3PaHevnuZLMyGKdZLF4AUYGwMjR4BJss0yA.jpg', 6, '2025-10-09 20:02:51', '2025-10-09 20:02:51'),
(69, 15, '/storage/Phones/Tfeo0DUsW1IbLAKu55889p5JrwtauqyF8c0vZv0R.jpg', 7, '2025-10-09 20:02:51', '2025-10-09 20:02:51'),
(70, 15, '/storage/Phones/8choIjcel2fepERKV7aN6ozcfmZyRv5NNX8bAqq4.jpg', 8, '2025-10-09 20:02:51', '2025-10-09 20:02:51'),
(71, 16, '/storage/Phones/bcTUTmF9ZoPgf5alWq3wCIN8zHLrzFablpTJ1TUz.jpg', 0, '2025-10-09 20:14:49', '2025-10-09 20:14:49'),
(72, 16, '/storage/Phones/XxsIlqrYUXUM5w11ewAPbL518s0fXJMB8QhfBXWX.jpg', 1, '2025-10-09 20:14:49', '2025-10-09 20:14:49'),
(73, 16, '/storage/Phones/5TT0MKcLjRKjSJVig0EVMXdgKCeGfX5mAp4bFJMu.jpg', 2, '2025-10-09 20:14:49', '2025-10-09 20:14:49'),
(74, 16, '/storage/Phones/cwU4NPDYOjg5ZX1aKb6E4rNgQ4TbCrdpqVCa2Ny4.jpg', 3, '2025-10-09 20:14:49', '2025-10-09 20:14:49'),
(75, 16, '/storage/Phones/9p5OyNo0cnLIADB9jA3JyNffP2uDiqaCUuRUngAC.jpg', 4, '2025-10-09 20:14:49', '2025-10-09 20:14:49'),
(76, 16, '/storage/Phones/1UAxOaQFm4IbkaLv87ejh2B3Ld8kjLB8CGTVHe9Z.jpg', 5, '2025-10-09 20:14:49', '2025-10-09 20:14:49'),
(77, 16, '/storage/Phones/zSLNc9YmkoOdpLvxR95ZEXzc98yLlBSjo4qUZPNL.jpg', 6, '2025-10-09 20:14:49', '2025-10-09 20:14:49'),
(78, 17, '/storage/Phones/x0VprrXNX9skabOS2Tg1vPBudLvvroo2jf7WUhgC.jpg', 0, '2025-10-09 20:20:43', '2025-10-09 20:20:43'),
(79, 17, '/storage/Phones/fS3shbQ8uGT8pGp0slYbz1sHVe2jJSO0Jkdsne82.jpg', 1, '2025-10-09 20:20:43', '2025-10-09 20:20:43'),
(80, 17, '/storage/Phones/KLGRjjWsDwXhB7L1dcxV0q1ng3lxq9rQw7MOYG0R.jpg', 2, '2025-10-09 20:20:43', '2025-10-09 20:20:43'),
(81, 17, '/storage/Phones/P3Jsy4M0bnowVI8psoTT5htaKrfMgFua2mXHbARG.jpg', 3, '2025-10-09 20:20:43', '2025-10-09 20:20:43'),
(82, 17, '/storage/Phones/isgSzbx4Edy3NUkoizRhqxtuAgyUr7plL5beRUBF.jpg', 4, '2025-10-09 20:20:43', '2025-10-09 20:20:43'),
(83, 17, '/storage/Phones/oGI1eertXvqS3PmsEZw9bnPlnLcppopqzoIl44s6.jpg', 5, '2025-10-09 20:20:43', '2025-10-09 20:20:43'),
(84, 17, '/storage/Phones/XGCNX6bfDoMrwyiKIZ8u2JODjMtE35ojmw5W2DYr.jpg', 6, '2025-10-09 20:20:43', '2025-10-09 20:20:43'),
(85, 17, '/storage/Phones/9STpx5BTAX3Wj7tAB8h3vhXGaLf28uUN3MxI4Zt6.jpg', 7, '2025-10-09 20:20:43', '2025-10-09 20:20:43'),
(86, 17, '/storage/Phones/NQdBKrSd31IVCaA4PMvCQrKM8aIAZ1RmzWUa26ik.jpg', 8, '2025-10-09 20:20:43', '2025-10-09 20:20:43'),
(87, 17, '/storage/Phones/4mun6LMLSstWVTsftyma4RSICgo31Yx20m5Plp68.jpg', 9, '2025-10-09 20:20:43', '2025-10-09 20:20:43'),
(88, 18, '/storage/Phones/Ek7QvTDJJbVJMs0fmtSE1QeYv8S8QXgkNIiLFBcZ.jpg', 0, '2025-10-09 20:27:45', '2025-10-09 20:27:45'),
(89, 18, '/storage/Phones/AND6EdEtrWIKlYUCGjRZ3FGi8npXt6LFxBu8bfGY.jpg', 1, '2025-10-09 20:27:45', '2025-10-09 20:27:45'),
(90, 18, '/storage/Phones/QhPCZTy4E4nQSqqpbuCse3BQ7pEhf1vZOEbm4EKi.jpg', 2, '2025-10-09 20:27:45', '2025-10-09 20:27:45'),
(91, 18, '/storage/Phones/pvgl6S0B0QxYxtvbkZlWIoGTFdbnqXKJDOZUsKek.jpg', 3, '2025-10-09 20:27:45', '2025-10-09 20:27:45'),
(92, 18, '/storage/Phones/SLgnCPKJmFjeaWhRqJTjHO71qrWZslC8O75WJn87.jpg', 4, '2025-10-09 20:27:45', '2025-10-09 20:27:45'),
(93, 18, '/storage/Phones/KfV6r48ftVZpXPLwypRPf0S1BDOqxtFAFk8veoN2.jpg', 5, '2025-10-09 20:27:45', '2025-10-09 20:27:45'),
(94, 18, '/storage/Phones/nYE4kDJANmAmH23jJQrCN9KpKfBOzjTArliMrkfK.jpg', 6, '2025-10-09 20:27:45', '2025-10-09 20:27:45'),
(95, 18, '/storage/Phones/FpLFk0tvNJCmuiO810uKngqfO2n2qdDegvYYjaI5.jpg', 7, '2025-10-09 20:27:45', '2025-10-09 20:27:45'),
(96, 19, '/storage/Phones/kI6KhmZIND6C2GQtVjklZtqmsxFBy0upIEYU7qqL.jpg', 0, '2025-10-09 20:38:04', '2025-10-09 20:38:04'),
(97, 19, '/storage/Phones/sgOYKYPF9NsilLfYqSBTsACQfRtWwyCpoqvwnp3O.jpg', 1, '2025-10-09 20:38:04', '2025-10-09 20:38:04'),
(98, 19, '/storage/Phones/f7DHUk3qXHjXgZNiFYrcn8dWjYf8lU17e5n6jov4.jpg', 2, '2025-10-09 20:38:04', '2025-10-09 20:38:04'),
(99, 19, '/storage/Phones/QVAyQ70st6YH1juu5yYcgJWva1KgW211WwmnWg4L.jpg', 3, '2025-10-09 20:38:04', '2025-10-09 20:38:04'),
(100, 19, '/storage/Phones/EVvwSSFfjKDX6ii6XqH0WGnJ4Krt3rGxU1i5VKOM.jpg', 4, '2025-10-09 20:38:04', '2025-10-09 20:38:04'),
(101, 19, '/storage/Phones/CCmXn1HtuFfKARKR5MuJiLRFJQZwi1B8qNiQS1c8.jpg', 5, '2025-10-09 20:38:04', '2025-10-09 20:38:04'),
(102, 19, '/storage/Phones/poO7vGVwxE8lvdDrEbCaOdr6E9UM00kTcL8EMV0R.jpg', 6, '2025-10-09 20:38:04', '2025-10-09 20:38:04'),
(103, 19, '/storage/Phones/In70EgOxGo05Ddwl5yCbbcMz4NCT2hbBRTAxR9Ng.jpg', 7, '2025-10-09 20:38:04', '2025-10-09 20:38:04'),
(104, 19, '/storage/Phones/dlVHNygPJIEhjlbvullSsqW6tAqhOx9fEx4IsjfY.jpg', 8, '2025-10-09 20:38:04', '2025-10-09 20:38:04'),
(105, 19, '/storage/Phones/Bv7iYB6LY0SYADvOft5WKiScmujdfMQz4zCmp211.jpg', 9, '2025-10-09 20:38:04', '2025-10-09 20:38:04'),
(106, 19, '/storage/Phones/zqpyWE5KClmDH410LodzEPMV0K9kpXkPipnV1Gs4.jpg', 10, '2025-10-09 20:38:04', '2025-10-09 20:38:04'),
(107, 19, '/storage/Phones/p3ExfnEp8dqi65U3gZVHycOSMjaxoxJ0xNucnDUg.jpg', 11, '2025-10-09 20:38:04', '2025-10-09 20:38:04'),
(108, 20, '/storage/Phones/v8xpEtNWeL7RP3BOUaRCIsmXQPqbTUH5aEHtPoKj.jpg', 0, '2025-10-09 20:50:10', '2025-10-09 20:50:10'),
(109, 20, '/storage/Phones/hSFEwmMcTMnu0k8eGscbc9gxQgMk63wO4dTVtP1t.jpg', 1, '2025-10-09 20:50:10', '2025-10-09 20:50:10'),
(110, 20, '/storage/Phones/b1Wxb7eHmpkWj32fnMvSLlOCyITFIjyuWLiRTVBZ.jpg', 2, '2025-10-09 20:50:10', '2025-10-09 20:50:10'),
(111, 20, '/storage/Phones/lBMbRudYG6mmkT7dTWgLfIkGEbAmBsu7BPRMDZBm.jpg', 3, '2025-10-09 20:50:10', '2025-10-09 20:50:10'),
(112, 20, '/storage/Phones/bd54ZjQ1ubrHC263yYFZWOKcqqFUxz5i0qkse4b4.jpg', 4, '2025-10-09 20:50:10', '2025-10-09 20:50:10'),
(113, 20, '/storage/Phones/t0xho6k7xpxh5U9V2pIcK42yNmTdlUKjzbamfkK5.jpg', 5, '2025-10-09 20:50:10', '2025-10-09 20:50:10'),
(114, 20, '/storage/Phones/l37WH6Mh88Rr6OPz998p5hCX54oQjxZfEi4KRFW8.jpg', 6, '2025-10-09 20:50:10', '2025-10-09 20:50:10'),
(115, 20, '/storage/Phones/1Fw7d1cudy4IYCdvg4Jp3nP9PqSqZKtGZLZp1Jdi.jpg', 7, '2025-10-09 20:50:10', '2025-10-09 20:50:10'),
(116, 20, '/storage/Phones/PQjxijaqTGPqIfLTKeJ95d0oQnkQToJ85ZFsUTX4.jpg', 8, '2025-10-09 20:50:10', '2025-10-09 20:50:10'),
(117, 20, '/storage/Phones/Wb9EHNYpbglD9J1XmxZd0aJNAMq1grgXft8TvCks.jpg', 9, '2025-10-09 20:50:10', '2025-10-09 20:50:10'),
(118, 20, '/storage/Phones/ffPupA9lIvHUCBNDvXhAkyiCXmrOidnVQI8eLU8Y.jpg', 10, '2025-10-09 20:50:10', '2025-10-09 20:50:10'),
(119, 21, '/storage/Phones/KGUMFoXUO4FE7FcLmM3kcfcJoRONUI2eifNCe46d.jpg', 0, '2025-10-09 20:57:19', '2025-10-09 20:57:19'),
(120, 21, '/storage/Phones/j69TV0fv8xBnBL2vvVsHMqbcDlwrLRnM36vInoaS.jpg', 1, '2025-10-09 20:57:19', '2025-10-09 20:57:19'),
(121, 21, '/storage/Phones/jwQ7Aq326OCVPtGcwqmz9jD1nsBHmR8q50sCugjC.jpg', 2, '2025-10-09 20:57:19', '2025-10-09 20:57:19'),
(122, 21, '/storage/Phones/VYMfuj1iqgeyKJwZoc2Plq4QD8pCL2IgbGORYFLO.jpg', 3, '2025-10-09 20:57:19', '2025-10-09 20:57:19'),
(123, 21, '/storage/Phones/iRNorrCAj8VQ1xkP5MmWww6GWRPzBjM2UxOZXW2I.jpg', 4, '2025-10-09 20:57:19', '2025-10-09 20:57:19'),
(124, 21, '/storage/Phones/QWQ3t0gD7DrdLtIdCCWNWl7O7IDyaCVu5PZCnV9b.jpg', 5, '2025-10-09 20:57:19', '2025-10-09 20:57:19'),
(125, 21, '/storage/Phones/Idf25ScNlz1LDpbVGMlUImOlYuefm4zIIboeJRss.jpg', 6, '2025-10-09 20:57:19', '2025-10-09 20:57:19'),
(126, 21, '/storage/Phones/rYppGF2OF9BysPdHdXOfz5wYhxadyjNS3yDQvpCP.jpg', 7, '2025-10-09 20:57:19', '2025-10-09 20:57:19'),
(127, 21, '/storage/Phones/cRd0LPPFeDyKMXcQXATkMXlqZLu7RBeJzxjUV2TR.jpg', 8, '2025-10-09 20:57:19', '2025-10-09 20:57:19'),
(128, 21, '/storage/Phones/xLs8mCVywyYYISrorR3WRnEqSJiAqNTJB8S3lZ1B.jpg', 9, '2025-10-09 20:57:19', '2025-10-09 20:57:19'),
(129, 21, '/storage/Phones/0Ptlv5byarnQXCLipvMfqmz8AW0zdp7x8RXYc6BC.jpg', 10, '2025-10-09 20:57:19', '2025-10-09 20:57:19'),
(130, 21, '/storage/Phones/HshK86YpIqLCGKJYOm5GKtPXPTqtCOqofQAGCti3.jpg', 11, '2025-10-09 20:57:19', '2025-10-09 20:57:19'),
(131, 21, '/storage/Phones/xcYgzcLnysqTks2iQDWvxRCwwA5eZton8LRX75zH.jpg', 12, '2025-10-09 20:57:19', '2025-10-09 20:57:19'),
(132, 21, '/storage/Phones/Hp0PQ4xdk1mgTFbfxDeI1cbVCSIfj03fKLQGZYRH.jpg', 13, '2025-10-09 20:57:19', '2025-10-09 20:57:19'),
(133, 21, '/storage/Phones/90jIgiUGBVAigE8lkFGmPysKZxoGq2UZvUWh7Y6l.jpg', 14, '2025-10-09 20:57:19', '2025-10-09 20:57:19'),
(134, 22, '/storage/Phones/f61rQQwta0jzIbLjtkGPAlg2DGxu3HJ7duoZGbpM.jpg', 0, '2025-10-09 21:04:19', '2025-10-09 21:04:19'),
(135, 22, '/storage/Phones/dLWmq5UZpNhWVggmx4OsHWfUMWIWStaICOfcSr1L.jpg', 1, '2025-10-09 21:04:19', '2025-10-09 21:04:19'),
(136, 22, '/storage/Phones/drVJjrwaaS2y3oN43gqV82g7YqEEdhlL9fuaTcgq.jpg', 2, '2025-10-09 21:04:19', '2025-10-09 21:04:19'),
(137, 22, '/storage/Phones/rnHFclgKQAqgBDotQMKGg6qPocPZoZ5pVnf6lSZf.jpg', 3, '2025-10-09 21:04:19', '2025-10-09 21:04:19'),
(138, 22, '/storage/Phones/WBmp9J8erHbODdNZIWW4Ev02IbeKOLNn4jgZh8wW.jpg', 4, '2025-10-09 21:04:19', '2025-10-09 21:04:19'),
(139, 22, '/storage/Phones/3BOyPatqFpdnOdBkipAZe5UujcplSNvzSsHDRWCe.jpg', 5, '2025-10-09 21:04:19', '2025-10-09 21:04:19'),
(140, 22, '/storage/Phones/UhxNVjZEFMb8oxDvYRUoKCvWJRyC14yW2glxNW8m.jpg', 6, '2025-10-09 21:04:19', '2025-10-09 21:04:19'),
(141, 22, '/storage/Phones/OTWZ2zWAUNt8Cr48HWDBIaPpGckN9pOmax3ny6Zl.jpg', 7, '2025-10-09 21:04:19', '2025-10-09 21:04:19'),
(142, 22, '/storage/Phones/yN24OZByMlXvs46Hj6796UJH4WGcIXpB1I2BjRBB.jpg', 8, '2025-10-09 21:04:19', '2025-10-09 21:04:19'),
(143, 22, '/storage/Phones/W42IaX2Bb3nx5CbmKOclvFk5lJYsMacrTwi2IJxj.jpg', 9, '2025-10-09 21:04:19', '2025-10-09 21:04:19'),
(144, 22, '/storage/Phones/A5OdYBXOgRPN0SNq8Nd3Fonqd7PAq7QDa3VhoEPB.jpg', 10, '2025-10-09 21:04:19', '2025-10-09 21:04:19'),
(145, 22, '/storage/Phones/3ChNCtOB2RtU7YbBM0DJStDUcBEEpeGJlXsLTmeh.jpg', 11, '2025-10-09 21:04:19', '2025-10-09 21:04:19'),
(146, 22, '/storage/Phones/FaB7wRjS3YuCTUQmbsghgsXvXauzko7amG25okca.jpg', 12, '2025-10-09 21:04:19', '2025-10-09 21:04:19'),
(147, 22, '/storage/Phones/Zv38EituWq4Oa9n7HhqXEcKnG4snjuvpjs5ru4yq.jpg', 13, '2025-10-09 21:04:19', '2025-10-09 21:04:19'),
(148, 22, '/storage/Phones/0Ne2om4kMhOMeqBuWQ8RSyi1FjVSozF49Z8fpkY4.jpg', 14, '2025-10-09 21:04:19', '2025-10-09 21:04:19'),
(149, 22, '/storage/Phones/XMGq1sbACSnewyaR9SZr5TDEDvcExNbS4JjDwHUf.jpg', 15, '2025-10-09 21:04:19', '2025-10-09 21:04:19'),
(150, 22, '/storage/Phones/GK2u2fFRZLMyFU8WuHTXfs1Ay9ASNbbbBC9JdAZt.jpg', 16, '2025-10-09 21:04:19', '2025-10-09 21:04:19'),
(151, 22, '/storage/Phones/ky3MXtRHqZcc8awW3Fcs8UR2rkzpCbcp2HuvVp97.jpg', 17, '2025-10-09 21:04:19', '2025-10-09 21:04:19'),
(152, 22, '/storage/Phones/u84rCyeBz5uCLwYkBGSGkHKS6EvV2o0ksr88loKc.jpg', 18, '2025-10-09 21:04:19', '2025-10-09 21:04:19'),
(153, 22, '/storage/Phones/sEtcYRU85HwHkD0AayyhvEyggflDvx34jEzJyOkt.jpg', 19, '2025-10-09 21:04:19', '2025-10-09 21:04:19'),
(154, 23, '/storage/Phones/13IZWsVVGvJOBmnbOh1iU4EdlZN3X8oYQU30joDb.jpg', 0, '2025-10-09 21:10:43', '2025-10-09 21:10:43'),
(155, 23, '/storage/Phones/45Zy5BWcHUcZI0JX096BIy1wztAllAVi15ZyhRXO.jpg', 1, '2025-10-09 21:10:43', '2025-10-09 21:10:43'),
(156, 23, '/storage/Phones/kv0WqzJ3EmWfZsXtje9ZGi62jt36KLF7hQKHgFu2.jpg', 2, '2025-10-09 21:10:43', '2025-10-09 21:10:43'),
(157, 23, '/storage/Phones/ngPIDciGnssYmgHuGT1tRwulzVhX2wD8olDLUB9W.jpg', 3, '2025-10-09 21:10:43', '2025-10-09 21:10:43'),
(158, 23, '/storage/Phones/z3RG23a5qgEzDORL2K7sa5dydj3pP4MsfOtSt9Nz.jpg', 4, '2025-10-09 21:10:43', '2025-10-09 21:10:43'),
(159, 23, '/storage/Phones/Jy8Fv48Z0hGQXVq8MqNinv4QqPDAxs1RgEdiNKkn.jpg', 5, '2025-10-09 21:10:43', '2025-10-09 21:10:43'),
(160, 24, '/storage/Phones/VWdlyJ54MZ4a5jp7Q638QdxxcHqDGlaOvaiZkaeY.jpg', 0, '2025-10-09 21:19:24', '2025-10-09 21:19:24'),
(161, 24, '/storage/Phones/jxllQtdF7rmgsq3SaqEkLIZmTRN64TROiSYuNHT2.jpg', 1, '2025-10-09 21:19:24', '2025-10-09 21:19:24'),
(162, 24, '/storage/Phones/fy7ONdPtPhnbtYDZhE7R0vt8XKhP2zYgSWT2fal3.jpg', 2, '2025-10-09 21:19:24', '2025-10-09 21:19:24'),
(163, 24, '/storage/Phones/7jw9zEqC4YFPNJRT3sD2CIakepb0ym5wa6lkjjIB.jpg', 3, '2025-10-09 21:19:24', '2025-10-09 21:19:24'),
(164, 24, '/storage/Phones/3FAj2RcLVcVqCIq6k9atfcQxosL1dzVyrVkFiMov.jpg', 4, '2025-10-09 21:19:24', '2025-10-09 21:19:24'),
(165, 24, '/storage/Phones/QMnUNn1c4Oh1DZY88z089GjyvQAYty9ZWKSkBM3r.jpg', 5, '2025-10-09 21:19:24', '2025-10-09 21:19:24'),
(166, 24, '/storage/Phones/nUp8Soqs9q3NRQJfCOpwEAEnqXXGoYQXydFs6Va5.jpg', 6, '2025-10-09 21:19:24', '2025-10-09 21:19:24'),
(167, 24, '/storage/Phones/V6moFvGlAxM93Z8ujcIifS1owIXR8jO81izh460w.jpg', 7, '2025-10-09 21:19:24', '2025-10-09 21:19:24'),
(168, 25, '/storage/Phones/LFlxgtT0XLwGYuO0bYXt5TqWrHC89BQ6j2Q4IqgV.jpg', 0, '2025-10-09 21:25:38', '2025-10-09 21:25:38'),
(169, 25, '/storage/Phones/bG7ca7J645HFda8BkvDuuA61Djl7AqrSxZOnltiF.jpg', 1, '2025-10-09 21:25:38', '2025-10-09 21:25:38'),
(170, 25, '/storage/Phones/DFySVmtTc8enR9KGdfn5iq4mEEQTsEGoBMrqjysr.jpg', 2, '2025-10-09 21:25:38', '2025-10-09 21:25:38'),
(171, 25, '/storage/Phones/oCW5HfaBJ0zfzyB04p6OPAkdiEBaVVCOeF9maryc.jpg', 3, '2025-10-09 21:25:38', '2025-10-09 21:25:38'),
(172, 25, '/storage/Phones/s1TMC0ChzT3mMc8Ji3UXXzbfiSkUcpYBS34OOxMA.jpg', 4, '2025-10-09 21:25:38', '2025-10-09 21:25:38'),
(173, 25, '/storage/Phones/OAwHcdefxG5l2aOorEgH90EV8eIJlGFHODXNCT6s.jpg', 5, '2025-10-09 21:25:38', '2025-10-09 21:25:38'),
(174, 25, '/storage/Phones/sJ59sj0FPPsE0NcncUsGBE4LruSFowhn79ZOQmbG.jpg', 6, '2025-10-09 21:25:38', '2025-10-09 21:25:38'),
(175, 25, '/storage/Phones/AefX0WZhqm6ZffY35BWZJRPasjfSZd4M8gnQxkGK.jpg', 7, '2025-10-09 21:25:38', '2025-10-09 21:25:38'),
(176, 25, '/storage/Phones/FAKl03TLOUrqbL2snDphgxLZfCP51nL1GL0SXahY.jpg', 8, '2025-10-09 21:25:38', '2025-10-09 21:25:38'),
(177, 25, '/storage/Phones/RUl5fOawnMnPoeLzcXnGwk9XjnFv2PORE6YfIiwv.jpg', 9, '2025-10-09 21:25:38', '2025-10-09 21:25:38'),
(178, 26, '/storage/Phones/Sk40tNmf1bAGVw2pWpYelOOft7qRgmFZjK4WncBv.jpg', 0, '2025-10-09 21:29:39', '2025-10-09 21:29:39'),
(179, 26, '/storage/Phones/4bUAQ1ZU6Ercf7wbXoI4AuzNfDFigpIsQwHpjZDt.jpg', 1, '2025-10-09 21:29:39', '2025-10-09 21:29:39'),
(180, 26, '/storage/Phones/AwjNmdraQKfMNPXZItr4FbepEQ7uCt9R7Tz9FBKh.jpg', 2, '2025-10-09 21:29:39', '2025-10-09 21:29:39'),
(181, 26, '/storage/Phones/ORxxucvUyB2UgxXeWZN4AWeTbcNsSZ9hvQeneAsh.jpg', 3, '2025-10-09 21:29:39', '2025-10-09 21:29:39'),
(182, 26, '/storage/Phones/7rInpJ9zDXAMBbdDX29oTqT4FamjxNb2Z1BkcQ59.jpg', 4, '2025-10-09 21:29:39', '2025-10-09 21:29:39'),
(183, 26, '/storage/Phones/VcXYkTGvtW4bIItgn6cGPpHmKqGtraltDgXul2Jl.jpg', 5, '2025-10-09 21:29:39', '2025-10-09 21:29:39'),
(184, 26, '/storage/Phones/NckrBXZ9sdjyKAiKDvxuiALK0HzGo4Ybina5f9rn.jpg', 6, '2025-10-09 21:29:39', '2025-10-09 21:29:39'),
(185, 26, '/storage/Phones/8SejEZEPz77vijDgDr6uDSfOBtEQlJGvC0IJSWZA.jpg', 7, '2025-10-09 21:29:39', '2025-10-09 21:29:39');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `likes`
--

CREATE TABLE `likes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `phone_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `likes`
--

INSERT INTO `likes` (`id`, `user_id`, `phone_id`, `created_at`, `updated_at`) VALUES
(15, 1, 5, '2025-10-09 04:19:30', '2025-10-09 04:19:30'),
(19, 4, 19, '2025-10-09 21:50:26', '2025-10-09 21:50:26'),
(20, 4, 22, '2025-10-09 21:51:34', '2025-10-09 21:51:34'),
(21, 4, 21, '2025-10-09 21:51:49', '2025-10-09 21:51:49'),
(22, 4, 20, '2025-10-09 21:52:20', '2025-10-09 21:52:20'),
(23, 5, 22, '2025-10-09 21:56:17', '2025-10-09 21:56:17'),
(24, 5, 21, '2025-10-09 21:56:31', '2025-10-09 21:56:31'),
(25, 6, 21, '2025-10-09 22:08:28', '2025-10-09 22:08:28'),
(26, 6, 19, '2025-10-09 22:09:57', '2025-10-09 22:09:57'),
(27, 6, 20, '2025-10-09 22:10:06', '2025-10-09 22:10:06'),
(28, 3, 14, '2025-10-10 01:40:45', '2025-10-10 01:40:45');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_10_04_112638_create_categories_table', 1),
(5, '2025_10_04_112647_create_phones_table', 1),
(6, '2025_10_04_112651_create_images_table', 1),
(7, '2025_10_04_112655_create_reviews_table', 1),
(8, '2025_10_04_112700_create_comments_table', 1),
(9, '2025_10_04_112703_create_likes_table', 1),
(10, '2025_10_04_151812_create_personal_access_tokens_table', 1),
(11, '2025_10_08_154255_add_colors_to_phones_table', 2),
(12, '2025_10_09_021752_create_likes_table', 3),
(13, '2025_10_09_155048_add_status_to_reviews_table', 4),
(14, '2025_10_09_155338_add_status_to_users_table', 4);

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` text NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(47, 'App\\Models\\User', 1, 'auth_token', '5707181a0fdf4f37ca50115d31208f0258657ef0991056ed04d1844524398802', '[\"*\"]', NULL, NULL, '2025-10-10 01:31:44', '2025-10-10 01:31:44'),
(48, 'App\\Models\\User', 1, 'auth_token', 'c1c8abdc62e783b50149d047a1d5147d975ca27e4d896e1ead59d5b599cc0f5b', '[\"*\"]', '2025-10-11 05:41:30', NULL, '2025-10-10 01:31:45', '2025-10-11 05:41:30'),
(49, 'App\\Models\\User', 3, 'auth_token', '525152ea6f389b0a61f927ba7f671fd1ae2de5754bf6aab56d8a75ed469a068d', '[\"*\"]', NULL, NULL, '2025-10-10 01:33:10', '2025-10-10 01:33:10'),
(50, 'App\\Models\\User', 3, 'auth_token', '2bcc9b9d2331ae429233f813bc6d77f0c72866f0980663fca074b36d4c4e85a9', '[\"*\"]', '2025-10-10 01:40:45', NULL, '2025-10-10 01:33:12', '2025-10-10 01:40:45');

-- --------------------------------------------------------

--
-- Table structure for table `phones`
--

CREATE TABLE `phones` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `model` varchar(150) NOT NULL,
  `summary` text DEFAULT NULL,
  `release_date` date DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `main_image_url` varchar(255) DEFAULT NULL,
  `specs` longtext DEFAULT NULL,
  `colors` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`colors`)),
  `views` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `category_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `phones`
--

INSERT INTO `phones` (`id`, `model`, `summary`, `release_date`, `price`, `main_image_url`, `specs`, `colors`, `views`, `category_id`, `created_at`, `updated_at`) VALUES
(5, 'vivo Y21d', '{\"screen\":\"6.68 นิ้ว, IPS-LCD 24-bit, 720 x 1608 พิกเซล\",\"camera\":\"กล้องหลัง: 50MP + 0.08MP (Auxiliary lens)  กล้องหน้า: 5MP\",\"cpu\":\"T7225 Octa Core ความเร็ว 1.8 GHz\",\"memory\":\"RAM 4/6GB  ROM 128/256GB \",\"battery\":\"6,500 mAh ชาร์จไว 44w\",\"os\":\" Funtouch OS  Android 15\",\"dimensions\":\"166.14 × 77.01 × 8.39 มม.\",\"weight\":\"209 กรัม\"}', '2025-10-09', 4499, '/storage/Phones/kuUspT2TPxhMrfaIQKaVfQGdocEXeQTpmHTlEp8P.jpg', '<p><strong>ข้อมูลมือถือ vivo Y21d</strong></p><ul><li>เปิดตัวครั้งแรก 9 ตุลาคม 2025 (สยามโฟนฯ)</li><li>สถานะ มีวางจำหน่ายในประเทศไทย</li><li>วางจำหน่าย ไตรมาสที่ 4 ปี 2025 (ตุลาคม 68)</li><li>- ราคาเปิดตัว 4,499 บาท (ตุลาคม 68)</li><li>รุ่น RAM 4GB + ROM 128GB ราคา 4,499 บาท , RAM 6GB + ROM 128GB ราคา 4,999 บาท</li><li>รุ่น RAM 6GB + ROM 256GB ราคา 5,999 บาท</li></ul><p><strong>จอแสดงผล (Display)</strong></p><ul><li>สมาร์ทโฟน (โทรศัพท์มือถือพร้อมระบบปฏิบัติการ)</li><li>จอแสดงผล IPS-LCD 24-bit (16 ล้านสี)</li><li>- จอแสดงผลมีรูสำหรับกล้องหน้า (Punch-Hole Display)</li><li>- กว้าง 6.68 นิ้ว (แนวทะแยง)</li><li>- ความละเอียด 720 x 1608 พิกเซล</li><li>(264 ppi)</li><li>- อัตราการสัมผัสหน้าจอ 90 เฮิรตซ์ (Refresh Rate 90Hz)</li><li>ค่าความสว่างหน้าจอ (Display Brightness)</li><li>- ค่าความสว่างทั่วไป (Typical brightness) 1000 nits</li><li>จอแสดงผลรอง (ไม่ระบุ) 1-bit (2 สีขาว/ดำ)</li></ul><p><strong>วัสดุตัวเครื่อง (Body)</strong></p><ul><li>หน้าจอกระจก</li><li>กรอบพลาสติก</li><li>คุณสมบัติทนน้ำและระบบป้องกัน (Waterproof &amp; Resistance to dust)</li><li>- ทนน้ำได้ชั่วคราว</li><li>มาตรฐาน IP68 / IP69</li><li>มีสีให้เลือก (Colors) : Black, Red, Purple</li></ul><p><strong>เครือข่าย (Network)</strong></p><ul><li>ใช้งาน Nano-SIM</li><li>รองรับ 2 ซิมการ์ด</li><li>เทคโนโลยีรับ/ส่งข้อมูล 3G , 4G</li><li>ข้อมูลเครือข่าย</li><li>- GSM 900/1800/1900 MHz</li><li>- UMTS 850/900/1900/2100 MHz</li><li>- LTE Bands 1/ 2/ 3/ 4/ 5/ 7/ 8/ 12/ 13/ 17/ 18/ 19/ 20/ 25/ 26/ 28/ 28/ 31/ 34/ 38/ 39/ 40/ 41/ 42/ 48/ 66</li></ul><p><strong>ระบบปฏิบัติการ (OS, CPU, GPU)</strong></p><ul><li>Funtouch OS 15 based on Android 15</li><li>T7225 Octa Core</li><li>ความเร็ว : 1.8 GHz</li><li>RAM 4/6GB, ROM 128/256GB , microSD สูงสุด 2 TB</li></ul><p><strong>&nbsp;กล้องหลัง (Rear Camera)</strong></p><ul><li>กล้องดิจิตอล 50 + 0.08MP (Auxiliary lens) ล้านพิกเซล (Dual Camera)</li><li>- รูรับแสงขนาด ƒ/1.8</li><li>- ไฟแฟลช LED</li><li>- ขนาดภาพสูงสุด 8,000 x 6,000 พิกเซล (Image Size)</li><li>- โฟกัสอัตโนมัติ (Auto Focus)</li><li>- แตะเลือกจุดโฟกัส (Touch Focus)</li><li>- ค้นหาใบหน้าอัตโนมัติ (Face Detection)</li><li>- เทคโนโลยีถ่ายภาพอัจฉริยะ (AI Camera)</li><li>- โหมดหน้าสวย (Face Beauty)</li><li>- โหมดปรับหน้าสวยอัตโนมัติ (AI Face Beauty)</li><li>- ตั้งเวลาถ่ายภาพอัตโนมัติ (Self-Timer)</li><li>- โหมดถ่ายภาพพาโนราม่า (Panorama)</li><li>- ระบบโฟกัสภาพ Phase Detection Auto Focus (PDAF)</li><li>- โหมดถ่ายภาพช่วงการรับแสงสูง (HDR)</li></ul><p><strong>กล้องหน้า (Front Camera)</strong></p><ul><li>ความละเอียด 5MP</li><li>- รูรับแสงขนาด ƒ/2.0</li></ul><p><strong>บันทึกวิดีโอ (Video Recording)</strong></p><ul><li>บันทึกวิดีโอกล้องหลัง</li><li>- บันทึกวีดีโอระดับ FULL HD (1080p), 30/60 เฟรมต่อวินาที</li><li>- ความละเอียด 1920 x 1080 พิกเซล</li><li>บันทึกวิดีโอกล้องหน้า</li><li>- บันทึกวีดีโอระดับ FULL HD (1080p), 30 เฟรมต่อวินาที</li></ul><p><strong>&nbsp;เซ็นเซอร์ (Sensor)</strong></p><ul><li>ระบบตรวจสอบลายนิ้วมือ (Fingerprint)</li><li>ระบบหมุนภาพอัตโนมัติ (Accelerometer)</li></ul><p><strong>&nbsp;เชื่อมต่อ</strong></p><ul><li>การหาตำแหน่ง: Assisted GPS</li><li>WiFi 802.11 b/g/n/ac</li><li>- จุดกระจายสัญญาณอินเตอร์เน็ตแบบพกพา (Portable Wi-Fi Hotspot)</li><li>- เชื่อมต่อไร้สายระหว่างอุปกรณ์โดยตรง (Wi-Fi Direct)</li><li>- Dual band (2.4GHz / 5GHz)</li></ul><p><strong>มัลติมีเดีย</strong></p><ul><li>ระบบเสียง</li><li>- ลำโพงเสียงสเตอริโอ (Stereo speakers)</li></ul><p><strong>แบตเตอรี่ - ระบบชาร์จ</strong></p><ul><li>แบตเตอรี่ 6,500 mAh (Standard Battery)</li><li>- รองรับชาร์จไว 44W (Fast Charging)</li></ul>', '[{\"name\":\"Black\",\"hex\":\"#000000\"},{\"name\":\"Red\",\"hex\":\"#ff0000\"},{\"name\":\"Purple\",\"hex\":\"#80007b\"}]', 23, 2, '2025-10-07 09:18:36', '2025-10-10 01:15:28'),
(13, 'Honor X7c', '{\"screen\":\"6.77นิ้ว  จอ TFT-LCD 24-bit 720 x 1610 พิกเซล\",\"camera\":\"108 MP + 2MP (Depth)  กล้องหน้า 8MP\",\"cpu\":\"RAM 8 GB  ROM 256 GB\",\"memory\":\"Qualcomm Snapdragon 685 Octa Core  ความเร็ว 2.8 GHz\",\"battery\":\"6,000 mAh  ชาร์จไว 35W\",\"os\":\"MagicOS  MagicOS 8 based on Android 14 \",\"dimensions\":\"166.9 × 76.8 × 8.1 มม.\",\"weight\":\"194 กรัม\"}', '2025-10-08', 5499, '/storage/Phones/t5FnO8IodrhscnlNIfIVJGR256zNd0OfTRh5afkR.jpg', '<p><strong>ข้อมูลมือถือ&nbsp;&nbsp;Honor&nbsp;X7c</strong></p><ul><li>เปิดตัวครั้งแรก 9 ตุลาคม 2025 (สยามโฟนฯ)</li><li>สถานะ มีวางจำหน่ายในประเทศไทย</li><li>วางจำหน่าย ไตรมาสที่ 4 ปี 2025 (ตุลาคม 68)</li><li>- ราคาเปิดตัว 5,499 บาท (ตุลาคม 68)</li></ul><p><strong>จอแสดงผล (Display)</strong></p><ul><li>&nbsp;สมาร์ทโฟน&nbsp;(โทรศัพท์มือถือพร้อมระบบปฏิบัติการ)</li><li>จอแสดงผล TFT-LCD 24-bit (16 ล้านสี)</li><li>- จอแสดงผลมีรูสำหรับกล้องหน้า (Punch-Hole Display)</li><li>- กว้าง 6.77 นิ้ว (แนวทะแยง)</li><li>- ความละเอียด 720 x 1610 พิกเซล</li><li>(261 ppi)</li><li>- อัตราการสัมผัสหน้าจอ 120 เฮิรตซ์ (Refresh Rate 120Hz)</li><li>จอแสดงผลรอง (ไม่ระบุ) 1-bit (2 สีขาว/ดำ)</li><li>สมาร์ทโฟน Samsung</li></ul><p><strong>วัสดุตัวเครื่อง (Body)</strong></p><ul><li>หน้าจอกระจก</li><li>กรอบพลาสติก</li><li>คุณสมบัติทนน้ำและระบบป้องกัน (Waterproof &amp; Resistance to dust)</li><li>- ทนน้ำได้ชั่วคราว</li><li>มาตรฐาน IP64</li><li>มีสีให้เลือก (Colors) : White, Green</li></ul><p><strong>&nbsp;เครือข่าย (Network)</strong></p><ul><li>ใช้งาน Nano-SIM</li><li>รองรับ 2 ซิมการ์ด</li><li>เทคโนโลยีรับ/ส่งข้อมูล 3G , 4G</li><li>แสดงเพิ่มเติม</li></ul><p><strong>ระบบปฏิบัติการ (OS, CPU, GPU)</strong></p><ul><li>MagicOS 8 based on Android 14</li><li>CPU : Qualcomm : Snapdragon 685 Octa Core</li><li>ความเร็ว : 2.8 GHz</li><li>GPU : Adreno 610</li><li>RAM 8GB, ROM 256GB , microSD สูงสุด 1 TB</li><li>สมาร์ทโฟนที่ดีที่สุด</li></ul><p><strong>&nbsp;กล้องหลัง (Rear Camera)</strong></p><ul><li>กล้องดิจิตอล 108 + 2MP (Depth) ล้านพิกเซล (Dual Camera)</li><li>- รูรับแสงขนาด ƒ/1.8</li><li>- ไฟแฟลช LED</li><li>- ขนาดภาพสูงสุด 8,000 x 6,000 พิกเซล (Image Size)</li><li>แสดงเพิ่มเติม</li></ul><p><strong>กล้องหน้า (Front Camera)</strong></p><ul><li>ความละเอียด 8MP</li><li>- รูรับแสงขนาด ƒ/2.0</li></ul><p><strong>&nbsp;บันทึกวิดีโอ (Video Recording)</strong></p><ul><li>บันทึกวิดีโอกล้องหลัง</li><li>- บันทึกวีดีโอระดับ FULL HD (1080p), 30/60 เฟรมต่อวินาที</li><li>- ความละเอียด 1920 x 1080 พิกเซล</li><li>บันทึกวิดีโอกล้องหน้า</li><li>- บันทึกวีดีโอระดับ FULL HD (1080p), 30 เฟรมต่อวินาที</li></ul><p><strong>&nbsp;เซ็นเซอร์ (Sensor)</strong></p><ul><li>ระบบตรวจสอบลายนิ้วมือ (Fingerprint)</li><li>ระบบหมุนภาพอัตโนมัติ (Accelerometer)<img src=\"https://ads.siamphone.com/sp_ads/adlog.php?bannerid=1876&amp;clientid=844&amp;zoneid=82&amp;source=&amp;block=0&amp;capping=0&amp;cb=d99977cb66d079305cb8e4cbe3022dee\"></li></ul><p>&nbsp;<strong>เชื่อมต่อ</strong></p><ul><li>การหาตำแหน่ง: Assisted GPS</li><li>WiFi 802.11 a/b/g/n/ac</li><li>- จุดกระจายสัญญาณอินเตอร์เน็ตแบบพกพา (Portable Wi-Fi Hotspot)</li><li>- เชื่อมต่อไร้สายระหว่างอุปกรณ์โดยตรง (Wi-Fi Direct)</li><li>- Dual band (2.4GHz / 5GHz)</li></ul><p><strong>มัลติมีเดีย</strong></p><ul><li>ระบบเสียง</li><li>- ช่องเสียบชุดหูฟัง 3.5 มิลลิเมตร</li><li>- ลำโพงเสียงสเตอริโอ (Stereo speakers)</li></ul><p><strong>แบตเตอรี่ - ระบบชาร์จ</strong></p><ul><li>แบตเตอรี่ 6,000 mAh (Standard Battery)</li><li>- รองรับชาร์จไว 35W (Fast Charging)</li></ul>', '[{\"name\":\"White\",\"hex\":\"#ffffff\"},{\"name\":\"Green\",\"hex\":\"#168500\"}]', 1, 5, '2025-10-09 19:49:29', '2025-10-09 20:03:10'),
(14, 'Samsung Galaxy A07', '{\"screen\":\"6.7นิ้ว จอ PLS LCD 24-bit  720 x 1600 พิกเซล\",\"camera\":\"50 MP + 2MP (Depth) กล้องหน้า 8MP\",\"cpu\":\"Mediatek Helio G99 Octa Core  ความเร็ว 2.2 GHz\",\"memory\":\"RAM 4 GB  ROM 64/128 GB\",\"battery\":\"5,000 mAh  ชาร์จไว 25W\",\"os\":\"One UI 7 based on Android 15 \",\"dimensions\":\"167.4 × 77.4 × 7.6 มม.\",\"weight\":\"184 กรัม\"}', '2025-10-09', 2999, '/storage/Phones/LGuQyVwUOH4hOO3JtIB5WbbdMpWmKKaMpuultfkd.jpg', '<p><strong>ข้อมูลมือถือ&nbsp;&nbsp;Samsung Galaxy A07</strong></p><ul><li>เปิดตัวครั้งแรก 9 ตุลาคม 2025 (สยามโฟนฯ)</li><li>สถานะ มีวางจำหน่ายในประเทศไทย</li><li>วางจำหน่าย ไตรมาสที่ 4 ปี 2025 (ตุลาคม 68)</li><li>- ราคาเปิดตัว 2,999 บาท (ตุลาคม 68)</li><li>รุ่น ROM 64GB ราคา 2,999 บาท , ROM 128GB ราคา 3,999 บาท</li></ul><p><strong>จอแสดงผล (Display)</strong></p><ul><li>สมาร์ทโฟน (โทรศัพท์มือถือพร้อมระบบปฏิบัติการ)</li><li>จอแสดงผล PLS LCD 24-bit (16 ล้านสี)</li><li>- หน้าจอทรงหยดน้ำ รูปตัว U (Infinity U)</li><li>- หน้าจอหยดน้ำ (Waterdrop Display)</li><li>- กว้าง 6.7 นิ้ว (แนวทะแยง)</li><li>- ความละเอียด 720 x 1600 พิกเซล</li><li>(262 ppi)</li><li>- อัตราการสัมผัสหน้าจอ 90 เฮิรตซ์ (Refresh Rate 90Hz)</li><li>จอแสดงผลรอง (ไม่ระบุ) 1-bit (2 สีขาว/ดำ)</li><li>สมาร์ทโฟนรุ่นใหม่</li></ul><p><strong>วัสดุตัวเครื่อง (Body)</strong></p><ul><li>หน้าจอกระจก</li><li>กรอบพลาสติก</li><li>คุณสมบัติทนน้ำและระบบป้องกัน (Waterproof &amp; Resistance to dust)</li><li>- ทนน้ำได้ชั่วคราว</li><li>มาตรฐาน IP54</li><li>มีสีให้เลือก (Colors) : Black, Purple</li></ul><p><strong>&nbsp;เครือข่าย (Network)</strong></p><ul><li>ใช้งาน Nano-SIM</li><li>รองรับ 2 ซิมการ์ด</li><li>เทคโนโลยีรับ/ส่งข้อมูล 3G , 4G</li><li>แสดงเพิ่มเติม</li></ul><p><strong>ระบบปฏิบัติการ (OS, CPU, GPU)</strong></p><ul><li>One UI 7 based on Android 15</li><li>CPU : Mediatek : Helio G99 Octa Core</li><li>ความเร็ว : 2.2 GHz</li><li>GPU : Mali-G57 MC2</li><li>RAM 4GB, ROM 64/128GB , microSD สูงสุด 2 TB</li><li>สมาร์ทโฟนที่ดีที่สุด</li></ul><p><strong>&nbsp;กล้องหลัง (Rear Camera)</strong></p><ul><li>กล้องดิจิตอล 50 + 2MP (Depth) ล้านพิกเซล (Dual Camera)</li><li>- รูรับแสงขนาด ƒ/1.8</li><li>- ไฟแฟลช LED</li><li>- ขนาดภาพสูงสุด 8,000 x 6,000 พิกเซล (Image Size)</li><li>แสดงเพิ่มเติม</li></ul><p><strong>กล้องหน้า (Front Camera)</strong></p><ul><li>ความละเอียด 8MP</li><li>- รูรับแสงขนาด ƒ/2.0</li></ul><p><strong>&nbsp;บันทึกวิดีโอ (Video Recording)</strong></p><ul><li>บันทึกวิดีโอกล้องหลัง</li><li>- บันทึกวีดีโอระดับ FULL HD (1080p), 30/60 เฟรมต่อวินาที</li><li>- ความละเอียด 1920 x 1080 พิกเซล</li><li>บันทึกวิดีโอกล้องหน้า</li><li>- บันทึกวีดีโอระดับ FULL HD (1080p), 30 เฟรมต่อวินาที</li></ul><p><strong>&nbsp;เซ็นเซอร์ (Sensor)</strong></p><ul><li>ระบบตรวจสอบลายนิ้วมือ (Fingerprint)</li><li>ระบบหมุนภาพอัตโนมัติ (Accelerometer)<img src=\"https://ads.siamphone.com/sp_ads/adlog.php?bannerid=1876&amp;clientid=844&amp;zoneid=82&amp;source=&amp;block=0&amp;capping=0&amp;cb=aef985e6acb4a8c6237175b1e9fc26b0\"></li></ul><p><strong>&nbsp;เชื่อมต่อ</strong></p><ul><li>การหาตำแหน่ง: Assisted GPS</li><li>WiFi 802.11 a/b/g/n/ac</li><li>- จุดกระจายสัญญาณอินเตอร์เน็ตแบบพกพา (Portable Wi-Fi Hotspot)</li><li>- เชื่อมต่อไร้สายระหว่างอุปกรณ์โดยตรง (Wi-Fi Direct)</li><li>- Dual band (2.4GHz / 5GHz)</li></ul><p><strong>มัลติมีเดีย</strong></p><ul><li>ระบบเสียง</li><li>- ช่องเสียบชุดหูฟัง 3.5 มิลลิเมตร</li><li>- ลำโพงเสียงสเตอริโอ (Stereo speakers)</li></ul><p><strong>แบตเตอรี่ - ระบบชาร์จ</strong></p><ul><li>แบตเตอรี่ 5,000 mAh (Standard Battery)</li><li>- รองรับชาร์จไว 25W (Fast Charging)</li></ul>', '[{\"name\":\"Black\",\"hex\":\"#000000\"},{\"name\":\"Purple\",\"hex\":\"#850068\"}]', 44, 6, '2025-10-09 19:55:33', '2025-10-10 01:38:18'),
(15, 'Honor X6c', '{\"screen\":\"6.61นิ้ว  จอ TFT-LCD 24-bit  720 x 1604 พิกเซล\",\"camera\":\"50 MP + QVGA (Depth)  กล้องหน้า 5MP\",\"cpu\":\"Mediatek Helio G81 Ultra Octa Core  ความเร็ว 2.0 GHz\",\"memory\":\"RAM 6 GB  ROM 128/256 GB\",\"battery\":\"5,300 mAh  ชาร์จไว 35W\",\"os\":\"MagicOS 9 based on Android 15 \",\"dimensions\":\"164 × 75.6 × 8.4 มม.\",\"weight\":\"199 กรัม\"}', '2025-10-08', 3999, '/storage/Phones/DKvIFufIwKNP8gFChGpjrEDmWdnq11TFjwTNCRju.jpg', '<p><strong>ข้อมูลมือถือ&nbsp;&nbsp;Honor&nbsp;X6c</strong></p><ul><li>เปิดตัวครั้งแรก 8 ตุลาคม 2025 (สยามโฟนฯ)</li><li>สถานะ มีวางจำหน่ายในประเทศไทย</li><li>วางจำหน่าย ไตรมาสที่ 4 ปี 2025 (ตุลาคม 68)</li><li>- ราคาเปิดตัว 3,999 บาท (ตุลาคม 68)</li><li>รุ่น ROM 128GB ราคา 3,999 บาท , ROM 256GB ราคา 4,799 บาท</li></ul><p><strong>จอแสดงผล (Display)</strong></p><ul><li>สมาร์ทโฟน (โทรศัพท์มือถือพร้อมระบบปฏิบัติการ)</li><li>จอแสดงผล TFT-LCD 24-bit (16 ล้านสี)</li><li>- จอแสดงผลมีรูสำหรับกล้องหน้า (Punch-Hole Display)</li><li>- กว้าง 6.61 นิ้ว (แนวทะแยง)</li><li>- ความละเอียด 720 x 1604 พิกเซล</li><li>(266 ppi)</li><li>- อัตราการสัมผัสหน้าจอ 120 เฮิรตซ์ (Refresh Rate 120Hz)</li><li>จอแสดงผลรอง (ไม่ระบุ) 1-bit (2 สีขาว/ดำ)</li><li>สมาร์ทโฟน Samsung</li></ul><p><strong>วัสดุตัวเครื่อง (Body)</strong></p><ul><li>หน้าจอกระจก</li><li>กรอบพลาสติก</li><li>คุณสมบัติทนน้ำและระบบป้องกัน (Waterproof &amp; Resistance to dust)</li><li>- ทนน้ำได้ชั่วคราว</li><li>มาตรฐาน IP64</li><li>มีสีให้เลือก (Colors) : Black, White, Green</li></ul><p><strong>&nbsp;เครือข่าย (Network)</strong></p><ul><li>ใช้งาน Nano-SIM</li><li>รองรับ 2 ซิมการ์ด</li><li>เทคโนโลยีรับ/ส่งข้อมูล 3G , 4G</li></ul><p><strong>ระบบปฏิบัติการ (OS, CPU, GPU)</strong></p><ul><li>MagicOS 9 based on Android 15</li><li>CPU : Mediatek : Helio G81 Ultra Octa Core</li><li>ความเร็ว : 2.0 GHz</li><li>GPU : Mali-G52 MC2</li><li>RAM 6GB, ROM 128/256GB , microSD สูงสุด 1 TB</li><li>สมาร์ทโฟนที่ดีที่สุด</li></ul><p><strong>&nbsp;กล้องหลัง (Rear Camera)</strong></p><ul><li>กล้องดิจิตอล 50 + QVGA (Depth) ล้านพิกเซล (Dual Camera)</li><li>- รูรับแสงขนาด ƒ/1.8</li><li>- ไฟแฟลช LED</li><li>- ขนาดภาพสูงสุด 8,000 x 6,000 พิกเซล (Image Size)</li></ul><p><strong>กล้องหน้า (Front Camera)</strong></p><ul><li>ความละเอียด 5MP</li><li>- รูรับแสงขนาด ƒ/2.2</li></ul><p><strong>&nbsp;บันทึกวิดีโอ (Video Recording)</strong></p><ul><li>บันทึกวิดีโอกล้องหลัง</li><li>- บันทึกวีดีโอระดับ FULL HD (1080p), 30/60 เฟรมต่อวินาที</li><li>- ความละเอียด 1920 x 1080 พิกเซล</li><li>บันทึกวิดีโอกล้องหน้า</li><li>- บันทึกวีดีโอระดับ FULL HD (1080p), 30 เฟรมต่อวินาที</li></ul><p><strong>&nbsp;เซ็นเซอร์ (Sensor)</strong></p><ul><li>ระบบสแกนลายนิ้วมือใต้หน้าจอ (Fingerprint Under Display)</li><li>ระบบหมุนภาพอัตโนมัติ (Accelerometer)</li></ul><p><strong>&nbsp;เชื่อมต่อ</strong></p><ul><li>การหาตำแหน่ง: Assisted GPS</li><li>WiFi 802.11 a/b/g/n/ac</li><li>- จุดกระจายสัญญาณอินเตอร์เน็ตแบบพกพา (Portable Wi-Fi Hotspot)</li><li>- เชื่อมต่อไร้สายระหว่างอุปกรณ์โดยตรง (Wi-Fi Direct)</li><li>- Dual band (2.4GHz / 5GHz)</li></ul><p><strong>มัลติมีเดีย</strong></p><ul><li>ระบบเสียง</li><li>- ช่องเสียบชุดหูฟัง 3.5 มิลลิเมตร</li><li>- ลำโพงเสียงสเตอริโอ (Stereo speakers)</li></ul><p><strong>แบตเตอรี่ - ระบบชาร์จ</strong></p><ul><li>แบตเตอรี่ 5,300 mAh (Standard Battery)</li><li>- รองรับชาร์จไว 35W (Fast Charging)</li></ul>', '[{\"name\":\"Black\",\"hex\":\"#000000\"},{\"name\":\"White\",\"hex\":\"#ffffff\"},{\"name\":\"Green\",\"hex\":\"#007539\"}]', 0, 5, '2025-10-09 20:01:23', '2025-10-09 20:02:51'),
(16, 'Infinix Hot 60i', '{\"screen\":\"6.7นิ้ว  จอ IPS-LCD 24-bit  720 x 1600 พิกเซล\",\"camera\":\"50 MP + Auxiliary lens  กล้องหน้า 8MP\",\"cpu\":\"Mediatek Helio G81 Ultimate Octa Core  ความเร็ว 2.0 GHz\",\"memory\":\"RAM 8 GB  ROM 256 GB\",\"battery\":\"5,160 mAh  ชาร์จไว 45W\",\"os\":\"XOS 15.1 based on Android 15 \",\"dimensions\":\"166 × 76.6 × 7.7 มม.\",\"weight\":\"188 กรัม\"}', '2025-10-08', 3999, '/storage/Phones/bcTUTmF9ZoPgf5alWq3wCIN8zHLrzFablpTJ1TUz.jpg', '<p><strong>ข้อมูลมือถือ&nbsp;&nbsp;Infinix&nbsp;Hot 60i</strong></p><ul><li>เปิดตัวครั้งแรก 8 ตุลาคม 2025 (สยามโฟนฯ)</li><li>สถานะ มีวางจำหน่ายในประเทศไทย</li><li>วางจำหน่าย ไตรมาสที่ 4 ปี 2025 (ตุลาคม 68)</li><li>- ราคาเปิดตัว 3,999 บาท (ตุลาคม 68)<img src=\"https://ads.siamphone.com/sp_ads/adlog.php?bannerid=1876&amp;clientid=844&amp;zoneid=82&amp;source=&amp;block=0&amp;capping=0&amp;cb=7794055b9086e17c15bc5d7edb1867e9\"></li></ul><p><strong>จอแสดงผล (Display)</strong></p><ul><li>สมาร์ทโฟน (โทรศัพท์มือถือพร้อมระบบปฏิบัติการ)</li><li>จอแสดงผล IPS-LCD 24-bit (16 ล้านสี)</li><li>- จอแสดงผลมีรูสำหรับกล้องหน้า (Punch-Hole Display)</li><li>- กว้าง 6.7 นิ้ว (แนวทะแยง)</li><li>- ความละเอียด 720 x 1600 พิกเซล</li><li>(262 ppi)</li><li>- อัตราการสัมผัสหน้าจอ 120 เฮิรตซ์ (Refresh Rate 120Hz)</li><li>ค่าความสว่างหน้าจอ (Display Brightness)</li><li>- ค่าความสว่างสูงสุดเฉพาะจุด (High Brightness Mode) 700 nits</li><li>จอแสดงผลรอง (ไม่ระบุ) 1-bit (2 สีขาว/ดำ)</li><li>สมาร์ทโฟน Xiaomi</li></ul><p><strong>วัสดุตัวเครื่อง (Body)</strong></p><ul><li>หน้าจอกระจก</li><li>กรอบพลาสติก</li><li>คุณสมบัติทนน้ำและระบบป้องกัน (Waterproof &amp; Resistance to dust)</li><li>- ทนน้ำได้ชั่วคราว</li><li>มาตรฐาน IP64</li><li>มีสีให้เลือก (Colors) : Black, Blue, Silver</li></ul><p><strong>&nbsp;เครือข่าย (Network)</strong></p><ul><li>ใช้งาน Nano-SIM</li><li>รองรับ 2 ซิมการ์ด</li><li>เทคโนโลยีรับ/ส่งข้อมูล 3G , 4G</li><li>แสดงเพิ่มเติม</li></ul><p><strong>ระบบปฏิบัติการ (OS, CPU, GPU)</strong></p><ul><li>XOS 15.1 based on Android 15</li><li>CPU : Mediatek : Helio G81 Ultimate Octa Core</li><li>ความเร็ว : 2.0 GHz</li><li>GPU : Mali-G52 MC2</li><li>RAM 8GB, ROM 256GB , microSD สูงสุด 1 TB</li><li>สมาร์ทโฟนที่ดีที่สุด</li></ul><p><strong>&nbsp;กล้องหลัง (Rear Camera)</strong></p><ul><li>กล้องดิจิตอล 50 + Auxiliary lens ล้านพิกเซล (Dual Camera)</li><li>- รูรับแสงขนาด ƒ/1.8</li><li>- ไฟแฟลช Dual LED</li><li>- ขนาดภาพสูงสุด 8,000 x 6,000 พิกเซล (Image Size)</li></ul><p><strong>กล้องหน้า (Front Camera)</strong></p><ul><li>ความละเอียด 8MP</li><li>- รูรับแสงขนาด ƒ/2.0</li></ul><p><strong>&nbsp;บันทึกวิดีโอ (Video Recording)</strong></p><ul><li>บันทึกวิดีโอกล้องหลัง</li><li>- บันทึกวีดีโอระดับ QHD (2K), 30 เฟรมต่อวินาที</li><li>- ความละเอียด 2560 x 1440 พิกเซล</li><li>บันทึกวิดีโอกล้องหน้า</li><li>- บันทึกวีดีโอระดับ FULL HD (1080p), 30 เฟรมต่อวินาที</li></ul><p><strong>&nbsp;เซ็นเซอร์ (Sensor)</strong></p><ul><li>ระบบสแกนลายนิ้วมือใต้หน้าจอ (Fingerprint Under Display)</li><li>ระบบหมุนภาพอัตโนมัติ (Accelerometer)</li></ul><p><strong>&nbsp;เชื่อมต่อ</strong></p><ul><li>การหาตำแหน่ง: Assisted GPS</li><li>WiFi 802.11 a/b/g/n/ac</li><li>- จุดกระจายสัญญาณอินเตอร์เน็ตแบบพกพา (Portable Wi-Fi Hotspot)</li><li>- เชื่อมต่อไร้สายระหว่างอุปกรณ์โดยตรง (Wi-Fi Direct)</li><li>- Dual band (2.4GHz / 5GHz)</li></ul><p><strong>มัลติมีเดีย</strong></p><ul><li>ระบบเสียง</li><li>- ช่องเสียบชุดหูฟัง 3.5 มิลลิเมตร</li><li>- ลำโพงเสียงสเตอริโอ (Stereo speakers)</li></ul><p><strong>แบตเตอรี่ - ระบบชาร์จ</strong></p><ul><li>แบตเตอรี่ 5,160 mAh (Standard Battery)</li><li>- รองรับชาร์จไว 45W (Fast Charging)</li></ul>', '[{\"name\":\"Black\",\"hex\":\"#000000\"},{\"name\":\"Blue\",\"hex\":\"#0040ff\"},{\"name\":\"Silver\",\"hex\":\"#c9c9c9\"}]', 0, 7, '2025-10-09 20:13:13', '2025-10-09 20:14:49'),
(17, 'OPPO A5i', '{\"screen\":\"6.67นิ้ว  จอ IPS-LCD 24-bit  720 x 1604 พิกเซล\",\"camera\":\"8 MP + Auxiliary lens  กล้องหน้า 5MP\",\"cpu\":\"Qualcomm Snapdragon 6s 4G Gen1 Octa Core  ความเร็ว 2.8 GHz\",\"memory\":\"RAM 4 GB  ROM 64 GB\",\"battery\":\"5,100 mAh  ชาร์จไว 45W\",\"os\":\"Color OS 14\",\"dimensions\":\"165.7 × 76.08 × 7.68 มม.\",\"weight\":\"186 กรัม\"}', '2025-10-08', 2999, '/storage/Phones/x0VprrXNX9skabOS2Tg1vPBudLvvroo2jf7WUhgC.jpg', '<p><strong>ข้อมูลมือถือ&nbsp;&nbsp;OPPO A5i</strong></p><ul><li>เปิดตัวครั้งแรก 8 ตุลาคม 2025 (สยามโฟนฯ)</li><li>สถานะ มีวางจำหน่ายในประเทศไทย</li><li>วางจำหน่าย ไตรมาสที่ 4 ปี 2025 (ตุลาคม 68)</li><li>- ราคาเปิดตัว 2,999 บาท (ตุลาคม 68)</li></ul><p><strong>จอแสดงผล (Display)</strong></p><ul><li>สมาร์ทโฟน (โทรศัพท์มือถือพร้อมระบบปฏิบัติการ)</li><li>จอแสดงผล IPS-LCD 24-bit (16 ล้านสี)</li><li>- จอแสดงผลมีรูสำหรับกล้องหน้า (Punch-Hole Display)</li><li>- กว้าง 6.67 นิ้ว (แนวทะแยง)</li><li>- ความละเอียด 720 x 1604 พิกเซล</li><li>(264 ppi)</li><li>- อัตราการสัมผัสหน้าจอ 90 เฮิรตซ์ (Refresh Rate 90Hz)</li><li>- ระบบสัมผัส : 180Hz touch-sensing</li><li>ค่าความสว่างหน้าจอ (Display Brightness)</li><li>- ค่าความสว่างทั่วไป (Typical brightness) 1000 nits</li><li>จอแสดงผลรอง (ไม่ระบุ) 1-bit (2 สีขาว/ดำ)</li><li>ราคา OPPOสมาร์ทโฟน Apple</li></ul><p><strong>วัสดุตัวเครื่อง (Body)</strong></p><ul><li>หน้าจอกระจก</li><li>กรอบพลาสติก</li><li>คุณสมบัติทนน้ำและระบบป้องกัน (Waterproof &amp; Resistance to dust)</li><li>- ทนน้ำได้ชั่วคราว</li><li>มาตรฐาน IP64</li><li>มีสีให้เลือก (Colors) : Red, Purple</li></ul><p><strong>&nbsp;เครือข่าย (Network)</strong></p><ul><li>ใช้งาน Nano-SIM</li><li>รองรับ 2 ซิมการ์ด</li><li>เทคโนโลยีรับ/ส่งข้อมูล 3G , 4G</li><li>แสดงเพิ่มเติม</li></ul><p><strong>ระบบปฏิบัติการ (OS, CPU, GPU)</strong></p><ul><li>Color OS 14</li><li>CPU : Qualcomm : Snapdragon 6s 4G Gen1 Octa Core</li><li>ความเร็ว : 2.8 GHz</li><li>GPU : Adreno 610</li><li>RAM 4GB, ROM 64GB , microSD สูงสุด 1 TB</li></ul><p><strong>&nbsp;กล้องหลัง (Rear Camera)</strong></p><ul><li>กล้องดิจิตอล 8 + Auxiliary lens ล้านพิกเซล (Dual Camera)</li><li>- รูรับแสงขนาด ƒ/1.8</li><li>- ไฟแฟลช LED</li><li>- ขนาดภาพสูงสุด 4,000 x 3,000 พิกเซล (Image Size)</li></ul><p><strong>กล้องหน้า (Front Camera)</strong></p><ul><li>ความละเอียด 5MP</li><li>- รูรับแสงขนาด ƒ/2.0</li></ul><p>&nbsp;บันทึกวิดีโอ (Video Recording)</p><ul><li>บันทึกวิดีโอกล้องหลัง</li><li>- บันทึกวีดีโอระดับ FULL HD (1080p), 30/60 เฟรมต่อวินาที</li><li>- ความละเอียด 1920 x 1080 พิกเซล</li><li>บันทึกวิดีโอกล้องหน้า</li><li>- บันทึกวีดีโอระดับ FULL HD (1080p), 30 เฟรมต่อวินาที</li></ul><p><strong>&nbsp;เซ็นเซอร์ (Sensor)</strong></p><ul><li>ระบบสแกนลายนิ้วมือใต้หน้าจอ (Fingerprint Under Display)</li><li>สแกนใบหน้า (Face ID)</li><li>ระบบหมุนภาพอัตโนมัติ (Accelerometer)<img src=\"https://ads.siamphone.com/sp_ads/adlog.php?bannerid=1876&amp;clientid=844&amp;zoneid=82&amp;source=&amp;block=0&amp;capping=0&amp;cb=2d44752eb538c584c4dbb13db2f2213a\"></li></ul><p><strong>&nbsp;เชื่อมต่อ</strong></p><ul><li>การหาตำแหน่ง: Assisted GPS</li><li>WiFi 802.11b/g/n/a</li><li>- จุดกระจายสัญญาณอินเตอร์เน็ตแบบพกพา (Portable Wi-Fi Hotspot)</li><li>- เชื่อมต่อไร้สายระหว่างอุปกรณ์โดยตรง (Wi-Fi Direct)</li><li>- Dual band (2.4GHz / 5GHz)</li></ul><p><strong>มัลติมีเดีย</strong></p><ul><li>ระบบเสียง</li><li>- ช่องเสียบชุดหูฟัง 3.5 มิลลิเมตร</li><li>- ลำโพงเสียงสเตอริโอ (Stereo speakers)</li></ul><p><strong>แบตเตอรี่ - ระบบชาร์จ</strong></p><ul><li>แบตเตอรี่ 5,100 mAh (Standard Battery)</li><li>- รองรับชาร์จไว 45W (Fast Charging)</li></ul>', '[{\"name\":\"Red\",\"hex\":\"#d60000\"},{\"name\":\"Purple\",\"hex\":\"#7a008a\"}]', 7, 10, '2025-10-09 20:20:43', '2025-10-10 01:27:55'),
(18, 'Xiaomi 15T Pro', '{\"screen\":\" 6.83นิ้ว  จอ AMOLED 12bit 68B colors  1280 x 2772 พิกเซล\",\"camera\":\"50 MP + 50MP (Periscope telephoto) + 12MP (Ultrawide)  กล้องหน้า 32MP\",\"cpu\":\"Mediatek Dimensity 9400+ Octa Core  ความเร็ว 3.73 GHz\",\"memory\":\"RAM 12 GB  ROM 512 GB  ROM 1 TB\",\"battery\":\"5,500 mAh  ชาร์จไว 90W\",\"os\":\"HyperOS 2 based on Android 15\",\"dimensions\":\"162.7 × 77.9 × 7.96 มม.\",\"weight\":\"210 กรัม\"}', '2025-09-25', 21990, '/storage/Phones/Ek7QvTDJJbVJMs0fmtSE1QeYv8S8QXgkNIiLFBcZ.jpg', '<p><strong>ข้อมูลมือถือ&nbsp;&nbsp;Xiaomi 15T Pro</strong></p><ul><li>เปิดตัวครั้งแรก 25 กันยายน 2025 (สยามโฟนฯ)</li><li>สถานะ มีวางจำหน่ายในประเทศไทย</li><li>วางจำหน่าย ไตรมาสที่ 4 ปี 2025 (ตุลาคม 68)</li><li>- ราคาเปิดตัว 21,990 บาท (ตุลาคม 68)</li><li>รุ่น ROM 512GB ราคา 21,990 บาท , 1TB ราคา 24,990 บาท</li></ul><p><strong>จอแสดงผล (Display)</strong></p><ul><li>สมาร์ทโฟน (โทรศัพท์มือถือพร้อมระบบปฏิบัติการ)</li><li>จอแสดงผล AMOLED 12bit 68B colors</li><li>- จอแสดงผล HDR 10+</li><li>- จอแสดงผลมีรูสำหรับกล้องหน้า (Punch-Hole Display)</li><li>- กว้าง 6.83 นิ้ว (แนวทะแยง)</li><li>- ความละเอียด 1280 x 2772 พิกเซล</li><li>(447 ppi)</li><li>- อัตราการสัมผัสหน้าจอ 144 เฮิรตซ์ (Refresh Rate 144Hz)</li><li>- ระบบสัมผัส : 480Hz touch-sensing</li><li>ค่าความสว่างหน้าจอ (Display Brightness)</li><li>- ค่าความสว่างสูงสุดของหน้าจอ (Peak Brightness) 3200 nits</li></ul><p><strong>วัสดุตัวเครื่อง (Body)</strong></p><ul><li>หน้าจอกระจก Corning Gorilla Glass 7i</li><li>กรอบอะลูมิเนียม</li><li>คุณสมบัติทนน้ำและระบบป้องกัน (Waterproof &amp; Resistance to dust)</li><li>- ทนน้ำได้ชั่วคราว</li><li>- ทนน้ำที่ความลึกไม่เกิน 3 เมตร</li><li>- ฝุ่นละออง (Resistance to dust)</li><li>มาตรฐาน IP68</li><li>มีสีให้เลือก (Colors) : Black, Gray, Gold</li><li>สมาร์ทโฟนที่ดีที่สุด</li></ul><p><strong>&nbsp;เครือข่าย (Network)</strong></p><ul><li>ใช้งาน Nano-SIM</li><li>ใช้งาน eSIM</li><li>รองรับ 2 ซิมการ์ด</li><li>เทคโนโลยีรับ/ส่งข้อมูล 3G , 4G, 5G</li></ul><p><strong>ระบบปฏิบัติการ (OS, CPU, GPU)</strong></p><ul><li>HyperOS 2 based on Android 15</li><li>CPU : Mediatek : Dimensity 9400+ Octa Core</li><li>ความเร็ว : 3.73 GHz</li><li>GPU : Immortalis-G925 MC12</li><li>RAM 12GB, ROM 512GB , 1TB : UFS 4.1</li></ul><p><strong>&nbsp;กล้องหลัง (Rear Camera)</strong></p><ul><li>กล้องดิจิตอล 50MP + 50MP (Periscope telephoto) + 12MP (Ultrawide) (Triple Camera)</li><li>- เลนส์ Leica</li><li>- รูรับแสงขนาด ƒ/1.62</li><li>- ไฟแฟลช LED</li><li>- ซูมดิจิตอล 100 เท่า (100x Digital Zoom)</li><li>- ซูมออฟติคอล 5 เท่า (5x Optical Zoom)</li><li>- ขนาดภาพสูงสุด 8,192 x 6,144 พิกเซล (Image Size)</li></ul><p><strong>กล้องหน้า (Front Camera)</strong></p><ul><li>ความละเอียด 32MP</li><li>- รูรับแสงขนาด ƒ/2.2</li></ul><p><strong>&nbsp;บันทึกวิดีโอ (Video Recording)</strong></p><ul><li>บันทึกวิดีโอกล้องหลัง</li><li>- บันทึกวีดีโอระดับ UHD-2(8K), 30 เฟรมต่อวินาที</li><li>- ความละเอียด 7680 x 4320 พิกเซล</li><li>บันทึกวิดีโอกล้องหน้า</li><li>- บันทึกวีดีโอระดับ UHD (4K), 30 เฟรมต่อวินาที</li></ul><p><strong>&nbsp;เซ็นเซอร์ (Sensor)</strong></p><ul><li>ระบบสแกนลายนิ้วมือใต้หน้าจอ (Fingerprint Under Display)</li><li>สแกนใบหน้า (Face ID)</li><li>ระบบหมุนภาพอัตโนมัติ (Accelerometer)</li></ul><p><strong>&nbsp;เชื่อมต่อ</strong></p><ul><li>การหาตำแหน่ง: Assisted GPS</li><li>WiFi 802.11 a/b/g/n/ac/6e/7</li><li>- จุดกระจายสัญญาณอินเตอร์เน็ตแบบพกพา (Portable Wi-Fi Hotspot)</li><li>- เชื่อมต่อไร้สายระหว่างอุปกรณ์โดยตรง (Wi-Fi Direct)</li><li>- Dual band (2.4GHz / 5GHz)</li></ul><p><strong>มัลติมีเดีย</strong></p><ul><li>ระบบเสียง</li><li>- ลำโพงคู่ (Dual Speaker)</li><li>- ลำโพงเสียงสเตอริโอ (Stereo speakers)</li><li>- ระบบเสียง Dolby Atmos</li></ul><p><strong>แบตเตอรี่ - ระบบชาร์จ</strong></p><ul><li>แบตเตอรี่ 5,500 mAh (Standard Battery)</li><li>- รองรับชาร์จไว 90W (Fast Charging)</li><li>- รองรับชาร์จไร้สาย 50W (Wireless Charging)</li><li>- การแบ่งแบตเตอรี่แบบไร้สาย (Wireless PowerShare)</li></ul>', '[{\"name\":\"Black\",\"hex\":\"#000000\"},{\"name\":\"Gray\",\"hex\":\"#949494\"},{\"name\":\"Gold\",\"hex\":\"#c0b56d\"}]', 1, 9, '2025-10-09 20:27:45', '2025-10-09 23:19:02'),
(19, 'Apple iPhone 17 Pro Max', '{\"screen\":\" 6.9นิ้ว  จอ Super Retina XDR OLED 24-bit  1320 x 2868 พิกเซล\",\"camera\":\"48 MP + 48MP (Periscope telephoto) + 48MP (Ultrawide) + TOF 3D LiDAR scanner (Depth)  กล้องหน้า 18MP\",\"cpu\":\"Apple A19 Pro Hexa Core (2+4)\",\"memory\":\"RAM 12 GB  ROM 256/512 GB  ROM 1/2 TB\",\"battery\":\"4,832 mAh\",\"os\":\"iOS 26\",\"dimensions\":\"163.4 × 78 × 8.75 มม.\",\"weight\":\"231 กรัม\"}', '2025-09-10', 48900, '/storage/Phones/kI6KhmZIND6C2GQtVjklZtqmsxFBy0upIEYU7qqL.jpg', '<p><strong>ข้อมูลมือถือ&nbsp;&nbsp;Apple iPhone 17 Pro Max</strong></p><ul><li>เปิดตัวครั้งแรก 10 กันยายน 2025 (สยามโฟนฯ)</li><li>สถานะ มีวางจำหน่ายในประเทศไทย</li><li>วางจำหน่าย ไตรมาสที่ 3 ปี 2025 (กันยายน 68)</li><li>- ราคาเปิดตัว 48,900 บาท (กันยายน 68)</li><li>รุ่น 256GB ราคา 48,900 บาท , 512GB ราคา 56,900 บาท , 1TB ราคา 64,900 บาท , 2TB ราคา 80,900 บาท</li></ul><p><strong>จอแสดงผล (Display)</strong></p><ul><li>สมาร์ทโฟน (โทรศัพท์มือถือพร้อมระบบปฏิบัติการ)</li><li>จอแสดงผล Super Retina XDR OLED 24-bit (16 ล้านสี)</li><li>- จอแสดงผล HDR</li><li>- หน้าจอแบบเจาะ Dymamic Island</li><li>- กว้าง 6.9 นิ้ว (แนวทะแยง)</li><li>- ความละเอียด 1320 x 2868 พิกเซล</li><li>(460 ppi)</li><li>- อัตราการสัมผัสหน้าจอ 120 เฮิรตซ์ (Refresh Rate 120Hz)</li><li>- Always on display</li><li>ค่าความสว่างหน้าจอ (Display Brightness)</li><li>- ค่าความสว่างทั่วไป (Typical brightness) 1000 nits</li><li>- ค่าความสว่างสูงสุดเฉพาะจุด (High Brightness Mode) 1600 nits</li><li>- ค่าความสว่างสูงสุดของหน้าจอ (Peak Brightness) 3000 nits</li></ul><p><strong>วัสดุตัวเครื่อง (Body)</strong></p><ul><li>หน้าจอกระจก Ceramic Shield 2</li><li>กรอบอะลูมิเนียม</li><li>ด้านหลังเครื่อง กระจก Ceramic Shield glass</li><li>คุณสมบัติทนน้ำและระบบป้องกัน (Waterproof &amp; Resistance to dust)</li><li>- ทนน้ำได้ชั่วคราว</li><li>- ทนน้ำที่ความลึกไม่เกิน 6 เมตร</li><li>- ฝุ่นละออง (Resistance to dust)</li><li>ป้องกันรอยนิ้วมือ (Anti-fingerprint display coating)</li><li>มาตรฐาน IP68</li><li>มีสีให้เลือก (Colors) : Blue, Orange, Silver</li></ul><p>&nbsp;<strong>เครือข่าย (Network)</strong></p><ul><li>ใช้งาน Nano-SIM</li><li>ใช้งาน eSIM</li><li>เทคโนโลยีรับ/ส่งข้อมูล 3G , 4G, 5G</li></ul><p><strong>ระบบปฏิบัติการ (OS, CPU, GPU)</strong></p><ul><li>iOS 26</li><li>CPU : Apple : A19 Pro Hexa Core (2+4)</li><li>GPU : Apple GPU (5-core graphics) ,</li><li>Apple Neural Engine (ANE) : 16-core</li><li>256/512 GB (ตัวเครื่อง) RAM 12GB, , 1/2TB</li><li>ผ่อนสมาร์ทโฟนซื้อ Apple</li></ul><p><strong>&nbsp;กล้องหลัง (Rear Camera)</strong></p><ul><li>กล้องดิจิตอล 48MP + 48MP (Periscope telephoto) + 48MP (Ultrawide) + TOF 3D LiDAR scanner (Depth) (Quad Camera)</li><li>- รูรับแสงขนาด ƒ/1.6</li><li>- ไฟแฟลช Dual-LED dual-tone flash</li><li>- ซูมดิจิตอล 40 เท่า (40x Digital Zoom)</li><li>- ซูมออฟติคอล 8 เท่า (8x Optical Zoom)</li></ul><p><strong>กล้องหน้า (Front Camera)</strong></p><ul><li>ความละเอียด 18MP</li><li>- กล้องหน้าตัวที่สอง SL 3D (Depth/biometrics sensor)</li><li>- รูรับแสงขนาด ƒ/2.0</li></ul><p><strong>&nbsp;บันทึกวิดีโอ (Video Recording)</strong></p><ul><li>บันทึกวิดีโอกล้องหลัง</li><li>- บันทึกวีดีโอระดับ UHD (4K), 24/25/30/60/100/120 เฟรมต่อวินาที</li><li>- ความละเอียด 3840 x 2160 พิกเซล</li><li>บันทึกวิดีโอกล้องหน้า</li><li>- บันทึกวีดีโอระดับ UHD (4K), 24/25/30/60 เฟรมต่อวินาที</li></ul><p><strong>&nbsp;เซ็นเซอร์ (Sensor)</strong></p><ul><li>สแกนเนอร์ LiDAR (LiDAR scanner)</li><li>ไจโรแบบช่วงไดนามิกสูง (High dynamic range gyro)</li><li>อุปกรณ์ตรวจจับการเคลื่อนไหวแบบแรง g สูง (High-g accelerometer)</li><li>เซ็นเซอร์ตรวจวัดแสงโดยรอบแบบคู่ (Dual ambient light sensors)</li><li>สแกนใบหน้า (Face ID)</li><li>ระบบหมุนภาพอัตโนมัติ (Accelerometer)</li></ul><p><strong>&nbsp;เชื่อมต่อ</strong></p><ul><li>การหาตำแหน่ง: Assisted GPS</li><li>iBeacon เทคโนโลยีระบุตำแหน่งในอาคาร</li><li>WiFi 802.11 a/b/g/n/ac/6/7</li><li>- จุดกระจายสัญญาณอินเตอร์เน็ตแบบพกพา (Portable Wi-Fi Hotspot)</li><li>- เชื่อมต่อไร้สายระหว่างอุปกรณ์โดยตรง (Wi-Fi Direct)</li><li>- Tri band (2.4GHz / 5 + 5GHz)</li></ul><p><strong>มัลติมีเดีย</strong></p><ul><li>ระบบเสียง</li><li>- ลำโพงเสียงสเตอริโอ (Stereo speakers)</li></ul><p><strong>แบตเตอรี่ - ระบบชาร์จ</strong></p><ul><li>แบตเตอรี่ 4,832 mAh (Standard Battery)</li><li>- รองรับชาร์จไร้สาย MagSafe 25W (Wireless Charging)</li><li>- Qi2 25W (Wireless Charging)</li><li>- การแบ่งแบตเตอรี่แบบไร้สาย (Wireless PowerShare)</li><li>การใช้งานแบตเตอรี่</li><li>- ชมวีดีโอนานต่อเนื่อง 37 ชั่วโมง (Video playback time)</li></ul>', '[{\"name\":\"Blue\",\"hex\":\"#000000\"},{\"name\":\"Orange\",\"hex\":\"#e49525\"},{\"name\":\"Silver\",\"hex\":\"#b8b8b8\"}]', 58, 15, '2025-10-09 20:38:04', '2025-10-10 01:30:32'),
(20, 'Apple iPhone 17 Pro', '{\"screen\":\"6.3นิ้ว  จอ Super Retina XDR OLED 24-bit  1206 x 2622 พิกเซล\",\"camera\":\"48 MP + 48MP (Periscope telephoto) + 48MP (Ultrawide) + TOF 3D LiDAR scanner (Depth)  กล้องหน้า 18MP\",\"cpu\":\"Apple A19 Pro Hexa Core (2+4)\",\"memory\":\"RAM 12 GB  ROM 256/512 GB  ROM 1 TB\",\"battery\":\"3,988 mAh\",\"os\":\"iOS 26\",\"dimensions\":\"150 × 71.9 × 8.75 มม.\",\"weight\":\"204 กรัม\"}', '2025-09-10', 43900, '/storage/Phones/v8xpEtNWeL7RP3BOUaRCIsmXQPqbTUH5aEHtPoKj.jpg', '<p><strong>ข้อมูลมือถือ Apple&nbsp;&nbsp;iPhone 17 Pro</strong></p><ul><li>เปิดตัวครั้งแรก 10 กันยายน 2025 (สยามโฟนฯ)</li><li>สถานะ มีวางจำหน่ายในประเทศไทย</li><li>วางจำหน่าย ไตรมาสที่ 3 ปี 2025 (กันยายน 68)</li><li>- ราคาเปิดตัว 43,900 บาท (กันยายน 68)</li><li>รุ่น 256GB ราคา 43,900 บาท , 512GB ราคา 51,900 บาท , 1TB ราคา 59,900 บาท</li></ul><p><strong>จอแสดงผล (Display)</strong></p><ul><li>สมาร์ทโฟน (โทรศัพท์มือถือพร้อมระบบปฏิบัติการ)</li><li>จอแสดงผล Super Retina XDR OLED 24-bit (16 ล้านสี)</li><li>- จอแสดงผล HDR</li><li>- หน้าจอแบบเจาะ Dymamic Island</li><li>- กว้าง 6.3 นิ้ว (แนวทะแยง)</li><li>- ความละเอียด 1206 x 2622 พิกเซล</li><li>(460 ppi)</li><li>- อัตราการสัมผัสหน้าจอ 120 เฮิรตซ์ (Refresh Rate 120Hz)</li><li>- Always on display</li><li>ค่าความสว่างหน้าจอ (Display Brightness)</li><li>- ค่าความสว่างทั่วไป (Typical brightness) 1000 nits</li><li>- ค่าความสว่างสูงสุดเฉพาะจุด (High Brightness Mode) 1600 nits</li><li>- ค่าความสว่างสูงสุดของหน้าจอ (Peak Brightness) 3000 nits</li></ul><p><strong>วัสดุตัวเครื่อง (Body)</strong></p><ul><li>หน้าจอกระจก Ceramic Shield 2</li><li>กรอบอะลูมิเนียม</li><li>ด้านหลังเครื่อง กระจก Ceramic Shield glass</li><li>คุณสมบัติทนน้ำและระบบป้องกัน (Waterproof &amp; Resistance to dust)</li><li>- ทนน้ำได้ชั่วคราว</li><li>- ทนน้ำที่ความลึกไม่เกิน 6 เมตร</li><li>- ฝุ่นละออง (Resistance to dust)</li><li>ป้องกันรอยนิ้วมือ (Anti-fingerprint display coating)</li><li>มาตรฐาน IP68</li><li>มีสีให้เลือก (Colors) : Blue, Orange, Silver</li><li>MacBookซื้อ iPhone 17</li></ul><p><strong>&nbsp;เครือข่าย (Network)</strong></p><ul><li>ใช้งาน Nano-SIM</li><li>ใช้งาน eSIM</li><li>เทคโนโลยีรับ/ส่งข้อมูล 3G , 4G, 5G</li></ul><p><strong>ระบบปฏิบัติการ (OS, CPU, GPU)</strong></p><ul><li>iOS 26</li><li>CPU : Apple : A19 Pro Hexa Core (2+4)</li><li>GPU : Apple GPU (5-core graphics) ,</li><li>Apple Neural Engine (ANE) : 16-core</li><li>256/512 GB (ตัวเครื่อง) RAM 12GB, , 1TB</li><li>MacBook</li></ul><p><strong>&nbsp;กล้องหลัง (Rear Camera)</strong></p><ul><li>กล้องดิจิตอล 48MP + 48MP (Periscope telephoto) + 48MP (Ultrawide) + TOF 3D LiDAR scanner (Depth) (Quad Camera)</li><li>- รูรับแสงขนาด ƒ/1.6</li><li>- ไฟแฟลช Dual-LED dual-tone flash</li><li>- ซูมดิจิตอล 40 เท่า (40x Digital Zoom)</li><li>- ซูมออฟติคอล 8 เท่า (8x Optical Zoom)</li><li>แสดงเพิ่มเติม</li></ul><p><strong>กล้องหน้า (Front Camera)</strong></p><ul><li>ความละเอียด 18MP</li><li>- กล้องหน้าตัวที่สอง SL 3D (Depth/biometrics sensor)</li><li>- รูรับแสงขนาด ƒ/2.0</li></ul><p><strong>&nbsp;บันทึกวิดีโอ (Video Recording)</strong></p><ul><li>บันทึกวิดีโอกล้องหลัง</li><li>- บันทึกวีดีโอระดับ UHD (4K), 24/25/30/60/100/120 เฟรมต่อวินาที</li><li>- ความละเอียด 3840 x 2160 พิกเซล</li><li>บันทึกวิดีโอกล้องหน้า</li><li>- บันทึกวีดีโอระดับ UHD (4K), 24/25/30/60 เฟรมต่อวินาที</li></ul><p><strong>&nbsp;เซ็นเซอร์ (Sensor)</strong></p><ul><li>สแกนเนอร์ LiDAR (LiDAR scanner)</li><li>ไจโรแบบช่วงไดนามิกสูง (High dynamic range gyro)</li><li>อุปกรณ์ตรวจจับการเคลื่อนไหวแบบแรง g สูง (High-g accelerometer)</li><li>เซ็นเซอร์ตรวจวัดแสงโดยรอบแบบคู่ (Dual ambient light sensors)</li><li>สแกนใบหน้า (Face ID)</li><li>ระบบหมุนภาพอัตโนมัติ (Accelerometer)</li></ul><p><strong>&nbsp;เชื่อมต่อ</strong></p><ul><li>การหาตำแหน่ง: Assisted GPS</li><li>iBeacon เทคโนโลยีระบุตำแหน่งในอาคาร</li><li>WiFi 802.11 a/b/g/n/ac/6/7</li><li>- จุดกระจายสัญญาณอินเตอร์เน็ตแบบพกพา (Portable Wi-Fi Hotspot)</li><li>- เชื่อมต่อไร้สายระหว่างอุปกรณ์โดยตรง (Wi-Fi Direct)</li><li>- Tri band (2.4GHz / 5 + 5GHz)</li></ul><p><strong>มัลติมีเดีย</strong></p><ul><li>ระบบเสียง</li><li>- ลำโพงเสียงสเตอริโอ (Stereo speakers)</li></ul><p><strong>แบตเตอรี่ - ระบบชาร์จ</strong></p><ul><li>แบตเตอรี่ 3,988 mAh (Standard Battery)</li><li>- รองรับชาร์จไร้สาย MagSafe 25W (Wireless Charging)</li><li>- Qi2 25W (Wireless Charging)</li><li>- การแบ่งแบตเตอรี่แบบไร้สาย (Wireless PowerShare)</li><li>การใช้งานแบตเตอรี่</li><li>- ชมวีดีโอนานต่อเนื่อง 31 ชั่วโมง (Video playback time)</li></ul>', '[{\"name\":\"Blue\",\"hex\":\"#1566d1\"},{\"name\":\"Orange\",\"hex\":\"#e2901d\"},{\"name\":\"Silver\",\"hex\":\"#d4d4d4\"}]', 40, 15, '2025-10-09 20:45:39', '2025-10-09 23:25:43'),
(21, 'Apple iPhone Air', '{\"screen\":\"6.5นิ้ว  จอ Super Retina XDR OLED 24-bit  1260 x 2736 พิกเซล\",\"camera\":\"48 MP  กล้องหน้า 18MP\",\"cpu\":\"Apple A19 Pro Hexa Core (2+4)\",\"memory\":\"RAM 8 GB  ROM 256/512 GB  ROM 1 TB\",\"battery\":\"3,149 mAh\",\"os\":\"iOS 26\",\"dimensions\":\"156.2 × 74.7 × 5.64 มม.\",\"weight\":\"165 กรัม\"}', '2025-09-10', 39900, '/storage/Phones/KGUMFoXUO4FE7FcLmM3kcfcJoRONUI2eifNCe46d.jpg', '<p><strong>ข้อมูลมือถือ&nbsp;&nbsp;Apple iPhone Air</strong></p><ul><li>เปิดตัวครั้งแรก 10 กันยายน 2025 (สยามโฟนฯ)</li><li>สถานะ มีวางจำหน่ายในประเทศไทย</li><li>วางจำหน่าย ไตรมาสที่ 3 ปี 2025 (กันยายน 68)</li><li>- ราคาเปิดตัว 39,900 บาท (กันยายน 68)</li><li>รุ่น 256GB ราคา 39,900 บาท , 512GB ราคา 47,900 บาท , 1TB ราคา 55,900 บาท</li></ul><p><strong>จอแสดงผล (Display)</strong></p><ul><li>สมาร์ทโฟน (โทรศัพท์มือถือพร้อมระบบปฏิบัติการ)</li><li>จอแสดงผล Super Retina XDR OLED 24-bit (16 ล้านสี)</li><li>- จอแสดงผล HDR 10</li><li>- หน้าจอแบบเจาะ Dymamic Island</li><li>- กว้าง 6.5 นิ้ว (แนวทะแยง)</li><li>- ความละเอียด 1260 x 2736 พิกเซล</li><li>(460 ppi)</li><li>- อัตราการสัมผัสหน้าจอ 120 เฮิรตซ์ (Refresh Rate 120Hz)</li><li>- Always on display</li><li>ค่าความสว่างหน้าจอ (Display Brightness)</li><li>- ค่าความสว่างทั่วไป (Typical brightness) 1000 nits</li><li>- ค่าความสว่างสูงสุดเฉพาะจุด (High Brightness Mode) 1600 nits</li><li>- ค่าความสว่างสูงสุดของหน้าจอ (Peak Brightness) 3000 nits</li></ul><p><strong>วัสดุตัวเครื่อง (Body)</strong></p><ul><li>หน้าจอกระจก Ceramic Shield 2</li><li>ด้านหลังเครื่อง กระจก Ceramic Shield glass</li><li>กรอบไทเทเนียม (grade 5)</li><li>คุณสมบัติทนน้ำและระบบป้องกัน (Waterproof &amp; Resistance to dust)</li><li>- ทนน้ำได้ชั่วคราว</li><li>- ทนน้ำที่ความลึกไม่เกิน 6 เมตร</li><li>- ฝุ่นละออง (Resistance to dust)</li><li>ป้องกันรอยนิ้วมือ (Anti-fingerprint display coating)</li><li>มาตรฐาน IP68</li><li>มีสีให้เลือก (Colors) : Black, White, Blue, Gold</li><li>ผลิตภัณฑ์ Appleราคา iPhone Air</li></ul><p><strong>&nbsp;เครือข่าย (Network)</strong></p><ul><li>ใช้งาน Nano-SIM</li><li>ใช้งาน eSIM</li><li>เทคโนโลยีรับ/ส่งข้อมูล 3G , 4G, 5G</li></ul><p><strong>ระบบปฏิบัติการ (OS, CPU, GPU)</strong></p><ul><li>iOS 26</li><li>CPU : Apple : A19 Pro Hexa Core (2+4)</li><li>GPU : Apple GPU (5-core graphics) ,</li><li>Apple Neural Engine (ANE) : 16-core</li><li>256/512 GB (ตัวเครื่อง) RAM 8GB, , 1TB</li><li>ราคา สมาร์ทโฟนผลิตภัณฑ์ Apple</li></ul><p><strong>&nbsp;กล้องหลัง (Rear Camera)</strong></p><ul><li>กล้องดิจิตอล 48 ล้านพิกเซล (Digital Camera)</li><li>- รูรับแสงขนาด ƒ/1.6</li><li>- ไฟแฟลช Dual-LED dual-tone flash</li><li>- ซูมดิจิตอล 10 เท่า (10x Digital Zoom)</li></ul><p><strong>กล้องหน้า (Front Camera)</strong></p><ul><li>ความละเอียด 18MP</li><li>- กล้องหน้าตัวที่สอง SL 3D (Depth/biometrics sensor)</li><li>- รูรับแสงขนาด ƒ/1.9</li></ul><p><strong>&nbsp;บันทึกวิดีโอ (Video Recording)</strong></p><ul><li>บันทึกวิดีโอกล้องหลัง</li><li>- ซูมดิจิตอล 6 เท่า (6x Digital Video Zoom)</li><li>- บันทึกวีดีโอระดับ UHD (4K), 24/25/30/60 เฟรมต่อวินาที</li><li>- ความละเอียด 3840 x 2160 พิกเซล</li><li>บันทึกวิดีโอกล้องหน้า</li><li>- บันทึกวีดีโอระดับ UHD (4K), 24/25/30/60 เฟรมต่อวินาที</li></ul><p><strong>&nbsp;เซ็นเซอร์ (Sensor)</strong></p><ul><li>ไจโรแบบช่วงไดนามิกสูง (High dynamic range gyro)</li><li>อุปกรณ์ตรวจจับการเคลื่อนไหวแบบแรง g สูง (High-g accelerometer)</li><li>เซ็นเซอร์ตรวจวัดแสงโดยรอบแบบคู่ (Dual ambient light sensors)</li><li>สแกนใบหน้า (Face ID)</li><li>ระบบหมุนภาพอัตโนมัติ (Accelerometer)</li></ul><p><strong>&nbsp;เชื่อมต่อ</strong></p><ul><li>การหาตำแหน่ง: Assisted GPS</li><li>iBeacon เทคโนโลยีระบุตำแหน่งในอาคาร</li><li>WiFi 802.11 a/b/g/n/ac/6/7</li><li>- จุดกระจายสัญญาณอินเตอร์เน็ตแบบพกพา (Portable Wi-Fi Hotspot)</li><li>- เชื่อมต่อไร้สายระหว่างอุปกรณ์โดยตรง (Wi-Fi Direct)</li><li>- Tri band (2.4GHz / 5 + 5GHz)</li></ul><p><strong>มัลติมีเดีย</strong></p><ul><li>ระบบเสียง</li><li>- ลำโพงเสียงสเตอริโอ (Stereo speakers)</li></ul><p><strong>แบตเตอรี่ - ระบบชาร์จ</strong></p><ul><li>แบตเตอรี่ 3,149 mAh (Standard Battery)</li><li>- รองรับชาร์จไร้สาย MagSafe 20W (Wireless Charging)</li><li>- Qi2 20W (Wireless Charging)</li><li>- การแบ่งแบตเตอรี่แบบไร้สาย (Wireless PowerShare)</li><li>การใช้งานแบตเตอรี่</li><li>- ชมวีดีโอนานต่อเนื่อง 27 ชั่วโมง (Video playback time)</li></ul>', '[{\"name\":\"Black\",\"hex\":\"#000000\"},{\"name\":\"White\",\"hex\":\"#e3e3e3\"},{\"name\":\"Blue\",\"hex\":\"#176bc4\"},{\"name\":\"Gold\",\"hex\":\"#c7b585\"}]', 43, 15, '2025-10-09 20:54:14', '2025-10-09 22:08:31'),
(22, 'Apple iPhone 17', '{\"screen\":\"6.3นิ้ว  จอ Super Retina XDR OLED 24-bit  1206 x 2622 พิกเซล\",\"camera\":\"48 MP + 48MP (Ultrawide)  กล้องหน้า 18MP\",\"cpu\":\"Apple A19 Hexa Core (2+4)\",\"memory\":\"RAM 8 GB  ROM 256/512 GB\",\"battery\":\"3,692 mAh\",\"os\":\"iOS 26\",\"dimensions\":\"149.6 × 71.5 × 7.95 มม.\",\"weight\":\"177 กรัม\"}', '2025-09-10', 29900, '/storage/Phones/f61rQQwta0jzIbLjtkGPAlg2DGxu3HJ7duoZGbpM.jpg', '<p><strong>ข้อมูลมือถือ&nbsp;&nbsp;Apple iPhone 17</strong></p><ul><li>เปิดตัวครั้งแรก 10 กันยายน 2025 (สยามโฟนฯ)</li><li>สถานะ มีวางจำหน่ายในประเทศไทย</li><li>วางจำหน่าย ไตรมาสที่ 3 ปี 2025 (กันยายน 68)</li><li>- ราคาเปิดตัว 29,900 บาท (กันยายน 68)</li><li>รุ่น 256GB ราคา 29,900 บาท , 512GB ราคา 37,900 บาท<img src=\"https://ads.siamphone.com/sp_ads/adlog.php?bannerid=1876&amp;clientid=844&amp;zoneid=82&amp;source=&amp;block=0&amp;capping=0&amp;cb=e706dd0076fa3edb708acf4e6bd9afa5\"></li></ul><p><strong>จอแสดงผล (Display)</strong></p><ul><li>สมาร์ทโฟน (โทรศัพท์มือถือพร้อมระบบปฏิบัติการ)</li><li>จอแสดงผล Super Retina XDR OLED 24-bit (16 ล้านสี)</li><li>- จอแสดงผล HDR</li><li>- หน้าจอแบบเจาะ Dymamic Island</li><li>- กว้าง 6.3 นิ้ว (แนวทะแยง)</li><li>- ความละเอียด 1206 x 2622 พิกเซล</li><li>(460 ppi)</li><li>- อัตราการสัมผัสหน้าจอ 120 เฮิรตซ์ (Refresh Rate 120Hz)</li><li>- Always on display</li><li>ค่าความสว่างหน้าจอ (Display Brightness)</li><li>- ค่าความสว่างทั่วไป (Typical brightness) 1000 nits</li><li>- ค่าความสว่างสูงสุดเฉพาะจุด (High Brightness Mode) 1600 nits</li><li>- ค่าความสว่างสูงสุดของหน้าจอ (Peak Brightness) 3000 nits</li><li>จอแสดงผลรอง (ไม่ระบุ) 1-bit (2 สีขาว/ดำ)</li></ul><p><strong>วัสดุตัวเครื่อง (Body)</strong></p><ul><li>หน้าจอกระจก Ceramic Shield 2</li><li>กรอบอะลูมิเนียม</li><li>ด้านหลังเครื่อง กระจก</li><li>คุณสมบัติทนน้ำและระบบป้องกัน (Waterproof &amp; Resistance to dust)</li><li>- ทนน้ำได้ชั่วคราว</li><li>- ทนน้ำที่ความลึกไม่เกิน 6 เมตร</li><li>- ฝุ่นละออง (Resistance to dust)</li><li>ป้องกันรอยนิ้วมือ (Anti-fingerprint display coating)</li><li>มาตรฐาน IP68</li><li>มีสีให้เลือก (Colors) : Black, White, Green, Blue, Purple</li></ul><p><strong>&nbsp;เครือข่าย (Network)</strong></p><ul><li>ใช้งาน Nano-SIM</li><li>ใช้งาน eSIM</li><li>เทคโนโลยีรับ/ส่งข้อมูล 3G , 4G, 5G</li><li><em>Apple Store Onlineราคา iPhone 17</em></li></ul><p><strong>ระบบปฏิบัติการ (OS, CPU, GPU)</strong></p><ul><li>iOS 26</li><li>CPU : Apple : A19 Hexa Core (2+4)</li><li>GPU : Apple GPU (5-core graphics) ,</li><li>Apple Neural Engine (ANE) : 16-core</li><li>256/512 GB (ตัวเครื่อง) RAM 8GB,</li></ul><p>&nbsp;<strong>กล้องหลัง (Rear Camera)</strong></p><ul><li>กล้องดิจิตอล 48 + 48MP (Ultrawide) ล้านพิกเซล (Dual Camera)</li><li>- รูรับแสงขนาด ƒ/1.6</li><li>- ไฟแฟลช Dual-LED dual-tone flash</li><li>- ซูมดิจิตอล 10 เท่า (10x Digital Zoom)</li><li>- ซูมออฟติคอล 4 เท่า (4x Optical Zoom)</li></ul><p><strong>กล้องหน้า (Front Camera)</strong></p><ul><li>ความละเอียด 18MP</li><li>- กล้องหน้าตัวที่สอง SL 3D (Depth/biometrics sensor)</li><li>- รูรับแสงขนาด ƒ/2.0</li></ul><p><strong>บันทึกวิดีโอ (Video Recording)</strong></p><ul><li>บันทึกวิดีโอกล้องหลัง</li><li>- บันทึกวีดีโอระดับ UHD (4K), 24/25/30/60 เฟรมต่อวินาที</li><li>- ความละเอียด 3840 x 2160 พิกเซล</li><li>บันทึกวิดีโอกล้องหน้า</li><li>- บันทึกวีดีโอระดับ UHD (4K), 24/25/30/60 เฟรมต่อวินาที</li></ul><p><strong>&nbsp;เซ็นเซอร์ (Sensor)</strong></p><ul><li>สแกนใบหน้า (Face ID)</li><li>ระบบหมุนภาพอัตโนมัติ (Accelerometer)</li></ul><p><strong>&nbsp;เชื่อมต่อ</strong></p><ul><li>การหาตำแหน่ง: Assisted GPS</li><li>iBeacon เทคโนโลยีระบุตำแหน่งในอาคาร</li><li>WiFi 802.11 a/b/g/n/ac/6/7</li><li>- จุดกระจายสัญญาณอินเตอร์เน็ตแบบพกพา (Portable Wi-Fi Hotspot)</li><li>- เชื่อมต่อไร้สายระหว่างอุปกรณ์โดยตรง (Wi-Fi Direct)</li><li>- Tri band (2.4GHz / 5 + 5GHz)</li></ul><p><strong>มัลติมีเดีย</strong></p><ul><li>ระบบเสียง</li><li>- ลำโพงเสียงสเตอริโอ (Stereo speakers)</li></ul><p><strong>แบตเตอรี่ - ระบบชาร์จ</strong></p><ul><li>แบตเตอรี่ 3,692 mAh (Standard Battery)</li><li>- รองรับชาร์จไร้สาย MagSafe 25W (Wireless Charging)</li><li>- Qi2 25W (Wireless Charging)</li><li>- การแบ่งแบตเตอรี่แบบไร้สาย (Wireless PowerShare)</li><li>การใช้งานแบตเตอรี่</li><li>- ชมวีดีโอนานต่อเนื่อง 30 ชั่วโมง (Video playback time)</li></ul>', '[{\"name\":\"Black\",\"hex\":\"#000000\"},{\"name\":\"White\",\"hex\":\"#f5f5f5\"},{\"name\":\"Green\",\"hex\":\"#4ab05b\"},{\"name\":\"Blue\",\"hex\":\"#3e7ada\"},{\"name\":\"Purple\",\"hex\":\"#b1689a\"}]', 62, 15, '2025-10-09 21:00:41', '2025-10-09 22:07:55'),
(23, 'Redmi Note 14 Pro', '{\"screen\":\" 6.67นิ้ว  จอ AMOLED 12bit 68B colors  1220 x 2712 พิกเซล\",\"camera\":\"200 MP + 8MP (Ultrawide) + 2MP (Macro)  กล้องหน้า 20MP\",\"cpu\":\"Mediatek Dimensity 7300 Ultra Octa Core  ความเร็ว 2.5 GHz\",\"memory\":\"RAM 12 GB  ROM 256 GB\",\"battery\":\"5,110 mAh  ชาร์จไว 45W\",\"os\":\"HyperOS based on Android 14\",\"dimensions\":\"162.3 × 74.4 × 8.2 มม.\",\"weight\":\"190 กรัม\"}', '2025-09-04', 11990, '/storage/Phones/13IZWsVVGvJOBmnbOh1iU4EdlZN3X8oYQU30joDb.jpg', '<p><strong>ข้อมูลมือถือ&nbsp;&nbsp;Redmi&nbsp;Note 14 Pro</strong></p><ul><li>เปิดตัวครั้งแรก 4 กันยายน 2025 (สยามโฟนฯ)</li><li>สถานะ มีวางจำหน่ายในประเทศไทย</li><li>วางจำหน่าย ไตรมาสที่ 3 ปี 2025 (กันยายน 68)</li><li>- ราคาเปิดตัว 11,990 บาท (กันยายน 68)</li></ul><p><strong>จอแสดงผล (Display)</strong></p><ul><li>&nbsp;สมาร์ทโฟน&nbsp;(โทรศัพท์มือถือพร้อมระบบปฏิบัติการ)</li><li>จอแสดงผล AMOLED 12bit 68B colors</li><li>- จอแสดงผล HDR 10+</li><li>- จอแสดงผลมีรูสำหรับกล้องหน้า (Punch-Hole Display)</li><li>- กว้าง 6.67 นิ้ว (แนวทะแยง)</li><li>- ความละเอียด 1220 x 2712 พิกเซล</li><li>(446 ppi)</li><li>- อัตราการสัมผัสหน้าจอ 120 เฮิรตซ์ (Refresh Rate 120Hz)</li><li>- Always on display</li><li>ค่าความสว่างหน้าจอ (Display Brightness)</li><li>- ค่าความสว่างสูงสุดของหน้าจอ (Peak Brightness) 3000 nits</li></ul><p><strong>วัสดุตัวเครื่อง (Body)</strong></p><ul><li>หน้าจอกระจก Gorilla Glass Victus 2</li><li>กรอบพลาสติก</li><li>ด้านหลังเครื่อง Silicone Polymer</li><li>คุณสมบัติทนน้ำและระบบป้องกัน (Waterproof &amp; Resistance to dust)</li><li>- ทนน้ำได้ชั่วคราว</li><li>- ทนน้ำที่ความลึกไม่เกิน 2 เมตร</li><li>- ฝุ่นละออง (Resistance to dust)</li><li>มาตรฐาน IP68</li><li>มีสีให้เลือก (Colors) : Black, Green, Gold, Purple</li><li>มือถือจอใหญ่สมาร์ทโฟนที่ดีที่สุด</li></ul><p><strong>เครือข่าย (Network)</strong></p><ul><li>ใช้งาน Nano-SIM</li><li>เทคโนโลยีรับ/ส่งข้อมูล 3G , 4G, 5G</li></ul><p><strong>ระบบปฏิบัติการ (OS, CPU, GPU)</strong></p><ul><li>HyperOS based on Android 14</li><li>CPU : Mediatek : Dimensity 7300 Ultra Octa Core</li><li>ความเร็ว : 2.5 GHz</li><li>GPU : Mali-G615 MC2</li><li>RAM 12GB, ROM 256GB : UFS 2.2</li><li>ซื้อมือถือ Xiaomiมือถือ Redmi</li></ul><p><strong>&nbsp;กล้องหลัง (Rear Camera)</strong></p><ul><li>กล้องดิจิตอล 200MP + 8MP (Ultrawide) + 2MP (Macro) (Triple Camera)</li><li>- รูรับแสงขนาด ƒ/1.5</li><li>- ไฟแฟลช LED</li><li>- ขนาดภาพสูงสุด 8,000 x 6,000 พิกเซล (Image Size)</li></ul><p><strong>กล้องหน้า (Front Camera)</strong></p><ul><li>ความละเอียด 20MP</li><li>- รูรับแสงขนาด ƒ/2.2</li></ul><p><strong>&nbsp;บันทึกวิดีโอ (Video Recording)</strong></p><ul><li>บันทึกวิดีโอกล้องหลัง</li><li>- บันทึกวีดีโอระดับ UHD (4K), 24/30 เฟรมต่อวินาที</li><li>- ความละเอียด 3840 x 2160 พิกเซล</li><li>บันทึกวิดีโอกล้องหน้า</li><li>- บันทึกวีดีโอระดับ FULL HD (1080p), 30 เฟรมต่อวินาที</li><li>เปรียบเทียบสมาร์ทโฟน</li></ul><p><strong>&nbsp;เซ็นเซอร์ (Sensor)</strong></p><ul><li>ระบบสแกนลายนิ้วมือใต้หน้าจอ (Fingerprint Under Display)</li><li>สแกนใบหน้า (Face ID)</li><li>ระบบหมุนภาพอัตโนมัติ (Accelerometer)</li></ul><p><strong>&nbsp;เชื่อมต่อ</strong></p><ul><li>การหาตำแหน่ง: Assisted GPS</li><li>WiFi 802.11 a/b/g/n/ac/6</li><li>- จุดกระจายสัญญาณอินเตอร์เน็ตแบบพกพา (Portable Wi-Fi Hotspot)</li><li>- เชื่อมต่อไร้สายระหว่างอุปกรณ์โดยตรง (Wi-Fi Direct)</li><li>- Dual band (2.4GHz / 5GHz)</li></ul><p><strong>มัลติมีเดีย</strong></p><ul><li>ระบบเสียง</li><li>- ลำโพงคู่ (Dual Speaker)</li><li>- ลำโพงเสียงสเตอริโอ (Stereo speakers)</li><li>- ระบบเสียง Dolby Atmos</li></ul><p><strong>แบตเตอรี่ - ระบบชาร์จ</strong></p><ul><li>แบตเตอรี่ 5,110 mAh (Standard Battery)</li><li>- รองรับชาร์จไว 45W (Fast Charging)</li></ul>', '[{\"name\":\"Black\",\"hex\":\"#000000\"},{\"name\":\"Green\",\"hex\":\"#4da357\"},{\"name\":\"Gold\",\"hex\":\"#c9bf7e\"},{\"name\":\"Purple\",\"hex\":\"#a96099\"}]', 0, 14, '2025-10-09 21:07:57', '2025-10-09 21:10:43');
INSERT INTO `phones` (`id`, `model`, `summary`, `release_date`, `price`, `main_image_url`, `specs`, `colors`, `views`, `category_id`, `created_at`, `updated_at`) VALUES
(24, 'Samsung Galaxy A17', '{\"screen\":\"6.7นิ้ว  จอ Super AMOLED 24-bit  1080 x 2340 พิกเซล\",\"camera\":\"50 MP + 5MP (Ultrawide) + 2MP (Macro)  กล้องหน้า 13MP\",\"cpu\":\"Exynos 1330 Octa Core\",\"memory\":\"RAM 8 GB  ROM 128/256 GB\",\"battery\":\"5,000 mAh  ชาร์จไว 25W\",\"os\":\"One UI 7 based on Android 15\",\"dimensions\":\"164.4 × 77.9 × 7.5 มม.\",\"weight\":\"192 กรัม\"}', '2025-08-28', 7499, '/storage/Phones/VWdlyJ54MZ4a5jp7Q638QdxxcHqDGlaOvaiZkaeY.jpg', '<p><strong>ข้อมูลมือถือ&nbsp;&nbsp;Samsung Galaxy A17</strong></p><ul><li>เปิดตัวครั้งแรก 28 สิงหาคม 2025 (สยามโฟนฯ)</li><li>สถานะ มีวางจำหน่ายในประเทศไทย</li><li>วางจำหน่าย ไตรมาสที่ 3 ปี 2025 (สิงหาคม 68)</li><li>- ราคาเปิดตัว 7,499 บาท (สิงหาคม 68)</li><li>รุ่น ROM 128GB ราคา 7,499 บาท , รุ่น ROM 256GB ราคา 8,999 บาท</li></ul><p><strong>จอแสดงผล (Display)</strong></p><ul><li>สมาร์ทโฟน (โทรศัพท์มือถือพร้อมระบบปฏิบัติการ)</li><li>จอแสดงผล Super AMOLED 24-bit (16 ล้านสี)</li><li>- หน้าจอทรงหยดน้ำ รูปตัว U (Infinity U)</li><li>- หน้าจอหยดน้ำ (Waterdrop Display)</li><li>- กว้าง 6.7 นิ้ว (แนวทะแยง)</li><li>- ความละเอียด 1080 x 2340 พิกเซล</li><li>(385 ppi)</li><li>- อัตราการสัมผัสหน้าจอ 90 เฮิรตซ์ (Refresh Rate 90Hz)</li><li>ค่าความสว่างหน้าจอ (Display Brightness)</li><li>- ค่าความสว่างสูงสุดเฉพาะจุด (High Brightness Mode) 800 nits</li></ul><p><strong>วัสดุตัวเครื่อง (Body)</strong></p><ul><li>หน้าจอกระจก Gorilla Glass Victus</li><li>กรอบพลาสติก</li><li>คุณสมบัติทนน้ำและระบบป้องกัน (Waterproof &amp; Resistance to dust)</li><li>- ทนน้ำได้ชั่วคราว</li><li>- ฝุ่นละออง (Resistance to dust)</li><li>มาตรฐาน IP54</li><li>มีสีให้เลือก (Colors) : Black, Blue</li></ul><p><strong>&nbsp;เครือข่าย (Network)</strong></p><ul><li>ใช้งาน Nano-SIM</li><li>รองรับ 2 ซิมการ์ด</li><li>เทคโนโลยีรับ/ส่งข้อมูล 3G , 4G, 5G</li><li><em>สมาร์ทโฟนที่ดีที่สุดซื้อ Galaxy A17</em></li></ul><p><strong>ระบบปฏิบัติการ (OS, CPU, GPU)</strong></p><ul><li>One UI 7 based on Android 15</li><li>Exynos 1330 Octa Core</li><li>ความเร็ว : 2.4 GHz</li><li>GPU : Mali-G68 MP2</li><li>RAM 8GB, ROM 128/256GB , microSD สูงสุด 1 TB</li></ul><p><strong>&nbsp;กล้องหลัง (Rear Camera)</strong></p><ul><li>กล้องดิจิตอล 50MP + 5MP (Ultrawide) + 2MP (Macro) (Triple Camera)</li><li>- รูรับแสงขนาด ƒ/1.8</li><li>- ไฟแฟลช LED</li><li>- ขนาดภาพสูงสุด 8,000 x 6,000 พิกเซล (Image Size)</li></ul><p><strong>กล้องหน้า (Front Camera)</strong></p><ul><li>ความละเอียด 13MP</li><li>- รูรับแสงขนาด ƒ/2.0</li><li>อุปกรณ์ Samsungเปรียบเทียบสมาร์ทโฟน</li></ul><p><strong>&nbsp;บันทึกวิดีโอ (Video Recording)</strong></p><ul><li>บันทึกวิดีโอกล้องหลัง</li><li>- บันทึกวีดีโอระดับ FULL HD (1080p), 30/60 เฟรมต่อวินาที</li><li>- ความละเอียด 1920 x 1080 พิกเซล</li><li>บันทึกวิดีโอกล้องหน้า</li><li>- บันทึกวีดีโอระดับ FULL HD (1080p), 30 เฟรมต่อวินาที</li></ul><p><strong>&nbsp;เซ็นเซอร์ (Sensor)</strong></p><ul><li>ระบบสแกนลายนิ้วมือใต้หน้าจอ (Fingerprint Under Display)</li><li>ระบบหมุนภาพอัตโนมัติ (Accelerometer)</li></ul><p><strong>&nbsp;เชื่อมต่อ</strong></p><ul><li>การหาตำแหน่ง: Assisted GPS</li><li>WiFi 802.11 a/b/g/n/ac</li><li>- จุดกระจายสัญญาณอินเตอร์เน็ตแบบพกพา (Portable Wi-Fi Hotspot)</li><li>- เชื่อมต่อไร้สายระหว่างอุปกรณ์โดยตรง (Wi-Fi Direct)</li><li>- Dual band (2.4GHz / 5GHz)</li></ul><p><strong>มัลติมีเดีย</strong></p><ul><li>ระบบเสียง</li><li>- ลำโพงเสียงสเตอริโอ (Stereo speakers)</li></ul><p><strong>แบตเตอรี่ - ระบบชาร์จ</strong></p><ul><li>แบตเตอรี่ 5,000 mAh (Standard Battery)</li><li>- รองรับชาร์จไว 25W (Fast Charging)</li></ul>', '[{\"name\":\"Black\",\"hex\":\"#000000\"},{\"name\":\"Blue\",\"hex\":\"#422494\"}]', 0, 6, '2025-10-09 21:14:39', '2025-10-09 21:19:24'),
(25, 'vivo X Fold 5', '{\"screen\":\"8.03นิ้ว  จอ LTPO AMOLED 10-bit  2200 x 2480 พิกเซล\",\"camera\":\"50 MP + 50MP (Periscope telephoto) + 50MP (Ultrawide)  กล้องหน้า 20MP\",\"cpu\":\"Qualcomm Snapdragon 8 Gen 3 Octa Core  ความเร็ว 3.3 GHz\",\"memory\":\"RAM 16 GB  ROM 512 GB\",\"battery\":\"6,000 mAh  ชาร์จไว 80W\",\"os\":\"Funtouch OS 15 based on Android 15\",\"dimensions\":\"159.7 × 142.3 × 4.3 มม.\",\"weight\":\"217 กรัม\"}', '2025-08-15', 59999, '/storage/Phones/LFlxgtT0XLwGYuO0bYXt5TqWrHC89BQ6j2Q4IqgV.jpg', '<p><strong>ข้อมูลมือถือ vivo X Fold 5</strong></p><ul><li>เปิดตัวครั้งแรก 15 สิงหาคม 2025 (สยามโฟนฯ)</li><li>สถานะ มีวางจำหน่ายในประเทศไทย</li><li>วางจำหน่าย ไตรมาสที่ 3 ปี 2025 (สิงหาคม 68)</li><li>- ราคาเปิดตัว 59,999 บาท (สิงหาคม 68)</li></ul><p><strong>จอแสดงผล (Display)</strong></p><ul><li>สมาร์ทโฟน (โทรศัพท์มือถือพร้อมระบบปฏิบัติการ)</li><li>จอแสดงผล</li><li>- จอแสดงผล HDR 10+</li><li>- จอแสดงผลมีรูสำหรับกล้องหน้า (Punch-Hole Display)</li><li>- หน้าจอ Foldable Display</li><li>- อัตราการสัมผัสหน้าจอ 120 เฮิรตซ์ (Refresh Rate 120Hz)</li><li>ค่าความสว่างหน้าจอ (Display Brightness)</li><li>- ค่าความสว่างสูงสุดของหน้าจอ (Peak Brightness) 4500 nits</li><li>- PWM (Pulse Width Modulation) 5280Hz</li><li>รูปแบบ ขนาดหน้าจอตอนเปิดออก</li><li>- LTPO AMOLED 10-bit (1.07 พันล้านสี)</li><li>- กว้าง 8.03 นิ้ว (แนวทะแยง)</li><li>- ความละเอียด 2200 x 2480 พิกเซล (394 ppi)</li><li>รูปแบบ ขนาดหน้าจอตอนพับด้านหน้า</li><li>- LTPO AMOLED 10-bit (1.07 พันล้านสี)</li><li>- กว้าง 6.53 นิ้ว (แนวทะแยง)</li><li>- ความละเอียด 1172 x 2748 พิกเซล</li></ul><p><strong>วัสดุตัวเครื่อง (Body)</strong></p><ul><li>หน้าจอกระจก</li><li>กรอบอะลูมิเนียม</li><li>ด้านหลังเครื่อง กระจก</li><li>คุณสมบัติทนน้ำและระบบป้องกัน (Waterproof &amp; Resistance to dust)</li><li>- ทนน้ำได้ชั่วคราว</li><li>- ทนน้ำที่ความลึกไม่เกิน 3 เมตร</li><li>- ฝุ่นละออง (Resistance to dust)</li><li>มาตรฐาน IP5X / IPX8 / IPX9 / IPX9+</li><li>มีสีให้เลือก (Colors) : White, Gray</li></ul><p><strong>&nbsp;เครือข่าย (Network)</strong></p><ul><li>ใช้งาน Nano-SIM</li><li>รองรับ 2 ซิมการ์ด</li><li>เทคโนโลยีรับ/ส่งข้อมูล 3G , 4G, 5G</li></ul><p><strong>ระบบปฏิบัติการ (OS, CPU, GPU)</strong></p><ul><li>Funtouch OS 15 based on Android 15</li><li>CPU : Qualcomm : Snapdragon 8 Gen 3 Octa Core</li><li>ความเร็ว : 3.3 GHz</li><li>GPU : Adreno 750</li><li>RAM 16GB, ROM 512GB : UFS 4.1</li></ul><p><strong>&nbsp;กล้องหลัง (Rear Camera)</strong></p><ul><li>กล้องดิจิตอล 50MP + 50MP (Periscope telephoto) + 50MP (Ultrawide) (Triple Camera)</li><li>- เลนส์ Zeiss optics</li><li>- รูรับแสงขนาด ƒ/1.8</li><li>- ไฟแฟลช LED</li><li>- ซูมออฟติคอล 3 เท่า (3x Optical Zoom)</li><li>- ขนาดภาพสูงสุด 8,000 x 6,000 พิกเซล (Image Size)</li></ul><p><strong>กล้องหน้า (Front Camera)</strong></p><ul><li>ความละเอียด 20MP</li><li>- กล้องหน้าตัวที่สอง 20MP</li><li>- รูรับแสงขนาด ƒ/2.4</li></ul><p><strong>&nbsp;บันทึกวิดีโอ (Video Recording)</strong></p><ul><li>บันทึกวิดีโอกล้องหลัง</li><li>- บันทึกวีดีโอระดับ UHD-2(8K), 30 เฟรมต่อวินาที</li><li>- ความละเอียด 7680 x 4320 พิกเซล</li><li>บันทึกวิดีโอกล้องหน้า</li><li>- บันทึกวีดีโอระดับ FULL HD (1080p), 30 เฟรมต่อวินาที</li></ul><p><strong>&nbsp;เซ็นเซอร์ (Sensor)</strong></p><ul><li>ระบบตรวจสอบลายนิ้วมือ (Fingerprint)</li><li>ระบบหมุนภาพอัตโนมัติ (Accelerometer)</li></ul><p><strong>&nbsp;เชื่อมต่อ</strong></p><ul><li>การหาตำแหน่ง: Assisted GPS</li><li>WiFi 802.11 a/b/g/n/ac/6e/7</li><li>- จุดกระจายสัญญาณอินเตอร์เน็ตแบบพกพา (Portable Wi-Fi Hotspot)</li><li>- เชื่อมต่อไร้สายระหว่างอุปกรณ์โดยตรง (Wi-Fi Direct)</li><li>- Dual band (2.4GHz / 5GHz)</li></ul><p><strong>มัลติมีเดีย</strong></p><ul><li>ระบบเสียง</li><li>- ลำโพงเสียงสเตอริโอ (Stereo speakers)</li></ul><p><strong>แบตเตอรี่ - ระบบชาร์จ</strong></p><ul><li>แบตเตอรี่ 6,000 mAh (Standard Battery)</li><li>- รองรับชาร์จไว 80W (Fast Charging)</li><li>- รองรับชาร์จไร้สาย 40W (Wireless Charging)</li><li>- การแบ่งแบตเตอรี่แบบไร้สาย (Wireless PowerShare)</li></ul>', '[{\"name\":\"White\",\"hex\":\"#f5f5f5\"},{\"name\":\"Gray\",\"hex\":\"#bfbfbf\"}]', 0, 2, '2025-10-09 21:22:29', '2025-10-09 21:25:38'),
(26, 'Honor Magic V5', '{\"screen\":\" 7.95นิ้ว  จอ LTPO AMOLED 10-bit  2172 x 2352 พิกเซล\",\"camera\":\"50 MP + 64MP (Periscope telephoto) + 50MP (Ultrawide)  กล้องหน้า 20MP\",\"cpu\":\"Qualcomm Snapdragon 8 Elite Octa Core  ความเร็ว 4.32 GHz\",\"memory\":\"RAM 16 GB  ROM 512 GB\",\"battery\":\"5,820 mAh  ชาร์จไว 66W\",\"os\":\"MagicOS 9 based on Android 15\",\"dimensions\":\"156.8 × 145.9 × 4.1 มม.\",\"weight\":\"217 กรัม\"}', '2025-08-15', 57990, '/storage/Phones/Sk40tNmf1bAGVw2pWpYelOOft7qRgmFZjK4WncBv.jpg', '<p><strong>ข้อมูลมือถือ&nbsp;&nbsp;Honor&nbsp;Magic V5</strong></p><ul><li>เปิดตัวครั้งแรก 15 สิงหาคม 2025 (สยามโฟนฯ)</li><li>สถานะ มีวางจำหน่ายในประเทศไทย</li><li>วางจำหน่าย ไตรมาสที่ 3 ปี 2025 (สิงหาคม 68)</li><li>- ราคาเปิดตัว 57,990 บาท (สิงหาคม 68)<img src=\"https://ads.siamphone.com/sp_ads/adlog.php?bannerid=1876&amp;clientid=844&amp;zoneid=82&amp;source=&amp;block=0&amp;capping=0&amp;cb=084a7fbbcfd729f6c9a564c719c31513\"></li></ul><p><strong>จอแสดงผล (Display)</strong></p><ul><li>สมาร์ทโฟน (โทรศัพท์มือถือพร้อมระบบปฏิบัติการ)</li><li>จอแสดงผล</li><li>- จอแสดงผลมีรูสำหรับกล้องหน้า (Punch-Hole Display)</li><li>- หน้าจอ Foldable Display</li><li>- อัตราการสัมผัสหน้าจอ 120 เฮิรตซ์ (Refresh Rate 120Hz)</li><li>ค่าความสว่างหน้าจอ (Display Brightness)</li><li>- ค่าความสว่างสูงสุดของหน้าจอ (Peak Brightness) 5000 nits</li><li>- PWM (Pulse Width Modulation) 4320Hz</li><li>รูปแบบ ขนาดหน้าจอตอนเปิดออก</li><li>- LTPO AMOLED 10-bit (1.07 พันล้านสี)</li><li>- กว้าง 7.95 นิ้ว (แนวทะแยง)</li><li>- ความละเอียด 2172 x 2352 พิกเซล (403 ppi)</li><li>รูปแบบ ขนาดหน้าจอตอนพับด้านหน้า</li><li>- LTPO AMOLED 10-bit (1.07 พันล้านสี)</li><li>- กว้าง 6.43 นิ้ว (แนวทะแยง)</li><li>- ความละเอียด 1060 x 2376 พิกเซล</li><li>ปากกา Stylus สำหรับวาด, เขียน, ระบาย และรีทัชรูปภาพ</li></ul><p><strong>วัสดุตัวเครื่อง (Body)</strong></p><ul><li>หน้าจอกระจก</li><li>กรอบอะลูมิเนียม</li><li>คุณสมบัติทนน้ำและระบบป้องกัน (Waterproof &amp; Resistance to dust)</li><li>- ทนน้ำได้ชั่วคราว</li><li>- ทนน้ำที่ความลึกไม่เกิน 1 เมตร</li><li>- ฝุ่นละออง (Resistance to dust)</li><li>มาตรฐาน IP58 / IP59</li><li>มีสีให้เลือก (Colors) : White, Gold, Brown</li></ul><p><strong>&nbsp;เครือข่าย (Network)</strong></p><ul><li>ใช้งาน Nano-SIM</li><li>รองรับ 2 ซิมการ์ด</li><li>เทคโนโลยีรับ/ส่งข้อมูล 3G , 4G, 5G</li><li><em>สมาร์ทโฟนที่ดีที่สุดโทรศัพท์ Honor</em></li></ul><p><strong>ระบบปฏิบัติการ (OS, CPU, GPU)</strong></p><ul><li>MagicOS 9 based on Android 15</li><li>CPU : Qualcomm : Snapdragon 8 Elite Octa Core</li><li>ความเร็ว : 4.32 GHz</li><li>GPU : Adreno 830</li><li>RAM 16GB, ROM 512GB</li></ul><p><strong>&nbsp;กล้องหลัง (Rear Camera)</strong></p><ul><li>กล้องดิจิตอล 50MP + 64MP (Periscope telephoto) + 50MP (Ultrawide) (Triple Camera)</li><li>- รูรับแสงขนาด ƒ/1.8</li><li>- ไฟแฟลช LED</li><li>- ซูมดิจิตอล 100 เท่า (100x Digital Zoom)</li><li>- ซูมออฟติคอล 3 เท่า (3x Optical Zoom)</li><li>- ขนาดภาพสูงสุด 9,216 x 6,912 พิกเซล (Image Size)</li></ul><p><strong>กล้องหน้า (Front Camera)</strong></p><ul><li>ความละเอียด 20MP</li><li>- กล้องหน้าตัวที่สอง 20MP</li><li>- รูรับแสงขนาด ƒ/2.42</li></ul><p><strong>&nbsp;บันทึกวิดีโอ (Video Recording)</strong></p><ul><li>บันทึกวิดีโอกล้องหลัง</li><li>- บันทึกวีดีโอระดับ UHD (4K), 30/60 เฟรมต่อวินาที</li><li>- ความละเอียด 3840 x 2160 พิกเซล</li><li>บันทึกวิดีโอกล้องหน้า</li><li>- บันทึกวีดีโอระดับ UHD (4K), 30 เฟรมต่อวินาที</li></ul><p><strong>&nbsp;เซ็นเซอร์ (Sensor)</strong></p><ul><li>ระบบตรวจสอบลายนิ้วมือ (Fingerprint)</li><li>ระบบหมุนภาพอัตโนมัติ (Accelerometer)</li></ul><p>&nbsp;<strong>เชื่อมต่อ</strong></p><ul><li>การหาตำแหน่ง: Assisted GPS</li><li>WiFi 802.11 a/b/g/n/ac/6e/7</li><li>- จุดกระจายสัญญาณอินเตอร์เน็ตแบบพกพา (Portable Wi-Fi Hotspot)</li><li>- เชื่อมต่อไร้สายระหว่างอุปกรณ์โดยตรง (Wi-Fi Direct)</li><li>- Dual band (2.4GHz / 5GHz)</li></ul><p><strong>มัลติมีเดีย</strong></p><ul><li>ระบบเสียง</li><li>- ลำโพงเสียงสเตอริโอ (Stereo speakers)</li></ul><p><strong>แบตเตอรี่ - ระบบชาร์จ</strong></p><ul><li>แบตเตอรี่ 5,820 mAh (Standard Battery)</li><li>- รองรับชาร์จไว 66W (Fast Charging)</li><li>- รองรับชาร์จไร้สาย 50W (Wireless Charging)</li><li>- การแบ่งแบตเตอรี่แบบไร้สาย (Wireless PowerShare)</li></ul>', '[{\"name\":\"White\",\"hex\":\"#ebebeb\"},{\"name\":\"Gold\",\"hex\":\"#deb882\"},{\"name\":\"Brown\",\"hex\":\"#926c2a\"}]', 0, 5, '2025-10-09 21:29:39', '2025-10-09 21:31:39');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `phone_id` bigint(20) UNSIGNED NOT NULL,
  `rating` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `body` text DEFAULT NULL,
  `status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`id`, `user_id`, `phone_id`, `rating`, `title`, `body`, `status`, `created_at`, `updated_at`) VALUES
(13, 1, 5, 2, 'กฟกห', 'wow sa', 'pending', '2025-10-09 02:30:16', '2025-10-09 23:21:08'),
(16, 3, 5, 5, NULL, 'ใช้ดีมากเลย', 'approved', '2025-10-09 06:48:52', '2025-10-09 22:16:23'),
(19, 4, 19, 5, NULL, 'น่าซื้อมากเลย', 'approved', '2025-10-09 21:50:48', '2025-10-09 22:16:18'),
(20, 5, 22, 5, NULL, 'ราคาดี', 'approved', '2025-10-09 22:06:58', '2025-10-09 22:16:29'),
(21, 5, 21, 5, NULL, 'บางมาก', 'approved', '2025-10-09 22:07:19', '2025-10-09 22:16:26'),
(22, 6, 22, 4, NULL, 'ดีมาก', 'approved', '2025-10-09 22:08:13', '2025-10-09 22:16:09'),
(23, 6, 21, 3, NULL, 'บางไปไหน', 'approved', '2025-10-09 22:09:34', '2025-10-09 22:16:04'),
(24, 6, 19, 3, NULL, 'แพง', 'rejected', '2025-10-09 22:09:55', '2025-10-09 22:16:00'),
(25, 1, 20, 5, NULL, 'ส้มเหมือนพระเลยครับ', 'approved', '2025-10-09 23:13:19', '2025-10-09 23:13:42'),
(26, 1, 14, 4, NULL, 'ฟหกฟกฟห', 'pending', '2025-10-10 01:32:09', '2025-10-10 01:32:09'),
(27, 3, 14, 5, NULL, 'ดีมาก', 'approved', '2025-10-10 01:33:30', '2025-10-10 01:36:45'),
(28, 3, 22, 5, 'ฟหกฟหก', NULL, 'pending', NULL, NULL),
(29, 3, 22, 5, 'ฟหกฟหก', NULL, 'pending', NULL, NULL),
(30, 3, 22, 5, 'ฟหกฟหก', NULL, 'pending', NULL, NULL),
(31, 3, 22, 5, 'ฟหกฟหก', NULL, 'pending', NULL, NULL),
(32, 3, 22, 5, 'ฟหกฟหก', NULL, 'pending', NULL, NULL),
(33, 3, 22, 5, 'ฟหกฟหก', NULL, 'pending', NULL, NULL),
(34, 3, 22, 5, 'ฟหกฟหก', NULL, 'pending', NULL, NULL),
(35, 3, 22, 5, 'ฟหกฟหก', NULL, 'pending', NULL, NULL),
(36, 3, 22, 5, 'ฟหกฟหก', NULL, 'pending', NULL, NULL),
(37, 3, 22, 5, 'ฟหกฟหก', NULL, 'pending', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('29rkdjbagg6dVQy8uQAbnTNXZjvAE6mKJhx363Zg', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoialNiN2FrazJOZHlrUWo5OHExMFlLWDJjb3YwYXpjZHlEdklrcWxFaSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzg6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi9jYXRlZ29yaWVzIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1760076626),
('BMXJrKGFxzoK259nmG370sDkHLi7074SXPTOeC4N', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiemg4RUFqdml2VU0xdTRab0hVcFZXT3Nwbjh6MXQ3THBkN1N1YVhKaCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9zdG9yYWdlL2F2YXRhcnMvMTc2MDA3MzU0OF9ibG9iIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1760085165),
('EHe27gBdrEsAG50hIJmTaG0eH64F6ppFmAcCT14z', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTXJncWFJUFFnTGdaMVY1VkQxSlJzaVhleXE1aDVOVTI0Z0hlRnREMSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1760086031),
('JKFISYF8m0DJAaV3IeWQod0JDXbMFITIar9f05u3', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRGNkdElJYnZKcVhYTGt4STk5NVB3RUEyVXMyZDd4UWhhN1dkVkM4NSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9wcm9maWxlIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1760186487),
('zcpaAJsv2o5uVyU4mivsEKO5ZsJo6ugCarS6n5yO', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaHNCc0xQRktWcXAwYTd0a2JOWjVkdWZLSVhqUUN2Z2dzQWRCd0JkOCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjg6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9waG9uZXMiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1760086031);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('user','admin') NOT NULL DEFAULT 'user',
  `status` enum('active','inactive','banned') NOT NULL DEFAULT 'active',
  `avatar_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `role`, `status`, `avatar_url`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'admin@gmail.com', '$2y$12$7Mn7.h4h1AQMjlCBW0uuEOHCWWDgLbyk9AhYcHwrcnofkNa0Qfkgi', 'admin', 'active', 'http://127.0.0.1:8000/storage/avatars/1760077432_blob', '2025-10-07 08:14:04', '2025-10-10 00:47:51'),
(3, 'user', 'user@gmail.com', '$2y$12$4AjCiG8vV7u9a16lqPmckuXMmMWl5ilrdlPtlpVZdeQQZHLUHefPa', 'user', 'banned', NULL, '2025-10-09 05:22:11', '2025-10-10 01:44:19'),
(4, 'user1', 'user1@gmail.com', '$2y$12$XuYkhY1LF269scmTMmA1fekxpoj6LzsQ3Q0NfVbYNpWI2Vk9qFGRq', 'user', 'active', 'http://127.0.0.1:8000/storage/avatars/1760072135_blob', '2025-10-09 21:34:46', '2025-10-09 21:55:35'),
(5, 'user2', 'user2@gmail.com', '$2y$12$rtm9WapbtZ4SSIxrUQ/H.e8Ldh65rND9CwgXho5B2G6CqvkXBsRom', 'user', 'active', NULL, '2025-10-09 21:35:10', '2025-10-09 21:35:10'),
(6, 'user3', 'user3@gmail.com', '$2y$12$2Eu5JS/BpjEtIIxZqc8Q8eEYBWR3B1hdOYMEZonATSYv/Ski1uiA.', 'user', 'active', NULL, '2025-10-09 21:35:36', '2025-10-09 21:35:36'),
(7, 'user4', 'user4@gmail.com', '$2y$12$2i7yNjWEBWI8eymbhNi12uzLxiPk8L1qHUJOx2J08qXOkt6jgY41C', 'user', 'active', NULL, '2025-10-09 21:36:01', '2025-10-09 21:36:01'),
(8, 'user5', 'user5@gmail.com', '$2y$12$XW4XP91o.53TEM3tOaHMGezNqWLXf5ztWwQcNwJRz5GKA5Fp4O72W', 'user', 'active', NULL, '2025-10-09 21:36:29', '2025-10-09 21:36:29'),
(9, 'user6', 'user6@gmail.com', '$2y$12$yW2G8eM14IBvZJbZL6rHx.UeeRh4aEjhhIi0RkwtPllRkNUqqW2FC', 'user', 'active', NULL, '2025-10-09 21:36:54', '2025-10-09 21:36:54'),
(10, 'user7', 'user7@gmail.com', '$2y$12$VID15/WUOaA9AbPedS79GeLbDoQce88DOErya4aSqAamADHu7duvO', 'user', 'active', NULL, '2025-10-09 21:37:44', '2025-10-09 21:37:44'),
(11, 'user8', 'user8@gmail.com', '$2y$12$Qi9svvfn5h/8Df.5nJMoP.OQ52cmI0VhadkqEGKNeI4cyAnXgwtsm', 'user', 'active', NULL, '2025-10-09 21:38:16', '2025-10-09 21:38:16'),
(12, 'user9', 'user9@gmail.com', '$2y$12$tEZwQLL3XtDzRjuLIUd1g.oK05Vln91EF/dsP4s1qZw5t5AwuMY1m', 'user', 'active', NULL, '2025-10-09 21:38:43', '2025-10-09 21:38:43'),
(14, 'user10', 'user10@gmail.com', '$2y$12$Jf1.ToEwWILwCzX86YCNi.dH1nNeQiq27BIXXnFNzpJHQ.6J7G/0a', 'user', 'active', NULL, '2025-10-09 23:39:38', '2025-10-09 23:39:38');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `comments_user_id_foreign` (`user_id`),
  ADD KEY `comments_review_id_foreign` (`review_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `images_phone_id_foreign` (`phone_id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `likes`
--
ALTER TABLE `likes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `likes_user_id_phone_id_unique` (`user_id`,`phone_id`),
  ADD KEY `likes_phone_id_foreign` (`phone_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Indexes for table `phones`
--
ALTER TABLE `phones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `phones_category_id_foreign` (`category_id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reviews_user_id_foreign` (`user_id`),
  ADD KEY `reviews_phone_id_foreign` (`phone_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `images`
--
ALTER TABLE `images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=186;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `likes`
--
ALTER TABLE `likes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `phones`
--
ALTER TABLE `phones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_review_id_foreign` FOREIGN KEY (`review_id`) REFERENCES `reviews` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `images`
--
ALTER TABLE `images`
  ADD CONSTRAINT `images_phone_id_foreign` FOREIGN KEY (`phone_id`) REFERENCES `phones` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `likes`
--
ALTER TABLE `likes`
  ADD CONSTRAINT `likes_phone_id_foreign` FOREIGN KEY (`phone_id`) REFERENCES `phones` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `likes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `phones`
--
ALTER TABLE `phones`
  ADD CONSTRAINT `phones_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_phone_id_foreign` FOREIGN KEY (`phone_id`) REFERENCES `phones` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reviews_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
