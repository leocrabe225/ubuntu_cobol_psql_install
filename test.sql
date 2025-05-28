CREATE DATABASE testdb;

\c testdb

CREATE TABLE clients (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(50),
    prenom VARCHAR(50),
    telephone VARCHAR(20)
);

INSERT INTO clients (nom, prenom, telephone)
VALUES
    ('Durand', 'Sophie', '0612345678'),
    ('Lemoine', 'Alex', '0623456789'),
    ('Martin', 'Lucie', '0634567890');
