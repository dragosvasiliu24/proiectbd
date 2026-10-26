CREATE DATABASE IF NOT EXISTS magazin_componente;
USE magazin_componente;

-- Tabel 1: Roluri
CREATE TABLE Roluri (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nume_rol VARCHAR(50) NOT NULL UNIQUE
);

-- Tabel 2: Utilizatori
CREATE TABLE Utilizatori (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nume VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    parola_hash VARCHAR(255) NOT NULL,
    rol_id INT NOT NULL,
    FOREIGN KEY (rol_id) REFERENCES Roluri(id) ON DELETE RESTRICT
);

-- Tabel 3: Categorii
CREATE TABLE Categorii (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nume_categorie VARCHAR(100) NOT NULL UNIQUE
);

-- Tabel 4: Produse
CREATE TABLE Produse (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nume_produs VARCHAR(150) NOT NULL,
    pret DECIMAL(10, 2) NOT NULL,
    stoc_curent INT NOT NULL CHECK (stoc_curent >= 0),
    categorie_id INT NOT NULL,
    FOREIGN KEY (categorie_id) REFERENCES Categorii(id) ON DELETE RESTRICT
);

-- Tabel 5: Comenzi
CREATE TABLE Comenzi (
    id INT AUTO_INCREMENT PRIMARY KEY,
    data_comanda DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) NOT NULL DEFAULT 'IN_ASTEPTARE',
    utilizator_id INT NOT NULL,
    FOREIGN KEY (utilizator_id) REFERENCES Utilizatori(id) ON DELETE CASCADE
);

-- Tabel 6: Linii_Comanda (Tabel de legătură M:N)
CREATE TABLE Linii_Comanda (
    comanda_id INT NOT NULL,
    produs_id INT NOT NULL,
    cantitate INT NOT NULL CHECK (cantitate > 0),
    pret_unitar DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (comanda_id, produs_id),
    FOREIGN KEY (comanda_id) REFERENCES Comenzi(id) ON DELETE CASCADE,
    FOREIGN KEY (produs_id) REFERENCES Produse(id) ON DELETE RESTRICT
);
