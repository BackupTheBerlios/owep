package owep.modele.execution ;


import java.util.ArrayList ;
import java.util.Date ;


/**
 * Une it�ration est une �tape d'un projet. Elle se caract�rise par un ensemble de t�ches et de
 * participant qui utilisent et r�alisent des artefacts.
 */
public class MIteration
{
  private int       mId ;              // Identifie l'it�ration de mani�re unique.
  private int       mNumero ;          // Num�ro de l'it�ration.
  private Date      mDateDebutPrevue ; // Date de d�but pr�vue pour l'it�ration.
  private Date      mDateFinPrevue ;   // Date de fin pr�vue pour l'it�ration.
  private Date      mDateDebutReelle ; // Date de d�but r�elle de l'it�ration.
  private Date      mDateFinReelle ;   // Date de fin r�elle de l'it�ration.
  private MProjet   mProjet ;          // Projet dont l'it�ration est une �tape.
  private ArrayList mTaches ;          // Liste des t�ches r�alis�es durant l'it�ration.


  /**
   * Cr�e une instance vide de MIteration.
   */
  public MIteration ()
  {
    super () ;
    
    mTaches = new ArrayList () ;
  }


  /**
   * Cr�e une instance initialis�e de MIteration.
   * @param pNumero Num�ro de l'it�ration.
   * @param pDateDebutPrevue Date de d�but pr�vue de l'it�ration.
   * @param pDateFinPrevue Date de fin pr�vue de l'it�ration.
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
   * Cr�e une instance de MIteration
   * @param pNumero Num�ro de l'it�ration.
   * @param pDateDebutPrevue Date de d�but pr�vue de l'it�ration.
   * @param pDateFinPrevue Date de fin pr�vue de l'it�ration.
   * @param pDateDebutReelle Date de d�but r�elle de l'it�ration.
   * @param pDateFinReelle Date de fin r�elle de l'it�ration.
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
   * R�cup�re la date de d�but pr�vue pour l'it�ration.
   * @return Date de d�but pr�vue pour l'it�ration.
   */
  public Date getDateDebutPrevue ()
  {
    return mDateDebutPrevue ;
  }


  /**
   * Initialise la date de d�but pr�vue pour l'it�ration.
   * @param pDateDebutPrevue Date de d�but pr�vue pour l'it�ration.
   */
  public void setDateDebutPrevue (Date pDateDebutPrevue)
  {
    mDateDebutPrevue = pDateDebutPrevue ;
  }


  /**
   * R�cup�re la date de d�but r�elle de l'it�ration.
   * @return Date de d�but r�elle de l'it�ration.
   */
  public Date getDateDebutReelle ()
  {
    return mDateDebutReelle ;
  }


  /**
   * Initialise la date de d�but r�elle de l'it�ration.
   * @param pDateDebutReelle Date de d�but r�elle de l'it�ration.
   */
  public void setDateDebutReelle (Date pDateDebutReelle)
  {
    mDateDebutReelle = pDateDebutReelle ;
  }


  /**
   * R�cup�re la date de fin pr�vue pour l'it�ration.
   * @return Date de d�but fin pour l'it�ration.
   */
  public Date getDateFinPrevue ()
  {
    return mDateFinPrevue ;
  }


  /**
   * Initialise la date de fin pr�vue pour l'it�ration.
   * @param pDateFinPrevue Date de fin pr�vue pour l'it�ration.
   */
  public void setDateFinPrevue (Date pDateFinPrevue)
  {
    mDateFinPrevue = pDateFinPrevue ;
  }


  /**
   * R�cup�re la date de fin r�elle de l'it�ration.
   * @return Date de d�but fin de l'it�ration.
   */
  public Date getDateFinReelle ()
  {
    return mDateFinReelle ;
  }


  /**
   * Initialise la date de fin r�elle de l'it�ration.
   * @param pDateFinReelle Date de fin r�elle de l'it�ration.
   */
  public void setDateFinReelle (Date pDateFinReelle)
  {
    mDateFinReelle = pDateFinReelle ;
  }


  /**
   * R�cup�re l'identifiant de l'it�ration.
   * @return Identifiant unique de l'it�ration.
   */
  public int getId ()
  {
    return mId ;
  }


  /**
   * Initialise l'identifiant de l'it�ration.
   * @param pId Identifiant unique de l'it�ration.
   */
  public void setId (int pId)
  {
    mId = pId ;
  }


  /**
   * R�cup�re le num�ro de l'it�ration.
   * @return Num�ro de l'it�ration.
   */
  public int getNumero ()
  {
    return mNumero ;
  }


  /**
   * Initialise le num�ro de l'it�ration.
   * @param pNumero Num�ro de l'it�ration.
   */
  public void setNumero (int pNumero)
  {
    mNumero = pNumero ;
  }


  /**
   * R�cup�re le projet dont l'it�ration est une �tape.
   * @return Projet dont l'it�ration est une �tape.
   */
  public MProjet getProjet ()
  {
    return mProjet ;
  }


  /**
   * Associe le projet dont l'it�ration est une �tape.
   * @param pProjet Projet dont l'it�ration est une �tape.
   */
  public void setProjet (MProjet pProjet)
  {
    mProjet = pProjet ;
  }


  /**
   * R�cup�re la liste des t�ches r�alis�es durant l'it�ration.
   * @return Liste des t�ches r�alis�es durant l'it�ration.
   */
  public ArrayList getListeTaches ()
  {
    return mTaches ;
  }


  /**
   * Initialise la liste des t�ches r�alis�es durant l'it�ration.
   * @param pTaches Liste des t�ches r�alis�es durant l'it�ration.
   */
  public void setListeTaches (ArrayList pTaches)
  {
    mTaches = pTaches ;
  }


  /**
   * R�cup�re le nombre de t�ches r�alis�es durant l'it�ration.
   * @return Nombre de t�ches r�alis�es durant l'it�ration.
   */
  public int getNbTaches ()
  {
    return mTaches.size () ;
  }


  /**
   * R�cup�re la t�che d'indice sp�cifi� r�alis�e durant l'it�ration.
   * @param pIndice Indice de la t�che dans la liste.
   * @return T�che r�alis�e durant l'it�ration.
   */
  public MTache getTache (int pIndice)
  {
    return (MTache) mTaches.get (pIndice) ;
  }


  /**
   * Ajoute la t�che sp�cifi�e � l'it�ration.
   * @param pTache T�che r�alis�e durant l'it�ration.
   */
  public void addTache (MTache pTache)
  {
    mTaches.add (pTache) ;
  }
}