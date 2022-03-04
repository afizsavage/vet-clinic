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
SELECT species, MIN(weight), MAX(weight) FROM animals GROUP BY species;
SELECT neutered, AVG(escape_attempts) FROM animals 
    WHERE date_of_birth BETWEEN '1990/01/01' AND '2000/31/12' GROUP BY neutered;

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT species FROM animals;
ROLLBACK;
SELECT species FROM animals;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon'; 
UPDATE animals SET species = 'pokemon' WHERE species IS NULL; 
COMMIT;
SELECT species from animals;

BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT species from animals;

BEGIN;
DELETE FROM animals WHERE  date_of_birth > '2022-01-01';
SAVEPOINT delete_by_date;
UPDATE animals SET weight = weight * -1;
SELECT weight FROM animals;
ROLLBACK TO delete_by_date;
UPDATE animals SET weight = weight * -1 WHERE weight < 0; 
COMMIT;

-- What animals belong to Melody Pond?
SELECT name, full_name FROM animals INNER JOIN owners ON animals.owner_id = owners.id
    WHERE full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name, species.name FROM animals 
    INNER JOIN species ON animals.species_id = species.id 
    WHERE species.name = 'Pokemon';

-- List all owners and their animals, including those that don't own any animal
SELECT full_name, name FROM owners LEFT JOIN animals ON owners.id = animals.owner_id;

-- How many animals are there per species?
SELECT species.name, COUNT(*) FROM animals
    LEFT JOIN species
    ON animals.species_id = species.id
    GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell
SELECT a.name, s.name, full_name FROM animals a 
    INNER JOIN species s ON s.id = a.species_id 
    INNER JOIN owners o ON a.owner_id = o.id 
    WHERE a.species_id = (SELECT id FROM species WHERE name = 'Digimon') 
    AND full_name = 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape
SELECT name, escape_attempts, full_name FROM animals 
    INNER JOIN owners ON animals.owner_id = owners.id 
    WHERE animals.escape_attempts < 1 
    AND owners.full_name = 'Dean Winchester';

-- Who ownes the most animals
SELECT owners.full_name, COUNT(owners.full_name) FROM animals
    LEFT JOIN owners
    ON animals.owner_id = owners.id
    GROUP BY owners.full_name
    ORDER BY COUNT(owners.full_name) DESC;
