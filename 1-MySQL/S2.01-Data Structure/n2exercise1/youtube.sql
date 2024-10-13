-- MySQL Workbench Synchronization
-- Generated: 2024-10-13 23:27
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: alien

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `YouTube` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `YouTube`.`users` (
  `user_id` INT(11) NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `birthdate` DATE NOT NULL,
  `sex` VARCHAR(45) NULL DEFAULT NULL,
  `country` VARCHAR(45) NOT NULL,
  `postal_code` VARCHAR(5) NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `YouTube`.`videos` (
  `video_id` INT(11) NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  `size` DOUBLE NOT NULL,
  `file_name` VARCHAR(45) NOT NULL,
  `duration` TIME NOT NULL,
  `thumbnail` VARCHAR(45) NOT NULL,
  `views` INT(11) NOT NULL,
  `likes` INT(11) NOT NULL,
  `dislikes` INT(11) NOT NULL,
  `status` ENUM("public", "hidden", "private") NOT NULL,
  `upload_date` DATETIME NOT NULL,
  PRIMARY KEY (`video_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `YouTube`.`videos_likes_dislikes` (
  `user_id` INT(11) NOT NULL,
  `video_id` INT(11) NOT NULL,
  `reaction` ENUM("like", "dislike") NOT NULL,
  `reaction_date` DATETIME NOT NULL,
  PRIMARY KEY (`user_id`, `video_id`),
  INDEX `fk_users_has_videos_videos1_idx` (`video_id` ASC) VISIBLE,
  INDEX `fk_users_has_videos_users_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_users_has_videos_users`
    FOREIGN KEY (`user_id`)
    REFERENCES `YouTube`.`users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_users_has_videos_videos1`
    FOREIGN KEY (`video_id`)
    REFERENCES `YouTube`.`videos` (`video_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `YouTube`.`tags` (
  `tag_id` INT(11) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`tag_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `YouTube`.`videos_has_tags` (
  `video_id` INT(11) NOT NULL,
  `tag_id` INT(11) NOT NULL,
  PRIMARY KEY (`video_id`, `tag_id`),
  INDEX `fk_videos_has_tags_tags1_idx` (`tag_id` ASC) VISIBLE,
  INDEX `fk_videos_has_tags_videos1_idx` (`video_id` ASC) VISIBLE,
  CONSTRAINT `fk_videos_has_tags_videos1`
    FOREIGN KEY (`video_id`)
    REFERENCES `YouTube`.`videos` (`video_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_videos_has_tags_tags1`
    FOREIGN KEY (`tag_id`)
    REFERENCES `YouTube`.`tags` (`tag_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `YouTube`.`channels` (
  `channel_id` INT(11) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NULL DEFAULT NULL,
  `creation_date` DATETIME NOT NULL,
  `user_id` INT(11) NOT NULL,
  PRIMARY KEY (`channel_id`),
  INDEX `fk_channels_users1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_channels_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `YouTube`.`users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `YouTube`.`subscriptions` (
  `subscription_id` INT(11) NOT NULL,
  `channel_id` INT(11) NOT NULL,
  `user_id` INT(11) NOT NULL,
  PRIMARY KEY (`subscription_id`),
  INDEX `fk_channels_has_users_users1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_channels_has_users_channels1_idx` (`channel_id` ASC) VISIBLE,
  CONSTRAINT `fk_channels_has_users_channels1`
    FOREIGN KEY (`channel_id`)
    REFERENCES `YouTube`.`channels` (`channel_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_channels_has_users_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `YouTube`.`users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `YouTube`.`playlists` (
  `playlist_id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `creation_date` DATETIME NOT NULL,
  `status` ENUM("public", "private") NOT NULL,
  `user_id` INT(11) NOT NULL,
  PRIMARY KEY (`playlist_id`),
  INDEX `fk_playlists_users1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_playlists_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `YouTube`.`users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `YouTube`.`playlists_has_videos` (
  `playlist_id` INT(11) NOT NULL,
  `video_id` INT(11) NOT NULL,
  PRIMARY KEY (`playlist_id`, `video_id`),
  INDEX `fk_playlists_has_videos_videos1_idx` (`video_id` ASC) VISIBLE,
  INDEX `fk_playlists_has_videos_playlists1_idx` (`playlist_id` ASC) VISIBLE,
  CONSTRAINT `fk_playlists_has_videos_playlists1`
    FOREIGN KEY (`playlist_id`)
    REFERENCES `YouTube`.`playlists` (`playlist_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_playlists_has_videos_videos1`
    FOREIGN KEY (`video_id`)
    REFERENCES `YouTube`.`videos` (`video_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `YouTube`.`comments` (
  `comment_id` VARCHAR(45) NOT NULL,
  `comment_date` DATETIME NOT NULL,
  `text` VARCHAR(255) NOT NULL,
  `users_user_id` INT(11) NOT NULL,
  `videos_video_id` INT(11) NOT NULL,
  INDEX `fk_users_has_videos_videos2_idx` (`videos_video_id` ASC) VISIBLE,
  INDEX `fk_users_has_videos_users1_idx` (`users_user_id` ASC) VISIBLE,
  PRIMARY KEY (`comment_id`),
  CONSTRAINT `fk_users_has_videos_users1`
    FOREIGN KEY (`users_user_id`)
    REFERENCES `YouTube`.`users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_users_has_videos_videos2`
    FOREIGN KEY (`videos_video_id`)
    REFERENCES `YouTube`.`videos` (`video_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `YouTube`.`comments_likes_dislikes` (
  `users_user_id` INT(11) NOT NULL,
  `comments_comment_id` VARCHAR(45) NOT NULL,
  `reaction` ENUM("like", "dislike") NOT NULL,
  `reaction_date` DATETIME NOT NULL,
  PRIMARY KEY (`users_user_id`, `comments_comment_id`),
  INDEX `fk_users_has_comments_comments1_idx` (`comments_comment_id` ASC) VISIBLE,
  INDEX `fk_users_has_comments_users1_idx` (`users_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_users_has_comments_users1`
    FOREIGN KEY (`users_user_id`)
    REFERENCES `YouTube`.`users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_users_has_comments_comments1`
    FOREIGN KEY (`comments_comment_id`)
    REFERENCES `YouTube`.`comments` (`comment_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
