CREATE DATABASE AcademyDB;
GO

USE AcademyDB;

CREATE TABLE Students (
    Id INT PRIMARY KEY IDENTITY(1,1),
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    BirthDate DATE NULL,
    Gender CHAR(1) NOT NULL CHECK (Gender IN ('M', 'F')),
    CreatedAt DATETIME DEFAULT GETDATE()
);

INSERT INTO Students (FullName, Email, BirthDate, Gender)
VALUES 
('Aysu Ahmadova', 'aysu@gmail.com', '2003-05-10', 'F'),
('Ali Aliyev', 'ali@gmail.com', '2002-03-15', 'M'),
('Nigar Mammadova', 'nigar@gmail.com', '2004-07-20', 'F');

CREATE TABLE Groups (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(50) NOT NULL UNIQUE,
    Capacity INT NOT NULL CHECK (Capacity >= 5)
);

INSERT INTO Groups (Name, Capacity)
VALUES 
('P414', 20),
('P415', 18),
('P416', 25);

CREATE TABLE StudentGroups (
    Id INT PRIMARY KEY IDENTITY(1,1),
    StudentId INT NOT NULL,
    GroupId INT NOT NULL,

    CONSTRAINT FK_StudentGroups_Students 
        FOREIGN KEY (StudentId) REFERENCES Students(Id),

    CONSTRAINT FK_StudentGroups_Groups 
        FOREIGN KEY (GroupId) REFERENCES Groups(Id),

    CONSTRAINT UQ_Student_Group UNIQUE (StudentId, GroupId)
);

INSERT INTO StudentGroups (StudentId, GroupId)
VALUES
(1, 1),
(2, 1),
(3, 2);

SELECT * FROM Students;
SELECT * FROM Groups;
SELECT * FROM StudentGroups;

SELECT 
    s.FullName,
    s.Email,
    g.Name AS GroupName
FROM StudentGroups sg
JOIN Students s ON sg.StudentId = s.Id
JOIN Groups g ON sg.GroupId = g.Id;