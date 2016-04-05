-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema drugbank
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `drugbank` ;

-- -----------------------------------------------------
-- Schema drugbank
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `drugbank` DEFAULT CHARACTER SET latin1 ;
USE `drugbank` ;

-- -----------------------------------------------------
-- Table `drugbank`.`known_actions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`known_actions` (
  `id` INT NOT NULL,
  `action` CHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`drugbank`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`drugbank` (
  `id` INT NOT NULL,
  `version` CHAR(255) NULL DEFAULT NULL,
  `exported-on` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`reaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`reaction` (
  `id` INT NOT NULL,
  `sequence` CHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`drug`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`drug` (
  `id` VARCHAR(45) NOT NULL,
  `name` CHAR(255) NOT NULL,
  `description` CHAR(255) NOT NULL,
  `cas-number` CHAR(255) NOT NULL,
  `general-references` CHAR(255) NOT NULL,
  `synthesis-reference` CHAR(255) NOT NULL,
  `indication` CHAR(255) NOT NULL,
  `pharmacodynamics` CHAR(255) NOT NULL,
  `mechanism-of-action` CHAR(255) NOT NULL,
  `toxicity` CHAR(255) NOT NULL,
  `metabolism` CHAR(255) NOT NULL,
  `absorption` CHAR(255) NOT NULL,
  `half-life` CHAR(255) NOT NULL,
  `protein-binding` CHAR(255) NOT NULL,
  `route-of-elimination` CHAR(255) NOT NULL,
  `volume-of-distribution` CHAR(255) NOT NULL,
  `clearance` CHAR(255) NOT NULL,
  `type` CHAR(255) NOT NULL,
  `created` VARCHAR(255) NOT NULL,
  `updated` VARCHAR(255) NOT NULL,
  `drugbank_id` INT NOT NULL,
  `reaction_id` INT NOT NULL,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  PRIMARY KEY (`id`, `drugbank_id`),
  INDEX `fk_drug_drugbank1_idx` (`drugbank_id` ASC),
  INDEX `fk_drug_reaction1_idx` (`reaction_id` ASC),
  CONSTRAINT `fk_drug_drugbank1`
    FOREIGN KEY (`drugbank_id`)
    REFERENCES `drugbank`.`drugbank` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_drug_reaction1`
    FOREIGN KEY (`reaction_id`)
    REFERENCES `drugbank`.`reaction` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`affected-organisms`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`affected-organisms` (
  `id` INT NOT NULL,
  `affected_organism` CHAR(255) NULL DEFAULT NULL,
  `drug_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_affected-organisms_drug1_idx` (`drug_id` ASC),
  CONSTRAINT `fk_affected-organisms_drug1`
    FOREIGN KEY (`drug_id`)
    REFERENCES `drugbank`.`drug` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`ahfs_code`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`ahfs_code` (
  `id` INT NOT NULL,
  `ahfs-code` CHAR(255) NULL DEFAULT NULL,
  `drug_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_ahfs-code_drug1_idx` (`drug_id` ASC),
  CONSTRAINT `fk_ahfs-code_drug1`
    FOREIGN KEY (`drug_id`)
    REFERENCES `drugbank`.`drug` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`atc_code`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`atc_code` (
  `id` INT NOT NULL,
  `code` CHAR(255) NULL DEFAULT NULL,
  `drug_id` VARCHAR(45) NOT NULL,
  INDEX `fk_atc-code_drug1_idx` (`drug_id` ASC),
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  CONSTRAINT `fk_atc-code_drug1`
    FOREIGN KEY (`drug_id`)
    REFERENCES `drugbank`.`drug` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`interactant_group`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`interactant_group` (
  `id` INT NOT NULL,
  `name` CHAR(255) NOT NULL,
  `organism` CHAR(255) NOT NULL,
  `references` CHAR(255) NOT NULL,
  `position` TINYINT(4) NULL DEFAULT NULL,
  `drug_id` VARCHAR(45) NOT NULL,
  `known_actions_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_interactant_group_known_actions1_idx` (`known_actions_id` ASC),
  CONSTRAINT `fk_interactant_group_known_actions1`
    FOREIGN KEY (`known_actions_id`)
    REFERENCES `drugbank`.`known_actions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`carrier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`carrier` (
  `id` INT NOT NULL,
  `position` TINYINT(4) NULL DEFAULT NULL,
  `drug_id` VARCHAR(45) NOT NULL,
  `interactant_group_id` INT NOT NULL,
  INDEX `fk_carrier_drug1_idx` (`drug_id` ASC),
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_carrier_interactant_group1_idx` (`interactant_group_id` ASC),
  CONSTRAINT `fk_carrier_drug1`
    FOREIGN KEY (`drug_id`)
    REFERENCES `drugbank`.`drug` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_carrier_interactant_group1`
    FOREIGN KEY (`interactant_group_id`)
    REFERENCES `drugbank`.`interactant_group` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`category` (
  `id` INT NOT NULL,
  `category` CHAR(255) NOT NULL,
  `mesh-id` CHAR(255) NOT NULL,
  `drug_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_category_drug1_idx` (`drug_id` ASC),
  CONSTRAINT `fk_category_drug1`
    FOREIGN KEY (`drug_id`)
    REFERENCES `drugbank`.`drug` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`classification`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`classification` (
  `id` VARCHAR(45) NOT NULL,
  `description` CHAR(255) NOT NULL,
  `direct-parent` CHAR(255) NOT NULL,
  `kingdom` CHAR(255) NOT NULL,
  `superclass` CHAR(255) NOT NULL,
  `class` CHAR(255) NOT NULL,
  `subclass` CHAR(255) NOT NULL,
  `drug_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_classification_drug1_idx` (`drug_id` ASC),
  CONSTRAINT `fk_classification_drug1`
    FOREIGN KEY (`drug_id`)
    REFERENCES `drugbank`.`drug` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`currency`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`currency` (
  `id` INT NOT NULL,
  `currency` CHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`dosage`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`dosage` (
  `id` VARCHAR(45) NOT NULL,
  `form` CHAR(255) NOT NULL,
  `route` CHAR(255) NOT NULL,
  `strength` CHAR(255) NOT NULL,
  `drug_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_dosage_drug1_idx` (`drug_id` ASC),
  CONSTRAINT `fk_dosage_drug1`
    FOREIGN KEY (`drug_id`)
    REFERENCES `drugbank`.`drug` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`drug_interaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`drug_interaction` (
  `id` INT NOT NULL,
  `name` CHAR(255) NOT NULL,
  `description` CHAR(255) NOT NULL,
  `drug_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_drug_interaction_drug1_idx` (`drug_id` ASC),
  CONSTRAINT `fk_drug_interaction_drug1`
    FOREIGN KEY (`drug_id`)
    REFERENCES `drugbank`.`drug` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`snp_effect`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`snp_effect` (
  `id` INT NOT NULL,
  `protein-name` CHAR(255) NOT NULL,
  `gene-symbol` CHAR(255) NOT NULL,
  `uniprot-id` CHAR(255) NOT NULL,
  `rs-id` CHAR(255) NOT NULL,
  `allele` CHAR(255) NOT NULL,
  `defining-change` CHAR(255) NOT NULL,
  `description` CHAR(255) NOT NULL,
  `pubmed-id` CHAR(255) NOT NULL,
  `drug_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_snp_effect_drug1_idx` (`drug_id` ASC),
  CONSTRAINT `fk_snp_effect_drug1`
    FOREIGN KEY (`drug_id`)
    REFERENCES `drugbank`.`drug` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`enzymes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`enzymes` (
  `id` VARCHAR(45) NOT NULL,
  `uniprot_id` CHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`identifier_resource`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`identifier_resource` (
  `id` INT NOT NULL,
  `name` CHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`external-identifier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`external-identifier` (
  `id` INT NOT NULL,
  `resource` CHAR(255) NOT NULL,
  `identifier` CHAR(255) NOT NULL,
  `drug_id` VARCHAR(45) NOT NULL,
  `identifier_resource_id` INT NOT NULL,
  PRIMARY KEY (`id`, `identifier_resource_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_external-identifier_drug1_idx` (`drug_id` ASC),
  INDEX `fk_external-identifier_identifier_resource1_idx` (`identifier_resource_id` ASC),
  CONSTRAINT `fk_external-identifier_drug1`
    FOREIGN KEY (`drug_id`)
    REFERENCES `drugbank`.`drug` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_external-identifier_identifier_resource1`
    FOREIGN KEY (`identifier_resource_id`)
    REFERENCES `drugbank`.`identifier_resource` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`polypeptide_external_identifier_resource`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`polypeptide_external_identifier_resource` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`organism`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`organism` (
  `id` INT NOT NULL,
  `ncbi_taxonomy_id` CHAR(255) NULL DEFAULT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`polypeptide`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`polypeptide` (
  `id` CHAR(255) NOT NULL,
  `name` CHAR(255) NOT NULL,
  `general-function` CHAR(255) NOT NULL,
  `specific-function` CHAR(255) NOT NULL,
  `gene-name` CHAR(255) NOT NULL,
  `locus` CHAR(255) NOT NULL,
  `cellular-location` CHAR(255) NOT NULL,
  `transmembrane-regions` CHAR(255) NOT NULL,
  `signal-regions` CHAR(255) NOT NULL,
  `theoretical-pi` CHAR(255) NOT NULL,
  `molecular-weight` CHAR(255) NOT NULL,
  `chromosome-location` CHAR(255) NOT NULL,
  `source` CHAR(255) NOT NULL,
  `amino-acid-sequence` VARCHAR(255) NULL,
  `gene_sequence` VARCHAR(255) NULL,
  `organism_id` INT NOT NULL,
  `interactant_group_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_polypeptide_organism1_idx` (`organism_id` ASC),
  INDEX `fk_polypeptide_interactant_group1_idx` (`interactant_group_id` ASC),
  CONSTRAINT `fk_polypeptide_organism1`
    FOREIGN KEY (`organism_id`)
    REFERENCES `drugbank`.`organism` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_polypeptide_interactant_group1`
    FOREIGN KEY (`interactant_group_id`)
    REFERENCES `drugbank`.`interactant_group` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`polypeptide_external_identifier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`polypeptide_external_identifier` (
  `id` INT NOT NULL,
  `identifier` CHAR(255) NOT NULL,
  `polypeptide_external_identifier_resource_id` INT NOT NULL,
  `polypeptide_id` CHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_polypeptide_external_identifier_polypeptide_external_ide_idx` (`polypeptide_external_identifier_resource_id` ASC),
  INDEX `fk_polypeptide_external_identifier_polypeptide1_idx` (`polypeptide_id` ASC),
  CONSTRAINT `fk_polypeptide_external_identifier_polypeptide_external_ident1`
    FOREIGN KEY (`polypeptide_external_identifier_resource_id`)
    REFERENCES `drugbank`.`polypeptide_external_identifier_resource` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_polypeptide_external_identifier_polypeptide1`
    FOREIGN KEY (`polypeptide_id`)
    REFERENCES `drugbank`.`polypeptide` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`food_interactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`food_interactions` (
  `id` INT NOT NULL,
  `description` CHAR(255) NULL DEFAULT NULL,
  `drug_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_food_interactions_drug1_idx` (`drug_id` ASC),
  CONSTRAINT `fk_food_interactions_drug1`
    FOREIGN KEY (`drug_id`)
    REFERENCES `drugbank`.`drug` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`go_classifier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`go_classifier` (
  `id` INT NOT NULL,
  `category` CHAR(255) NOT NULL,
  `description` CHAR(255) NOT NULL,
  `polypeptide_id` CHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_go_classifier_polypeptide1_idx` (`polypeptide_id` ASC),
  CONSTRAINT `fk_go_classifier_polypeptide1`
    FOREIGN KEY (`polypeptide_id`)
    REFERENCES `drugbank`.`polypeptide` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`groups`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`groups` (
  `id` INT NOT NULL,
  `group` CHAR(255) NOT NULL,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`international-brand`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`international-brand` (
  `id` VARCHAR(45) NOT NULL,
  `name` CHAR(255) NOT NULL,
  `company` CHAR(255) NOT NULL,
  `drug_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_international-brand_drug1_idx` (`drug_id` ASC),
  CONSTRAINT `fk_international-brand_drug1`
    FOREIGN KEY (`drug_id`)
    REFERENCES `drugbank`.`drug` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`level`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`level` (
  `id` INT NOT NULL,
  `code` CHAR(255) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `atc-code_id` INT NOT NULL,
  PRIMARY KEY (`id`, `atc-code_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_level_atc-code1_idx` (`atc-code_id` ASC),
  CONSTRAINT `fk_level_atc-code1`
    FOREIGN KEY (`atc-code_id`)
    REFERENCES `drugbank`.`atc_code` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`manufacturer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`manufacturer` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`mixture`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`mixture` (
  `id` INT NOT NULL,
  `name` CHAR(255) NOT NULL,
  `ingredients` CHAR(255) NOT NULL,
  `drug_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_mixture_drug1_idx` (`drug_id` ASC),
  CONSTRAINT `fk_mixture_drug1`
    FOREIGN KEY (`drug_id`)
    REFERENCES `drugbank`.`drug` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`packager`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`packager` (
  `id` INT NOT NULL,
  `name` CHAR(255) NOT NULL,
  `url` CHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`pathway`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`pathway` (
  `id` VARCHAR(45) NOT NULL,
  `smpdb_id` CHAR(255) NOT NULL,
  `name` CHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`pfam`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`pfam` (
  `id` INT NOT NULL,
  `identifier` CHAR(255) NOT NULL,
  `name` CHAR(255) NOT NULL,
  `polypeptide_id` CHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_pfam_polypeptide1_idx` (`polypeptide_id` ASC),
  CONSTRAINT `fk_pfam_polypeptide1`
    FOREIGN KEY (`polypeptide_id`)
    REFERENCES `drugbank`.`polypeptide` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`price`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`price` (
  `id` INT NOT NULL,
  `description` CHAR(255) NOT NULL,
  `cost` DOUBLE NOT NULL,
  `unit` CHAR(255) NOT NULL,
  `currency_id` INT NOT NULL,
  `drug_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`, `currency_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_price_currency1_idx` (`currency_id` ASC),
  INDEX `fk_price_drug1_idx` (`drug_id` ASC),
  CONSTRAINT `fk_price_currency1`
    FOREIGN KEY (`currency_id`)
    REFERENCES `drugbank`.`currency` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_price_drug1`
    FOREIGN KEY (`drug_id`)
    REFERENCES `drugbank`.`drug` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`country` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `code` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`source`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`source` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`product` (
  `id` INT NOT NULL,
  `name` CHAR(255) NOT NULL,
  `ndc-id` CHAR(255) NOT NULL,
  `ndc-product-code` CHAR(255) NOT NULL,
  `dpd-id` CHAR(255) NULL DEFAULT NULL,
  `started-marketing-on` CHAR(255) NOT NULL,
  `ended-marketing-on` CHAR(255) NOT NULL,
  `dosage-form` CHAR(255) NOT NULL,
  `strength` CHAR(255) NOT NULL,
  `route` CHAR(255) NOT NULL,
  `fda-application-number` CHAR(255) NOT NULL,
  `generic` TINYINT(4) NOT NULL,
  `over-the-counter` TINYINT(4) NOT NULL,
  `approved` TINYINT(4) NOT NULL,
  `drug_id` VARCHAR(45) NOT NULL,
  `country_id` INT NOT NULL,
  `source_id` INT NOT NULL,
  PRIMARY KEY (`id`, `country_id`, `source_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_product_drug1_idx` (`drug_id` ASC),
  INDEX `fk_product_country1_idx` (`country_id` ASC),
  INDEX `fk_product_source1_idx` (`source_id` ASC),
  CONSTRAINT `fk_product_drug1`
    FOREIGN KEY (`drug_id`)
    REFERENCES `drugbank`.`drug` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_country1`
    FOREIGN KEY (`country_id`)
    REFERENCES `drugbank`.`country` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_source1`
    FOREIGN KEY (`source_id`)
    REFERENCES `drugbank`.`source` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`sequence`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`sequence` (
  `id` INT NOT NULL,
  `format` CHAR(255) NULL DEFAULT NULL,
  `drug_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_sequence_drug1_idx` (`drug_id` ASC),
  CONSTRAINT `fk_sequence_drug1`
    FOREIGN KEY (`drug_id`)
    REFERENCES `drugbank`.`drug` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`synonym`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`synonym` (
  `id` INT NOT NULL,
  `language` CHAR(255) NULL DEFAULT NULL,
  `coder` CHAR(255) NULL DEFAULT NULL,
  `description` VARCHAR(45) NULL,
  `drug_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_synonym_drug1_idx` (`drug_id` ASC),
  CONSTRAINT `fk_synonym_drug1`
    FOREIGN KEY (`drug_id`)
    REFERENCES `drugbank`.`drug` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`transporter`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`transporter` (
  `id` INT NOT NULL,
  `position` TINYINT(4) NULL DEFAULT NULL,
  `drug_id` VARCHAR(45) NOT NULL,
  `interactant_group_id` INT NOT NULL,
  INDEX `fk_transporter_drug1_idx` (`drug_id` ASC),
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_transporter_interactant_group1_idx` (`interactant_group_id` ASC),
  CONSTRAINT `fk_transporter_drug1`
    FOREIGN KEY (`drug_id`)
    REFERENCES `drugbank`.`drug` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transporter_interactant_group1`
    FOREIGN KEY (`interactant_group_id`)
    REFERENCES `drugbank`.`interactant_group` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`drug_groups`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`drug_groups` (
  `drug_id` VARCHAR(45) NOT NULL,
  `group_id` INT NOT NULL,
  PRIMARY KEY (`drug_id`),
  INDEX `fk_drug_has_groups_groups1_idx` (`group_id` ASC),
  INDEX `fk_drug_has_groups_drug_idx` (`drug_id` ASC),
  CONSTRAINT `fk_drug_has_groups_drug`
    FOREIGN KEY (`drug_id`)
    REFERENCES `drugbank`.`drug` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_drug_has_groups_groups1`
    FOREIGN KEY (`group_id`)
    REFERENCES `drugbank`.`groups` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`drug_packager`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`drug_packager` (
  `drug_id` VARCHAR(45) NOT NULL,
  `packager_id` INT NOT NULL,
  PRIMARY KEY (`packager_id`, `drug_id`),
  INDEX `fk_drug_has_packager_packager1_idx` (`packager_id` ASC),
  INDEX `fk_drug_has_packager_drug1_idx` (`drug_id` ASC),
  CONSTRAINT `fk_drug_has_packager_drug1`
    FOREIGN KEY (`drug_id`)
    REFERENCES `drugbank`.`drug` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_drug_has_packager_packager1`
    FOREIGN KEY (`packager_id`)
    REFERENCES `drugbank`.`packager` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`drug_manufacturer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`drug_manufacturer` (
  `drug_id` VARCHAR(45) NOT NULL,
  `manufacturer_id` INT NOT NULL,
  PRIMARY KEY (`drug_id`, `manufacturer_id`),
  INDEX `fk_drug_has_manufacturer_manufacturer1_idx` (`manufacturer_id` ASC),
  INDEX `fk_drug_has_manufacturer_drug1_idx` (`drug_id` ASC),
  CONSTRAINT `fk_drug_has_manufacturer_drug1`
    FOREIGN KEY (`drug_id`)
    REFERENCES `drugbank`.`drug` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_drug_has_manufacturer_manufacturer1`
    FOREIGN KEY (`manufacturer_id`)
    REFERENCES `drugbank`.`manufacturer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`patent`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`patent` (
  `id` INT NOT NULL,
  `number` VARCHAR(45) NULL,
  `country` VARCHAR(45) NULL,
  `approved` VARCHAR(45) NULL,
  `expires` VARCHAR(45) NULL,
  `drug_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_patent_drug1_idx` (`drug_id` ASC),
  CONSTRAINT `fk_patent_drug1`
    FOREIGN KEY (`drug_id`)
    REFERENCES `drugbank`.`drug` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`property_kind`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`property_kind` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`property_source`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`property_source` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`calculated_property`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`calculated_property` (
  `id` INT NOT NULL,
  `value` VARCHAR(45) NULL,
  `drug_id` VARCHAR(45) NOT NULL,
  `calculated_property_kind_id` INT NOT NULL,
  `calculated_property_source_id` INT NOT NULL,
  PRIMARY KEY (`id`, `calculated_property_kind_id`, `calculated_property_source_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_calculated_property_drug1_idx` (`drug_id` ASC),
  INDEX `fk_calculated_property_calculated_property_kind1_idx` (`calculated_property_kind_id` ASC),
  INDEX `fk_calculated_property_calculated_property_source1_idx` (`calculated_property_source_id` ASC),
  CONSTRAINT `fk_calculated_property_drug1`
    FOREIGN KEY (`drug_id`)
    REFERENCES `drugbank`.`drug` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_calculated_property_calculated_property_kind1`
    FOREIGN KEY (`calculated_property_kind_id`)
    REFERENCES `drugbank`.`property_kind` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_calculated_property_calculated_property_source1`
    FOREIGN KEY (`calculated_property_source_id`)
    REFERENCES `drugbank`.`property_source` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`experimental_property_kind`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`experimental_property_kind` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`experimental_property`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`experimental_property` (
  `id` INT NOT NULL,
  `value` VARCHAR(45) NULL,
  `source` VARCHAR(45) NULL,
  `drug_id` VARCHAR(45) NOT NULL,
  `experimental_property_kind_id` INT NOT NULL,
  `property_kind_id` INT NOT NULL,
  PRIMARY KEY (`id`, `experimental_property_kind_id`, `property_kind_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_experimental_property_drug1_idx` (`drug_id` ASC),
  INDEX `fk_experimental_property_experimental_property_kind1_idx` (`experimental_property_kind_id` ASC),
  INDEX `fk_experimental_property_property_kind1_idx` (`property_kind_id` ASC),
  CONSTRAINT `fk_experimental_property_drug1`
    FOREIGN KEY (`drug_id`)
    REFERENCES `drugbank`.`drug` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_experimental_property_experimental_property_kind1`
    FOREIGN KEY (`experimental_property_kind_id`)
    REFERENCES `drugbank`.`experimental_property_kind` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_experimental_property_property_kind1`
    FOREIGN KEY (`property_kind_id`)
    REFERENCES `drugbank`.`property_kind` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`link_resource`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`link_resource` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`external_link`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`external_link` (
  `id` INT NOT NULL,
  `url` VARCHAR(45) NULL,
  `drug_id` VARCHAR(45) NOT NULL,
  `link_resource_id` INT NOT NULL,
  PRIMARY KEY (`id`, `link_resource_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_external_link_drug1_idx` (`drug_id` ASC),
  INDEX `fk_external_link_link_resource1_idx` (`link_resource_id` ASC),
  CONSTRAINT `fk_external_link_drug1`
    FOREIGN KEY (`drug_id`)
    REFERENCES `drugbank`.`drug` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_external_link_link_resource1`
    FOREIGN KEY (`link_resource_id`)
    REFERENCES `drugbank`.`link_resource` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`drug_pathway`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`drug_pathway` (
  `id` VARCHAR(45) NOT NULL,
  `drug_id` VARCHAR(45) NOT NULL,
  `pathway_id` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`, `drug_id`, `pathway_id`),
  INDEX `fk_drug_has_pathway_pathway1_idx` (`pathway_id` ASC),
  INDEX `fk_drug_has_pathway_drug1_idx` (`drug_id` ASC),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  CONSTRAINT `fk_drug_has_pathway_drug1`
    FOREIGN KEY (`drug_id`)
    REFERENCES `drugbank`.`drug` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_drug_has_pathway_pathway1`
    FOREIGN KEY (`pathway_id`)
    REFERENCES `drugbank`.`pathway` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`reaction_element`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`reaction_element` (
  `drug_id` VARCHAR(45) NOT NULL,
  `reaction_id` INT NOT NULL,
  `type` VARCHAR(45) NULL,
  PRIMARY KEY (`drug_id`, `reaction_id`),
  INDEX `fk_drug_has_reaction_reaction1_idx` (`reaction_id` ASC),
  INDEX `fk_drug_has_reaction_drug1_idx` (`drug_id` ASC),
  CONSTRAINT `fk_drug_has_reaction_drug1`
    FOREIGN KEY (`drug_id`)
    REFERENCES `drugbank`.`drug` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_drug_has_reaction_reaction1`
    FOREIGN KEY (`reaction_id`)
    REFERENCES `drugbank`.`reaction` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`pathway_enzymes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`pathway_enzymes` (
  `pathway_id` VARCHAR(45) NOT NULL,
  `enzymes_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`pathway_id`, `enzymes_id`),
  INDEX `fk_pathway_has_enzymes_enzymes1_idx` (`enzymes_id` ASC),
  INDEX `fk_pathway_has_enzymes_pathway1_idx` (`pathway_id` ASC),
  CONSTRAINT `fk_pathway_has_enzymes_pathway1`
    FOREIGN KEY (`pathway_id`)
    REFERENCES `drugbank`.`pathway` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pathway_has_enzymes_enzymes1`
    FOREIGN KEY (`enzymes_id`)
    REFERENCES `drugbank`.`enzymes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`reaction_enzymes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`reaction_enzymes` (
  `reaction_id` INT NOT NULL,
  `enzymes_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`reaction_id`, `enzymes_id`),
  INDEX `fk_reaction_has_enzymes_enzymes1_idx` (`enzymes_id` ASC),
  INDEX `fk_reaction_has_enzymes_reaction1_idx` (`reaction_id` ASC),
  CONSTRAINT `fk_reaction_has_enzymes_reaction1`
    FOREIGN KEY (`reaction_id`)
    REFERENCES `drugbank`.`reaction` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reaction_has_enzymes_enzymes1`
    FOREIGN KEY (`enzymes_id`)
    REFERENCES `drugbank`.`enzymes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`snp_adverse_drug_reaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`snp_adverse_drug_reaction` (
  `id` INT NOT NULL,
  `protein-name` CHAR(255) NOT NULL,
  `gene-symbol` CHAR(255) NOT NULL,
  `uniprot-id` CHAR(255) NOT NULL,
  `rs-id` CHAR(255) NOT NULL,
  `allele` CHAR(255) NOT NULL,
  `adverse-reaction` CHAR(255) NOT NULL,
  `description` CHAR(255) NOT NULL,
  `pubmed-id` CHAR(255) NOT NULL,
  `drug_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_snp_effect_drug1_idx` (`drug_id` ASC),
  CONSTRAINT `fk_snp_effect_drug10`
    FOREIGN KEY (`drug_id`)
    REFERENCES `drugbank`.`drug` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`polypeptide_synonym`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`polypeptide_synonym` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `polypeptide_id` CHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_polypeptide_synonym_polypeptide1_idx` (`polypeptide_id` ASC),
  CONSTRAINT `fk_polypeptide_synonym_polypeptide1`
    FOREIGN KEY (`polypeptide_id`)
    REFERENCES `drugbank`.`polypeptide` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`alternative_parent`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`alternative_parent` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `classification_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_alternative_parent_classification1_idx` (`classification_id` ASC),
  CONSTRAINT `fk_alternative_parent_classification1`
    FOREIGN KEY (`classification_id`)
    REFERENCES `drugbank`.`classification` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`substituent`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`substituent` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `classification_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_substituent_classification1_idx` (`classification_id` ASC),
  CONSTRAINT `fk_substituent_classification1`
    FOREIGN KEY (`classification_id`)
    REFERENCES `drugbank`.`classification` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`drug_enzyme`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`drug_enzyme` (
  `id` INT NOT NULL,
  `inhibition-strength` VARCHAR(45) NULL,
  `induction-strength` VARCHAR(45) NULL,
  `position` INT NULL,
  `drug_id` VARCHAR(45) NOT NULL,
  `interactant_group_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_drug_enzyme_drug1_idx` (`drug_id` ASC),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_drug_enzyme_interactant_group1_idx` (`interactant_group_id` ASC),
  CONSTRAINT `fk_drug_enzyme_drug1`
    FOREIGN KEY (`drug_id`)
    REFERENCES `drugbank`.`drug` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_drug_enzyme_interactant_group1`
    FOREIGN KEY (`interactant_group_id`)
    REFERENCES `drugbank`.`interactant_group` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `drugbank`.`drug_target`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drugbank`.`drug_target` (
  `id` INT NOT NULL,
  `position` INT NULL,
  `drug_id` VARCHAR(45) NOT NULL,
  `interactant_group_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_target_drug2_idx` (`drug_id` ASC),
  INDEX `fk_drug_target_interactant_group1_idx` (`interactant_group_id` ASC),
  CONSTRAINT `fk_target_drug2`
    FOREIGN KEY (`drug_id`)
    REFERENCES `drugbank`.`drug` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_drug_target_interactant_group1`
    FOREIGN KEY (`interactant_group_id`)
    REFERENCES `drugbank`.`interactant_group` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
