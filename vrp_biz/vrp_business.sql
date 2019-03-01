CREATE TABLE `vrp_business` (
  `id` int(255) NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `bizName` text CHARACTER SET latin1 NOT NULL,
  `bizDescription` text CHARACTER SET latin1 NOT NULL,
  `bizPrice` int(255) NOT NULL DEFAULT '0',
  `bizType` text CHARACTER SET latin1 NOT NULL,
  `bizCashier` bigint(255) NOT NULL DEFAULT '0',
  `bizSupplies` int(255) NOT NULL DEFAULT '75',
  `bizOwner` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `bizOwnerID` int(255) NOT NULL,
  `bizForSale` int(255) NOT NULL DEFAULT '0',
  `bizSalePrice` int(255) NOT NULL,
  `bizStrikes` int(255) NOT NULL DEFAULT '0',
  `bizImunity` int(255) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `vrp_business`
  ADD PRIMARY KEY (`id`);
  
ALTER TABLE `vrp_business`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;