-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema University
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `University` ;

-- -----------------------------------------------------
-- Schema University
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `University` DEFAULT CHARACTER SET utf8 ;
USE `University` ;

-- -----------------------------------------------------
-- Table `University`.`term`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `University`.`term` (
  `term_id` INT NOT NULL AUTO_INCREMENT,
  `term_name` VARCHAR(20) NOT NULL,
  `term_year` YEAR NOT NULL,
  PRIMARY KEY (`term_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`college`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `University`.`college` (
  `college_id` INT NOT NULL AUTO_INCREMENT,
  `college_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`college_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `University`.`department` (
  `department_id` INT NOT NULL AUTO_INCREMENT,
  `department_name` VARCHAR(45) NOT NULL,
  `department_code` VARCHAR(10) NOT NULL,
  `college_id` INT NOT NULL,
  PRIMARY KEY (`department_id`),
  INDEX `fk_department_college1_idx` (`college_id` ASC) VISIBLE,
  CONSTRAINT `fk_department_college1`
    FOREIGN KEY (`college_id`)
    REFERENCES `University`.`college` (`college_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `University`.`course` (
  `course_id` INT NOT NULL AUTO_INCREMENT,
  `course_title` VARCHAR(45) NOT NULL,
  `course_number` SMALLINT NOT NULL,
  `credits` TINYINT NOT NULL,
  `department_id` INT NOT NULL,
  PRIMARY KEY (`course_id`),
  INDEX `fk_course_department1_idx` (`department_id` ASC) VISIBLE,
  CONSTRAINT `fk_course_department1`
    FOREIGN KEY (`department_id`)
    REFERENCES `University`.`department` (`department_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`faculty`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `University`.`faculty` (
  `faculty_id` INT NOT NULL AUTO_INCREMENT,
  `faculty_fname` VARCHAR(20) NOT NULL,
  `faculty_lname` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`faculty_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`section`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `University`.`section` (
  `section_id` INT NOT NULL AUTO_INCREMENT,
  `section_number` INT NOT NULL,
  `capacity` SMALLINT NOT NULL,
  `term_id` INT NOT NULL,
  `course_id` INT NOT NULL,
  `faculty_id` INT NOT NULL,
  PRIMARY KEY (`section_id`, `term_id`, `course_id`, `faculty_id`),
  INDEX `fk_section_term1_idx` (`term_id` ASC) VISIBLE,
  INDEX `fk_section_course1_idx` (`course_id` ASC) VISIBLE,
  INDEX `fk_section_faculty1_idx` (`faculty_id` ASC) VISIBLE,
  CONSTRAINT `fk_section_term1`
    FOREIGN KEY (`term_id`)
    REFERENCES `University`.`term` (`term_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_section_course1`
    FOREIGN KEY (`course_id`)
    REFERENCES `University`.`course` (`course_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_section_faculty1`
    FOREIGN KEY (`faculty_id`)
    REFERENCES `University`.`faculty` (`faculty_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `University`.`student` (
  `student_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(20) NOT NULL,
  `last_name` VARCHAR(20) NOT NULL,
  `gender` ENUM("M", "F") NOT NULL,
  `city` VARCHAR(20) NOT NULL,
  `state` CHAR(2) NOT NULL,
  `birthdate` DATE NOT NULL,
  PRIMARY KEY (`student_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`enrollment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `University`.`enrollment` (
  `section_id` INT NOT NULL,
  `student_id` INT NOT NULL,
  PRIMARY KEY (`section_id`, `student_id`),
  INDEX `fk_section_has_student_student1_idx` (`student_id` ASC) VISIBLE,
  INDEX `fk_section_has_student_section_idx` (`section_id` ASC) VISIBLE,
  CONSTRAINT `fk_section_has_student_section`
    FOREIGN KEY (`section_id`)
    REFERENCES `University`.`section` (`section_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_section_has_student_student1`
    FOREIGN KEY (`student_id`)
    REFERENCES `University`.`student` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



-- -----------------------------------------------------
-- Load the University Database
-- -----------------------------------------------------

INSERT INTO term VALUES 
	(1, "Fall", 2019),
    (2, "Winter", 2018);
    
 INSERT INTO college VALUES 
	(1, "College of Physical Science and Engineering"),
	(2, "College of Business and Communication"),
	(3, "College of Language and Letters");   
    
INSERT INTO department VALUES 
	(1, "Computer Information Technology", "CIT", 1),
    (2, "Economics", "ECON", 2),
    (3, "Humanities and Philosophy", "HUM", 3);

INSERT INTO course VALUES 
	(1, "Intro to Databases", 111, 3, 1),
	(2, "Econometrics", 388, 4, 2),
	(3, "Micro Economics", 150, 3, 2),
	(4, "Classical Heritage", 376, 2, 3);

INSERT INTO faculty VALUES 
	(1, "Marty", "Morring"),
	(2, "Nate", "Norris"),
	(3, "Ben", "Barrus"),
	(4, "John", "Jensen"),
	(5, "Bill", "Barney");
    
INSERT INTO section VALUES 
	(1, 1, 30, 1, 1, 1),
	(2, 1, 50, 1, 3, 2),
	(3, 2, 50, 1, 3, 2),
	(4, 1, 35, 1, 2, 3),
	(5, 1, 30, 1, 4, 4),
	(6, 2, 30, 2, 1, 1),
	(7, 3, 35, 2, 1, 5),
	(8, 1, 50, 2, 3, 2),
	(9, 2, 50, 2, 3, 2),
	(10, 1, 30, 2, 4, 4);

INSERT INTO student VALUES
	(1, "Paul", "Miller", "M", "Dallas", "TX", "1996-02-22"),
	(2, "Katie", "Smith", "F", "Provo", "UT", "1995-07-22"),
    (3, "Kelly", "Jones", "F", "Provo", "UT", "1998-06-22"),
    (4, "Devon", "Merrill", "M", "Mesa", "AZ", "2000-07-22"),
    (5, "Mandy", "Murdock", "F", "Topeka", "KS", "1996-11-22"),
    (6, "Alece", "Adams", "F", "Rigby", "ID", "1997-05-22"),
    (7, "Bryce", "Carlson", "M", "Bozeman", "MT", "1997-11-22"),
    (8, "Preston", "Larsen", "M", "Decatur", "TN", "1996-09-22"),
    (9, "Julia", "Madsen", "F", "Rexburg", "ID", "1998-09-22"),
    (10, "Susan", "Sorensen", "F", "Mesa", "AZ", "1998-08-09");

INSERT INTO enrollment VALUES
	(7, 6),
    (6, 7),
    (8, 7),
    (10, 7),
    (5, 4),
    (9, 9),
    (4, 2),
    (4, 3),
    (4, 5),
    (5, 5),
    (1, 1),
    (3, 1),
    (9, 8),
    (6, 10);

-- -----------------------------------------------------
-- Query the University Database
-- -----------------------------------------------------
USE University;

-- Query #1 
SELECT first_name, last_name, DATE_FORMAT(birthdate, "%M %d, %Y") AS "Sept Birthdays"
FROM student 
WHERE MONTH(birthdate) = 9
ORDER BY last_name;

-- Query #2
SELECT first_name, last_name, 
	FLOOR(DATEDIFF("2017-01-05", birthdate) / 365) AS "Years",
    DATEDIFF("2017-01-05", birthdate) % 365 AS "Days",
    CONCAT(FLOOR(DATEDIFF("2017-01-05", birthdate) / 365), " - Yrs, ", DATEDIFF("2017-01-05", birthdate) % 365, " - Days") AS "Years and Days"
FROM student 
ORDER BY birthdate;

-- Query #3 
SELECT first_name, last_name
FROM student 
	JOIN enrollment
		ON student.student_id = enrollment.student_id
	JOIN section
		ON enrollment.section_id = section.section_id 
	JOIN faculty
		ON section.faculty_id = faculty.faculty_id
WHERE faculty.faculty_id = 4
ORDER BY last_name;

-- Query #4 
SELECT faculty_fname, faculty_lname
FROM student 
	JOIN enrollment
		ON student.student_id = enrollment.student_id
	JOIN section
		ON enrollment.section_id = section.section_id 
	JOIN faculty
		ON section.faculty_id = faculty.faculty_id
WHERE student.student_id = 7
ORDER BY faculty_lname;

-- Query #5 
SELECT first_name, last_name
FROM student 
	JOIN enrollment
		ON student.student_id = enrollment.student_id
	JOIN section
		ON enrollment.section_id = section.section_id 
WHERE term_id = 1 AND course_id = 2
ORDER BY last_name;

-- Query #6 
SELECT department_code, course_number, course_title
FROM student 
	JOIN enrollment
		ON student.student_id = enrollment.student_id
	JOIN section
		ON enrollment.section_id = section.section_id 
 	JOIN course
		ON section.course_id = course.course_id
	JOIN department
		ON course.department_id = department.department_id
WHERE student.student_id = 7 AND term_id = 2
ORDER BY course_title;

-- Query #7 
SELECT term_name AS "Term", term_year AS "Year", COUNT(student.student_id) AS "Enrollment"
FROM student 
	JOIN enrollment
		ON student.student_id = enrollment.student_id
	JOIN section
		ON enrollment.section_id = section.section_id 
	JOIN term
		ON section.term_id = term.term_id
WHERE term.term_id = 1;

-- Query #8 
SELECT college_name AS "Colleges", COUNT(course.course_id) AS "Courses"
FROM course
	JOIN department
		ON course.department_id = department.college_id
	JOIN college
		ON department.college_id = college.college_id
GROUP BY college_name
ORDER BY college_name;	

-- Query #9 
SELECT faculty_fname, faculty_lname, SUM(capacity) AS "TeachingCapacity"
FROM section
	JOIN faculty
		ON section.faculty_id = faculty.faculty_id
WHERE section.term_id = 2
GROUP BY faculty_fname, faculty_lname
ORDER BY TeachingCapacity;

-- Query #10 
SELECT last_name, first_name, SUM(credits) AS "Credits"
FROM student 
	JOIN enrollment
		ON student.student_id = enrollment.student_id
	JOIN section
		ON enrollment.section_id = section.section_id 
	JOIN course
		ON section.course_id = course.course_id
	JOIN term
		ON section.term_id = term.term_id
WHERE term.term_id = 1
GROUP BY last_name, first_name
	HAVING SUM(credits) > 3
ORDER BY Credits DESC
