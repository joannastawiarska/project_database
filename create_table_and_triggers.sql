CREATE DATABASE car_rental;
USE car_rental;

CREATE TABLE `address`(
  `address_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(20) NOT NULL,
  `post_code` VARCHAR(10) NOT NULL,
  `city` VARCHAR(20) NOT NULL,
  `region` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`address_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `client` (
  `client_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `surname` VARCHAR(100) NOT NULL,
  `phone_number` VARCHAR(20) NOT NULL,
  `card_number` VARCHAR(22) NOT NULL,
  `address_ID` int(10) unsigned NOT NULL,
  `date_birth` DATE,
  `email` VARCHAR(45) NOT NULL,
  FOREIGN KEY addressFK(address_ID) REFERENCES address(address_ID),
  PRIMARY KEY (`client_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `car` (
  `car_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(20)  NOT NULL,
  `make` VARCHAR(20) NOT NULL,
  `production_year` int(4)  NOT NULL,
  `color` VARCHAR(20) NOT NULL,
  `engine` DECIMAL(3,1)  NOT NULL,
  `power` int(15) NOT NULL,
  `mileage` DECIMAL(8,1),
  PRIMARY KEY (`car_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `agency` (
 `agency_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
 `phone_number` VARCHAR(20) NOT NULL,
 `email` VARCHAR(45) NOT NULL,
 `address_ID` int(10) unsigned NOT NULL,
  FOREIGN KEY addressFK(address_ID) REFERENCES address(address_ID),
  PRIMARY KEY (`agency_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `worker_position` (
 `position_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
 `name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`position_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `worker` (
`worker_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
`name` VARCHAR(15) NOT NULL,
`surname` VARCHAR(25) NOT NULL,
`date_birth` DATE,
`address_ID` int(10) unsigned NOT NULL,
`position_ID` int(10) unsigned NOT NULL,
`agency_ID` int(10) unsigned NOT NULL,
FOREIGN KEY addressFK(address_ID) REFERENCES address(address_ID),
FOREIGN KEY positionFK(position_ID) REFERENCES worker_position(position_ID),
FOREIGN KEY agencyFK(agency_ID) REFERENCES agency(agency_ID),
PRIMARY KEY (`worker_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `rent` (
`rent_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
`client_ID` int(10) unsigned NOT NULL,
`car_ID` int(10) unsigned NOT NULL,
`agency_from_ID` int(10) unsigned NOT NULL,
`agency_to_ID` int(10) unsigned NOT NULL,
`date_rent` DATE,
`date_return` DATE,
`cost` FLOAT,
INDEX indeks_client (client_ID),
INDEX indeks_car (car_ID),
FOREIGN KEY clientFK(client_ID) REFERENCES client(client_ID),
FOREIGN KEY carFK(car_ID) REFERENCES car(car_ID),
FOREIGN KEY agency_fromFK(agency_from_ID) REFERENCES agency(agency_ID),
FOREIGN KEY agency_toFK(agency_to_ID) REFERENCES agency(agency_ID),
PRIMARY KEY (`rent_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `carer` (
  `car_ID` int(10) unsigned NOT NULL,
  `worker_ID` int(10) unsigned NOT NULL,
  PRIMARY KEY (car_ID, worker_ID),
  CONSTRAINT carFK FOREIGN KEY(car_ID) REFERENCES car(car_ID),
  CONSTRAINT workerFK FOREIGN KEY(worker_ID) REFERENCES worker(worker_ID)
  );
  
DELIMITER $$
CREATE TRIGGER update_controller
BEFORE UPDATE ON car_rental.rent
FOR EACH ROW BEGIN
 
IF
NEW.cost < 100 THEN
SET NEW.cost = 100;
END IF;
END;$$

DELIMITER $$
CREATE TRIGGER insert_controller
BEFORE INSERT ON car_rental.rent
FOR EACH ROW BEGIN
 
IF
NEW.cost < 100 THEN
SET NEW.cost = 100;
END IF;
END;$$