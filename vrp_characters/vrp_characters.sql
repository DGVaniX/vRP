SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;


CREATE TABLE `vrp_characters` (
  `id` int(255) NOT NULL,
  `accID` int(255) NOT NULL,
  `charName` longtext NOT NULL,
  `charAge` int(255) NOT NULL,
  `cDate` varchar(255) NOT NULL,
  `lastLogin` varchar(255) NOT NULL,
  `facName` text NOT NULL,
  `facRank` text NOT NULL,
  `facLeader` int(255) NOT NULL,
  `skin` text NOT NULL,
  `inventory` text NOT NULL,
  `weapons` text NOT NULL,
  `x` float NOT NULL DEFAULT '-542.974',
  `y` float NOT NULL DEFAULT '-207.803',
  `z` float NOT NULL DEFAULT '37.6498',
  `rot` float NOT NULL DEFAULT '204.738',
  `health` int(255) NOT NULL DEFAULT '200',
  `hunger` int(255) NOT NULL DEFAULT '100',
  `thirst` int(255) NOT NULL DEFAULT '100',
  `wallet` int(255) NOT NULL DEFAULT '10000',
  `bank` int(255) NOT NULL DEFAULT '5000',
  `xzCoins` int(255) NOT NULL DEFAULT '0',
  `diamonds` int(255) NOT NULL DEFAULT '0',
  `transfer_limit` int(255) NOT NULL DEFAULT '1000000',
  `last_transfer_time` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE `vrp_characters`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `vrp_characters`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
