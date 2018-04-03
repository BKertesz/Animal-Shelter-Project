DROP TABLE animals;
DROP TABLE owners;


CREATE TABLE owners(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  notes TEXT
);


CREATE TABLE animals(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  breed VARCHAR(255),
  status VARCHAR(255),
  admission_date VARCHAR(255),
  owner_id INT REFERENCES owners(id),
  age INT,
  description TEXT,
  gender VARCHAR(255)
);

/* EOF */
