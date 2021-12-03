-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Login`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Login` (
  `Login_Username` VARCHAR(45) NOT NULL,
  `Login_Pass` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Login_Username`, `Login_Pass`))
ENGINE = InnoDB;

insert into Login values 
#('jsmith','123'),
#('mjones','567'),
#('jdresdon','891')
('ptrevor','pass'),
('jirons','word')
;

select *
from Login;
-- -----------------------------------------------------
-- Table `mydb`.`Admin`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`admin` (
  `Admin_ID` INT NOT NULL,
  `Admin_Fname` VARCHAR(45) NULL,
  `Admin_Lname` VARCHAR(45) NULL,
  `Login_Login_Username` VARCHAR(45) NOT NULL,
  `Login_Login_Pass` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Admin_ID`, `Login_Login_Username`, `Login_Login_Pass`),
  INDEX `fk_Admin_Login1_idx` (`Login_Login_Username` ASC, `Login_Login_Pass` ASC) VISIBLE,
  CONSTRAINT `fk_Admin_Login1`
    FOREIGN KEY (`Login_Login_Username` , `Login_Login_Pass`)
    REFERENCES `mydb`.`Login` (`Login_Username` , `Login_Pass`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

insert into admin values(
'101', 'Jeff', 'Smith', 'jsmith','123'
);

select * 
from admin;

-- -----------------------------------------------------
-- Table `mydb`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Employee` (
  `Employee_ID` INT NOT NULL,
  `Employee_Fname` VARCHAR(45) NULL,
  `Employee_Lname` VARCHAR(45) NULL,
  `Admin_Admin_ID` INT NOT NULL,
  `Login_Login_Username` VARCHAR(45) NOT NULL,
  `Login_Login_Pass` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Employee_ID`, `Login_Login_Username`, `Login_Login_Pass`),
  INDEX `fk_Employee_Admin1_idx` (`Admin_Admin_ID` ASC) VISIBLE,
  INDEX `fk_Employee_Login1_idx` (`Login_Login_Username` ASC, `Login_Login_Pass` ASC) VISIBLE,
  CONSTRAINT `fk_Employee_Admin1`
    FOREIGN KEY (`Admin_Admin_ID`)
    REFERENCES `mydb`.`Admin` (`Admin_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Employee_Login1`
    FOREIGN KEY (`Login_Login_Username` , `Login_Login_Pass`)
    REFERENCES `mydb`.`Login` (`Login_Username` , `Login_Pass`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

insert into Employee values(
'201', 'Mark', 'Jones', '101', 'mjones','567'
),('202', 'Jane', 'Dresden','101', 'jdresdon','891');

select * from Employee;

-- -----------------------------------------------------
-- Table `mydb`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Customer` (
  `Customer_ID` INT NOT NULL,
  `Customer_Fname` VARCHAR(45) NULL,
  `Customer_Lname` VARCHAR(45) NULL,
  `Customer_Email` VARCHAR(45) NULL,
  `Customer_Phone` INT(10) NULL,
  `Login_Login_Username` VARCHAR(45) NOT NULL,
  `Login_Login_Pass` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Customer_ID`, `Login_Login_Username`, `Login_Login_Pass`),
  INDEX `fk_Customer_Login1_idx` (`Login_Login_Username` ASC, `Login_Login_Pass` ASC) VISIBLE,
  CONSTRAINT `fk_Customer_Login1`
    FOREIGN KEY (`Login_Login_Username` , `Login_Login_Pass`)
    REFERENCES `mydb`.`Login` (`Login_Username` , `Login_Pass`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
insert into Customer values
('301', 'Paul', 'Trevor', 'pt@email.com','555555555','ptrevor', 'pass'),
('302', 'Jack', 'Irons','ji@email.com', '666666666', 'jirons', 'word'),
('303', 'John', 'Deere', 'jd@email.com','777777777', 'jdeere', 'password'),
('304', 'Mike', 'Rogers', 'mr@email.com','888888888', 'mrogers', 'space');

select *
from Customer;
-- -----------------------------------------------------
-- Table `mydb`.`Order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`orders` (
  `Orders_ID` INT NOT NULL,
  `Orders_Date` DATE NULL,
  `Orders_Total` FLOAT NULL,
  `Customer_Customer_ID` INT NOT NULL,
  PRIMARY KEY (`Orders_ID`),
  INDEX `fk_Order_Customer1_idx` (`Customer_Customer_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Orders_Customer1`
    FOREIGN KEY (`Customer_Customer_ID`)
    REFERENCES `mydb`.`Customer` (`Customer_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


insert into orders values 
('1','2021-11-12','40.50','301'
),
('2','2021-10-23','50.34','302'
);

select * from orders;
-- -----------------------------------------------------
-- Table `mydb`.`Dept`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Dept` (
  `Dept_ID` INT NOT NULL,
  `Dept_Name` VARCHAR(45) NULL,
  PRIMARY KEY (`Dept_ID`))
ENGINE = InnoDB;

insert into Dept values (
'1', 'Sandwich'),
('2','Wraps'),
('3','Drinks'),
('4','Salads'),
('5','Other');
-- -----------------------------------------------------
-- Table `mydb`.`Vendor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Vendor` (
  `Vendor_ID` INT NOT NULL,
  `Vendor_Name` VARCHAR(45) NULL,
  `Vendor_Location` VARCHAR(45) NULL,
  `Vendor_Contact` VARCHAR(45) NULL,
  PRIMARY KEY (`Vendor_ID`))
ENGINE = InnoDB;

insert into Vendor values 
('401','Nos Astra','New York','nosatra@email.com'),
('402','Andrometa','Detroit','andrometa@email.com'),
('403','Omega','Redmond','Omega@email.com')
;

select * from Vendor;
-- -----------------------------------------------------
-- Table `mydb`.`Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Product` (
  `Product_ID` INT NOT NULL,
  `Product_Name` VARCHAR(45) NULL,
  `Product_Price` FLOAT NULL,
  `Product_Stock` INT NULL,
  `Product_Date` DATE NULL,
  `Employee_Employee_ID` INT NOT NULL,
  `orders_Orders_ID` INT NOT NULL,
  `Dept_Dept_ID` INT NOT NULL,
  `Vendor_Vendor_ID` INT NOT NULL,
  PRIMARY KEY (`Product_ID`, `orders_Orders_ID`, `Dept_Dept_ID`, `Vendor_Vendor_ID`),
  INDEX `fk_Product_Employee1_idx` (`Employee_Employee_ID` ASC) VISIBLE,
  INDEX `fk_Product_orders1_idx` (`Orders_Orders_ID` ASC) VISIBLE,
  INDEX `fk_Product_Dept1_idx` (`Dept_Dept_ID` ASC) VISIBLE,
  INDEX `fk_Product_Vendor1_idx` (`Vendor_Vendor_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Product_Employee1`
    FOREIGN KEY (`Employee_Employee_ID`)
    REFERENCES `mydb`.`Employee` (`Employee_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Product_orders1`
    FOREIGN KEY (`orders_Orders_ID`)
    REFERENCES `mydb`.`orders` (`Orders_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Product_Dept1`
    FOREIGN KEY (`Dept_Dept_ID`)
    REFERENCES `mydb`.`Dept` (`Dept_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Product_Vendor1`
    FOREIGN KEY (`Vendor_Vendor_ID`)
    REFERENCES `mydb`.`Vendor` (`Vendor_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

drop table Product;

insert into Product values
('1','Turkey Sandwich','3.55','30','2021-12-31','202','1','1','401'),
('2','Ham Sandwich','5.98','10','2021-12-31','201','2','1','402'),
('3','BLT','3.99','5','2021-12-31','202','1','1','403'),
('4','Chicken','5.45','45','2021-12-31','201','1','1','401'),
('5','Veggie Burger','6.99','15','2021-12-31','202','2','1','403'),
('6','Egg Salad','2.99','0','2021-12-31','202','2','1','401'),
('7','Grilled Cheese','2.99','0','2021-12-31','201','2','1','402'),
('8','Italian','5.99','50','2021-12-31','201','1','1','403'),
('9','Meatball','6.99','67','2021-12-31','202','2','1','402'),
('10','Veggie Lovers','8.99','12','2021-12-31','201','1','1','402'), -- end of sandwiches
('11','Chicken Ceaser','5.99','30','2021-12-31','202','1','2','402'),
('12','Tuna Salad','6.99','40','2021-12-31','201','1','2','401'),
('13', 'Vegetable','4.49','28','2021-12-31','202','2','2','403'),
('14','Steak and Cheese','8.99','2021-12-31','201','1','2','402'), -- end of wraps
('15','Fountain drink', '2.19','400','2021-12-31','201','1','3','401'),
('16','Green Tea', '2.99','115','2021-12-31','201','1','3','402'),
('17','Water','0.99','1000','2021-12-31','202','2','3','401'), 
('18','Coffee', '2.49','80','2021-12-31','201','1','3','403'), -- end of drinks
('19','Ceaser', '3.99','50','2021-12-31','201','1','4','401'),
('20','Greek','4.99','35','2021-12-31','202','2','4','402'),
('21','Chef','2.99','40','2021-12-31','201','1','4','401'),
('22','Italian','3.99','20','2021-12-31','202','2','4','403'), -- end of salads
;

select *
from Product;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
