CREATE TABLE IF NOT EXISTS `lscmdt_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) DEFAULT NULL,
  `client` varchar(255) CHARACTER SET utf8 DEFAULT 'Brak',
  `mechanic` varchar(255) CHARACTER SET utf8mb4 DEFAULT 'Brak',
  `reason` longtext,
  `fee` int DEFAULT '0',
  `date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE IF NOT EXISTS `lscmdt_karta_notatki` (
  `id` int NOT NULL AUTO_INCREMENT,
  `identifier`  varchar(255) NOT NULL,
  `notatka` longtext NOT NULL,
  `mechanic` varchar(255) CHARACTER SET utf8mb4 NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `lscmdt_notatki` (
  `id` int NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL DEFAULT '0',
  `notatka` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  PRIMARY KEY (`id`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

CREATE TABLE IF NOT EXISTS `lscmdt_ogloszenia` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mechanic` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `ogloszenie` longtext NOT NULL,
  `date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `lscmdt_raporty` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mechanic` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `raport` longtext NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;