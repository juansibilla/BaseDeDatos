CREATE TABLE film (
	film_id INT NOT NULL AUTO_INCREMENT,
	title VARCHAR(30), 
	description VARCHAR(40), 
	release_year DATE, 
	PRIMARY KEY(film_id));

CREATE TABLE actor (
	actor_id INT NOT NULL AUTO_INCREMENT,
	first_name VARCHAR(20),
	last_name VARCHAR(30), 
	PRIMARY KEY(actor_id));

CREATE TABLE film_actor (
	film_id INT NOT NULL, 
	actor_id INT NOT NULL);

ALTER TABLE film 
	ADD COLUMN last_update TIMESTAMP 
		DEFAULT CURRENT_TIMESTAMP 
		ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE actor
	ADD COLUMN last_update TIMESTAMP 
		DEFAULT CURRENT_TIMESTAMP 
		ON UPDATE CURRENT_TIMESTAMP;
	
ALTER TABLE film_actor 
	ADD FOREIGN KEY (film_id) REFERENCES film(film_id), 
	ADD FOREIGN KEY (actor_id) REFERENCES actor(actor_id);

INSERT INTO film (title, description, release_year) VALUES 
	('Toy Story', 'Descripcion de Toy Story', '1987-02-01'), 
	('Cars', 'Descripcion de Cars', '1989-02-02'),
	('Titanic', 'Descripcion de Titanic', '1904-03-01'),
	('Dracula', 'Descripcion de Dracula', '1986-11-08');

INSERT INTO actor (first_name, last_name) VALUES 
	('Pepito', 'Gonzales'),
	('Pepita', 'Martines'),
	('Pepite', 'Hernandes'),
	('Pepitu', 'Garcia'),
	('Pepiti', 'Giordano'),
	('Pep', 'Herera');

INSERT INTO film_actor VALUES
	(2, 1),
	(1, 4),
	(2, 1),
	(3, 4),
	(4, 3),
	(1, 5),
	(1, 4),
	(4, 5);
