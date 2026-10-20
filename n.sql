-- MySQL Script corrigido

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `Desenvolvimento_de_Sistema_PDV_MS²_Vestuário` DEFAULT CHARACTER SET utf8 ;
USE `Desenvolvimento_de_Sistema_PDV_MS²_Vestuário` ;

-- -----------------------------------------------------
-- Table `usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Desenvolvimento_de_Sistema_PDV_MS²_Vestuário`.`usuarios` (
  `id_Usuarios` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `email` VARCHAR(225) NOT NULL,
  `senha` VARCHAR(255) NOT NULL,
  `nivel_acesso` ENUM('caixa', 'gerente') NOT NULL DEFAULT 'caixa',
  `criado_em` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_Usuarios`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Desenvolvimento_de_Sistema_PDV_MS²_Vestuário`.`clientes` (
  `id_clientes` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `cpf` VARCHAR(14) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `telefone` VARCHAR(20) NOT NULL,
  `criado_em` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_clientes`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC) VISIBLE,
  UNIQUE INDEX `telefone_UNIQUE` (`telefone` ASC) VISIBLE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `produtos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Desenvolvimento_de_Sistema_PDV_MS²_Vestuário`.`produtos` (
  `id_produtos` INT NOT NULL AUTO_INCREMENT,
  `codigo` VARCHAR(50) NOT NULL,
  `descricao` VARCHAR(255) NOT NULL,
  `preco` DECIMAL(10,2) NOT NULL,
  `estoque` INT NULL DEFAULT 0,
  `chegada_em` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_produtos`),
  UNIQUE INDEX `codigo_UNIQUE` (`codigo` ASC) VISIBLE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `vendas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Desenvolvimento_de_Sistema_PDV_MS²_Vestuário`.`vendas` (
  `id_vendas` INT NOT NULL AUTO_INCREMENT,
  `valor_total` DECIMAL(10,2) NOT NULL,
  `descoto` DECIMAL(10,2) NULL DEFAULT 0.00,
  `status` ENUM('concluida', 'cancelada') NOT NULL DEFAULT 'concluida',
  `data_venda` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `usuarios_id_Usuarios` INT NOT NULL,
  `clientes_id_clientes` INT NOT NULL,
  PRIMARY KEY (`id_vendas`, `usuarios_id_Usuarios`, `clientes_id_clientes`),
  INDEX `fk_vendas_usuarios_idx` (`usuarios_id_Usuarios` ASC) VISIBLE,
  INDEX `fk_vendas_clientes1_idx` (`clientes_id_clientes` ASC) VISIBLE,
  CONSTRAINT `fk_vendas_usuarios`
    FOREIGN KEY (`usuarios_id_Usuarios`)
    REFERENCES `Desenvolvimento_de_Sistema_PDV_MS²_Vestuário`.`usuarios` (`id_Usuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vendas_clientes1`
    FOREIGN KEY (`clientes_id_clientes`)
    REFERENCES `Desenvolvimento_de_Sistema_PDV_MS²_Vestuário`.`clientes` (`id_clientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `itens_vendas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Desenvolvimento_de_Sistema_PDV_MS²_Vestuário`.`itens_vendas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `quantidade` INT NOT NULL,
  `preco_unitario` DECIMAL(10,2) NOT NULL,
  `subtotal` DECIMAL(10,2) NOT NULL,
  `vendas_id_vendas` INT NOT NULL,
  `vendas_usuarios_id_Usuarios` INT NOT NULL,
  `vendas_clientes_id_clientes` INT NOT NULL,
  `produtos_id_produtos` INT NOT NULL,
  PRIMARY KEY (`id`, `vendas_id_vendas`, `vendas_usuarios_id_Usuarios`, `vendas_clientes_id_clientes`, `produtos_id_produtos`),
  INDEX `fk_itens_vendas_vendas1_idx` (`vendas_id_vendas` ASC, `vendas_usuarios_id_Usuarios` ASC, `vendas_clientes_id_clientes` ASC) VISIBLE,
  INDEX `fk_itens_vendas_produtos1_idx` (`produtos_id_produtos` ASC) VISIBLE,
  CONSTRAINT `fk_itens_vendas_vendas1`
    FOREIGN KEY (`vendas_id_vendas` , `vendas_usuarios_id_Usuarios` , `vendas_clientes_id_clientes`)
    REFERENCES `Desenvolvimento_de_Sistema_PDV_MS²_Vestuário`.`vendas` (`id_vendas` , `usuarios_id_Usuarios` , `clientes_id_clientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_itens_vendas_produtos1`
    FOREIGN KEY (`produtos_id_produtos`)
    REFERENCES `Desenvolvimento_de_Sistema_PDV_MS²_Vestuário`.`produtos` (`id_produtos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;