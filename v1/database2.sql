-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema cs04sec2_mysql
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema cs04sec2_mysql
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cs04sec2_mysql` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `cs04sec2_mysql` ;

-- -----------------------------------------------------
-- Table `cs04sec2_mysql`.`academicworks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs04sec2_mysql`.`academicworks` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ac_name` VARCHAR(200) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `ac_type` VARCHAR(50) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `ac_sourcetitle` VARCHAR(50) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `ac_year` DATE NULL DEFAULT NULL,
  `ac_refnumber` VARCHAR(75) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `ac_page` VARCHAR(45) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 76
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cs04sec2_mysql`.`authors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs04sec2_mysql`.`authors` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `author_fname` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `author_lname` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 707
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cs04sec2_mysql`.`author_of_academicworks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs04sec2_mysql`.`author_of_academicworks` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `author_type` INT NULL DEFAULT NULL,
  `author_id` BIGINT UNSIGNED NOT NULL,
  `academicwork_id` BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `author_of_academicworks_author_id_foreign` (`author_id` ASC) VISIBLE,
  INDEX `author_of_academicworks_academicwork_id_foreign` (`academicwork_id` ASC) VISIBLE,
  CONSTRAINT `author_of_academicworks_academicwork_id_foreign`
    FOREIGN KEY (`academicwork_id`)
    REFERENCES `cs04sec2_mysql`.`academicworks` (`id`)
    ON DELETE CASCADE,
  CONSTRAINT `author_of_academicworks_author_id_foreign`
    FOREIGN KEY (`author_id`)
    REFERENCES `cs04sec2_mysql`.`authors` (`id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 98
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cs04sec2_mysql`.`papers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs04sec2_mysql`.`papers` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `paper_name` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `abstract` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `paper_type` VARCHAR(55) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `paper_subtype` VARCHAR(55) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `paper_sourcetitle` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `keyword` LONGTEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_bin' NULL DEFAULT NULL,
  `paper_url` VARCHAR(150) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `publication` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `paper_yearpub` YEAR NULL DEFAULT NULL,
  `paper_volume` VARCHAR(20) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `paper_issue` VARCHAR(20) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `paper_citation` INT NULL DEFAULT NULL,
  `paper_page` VARCHAR(50) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `paper_doi` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `paper_funder` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `reference_number` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 574
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cs04sec2_mysql`.`author_of_papers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs04sec2_mysql`.`author_of_papers` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `author_id` BIGINT UNSIGNED NOT NULL,
  `paper_id` BIGINT UNSIGNED NOT NULL,
  `author_type` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `author_of_papers_author_id_foreign` (`author_id` ASC) VISIBLE,
  INDEX `author_of_papers_paper_id_foreign` (`paper_id` ASC) VISIBLE,
  CONSTRAINT `author_of_papers_author_id_foreign`
    FOREIGN KEY (`author_id`)
    REFERENCES `cs04sec2_mysql`.`authors` (`id`)
    ON DELETE CASCADE,
  CONSTRAINT `author_of_papers_paper_id_foreign`
    FOREIGN KEY (`paper_id`)
    REFERENCES `cs04sec2_mysql`.`papers` (`id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 1114
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cs04sec2_mysql`.`degrees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs04sec2_mysql`.`degrees` (
  `id` BIGINT UNSIGNED NOT NULL,
  `degree_name_th` VARCHAR(75) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `degree_name_en` VARCHAR(75) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `title_th` VARCHAR(10) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `title_en` VARCHAR(10) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cs04sec2_mysql`.`departments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs04sec2_mysql`.`departments` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `department_name_th` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `department_name_en` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cs04sec2_mysql`.`programs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs04sec2_mysql`.`programs` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `program_name_th` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `program_name_en` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `degree_id` BIGINT UNSIGNED NOT NULL,
  `department_id` BIGINT UNSIGNED NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `programs_degree_id_foreign` (`degree_id` ASC) VISIBLE,
  INDEX `department_id` (`department_id` ASC) VISIBLE,
  CONSTRAINT `department_id`
    FOREIGN KEY (`department_id`)
    REFERENCES `cs04sec2_mysql`.`departments` (`id`),
  CONSTRAINT `programs_degree_id_foreign`
    FOREIGN KEY (`degree_id`)
    REFERENCES `cs04sec2_mysql`.`degrees` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 26
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cs04sec2_mysql`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs04sec2_mysql`.`users` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `username` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `password` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `fname_en` VARCHAR(50) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `lname_en` VARCHAR(50) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `fname_th` VARCHAR(50) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `lname_th` VARCHAR(50) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `doctoral_degree` VARCHAR(5) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `academic_ranks_en` VARCHAR(25) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `academic_ranks_th` VARCHAR(25) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `position_en` VARCHAR(25) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `position_th` VARCHAR(25) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `title_name_th` VARCHAR(15) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `title_name_en` VARCHAR(15) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `picture` VARCHAR(155) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `status` INT NULL DEFAULT NULL,
  `email_verified_at` TIMESTAMP NULL DEFAULT NULL,
  `program_id` BIGINT UNSIGNED NULL DEFAULT NULL,
  `remember_token` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `users_email_unique` (`email` ASC) VISIBLE,
  UNIQUE INDEX `username` (`username` ASC) VISIBLE,
  INDEX `users_program_id_foreign` USING BTREE (`program_id`) VISIBLE,
  CONSTRAINT `users_program_id_foreign`
    FOREIGN KEY (`program_id`)
    REFERENCES `cs04sec2_mysql`.`programs` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 151
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cs04sec2_mysql`.`education`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs04sec2_mysql`.`education` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `uname` VARCHAR(150) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `qua_name` VARCHAR(150) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `level` INT NOT NULL,
  `user_id` BIGINT UNSIGNED NULL DEFAULT NULL,
  `year` VARCHAR(4) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `education_user_id_foreign` (`user_id` ASC) VISIBLE,
  CONSTRAINT `education_user_id_foreign`
    FOREIGN KEY (`user_id`)
    REFERENCES `cs04sec2_mysql`.`users` (`id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 86
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cs04sec2_mysql`.`expertises`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs04sec2_mysql`.`expertises` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `expert_name` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `user_id` BIGINT UNSIGNED NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `expertises_user_id_foreign` (`user_id` ASC) VISIBLE,
  CONSTRAINT `expertises_user_id_foreign`
    FOREIGN KEY (`user_id`)
    REFERENCES `cs04sec2_mysql`.`users` (`id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 225
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cs04sec2_mysql`.`failed_jobs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs04sec2_mysql`.`failed_jobs` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `connection` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `queue` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `payload` LONGTEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `exception` LONGTEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `failed_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `failed_jobs_uuid_unique` (`uuid` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cs04sec2_mysql`.`files`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs04sec2_mysql`.`files` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `file_path` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cs04sec2_mysql`.`funds`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs04sec2_mysql`.`funds` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fund_name` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `fund_details` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `fund_type` VARCHAR(10) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `fund_level` VARCHAR(10) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `fund_agency` VARCHAR(150) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `support_resource` VARCHAR(150) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `user_id` BIGINT UNSIGNED NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fund_user_id` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fund_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `cs04sec2_mysql`.`users` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 32
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cs04sec2_mysql`.`migrations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs04sec2_mysql`.`migrations` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `batch` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 32
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cs04sec2_mysql`.`permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs04sec2_mysql`.`permissions` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `guard_name` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `permissions_name_guard_name_unique` (`name` ASC, `guard_name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 52
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cs04sec2_mysql`.`model_has_permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs04sec2_mysql`.`model_has_permissions` (
  `permission_id` BIGINT UNSIGNED NOT NULL,
  `model_type` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `model_id` BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (`permission_id`, `model_id`, `model_type`),
  INDEX `model_has_permissions_model_id_model_type_index` (`model_id` ASC, `model_type` ASC) VISIBLE,
  CONSTRAINT `model_has_permissions_permission_id_foreign`
    FOREIGN KEY (`permission_id`)
    REFERENCES `cs04sec2_mysql`.`permissions` (`id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cs04sec2_mysql`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs04sec2_mysql`.`roles` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `guard_name` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `roles_name_guard_name_unique` (`name` ASC, `guard_name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cs04sec2_mysql`.`model_has_roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs04sec2_mysql`.`model_has_roles` (
  `role_id` BIGINT UNSIGNED NOT NULL,
  `model_type` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `model_id` BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (`role_id`, `model_id`, `model_type`),
  INDEX `model_has_roles_model_id_model_type_index` (`model_id` ASC, `model_type` ASC) VISIBLE,
  CONSTRAINT `model_has_roles_role_id_foreign`
    FOREIGN KEY (`role_id`)
    REFERENCES `cs04sec2_mysql`.`roles` (`id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cs04sec2_mysql`.`outsiders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs04sec2_mysql`.`outsiders` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fname` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `lname` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `title_name` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cs04sec2_mysql`.`research_projects`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs04sec2_mysql`.`research_projects` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `project_name` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `project_start` DATE NULL DEFAULT NULL,
  `project_end` DATE NULL DEFAULT NULL,
  `project_year` YEAR NULL DEFAULT NULL,
  `budget` INT NULL DEFAULT NULL,
  `responsible_department` VARCHAR(50) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `note` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `status` INT NOT NULL,
  `fund_id` BIGINT UNSIGNED NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fund_id` (`fund_id` ASC) VISIBLE,
  CONSTRAINT `projects_fund_id_foreign`
    FOREIGN KEY (`fund_id`)
    REFERENCES `cs04sec2_mysql`.`funds` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 46
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cs04sec2_mysql`.`outsiders_work_of_project`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs04sec2_mysql`.`outsiders_work_of_project` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `outsider_id` BIGINT UNSIGNED NOT NULL,
  `research_project_id` BIGINT UNSIGNED NOT NULL,
  `role` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `outsiders_work_of_project_outsider_id_foreign` (`outsider_id` ASC) VISIBLE,
  INDEX `outsiders_work_of_project_research_project_id_foreign` (`research_project_id` ASC) VISIBLE,
  CONSTRAINT `outsiders_work_of_project_outsider_id_foreign`
    FOREIGN KEY (`outsider_id`)
    REFERENCES `cs04sec2_mysql`.`outsiders` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `outsiders_work_of_project_research_project_id_foreign`
    FOREIGN KEY (`research_project_id`)
    REFERENCES `cs04sec2_mysql`.`research_projects` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cs04sec2_mysql`.`password_resets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs04sec2_mysql`.`password_resets` (
  `email` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `token` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  INDEX `password_resets_email_index` (`email` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cs04sec2_mysql`.`research_groups`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs04sec2_mysql`.`research_groups` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `group_name_th` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `group_name_en` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `group_detail_th` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `group_detail_en` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `group_desc_th` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `group_desc_en` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `group_image` VARCHAR(155) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cs04sec2_mysql`.`role_has_permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs04sec2_mysql`.`role_has_permissions` (
  `permission_id` BIGINT UNSIGNED NOT NULL,
  `role_id` BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (`permission_id`, `role_id`),
  INDEX `role_has_permissions_role_id_foreign` (`role_id` ASC) VISIBLE,
  CONSTRAINT `role_has_permissions_permission_id_foreign`
    FOREIGN KEY (`permission_id`)
    REFERENCES `cs04sec2_mysql`.`permissions` (`id`)
    ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign`
    FOREIGN KEY (`role_id`)
    REFERENCES `cs04sec2_mysql`.`roles` (`id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cs04sec2_mysql`.`source_data`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs04sec2_mysql`.`source_data` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `source_name` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cs04sec2_mysql`.`source_papers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs04sec2_mysql`.`source_papers` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `source_data_id` BIGINT UNSIGNED NOT NULL,
  `paper_id` BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `source_papers_source_data_id_foreign` (`source_data_id` ASC) VISIBLE,
  INDEX `source_papers_paper_id_foreign` (`paper_id` ASC) VISIBLE,
  CONSTRAINT `source_papers_paper_id_foreign`
    FOREIGN KEY (`paper_id`)
    REFERENCES `cs04sec2_mysql`.`papers` (`id`)
    ON DELETE CASCADE,
  CONSTRAINT `source_papers_source_data_id_foreign`
    FOREIGN KEY (`source_data_id`)
    REFERENCES `cs04sec2_mysql`.`source_data` (`id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 3875
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cs04sec2_mysql`.`user_of_academicworks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs04sec2_mysql`.`user_of_academicworks` (
  `user_id` BIGINT UNSIGNED NOT NULL,
  `author_type` INT NULL DEFAULT NULL,
  `academicwork_id` BIGINT UNSIGNED NOT NULL,
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  INDEX `user_of_academicworks_user_id_foreign` (`user_id` ASC) VISIBLE,
  INDEX `user_of_academicworks_academicwork_id_foreign` (`academicwork_id` ASC) VISIBLE,
  CONSTRAINT `user_of_academicworks_academicwork_id_foreign`
    FOREIGN KEY (`academicwork_id`)
    REFERENCES `cs04sec2_mysql`.`academicworks` (`id`)
    ON DELETE CASCADE,
  CONSTRAINT `user_of_academicworks_user_id_foreign`
    FOREIGN KEY (`user_id`)
    REFERENCES `cs04sec2_mysql`.`users` (`id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 74
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cs04sec2_mysql`.`user_papers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs04sec2_mysql`.`user_papers` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `paper_id` BIGINT UNSIGNED NOT NULL,
  `author_type` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `user_papers_user_id_foreign` USING BTREE (`user_id`) VISIBLE,
  INDEX `user_papers_paper_id_foreign` USING BTREE (`paper_id`) VISIBLE,
  CONSTRAINT `user_papers_paper_id_foreign`
    FOREIGN KEY (`paper_id`)
    REFERENCES `cs04sec2_mysql`.`papers` (`id`)
    ON DELETE CASCADE,
  CONSTRAINT `user_papers_user_id_foreign`
    FOREIGN KEY (`user_id`)
    REFERENCES `cs04sec2_mysql`.`users` (`id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 707
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cs04sec2_mysql`.`work_of_research_groups`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs04sec2_mysql`.`work_of_research_groups` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `role` INT NOT NULL,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `research_group_id` BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `work_of_research_groups_user_id_foreign` (`user_id` ASC) VISIBLE,
  INDEX `work_of_research_groups_research_group_id_foreign` (`research_group_id` ASC) VISIBLE,
  CONSTRAINT `work_of_research_groups_research_group_id_foreign`
    FOREIGN KEY (`research_group_id`)
    REFERENCES `cs04sec2_mysql`.`research_groups` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `work_of_research_groups_user_id_foreign`
    FOREIGN KEY (`user_id`)
    REFERENCES `cs04sec2_mysql`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 117
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cs04sec2_mysql`.`work_of_research_projects`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs04sec2_mysql`.`work_of_research_projects` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `role` INT NOT NULL,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `research_project_id` BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `work_of_research_projects_user_id_foreign` (`user_id` ASC) VISIBLE,
  INDEX `work_of_research_projects_research_project_id_foreign` (`research_project_id` ASC) VISIBLE,
  CONSTRAINT `work_of_research_projects_research_project_id_foreign`
    FOREIGN KEY (`research_project_id`)
    REFERENCES `cs04sec2_mysql`.`research_projects` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `work_of_research_projects_user_id_foreign`
    FOREIGN KEY (`user_id`)
    REFERENCES `cs04sec2_mysql`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 102
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cs04sec2_mysql`.`model_has_roles_has_users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs04sec2_mysql`.`model_has_roles_has_users` (
  `model_has_roles_role_id` BIGINT UNSIGNED NOT NULL,
  `model_has_roles_model_id` BIGINT UNSIGNED NOT NULL,
  `model_has_roles_model_type` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `users_id` BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (`model_has_roles_role_id`, `model_has_roles_model_id`, `model_has_roles_model_type`, `users_id`),
  INDEX `fk_model_has_roles_has_users_users1_idx` (`users_id` ASC) VISIBLE,
  INDEX `fk_model_has_roles_has_users_model_has_roles1_idx` (`model_has_roles_role_id` ASC, `model_has_roles_model_id` ASC, `model_has_roles_model_type` ASC) VISIBLE,
  CONSTRAINT `fk_model_has_roles_has_users_model_has_roles1`
    FOREIGN KEY (`model_has_roles_role_id` , `model_has_roles_model_id` , `model_has_roles_model_type`)
    REFERENCES `cs04sec2_mysql`.`model_has_roles` (`role_id` , `model_id` , `model_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_model_has_roles_has_users_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `cs04sec2_mysql`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cs04sec2_mysql`.`users_has_model_has_roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs04sec2_mysql`.`users_has_model_has_roles` (
  `users_id` BIGINT UNSIGNED NOT NULL,
  `model_has_roles_role_id` BIGINT UNSIGNED NOT NULL,
  `model_has_roles_model_id` BIGINT UNSIGNED NOT NULL,
  `model_has_roles_model_type` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  PRIMARY KEY (`users_id`, `model_has_roles_role_id`, `model_has_roles_model_id`, `model_has_roles_model_type`),
  INDEX `fk_users_has_model_has_roles_model_has_roles1_idx` (`model_has_roles_role_id` ASC, `model_has_roles_model_id` ASC, `model_has_roles_model_type` ASC) VISIBLE,
  INDEX `fk_users_has_model_has_roles_users1_idx` (`users_id` ASC) VISIBLE,
  CONSTRAINT `fk_users_has_model_has_roles_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `cs04sec2_mysql`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_has_model_has_roles_model_has_roles1`
    FOREIGN KEY (`model_has_roles_role_id` , `model_has_roles_model_id` , `model_has_roles_model_type`)
    REFERENCES `cs04sec2_mysql`.`model_has_roles` (`role_id` , `model_id` , `model_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cs04sec2_mysql`.`users_has_roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs04sec2_mysql`.`users_has_roles` (
  `users_id` BIGINT UNSIGNED NOT NULL,
  `roles_id` BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (`users_id`, `roles_id`),
  INDEX `fk_users_has_roles_roles1_idx` (`roles_id` ASC) VISIBLE,
  INDEX `fk_users_has_roles_users1_idx` (`users_id` ASC) VISIBLE,
  CONSTRAINT `fk_users_has_roles_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `cs04sec2_mysql`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_has_roles_roles1`
    FOREIGN KEY (`roles_id`)
    REFERENCES `cs04sec2_mysql`.`roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cs04sec2_mysql`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs04sec2_mysql`.`category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cs04sec2_mysql`.`highlight`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs04sec2_mysql`.`highlight` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `image` VARCHAR(45) NULL,
  `title` VARCHAR(45) NULL,
  `description` VARCHAR(45) NULL,
  `status` TINYINT NULL,
  `category_id` INT NOT NULL,
  PRIMARY KEY (`id`, `category_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_highlight_category1_idx` (`category_id` ASC) VISIBLE,
  CONSTRAINT `fk_highlight_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `cs04sec2_mysql`.`category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cs04sec2_mysql`.`image_collection`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs04sec2_mysql`.`image_collection` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `image` VARCHAR(45) NULL,
  `highlight_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idimage_collection_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_image_collection_highlight1_idx` (`highlight_id` ASC) VISIBLE,
  CONSTRAINT `fk_image_collection_highlight1`
    FOREIGN KEY (`highlight_id`)
    REFERENCES `cs04sec2_mysql`.`highlight` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
