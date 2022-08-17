-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Aug 17, 2022 at 01:01 PM
-- Server version: 10.4.13-MariaDB
-- PHP Version: 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pizza_test_4`
--

-- --------------------------------------------------------

--
-- Table structure for table `dough_chef`
--

DROP TABLE IF EXISTS `dough_chef`;
CREATE TABLE IF NOT EXISTS `dough_chef` (
  `dc_id` int(11) NOT NULL AUTO_INCREMENT,
  `status` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`dc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `dough_chef`
--

INSERT INTO `dough_chef` (`dc_id`, `status`) VALUES
(1, 0),
(2, 0);

-- --------------------------------------------------------

--
-- Table structure for table `dough_data`
--

DROP TABLE IF EXISTS `dough_data`;
CREATE TABLE IF NOT EXISTS `dough_data` (
  `dough_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `chef_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`dough_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
CREATE TABLE IF NOT EXISTS `orders` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `pizza_name` varchar(30) DEFAULT NULL,
  `toppings` text DEFAULT NULL,
  `status` int(11) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `oven_data`
--

DROP TABLE IF EXISTS `oven_data`;
CREATE TABLE IF NOT EXISTS `oven_data` (
  `oven_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`oven_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `serving_data`
--

DROP TABLE IF EXISTS `serving_data`;
CREATE TABLE IF NOT EXISTS `serving_data` (
  `serve_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `waiter_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`serve_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `topping_chef`
--

DROP TABLE IF EXISTS `topping_chef`;
CREATE TABLE IF NOT EXISTS `topping_chef` (
  `tc_id` int(11) NOT NULL AUTO_INCREMENT,
  `status` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`tc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `topping_chef`
--

INSERT INTO `topping_chef` (`tc_id`, `status`) VALUES
(1, 0),
(2, 0),
(3, 0);

-- --------------------------------------------------------

--
-- Table structure for table `topping_data`
--

DROP TABLE IF EXISTS `topping_data`;
CREATE TABLE IF NOT EXISTS `topping_data` (
  `topping_id` int(11) NOT NULL AUTO_INCREMENT,
  `topping` varchar(30) DEFAULT NULL,
  `order_id` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `chef_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`topping_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `waiters`
--

DROP TABLE IF EXISTS `waiters`;
CREATE TABLE IF NOT EXISTS `waiters` (
  `w_id` int(11) NOT NULL AUTO_INCREMENT,
  `status` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`w_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `waiters`
--

INSERT INTO `waiters` (`w_id`, `status`) VALUES
(1, 0),
(2, 0);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
