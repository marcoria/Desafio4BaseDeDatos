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
-- Table `mydb`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`persona` (
  `idpersona` INT NOT NULL,
  `DNI` INT(8) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `domicilio` VARCHAR(45) NOT NULL,
  `fecha_nac` DATE NOT NULL,
  `edad` TINYINT(3) NULL,
  `telefono 1` VARCHAR(15) NOT NULL,
  `telefono 2` VARCHAR(15) NULL,
  `img_foto` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`idpersona`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`domicilio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`domicilio` (
  `iddomicilio` INT NOT NULL,
  `pais` VARCHAR(45) NULL,
  `provincia` VARCHAR(45) NULL,
  `departamento` VARCHAR(45) NULL,
  `calle` VARCHAR(45) NULL,
  `altura` SMALLINT(5) NULL,
  `persona_idpersona` INT NOT NULL,
  PRIMARY KEY (`iddomicilio`, `persona_idpersona`),
  INDEX `fk_domicilio_persona_idx` (`persona_idpersona` ASC) VISIBLE,
  CONSTRAINT `fk_domicilio_persona`
    FOREIGN KEY (`persona_idpersona`)
    REFERENCES `mydb`.`persona` (`idpersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`educacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`educacion` (
  `ideducacion` INT NOT NULL,
  `establecimiento` VARCHAR(45) NOT NULL,
  `nivel_duc` VARCHAR(45) NOT NULL,
  `fecha_ing` DATE NOT NULL,
  `fecha_egr` VARCHAR(45) NOT NULL,
  `persona_idpersona` INT NOT NULL,
  PRIMARY KEY (`ideducacion`, `persona_idpersona`),
  INDEX `fk_educacion_persona1_idx` (`persona_idpersona` ASC) VISIBLE,
  CONSTRAINT `fk_educacion_persona1`
    FOREIGN KEY (`persona_idpersona`)
    REFERENCES `mydb`.`persona` (`idpersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`experiencias_laboral`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`experiencias_laboral` (
  `ideducacion` INT NOT NULL,
  `empresa` VARCHAR(45) NOT NULL,
  `fecha_ing` DATE NOT NULL,
  `fecha_egr` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `persona_idpersona` INT NOT NULL,
  PRIMARY KEY (`ideducacion`, `persona_idpersona`),
  INDEX `fk_experiencias_laboral_persona1_idx` (`persona_idpersona` ASC) VISIBLE,
  CONSTRAINT `fk_experiencias_laboral_persona1`
    FOREIGN KEY (`persona_idpersona`)
    REFERENCES `mydb`.`persona` (`idpersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuarios` (
  `idusuarios` INT NOT NULL,
  `usuario` VARCHAR(45) NOT NULL,
  `contraseña` VARCHAR(45) NOT NULL,
  `mail` VARCHAR(45) NOT NULL,
  `persona_idpersona` INT NOT NULL,
  PRIMARY KEY (`idusuarios`, `persona_idpersona`),
  INDEX `fk_usuarios_persona1_idx` (`persona_idpersona` ASC) VISIBLE,
  CONSTRAINT `fk_usuarios_persona1`
    FOREIGN KEY (`persona_idpersona`)
    REFERENCES `mydb`.`persona` (`idpersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Hard&SoftSkills`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Hard&SoftSkills` (
  `idHard&SoftSkills` INT NOT NULL,
  `tecnologia` VARCHAR(45) NOT NULL,
  `nivel` VARCHAR(45) NOT NULL,
  `img_logo` VARCHAR(200) NOT NULL,
  `persona_idpersona` INT NOT NULL,
  PRIMARY KEY (`idHard&SoftSkills`, `persona_idpersona`),
  INDEX `fk_Hard&SoftSkills_persona1_idx` (`persona_idpersona` ASC) VISIBLE,
  CONSTRAINT `fk_Hard&SoftSkills_persona1`
    FOREIGN KEY (`persona_idpersona`)
    REFERENCES `mydb`.`persona` (`idpersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`proyecto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`proyecto` (
  `idproyecto` INT NOT NULL,
  `nombre_proyecto` VARCHAR(45) NOT NULL,
  `version` VARCHAR(45) NULL,
  `descripcion` LONGTEXT NULL,
  `persona_idpersona` INT NOT NULL,
  PRIMARY KEY (`idproyecto`, `persona_idpersona`),
  INDEX `fk_proyecto_persona1_idx` (`persona_idpersona` ASC) VISIBLE,
  CONSTRAINT `fk_proyecto_persona1`
    FOREIGN KEY (`persona_idpersona`)
    REFERENCES `mydb`.`persona` (`idpersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`roles` (
  `idroles` INT NOT NULL,
  `rol` VARCHAR(45) NULL,
  PRIMARY KEY (`idroles`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`usuarios_has_roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuarios_has_roles` (
  `usuarios_idusuarios` INT NOT NULL,
  `usuarios_persona_idpersona` INT NOT NULL,
  `roles_idroles` INT NOT NULL,
  PRIMARY KEY (`usuarios_idusuarios`, `usuarios_persona_idpersona`, `roles_idroles`),
  INDEX `fk_usuarios_has_roles_roles1_idx` (`roles_idroles` ASC) VISIBLE,
  INDEX `fk_usuarios_has_roles_usuarios1_idx` (`usuarios_idusuarios` ASC, `usuarios_persona_idpersona` ASC) VISIBLE,
  CONSTRAINT `fk_usuarios_has_roles_usuarios1`
    FOREIGN KEY (`usuarios_idusuarios` , `usuarios_persona_idpersona`)
    REFERENCES `mydb`.`usuarios` (`idusuarios` , `persona_idpersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_has_roles_roles1`
    FOREIGN KEY (`roles_idroles`)
    REFERENCES `mydb`.`roles` (`idroles`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
