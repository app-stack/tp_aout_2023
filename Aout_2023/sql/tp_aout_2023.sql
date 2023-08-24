-- créer la base de données

create database tp_aout_2023;
use tp_aout_2023;

-- créer les tables

create table ticket(
id_ticket int primary key auto_increment not null,
nom_ticket varchar (50) not null,
description_ticket text not null,
date_ouverture datetime not null,
date_fermeture datetime null,
id_logiciel int not null,
id_type_ticket int not null,
id_statut int not null,
id_materiel int not null,
id_utilisateur int not null
)Engine=InnoDB;

create table solution(
id_solution int primary key auto_increment not null,
nom_solution varchar (50) not null,
description_solution text not null,
date_creation datetime not null,
date_modification datetime not null,
id_type_solution int not null,
id_materiel int not null,
id_logiciel int not null,
id_utilisateur int null
)Engine=InnoDB;

create table intervention(
id_intervention int primary key auto_increment not null,
description_intervention text not null,
date_intervention datetime not null,
duree time not null,
verifie tinyint (1) default 0,
id_utilisateur int not null,
id_ticket int not null
)Engine=InnoDB;

create table materiel(
id_materiel int primary key auto_increment not null,
nom varchar (50) not null,
description_materiel text not null,
spare tinyint (1) default 0,
quantity int not null,
id_fabricant int not null,
id_type_materiel int not null
)Engine=InnoDB;

create table utilisateur(
id_utilisateur int primary key auto_increment not null,
nom varchar (50) not null,
prenom varchar (50) not null,
age int,
mail varchar (50),
password_utilisateur varchar (100),  
id_poste int not null
)Engine=InnoDB;


create table logiciel(
id_logiciel int primary key auto_increment not null,
nom varchar (50) not null,
description_logiciel text not null,
quantity int not null,
id_editeur int not null
)Engine=InnoDB;

create table editeur(
id_editeur int primary key auto_increment not null,
nom varchar (50) not null
)Engine=InnoDB;

create table statut(
id_statut int primary key auto_increment not null,
nom varchar (50) not null
)Engine=InnoDB;

create table poste(
id_poste int primary key auto_increment not null,
nom varchar (50) not null
)Engine=InnoDB;

create table type_ticket(
id_type_ticket int primary key auto_increment not null,
nom varchar (50) not null
)Engine=InnoDB;

create table fabricant(
id_fabricant int primary key auto_increment not null,
nom varchar (50) not null
)Engine=InnoDB;

create table type_materiel(
id_type_materiel int primary key auto_increment not null,
nom varchar (50) not null
)Engine=InnoDB;


create table type_solution(
id_type_solution int primary key auto_increment not null,
nom varchar (50) not null
)Engine=InnoDB;


-- table association

create table installer (
id_utilisateur int not null,
id_logiciel int not null,
primary key (id_utilisateur, id_logiciel)
)Engine=InnoDB;

create table assigner (
id_utilisateur int not null,
id_materiel int not null,
primary key (id_utilisateur, id_materiel)
)Engine=InnoDB;

create table incorporer (
id_intervention int not null,
id_solution int not null,
primary key (id_intervention, id_solution)
)Engine=InnoDB;


-- contraintes foreign key

-- contraintes foreign key logiciel

alter table logiciel
add constraint fk_editer_editeur
foreign key (id_editeur)
references editeur (id_editeur);

-- contraintes foreign key utilisateur

alter table utilisateur 
add constraint fk_occuper_poste
foreign key (id_poste)
references poste (id_poste);

-- contraintes foreign key ticket

alter table ticket
add constraint fk_inclure_logiciel
foreign key (id_logiciel)
references logiciel (id_logiciel);

alter table ticket
add constraint fk_detailler_type_ticket
foreign key (id_type_ticket)
references type_ticket (id_type_ticket);

alter table ticket
add constraint fk_posseder_statut
foreign key (id_statut)
references statut (id_statut);

alter table ticket
add constraint fk_lier_materiel
foreign key (id_materiel)
references materiel (id_materiel);

alter table ticket
add constraint fk_rediger_utilisateur
foreign key (id_utilisateur)
references utilisateur (id_utilisateur); 

-- contraintes foreign key intervention

alter table intervention
add constraint fk_ajouter_utilisateur
foreign key (id_utilisateur)
references utilisateur (id_utilisateur); 

alter table intervention
add constraint fk_intervenir_ticket
foreign key (id_ticket)
references ticket (id_ticket);

 -- contraintes foreign key materiel
 
alter table materiel
add constraint fk_fabriquer_fabricant
foreign key (id_fabricant)
references fabricant (id_fabricant);

alter table materiel
add constraint fk_completer_type_materiel
foreign key (id_type_materiel)
references type_materiel (id_type_materiel);

 -- contraintes foreign key solution
 
alter table solution
add constraint fk_classer_type_solution
foreign key (id_type_solution)
references type_solution (id_type_solution);

alter table solution
add constraint fk_appliquer_materiel
foreign key (id_materiel)
references materiel (id_materiel);


alter table solution
add constraint fk_depanner_logiciel
foreign key (id_logiciel)
references logiciel (id_logiciel);

alter table solution
add constraint fk_ecrire_utilisateur
foreign key (id_utilisateur)
references utilisateur (id_utilisateur);



