**# Sistem de gestiune magazin componente hardware

## Etapa 0: Tema
Sistem back-office pentru gestionarea inventarului și procesarea vânzărilor de componente PC. Baza de date relațională MySQL gestionează stocuri, comenzi, clienți și drepturi de acces.

## Etapa 1: Modelare
Modelul conține 6 tabele cu relații PK/FK:
- `Roluri` (1:N cu Utilizatori)
- `Utilizatori` (1:N cu Comenzi)
- `Categorii` (1:N cu Produse)
- `Produse` (1:N cu Linii_Comanda)
- `Comenzi` (1:N cu Linii_Comanda)
- `Linii_Comanda` (tabel de legătură M:N între Comenzi și Produse)

Fixtures: Datele de test sunt încărcate la pornirea serviciului prin scriptul `init.sql`.**
