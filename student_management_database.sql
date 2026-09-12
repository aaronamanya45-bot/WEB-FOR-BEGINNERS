-- Student Management Database
-- Beginner Database Coursework Project
-- Author: Amanya Aaron
--
-- This database demonstrates:
-- 1. Creating tables
-- 2. Primary keys and foreign keys
-- 3. Inserting records
-- 4. SELECT queries
-- 5. UPDATE and DELETE
-- 6. JOIN queries

CREATE DATABASE student_management;
USE student_management;

-- =========================
-- 1. CREATE TABLES
-- =========================

CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender VARCHAR(10),
    email VARCHAR(100) UNIQUE,
    course_id INT,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

CREATE TABLE Lecturers (
    lecturer_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

CREATE TABLE Results (
    result_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    marks DECIMAL(5,2),
    grade VARCHAR(2),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- =========================
-- 2. INSERT SAMPLE DATA
-- =========================

INSERT INTO Departments VALUES
(1, 'Information Technology'),
(2, 'Business Administration'),
(3, 'Computer Science');

INSERT INTO Courses VALUES
(101, 'Bachelor of Science in Information Technology', 1),
(102, 'Bachelor of Business Administration', 2),
(103, 'Bachelor of Science in Computer Science', 3);

INSERT INTO Students VALUES
(1001, 'Aaron', 'Amanya', 'Male', 'aaron@example.com', 101),
(1002, 'John', 'Okello', 'Male', 'john@example.com', 101),
(1003, 'Mary', 'Auma', 'Female', 'mary@example.com', 103),
(1004, 'Sarah', 'Nabirye', 'Female', 'sarah@example.com', 102);

INSERT INTO Lecturers VALUES
(501, 'Peter', 'Mugisha', 'peter@example.com', 1),
(502, 'Grace', 'Namatovu', 'grace@example.com', 3),
(503, 'David', 'Okoth', 'david@example.com', 2);

INSERT INTO Enrollments VALUES
(1, 1001, 101, '2026-08-01'),
(2, 1002, 101, '2026-08-01'),
(3, 1003, 103, '2026-08-02'),
(4, 1004, 102, '2026-08-02');

INSERT INTO Results VALUES
(1, 1001, 101, 82.00, 'A'),
(2, 1002, 101, 68.00, 'B'),
(3, 1003, 103, 74.00, 'B'),
(4, 1004, 102, 59.00, 'C');

-- =========================
-- 3. BASIC SELECT QUERIES
-- =========================

-- Display all students
SELECT * FROM Students;

-- Display all courses
SELECT * FROM Courses;

-- Display students with their email addresses
SELECT first_name, last_name, email
FROM Students;

-- Display students whose marks are above 70
SELECT student_id, marks, grade
FROM Results
WHERE marks > 70;

-- =========================
-- 4. UPDATE AND DELETE
-- =========================

-- Example UPDATE
UPDATE Students
SET email = 'aaron.amanya@example.com'
WHERE student_id = 1001;

-- Example DELETE
-- Uncomment only when you want to remove a record.
-- DELETE FROM Students WHERE student_id = 1004;

-- =========================
-- 5. JOIN QUERIES
-- =========================

-- Students and their courses
SELECT
    Students.first_name,
    Students.last_name,
    Courses.course_name
FROM Students
JOIN Courses
ON Students.course_id = Courses.course_id;

-- Students and their results
SELECT
    Students.first_name,
    Students.last_name,
    Results.marks,
    Results.grade
FROM Students
JOIN Results
ON Students.student_id = Results.student_id;

-- Students, courses and results
SELECT
    Students.first_name,
    Students.last_name,
    Courses.course_name,
    Results.marks,
    Results.grade
FROM Students
JOIN Results
ON Students.student_id = Results.student_id
JOIN Courses
ON Results.course_id = Courses.course_id;

-- =========================
-- 6. USEFUL SUMMARY QUERIES
-- =========================

-- Count the number of students
SELECT COUNT(*) AS total_students
FROM Students;

-- Find the highest mark
SELECT MAX(marks) AS highest_mark
FROM Results;

-- Find the lowest mark
SELECT MIN(marks) AS lowest_mark
FROM Results;

-- Find the average mark
SELECT AVG(marks) AS average_mark
FROM Results;

-- Sort students by marks from highest to lowest
SELECT
    Students.first_name,
    Students.last_name,
    Results.marks
FROM Students
JOIN Results
ON Students.student_id = Results.student_id
ORDER BY Results.marks DESC;
