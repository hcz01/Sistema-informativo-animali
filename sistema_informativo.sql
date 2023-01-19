-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- 主机： 127.0.0.1
-- 生成日期： 2023-01-19 21:26:02
-- 服务器版本： 10.4.27-MariaDB
-- PHP 版本： 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 数据库： `sistema_informativo`
--

-- --------------------------------------------------------

--
-- 表的结构 `animale`
--

CREATE TABLE `animale` (
  `id_animale` int(11) NOT NULL,
  `id_Specie` int(11) NOT NULL,
  `id_parco` int(11) NOT NULL,
  `Nome_animale` varchar(255) DEFAULT NULL,
  `Stato_salute` varchar(255) DEFAULT NULL,
  `Data_di_nascita` date NOT NULL,
  `Sesso` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `animale`
--

INSERT INTO `animale` (`id_animale`, `id_Specie`, `id_parco`, `Nome_animale`, `Stato_salute`, `Data_di_nascita`, `Sesso`) VALUES
(1, 1, 1, 'Pipo', 'Bene', '2014-01-01', 'M'),
(2, 2, 1, 'Carlo', 'Male', '2017-01-11', 'F'),
(3, 3, 1, 'Giada', 'Bene', '2013-01-01', 'F'),
(4, 2, 1, 'Tinta', 'Bene', '2022-11-15', 'F');

-- --------------------------------------------------------

--
-- 表的结构 `guardiaparco`
--

CREATE TABLE `guardiaparco` (
  `id_parco` int(11) NOT NULL,
  `id_guardia` int(11) NOT NULL,
  `Nome` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- 表的结构 `ordine`
--

CREATE TABLE `ordine` (
  `Id_Ordine` int(11) NOT NULL,
  `Nome_ordine` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `ordine`
--

INSERT INTO `ordine` (`Id_Ordine`, `Nome_ordine`) VALUES
(1, 'Mammiferi'),
(2, 'Eucarioti'),
(3, 'Carnivoli');

-- --------------------------------------------------------

--
-- 表的结构 `parco`
--

CREATE TABLE `parco` (
  `Id_parco` int(11) NOT NULL,
  `Nome` varchar(255) NOT NULL,
  `Regione` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `parco`
--

INSERT INTO `parco` (`Id_parco`, `Nome`, `Regione`) VALUES
(1, 'Amari', 'Lombardia'),
(2, 'Cicchio', 'Lombardia');

-- --------------------------------------------------------

--
-- 表的结构 `specie`
--

CREATE TABLE `specie` (
  `id_specie` int(11) NOT NULL,
  `Nome_specie` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `specie`
--

INSERT INTO `specie` (`id_specie`, `Nome_specie`) VALUES
(1, 'Cane'),
(2, 'Gatto'),
(3, 'Orso');

--
-- 转储表的索引
--

--
-- 表的索引 `animale`
--
ALTER TABLE `animale`
  ADD PRIMARY KEY (`id_animale`),
  ADD KEY `animale-parco` (`id_parco`),
  ADD KEY `animale-specie` (`id_Specie`);

--
-- 表的索引 `guardiaparco`
--
ALTER TABLE `guardiaparco`
  ADD PRIMARY KEY (`id_guardia`);

--
-- 表的索引 `ordine`
--
ALTER TABLE `ordine`
  ADD PRIMARY KEY (`Id_Ordine`,`Nome_ordine`);

--
-- 表的索引 `parco`
--
ALTER TABLE `parco`
  ADD PRIMARY KEY (`Id_parco`,`Nome`);

--
-- 表的索引 `specie`
--
ALTER TABLE `specie`
  ADD PRIMARY KEY (`id_specie`,`Nome_specie`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `animale`
--
ALTER TABLE `animale`
  MODIFY `id_animale` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- 使用表AUTO_INCREMENT `guardiaparco`
--
ALTER TABLE `guardiaparco`
  MODIFY `id_guardia` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `ordine`
--
ALTER TABLE `ordine`
  MODIFY `Id_Ordine` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- 使用表AUTO_INCREMENT `parco`
--
ALTER TABLE `parco`
  MODIFY `Id_parco` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- 使用表AUTO_INCREMENT `specie`
--
ALTER TABLE `specie`
  MODIFY `id_specie` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- 限制导出的表
--

--
-- 限制表 `animale`
--
ALTER TABLE `animale`
  ADD CONSTRAINT `animale-parco` FOREIGN KEY (`id_parco`) REFERENCES `parco` (`Id_parco`),
  ADD CONSTRAINT `animale-specie` FOREIGN KEY (`id_Specie`) REFERENCES `specie` (`id_specie`);

--
-- 限制表 `specie`
--
ALTER TABLE `specie`
  ADD CONSTRAINT `specie-ordine` FOREIGN KEY (`id_specie`) REFERENCES `ordine` (`Id_Ordine`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
