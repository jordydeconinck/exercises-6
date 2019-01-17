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
-- Table `mydb`.`Doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Doctor` (
  `doctor_id` INT NOT NULL AUTO_INCREMENT,
  `doctorName` VARCHAR(45) NULL,
  `doctorBirth` DATE NULL,
  `doctorAddress` VARCHAR(45) NULL,
  `doctorPhone` INT(10) NULL,
  `doctorSalary` INT NULL,
  PRIMARY KEY (`doctor_id`),
  UNIQUE INDEX `doctor_id_UNIQUE` (`doctor_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Medical`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Medical` (
  `overtime_id` INT NOT NULL,
  `overtime_rate` INT NULL,
  `Doctor_doctor_id` INT NOT NULL,
  PRIMARY KEY (`overtime_id`),
  INDEX `fk_Medical_Doctor_idx` (`Doctor_doctor_id` ASC) VISIBLE,
  CONSTRAINT `fk_Medical_Doctor`
    FOREIGN KEY (`Doctor_doctor_id`)
    REFERENCES `mydb`.`Doctor` (`doctor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Specialist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Specialist` (
  `spec_id` INT NOT NULL,
  `field_area` VARCHAR(45) NULL,
  `Doctor_doctor_id` INT NOT NULL,
  PRIMARY KEY (`spec_id`),
  INDEX `fk_Specialist_Doctor1_idx` (`Doctor_doctor_id` ASC) VISIBLE,
  CONSTRAINT `fk_Specialist_Doctor1`
    FOREIGN KEY (`Doctor_doctor_id`)
    REFERENCES `mydb`.`Doctor` (`doctor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Patient` (
  `patient_id` INT NOT NULL,
  `patientName` VARCHAR(45) NULL,
  `patAddress` VARCHAR(45) NULL,
  `patPhone` INT NULL,
  `patBirth` DATE NULL,
  PRIMARY KEY (`patient_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Appointment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Appointment` (
  `appointment_id` INT NOT NULL,
  `apptDate` DATE NULL,
  `apptTime` TIME NULL,
  `Patient_patient_id` INT NOT NULL,
  `Doctor_doctor_id` INT NOT NULL,
  PRIMARY KEY (`appointment_id`),
  INDEX `fk_Appointment_Patient1_idx` (`Patient_patient_id` ASC) VISIBLE,
  INDEX `fk_Appointment_Doctor1_idx` (`Doctor_doctor_id` ASC) VISIBLE,
  CONSTRAINT `fk_Appointment_Patient1`
    FOREIGN KEY (`Patient_patient_id`)
    REFERENCES `mydb`.`Patient` (`patient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Appointment_Doctor1`
    FOREIGN KEY (`Doctor_doctor_id`)
    REFERENCES `mydb`.`Doctor` (`doctor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Payment` (
  `payment_id` INT NOT NULL,
  `paymentdetails` VARCHAR(45) NULL,
  `method` ENUM("cash", "card") NULL,
  `Patient_patient_id` INT NOT NULL,
  PRIMARY KEY (`payment_id`),
  INDEX `fk_Payment_Patient1_idx` (`Patient_patient_id` ASC) VISIBLE,
  CONSTRAINT `fk_Payment_Patient1`
    FOREIGN KEY (`Patient_patient_id`)
    REFERENCES `mydb`.`Patient` (`patient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Bill` (
  `bill_id` INT NOT NULL,
  `total` INT NULL,
  `Doctor_doctor_id` INT NOT NULL,
  PRIMARY KEY (`bill_id`),
  INDEX `fk_Bill_Doctor1_idx` (`Doctor_doctor_id` ASC) VISIBLE,
  CONSTRAINT `fk_Bill_Doctor1`
    FOREIGN KEY (`Doctor_doctor_id`)
    REFERENCES `mydb`.`Doctor` (`doctor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Payment_has_Bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Payment_has_Bill` (
  `Payment_payment_id` INT NOT NULL,
  `Bill_bill_id` INT NOT NULL,
  PRIMARY KEY (`Payment_payment_id`, `Bill_bill_id`),
  INDEX `fk_Payment_has_Bill_Bill1_idx` (`Bill_bill_id` ASC) VISIBLE,
  INDEX `fk_Payment_has_Bill_Payment1_idx` (`Payment_payment_id` ASC) VISIBLE,
  CONSTRAINT `fk_Payment_has_Bill_Payment1`
    FOREIGN KEY (`Payment_payment_id`)
    REFERENCES `mydb`.`Payment` (`payment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Payment_has_Bill_Bill1`
    FOREIGN KEY (`Bill_bill_id`)
    REFERENCES `mydb`.`Bill` (`bill_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
