--NICHOLAS BARRANCO
--DATABASE MANAGEMENT
--LAB#8

--2
DROP TABLE IF EXISTS people;
DROP TABLE IF EXISTS actors;
DROP TABLE IF EXISTS directors;
DROP TABLE IF EXISTS married;
DROP TABLE IF EXISTS movieData;

--PEOPLE TABLE--
CREATE TABLE people (
	pid		CHAR(6) UNIQUE NOT NULL,
	firstName	TEXT NOT NULL,
	lastName	TEXT NOT NULL,
	birthday	DATE NOT NULL,
	heightIN	INTEGER NOT NULL,
	weightLBS	INTEGER NOT NULL,
	favColor	TEXT,
	address		TEXT NOT NULL,
	hairColor	TEXT NOT NULL,
	eyeColor	TEXT NOT NULL,
	primary key(pid)	
);

-- Insert into People --
INSERT INTO people (pid, firstName, lastName, birthday, heightIN,
				weightLBS, favColor, address, hairColor, eyeColor)
	VALUES('aQez01', 'Sean', 'Connery', '1930-08-25', '74', 
	       '185', 'Green', '3400 Vine St, Cincinnati, OH 45220', 'Grey', 'Dark Brown');

INSERT INTO people (pid, firstName, lastName, birthday, heightIN,
				weightLBS, favColor, address, hairColor, eyeColor)
	VALUES('maYF02', 'Richard', 'Kiel', '1939-09-13', '86', 
		   '350', 'Yellow', '725 5th Ave, New York, NY 10022', 'Brown', 'Dark Brown');

INSERT INTO people (pid, firstName, lastName, birthday, heightIN, 
				weightLBS, favColor, address, hairColor, eyeColor)
	VALUES('62fm03', 'Lewis', 'Gilber', '1920-03-06', '71', 
		   '205', 'Blue', '27 Marshall Lane Little Falls, NJ 07424', 'Brown', 'Green');
	
INSERT INTO people (pid, firstName, lastName, birthday, heightIN, 
				weightLBS, favColor, address, hairColor, eyeColor)
	VALUES('oQ9304', 'Martin', 'Campbell', '1943-10-24', '68', 
		   '195', 'Purple', '794 Sheffield St. Billings, MT 59101', 'Bald', 'Dark Brown');

INSERT INTO people (pid, firstName, lastName, birthday, heightIN, 
				weightLBS, favColor, address, hairColor, eyeColor)
	VALUES('k9HX05', 'Ursula', 'Andress', '1936-03-19', '61', 
		   '146', 'Violet', '9699 Big Rock Cove Street Savage, MN 55378', 'Red', 'Green');

SELECT * FROM people;

--ACTORS--
CREATE TABLE actors (
	pid		CHAR(6) NOT NULL REFERENCES people(pid),
	AGAD	DATE,
	primary key(pid)
);

INSERT INTO actors (pid, AGAD)
	VALUES('aQez01', '1953-01-01');

INSERT INTO actors (pid, AGAD)
	VALUES('maYF02', '1980-12-07');

INSERT INTO actors (pid, AGAD)
	VALUES('k9HX05', '1962-07-09');

SELECT * FROM actors;

-- Directors --
CREATE TABLE directors (
	pid		CHAR(6) NOT NULL REFERENCES people(pid),
	filmSchool	TEXT,
	DGAD		DATE,
	favLenMaker	TEXT,
	primary key(pid)	
);

-- Insert into Directors Required that they have to use Sony Lenses Since its a Bond Film--
INSERT INTO directors (pid, filmSchool, DGAD, favLenMaker)
	VALUES('oQ9304', 'New Zealand Film Academy', '06/06/1968', 'Sony');

INSERT INTO directors (pid, filmSchool, DGAD, favLenMaker)
	VALUES('62fm03', 'St Johns University', '08/09/1957', 'Sony');

SELECT * FROM directors;

-- Married --
CREATE TABLE married (
	pid		CHAR(6) NOT NULL REFERENCES people(pid),
	spouseFName	TEXT NOT NULL,
	spouseLName	TEXT NOT NULL,
	primary key(pid)
);

-- Insert into Married --
INSERT INTO married (pid, spouseFName, spouseLName)
	VALUES('aQez01', 'Micheline', 'Roquebrune');

INSERT INTO married (pid, spouseFName, spouseLName)
	VALUES('oQ9304', 'Valarie', 'Trapp');

SELECT * FROM married;

-- MOVIE DATA --
CREATE TABLE movieData (
	mid		CHAR(2) NOT NULL,
	mpaaNum		TEXT NOT NULL,
	name		TEXT NOT NULL,
	releaseDate	DATE NOT NULL,
	dbosUSD		INTEGER NOT NULL,
	fbosUSD		INTEGER NOT NULL,
	dvdbluSales	INTEGER NOT NULL,
	primary key(mid)
);

-- INSERTING MY DUDE --
INSERT INTO movieDATA (mid, mpaaNum, name, releaseDate, dbosUSD, fbosUSD, dvdbluSales)
	VALUES('17', 'PGThirteen', 'GoldenEye', '1995-11-17', '100500300', '83000200', '7202025');

INSERT INTO movieDATA (mid, mpaaNZum, name, releaseDate, dbosUSD, fbosUSD, dvdbluSales)
	VALUES('11', 'PG', 'Moonraker', '1979-06-29', '35819002', '2159009', '51244781');

INSERT INTO movieDATA (mid, mpaaNum, name, releaseDate, dbosUSD, fbosUSD, dvdbluSales)
	VALUES('01', 'PG', 'Dr. No', '1962-10-05', '1792000', '42050992', '10300600');

SELECT * FROM movieData;



-- CAST CREW IN MOVIES --
CREATE TABLE castCrew (
	pid	CHAR(6) NOT NULL REFERENCES people(pid),
	mid	CHAR(2) NOT NULL REFERENCES movieData(mid),
	role	TEXT NOT NULL,
	primary key(pid, mid, role)
);

-- INSERT --
INSERT INTO castCrew (pid, mid, role)
	VALUES('aQez01', '01', 'Actor');

INSERT INTO castCrew (pid, mid, role)
	VALUES('k9HX05', '01', 'Actor');

INSERT INTO castCrew (pid, mid, role)
	VALUES('oQ9304', '01', 'Director');

INSERT INTO castCrew (pid, mid, role)
	VALUES('oQ9304', '17', 'Director');

INSERT INTO castCrew (pid, mid, role)
	VALUES('62fm03', '11', 'Director');

INSERT INTO castCrew (pid, mid, role)
	VALUES('maYF02', '11', 'Actor');

SELECT * FROM castCrew;

-- TEST QUIERIES --
SELECT * 
  FROM people;

SELECT * 
FROM people p, actors a
WHERE p.pid = a.pid;

SELECT * 
FROM people p, directors d
WHERE p.pid = d.pid;

SELECT * 
FROM movieData;

SELECT * 
FROM people LEFT OUTER JOIN married ON people.pid = married.pid;


--4
SELECT * 
FROM people p,directors d 
WHERE p.pid = d.pid 
      AND p.pid != 'aQez01'
      AND d.pid 
      IN (SELECT pid 
	  FROM castCrew 
	  WHERE role = 'Director' 
	  AND mid 
	  IN (SELECT mid 
	  FROM castCrew 
      WHERE pid = 'aQez01'));