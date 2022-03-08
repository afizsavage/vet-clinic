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

INSERT INTO owners VALUES ('Sam Smith', 34),
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

INSERT INTO vets (name, age, date_of_graduatation) 
    VALUES ('William Tatcher', 45, '2000/04/23'),
    ('Maisy Smith', 26, '2019/01/17'),
    ('Stephanie Mendez', 64, '1981/05/04'),
    ('Jack Harkness', 38, '2008/06/08');

INSERT INTO specializations VALUES ((SELECT id FROM species WHERE name = 'Pokemon'),
    (SELECT id FROM vets WHERE name = 'William Tatcher')),
    ((SELECT id FROM species WHERE name = 'Digimon'),
    (SELECT id FROM vets WHERE name = 'Stephanie Mendez')),
    ((SELECT id FROM species WHERE name = 'Pokemon'),
    (SELECT id FROM vets WHERE name = 'Stephanie Mendez')),
    ((SELECT id FROM species WHERE name = 'Digimon'),
    (SELECT id FROM vets WHERE name = 'Jack Harkness'));

INSERT INTO visits VALUES 
    ((SELECT id FROM animals WHERE name = 'Agumon'),
    (SELECT id FROM vets WHERE name = 'William Tatcher'), '2020/05/24'),
    ((SELECT id FROM animals WHERE name = 'Agumon'),
    (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2020/07/22'),
    ((SELECT id FROM animals WHERE name = 'Gabumon'),
    (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2021/02/02'),
    ((SELECT id FROM animals WHERE name = 'Pikachu'),
    (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020/01/05'),
    ((SELECT id FROM animals WHERE name = 'Pikachu'),
    (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020/03/08'),
    ((SELECT id FROM animals WHERE name = 'Pikachu'),
    (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020/05/14'),
    ((SELECT id FROM animals WHERE name = 'Devimon'),
    (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2021/05/04'),
    ((SELECT id FROM animals WHERE name = 'Charmander'),
    (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2021/02/24'),
    ((SELECT id FROM animals WHERE name = 'Plantmon'),
    (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019/12/21'),
    ((SELECT id FROM animals WHERE name = 'Plantmon'),
    (SELECT id FROM vets WHERE name = 'William Tatcher'), '2020/08/10'),
    ((SELECT id FROM animals WHERE name = 'Plantmon'),
    (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2021/04/07'),
    ((SELECT id FROM animals WHERE name = 'Squirtle'),
    (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2019/09/29'),
    ((SELECT id FROM animals WHERE name = 'Angemon'),
    (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2020/10/03'),
    ((SELECT id FROM animals WHERE name = 'Angemon'),
    (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2020/11/04'),
    ((SELECT id FROM animals WHERE name = 'Boarmon'),
    (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019/01/24'),
    ((SELECT id FROM animals WHERE name = 'Boarmon'),
    (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019/05/15'),
    ((SELECT id FROM animals WHERE name = 'Boarmon'),
    (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020/02/27'),
    ((SELECT id FROM animals WHERE name = 'Boarmon'),
    (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020/08/03'),
    ((SELECT id FROM animals WHERE name = 'Blossom'),
    (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2020/05/24'),
    ((SELECT id FROM animals WHERE name = 'Blossom'),
    (SELECT id FROM vets WHERE name = 'William Tatcher'), '2021/01/11');

-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) 
    SELECT * FROM (SELECT id FROM animals) animal_ids,
    (SELECT id FROM vets) vets_ids, generate_series
    ('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) 
    select 'Owner ' || generate_series(1,2500000), 'owner_' 
        || generate_series(1,2500000) || '@mail.com';