/* Populate database with sample data. */

INSERT INTO animals VALUES (1, 'Agumon', cast('2020/02/03' as date), 0, '1', 10.23);
INSERT INTO animals VALUES (2, 'Gabumon', cast('2018/11/15' as date), 2, '1', 8);
INSERT INTO animals VALUES (3, 'Pikachu', cast('2021/01/7' as date), 1, '0', 15.04);
INSERT INTO animals VALUES (4, 'Devimon', cast('2017/06/12' as date), 5, '1', 11);
INSERT INTO animals VALUES (5, 'Charmander', '2020/02/08', 0, '1', -11);
INSERT INTO animals VALUES (6, 'Plantmon', '2022/11/15', 2, '1', -5.7);
INSERT INTO animals VALUES (7, 'Squirtie', '1993/04/02', 3, '0', -12.13);
INSERT INTO animals VALUES (8, 'Angemon', '2005/06/12', 1, '1', -45);
INSERT INTO animals VALUES (9, 'Boarmon', '2005/06/7', 7, '1', 20.4);
INSERT INTO animals VALUES (10, 'Blossom', '1998/10/13', 3, '1', 17);

VALUES ('Sam Smith', 34),
	('Jennifer Orwell', 19),
	('Bob', 45),
	('Melody Pond', 77),
	('Dean Winchester', 14),
	('Jodie Whittaker', 38);

INSERT INTO species (name) VALUES ('Pokemon'), ('Digimon');

UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Digimon') 
    WHERE name LIKE '%mon';

UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Pokemon') 
    WHERE species_id IS NULL;

UPDATE animals
    SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith')
    WHERE name = 'Agumon';

UPDATE animals
    SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
    WHERE name = 'Gabumon' OR name = 'Pikachu';

UPDATE animals
    SET owner_id = (SELECT id from owners WHERE full_name = 'Bob')
    WHERE name = 'Devimon' OR name = 'Plantmon';

UPDATE animals
    SET owner_id = (SELECT id from owners WHERE full_name = 'Melody Pond')
    WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';

UPDATE animals
    SET owner_id = (SELECT id from owners WHERE full_name = 'Dean Winchester')
    WHERE name = 'Angemon'  OR name = 'Boarmon';