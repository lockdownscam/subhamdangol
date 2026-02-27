create database hall;
use hall;
create table movie (
mID int primary key,
Title varchar(100),
Year int,
Director varchar(50)
);
create table user(
uID int primary key,
Name varchar(50)
);
create table rating(
ratingID INT AUTO_INCREMENT PRIMARY KEY,
    uID INT,
    mID INT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    ratingDate DATE,
    FOREIGN KEY (uID) REFERENCES user(uID),
    FOREIGN KEY (mID) REFERENCES movie(mID)
);
INSERT INTO movie (mID, Title, Year, Director) VALUES
(101, 'Top Gun', 1986, 'Tony Scott'),
(102, 'Titanic', 1997, 'James Cameron'),
(103, 'The Lion King', 1994, 'Rob Minkoff'),
(104, 'Gravity', 2013, 'Alfonso Cuaron'),
(105, 'Harry Potter', 2001, NULL),
(106, 'Cast Away', 2000, 'Robert Zemeckis'),
(107, 'Spider Man', 2002, 'Sam Raimi'),
(108, 'The Godfather', 1972, 'Francis Coppola');
INSERT INTO user  VALUES
(201, 'James Dean'),
(202, 'Chris Anderson'),
(203, 'Ashley Burley'),
(204, 'Ralph Truman'),
(205, 'Gordon Maximus'),
(206, 'Sarah Rodriguez'),
(207, 'Darrel Sherman'),
(208, 'Lisa Jackson');
INSERT INTO rating (uID, mID, Rating, ratingDate) VALUES
(201, 101, 2, '2014-03-09'),
(201, 101, 4, '2014-03-02'),
(202, 104, 4, NULL),
(203, 107, 2, '2014-03-24'),
(204, 103, 4, '2014-03-17'),
(204, 104, 2, '2014-03-13'),
(205, 108, 3, '2014-03-24'),
(206, 102, 3, '2014-03-02'),
(207, 104, 5, NULL),
(207, 108, 4, '2014-03-07'),
(207, 102, 5, '2014-03-26'),
(208, 105, 2, '2014-03-13');
#1 find the title and year of movie that were created after year 2000
SELECT Title, Year
FROM movie
WHERE Year > 2000;
#2 find the Title, mID, and Rating of movied that was created before year 2000 and rating>2
SELECT m.Title, m.mID, r.Rating
FROM movie m
JOIN rating r ON m.mID = r.mID
WHERE m.Year < 2000
  AND r.Rating > 2;
#3sort all movies by descending rating
SELECT r.ratingID, u.Name AS UserName, m.Title AS MovieTitle, r.Rating, r.ratingDate
FROM rating r
JOIN user u ON r.uID = u.uID
JOIN movie m ON r.mID = m.mID
ORDER BY r.Rating DESC;
#4 find all movies that have the exact same rating
SELECT r.Rating, GROUP_CONCAT(m.Title) AS Movies
FROM rating r
JOIN movie m ON r.mID = m.mID
GROUP BY r.Rating
HAVING COUNT(DISTINCT m.mID) > 1;
#5 create a query that looks for movies id title and director but only if rating is above 4
SELECT DISTINCT m.mID, m.Title, m.Director
FROM movie m
JOIN rating r ON m.mID = r.mID
WHERE r.Rating > 4;