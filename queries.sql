/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016/12/31' AND '2019/01/01';
SELECT * FROM animals WHERE neutered = '1' AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight > 10.5;
SELECT * FROM animals WHERE neutered = '1';
SELECT * FROM animals WHERE NOT name = 'Gabumon';
SELECT * FROM animals WHERE weight BETWEEN 10.3 AND 17.4;
SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts < 1;
SELECT AVG(weight) FROM animals;
SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered
SELECT neutered, MIN(weight), MAX(weight) FROM animals GROUP BY neutered;
SELECT neutered, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990/12/31' AND '2000/01/01' GROUP BY neutered;