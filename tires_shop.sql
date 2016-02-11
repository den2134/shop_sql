-- phpMyAdmin SQL Dump
-- version 4.0.10.10
-- http://www.phpmyadmin.net
--
-- Хост: 127.0.0.1:3306
-- Время создания: Фев 11 2016 г., 19:05
-- Версия сервера: 5.5.45
-- Версия PHP: 5.6.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База данных: `tires_shop`
--

-- --------------------------------------------------------

--
-- Структура таблицы `Brands`
--

CREATE TABLE IF NOT EXISTS `Brands` (
  `id` smallint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(15) NOT NULL,
  `description` mediumtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `buyers`
--

CREATE TABLE IF NOT EXISTS `buyers` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `f_name` varchar(15) NOT NULL,
  `l_name` varchar(15) NOT NULL,
  `delivery_type` varchar(20) NOT NULL,
  `delivery_adress` varchar(50) NOT NULL,
  `phone_1` varchar(15) NOT NULL,
  `phone_2` varchar(15) DEFAULT NULL,
  `buyer_comment` varchar(150) DEFAULT NULL COMMENT 'Пожелание покупателя или вопрос при покупке товара',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `categories`
--

CREATE TABLE IF NOT EXISTS `categories` (
  `id` tinyint(2) unsigned NOT NULL AUTO_INCREMENT,
  `Parent_category` varchar(10) DEFAULT NULL COMMENT 'Родительськая категория если есть',
  `name` varchar(10) NOT NULL DEFAULT 'Шины' COMMENT 'Имя категории - шины, если будут другие категории, типа Диски и т.д.',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `comments`
--

CREATE TABLE IF NOT EXISTS `comments` (
  `id` smallint(3) unsigned NOT NULL AUTO_INCREMENT,
  `tires_id` smallint(3) unsigned NOT NULL,
  `comments_detail_id` smallint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `comments_detail_id` (`comments_detail_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `comments_detail`
--

CREATE TABLE IF NOT EXISTS `comments_detail` (
  `id` smallint(3) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(10) NOT NULL,
  `user_email` varchar(20) NOT NULL,
  `user_comment` varchar(150) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `load_index`
--

CREATE TABLE IF NOT EXISTS `load_index` (
  `id` tinyint(2) unsigned NOT NULL AUTO_INCREMENT,
  `number` tinyint(3) unsigned NOT NULL,
  `weight` mediumint(4) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `orders`
--

CREATE TABLE IF NOT EXISTS `orders` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `buyer_id` mediumint(8) unsigned NOT NULL,
  `vendors_id` tinyint(2) unsigned NOT NULL,
  `order_date` datetime NOT NULL,
  `delivery_date` date NOT NULL,
  `delivery_check` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Доставлен товара или нет',
  `comment` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `buyer_id` (`buyer_id`),
  KEY `vendors_id` (`vendors_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `orders_detail`
--

CREATE TABLE IF NOT EXISTS `orders_detail` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `orders_id` mediumint(8) unsigned NOT NULL,
  `tires_id` smallint(3) unsigned NOT NULL,
  `tires_count` tinyint(3) unsigned NOT NULL,
  `amount` decimal(10,2) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `orders_id` (`orders_id`),
  KEY `tires_id` (`tires_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `speed_index`
--

CREATE TABLE IF NOT EXISTS `speed_index` (
  `id` tinyint(2) unsigned NOT NULL AUTO_INCREMENT,
  `marker` varchar(5) NOT NULL,
  `value` smallint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `supplier`
--

CREATE TABLE IF NOT EXISTS `supplier` (
  `id` tinyint(2) unsigned NOT NULL AUTO_INCREMENT,
  `firm_name` varchar(15) NOT NULL,
  `adress` varchar(50) NOT NULL,
  `phone_1` varchar(10) NOT NULL,
  `phone_2` varchar(10) DEFAULT NULL,
  `short_description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `tires`
--

CREATE TABLE IF NOT EXISTS `tires` (
  `id` smallint(3) unsigned NOT NULL AUTO_INCREMENT,
  `model` varchar(10) NOT NULL,
  `brand_id` smallint(3) unsigned NOT NULL,
  `season` tinyint(1) unsigned NOT NULL,
  `auto_type` varchar(10) NOT NULL,
  `width` smallint(3) unsigned NOT NULL,
  `prof` tinyint(3) unsigned NOT NULL,
  `diametr` tinyint(2) unsigned NOT NULL,
  `speed_index_id` tinyint(2) unsigned NOT NULL COMMENT 'Индекс скорости(маркер, ограничение)',
  `load_index_id` tinyint(2) unsigned NOT NULL COMMENT 'Нидекс нагрузки(номер, предел)',
  `thorns` tinyint(1) NOT NULL DEFAULT '0',
  `param` varchar(6) DEFAULT NULL COMMENT 'Дополнительные параметры',
  `descript` tinytext COMMENT 'Описание',
  `category_id` tinyint(2) unsigned NOT NULL COMMENT 'Категория - шины',
  `supplier_id` tinyint(2) unsigned NOT NULL,
  `suplier_price_per_one` decimal(6,2) unsigned NOT NULL,
  `price_per_one` decimal(5,2) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `brand_id` (`brand_id`),
  KEY `speed_index_id` (`speed_index_id`),
  KEY `load_index_id` (`load_index_id`),
  KEY `supplier_id` (`supplier_id`),
  KEY `category_id` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `vendors`
--

CREATE TABLE IF NOT EXISTS `vendors` (
  `id` tinyint(2) unsigned NOT NULL AUTO_INCREMENT,
  `f_name` varchar(10) NOT NULL,
  `l_name` varchar(10) NOT NULL,
  `descr` varchar(100) DEFAULT NULL COMMENT 'Краткая информация о продавце, если нужно',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`comments_detail_id`) REFERENCES `comments_detail` (`id`);

--
-- Ограничения внешнего ключа таблицы `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`vendors_id`) REFERENCES `vendors` (`id`),
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`buyer_id`) REFERENCES `buyers` (`id`);

--
-- Ограничения внешнего ключа таблицы `orders_detail`
--
ALTER TABLE `orders_detail`
  ADD CONSTRAINT `orders_detail_ibfk_1` FOREIGN KEY (`orders_id`) REFERENCES `orders` (`id`),
  ADD CONSTRAINT `orders_detail_ibfk_2` FOREIGN KEY (`tires_id`) REFERENCES `tires` (`id`);

--
-- Ограничения внешнего ключа таблицы `tires`
--
ALTER TABLE `tires`
  ADD CONSTRAINT `tires_ibfk_7` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `tires_ibfk_1` FOREIGN KEY (`brand_id`) REFERENCES `Brands` (`id`),
  ADD CONSTRAINT `tires_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `tires_ibfk_3` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`id`),
  ADD CONSTRAINT `tires_ibfk_4` FOREIGN KEY (`speed_index_id`) REFERENCES `speed_index` (`id`),
  ADD CONSTRAINT `tires_ibfk_5` FOREIGN KEY (`load_index_id`) REFERENCES `load_index` (`id`),
  ADD CONSTRAINT `tires_ibfk_6` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
