-- USE DATABASE demo;

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `country` (
  `Code` CHAR(3) NOT NULL DEFAULT '',
  `Name` CHAR(52) NOT NULL DEFAULT '',
  `Continent` enum('Asia','Europe','North America','Africa','Oceania','Antarctica','South America') NOT NULL DEFAULT 'Asia',
  `Region` CHAR(26) NOT NULL DEFAULT '',
  `SurfaceArea` FLOAT(10,2) NOT NULL DEFAULT '0.00',
  `IndepYear` SMALLINT(6) DEFAULT NULL,
  `Population` INT(11) NOT NULL DEFAULT '0',
  `LifeExpectancy` FLOAT(3,1) DEFAULT NULL,
  `GNP` FLOAT(10,2) DEFAULT NULL,
  `GNPOld` FLOAT(10,2) DEFAULT NULL,
  `LocalName` CHAR(45) NOT NULL DEFAULT '',
  `GovernmentForm` CHAR(45) NOT NULL DEFAULT '',
  `HeadOfState` CHAR(60) DEFAULT NULL,
  `Capital` INT(11) DEFAULT NULL,
  `Code2` CHAR(2) NOT NULL DEFAULT '',
  PRIMARY KEY (`Code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country`
--
-- ORDER BY:  `Code`

INSERT INTO `country` VALUES ('ABW','Aruba','North America','Caribbean',193.00,NULL,103000,78.4,828.00,793.00,'Aruba','Nonmetropolitan Territory of The Netherlands','Beatrix',129,'AW');
INSERT INTO `country` VALUES ('AFG','Afghanistan','Asia','Southern and Central Asia',652090.00,1919,22720000,45.9,5976.00,NULL,'Afganistan/Afqanestan','Islamic Emirate','Mohammad Omar',1,'AF');
INSERT INTO `country` VALUES ('AGO','Angola','Africa','Central Africa',1246700.00,1975,12878000,38.3,6648.00,7984.00,'Angola','Republic','Jos� Eduardo dos Santos',56,'AO');
INSERT INTO `country` VALUES ('AIA','Anguilla','North America','Caribbean',96.00,NULL,8000,76.1,63.20,NULL,'Anguilla','Dependent Territory of the UK','Elisabeth II',62,'AI');
INSERT INTO `country` VALUES ('ALB','Albania','Europe','Southern Europe',28748.00,1912,3401200,71.6,3205.00,2500.00,'Shqip�ria','Republic','Rexhep Mejdani',34,'AL');
INSERT INTO `country` VALUES ('AND','Andorra','Europe','Southern Europe',468.00,1278,78000,83.5,1630.00,NULL,'Andorra','Parliamentary Coprincipality','',55,'AD');
INSERT INTO `country` VALUES ('ANT','Netherlands Antilles','North America','Caribbean',800.00,NULL,217000,74.7,1941.00,NULL,'Nederlandse Antillen','Nonmetropolitan Territory of The Netherlands','Beatrix',33,'AN');
INSERT INTO `country` VALUES ('ARE','United Arab Emirates','Asia','Middle East',83600.00,1971,2441000,74.1,37966.00,36846.00,'Al-Imarat al-�Arabiya al-Muttahida','Emirate Federation','Zayid bin Sultan al-Nahayan',65,'AE');
INSERT INTO `country` VALUES ('ARG','Argentina','South America','South America',2780400.00,1816,37032000,75.1,340238.00,323310.00,'Argentina','Federal Republic','Fernando de la R�a',69,'AR');
INSERT INTO `country` VALUES ('ARM','Armenia','Asia','Middle East',29800.00,1991,3520000,66.4,1813.00,1627.00,'Hajastan','Republic','Robert Kot�arjan',126,'AM');
INSERT INTO `country` VALUES ('ASM','American Samoa','Oceania','Polynesia',199.00,NULL,68000,75.1,334.00,NULL,'Amerika Samoa','US Territory','George W. Bush',54,'AS');
INSERT INTO `country` VALUES ('ATA','Antarctica','Antarctica','Antarctica',13120000.00,NULL,0,NULL,0.00,NULL,'�','Co-administrated','',NULL,'AQ');
INSERT INTO `country` VALUES ('ATF','French Southern territories','Antarctica','Antarctica',7780.00,NULL,0,NULL,0.00,NULL,'Terres australes fran�aises','Nonmetropolitan Territory of France','Jacques Chirac',NULL,'TF');
INSERT INTO `country` VALUES ('ATG','Antigua and Barbuda','North America','Caribbean',442.00,1981,68000,70.5,612.00,584.00,'Antigua and Barbuda','Constitutional Monarchy','Elisabeth II',63,'AG');
INSERT INTO `country` VALUES ('AUS','Australia','Oceania','Australia and New Zealand',7741220.00,1901,18886000,79.8,351182.00,392911.00,'Australia','Constitutional Monarchy, Federation','Elisabeth II',135,'AU');
INSERT INTO `country` VALUES ('AUT','Austria','Europe','Western Europe',83859.00,1918,8091800,77.7,211860.00,206025.00,'�sterreich','Federal Republic','Thomas Klestil',1523,'AT');
INSERT INTO `country` VALUES ('AZE','Azerbaijan','Asia','Middle East',86600.00,1991,7734000,62.9,4127.00,4100.00,'Az�rbaycan','Federal Republic','Heyd�r �liyev',144,'AZ');
INSERT INTO `country` VALUES ('BDI','Burundi','Africa','Eastern Africa',27834.00,1962,6695000,46.2,903.00,982.00,'Burundi/Uburundi','Republic','Pierre Buyoya',552,'BI');
INSERT INTO `country` VALUES ('BEL','Belgium','Europe','Western Europe',30518.00,1830,10239000,77.8,249704.00,243948.00,'Belgi�/Belgique','Constitutional Monarchy, Federation','Albert II',179,'BE');
INSERT INTO `country` VALUES ('BEN','Benin','Africa','Western Africa',112622.00,1960,6097000,50.2,2357.00,2141.00,'B�nin','Republic','Mathieu K�r�kou',187,'BJ');
INSERT INTO `country` VALUES ('BFA','Burkina Faso','Africa','Western Africa',274000.00,1960,11937000,46.7,2425.00,2201.00,'Burkina Faso','Republic','Blaise Compaor�',549,'BF');
INSERT INTO `country` VALUES ('BGD','Bangladesh','Asia','Southern and Central Asia',143998.00,1971,129155000,60.2,32852.00,31966.00,'Bangladesh','Republic','Shahabuddin Ahmad',150,'BD');
INSERT INTO `country` VALUES ('BGR','Bulgaria','Europe','Eastern Europe',110994.00,1908,8190900,70.9,12178.00,10169.00,'Balgarija','Republic','Petar Stojanov',539,'BG');
INSERT INTO `country` VALUES ('BHR','Bahrain','Asia','Middle East',694.00,1971,617000,73.0,6366.00,6097.00,'Al-Bahrayn','Monarchy (Emirate)','Hamad ibn Isa al-Khalifa',149,'BH');
INSERT INTO `country` VALUES ('BHS','Bahamas','North America','Caribbean',13878.00,1973,307000,71.1,3527.00,3347.00,'The Bahamas','Constitutional Monarchy','Elisabeth II',148,'BS');
INSERT INTO `country` VALUES ('BIH','Bosnia and Herzegovina','Europe','Southern Europe',51197.00,1992,3972000,71.5,2841.00,NULL,'Bosna i Hercegovina','Federal Republic','Ante Jelavic',201,'BA');
INSERT INTO `country` VALUES ('BLR','Belarus','Europe','Eastern Europe',207600.00,1991,10236000,68.0,13714.00,NULL,'Belarus','Republic','Aljaksandr Luka�enka',3520,'BY');
INSERT INTO `country` VALUES ('BLZ','Belize','North America','Central America',22696.00,1981,241000,70.9,630.00,616.00,'Belize','Constitutional Monarchy','Elisabeth II',185,'BZ');
