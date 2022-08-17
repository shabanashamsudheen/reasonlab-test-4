-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Aug 17, 2022 at 01:01 PM
-- Server version: 10.4.13-MariaDB
-- PHP Version: 7.3.21
DROP database IF EXISTS `test`;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Database: `test`
--

-- --------------------------------------------------------

--
-- Table structure for table `dough_chef`
--
create database `test`;
USE `test`;
DROP TABLE IF EXISTS `dough_chef`;
CREATE TABLE  `dough_chef` (
  `dc_id` int(11)  AUTO_INCREMENT,
  `status` int(11)  DEFAULT 0,
  PRIMARY KEY (`dc_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

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
CREATE TABLE  `dough_data` (
  `dough_id` int(11)  AUTO_INCREMENT,
  `order_id` int(11) ,
  `status` int(11)  DEFAULT 0,
  `chef_id` int(11) DEFAULT NULL,
  `created_at` timestamp  DEFAULT current_timestamp(),
  `updated_at` timestamp  DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`dough_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
CREATE TABLE  `orders` (
  `order_id` int(11)  AUTO_INCREMENT,
  `pizza_name` varchar(30) DEFAULT NULL,
  `toppings` text DEFAULT NULL,
  `status` int(11) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `oven_data`
--

DROP TABLE IF EXISTS `oven_data`;
CREATE TABLE  `oven_data` (
  `oven_id` int(11)  AUTO_INCREMENT,
  `order_id` int(11) ,
  `status` int(11)  DEFAULT 0,
  `created_at` timestamp  DEFAULT current_timestamp(),
  `updated_at` timestamp  DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`oven_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `serving_data`
--

DROP TABLE IF EXISTS `serving_data`;
CREATE TABLE  `serving_data` (
  `serve_id` int(11)  AUTO_INCREMENT,
  `order_id` int(11) ,
  `status` int(11)  DEFAULT 0,
  `waiter_id` int(11) ,
  `created_at` timestamp  DEFAULT current_timestamp(),
  `updated_at` timestamp  DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`serve_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `topping_chef`
--

DROP TABLE IF EXISTS `topping_chef`;
CREATE TABLE  `topping_chef` (
  `tc_id` int(11)  AUTO_INCREMENT,
  `status` int(11)  DEFAULT 0,
  PRIMARY KEY (`tc_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

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
CREATE TABLE  `topping_data` (
  `topping_id` int(11)  AUTO_INCREMENT,
  `topping` varchar(30) DEFAULT NULL,
  `order_id` int(11) ,
  `status` int(11)  DEFAULT 0,
  `chef_id` int(11) DEFAULT NULL,
  `created_at` timestamp  DEFAULT current_timestamp(),
  `updated_at` timestamp  DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`topping_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `waiters`
--

DROP TABLE IF EXISTS `waiters`;
CREATE TABLE  `waiters` (
  `w_id` int(11)  AUTO_INCREMENT,
  `status` int(11)  DEFAULT 0,
  PRIMARY KEY (`w_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `waiters`
--

INSERT INTO `waiters` (`w_id`, `status`) VALUES
(1, 0),
(2, 0);
COMMIT;
flush privileges;

