package owep.modele.execution ;


import java.util.ArrayList ;
import java.util.Date ;
import owep.modele.MModeleBase ;
import owep.modele.processus.MActivite ;


/**
 * Une t�che repr�sente le travail d'une personne sur un ou plusieurs artefact. La t�che contient
 * les estimations et mesures de charges et de dates.
 */
public class MTache extends MModeleBase
{
  /**
   * Indique que la t�che a �t� cr��e par le chef de projet mais ne peut �tre d�marr�e si certaines
   * conditions ou d�pendances ne sont pas remplies.
   */
  public static final int ETAT_CREEE    = 0 ;
  /**
   * Indique que la t�che peut �tre d�marr�e par le collaborateur concern�.
   */
  public static final int ETAT_PRETE    = 1 ;
  /**
   * Indique que la t�che est en cours de r�alisation.
   */
  public static final int ETAT_EN_COURS = 2 ;
  /**
   * Indique que la t�che est termin�e.
   */
  public static final int ETAT_TERMINE  = 3 ;


  private int            mId ;               // Identifie la t�che de mani�re unique.
  private String         mNom ;              // Nom de la t�che.
  private String         mDescription ;      // Description de la t�che.
  private int            mEtat ;             // Etat de la t�che.
  private double         mChargeInitiale ;   // Charge pr�vue par le chef de projet.
  private double         mTempsPasse ;       // Temps pass� sur la t�che.
  private double         mResteAPasser ;     // Temps restant � passer sur la t�che.
  private Date           mDateDebutPrevue ;  // Date de d�but pr�vue par le chef de projet.
  private Date           mDateFinPrevue ;    // Date de fin pr�vue par le chef de projet.
  private Date           mDateDebutReelle ;  // Date de d�but r�elle de la t�che.
  private Date           mDateFinReelle ;    // Date de fin r�elle de la t�che.
  private ArrayList      mArtefactsEntrees ; // Liste des artefacts n�cessaires � la t�che.
  private ArrayList      mArtefactsSorties ; // Liste des artefacts � produire durant la t�che.
  private MActivite      mActivite ;         // Activit� que la t�che instancie. 
  private MCollaborateur mCollaborateur ;    // Collaborateur r�alisant la t�che.
  private MIteration     mIteration ;        // It�ration durant laquelle est effectu�e la t�che.


  /**
   * Cr�e une instance vide de MTache.
   */
  public MTache ()
  {
    super () ;
    
    mEtat = ETAT_CREEE ;
    
    mArtefactsEntrees = new ArrayList () ;
    mArtefactsSorties = new ArrayList () ;
  }


  /**
   * Cr�e une instance de MArtefact initialis�e avec les donn�es du chef de projet.
   * @param pId Identifiant unique de l'artefact.
   * @param pNom Nom de la t�che.
   * @param pDescription Description de la t�che.
   * @param pChargeInitiale Charge pr�vue par le chef de projet.
   * @param pDateDebutPrevue Date de d�but pr�vue par le chef de projet.
   * @param pDateFinPrevue Date de fin pr�vue par le chef de projet.
   */
  public MTache (int pId, String pNom, String pDescription, double pChargeInitiale,
                 Date pDateDebutPrevue, Date pDateFinPrevue)
  {
    super () ;
    
    mId              = pId ;
    mNom             = pNom ;
    mDescription     = pDescription ;
    mEtat            = ETAT_CREEE ;
    mChargeInitiale  = pChargeInitiale ;
    mDateDebutPrevue = pDateDebutPrevue ;
    mDateFinPrevue   = pDateFinPrevue ;
    
    mArtefactsEntrees = new ArrayList () ;
    mArtefactsSorties = new ArrayList () ;
  }


  /**
   * Cr�e une instance de MArtefact initialis�e avec les donn�es du chef de projet.
   * @param pId Identifiant unique de l'artefact.
   * @param pNom Nom de la t�che.
   * @param pDescription Description de la t�che.
   * @param pChargeInitiale Charge pr�vue par le chef de projet.
   * @param pTempsPasse Temps pass� sur la t�che.
   * @param pResteAPasser Temps restant � passer sur la t�che.
   * @param pDateDebutPrevue Date de d�but pr�vue par le chef de projet.
   * @param pDateDebutReelle Date de d�but r�elle de la t�che.
   * @param pDateFinPrevue Date de fin pr�vue par le chef de projet.
   * @param pDateFinReelle Date de fin r�elle de la t�che.
   */
  public MTache (int pId, String pNom, String pDescription, double pChargeInitiale,
                 double pTempsPasse, double pResteAPasser, Date pDateDebutPrevue,
                 Date pDateFinPrevue, Date pDateDebutReelle, Date pDateFinReelle)
  {
    super () ;
    
    mId              = pId ;
    mNom             = pNom ;
    mDescription     = pDescription ;
    mEtat            = ETAT_CREEE ;
    mChargeInitiale  = pChargeInitiale ;
    mTempsPasse      = pTempsPasse ;
    mResteAPasser    = pResteAPasser ;
    mDateDebutPrevue = pDateDebutPrevue ;
    mDateDebutReelle = pDateDebutReelle ;
    mDateFinPrevue   = pDateFinPrevue ;
    mDateFinReelle   = pDateFinReelle ;
    
    mArtefactsEntrees = new ArrayList () ;
    mArtefactsSorties = new ArrayList () ;
  }


  /**
   * R�cup�re l'activit� que la t�che instancie.
   * @return Activit� que la t�che instancie.
   */
  public MActivite getActivite ()
  {
    return mActivite ;
  }


  /**
   * Associe l'activit� que la t�che instancie.
   * @param pActivite Activit� que la t�che instancie.
   */
  public void setActivite (MActivite pActivite)
  {
    mActivite = pActivite ;
  }


  /**
   * R�cup�re la liste des artefacts en entr�es de la t�che.
   * @return Liste des artefacts n�cessaires � la t�che.
   */
  public ArrayList getListeArtefactsEntrees ()
  {
    return mArtefactsEntrees ;
  }


  /**
   * Initialise la liste des artefacts en entr�es de la t�che.
   * @param pArtefactsEntrees Liste des artefacts n�cessaires � la t�che.
   */
  public void setListeArtefactsEntrees (ArrayList pArtefactsEntrees)
  {
    mArtefactsEntrees = pArtefactsEntrees ;
  }


  /**
   * R�cup�re le nombre d'artefacts en entr�es.
   * @return Nombre d'artefacts en entr�es.
   */
  public int getNbArtefactsEntrees ()
  {
    return mArtefactsEntrees.size () ;
  }


  /**
   * R�cup�re l'artefact d'indice sp�cifi� n�cessaire � la t�che.
   * @param pIndice Indice de l'artefact en entr�e dans la liste.
   * @return Artefact n�cessaire � la t�che.
   */
  public MArtefact getArtefact (int pIndice)
  {
    return (MArtefact) mArtefactsEntrees.get (pIndice) ;
  }


  /**
   * Ajoute l'artefact sp�cifi� en entr�e de la t�che.
   * @param pArtefact Artefact n�cessaire � la t�che.
   */
  public void addArtefact (MTache pArtefact)
  {
    mArtefactsEntrees.add (pArtefact) ;
  }


  /**
   * R�cup�re la liste des artefacts en sorties de la t�che.
   * @return Liste des artefacts � produire durant la t�che.
   */
  public ArrayList getListeArtefactsSorties ()
  {
    return mArtefactsSorties ;
  }


  /**
   * Initialise la liste des artefacts en sorties de la t�che.
   * @param pArtefactsSorties Liste des artefacts � produire durant la t�che.
   */
  public void setListeArtefactsSorties (ArrayList pArtefactsSorties)
  {
    mArtefactsSorties = pArtefactsSorties ;
  }


  /**
   * R�cup�re le nombre d'artefacts en sorties.
   * @return Nombre d'artefacts en sorties.
   */
  public int getNbArtefactsSorties ()
  {
    return mArtefactsSorties.size () ;
  }


  /**
   * R�cup�re l'artefact d'indice sp�cifi� � produire durant la t�che.
   * @param pIndice Indice de l'artefact en sortie dans la liste.
   * @return Artefact � produire durant la t�che.
   */
  public MArtefact getArtefactSortie (int pIndice)
  {
    return (MArtefact) mArtefactsSorties.get (pIndice) ;
  }


  /**
   * Ajoute l'artefact sp�cifi� en sortie de la t�che.
   * @param pArtefact Artefact � produire durant la t�che.
   */
  public void addArtefactSortie (MTache pArtefact)
  {
    mArtefactsSorties.add (pArtefact) ;
  }


  /**
   * R�cup�re la charge pr�vue par le chef de projet.
   * @return Charge pr�vue par le chef de projet.
   */
  public double getChargeInitiale ()
  {
    return mChargeInitiale ;
  }


  /**
   * Initialise la charge pr�vue par le chef de projet.
   * @param pChargeInitiale Charge pr�vue par le chef de projet.
   */
  public void setChargeInitiale (double pChargeInitiale)
  {
    assert pChargeInitiale > 0.0 ;
    mChargeInitiale = pChargeInitiale ;
  }


  /**
   * R�cup�re le collaborateur r�alisant la t�che.
   * @return Collaborateur r�alisant la t�che.
   */
  public MCollaborateur getCollaborateur ()
  {
    return mCollaborateur ;
  }


  /**
   * Associe le collaborateur r�alisant la t�che.
   * @param pCollaborateur Collaborateur r�alisant la t�che.
   */
  public void setCollaborateur (MCollaborateur pCollaborateur)
  {
    mCollaborateur = pCollaborateur ;
  }


  /**
   * R�cup�re la date de d�but pr�vue par le chef de projet.
   * @return Date de d�but pr�vue par le chef de projet.
   */
  public Date getDateDebutPrevue ()
  {
    return mDateDebutPrevue ;
  }


  /**
   * R�cup�re la date de d�but pr�vue par le chef de projet.
   * @param pDateDebutPrevue The mDateDebutPrevue to set.
   */
  public void setDateDebutPrevue (Date pDateDebutPrevue)
  {
    assert mDateFinPrevue != null ? pDateDebutPrevue.before (mDateFinPrevue) : true ;
    mDateDebutPrevue = pDateDebutPrevue ;
  }


  /**
   * R�cup�re la date de d�but r�elle de la t�che.
   * @return Date de d�but r�elle de la t�che.
   */
  public Date getDateDebutReelle ()
  {
    return mDateDebutReelle ;
  }


  /**
   * Initialise la date de d�but r�elle de la t�che.
   * @param pDateDebutReelle Date de d�but r�elle de la t�che.
   */
  public void setDateDebutReelle (Date pDateDebutReelle)
  {
    assert mDateFinReelle != null ? pDateDebutReelle.before (mDateFinReelle) : true ;
    mDateDebutReelle = pDateDebutReelle ;
  }


  /**
   * R�cup�re la date de fin pr�vue par le chef de projet.
   * @return Date de fin pr�vue par le chef de projet.
   */
  public Date getDateFinPrevue ()
  {
    return mDateFinPrevue ;
  }


  /**
   * Initialise la date de fin pr�vue par le chef de projet.
   * @param pDateFinPrevue Date de fin pr�vue par le chef de projet.
   */
  public void setDateFinPrevue (Date pDateFinPrevue)
  {
    assert mDateDebutPrevue != null ? pDateFinPrevue.after (mDateDebutPrevue) : true ;
    mDateFinPrevue = pDateFinPrevue ;
  }


  /**
   * R�cup�re la daate de fin r�elle de la t�che.
   * @return Date de fin r�elle de la t�che.
   */
  public Date getDateFinReelle ()
  {
    return mDateFinReelle ;
  }


  /**
   * R�cup�re la date de fin pr�vue par le chef de projet.
   * @param pDateFinReelle Date de fin r�elle de la t�che.
   */
  public void setDateFinReelle (Date pDateFinReelle)
  {
    assert mDateDebutReelle != null ? pDateFinReelle.after (mDateDebutReelle) : true ;
    mDateFinReelle = pDateFinReelle ;
  }


  /**
   * R�cup�re la description de la t�che.
   * @return Description de la t�che.
   */
  public String getDescription ()
  {
    return mDescription ;
  }


  /**
   * Initialise la description de la t�che.
   * @param pDescription Description de la t�che.
   */
  public void setDescription (String pDescription)
  {
    mDescription = pDescription ;
  }


  /**
   * R�cup�re l'�tat de r�alisation de la t�che.
   * @return Etat de r�alisation de la t�che.
   */
  public int getEtat ()
  {
    return mEtat ;
  }


  /**
   * Initialise l'�tat de r�alisation de la t�che.
   * @param pEtat Etat de r�alisation de la t�che.
   */
  public void setEtat (int pEtat)
  {
    mEtat = pEtat ;
    if (mEtat == ETAT_TERMINE)
    {
      mResteAPasser = 0 ;
    }
  }


  /**
   * R�cup�re l'identifiant de la t�che.
   * @return Identifiant unique de la t�che
   */
  public int getId ()
  {
    return mId ;
  }


  /**
   * Initialise l'identifiant de la t�che.
   * @param pId Identifiant unique de la t�che
   */
  public void setId (int pId)
  {
    mId = pId ;
  }


  /**
   * R�cup�re l'it�ration durant laquelle est effectu�e la t�che.
   * @return It�ration durant laquelle est effectu�e la t�che.
   */
  public MIteration getIteration ()
  {
    return mIteration ;
  }


  /**
   * Initialise l'it�ration durant laquelle est effectu�e la t�che.
   * @param pIteration It�ration durant laquelle est effectu�e la t�che.
   */
  public void setIteration (MIteration pIteration)
  {
    mIteration = pIteration ;
  }


  /**
   * R�cup�re le nom de la t�che.
   * @return Nom de la t�che
   */
  public String getNom ()
  {
    return mNom ;
  }


  /**
   * Initialise le nom de la t�che.
   * @param pNom Nom de la t�che
   */
  public void setNom (String pNom)
  {
    mNom = pNom ;
  }


  /**
   * R�cup�re le temps restant � passer sur la t�che.
   * @return Temps restant � passer sur la t�che
   */
  public double getResteAPasser ()
  {
    return mResteAPasser ;
  }


  /**
   * Initialise le temps restant � passer sur la t�che.
   * @param pResteAPasser Temps restant � passer sur la t�che
   */
  public void setResteAPasser (double pResteAPasser)
  {
    mResteAPasser = pResteAPasser ;
  }


  /**
   * R�cup�re le temps pass� sur la t�che.
   * @return Temps pass� sur la t�che
   */
  public double getTempsPasse ()
  {
    return mTempsPasse ;
  }


  /**
   * Initialise le temps pass� sur la t�che.
   * @param pTempsPasse Temps pass� sur la t�che
   */
  public void setTempsPasse (double pTempsPasse)
  {
    assert pTempsPasse > 0 ;
    mTempsPasse = pTempsPasse ;
  }


  /**
   * Calcule le budget consomm� pour la t�che. Formule : tempsPasse / chargeInitiale).
   * @return Budget consomm� pour la t�che.
   */
  public double getBudgetConsomme ()
  {
    return mTempsPasse / mChargeInitiale ;
  }


  /**
   * Calcule le nombre d'hommes x jours de d�passement de charges. Formule : tempsPasse +
   * resteAPasser - chargeInitiale.
   * @return Nombre d'hommes x jours de d�passement de charges.
   */
  public double getHJDepassementCharge ()
  {
    return mTempsPasse + mResteAPasser - mChargeInitiale ;
  }


  /**
   * Calcule le pourcentage de d�passement de charges. Formule : (tempsPasse + resteAPasser -
   * chargeInitiale) / chargeInitiale.
   * @return Pourcentage de d�passement de charges.
   */
  public double getPrcDepassementCharge ()
  {
    return (mTempsPasse + mResteAPasser - mChargeInitiale) / mChargeInitiale ;
  }


  /**
   * Calcule le pourcentage de d�passement de charges. Formule : tempsPasse / (tempsPasse +
   * resteAPasser).
   * @return Pourcentage de d�passement de charges.
   */
  public double getPrcAvancement ()
  {
    return mTempsPasse / (mTempsPasse + mResteAPasser) ;
  }
}