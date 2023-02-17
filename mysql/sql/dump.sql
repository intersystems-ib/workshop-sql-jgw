CREATE database test;

USE test;

CREATE TABLE patient (
    `Id` int(8),
    `Name` varchar(225),
    `Lastname` varchar(225)
);

INSERT INTO patient VALUES (1, 'Juan','Sanz'), (2, 'Lorena', 'Gil');
