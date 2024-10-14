-- MySQL Workbench Synchronization
-- Generated: 2024-10-14 17:12
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: alien

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `spotify` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `spotify`.`users` (
  `user_id` INT(11) NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `birthdate` DATE NULL DEFAULT NULL,
  `sex` VARCHAR(45) NULL DEFAULT NULL,
  `country` VARCHAR(45) NOT NULL,
  `postal_code` VARCHAR(5) NULL DEFAULT NULL,
  `account` ENUM("free", "premium") NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`subscriptions` (
  `subscription_id` INT(11) NOT NULL AUTO_INCREMENT,
  `start_date` DATETIME NOT NULL,
  `renovation_date` DATETIME NOT NULL,
  `payment` ENUM("card", "paypal") NOT NULL,
  `user_id` INT(11) NOT NULL,
  PRIMARY KEY (`subscription_id`),
  INDEX `fk_subscriptions_users1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_subscriptions_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `spotify`.`users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`payments` (
  `payment_id` INT(11) NOT NULL AUTO_INCREMENT,
  `order_number` INT(11) NOT NULL,
  `total_price` FLOAT(11) NOT NULL,
  `paypal_id` INT(11) NOT NULL,
  `card_id` INT(11) NOT NULL,
  `subscription_id` INT(11) NOT NULL,
  PRIMARY KEY (`payment_id`),
  INDEX `fk_payments_paypal1_idx` (`paypal_id` ASC) VISIBLE,
  INDEX `fk_payments_cards1_idx` (`card_id` ASC) VISIBLE,
  INDEX `fk_payments_subscriptions1_idx` (`subscription_id` ASC) VISIBLE,
  CONSTRAINT `fk_payments_paypal1`
    FOREIGN KEY (`paypal_id`)
    REFERENCES `spotify`.`paypal` (`paypal_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_payments_cards1`
    FOREIGN KEY (`card_id`)
    REFERENCES `spotify`.`cards` (`card_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_payments_subscriptions1`
    FOREIGN KEY (`subscription_id`)
    REFERENCES `spotify`.`subscriptions` (`subscription_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`paypal` (
  `paypal_id` INT(11) NOT NULL AUTO_INCREMENT,
  `username_paypal` INT(11) NOT NULL,
  PRIMARY KEY (`paypal_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`cards` (
  `card_id` INT(11) NOT NULL AUTO_INCREMENT,
  `number_card` INT(11) NOT NULL,
  `expiration` DATE NOT NULL,
  `security_code` INT(11) NOT NULL,
  PRIMARY KEY (`card_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`artists` (
  `artist_id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `image` VARCHAR(155) NULL DEFAULT NULL,
  PRIMARY KEY (`artist_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`related_artists` (
  `artist_id` INT(11) NOT NULL,
  `related_artist_id` INT(11) NOT NULL,
  PRIMARY KEY (`artist_id`, `related_artist_id`),
  INDEX `fk_related_artists_artists1_idx` (`artist_id` ASC) VISIBLE,
  INDEX `fk_related_artists_artists2_idx` (`related_artist_id` ASC) VISIBLE,
  CONSTRAINT `fk_related_artists_artists1`
    FOREIGN KEY (`artist_id`)
    REFERENCES `spotify`.`artists` (`artist_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_related_artists_artists2`
    FOREIGN KEY (`related_artist_id`)
    REFERENCES `spotify`.`artists` (`artist_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`followers` (
  `artist_id` INT(11) NOT NULL,
  `user_id` INT(11) NOT NULL,
  PRIMARY KEY (`artist_id`, `user_id`),
  INDEX `fk_users_has_artists_artists1_idx` (`artist_id` ASC) VISIBLE,
  INDEX `fk_users_has_artists_users1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_users_has_artists_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `spotify`.`users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_users_has_artists_artists1`
    FOREIGN KEY (`artist_id`)
    REFERENCES `spotify`.`artists` (`artist_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`albums` (
  `album_id` INT(11) NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `year` DATE NOT NULL,
  `image` VARCHAR(155) NOT NULL,
  `artist_id` INT(11) NOT NULL,
  PRIMARY KEY (`album_id`),
  INDEX `fk_albums_artists1_idx` (`artist_id` ASC) VISIBLE,
  UNIQUE INDEX `image_UNIQUE` (`image` ASC) VISIBLE,
  UNIQUE INDEX `artist_id_UNIQUE` (`artist_id` ASC) VISIBLE,
  CONSTRAINT `fk_albums_artists1`
    FOREIGN KEY (`artist_id`)
    REFERENCES `spotify`.`artists` (`artist_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`favourites` (
  `album_id` INT(11) NOT NULL,
  `user_id` INT(11) NOT NULL,
  PRIMARY KEY (`album_id`, `user_id`),
  INDEX `fk_albums_has_users_users1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_albums_has_users_albums1_idx` (`album_id` ASC) VISIBLE,
  CONSTRAINT `fk_albums_has_users_albums1`
    FOREIGN KEY (`album_id`)
    REFERENCES `spotify`.`albums` (`album_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_albums_has_users_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `spotify`.`users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`songs` (
  `song_id` INT(11) NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `plays` INT(11) NOT NULL,
  `album_id` INT(11) NOT NULL,
  PRIMARY KEY (`song_id`),
  INDEX `fk_songs_albums1_idx` (`album_id` ASC) VISIBLE,
  CONSTRAINT `fk_songs_albums1`
    FOREIGN KEY (`album_id`)
    REFERENCES `spotify`.`albums` (`album_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`favourites` (
  `song_id` INT(11) NOT NULL,
  `user_id` INT(11) NOT NULL,
  PRIMARY KEY (`song_id`, `user_id`),
  INDEX `fk_songs_has_users_users1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_songs_has_users_songs1_idx` (`song_id` ASC) VISIBLE,
  CONSTRAINT `fk_songs_has_users_songs1`
    FOREIGN KEY (`song_id`)
    REFERENCES `spotify`.`songs` (`song_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_songs_has_users_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `spotify`.`users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`playlists` (
  `playlist_id` INT(11) NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `songs` INT(11) NULL DEFAULT NULL,
  `creation_date` DATETIME NOT NULL,
  `deleted` TINYINT(4) NOT NULL,
  `user_id` INT(11) NOT NULL,
  PRIMARY KEY (`playlist_id`),
  INDEX `fk_playlists_users1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_playlists_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `spotify`.`users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`playlist_has_songs` (
  `playlist_id` INT(11) NOT NULL,
  `song_id` INT(11) NOT NULL,
  PRIMARY KEY (`playlist_id`, `song_id`),
  INDEX `fk_songs_has_playlists_playlists1_idx` (`playlist_id` ASC) VISIBLE,
  INDEX `fk_songs_has_playlists_songs1_idx` (`song_id` ASC) VISIBLE,
  CONSTRAINT `fk_songs_has_playlists_songs1`
    FOREIGN KEY (`song_id`)
    REFERENCES `spotify`.`songs` (`song_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_songs_has_playlists_playlists1`
    FOREIGN KEY (`playlist_id`)
    REFERENCES `spotify`.`playlists` (`playlist_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`deactivated` (
  `playlist_id` INT(11) NOT NULL,
  `elimination_date` DATETIME NOT NULL,
  PRIMARY KEY (`playlist_id`),
  CONSTRAINT `fk_deactivated_playlists1`
    FOREIGN KEY (`playlist_id`)
    REFERENCES `spotify`.`playlists` (`playlist_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`shared_playlists` (
  `playlist_id` INT(11) NOT NULL,
  `user_id` INT(11) NOT NULL,
  `date_added` DATETIME NOT NULL,
  PRIMARY KEY (`playlist_id`, `user_id`),
  INDEX `fk_playlists_has_users_users1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_playlists_has_users_playlists1_idx` (`playlist_id` ASC) VISIBLE,
  CONSTRAINT `fk_playlists_has_users_playlists1`
    FOREIGN KEY (`playlist_id`)
    REFERENCES `spotify`.`playlists` (`playlist_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_playlists_has_users_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `spotify`.`users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
