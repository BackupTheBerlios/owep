package owep.modele.execution ;


import java.util.ArrayList ;
import java.util.Date ;


/**
 * Une itération est une étape d'un projet. Elle se caractérise par un ensemble de tâches et de
 * participant qui utilisent et réalisent des artefacts.
 */
public class MIteration
{
  private int       mId ;              // Identifie l'itération de manière unique.
  private int       mNumero ;          // Numéro de l'itération.
  private Date      mDateDebutPrevue ; // Date de début prévue pour l'itération.
  private Date      mDateFinPrevue ;   // Date de fin prévue pour l'itération.
  private Date      mDateDebutReelle ; // Date de début réelle de l'itération.
  private Date      mDateFinReelle ;   // Date de fin réelle de l'itération.
  private MProjet   mProjet ;          // Projet dont l'itération est une étape.
  private ArrayList mTaches ;          // Liste des tâches réalisées durant l'itération.


  /**
   * Crée une instance vide de MIteration.
   */
  public MIteration ()
  {
    super () ;
    
    mTaches = new ArrayList () ;
  }


  /**
   * Crée une instance initialisée de MIteration.
   * @param pNumero Numéro de l'itération.
   * @param pDateDebutPrevue Date de début prévue de l'itération.
   * @param pDateFinPrevue Date de fin prévue de l'itération.
   */
  public MIteration (int pNumero, Date pDateDebutPrevue, Date pDateFinPrevue)
  {
    super () ;
    
    mNumero          = pNumero ;
    mDateDebutPrevue = pDateDebutPrevue ;
    mDateFinPrevue   = pDateFinPrevue ;
    
    mTaches = new ArrayList () ;
  }


  /**
   * Crée une instance de MIteration
   * @param pNumero Numéro de l'itération.
   * @param pDateDebutPrevue Date de début prévue de l'itération.
   * @param pDateFinPrevue Date de fin prévue de l'itération.
   * @param pDateDebutReelle Date de début réelle de l'itération.
   * @param pDateFinReelle Date de fin réelle de l'itération.
   */
  public MIteration (int pNumero, Date pDateDebutPrevue, Date pDateFinPrevue,
                     Date pDateDebutReelle, Date pDateFinReelle)
  {
    super () ;
    
    mNumero          = pNumero ;
    mDateDebutPrevue = pDateDebutPrevue ;
    mDateFinPrevue   = pDateFinPrevue ;
    mDateDebutReelle = pDateDebutReelle ;
    mDateFinReelle   = pDateFinReelle ;
    
    mTaches = new ArrayList () ;
  }


  /**
   * Récupère la date de début prévue pour l'itération.
   * @return Date de début prévue pour l'itération.
   */
  public Date getDateDebutPrevue ()
  {
    return mDateDebutPrevue ;
  }


  /**
   * Initialise la date de début prévue pour l'itération.
   * @param pDateDebutPrevue Date de début prévue pour l'itération.
   */
  public void setDateDebutPrevue (Date pDateDebutPrevue)
  {
    mDateDebutPrevue = pDateDebutPrevue ;
  }


  /**
   * Récupère la date de début réelle de l'itération.
   * @return Date de début réelle de l'itération.
   */
  public Date getDateDebutReelle ()
  {
    return mDateDebutReelle ;
  }


  /**
   * Initialise la date de début réelle de l'itération.
   * @param pDateDebutReelle Date de début réelle de l'itération.
   */
  public void setDateDebutReelle (Date pDateDebutReelle)
  {
    mDateDebutReelle = pDateDebutReelle ;
  }


  /**
   * Récupère la date de fin prévue pour l'itération.
   * @return Date de début fin pour l'itération.
   */
  public Date getDateFinPrevue ()
  {
    return mDateFinPrevue ;
  }


  /**
   * Initialise la date de fin prévue pour l'itération.
   * @param pDateFinPrevue Date de fin prévue pour l'itération.
   */
  public void setDateFinPrevue (Date pDateFinPrevue)
  {
    mDateFinPrevue = pDateFinPrevue ;
  }


  /**
   * Récupère la date de fin réelle de l'itération.
   * @return Date de début fin de l'itération.
   */
  public Date getDateFinReelle ()
  {
    return mDateFinReelle ;
  }


  /**
   * Initialise la date de fin réelle de l'itération.
   * @param pDateFinReelle Date de fin réelle de l'itération.
   */
  public void setDateFinReelle (Date pDateFinReelle)
  {
    mDateFinReelle = pDateFinReelle ;
  }


  /**
   * Récupère l'identifiant de l'itération.
   * @return Identifiant unique de l'itération.
   */
  public int getId ()
  {
    return mId ;
  }


  /**
   * Initialise l'identifiant de l'itération.
   * @param pId Identifiant unique de l'itération.
   */
  public void setId (int pId)
  {
    mId = pId ;
  }


  /**
   * Récupère le numéro de l'itération.
   * @return Numéro de l'itération.
   */
  public int getNumero ()
  {
    return mNumero ;
  }


  /**
   * Initialise le numéro de l'itération.
   * @param pNumero Numéro de l'itération.
   */
  public void setNumero (int pNumero)
  {
    mNumero = pNumero ;
  }


  /**
   * Récupère le projet dont l'itération est une étape.
   * @return Projet dont l'itération est une étape.
   */
  public MProjet getProjet ()
  {
    return mProjet ;
  }


  /**
   * Associe le projet dont l'itération est une étape.
   * @param pProjet Projet dont l'itération est une étape.
   */
  public void setProjet (MProjet pProjet)
  {
    mProjet = pProjet ;
  }


  /**
   * Récupère la liste des tâches réalisées durant l'itération.
   * @return Liste des tâches réalisées durant l'itération.
   */
  public ArrayList getListeTaches ()
  {
    return mTaches ;
  }


  /**
   * Initialise la liste des tâches réalisées durant l'itération.
   * @param pTaches Liste des tâches réalisées durant l'itération.
   */
  public void setListeTaches (ArrayList pTaches)
  {
    mTaches = pTaches ;
  }


  /**
   * Récupère le nombre de tâches réalisées durant l'itération.
   * @return Nombre de tâches réalisées durant l'itération.
   */
  public int getNbTaches ()
  {
    return mTaches.size () ;
  }


  /**
   * Récupère la tâche d'indice spécifié réalisée durant l'itération.
   * @param pIndice Indice de la tâche dans la liste.
   * @return Tâche réalisée durant l'itération.
   */
  public MTache getTache (int pIndice)
  {
    return (MTache) mTaches.get (pIndice) ;
  }


  /**
   * Ajoute la tâche spécifiée à l'itération.
   * @param pTache Tâche réalisée durant l'itération.
   */
  public void addTache (MTache pTache)
  {
    mTaches.add (pTache) ;
  }
}