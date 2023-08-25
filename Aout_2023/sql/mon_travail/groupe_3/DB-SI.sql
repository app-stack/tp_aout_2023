create database if not exists SI_db;
use SI_db;

create table if not exists utilisateur(
	id_utilisateur int primary key not null auto_increment,
    nom_utilisateur varchar(50),
    prenom_utilisateur varchar(50),
    age_utilisateur int,
    mail_utilisateur varchar(50),
    password_utilisateur varchar(100) not null,
    id_poste int not null
    );

create table if not exists poste(
	id_poste int primary key not null auto_increment,
    nom_poste varchar(50)
    );
    
create table if not exists installer(
	id_utilisateur int not null,
    id_logiciel int not null,
    primary key (id_utilisateur,id_logiciel),
    num_license_installer varchar(50),
    date_assignation_installer datetime
    );
    
create table if not exists logiciel(
	id_logiciel int primary key not null auto_increment,
    nom_logiciel varchar(50),
    description_logiciel varchar(50),
    quantite_logiciel int,
    id_editeur int not null
    );
    
create table if not exists editeur(
	id_editeur int primary key not null auto_increment,
    nom_editeur varchar(50)
    );
    
create table if not exists ticket(
	id_ticket int primary key not null auto_increment,
    nom_ticket varchar(50),
    description_ticket text,
    date_ouverture datetime,
    date_fermeture datetime,
    id_logiciel int,
    id_type_ticket int not null,
    id_statut int not null,
    id_materiel int,
    id_utilisateur int not null
    );
    
create table if not exists statut(
	id_statut int primary key not null auto_increment,
    nom_statut varchar(50)
    );
    
create table if not exists type_ticket(
	id_type_ticket int primary key not null auto_increment,
	nom_type_ticket varchar(50)
    );
    
create table if not exists materiel(
	id_materiel int primary key not null auto_increment,
    nom_materiel varchar(50),
    description_materiel varchar(50),
    spare_materiel tinyint(1),
    quantite_materiel int,
    id_fabricant int not null,
    id_type_materiel int not null
    );
    
create table if not exists assigner(
	id_utilisateur int not null,
    id_materiel int not null,
    primary key (id_utilisateur,id_materiel),
    reference_assigner varchar(50),
    date_assignation_assigner datetime
    );
    
create table if not exists fabricant(
	id_fabricant int primary key not null auto_increment,
    nom_fabricant varchar(50)
    );

create table if not exists type_materiel(
	id_type_materiel int primary key not null auto_increment,
    nom_type_materiel varchar(50)
    );

create table if not exists intervention(
	id_intervention int primary key not null auto_increment,
    nom_intervention varchar(50),
    description_intervention varchar(50),
    date_intervention datetime,
    duree_intervention time,
    verifie_intervention tinyint(1),
    id_utilisateur int not null,
    id_ticket int not null
    );
    
create table if not exists incorporer(
	id_intervention int not null,
    id_solution int not null,
    primary key(id_intervention,id_solution)
    );

create table if not exists solution(
	id_solution int primary key not null auto_increment,
    nom_solution varchar(50),
    description_solution text,
    date_creation_solution datetime,
    date_creation_modification datetime,
    id_type_solution int not null,
    id_materiel int,
    id_logiciel int,
    id_utilisateur int not null
    );
    
create table if not exists type_solution(
	id_type_solution int primary key not null auto_increment,
    nom_type_solution varchar(50)
    );
    

alter table utilisateur add constraint fk_id_poste foreign key (id_poste) references poste(id_poste);
alter table installer add constraint fk_id_utilisateur_installer foreign key (id_utilisateur) references utilisateur(id_utilisateur);
alter table installer add constraint fk_id_logiciel_installer foreign key (id_logiciel) references logiciel(id_logiciel);
alter table logiciel add constraint fk_id_editeur foreign key(id_editeur) references editeur(id_editeur);
alter table assigner add constraint fk_id_utilisateur_assigner foreign key(id_utilisateur) references utilisateur(id_utilisateur);
alter table assigner add constraint fk_id_materiel_assigner foreign key(id_materiel) references materiel(id_materiel);
alter table materiel add constraint fk_id_fabricant foreign key(id_fabricant) references fabricant(id_fabricant);
alter table materiel add constraint fk_id_type_materiel foreign key(id_type_materiel) references type_materiel(id_type_materiel);
alter table ticket add constraint fk_id_logiciel_ticket foreign key(id_logiciel) references logiciel(id_logiciel);
alter table ticket add constraint fk_id_type_ticket foreign key(id_type_ticket) references type_ticket(id_type_ticket);
alter table ticket add constraint fk_id_statut foreign key(id_statut) references statut(id_statut);
alter table ticket add constraint fk_id_materiel_ticket foreign key(id_materiel) references materiel(id_materiel);
alter table ticket add constraint fk_id_utilisateur_ticket foreign key (id_utilisateur) references utilisateur(id_utilisateur);
alter table intervention add constraint fk_id_utilisateur_intervention foreign key(id_utilisateur) references utilisateur(id_utilisateur);
alter table intervention add constraint fk_id_ticket foreign key(id_ticket) references ticket(id_ticket);
alter table incorporer add constraint fk_id_intervention foreign key(id_intervention) references intervention(id_intervention);
alter table incorporer add constraint fk_id_solution foreign key(id_solution) references solution(id_solution);
alter table solution add constraint fk_id_type_solution foreign key(id_type_solution) references type_solution(id_type_solution);
alter table solution add constraint fk_id_materiel_solution foreign key(id_materiel) references materiel(id_materiel);
alter table solution add constraint fk_id_logiciel_solution foreign key(id_logiciel) references logiciel(id_logiciel);
alter table solution add constraint fk_id_utilisateur_solution foreign key (id_utilisateur) references utilisateur(id_utilisateur);
    
insert into poste(nom_poste)
values("employe"), ("admin"), ("technicien"), ("responsable");
insert into utilisateur(nom_utilisateur, prenom_utilisateur, age_utilisateur, mail_utilisateur, password_utilisateur, id_poste)
values ("jean", "jo", 12, "abc","1234azerty", 2), ("kevin", "serda" , 31,"ae", "azeazrzar", 3), ("laurent", "teyssier", 30,"1234azerty", "etzerarazr", 1), ("leyla", "pasaj", 36,"1234azerty", "pezrozerzer", 4);
insert into fabricant (nom_fabricant)
values("acer"), ("nvidia"), ("gigabyte");
insert into type_materiel(nom_type_materiel)
values("ecran"), ("pc portable"), ("desktop"), ("clavier"), ("souris");
insert into materiel (nom_materiel, description_materiel, spare_materiel, quantite_materiel, id_fabricant, id_type_materiel)
values ("aa", "aae", 0, 8, 1, 1), ("ee", "eea", 1, 41, 2, 2);
insert into editeur(nom_editeur)
values("microsoft"),("oracle");
insert into logiciel(nom_logiciel, description_logiciel, quantite_logiciel, id_editeur)
values("photoshop", "photo", 12, 1), ("word", "texte", 5, 1), ("apache", "bdd", 4, 2);
insert into statut(nom_statut)
values ("en cours"), ("traité"), ("à point"), ("saignant");

insert into type_ticket(nom_type_ticket)
values ("pikachu"), ("feu"), ("metro"), ("eau");

insert into ticket(nom_ticket, description_ticket, date_ouverture, id_type_ticket, id_statut, id_materiel, id_utilisateur, id_logiciel)
values ("aeae", "aeaeae", "2023-05-05", 1, 1, 1, 1,1), ("aae", "aeaeae", "2023-05-25", 2, 2, 1, 1,1);

insert into intervention (nom_intervention, description_intervention, date_intervention, duree_intervention, verifie_intervention,id_utilisateur, id_ticket)
values("jhfjkhg", "dfsfdjdkg", "2024-12-06", "00:00:20", false, 1 , 1),
("jhfjkhg", "dfsfdjdkg", "2024-12-06", "00:00:20", false, 1 , 1),
 ("jhfjkhg", "dfsfdjdkg", "2024-12-06", "00:00:20", false, 1 , 1),
 ("jhfjkhg", "dfsfdjdkg", "2024-12-06", "00:00:20", false, 2 , 2),
 ("jhfjkhg", "dfsfdjdkg", "2024-12-06", "00:00:20", false, 2 , 2),
 ("jhfjkhg", "dfsfdjdkg", "2024-12-06", "00:00:20", false, 3 , 2);

select nom_utilisateur,prenom_utilisateur,nom_poste
from utilisateur
inner join poste
on utilisateur.id_poste = poste.id_poste;

select nom_utilisateur,prenom_utilisateur,nom_poste
from utilisateur
inner join poste
on utilisateur.id_poste = poste.id_poste
where nom_poste = "technicien";

select nom_materiel, description_materiel, quantite_materiel, nom_fabricant, nom_type_materiel
from materiel
inner join fabricant
on materiel.id_fabricant = fabricant.id_fabricant
inner join type_materiel
on materiel.id_type_materiel = type_materiel.id_type_materiel;

select nom_logiciel, description_logiciel, nom_editeur
from logiciel
inner join editeur 
on logiciel.id_editeur = editeur.id_editeur;

select nom_ticket, description_ticket, date_ouverture_ticket, nom_statut, nom_utilisateur, prenom_utilisateur, nom_type_ticket
from ticket
inner join statut
on ticket.id_statut = statut.id_statut
inner join utilisateur
on ticket.id_utilisateur = utilisateur.id_utilisateur
inner join type_ticket
on ticket.id_type_ticket = type_ticket.id_type_ticket;

select nom_intervention, description_intervention, date_intervention, duree_intervention, nom_utilisateur, prenom_utilisateur, nom_poste
from intervention
inner join utilisateur
on intervention.id_utilisateur = utilisateur.id_utilisateur
inner join poste
on utilisateur.id_poste = poste.id_poste
where nom_poste = "technicien";

select nom_intervention, description_intervention, date_intervention, duree_intervention, nom_utilisateur, prenom_utilisateur
from intervention
inner join utilisateur
on intervention.id_utilisateur = utilisateur.id_utilisateur
where date_intervention = "2024-12-06";

select distinct nom_utilisateur, prenom_utilisateur, count(intervention.id_utilisateur) over (partition by intervention.id_utilisateur) as nombre_demandes
from utilisateur
inner join intervention
on utilisateur.id_utilisateur = intervention.id_utilisateur
order by nom_utilisateur asc, prenom_utilisateur asc;

select nom_utilisateur, prenom_utilisateur, count(intervention.id_utilisateur) over (partition by intervention.id_utilisateur ) as nombre_demandes, nom_poste
from utilisateur
inner join intervention
on utilisateur.id_utilisateur = intervention.id_utilisateur
inner join poste
on utilisateur.id_poste = poste.id_poste
order by nombre_demandes desc limit 1;

select nom_ticket, description_ticket, date_ouverture_ticket, count(intervention.id_ticket) over (partition by id_intervention) as nombre_ticket
from ticket
inner join intervention 
on ticket.id_ticket = intervention.id_ticket;
