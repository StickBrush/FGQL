-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.2.11-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para fgql
CREATE DATABASE IF NOT EXISTS `fgql` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `fgql`;

-- Volcando estructura para tabla fgql.aka_name
CREATE TABLE IF NOT EXISTS `aka_name` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `char_ID` int(11) NOT NULL DEFAULT 0,
  `name` varchar(30) NOT NULL DEFAULT '0',
  `note` text DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `FK1` (`char_ID`),
  CONSTRAINT `FK1` FOREIGN KEY (`char_ID`) REFERENCES `character` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1 COMMENT='Alternative names for characters (full names, names in other countries...)\r\nID: Alternative name ID\r\nchar_ID: Character ID\r\nname: Alternative name\r\nnote: Alternative name type (full name, name in Japan...)';

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla fgql.alt_attack
CREATE TABLE IF NOT EXISTS `alt_attack` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `syntax_ID` int(11) NOT NULL DEFAULT 0,
  `attack_ID` int(11) NOT NULL DEFAULT 0,
  `command` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `FKAID` (`attack_ID`),
  KEY `FKSID` (`syntax_ID`),
  CONSTRAINT `FKAID` FOREIGN KEY (`attack_ID`) REFERENCES `attacks` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FKSID` FOREIGN KEY (`syntax_ID`) REFERENCES `alt_syntax` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Table to link attacks to their alternative syntax commands,\r\nID: Alternative command ID\r\nsyntax_ID: Syntax ID\r\nattack_ID: Attack ID\r\ncommand: Command for the attack in this alternative syntax';

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla fgql.alt_syntax
CREATE TABLE IF NOT EXISTS `alt_syntax` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Alternative syntaxes\r\nID: Alternative syntax ID\r\nname: Alternative syntax name';

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla fgql.attacks
CREATE TABLE IF NOT EXISTS `attacks` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `char_ID` int(11) NOT NULL,
  `startup` tinyint(3) unsigned NOT NULL,
  `active` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `recovery` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `block_adv` tinyint(4) NOT NULL DEFAULT 0,
  `knd_block` bit(1) NOT NULL DEFAULT b'0',
  `hit_adv` tinyint(4) NOT NULL DEFAULT 0,
  `knd_hit` bit(1) NOT NULL DEFAULT b'0',
  `counter_adv` tinyint(4) DEFAULT 0,
  `knd_counter` bit(1) DEFAULT b'0',
  `name` varchar(50) DEFAULT '0',
  `command` varchar(50) NOT NULL DEFAULT '0',
  `damage` smallint(5) unsigned NOT NULL DEFAULT 0,
  `stun` smallint(5) unsigned DEFAULT 0,
  `note` text DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `FK2` (`char_ID`),
  CONSTRAINT `FK2` FOREIGN KEY (`char_ID`) REFERENCES `character` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Attacks and moves\r\nID: Attack ID\r\nchar_ID: Character ID\r\nstartup: Startup frames\r\nactive: Active frames\r\nrecovery: Recovery frames\r\nblock_adv: Block advantage\r\nknd_block: Knockdown on block\r\nhit_adv: Hit advantage\r\nknd_hit: Knockdown on hit\r\ncounter_adv: Counter advantage\r\nknd_counter: Knockdown on counter\r\nname: Attack name\r\ncommand: Attack command\r\ndamage: Attack damage\r\nstun: Attack stun (leave it NULL if your FG doesn''t have stun)\r\nnote: Extra info';

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla fgql.character
CREATE TABLE IF NOT EXISTS `character` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=latin1 COMMENT='Characters\r\nID: Character ID\r\nname: Character name';

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla fgql.hitboxes
CREATE TABLE IF NOT EXISTS `hitboxes` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(20) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Índice 2` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COMMENT='Hitbox types (high, middle, low, overhead...)\r\nID: Hitbox type ID\r\ntype: Hitbox type name';

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla fgql.hitbox_info
CREATE TABLE IF NOT EXISTS `hitbox_info` (
  `ID` int(11) NOT NULL,
  `hitbox_ID` int(11) NOT NULL,
  `attack_ID` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FKHID` (`hitbox_ID`),
  KEY `FKATID` (`attack_ID`),
  CONSTRAINT `FKATID` FOREIGN KEY (`attack_ID`) REFERENCES `attacks` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FKHID` FOREIGN KEY (`hitbox_ID`) REFERENCES `hitboxes` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Link between hitboxes and attacks\r\nID: Hitbox info ID\r\nhitbox_ID: Hitbox type ID\r\nattack_ID: Attack ID';

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla fgql.properties
CREATE TABLE IF NOT EXISTS `properties` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `property_name` varchar(20) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Índice 2` (`property_name`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1 COMMENT='Properties of different attacks (invulnerability, invulnerable startup...)\r\nID: Property ID\r\nproperty_name: Property name';

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla fgql.property_info
CREATE TABLE IF NOT EXISTS `property_info` (
  `ID` int(11) NOT NULL,
  `property_ID` int(11) NOT NULL,
  `attack_ID` int(11) NOT NULL,
  `note` text DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FKPRID` (`property_ID`),
  KEY `FKPRAT` (`attack_ID`),
  CONSTRAINT `FKPRAT` FOREIGN KEY (`attack_ID`) REFERENCES `attacks` (`ID`),
  CONSTRAINT `FKPRID` FOREIGN KEY (`property_ID`) REFERENCES `properties` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Link between attacks and properties\r\nID: Property info ID\r\nproperty_ID: Property ID\r\nattack_ID: Attack ID\r\nnote: Extra info';

-- La exportación de datos fue deseleccionada.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
