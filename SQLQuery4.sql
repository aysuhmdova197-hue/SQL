CREATE DATABASE CinemaDB;
GO

USE CinemaDB;
GO

CREATE TABLE Genres (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(50) NOT NULL UNIQUE
);


INSERT INTO Genres (Name)
VALUES
('Action'),
('Drama'),
('Sci-Fi'),
('Thriller');

CREATE TABLE Directors (
    Id INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Nationality NVARCHAR(50)
);

INSERT INTO Directors (FirstName, LastName, Nationality)
VALUES 
('Christopher', 'Nolan', 'British-American'),
('Quentin', 'Tarantino', 'American');

CREATE TABLE Movies (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(150) NOT NULL,
    Description NVARCHAR(MAX),
    ReleaseYear INT CHECK (ReleaseYear >= 1900),
    Rating DECIMAL(3,1) CHECK (Rating BETWEEN 0 AND 5),
    DirectorId INT,
    FOREIGN KEY (DirectorId) REFERENCES Directors(Id)
);

INSERT INTO Movies (Title, Description, ReleaseYear, Rating, DirectorId)
VALUES
('Inception', 'Mind-bending movie', 2010, 4.8, 1),
('Django Unchained', 'Western movie', 2012, 4.5, 2),
('Tenet', 'Time inversion', 2021, 4.2, 1),
('Random Film', 'Test movie', 2023, 3.5, 2);

CREATE TABLE Actors (
    Id INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    BirthDate DATE
);

INSERT INTO Actors (FirstName, LastName, BirthDate)
VALUES
('Leonardo', 'DiCaprio', '1974-11-11'),
('Jamie', 'Foxx', '1967-12-13');

CREATE TABLE Users (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Username NVARCHAR(50) NOT NULL UNIQUE,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE()
);

INSERT INTO Users (Username, Email, PasswordHash)
VALUES
('aysu', 'aysu@mail.com', 'hash1'),
('ali', 'ali@mail.com', 'hash2');

CREATE TABLE Reviews (
    Id INT PRIMARY KEY IDENTITY(1,1),
    MovieId INT,
    UserId INT,
    Content NVARCHAR(MAX),
    UserRating INT CHECK (UserRating BETWEEN 1 AND 5),
    ReviewDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (MovieId) REFERENCES Movies(Id),
    FOREIGN KEY (UserId) REFERENCES Users(Id)
);

INSERT INTO Reviews (MovieId, UserId, Content, UserRating)
VALUES
(1, 1, 'Very good movie', 5),
(2, 2, 'It was average', 4),
(3, 1, 'A bit confusing', 4),
(4, 2, 'Bad movie', 2);


CREATE TABLE MovieGenres (
    MovieId INT,
    GenreId INT,
    PRIMARY KEY (MovieId, GenreId),
    FOREIGN KEY (MovieId) REFERENCES Movies(Id),
    FOREIGN KEY (GenreId) REFERENCES Genres(Id)
);

INSERT INTO MovieGenres (MovieId, GenreId)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4);



CREATE TABLE MovieActors (
    MovieId INT,
    ActorId INT,
    RoleName NVARCHAR(100),
    PRIMARY KEY (MovieId, ActorId),
    FOREIGN KEY (MovieId) REFERENCES Movies(Id),
    FOREIGN KEY (ActorId) REFERENCES Actors(Id)
);

INSERT INTO MovieActors (MovieId, ActorId, RoleName)
VALUES
(1, 1, 'Cobb'),
(2, 2, 'Django');


SELECT * 
FROM Movies;
SELECT *
FROM Movies
WHERE ReleaseYear > 2020;
SELECT *
FROM Movies
WHERE Rating > 4;