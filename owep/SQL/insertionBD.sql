/***************************************
 * Insertion dans le mod�le processus. *
 ***************************************/
INSERT INTO PRC_PROCESSUS (PRC_NOM, PRC_DESCRIPTION, PRC_NOMAUTEUR, PRC_MAILAUTEUR)
VALUES ('PROJET1', 'DESCRIPTION1', 'NOMAUTEUR1', 'MAILAUTEUR1') ;

INSERT INTO COM_COMPOSANT (COM_NOM, COM_DESCRIPTION, COM_NOMAUTEUR, COM_MAILAUTEUR, COM_PRC_ID)
VALUES ('COMPOSANT1', 'DESCRIPTION1', 'NOMAUTEUR1', 'MAILAUTEUR1', 1) ;
INSERT INTO COM_COMPOSANT (COM_NOM, COM_DESCRIPTION, COM_NOMAUTEUR, COM_MAILAUTEUR, COM_PRC_ID)
VALUES ('COMPOSANT2', 'DESCRIPTION2', 'NOMAUTEUR2', 'MAILAUTEUR2', 1) ;

INSERT INTO DFT_DEFINITIONTRAVAIL (DFT_NOM, DFT_DESCRIPTION, DFT_COM_ID)
VALUES ('DEFINITIONTRAVAIL1', 'DESCRIPTION1', 1) ;
INSERT INTO DFT_DEFINITIONTRAVAIL (DFT_NOM, DFT_DESCRIPTION, DFT_COM_ID)
VALUES ('DEFINITIONTRAVAIL2', 'DESCRIPTION2', 1) ;
INSERT INTO DFT_DEFINITIONTRAVAIL (DFT_NOM, DFT_DESCRIPTION, DFT_COM_ID)
VALUES ('DEFINITIONTRAVAIL3', 'DESCRIPTION3', 2) ;
INSERT INTO DFT_DEFINITIONTRAVAIL (DFT_NOM, DFT_DESCRIPTION, DFT_COM_ID)
VALUES ('DEFINITIONTRAVAIL4', 'DESCRIPTION4', 2) ;


INSERT INTO ACT_ACTIVITE (ACT_NOM, ACT_DESCRIPTION, ACT_DFT_ID)
VALUES ('ACTIVITE1', 'DESCRIPTION1', 1) ;
INSERT INTO ACT_ACTIVITE (ACT_NOM, ACT_DESCRIPTION, ACT_DFT_ID)
VALUES ('ACTIVITE2', 'DESCRIPTION2', 1) ;
INSERT INTO ACT_ACTIVITE (ACT_NOM, ACT_DESCRIPTION, ACT_DFT_ID)
VALUES ('ACTIVITE3', 'DESCRIPTION3', 2) ;
INSERT INTO ACT_ACTIVITE (ACT_NOM, ACT_DESCRIPTION, ACT_DFT_ID)
VALUES ('ACTIVITE4', 'DESCRIPTION4', 1) ;
INSERT INTO ACT_ACTIVITE (ACT_NOM, ACT_DESCRIPTION, ACT_DFT_ID)
VALUES ('ACTIVITE5', 'DESCRIPTION5', 3) ;
INSERT INTO ACT_ACTIVITE (ACT_NOM, ACT_DESCRIPTION, ACT_DFT_ID)
VALUES ('ACTIVITE6', 'DESCRIPTION6', 3) ;
INSERT INTO ACT_ACTIVITE (ACT_NOM, ACT_DESCRIPTION, ACT_DFT_ID)
VALUES ('ACTIVITE7', 'DESCRIPTION7', 4) ;
INSERT INTO ACT_ACTIVITE (ACT_NOM, ACT_DESCRIPTION, ACT_DFT_ID)
VALUES ('ACTIVITE8', 'DESCRIPTION8', 4) ;


INSERT INTO ROL_ROLE (ROL_NOM, ROL_DESCRIPTION, ROL_COM_ID)
VALUES ('ROLE1', 'DESCRIPTION1', 1) ;
INSERT INTO ROL_ROLE (ROL_NOM, ROL_DESCRIPTION, ROL_COM_ID)
VALUES ('ROLE2', 'DESCRIPTION2', 1) ;
INSERT INTO ROL_ROLE (ROL_NOM, ROL_DESCRIPTION, ROL_COM_ID)
VALUES ('ROLE3', 'DESCRIPTION3', 2) ;
INSERT INTO ROL_ROLE (ROL_NOM, ROL_DESCRIPTION, ROL_COM_ID)
VALUES ('ROLE4', 'DESCRIPTION4', 2) ;


INSERT INTO PRD_PRODUIT (PRD_NOM, PRD_DESCRIPTION, PRD_COM_ID, PRD_ROL_ID)
VALUES ('PRODUIT1', 'DESCRIPTION1', 1, 1) ;
INSERT INTO PRD_PRODUIT (PRD_NOM, PRD_DESCRIPTION, PRD_COM_ID, PRD_ROL_ID)
VALUES ('PRODUIT2', 'DESCRIPTION2', 1, 2) ;
INSERT INTO PRD_PRODUIT (PRD_NOM, PRD_DESCRIPTION, PRD_COM_ID, PRD_ROL_ID)
VALUES ('PRODUIT3', 'DESCRIPTION3', 1, 1) ;
INSERT INTO PRD_PRODUIT (PRD_NOM, PRD_DESCRIPTION, PRD_COM_ID, PRD_ROL_ID)
VALUES ('PRODUIT4', 'DESCRIPTION4', 1, 2) ;
INSERT INTO PRD_PRODUIT (PRD_NOM, PRD_DESCRIPTION, PRD_COM_ID, PRD_ROL_ID)
VALUES ('PRODUIT5', 'DESCRIPTION5', 2, 1) ;
INSERT INTO PRD_PRODUIT (PRD_NOM, PRD_DESCRIPTION, PRD_COM_ID, PRD_ROL_ID)
VALUES ('PRODUIT6', 'DESCRIPTION6', 2, 2) ;
INSERT INTO PRD_PRODUIT (PRD_NOM, PRD_DESCRIPTION, PRD_COM_ID, PRD_ROL_ID)
VALUES ('PRODUIT7', 'DESCRIPTION7', 2, 1) ;
INSERT INTO PRD_PRODUIT (PRD_NOM, PRD_DESCRIPTION, PRD_COM_ID, PRD_ROL_ID)
VALUES ('PRODUIT8', 'DESCRIPTION8', 2, 2) ;
INSERT INTO PRD_PRODUIT (PRD_NOM, PRD_DESCRIPTION, PRD_COM_ID, PRD_ROL_ID)
VALUES ('PRODUIT9', 'DESCRIPTION9', 1, 1) ;
INSERT INTO PRD_PRODUIT (PRD_NOM, PRD_DESCRIPTION, PRD_COM_ID, PRD_ROL_ID)
VALUES ('PRODUIT10', 'DESCRIPTION10', 1, 2) ;
INSERT INTO PRD_PRODUIT (PRD_NOM, PRD_DESCRIPTION, PRD_COM_ID, PRD_ROL_ID)
VALUES ('PRODUIT11', 'DESCRIPTION11', 2, 1) ;
INSERT INTO PRD_PRODUIT (PRD_NOM, PRD_DESCRIPTION, PRD_COM_ID, PRD_ROL_ID)
VALUES ('PRODUIT12', 'DESCRIPTION12', 2, 2) ;


INSERT INTO R01_ACT_PRD_ENTREE (R01_ACT_ID, R01_PRD_ID)
VALUES (2, 1) ;
INSERT INTO R01_ACT_PRD_ENTREE (R01_ACT_ID, R01_PRD_ID)
VALUES (3, 2) ;
INSERT INTO R01_ACT_PRD_ENTREE (R01_ACT_ID, R01_PRD_ID)
VALUES (4, 3) ;
INSERT INTO R01_ACT_PRD_ENTREE (R01_ACT_ID, R01_PRD_ID)
VALUES (5, 4) ;
INSERT INTO R01_ACT_PRD_ENTREE (R01_ACT_ID, R01_PRD_ID)
VALUES (6, 5) ;
INSERT INTO R01_ACT_PRD_ENTREE (R01_ACT_ID, R01_PRD_ID)
VALUES (7, 6) ;
INSERT INTO R01_ACT_PRD_ENTREE (R01_ACT_ID, R01_PRD_ID)
VALUES (8, 7) ;
INSERT INTO R01_ACT_PRD_ENTREE (R01_ACT_ID, R01_PRD_ID)
VALUES (2, 8) ;
INSERT INTO R01_ACT_PRD_ENTREE (R01_ACT_ID, R01_PRD_ID)
VALUES (5, 9) ;
INSERT INTO R01_ACT_PRD_ENTREE (R01_ACT_ID, R01_PRD_ID)
VALUES (8, 10) ;
INSERT INTO R01_ACT_PRD_ENTREE (R01_ACT_ID, R01_PRD_ID)
VALUES (8, 11) ;
INSERT INTO R01_ACT_PRD_ENTREE (R01_ACT_ID, R01_PRD_ID)
VALUES (6, 12) ;


INSERT INTO R02_ACT_PRD_SORTIE (R02_ACT_ID, R02_PRD_ID)
VALUES (1, 1) ;
INSERT INTO R02_ACT_PRD_SORTIE (R02_ACT_ID, R02_PRD_ID)
VALUES (2, 2) ;
INSERT INTO R02_ACT_PRD_SORTIE (R02_ACT_ID, R02_PRD_ID)
VALUES (3, 3) ;
INSERT INTO R02_ACT_PRD_SORTIE (R02_ACT_ID, R02_PRD_ID)
VALUES (4, 4) ;
INSERT INTO R02_ACT_PRD_SORTIE (R02_ACT_ID, R02_PRD_ID)
VALUES (5, 5) ;
INSERT INTO R02_ACT_PRD_SORTIE (R02_ACT_ID, R02_PRD_ID)
VALUES (6, 6) ;
INSERT INTO R02_ACT_PRD_SORTIE (R02_ACT_ID, R02_PRD_ID)
VALUES (7, 7) ;
INSERT INTO R02_ACT_PRD_SORTIE (R02_ACT_ID, R02_PRD_ID)
VALUES (1, 8) ;
INSERT INTO R02_ACT_PRD_SORTIE (R02_ACT_ID, R02_PRD_ID)
VALUES (5, 9) ;
INSERT INTO R02_ACT_PRD_SORTIE (R02_ACT_ID, R02_PRD_ID)
VALUES (7, 10) ;
INSERT INTO R02_ACT_PRD_SORTIE (R02_ACT_ID, R02_PRD_ID)
VALUES (2, 11) ;
INSERT INTO R02_ACT_PRD_SORTIE (R02_ACT_ID, R02_PRD_ID)
VALUES (5, 12) ;


INSERT INTO R03_ACT_ROL (R03_ACT_ID, R03_ROL_ID)
VALUES (1, 1) ;
INSERT INTO R03_ACT_ROL (R03_ACT_ID, R03_ROL_ID)
VALUES (2, 2) ;
INSERT INTO R03_ACT_ROL (R03_ACT_ID, R03_ROL_ID)
VALUES (3, 3) ;
INSERT INTO R03_ACT_ROL (R03_ACT_ID, R03_ROL_ID)
VALUES (4, 4) ;
INSERT INTO R03_ACT_ROL (R03_ACT_ID, R03_ROL_ID)
VALUES (5, 1) ;
INSERT INTO R03_ACT_ROL (R03_ACT_ID, R03_ROL_ID)
VALUES (6, 2) ;
INSERT INTO R03_ACT_ROL (R03_ACT_ID, R03_ROL_ID)
VALUES (7, 3) ;
INSERT INTO R03_ACT_ROL (R03_ACT_ID, R03_ROL_ID)
VALUES (8, 4) ;
INSERT INTO R03_ACT_ROL (R03_ACT_ID, R03_ROL_ID)
VALUES (1, 2) ;
INSERT INTO R03_ACT_ROL (R03_ACT_ID, R03_ROL_ID)
VALUES (2, 3) ;
INSERT INTO R03_ACT_ROL (R03_ACT_ID, R03_ROL_ID)
VALUES (5, 4) ;
INSERT INTO R03_ACT_ROL (R03_ACT_ID, R03_ROL_ID)
VALUES (6, 1) ;






/***************************************
 * Insertion dans le mod�le ex�cution. *
 ***************************************/
INSERT INTO PRJ_PROJET (PRJ_NOM, PRJ_DESCRIPTION, PRJ_DATEDEBUTPREVUE, PRJ_DATEFINPREVUE, PRJ_PRC_ID)
VALUES ('PROJET1', 'DESCRIPTION1', '2005-01-01', '2005-12-31', 1) ;

INSERT INTO ITE_ITERATION (ITE_ID, ITE_NUMERO, ITE_NOM, ITE_DATEDEBUTPREVUE, ITE_DATEFINPREVUE, ITE_DATEDEBUTREELLE, ITE_DATEFINREELLE, ITE_ETAT, ITE_PRJ_ID)
VALUES (1, 1, 'ITERATION1', '2005-01-01', '2005-02-01', NULL, NULL, 1, 1) ;
INSERT INTO ITE_ITERATION (ITE_ID, ITE_NUMERO, ITE_NOM, ITE_DATEDEBUTPREVUE, ITE_DATEFINPREVUE, ITE_DATEDEBUTREELLE, ITE_DATEFINREELLE, ITE_ETAT, ITE_PRJ_ID)
VALUES (2, 2, 'ITERATION2', '2005-02-01', '2005-03-15', NULL, NULL, 0, 1) ;
INSERT INTO ITE_ITERATION (ITE_ID, ITE_NUMERO, ITE_NOM, ITE_DATEDEBUTPREVUE, ITE_DATEFINPREVUE, ITE_DATEDEBUTREELLE, ITE_DATEFINREELLE, ITE_ETAT, ITE_PRJ_ID)
VALUES (3, 3, 'ITERATION3', '2005-03-01', '2005-04-01', NULL, NULL, 0, 1) ;

INSERT INTO COL_COLLABORATEUR (COL_NOM, COL_PRENOM, COL_ADRESSE, COL_TELEPHONE, COL_PORTABLE, COL_EMAIL, COL_COMMENTAIRES, COL_UTILISATEUR, COL_MOTDEPASSE, COL_TACHEENCOURS, COL_DROIT)
VALUES ('NOM1', 'PRENOM1', 'ADRESSE1', 'TELEPHONE1', 'PORTABLE1', 'EMAIL1', 'COMMENTAIRES1', 'USER1', '', -1, 1) ;
INSERT INTO COL_COLLABORATEUR (COL_NOM, COL_PRENOM, COL_ADRESSE, COL_TELEPHONE, COL_PORTABLE, COL_EMAIL, COL_COMMENTAIRES, COL_UTILISATEUR, COL_MOTDEPASSE, COL_TACHEENCOURS, COL_DROIT)
VALUES ('NOM2', 'PRENOM2', 'ADRESSE2', 'TELEPHONE2', 'PORTABLE2', 'EMAIL2', 'COMMENTAIRES2', 'USER2', '', -1, 0) ;
INSERT INTO COL_COLLABORATEUR (COL_NOM, COL_PRENOM, COL_ADRESSE, COL_TELEPHONE, COL_PORTABLE, COL_EMAIL, COL_COMMENTAIRES, COL_UTILISATEUR, COL_MOTDEPASSE, COL_TACHEENCOURS, COL_DROIT)
VALUES ('NOM3', 'PRENOM3', 'ADRESSE3', 'TELEPHONE3', 'PORTABLE3', 'EMAIL3', 'COMMENTAIRES3', 'USER3', '', -1, 0) ;
INSERT INTO COL_COLLABORATEUR (COL_NOM, COL_PRENOM, COL_ADRESSE, COL_TELEPHONE, COL_PORTABLE, COL_EMAIL, COL_COMMENTAIRES, COL_UTILISATEUR, COL_MOTDEPASSE, COL_TACHEENCOURS, COL_DROIT)
VALUES ('NOM4', 'PRENOM4', 'ADRESSE4', 'TELEPHONE4', 'PORTABLE4', 'EMAIL4', 'COMMENTAIRES4', 'USER4', '', -1, 0) ;
INSERT INTO COL_COLLABORATEUR (COL_NOM, COL_PRENOM, COL_ADRESSE, COL_TELEPHONE, COL_PORTABLE, COL_EMAIL, COL_COMMENTAIRES, COL_UTILISATEUR, COL_MOTDEPASSE, COL_TACHEENCOURS, COL_DROIT)
VALUES ('NOM5', 'PRENOM5', 'ADRESSE5', 'TELEPHONE5', 'PORTABLE5', 'EMAIL5', 'COMMENTAIRES5', 'USER5', '', -1, 0) ;
INSERT INTO COL_COLLABORATEUR (COL_NOM, COL_PRENOM, COL_ADRESSE, COL_TELEPHONE, COL_PORTABLE, COL_EMAIL, COL_COMMENTAIRES, COL_UTILISATEUR, COL_MOTDEPASSE, COL_TACHEENCOURS, COL_DROIT)
VALUES ('NOM6', 'PRENOM6', 'ADRESSE6', 'TELEPHONE6', 'PORTABLE6', 'EMAIL6', 'COMMENTAIRES6', 'USER6', '', -1, 0) ;


INSERT INTO TAC_TACHE (TAC_NOM, TAC_DESCRIPTION, TAC_CHARGEINITIALE, TAC_TEMPSPASSE, TAC_RESTEAPASSER, TAC_ETAT, TAC_DATEDEBUTPREVUE, TAC_DATEFINPREVUE, TAC_DATEDEBUTREELLE, TAC_DATEFINREELLE, TAC_ITE_ID, TAC_COL_ID, TAC_ACT_ID)
VALUES ('TACHE1', 'DESCRIPTION1', 10.0, 0.0, 10.0, -1, '2005-01-01', '2005-01-10', NULL, NULL, 1, 1, 1) ;
INSERT INTO TAC_TACHE (TAC_NOM, TAC_DESCRIPTION, TAC_CHARGEINITIALE, TAC_TEMPSPASSE, TAC_RESTEAPASSER, TAC_ETAT, TAC_DATEDEBUTPREVUE, TAC_DATEFINPREVUE, TAC_DATEDEBUTREELLE, TAC_DATEFINREELLE, TAC_ITE_ID, TAC_COL_ID, TAC_ACT_ID)
VALUES ('TACHE2', 'DESCRIPTION2', 9.0,  0.0, 9.0, -1, '2005-01-10', '2005-01-19', NULL, NULL, 1, 2, 1) ;
INSERT INTO TAC_TACHE (TAC_NOM, TAC_DESCRIPTION, TAC_CHARGEINITIALE, TAC_TEMPSPASSE, TAC_RESTEAPASSER, TAC_ETAT, TAC_DATEDEBUTPREVUE, TAC_DATEFINPREVUE, TAC_DATEDEBUTREELLE, TAC_DATEFINREELLE, TAC_ITE_ID, TAC_COL_ID, TAC_ACT_ID)
VALUES ('TACHE3', 'DESCRIPTION3', 8.0,  0.0, 8.0, -1, '2005-01-01', '2005-01-08', NULL, NULL, 1, 3, 2) ;
INSERT INTO TAC_TACHE (TAC_NOM, TAC_DESCRIPTION, TAC_CHARGEINITIALE, TAC_TEMPSPASSE, TAC_RESTEAPASSER, TAC_ETAT, TAC_DATEDEBUTPREVUE, TAC_DATEFINPREVUE, TAC_DATEDEBUTREELLE, TAC_DATEFINREELLE, TAC_ITE_ID, TAC_COL_ID, TAC_ACT_ID)
VALUES ('TACHE4', 'DESCRIPTION4', 10.0, 0.0, 10.0, -1, '2005-01-01', '2005-01-10', NULL, NULL, 1, 4, 3) ;
INSERT INTO TAC_TACHE (TAC_NOM, TAC_DESCRIPTION, TAC_CHARGEINITIALE, TAC_TEMPSPASSE, TAC_RESTEAPASSER, TAC_ETAT, TAC_DATEDEBUTPREVUE, TAC_DATEFINPREVUE, TAC_DATEDEBUTREELLE, TAC_DATEFINREELLE, TAC_ITE_ID, TAC_COL_ID, TAC_ACT_ID)
VALUES ('TACHE5', 'DESCRIPTION5', 2.0,  0.0, 2.0, 0, '2005-02-01', '2005-02-02', NULL, NULL, 1, 1, 4) ;
INSERT INTO TAC_TACHE (TAC_NOM, TAC_DESCRIPTION, TAC_CHARGEINITIALE, TAC_TEMPSPASSE, TAC_RESTEAPASSER, TAC_ETAT, TAC_DATEDEBUTPREVUE, TAC_DATEFINPREVUE, TAC_DATEDEBUTREELLE, TAC_DATEFINREELLE, TAC_ITE_ID, TAC_COL_ID, TAC_ACT_ID)
VALUES ('TACHE6', 'DESCRIPTION6', 4.0,  0.0, 4.0, -1, '2005-02-01', '2005-02-04', NULL, NULL, 2, 5, 5) ;
INSERT INTO TAC_TACHE (TAC_NOM, TAC_DESCRIPTION, TAC_CHARGEINITIALE, TAC_TEMPSPASSE, TAC_RESTEAPASSER, TAC_ETAT, TAC_DATEDEBUTPREVUE, TAC_DATEFINPREVUE, TAC_DATEDEBUTREELLE, TAC_DATEFINREELLE, TAC_ITE_ID, TAC_COL_ID, TAC_ACT_ID)
VALUES ('TACHE7', 'DESCRIPTION7', 6.0,  0.0, 6.0, -1, '2005-02-04', '2005-02-10', NULL, NULL, 2, 5, 6) ;
INSERT INTO TAC_TACHE (TAC_NOM, TAC_DESCRIPTION, TAC_CHARGEINITIALE, TAC_TEMPSPASSE, TAC_RESTEAPASSER, TAC_ETAT, TAC_DATEDEBUTPREVUE, TAC_DATEFINPREVUE, TAC_DATEDEBUTREELLE, TAC_DATEFINREELLE, TAC_ITE_ID, TAC_COL_ID, TAC_ACT_ID)
VALUES ('TACHE8', 'DESCRIPTION8', 5.0,  0.0, 5.0, -1, '2005-02-01', '2005-02-05', NULL, NULL, 2, 6, 7) ;


INSERT INTO ART_ARTEFACT (ART_NOM, ART_DESCRIPTION, ART_NOM_FICHIER, ART_PRJ_ID, ART_COL_ID, ART_TAC_ID_ENTREE, ART_TAC_ID_SORTIE, ART_PRD_ID)
VALUES ('ARTEFACT1',  'DESCRIPTION1', 'artefact1.txt', 1, 1, 2, 1, 1);
INSERT INTO ART_ARTEFACT (ART_NOM, ART_DESCRIPTION, ART_PRJ_ID, ART_COL_ID, ART_TAC_ID_ENTREE, ART_TAC_ID_SORTIE, ART_PRD_ID)
VALUES ('ARTEFACT2',  'DESCRIPTION2', 1, 1, 3, 2, 2);
INSERT INTO ART_ARTEFACT (ART_NOM, ART_DESCRIPTION, ART_NOM_FICHIER, ART_PRJ_ID, ART_COL_ID, ART_TAC_ID_ENTREE, ART_TAC_ID_SORTIE, ART_PRD_ID)
VALUES ('ARTEFACT3',  'DESCRIPTION3', 'artefact3.txt', 1, 1, 4, 3, 3);
INSERT INTO ART_ARTEFACT (ART_NOM, ART_DESCRIPTION, ART_PRJ_ID, ART_COL_ID, ART_TAC_ID_ENTREE, ART_TAC_ID_SORTIE, ART_PRD_ID)
VALUES ('ARTEFACT4',  'DESCRIPTION4', 1, 1, 1, 4, 4);
INSERT INTO ART_ARTEFACT (ART_NOM, ART_DESCRIPTION, ART_PRJ_ID, ART_COL_ID, ART_TAC_ID_ENTREE, ART_TAC_ID_SORTIE, ART_PRD_ID)
VALUES ('ARTEFACT5',  'DESCRIPTION5', 1, 1, 5, 1, 5);
INSERT INTO ART_ARTEFACT (ART_NOM, ART_DESCRIPTION, ART_PRJ_ID, ART_COL_ID, ART_TAC_ID_ENTREE, ART_TAC_ID_SORTIE, ART_PRD_ID)
VALUES ('ARTEFACT6',  'DESCRIPTION6', 1, 1, 5, 5, 6);
INSERT INTO ART_ARTEFACT (ART_NOM, ART_DESCRIPTION, ART_PRJ_ID, ART_COL_ID, ART_TAC_ID_ENTREE, ART_TAC_ID_SORTIE, ART_PRD_ID)
VALUES ('ARTEFACT7',  'DESCRIPTION7', 1, 1, 6, 5, 7);
INSERT INTO ART_ARTEFACT (ART_NOM, ART_DESCRIPTION, ART_PRJ_ID, ART_COL_ID, ART_TAC_ID_ENTREE, ART_TAC_ID_SORTIE, ART_PRD_ID)
VALUES ('ARTEFACT8',  'DESCRIPTION8', 1, 1, 2, 6, 8);
INSERT INTO ART_ARTEFACT (ART_NOM, ART_DESCRIPTION, ART_PRJ_ID, ART_COL_ID, ART_TAC_ID_ENTREE, ART_TAC_ID_SORTIE, ART_PRD_ID)
VALUES ('ARTEFACT9',  'DESCRIPTION9', 1, 1, 2, 1, 9);
INSERT INTO ART_ARTEFACT (ART_NOM, ART_DESCRIPTION, ART_PRJ_ID, ART_COL_ID, ART_TAC_ID_ENTREE, ART_TAC_ID_SORTIE, ART_PRD_ID)
VALUES ('ARTEFACT10', 'DESCRIPTION10', 1, 1, 4, 3, 10);
INSERT INTO ART_ARTEFACT (ART_NOM, ART_DESCRIPTION, ART_PRJ_ID, ART_COL_ID, ART_TAC_ID_ENTREE, ART_TAC_ID_SORTIE, ART_PRD_ID)
VALUES ('ARTEFACT11', 'DESCRIPTION11', 1, 1, 6, 5, 11);
INSERT INTO ART_ARTEFACT (ART_NOM, ART_DESCRIPTION, ART_PRJ_ID, ART_COL_ID, ART_TAC_ID_ENTREE, ART_TAC_ID_SORTIE, ART_PRD_ID)
VALUES ('ARTEFACT12', 'DESCRIPTION12', 1, 1, 6, 6, 12);


INSERT INTO CND_CONDITION (CND_TAC_ID, CND_TAC_ID_PREC, CND_ETAT)
VALUES (1, 5, 1) ;
INSERT INTO CND_CONDITION (CND_TAC_ID, CND_TAC_ID_PREC, CND_ETAT)
VALUES (7, 6, 3) ;


INSERT INTO R04_COL_ROL (R04_COL_ID, R04_ROL_ID)
VALUES (1, 1) ;
INSERT INTO R04_COL_ROL (R04_COL_ID, R04_ROL_ID)
VALUES (2, 2) ;
INSERT INTO R04_COL_ROL (R04_COL_ID, R04_ROL_ID)
VALUES (3, 3) ;
INSERT INTO R04_COL_ROL (R04_COL_ID, R04_ROL_ID)
VALUES (4, 4) ;
INSERT INTO R04_COL_ROL (R04_COL_ID, R04_ROL_ID)
VALUES (5, 1) ;
INSERT INTO R04_COL_ROL (R04_COL_ID, R04_ROL_ID)
VALUES (6, 2) ;
INSERT INTO R04_COL_ROL (R04_COL_ID, R04_ROL_ID)
VALUES (1, 3) ;
INSERT INTO R04_COL_ROL (R04_COL_ID, R04_ROL_ID)
VALUES (1, 4) ;
INSERT INTO R04_COL_ROL (R04_COL_ID, R04_ROL_ID)
VALUES (2, 1) ;
INSERT INTO R04_COL_ROL (R04_COL_ID, R04_ROL_ID)
VALUES (3, 2) ;


INSERT INTO R05_COL_PRJ (R05_COL_ID, R05_PRJ_ID)
VALUES (1, 1) ;
INSERT INTO R05_COL_PRJ (R05_COL_ID, R05_PRJ_ID)
VALUES (2, 1) ;
INSERT INTO R05_COL_PRJ (R05_COL_ID, R05_PRJ_ID)
VALUES (3, 1) ;
INSERT INTO R05_COL_PRJ (R05_COL_ID, R05_PRJ_ID)
VALUES (4, 1) ;
INSERT INTO R05_COL_PRJ (R05_COL_ID, R05_PRJ_ID)
VALUES (5, 1) ;
INSERT INTO R05_COL_PRJ (R05_COL_ID, R05_PRJ_ID)
VALUES (6, 1) ;






/******************************************
 * Insertion tables de gestion de projet. *
 ******************************************/
INSERT INTO PRB_PROBLEME (PRB_ID, PRB_NOM, PRB_DESCRIPTION, PRB_ETAT, PRB_DATEIDENTIFICATION, PRB_DATECLOTURE)
VALUES (1, 'PROBLEME1', 'DESCRIPTION1', 'Non entame', '2005-05-05', NULL) ;
INSERT INTO PRB_PROBLEME (PRB_ID, PRB_NOM, PRB_DESCRIPTION, PRB_ETAT, PRB_DATEIDENTIFICATION, PRB_DATECLOTURE)
VALUES (2, 'PROBLEME2', 'DESCRIPTION2', 'Resolu', '2005-05-05', '2005-05-05') ;
INSERT INTO PRB_PROBLEME (PRB_ID, PRB_NOM, PRB_DESCRIPTION, PRB_ETAT, PRB_DATEIDENTIFICATION, PRB_DATECLOTURE)
VALUES (3, 'PROBLEME3', 'DESCRIPTION3', '', '2005-05-05', '2005-05-08') ;

INSERT INTO R07_PRB_TAC_RESOUT (R07_PRB_ID, R07_TAC_ID)
VALUES (1, 6) ;
INSERT INTO R07_PRB_TAC_RESOUT (R07_PRB_ID, R07_TAC_ID)
VALUES (2, 6) ;
INSERT INTO R07_PRB_TAC_RESOUT (R07_PRB_ID, R07_TAC_ID)
VALUES (2, 7) ;

INSERT INTO R08_PRB_TAC_PROVOQUE (R08_PRB_ID, R08_TAC_ID)
VALUES (1, 5) ;
INSERT INTO R08_PRB_TAC_PROVOQUE (R08_PRB_ID, R08_TAC_ID)
VALUES (2, 5) ;
INSERT INTO R08_PRB_TAC_PROVOQUE (R08_PRB_ID, R08_TAC_ID)
VALUES (2, 3) ;
INSERT INTO R08_PRB_TAC_PROVOQUE (R08_PRB_ID, R08_TAC_ID)
VALUES (3, 1) ;






/*************************************
 * Insertion table de configuration. *
 *************************************/
INSERT INTO CON_CONFIGURATION (CON_ID, CON_LANGUE, CON_PAYS, CON_APPARENCE, CON_PATH_ARTEFACT, CON_PATH_SAUVEGARDE)
VALUES (1, 'fr', 'FR', 'bidon', '/Artefacts/', '/owep/Sauvegarde/') ;
