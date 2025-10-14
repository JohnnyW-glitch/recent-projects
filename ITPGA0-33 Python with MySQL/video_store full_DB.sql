-- =================================================================
-- ITPGA0 - Project 1
-- Database Video Store
-- Author:John Wesley Williams
-- Date: 2025/08/25
-- Purpose: To create a database that stores information of movies and clients that can accessed in python
-- =================================================================

-- Create the database
DROP DATABASE IF EXISTS video_store;
CREATE DATABASE video_store
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;
USE video_store;

-- =================================================================
-- TABLE CREATION SECTION
-- Author: John Wesley Williams
-- Date: 2025/08/25
-- Description: Creating the tables needed for this database
-- =================================================================

-- Create the tables for the database
CREATE TABLE IF NOT EXISTS customers 
(
	custId INT AUTO_INCREMENT,
	fname VARCHAR(40) NOT NULL,
	sname VARCHAR(40) NOT NULL,
	address VARCHAR(40) NOT NULL,
	phone VARCHAR(10) NOT NULL UNIQUE,
	PRIMARY KEY (custId) 
);

CREATE TABLE IF NOT EXISTS videos 
(
	videoId INT NOT NULL,
	videoVer INT NOT NULL,
	vname VARCHAR(15) NOT NULL,
	type VARCHAR(1) NOT NULL,
	dateAdded DATE NOT NULL,
	PRIMARY KEY (videoId, videoVer)
);

CREATE TABLE IF NOT EXISTS hire 
(
	custId INT NOT NULL,
	videoId INT NOT NULL,
	videoVer INT NOT NULL,
	dateHired DATE NOT NULL,
	dateReturn DATE,
	FOREIGN KEY (custId) REFERENCES customers(custId),
    FOREIGN KEY (videoId, videoVer) REFERENCES videos(videoId, videoVer)
);

-- =================================================================
-- SAMPLE DATA INSERTION
-- Author: John Wesley Williams
-- Date: 2025/08/25
-- Description: Inserting data into the created tables
-- =================================================================

-- Insert data into the customers table
INSERT INTO customers (fname, sname, address, phone) VALUES
('John', 'Smith', '123 Oak Street, Dublin', '0831234567'),
('Sarah', 'Johnson', '45 Maple Avenue, Cork', '0876543210'),
('Michael', 'Brown', '78 Pine Road, Galway', '0861122334'),
('Emma', 'Davis', '22 Birch Lane, Limerick', '0859988776'),
('David', 'Wilson', '9 Elm Street, Waterford', '0834455667');

-- Insert into the videos table
INSERT INTO videos (videoId, videoVer, vname, type, dateAdded) VALUES
(101, 1, 'The Matrix', 'B', '2023-01-15'),
(102, 2, 'The Matrix', 'R', '2023-02-20'),
(103, 1, 'Inception', 'B', '2023-03-10'),
(104, 1, 'Toy Story', 'R', '2023-01-25'),
(105, 1, 'The Dark Knight', 'B', '2023-04-05'),
(106, 1, 'Frozen', 'R', '2023-02-12'),
(107, 1, 'Interstellar', 'R', '2023-03-28'),
(108, 1, 'Shrek', 'B', '2023-01-08'),
(109, 1, 'Avatar', 'B', '2023-04-18'),
(110, 2, 'Avatar', 'R', '2023-02-03');

-- Displaying yhe tables and the database
SHOW TABLES;

DESCRIBE customers;
SELECT * FROM customers;

DESCRIBE videos;
SELECT * FROM videos;

DESCRIBE hire