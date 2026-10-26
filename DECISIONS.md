# Decizii de proiectare

1. **Tipuri de date:** S-a folosit `DECIMAL(10,2)` la campurile `pret` si `pret_unitar` pentru a asigura precizia financiara si a evita erorile de rotunjire specifice tipurilor float/double.
2. **Constrangeri CHECK:** S-au adaugat constrangeri `CHECK (stoc_curent >= 0)` si `CHECK (cantitate > 0)` direct pe tabela pentru a preveni valori negative si a mentine integritatea la nivel de SGBD[cite: 1].
3. **Constrangeri ON DELETE:** 
   - S-a aplicat `ON DELETE RESTRICT` pentru relatia Produse-Categorii, blocand stergerea unei categorii daca exista produse asociate.
   - S-a aplicat `ON DELETE CASCADE` pentru relatia Comenzi-Linii_Comanda, astfel incat stergerea unei comenzi elimina automat si liniile aferente.
