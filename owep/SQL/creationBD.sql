CREATE TABLE ACI_ACTIVITE_IMPREVUE (
  ACI_ID INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  ACI_NOM VARCHAR(45) NULL,
  ACI_DESCRIPTION BLOB NULL,
  PRIMARY KEY(ACI_ID)
);

CREATE TABLE ACN_ACTION (
  ACN_ID INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  COL_COLLABORATEUR_COL_ID INTEGER UNSIGNED NOT NULL,
  ACN_NOM VARCHAR(45) NULL,
  ACN_DESCRIPTION BLOB NULL,
  ACN_DATE_DEBUT DATE NULL,
  ACN_DATE_FIN DATE NULL,
  ACN_ETAT VARCHAR(10) NULL,
  PRIMARY KEY(ACN_ID),
  INDEX FK_ACN_COL(COL_COLLABORATEUR_COL_ID)
);

CREATE TABLE ACP_ACTION_PROBLEME (
  ACP_ID INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  PRB_PROBLEME_PRB_ID INTEGER UNSIGNED NOT NULL,
  ACN_ACTION_ACN_ID INTEGER UNSIGNED NOT NULL,
  PRIMARY KEY(ACP_ID),
  INDEX FK_ACP_ACN(ACN_ACTION_ACN_ID),
  INDEX FK_ACP_PRB(PRB_PROBLEME_PRB_ID)
);

CREATE TABLE ACR_ACTION_RISQUE (
  ACR_ID INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  VER_VERSION_RISQUE_VER_ID INTEGER UNSIGNED NOT NULL,
  TAC_TACHE_TAC_ID INTEGER UNSIGNED NOT NULL,
  ACN_ACTION_ACN_ID INTEGER UNSIGNED NOT NULL,
  PRIMARY KEY(ACR_ID),
  INDEX FK_ACR_ACN(ACN_ACTION_ACN_ID),
  INDEX FK_ACR_TAC(TAC_TACHE_TAC_ID),
  INDEX FK_ACR_VER(VER_VERSION_RISQUE_VER_ID)
);

CREATE TABLE ACT_ACTIVITE (
  ACT_ID INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  DFT_DEFINITION_TRAVAIL_DFT_ID INTEGER UNSIGNED NOT NULL,
  ACT_NOM VARCHAR(45) NULL,
  ACT_DESCRIPTION BLOB NULL,
  PRIMARY KEY(ACT_ID),
  INDEX FK_ACT_DFT(DFT_DEFINITION_TRAVAIL_DFT_ID)
);

CREATE TABLE ART_ARTEFACT (
  ART_ID INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  COL_COLLABORATEUR_COL_ID INTEGER UNSIGNED NULL,
  TAC_TACHE_TAC_ID INTEGER UNSIGNED NULL,
  PRD_PRODUIT_PRD_ID INTEGER UNSIGNED NULL,
  ART_NOM VARCHAR(45) NULL,
  ART_DESCRIPTION BLOB NULL,
  PRIMARY KEY(ART_ID),
  INDEX FK_ART_PRD(PRD_PRODUIT_PRD_ID),
  INDEX FK_ART_TAC(TAC_TACHE_TAC_ID),
  INDEX FK_ART_COL(COL_COLLABORATEUR_COL_ID)
);

CREATE TABLE COL_COLLABORATEUR (
  COL_ID INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  COL_NOM VARCHAR(20) NULL,
  COL_PRENOM VARCHAR(20) NULL,
  COL_ADRESSE VARCHAR(255) NULL,
  COL_TELEPHONE VARCHAR(20) NULL,
  COL_PORTABLE VARCHAR(20) NULL,
  COL_EMAIL VARCHAR(45) NULL,
  COL_COMMENTAIRES BLOB NULL,
  PRIMARY KEY(COL_ID)
);

CREATE TABLE DFT_DEFINITION_TRAVAIL (
  DFT_ID INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  PRC_PROCESSUS_PRC_ID INTEGER UNSIGNED NOT NULL,
  DFT_NOM VARCHAR(45) NULL,
  DFT_DESCRIPTION BLOB NULL,
  PRIMARY KEY(DFT_ID),
  INDEX DFT_DEFINITION_TRAVAIL_FKIndex1(PRC_PROCESSUS_PRC_ID)
);

CREATE TABLE ITE_ITERATION (
  ITE_ID INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  DFT_DEFINITION_TRAVAIL_DFT_ID INTEGER UNSIGNED NOT NULL,
  PRJ_PROJET_PRJ_ID INTEGER UNSIGNED NOT NULL,
  ITE_NUMERO INTEGER UNSIGNED NULL,
  ITE_DATE_DEBUT_PREVUE DATE NULL,
  ITE_DATE_FIN_PREVUE DATE NULL,
  ITE_DATE_DEBUT_REELLE DATE NULL,
  ITE_DATE_FIN_REELLE DATE NULL,
  PRIMARY KEY(ITE_ID),
  INDEX FK_ITE_PRJ(PRJ_PROJET_PRJ_ID),
  INDEX FK_ITE_DFT(DFT_DEFINITION_TRAVAIL_DFT_ID)
);

CREATE TABLE PRB_PROBLEME (
  PRB_ID INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  PRJ_PROJET_PRJ_ID INTEGER UNSIGNED NOT NULL,
  PRB_NOM VARCHAR(45) NULL,
  PRB_DESCRIPTION BLOB NULL,
  PRB_DATE_IDENTIFICATION DATE NULL,
  PRB_DATE_CLOTURE DATE NULL,
  PRB_ETAT VARCHAR(10) NULL,
  PRIMARY KEY(PRB_ID),
  INDEX FK_PRB_PRJ(PRJ_PROJET_PRJ_ID)
);

CREATE TABLE PRC_PROCESSUS (
  PRC_ID INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  PRC_NOM VARCHAR(45) NULL,
  PRC_DESCRIPTION BLOB NULL,
  PRIMARY KEY(PRC_ID)
);

CREATE TABLE PRD_PRODUIT (
  PRD_ID INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  ROL_ROLE_ROL_ID INTEGER UNSIGNED NOT NULL,
  PRC_PROCESSUS_PRC_ID INTEGER UNSIGNED NOT NULL,
  PRD_NOM VARCHAR(45) NULL,
  PRD_DESCRIPTION BLOB NULL,
  PRIMARY KEY(PRD_ID),
  INDEX FK_PRD_PRC(PRC_PROCESSUS_PRC_ID),
  INDEX FK_PRD_ROL(ROL_ROLE_ROL_ID)
);

CREATE TABLE PRJ_PROJET (
  PRJ_ID INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  PRC_PROCESSUS_PRC_ID INTEGER UNSIGNED NOT NULL,
  PRJ_NOM VARCHAR(45) NULL,
  PRJ_DESCRIPTION BLOB NULL,
  PRJ_DATE_DEBUT_PRVUE DATE NULL,
  PRJ_DATE_FIN_PREVUE DATE NULL,
  PRJ_DATE_DEBUT_REELLE DATE NULL,
  PRJ_DATE_FIN_REELLE_2 INTEGER UNSIGNED NULL,
  PRJ_BUDJET INTEGER UNSIGNED NULL,
  PRIMARY KEY(PRJ_ID),
  INDEX FK_PRJ_PRC(PRC_PROCESSUS_PRC_ID)
);

CREATE TABLE R01_ACT_PRD_ENTREE (
  PRD_PRODUIT_PRD_ID INTEGER UNSIGNED NOT NULL,
  ACT_ACTIVITE_ACT_ID INTEGER UNSIGNED NOT NULL,
  PRIMARY KEY(PRD_PRODUIT_PRD_ID, ACT_ACTIVITE_ACT_ID),
  INDEX FK_R01_PRD(ACT_ACTIVITE_ACT_ID),
  INDEX FK_R01_ACT(PRD_PRODUIT_PRD_ID)
);

CREATE TABLE R02_ACT_PRD_SORTIE (
  ACT_ACTIVITE_ACT_ID INTEGER UNSIGNED NOT NULL,
  PRD_PRODUIT_PRD_ID INTEGER UNSIGNED NOT NULL,
  PRIMARY KEY(ACT_ACTIVITE_ACT_ID, PRD_PRODUIT_PRD_ID),
  INDEX FK_R02_ACT(PRD_PRODUIT_PRD_ID),
  INDEX FK_R02_PRD(ACT_ACTIVITE_ACT_ID)
);

CREATE TABLE R03_ACT_ROL (
  ACT_ACTIVITE_ACT_ID INTEGER UNSIGNED NOT NULL,
  ROL_ROLE_ROL_ID INTEGER UNSIGNED NOT NULL,
  PRIMARY KEY(ACT_ACTIVITE_ACT_ID, ROL_ROLE_ROL_ID),
  INDEX FK_R03_ROL(ROL_ROLE_ROL_ID),
  INDEX FK_R03_ACT(ACT_ACTIVITE_ACT_ID)
);

CREATE TABLE R04_ROL_COL (
  COL_COLLABORATEUR_COL_ID INTEGER UNSIGNED NOT NULL,
  ROL_ROLE_ROL_ID INTEGER UNSIGNED NOT NULL,
  PRIMARY KEY(COL_COLLABORATEUR_COL_ID, ROL_ROLE_ROL_ID),
  INDEX FK_R04_ROL(ROL_ROLE_ROL_ID),
  INDEX FK_R04_COL(COL_COLLABORATEUR_COL_ID)
);

CREATE TABLE R05_TAC_ART_ENTREE (
  TAC_TACHE_TAC_ID INTEGER UNSIGNED NOT NULL,
  ART_ARTEFACT_ART_ID INTEGER UNSIGNED NOT NULL,
  PRIMARY KEY(TAC_TACHE_TAC_ID, ART_ARTEFACT_ART_ID),
  INDEX FK_R05_ART(ART_ARTEFACT_ART_ID),
  INDEX FK_R05_TAC(TAC_TACHE_TAC_ID)
);

CREATE TABLE RAC_RAPPORT_ACTIVITE (
  RAC_ID INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  RAC_DATE_DEBUT DATE NULL,
  RAC_DATE_FIN DATE NULL,
  RAC_TEMPS_PASSE INTEGER UNSIGNED NULL,
  RAC_RESTE_A_PASSER INTEGER UNSIGNED NULL,
  PRIMARY KEY(RAC_ID)
);

CREATE TABLE RIS_RISQUE (
  RIS_ID INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  PRJ_PROJET_PRJ_ID INTEGER UNSIGNED NOT NULL,
  RIS_NOM VARCHAR(45) NULL,
  RIS_DATE_IDENTIFICATION DATE NULL,
  RIS_DATE_CLOTURE DATE NULL,
  PRIMARY KEY(RIS_ID),
  INDEX FK_RIS_PRJ(PRJ_PROJET_PRJ_ID)
);

CREATE TABLE ROL_ROLE (
  ROL_ID INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  PRC_PROCESSUS_PRC_ID INTEGER UNSIGNED NOT NULL,
  ROL_NOM VARCHAR(45) NULL,
  ROL_DSECRIPTION BLOB NULL,
  PRIMARY KEY(ROL_ID),
  INDEX FK_ROL_PRC(PRC_PROCESSUS_PRC_ID)
);

CREATE TABLE TAC_TACHE (
  TAC_ID INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  ITE_ITERATION_ITE_ID INTEGER UNSIGNED NULL,
  RAC_RAPPORT_ACTIVITE_RAC_ID INTEGER UNSIGNED NULL,
  COL_COLLABORATEUR_COL_ID INTEGER UNSIGNED NULL,
  ACI_ACTIVITE_IMPREVUE_ACI_ID INTEGER UNSIGNED NULL,
  ACT_ACTIVITE_ACT_ID INTEGER UNSIGNED NULL,
  TAC_NOM VARCHAR(45) NULL,
  TAC_DESCRIPTION TEXT NULL,
  TAC_CHARGE_INITIALE FLOAT NULL,
  TAC_TEMPS_PASSE FLOAT NULL,
  TAC_RESTE_A_PASSER FLOAT NULL,
  TAC_DATE_DEBUT_PREVUE DATE NULL,
  TAC_DATE_FIN_PREVUE DATE NULL,
  TAC_DATE_DEBUT_REELLE DATE NULL,
  TAC_DATE_FIN_REELLE DATE NULL,
  PRIMARY KEY(TAC_ID),
  INDEX FK_TAC_ACT(ACT_ACTIVITE_ACT_ID),
  INDEX FK_TAC_ACI(ACI_ACTIVITE_IMPREVUE_ACI_ID),
  INDEX FK_TAC_COL(COL_COLLABORATEUR_COL_ID),
  INDEX FK_TAC_RAC(RAC_RAPPORT_ACTIVITE_RAC_ID),
  INDEX FK_TAC_ITE(ITE_ITERATION_ITE_ID)
);

CREATE TABLE VER_VERSION_RISQUE (
  VER_ID INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  RIS_RISQUE_RIS_ID INTEGER UNSIGNED NOT NULL,
  VER_NUMERO INTEGER UNSIGNED NULL,
  VER_DESCRIPTION BLOB NULL,
  VER_INDICATEURS BLOB NULL,
  VER_DATE_DEBUT DATE NULL,
  VER_DATE_FIN DATE NULL,
  VER_PRIORITE INTEGER UNSIGNED NULL,
  PRIMARY KEY(VER_ID),
  INDEX FK_VER_RIS(RIS_RISQUE_RIS_ID)
);


