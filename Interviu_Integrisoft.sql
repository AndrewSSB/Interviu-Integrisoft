-- 1.
CREATE DATABASE Universitate COLLATE SQL_Latin1_General_CP1_CI_AI;

USE Universitate;

-- 2. 
CREATE TABLE Orase 
(
	Id INT IDENTITY(1, 1) PRIMARY KEY,
	Denumire NVARCHAR(100) COLLATE SQL_Latin1_General_CP1_CI_AI
);

CREATE TABLE Grupa 
(
	Id INT IDENTITY(1, 1) PRIMARY KEY,
	Denumire NVARCHAR(100) COLLATE SQL_Latin1_General_CP1_CI_AI
);

CREATE TABLE Student
(
	Id INT IDENTITY(1, 1) PRIMARY KEY,
	Grupa_la_care_apartine INT,
	Orasul_de_resedinta INT,
	Nume NVARCHAR(100) COLLATE SQL_Latin1_General_CP1_CI_AI,
    Prenume NVARCHAR(100) COLLATE SQL_Latin1_General_CP1_CI_AI,
	--FOREIGN KEY (Grupa_la_care_apartine) REFERENCES Grupa(Id),
 --   FOREIGN KEY (Orasul_de_resedinta) REFERENCES Orase(Id)
);

CREATE TABLE Materie
(
	Id INT IDENTITY(1, 1) PRIMARY KEY,
	Nume NVARCHAR(100) COLLATE SQL_Latin1_General_CP1_CI_AI,
);

CREATE TABLE Note
(
	Id INT IDENTITY(1, 1) PRIMARY KEY,
	Student INT,
	Materia INT,
	Nota_obtinuta INT,
	--FOREIGN KEY (Student) REFERENCES Student(Id),
	--FOREIGN KEY (Materia) REFERENCES Materie(Id)
);

-- 3.
ALTER TABLE Orase ADD CONSTRAINT UQ_Denumire_Orase UNIQUE(Denumire);
CREATE UNIQUE INDEX IDX_Denumire_Oras ON Orase(Denumire);

ALTER TABLE Grupa ADD CONSTRAINT UQ_Denumire_Grupa UNIQUE(Denumire);
CREATE UNIQUE INDEX IDX_Denumire_Grupa ON Grupa(Denumire);

ALTER TABLE Materie ADD CONSTRAINT UQ_Nume_Materie UNIQUE(Nume);
CREATE UNIQUE INDEX IDX_Nume_Materie ON Materie(Nume);

ALTER TABLE Student ALTER COLUMN Grupa_la_care_apartine INT NOT NULL;
ALTER TABLE Student ALTER COLUMN Orasul_de_resedinta INT NOT NULL;

ALTER TABLE Note ALTER COLUMN Student INT NOT NULL;
ALTER TABLE Note ALTER COLUMN Materia INT NOT NULL;

ALTER TABLE Student ADD CONSTRAINT FK_Student_Grupa FOREIGN KEY (Grupa_la_care_apartine) REFERENCES Grupa(Id);
ALTER TABLE Student ADD CONSTRAINT FK_Student_Oras FOREIGN KEY (Orasul_de_resedinta) REFERENCES Orase(Id);
ALTER TABLE Note ADD CONSTRAINT FK_Note_Student FOREIGN KEY (Student) REFERENCES Student(Id);
ALTER TABLE Note ADD CONSTRAINT FK_Note_Materie FOREIGN KEY (Materia) REFERENCES Materie(Id);

-- 4.
INSERT INTO Orase VALUES(N'Ploiești');
INSERT INTO Orase VALUES(N'Pitești');
INSERT INTO Orase VALUES(N'Constanța');
INSERT INTO Orase VALUES(N'București');
INSERT INTO Orase VALUES(N'Călărași');
INSERT INTO Orase VALUES(N'Iași');
INSERT INTO Orase VALUES(N'Slobozia');
INSERT INTO Orase VALUES(N'Sibiu');
INSERT INTO Orase VALUES(N'Cluj-Napoca');
INSERT INTO Orase VALUES(N'Brașov');
INSERT INTO Orase VALUES(N'Fetești');
INSERT INTO Orase VALUES(N'Satu-Mare');
INSERT INTO Orase VALUES(N'Oradea');
INSERT INTO Orase VALUES(N'Cernavodă');

INSERT INTO Grupa VALUES(N'A');
INSERT INTO Grupa VALUES(N'B');
INSERT INTO Grupa VALUES(N'C');
INSERT INTO Grupa VALUES(N'D');

INSERT INTO Materie VALUES(N'Geometrie');
INSERT INTO Materie VALUES(N'Algebră');
INSERT INTO Materie VALUES(N'Statistică');
INSERT INTO Materie VALUES(N'Trigonometrie');
INSERT INTO Materie VALUES(N'Muzică');
INSERT INTO Materie VALUES(N'Desen');
INSERT INTO Materie VALUES(N'Sport');
INSERT INTO Materie VALUES(N'Filozofie');
INSERT INTO Materie VALUES(N'Literatură');
INSERT INTO Materie VALUES(N'Engleză');
INSERT INTO Materie VALUES(N'Fizică');
INSERT INTO Materie VALUES(N'Franceză');
INSERT INTO Materie VALUES(N'Chimie');

-- Grupa, Oras, Nume, Prenume
INSERT INTO Student (Grupa_la_care_apartine, Orasul_de_resedinta, Nume, Prenume) 
VALUES
(	
	(SELECT Id FROM Grupa WHERE Denumire = N'A'), 
	(SELECT Id FROM Orase WHERE Denumire = N'Ploiești'),
	'Popescu',
	'Mihai'
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Popescu' AND Prenume = N'Mihai'), 
	(SELECT Id FROM Materie WHERE Nume = N'Chimie'),
	7
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Popescu' AND Prenume = N'Mihai'), 
	(SELECT Id FROM Materie WHERE Nume = N'Fizică'),
	4
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Popescu' AND Prenume = N'Mihai'), 
	(SELECT Id FROM Materie WHERE Nume = N'Franceză'),
	7
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Popescu' AND Prenume = N'Mihai'), 
	(SELECT Id FROM Materie WHERE Nume = N'Fizică'),
	6
);
-------------------------------------------------------------------------------
INSERT INTO Student (Grupa_la_care_apartine, Orasul_de_resedinta, Nume, Prenume) 
VALUES
(	
	(SELECT Id FROM Grupa WHERE Denumire = N'A'), 
	(SELECT Id FROM Orase WHERE Denumire = N'București'),
	'Ionescu',
	'Andrei'
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Ionescu' AND Prenume = N'Andrei'), 
	(SELECT Id FROM Materie WHERE Nume = N'Algebră'),
	5
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Ionescu' AND Prenume = N'Andrei'), 
	(SELECT Id FROM Materie WHERE Nume = N'Statistică'),
	9
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Ionescu' AND Prenume = N'Andrei'), 
	(SELECT Id FROM Materie WHERE Nume = N'Muzică'),
	6
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Ionescu' AND Prenume = N'Andrei'), 
	(SELECT Id FROM Materie WHERE Nume = N'Fizică'),
	9
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Ionescu' AND Prenume = N'Andrei'), 
	(SELECT Id FROM Materie WHERE Nume = N'Chimie'),
	10
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Ionescu' AND Prenume = N'Andrei'), 
	(SELECT Id FROM Materie WHERE Nume = N'Sport'),
	8
);
--------------------------------------------------------------------------------
INSERT INTO Student (Grupa_la_care_apartine, Orasul_de_resedinta, Nume, Prenume) 
VALUES
(	
	(SELECT Id FROM Grupa WHERE Denumire = N'A'), 
	(SELECT Id FROM Orase WHERE Denumire = N'Constanța'),
	'Ionescu',
	'Andreea'
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Ionescu' AND Prenume = N'Andreea'), 
	(SELECT Id FROM Materie WHERE Nume = N'Sport'),
	1
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Ionescu' AND Prenume = N'Andreea'), 
	(SELECT Id FROM Materie WHERE Nume = N'Literatură'),
	2
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Ionescu' AND Prenume = N'Andreea'), 
	(SELECT Id FROM Materie WHERE Nume = N'Franceză'),
	9
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Ionescu' AND Prenume = N'Andreea'), 
	(SELECT Id FROM Materie WHERE Nume = N'Sport'),
	5
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Ionescu' AND Prenume = N'Andreea'), 
	(SELECT Id FROM Materie WHERE Nume = N'Literatură'),
	4
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Ionescu' AND Prenume = N'Andreea'), 
	(SELECT Id FROM Materie WHERE Nume = N'Literatură'),
	7
);
--------------------------------------------------------------------------------
INSERT INTO Student (Grupa_la_care_apartine, Orasul_de_resedinta, Nume, Prenume) 
VALUES
(	
	(SELECT Id FROM Grupa WHERE Denumire = N'A'), 
	(SELECT Id FROM Orase WHERE Denumire = N'Călărași'),
	'Dinu',
	'Nicolae'
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Dinu' AND Prenume = N'Nicolae'), 
	(SELECT Id FROM Materie WHERE Nume = N'Chimie'),
	8
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Dinu' AND Prenume = N'Nicolae'), 
	(SELECT Id FROM Materie WHERE Nume = N'Algebră'),
	9
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Dinu' AND Prenume = N'Nicolae'), 
	(SELECT Id FROM Materie WHERE Nume = N'Statistică'),
	10
);
--------------------------------------------------------------------------------
INSERT INTO Student (Grupa_la_care_apartine, Orasul_de_resedinta, Nume, Prenume) 
VALUES
(	
	(SELECT Id FROM Grupa WHERE Denumire = N'B'), 
	(SELECT Id FROM Orase WHERE Denumire = N'Cernavodă'),
	N'Constantin',
	N'Ionuț'
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Constantin' AND Prenume = N'Ionuț'), 
	(SELECT Id FROM Materie WHERE Nume = N'Algebră'),
	10
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Constantin' AND Prenume = N'Ionuț'), 
	(SELECT Id FROM Materie WHERE Nume = N'Sport'),
	10
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Constantin' AND Prenume = N'Ionuț'), 
	(SELECT Id FROM Materie WHERE Nume = N'Fizică'),
	8
);
--------------------------------------------------------------------------------
INSERT INTO Student (Grupa_la_care_apartine, Orasul_de_resedinta, Nume, Prenume) 
VALUES
(	
	(SELECT Id FROM Grupa WHERE Denumire = N'B'), 
	(SELECT Id FROM Orase WHERE Denumire = N'Iași'),
	N'Simion',
	N'Mihai'
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Simion' AND Prenume = N'Mihai'), 
	(SELECT Id FROM Materie WHERE Nume = N'Fizică'),
	8
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Simion' AND Prenume = N'Mihai'), 
	(SELECT Id FROM Materie WHERE Nume = N'Algebră'),
	8
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Simion' AND Prenume = N'Mihai'), 
	(SELECT Id FROM Materie WHERE Nume = N'Sport'),
	3
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Simion' AND Prenume = N'Mihai'), 
	(SELECT Id FROM Materie WHERE Nume = N'Sport'),
	3
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Simion' AND Prenume = N'Mihai'), 
	(SELECT Id FROM Materie WHERE Nume = N'Sport'),
	1
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Simion' AND Prenume = N'Mihai'), 
	(SELECT Id FROM Materie WHERE Nume = N'Sport'),
	1
);
--------------------------------------------------------------------------------
INSERT INTO Student (Grupa_la_care_apartine, Orasul_de_resedinta, Nume, Prenume) 
VALUES
(	
	(SELECT Id FROM Grupa WHERE Denumire = N'B'), 
	(SELECT Id FROM Orase WHERE Denumire = N'Cernavodă'),
	N'Constantinescu',
	N'Ana-Maria'
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Constantinescu' AND Prenume = N'Ana-Maria'), 
	(SELECT Id FROM Materie WHERE Nume = N'Sport'),
	5
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Constantinescu' AND Prenume = N'Ana-Maria'), 
	(SELECT Id FROM Materie WHERE Nume = N'Fizică'),
	8
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Constantinescu' AND Prenume = N'Ana-Maria'), 
	(SELECT Id FROM Materie WHERE Nume = N'Algebră'),
	2
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Constantinescu' AND Prenume = N'Ana-Maria'), 
	(SELECT Id FROM Materie WHERE Nume = N'Algebră'),
	5
);
--------------------------------------------------------------------------------
INSERT INTO Student (Grupa_la_care_apartine, Orasul_de_resedinta, Nume, Prenume) 
VALUES
(	
	(SELECT Id FROM Grupa WHERE Denumire = N'B'), 
	(SELECT Id FROM Orase WHERE Denumire = N'Iași'),
	N'Amăriuței',
	N'Eugen'
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Amăriuței' AND Prenume = N'Eugen'), 
	(SELECT Id FROM Materie WHERE Nume = N'Algebră'),
	6
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Amăriuței' AND Prenume = N'Eugen'), 
	(SELECT Id FROM Materie WHERE Nume = N'Sport'),
	10
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Amăriuței' AND Prenume = N'Eugen'), 
	(SELECT Id FROM Materie WHERE Nume = N'Franceză'),
	7
);
--------------------------------------------------------------------------------
INSERT INTO Student (Grupa_la_care_apartine, Orasul_de_resedinta, Nume, Prenume) 
VALUES
(	
	(SELECT Id FROM Grupa WHERE Denumire = N'B'), 
	(SELECT Id FROM Orase WHERE Denumire = N'Sibiu'),
	N'Știrbei',
	N'Alexandru'
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Știrbei' AND Prenume = N'Alexandru'), 
	(SELECT Id FROM Materie WHERE Nume = N'Chimie'),
	9
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Știrbei' AND Prenume = N'Alexandru'), 
	(SELECT Id FROM Materie WHERE Nume = N'Fizică'),
	2
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Știrbei' AND Prenume = N'Alexandru'), 
	(SELECT Id FROM Materie WHERE Nume = N'Sport'),
	1
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Știrbei' AND Prenume = N'Alexandru'), 
	(SELECT Id FROM Materie WHERE Nume = N'Fizică'),
	2
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Știrbei' AND Prenume = N'Alexandru'), 
	(SELECT Id FROM Materie WHERE Nume = N'Fizică'),
	5
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Știrbei' AND Prenume = N'Alexandru'), 
	(SELECT Id FROM Materie WHERE Nume = N'Sport'),
	6
);
--------------------------------------------------------------------------------
INSERT INTO Student (Grupa_la_care_apartine, Orasul_de_resedinta, Nume, Prenume) 
VALUES
(	
	(SELECT Id FROM Grupa WHERE Denumire = N'C'), 
	(SELECT Id FROM Orase WHERE Denumire = N'Brașov'),
	N'Dumitru',
	N'Angela'
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Dumitru' AND Prenume = N'Angela'), 
	(SELECT Id FROM Materie WHERE Nume = N'Desen'),
	9
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Dumitru' AND Prenume = N'Angela'), 
	(SELECT Id FROM Materie WHERE Nume = N'Filozofie'),
	7
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Dumitru' AND Prenume = N'Angela'), 
	(SELECT Id FROM Materie WHERE Nume = N'Engleză'),
	9
);
--------------------------------------------------------------------------------
INSERT INTO Student (Grupa_la_care_apartine, Orasul_de_resedinta, Nume, Prenume) 
VALUES
(	
	(SELECT Id FROM Grupa WHERE Denumire = N'C'), 
	(SELECT Id FROM Orase WHERE Denumire = N'Oradea'),
	N'Dumitrache',
	N'Ion'
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Dumitrache' AND Prenume = N'Ion'), 
	(SELECT Id FROM Materie WHERE Nume = N'Desen'),
	8
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Dumitrache' AND Prenume = N'Ion'), 
	(SELECT Id FROM Materie WHERE Nume = N'Statistică'),
	2
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Dumitrache' AND Prenume = N'Ion'), 
	(SELECT Id FROM Materie WHERE Nume = N'Filozofie'),
	7
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Dumitrache' AND Prenume = N'Ion'), 
	(SELECT Id FROM Materie WHERE Nume = N'Statistică'),
	6
);
--------------------------------------------------------------------------------
INSERT INTO Student (Grupa_la_care_apartine, Orasul_de_resedinta, Nume, Prenume) 
VALUES
(	
	(SELECT Id FROM Grupa WHERE Denumire = N'C'), 
	(SELECT Id FROM Orase WHERE Denumire = N'Oradea'),
	N'Șerban',
	N'Maria-Magdalena'
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Șerban' AND Prenume = N'Maria-Magdalena'), 
	(SELECT Id FROM Materie WHERE Nume = N'Engleză'),
	7
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Șerban' AND Prenume = N'Maria-Magdalena'), 
	(SELECT Id FROM Materie WHERE Nume = N'Filozofie'),
	4
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Șerban' AND Prenume = N'Maria-Magdalena'), 
	(SELECT Id FROM Materie WHERE Nume = N'Desen'),
	8
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Șerban' AND Prenume = N'Maria-Magdalena'), 
	(SELECT Id FROM Materie WHERE Nume = N'Filozofie'),
	4
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Șerban' AND Prenume = N'Maria-Magdalena'), 
	(SELECT Id FROM Materie WHERE Nume = N'Filozofie'),
	4
);
--------------------------------------------------------------------------------
INSERT INTO Student (Grupa_la_care_apartine, Orasul_de_resedinta, Nume, Prenume) 
VALUES
(	
	(SELECT Id FROM Grupa WHERE Denumire = N'C'), 
	(SELECT Id FROM Orase WHERE Denumire = N'Cluj-Napoca'),
	N'Chelaru',
	N'Violeta'
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Chelaru' AND Prenume = N'Violeta'), 
	(SELECT Id FROM Materie WHERE Nume = N'Franceză'),
	1
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Chelaru' AND Prenume = N'Violeta'), 
	(SELECT Id FROM Materie WHERE Nume = N'Desen'),
	3
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Chelaru' AND Prenume = N'Violeta'), 
	(SELECT Id FROM Materie WHERE Nume = N'Engleză'),
	10
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Chelaru' AND Prenume = N'Violeta'), 
	(SELECT Id FROM Materie WHERE Nume = N'Franceză'),
	6
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Chelaru' AND Prenume = N'Violeta'), 
	(SELECT Id FROM Materie WHERE Nume = N'Desen'),
	1
);
--------------------------------------------------------------------------------
INSERT INTO Student (Grupa_la_care_apartine, Orasul_de_resedinta, Nume, Prenume) 
VALUES
(	
	(SELECT Id FROM Grupa WHERE Denumire = N'C'), 
	(SELECT Id FROM Orase WHERE Denumire = N'Cluj-Napoca'),
	N'Sandu',
	N'Daniel'
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Sandu' AND Prenume = N'Daniel'), 
	(SELECT Id FROM Materie WHERE Nume = N'Desen'),
	3
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Sandu' AND Prenume = N'Daniel'), 
	(SELECT Id FROM Materie WHERE Nume = N'Filozofie'),
	9
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Sandu' AND Prenume = N'Daniel'), 
	(SELECT Id FROM Materie WHERE Nume = N'Franceză'),
	4
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Sandu' AND Prenume = N'Daniel'), 
	(SELECT Id FROM Materie WHERE Nume = N'Desen'),
	8
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Sandu' AND Prenume = N'Daniel'), 
	(SELECT Id FROM Materie WHERE Nume = N'Franceză'),
	5
);
--------------------------------------------------------------------------------
INSERT INTO Student (Grupa_la_care_apartine, Orasul_de_resedinta, Nume, Prenume) 
VALUES
(	
	(SELECT Id FROM Grupa WHERE Denumire = N'D'), 
	(SELECT Id FROM Orase WHERE Denumire = N'Satu-Mare'),
	N'Marinache',
	N'Alin'
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Marinache' AND Prenume = N'Alin'), 
	(SELECT Id FROM Materie WHERE Nume = N'Desen'),
	7
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Marinache' AND Prenume = N'Alin'), 
	(SELECT Id FROM Materie WHERE Nume = N'Fizică'),
	8
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Marinache' AND Prenume = N'Alin'), 
	(SELECT Id FROM Materie WHERE Nume = N'Engleză'),
	5
);
--------------------------------------------------------------------------------
INSERT INTO Student (Grupa_la_care_apartine, Orasul_de_resedinta, Nume, Prenume) 
VALUES
(	
	(SELECT Id FROM Grupa WHERE Denumire = N'D'), 
	(SELECT Id FROM Orase WHERE Denumire = N'Satu-Mare'),
	N'Panait',
	N'Vasile'
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Panait' AND Prenume = N'Vasile'), 
	(SELECT Id FROM Materie WHERE Nume = N'Sport'),
	5
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Panait' AND Prenume = N'Vasile'), 
	(SELECT Id FROM Materie WHERE Nume = N'Desen'),
	7
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Panait' AND Prenume = N'Vasile'), 
	(SELECT Id FROM Materie WHERE Nume = N'Statistică'),
	10
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Panait' AND Prenume = N'Vasile'), 
	(SELECT Id FROM Materie WHERE Nume = N'Fizică'),
	8
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Panait' AND Prenume = N'Vasile'), 
	(SELECT Id FROM Materie WHERE Nume = N'Literatură'),
	6
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Panait' AND Prenume = N'Vasile'), 
	(SELECT Id FROM Materie WHERE Nume = N'Filozofie'),
	9
);
--------------------------------------------------------------------------------
INSERT INTO Student (Grupa_la_care_apartine, Orasul_de_resedinta, Nume, Prenume) 
VALUES
(	
	(SELECT Id FROM Grupa WHERE Denumire = N'D'), 
	(SELECT Id FROM Orase WHERE Denumire = N'Fetești'),
	N'Popa',
	N'Mirela'
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Popa' AND Prenume = N'Mirela'), 
	(SELECT Id FROM Materie WHERE Nume = N'Engleză'),
	3
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Popa' AND Prenume = N'Mirela'), 
	(SELECT Id FROM Materie WHERE Nume = N'Filozofie'),
	6
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Popa' AND Prenume = N'Mirela'), 
	(SELECT Id FROM Materie WHERE Nume = N'Desen'),
	6
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Popa' AND Prenume = N'Mirela'), 
	(SELECT Id FROM Materie WHERE Nume = N'Engleză'),
	6
);
--------------------------------------------------------------------------------
INSERT INTO Student (Grupa_la_care_apartine, Orasul_de_resedinta, Nume, Prenume) 
VALUES
(	
	(SELECT Id FROM Grupa WHERE Denumire = N'D'), 
	(SELECT Id FROM Orase WHERE Denumire = N'Fetești'),
	N'Dascălu',
	N'Daniel Ștefan'
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Dascălu' AND Prenume = N'Daniel Ștefan'), 
	(SELECT Id FROM Materie WHERE Nume = N'Fizică'),
	4
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Dascălu' AND Prenume = N'Daniel Ștefan'), 
	(SELECT Id FROM Materie WHERE Nume = N'Franceză'),
	9
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Dascălu' AND Prenume = N'Daniel Ștefan'), 
	(SELECT Id FROM Materie WHERE Nume = N'Statistică'),
	10
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Dascălu' AND Prenume = N'Daniel Ștefan'), 
	(SELECT Id FROM Materie WHERE Nume = N'Fizică'),
	2
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Dascălu' AND Prenume = N'Daniel Ștefan'), 
	(SELECT Id FROM Materie WHERE Nume = N'Fizică'),
	1
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Dascălu' AND Prenume = N'Daniel Ștefan'), 
	(SELECT Id FROM Materie WHERE Nume = N'Fizică'),
	3
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Dascălu' AND Prenume = N'Daniel Ștefan'), 
	(SELECT Id FROM Materie WHERE Nume = N'Fizică'),
	5
);
--------------------------------------------------------------------------------
INSERT INTO Student (Grupa_la_care_apartine, Orasul_de_resedinta, Nume, Prenume) 
VALUES
(	
	(SELECT Id FROM Grupa WHERE Denumire = N'D'), 
	(SELECT Id FROM Orase WHERE Denumire = N'Fetești'),
	N'Georgescu',
	N'Marian'
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Georgescu' AND Prenume = N'Marian'), 
	(SELECT Id FROM Materie WHERE Nume = N'Franceză'),
	10
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Georgescu' AND Prenume = N'Marian'), 
	(SELECT Id FROM Materie WHERE Nume = N'Engleză'),
	10
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Georgescu' AND Prenume = N'Marian'), 
	(SELECT Id FROM Materie WHERE Nume = N'Fizică'),
	8
);
--------------------------------------------------------------------------------
INSERT INTO Student (Grupa_la_care_apartine, Orasul_de_resedinta, Nume, Prenume) 
VALUES
(	
	(SELECT Id FROM Grupa WHERE Denumire = N'D'), 
	(SELECT Id FROM Orase WHERE Denumire = N'Fetești'),
	N'Dumitrașcu',
	N'Marius'
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Dumitrașcu' AND Prenume = N'Marius'), 
	(SELECT Id FROM Materie WHERE Nume = N'Sport'),
	5
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Dumitrașcu' AND Prenume = N'Marius'), 
	(SELECT Id FROM Materie WHERE Nume = N'Algebră'),
	6
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Dumitrașcu' AND Prenume = N'Marius'), 
	(SELECT Id FROM Materie WHERE Nume = N'Chimie'),
	2
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Dumitrașcu' AND Prenume = N'Marius'), 
	(SELECT Id FROM Materie WHERE Nume = N'Chimie'),
	2
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Dumitrașcu' AND Prenume = N'Marius'), 
	(SELECT Id FROM Materie WHERE Nume = N'Chimie'),
	5
);
--------------------------------------------------------------------------------
INSERT INTO Student (Grupa_la_care_apartine, Orasul_de_resedinta, Nume, Prenume) 
VALUES
(	
	(SELECT Id FROM Grupa WHERE Denumire = N'D'), 
	(SELECT Id FROM Orase WHERE Denumire = N'Fetești'),
	N'Dinu',
	N'Ionela'
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Dinu' AND Prenume = N'Ionela'), 
	(SELECT Id FROM Materie WHERE Nume = N'Muzică'),
	9
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Dinu' AND Prenume = N'Ionela'), 
	(SELECT Id FROM Materie WHERE Nume = N'Literatură'),
	8
);
INSERT INTO Note(Student, Materia, Nota_obtinuta) 
VALUES
(	
	(SELECT Id FROM Student WHERE Nume = N'Dinu' AND Prenume = N'Ionela'), 
	(SELECT Id FROM Materie WHERE Nume = N'Sport'),
	8
);

--select * from Student;
--SELECT CONCAT(s.Nume, ' ', s.Prenume) as Student, COUNT(n.Student) 
--FROM Note n
--JOIN Student s ON s.Id = n.Student
--GROUP BY CONCAT(s.Nume, ' ', s.Prenume);

-- 5.
SELECT COUNT(DISTINCT Denumire) AS NumarOrase
FROM Orase;

-- 6.
SELECT COUNT(DISTINCT Materia) AS NumarMaterii
FROM Note;

-- 7.
SELECT Nume, Prenume 
FROM Student
ORDER BY Nume, Prenume;

-- 8.
SELECT *
FROM Student
WHERE Prenume LIKE '% %' OR Prenume LIKE '%-%';

-- 9. ? 
-- Nu imi este clar

-- 10.
SELECT o.Denumire as Oras
FROM Orase o
LEFT JOIN Student s on s.Orasul_de_resedinta = o.Id
WHERE s.Id IS NULL;

-- 11.
SELECT g.Denumire AS "Grupa la care apartine", COUNT(*) AS NumarStudenti
FROM Student s
JOIN Grupa g on s.Grupa_la_care_apartine = g.Id
GROUP BY g.Denumire
HAVING COUNT(g.Denumire) >= 5;

-- 12.
SELECT g.Denumire AS "Numele Grupei", COUNT(*) AS "NumarStudenti"
FROM Student s
JOIN Grupa g ON s.Grupa_la_care_apartine = g.Id
GROUP BY g.Denumire
HAVING COUNT(g.Denumire) = (
					SELECT MAX(NumarStudenti) 
					FROM (
							SELECT COUNT(*) AS NumarStudenti 
							FROM Student 
							GROUP BY Grupa_la_care_apartine) AS CountByGroup
						 );

-- 13.
SELECT m.Nume as Materie
FROM Materie m 
LEFT JOIN Note n ON m.Id = n.Materia
WHERE n.Id IS NULL;

-- 14.
SELECT s.Nume, s.Prenume
FROM Student s
JOIN Note n ON s.Id = n.Student
GROUP BY s.Nume, s.Prenume, s.Id
HAVING COUNT(DISTINCT n.Materia) > 3;

-- 15.
SELECT s.Nume, s.Prenume, s.Grupa_la_care_apartine, AVG(CAST(ult.Nota_obtinuta AS FLOAT)) AS Medie
FROM Student s
JOIN 
	(
		SELECT n.Student, n.Nota_obtinuta
		FROM Note n
		WHERE n.Id IN (
			SELECT MAX(n2.Id) 
			FROM Note n2 
			WHERE n2.Student = n.Student AND n2.Materia = n.Materia
			GROUP BY n2.Materia
		)
	) AS ult
	ON s.Id = ult.Student
GROUP BY s.Nume, s.Prenume, s.Grupa_la_care_apartine
ORDER BY s.Grupa_la_care_apartine;

-- 16.
SELECT *
FROM Grupa g
WHERE g.Id = (
				SELECT TOP 1 grupa.Grupa_la_care_apartine
				FROM 
				(
					SELECT s.Id, s.Grupa_la_care_apartine, AVG(CAST(ult.Nota_obtinuta AS FLOAT)) AS Medie
					FROM Student s
					JOIN 
						(
							SELECT n.Student, n.Nota_obtinuta
							FROM Note n
							WHERE n.Id IN (
								SELECT MAX(n2.Id) 
								FROM Note n2 
								WHERE n2.Student = n.Student AND n2.Materia = n.Materia
								GROUP BY n2.Materia
							)
						) AS ult
						ON s.Id = ult.Student
					GROUP BY s.Id, s.Grupa_la_care_apartine
				) AS grupa
				GROUP BY grupa.Grupa_la_care_apartine
				ORDER BY AVG(grupa.Medie) DESC
			);

-- 17.
SELECT CONCAT(s.Nume ,' ', s.Prenume) AS "Nume Student"
FROM Student s
JOIN 
	(
		SELECT n.Student, n.Nota_obtinuta
		FROM Note n
		WHERE n.Id IN (
			SELECT MAX(n2.Id) 
			FROM Note n2 
			WHERE n2.Student = n.Student AND n2.Materia = n.Materia
			GROUP BY n2.Materia
		)
	) AS ult
	ON s.Id = ult.Student
GROUP BY s.Nume, s.Prenume
HAVING AVG(CAST(ult.Nota_obtinuta AS FLOAT)) > 8.50;

-- 18. 
SELECT DISTINCT s.Id AS StudentId, s.Nume, s.Prenume
FROM Student s
JOIN Note n1 ON s.Id = n1.Student
JOIN Note n2 ON s.Id = n2.Student AND n2.Id > n1.Id
JOIN Materie m ON n1.Materia = m.Id
WHERE m.Nume = N'Chimie' AND n1.Nota_obtinuta < 5 AND n2.Nota_obtinuta >= 5;

-- 19.
SELECT CONCAT(s.Nume ,' ', s.Prenume) AS "Nume Student"
FROM Student s
WHERE S.Id = (
		SELECT TOP 1 n.Student
		FROM Note n
		GROUP BY n.Student, n.Materia
		ORDER BY COUNT(n.Materia) DESC
	);

-- 20.
SELECT s.Id AS StudentId, s.Nume, s.Prenume, m.Nume AS Materie, COUNT(n.Id) AS NumarExaminari
FROM Student s
JOIN Note n ON s.Id = n.Student
JOIN Materie m ON n.Materia = m.Id
GROUP BY s.Id, s.Nume, s.Prenume, m.Nume
ORDER BY s.Id, COUNT(n.Id);

-- 21.
SELECT s.Id AS StudentId, s.Nume, s.Prenume
FROM Student s
JOIN 
	(
		SELECT n.Student, n.Nota_obtinuta
		FROM Note n
		WHERE n.Id IN (
			SELECT MAX(n2.Id) 
			FROM Note n2 
			WHERE n2.Student = n.Student AND n2.Materia = n.Materia
			GROUP BY n2.Materia
		)
	) AS ult ON ult.Student = s.Id
WHERE ult.Nota_obtinuta < 5;

-- 22.
INSERT INTO Grupa VALUES(N'E'); -- grupa noua

UPDATE Student
SET Grupa_la_care_apartine = (
								SELECT g.Id 
								FROM Grupa g 
								WHERE g.Denumire = N'E'
							 )
WHERE Id IN 
(
	SELECT s.Id
	FROM Student s
	JOIN 
		(
			SELECT n.Student, n.Nota_obtinuta
			FROM Note n
			WHERE n.Id IN (
				SELECT MAX(n2.Id) 
				FROM Note n2 
				WHERE n2.Student = n.Student AND n2.Materia = n.Materia
				GROUP BY n2.Materia
			)
		) AS ult ON ult.Student = s.Id
	WHERE ult.Nota_obtinuta < 5
);

-- 23.
DELETE 
FROM Student
WHERE Id = 
(
	SELECT TOP 1 s.Id
	FROM Student s
	JOIN 
		(
			SELECT n.Student, n.Nota_obtinuta
			FROM Note n
			WHERE n.Id IN (
				SELECT MAX(n2.Id) 
				FROM Note n2 
				WHERE n2.Student = n.Student AND n2.Materia = n.Materia
				GROUP BY n2.Materia
			)
		) AS ult
		ON s.Id = ult.Student
	GROUP BY s.Id, s.Grupa_la_care_apartine
	ORDER BY AVG(CAST(ult.Nota_obtinuta AS FLOAT))
);

-- 24.
SELECT Nume as Familia, STRING_AGG(Prenume, ', ') AS Frații
FROM Student
GROUP BY Nume
HAVING COUNT(Nume) > 1;