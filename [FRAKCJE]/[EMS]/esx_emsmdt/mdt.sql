CREATE TABLE IF NOT EXISTS `emsmdt_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255)  DEFAULT NULL,
  `patient` varchar(255) DEFAULT 'Brak',
  `doctor` varchar(255) CHARACTER SET utf8mb4 DEFAULT 'Brak',
  `reason` longtext,
  `fee` int DEFAULT '0',
  `date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

CREATE TABLE IF NOT EXISTS `emsmdt_karta_notatki` (
  `id` int NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `notatka` longtext NOT NULL,
  `doctor` varchar(255) CHARACTER SET utf8mb4 NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `emsmdt_notatki` (
  `id` int NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL DEFAULT '0',
  `notatka` text CHARACTER SET utf8mb4,
  PRIMARY KEY (`id`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `emsmdt_ogloszenia` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fp` varchar(255) DEFAULT NULL,
  `ogloszenie` longtext NOT NULL,
  `date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- Dumping structure for table piraterp.emsmdt_raporty
CREATE TABLE IF NOT EXISTS `emsmdt_raporty` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fp` varchar(255) DEFAULT NULL,
  `raport` longtext NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
