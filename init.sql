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

-- Tabel 6: Linii_Comanda (Tabel de legatura M:N)
CREATE TABLE Linii_Comanda (
    comanda_id INT NOT NULL,
    produs_id INT NOT NULL,
    cantitate INT NOT NULL CHECK (cantitate > 0),
    pret_unitar DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (comanda_id, produs_id),
    FOREIGN KEY (comanda_id) REFERENCES Comenzi(id) ON DELETE CASCADE,
    FOREIGN KEY (produs_id) REFERENCES Produse(id) ON DELETE RESTRICT
);

-- ==========================================
-- FIXTURES (Date de test pentru initializare)
-- ==========================================

INSERT INTO Roluri (nume_rol) VALUES ('Administrator'), ('Angajat'), ('Client');

INSERT INTO Utilizatori (nume, email, parola_hash, rol_id) VALUES 
('Admin', 'admin@magazin.ro', 'hash_parola_admin', 1),
('Popescu Ion', 'ion@gmail.com', 'hash_parola_client', 3);

INSERT INTO Categorii (nume_categorie) VALUES 
('Placi Video'), ('Procesoare'), ('Laptopuri'), ('Monitoare'), ('Periferice');

INSERT INTO Produse (nume_produs, pret, stoc_curent, categorie_id) VALUES 
('ASUS Prime RTX 5080', 6500.00, 12, 1),
('AMD Ryzen 7 5700X3D', 1250.00, 25, 2),
('Laptop Toshiba', 13500.00, 5, 3),
('AORUS FO27Q2', 4800.00, 8, 4),
('Tastatura Redragon Horus K618', 350.00, 30, 5);

INSERT INTO Comenzi (status, utilizator_id) VALUES ('FINALIZATA', 2);

INSERT INTO Linii_Comanda (comanda_id, produs_id, cantitate, pret_unitar) VALUES 
(1, 1, 1, 6500.00), 
(1, 5, 1, 350.00);
