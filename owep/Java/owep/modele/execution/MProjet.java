package owep.modele.execution;

import java.sql.Date;
import java.util.ArrayList;

/**
 * 
 */
public class MProjet
{
  private int       mId ;               // Identifiant du projet
  private String    mNom ;              // Nom du projet
  private String    mDescription ;      // Description du projet
  private Date      mDateDebutPrevue ;  // Date de d�but pr�vue du projet
  private Date      mDateFinPrevue ;    // Date de fin pr�vue du projet
  private float     mBudget ;           // Budget du projet
  private ArrayList mListeIterations ;  // Liste des it�rations du projet
  private ArrayList mListeRisques ;     // Liste des risques du projet
  
  /**
   * Cr�e une instance vide de MProjet
   */
  public MProjet ()
  {
    mListeIterations = new ArrayList () ;
    mListeRisques    = new ArrayList () ;
  }
  
  /**
   * Cr�e une instance de Mprojet
   * @param pId Identifiant du projet
   * @param pNom Nom du projet
   * @param pDescription Description du projet
   * @param pDateDebutPrevue Date de d�but pr�vue du projet
   * @param pDateFinPrevue Date de fin pr�vue du projet
   * @param pBudget Budget du projet
   */
  public MProjet (int pId, String pNom, String pDescription, 
                  Date pDateDebutPrevue, Date pDateFinPrevue, float pBudget)
  {
    mId              = pId;
    mNom             = pNom ;
    mDescription     = pDescription ;
    mDateDebutPrevue = pDateDebutPrevue ;
    mDateFinPrevue   = pDateFinPrevue ;
    mBudget          = pBudget ;
    mListeIterations = new ArrayList () ;
    mListeRisques    = new ArrayList () ;
  }
  
  /**
   * Cr�e une instance de Mprojet
   * @param pId Identifiant du projet
   * @param pNom Nom du projet
   * @param pDescription Description du projet
   * @param pDateDebutPrevue Date de d�but pr�vue du projet
   * @param pDateFinPrevue Date de fin pr�vue du projet
   * @param pBudget Budget du projet
   * @param pListeIterations Liste des it�rations du projet
   */
  public MProjet (int pId, String pNom, String pDescription, Date pDateDebutPrevue, 
                  Date pDateFinPrevue, float pBudget, ArrayList pListeIterations)
  {
    mId              = pId;
    mNom             = pNom ;
    mDescription     = pDescription ;
    mDateDebutPrevue = pDateDebutPrevue ;
    mDateFinPrevue   = pDateFinPrevue ;
    mBudget          = pBudget ;
    mListeIterations = pListeIterations ;
    mListeRisques    = new ArrayList () ;
  }
  
  /**
   * Cr�e une instance de Mprojet
   * @param pId Identifiant du projet
   * @param pNom Nom du projet
   * @param pDescription Description du projet
   * @param pDateDebutPrevue Date de d�but pr�vue du projet
   * @param pDateFinPrevue Date de fin pr�vue du projet
   * @param pBudget Budget du projet
   * @param pListeRisques Liste des risques du projet
   */
  public MProjet (int pId, String pNom, String pDescription, 
                  Date pDateDebutPrevue, Date pDateFinPrevue, 
                  ArrayList pListeRisques, float pBudget)
  {
    mId              = pId;
    mNom             = pNom ;
    mDescription     = pDescription ;
    mDateDebutPrevue = pDateDebutPrevue ;
    mDateFinPrevue   = pDateFinPrevue ;
    mBudget          = pBudget ;
    mListeIterations = new ArrayList () ;
    mListeRisques    = pListeRisques ;
  }
  
  /**
   * Cr�e une instance de Mprojet
   * @param pNom Nom du projet
   * @param pDescription Description du projet
   * @param pDateDebutPrevue Date de d�but pr�vue du projet
   * @param pDateFinPrevue Date de fin pr�vue du projet
   * @param pBudget Budget du projet
   * @param pListeRisques Liste des risques du projet
   * @param pListeActivites
   */
  public MProjet (int pId, String pNom, String pDescription, 
                  Date pDateDebutPrevue, Date pDateFinPrevue, float pBudget, 
                  ArrayList pListeRisques, ArrayList pListeActivites)
  {
    mId              = pId;
    mNom             = pNom ;
    mDescription     = pDescription ;
    mDateDebutPrevue = pDateDebutPrevue ;
    mDateFinPrevue   = pDateFinPrevue ;
    mBudget          = pBudget ;
    mListeIterations = pListeActivites ;
    mListeRisques    = pListeRisques ;
  }
  
  /**
   * @return Retourne la valeur de l'attribut budget.
   */
  public float getBudget ()
  {
    return mBudget ;
  }
  
  /**
   * @param initialse budget avec pBudget.
   */
  public void setBudget (float pBudget)
  {
    mBudget = pBudget ;
  }
  
  /**
   * @return Retourne la valeur de l'attribut dateDebutPrevue.
   */
  public Date getDateDebutPrevue ()
  {
    return mDateDebutPrevue ;
  }
  
  /**
   * @param initialse dateDebutPrevue avec pDateDebutPrevue.
   */
  public void setDateDebutPrevue (Date pDateDebutPrevue)
  {
    mDateDebutPrevue = pDateDebutPrevue ;
  }
  
  /**
   * @return Retourne la valeur de l'attribut dateFinPrevue.
   */
  public Date getDateFinPrevue ()
  {
    return mDateFinPrevue ;
  }
  
  /**
   * @param initialse dateFinPrevue avec pDateFinPrevue.
   */
  public void setDateFinPrevue (Date pDateFinPrevue)
  {
    mDateFinPrevue = pDateFinPrevue ;
  }
  
  /**
   * @return Retourne la valeur de l'attribut description.
   */
  public String getDescription ()
  {
    return mDescription ;
  }
  
  /**
   * @param initialse description avec pDescription.
   */
  public void setDescription (String pDescription)
  {
    mDescription = pDescription ;
  }
  
  /**
   * @return Retourne la valeur de l'attribut nom.
   */
  public String getNom ()
  {
    return mNom ;
  }
  
  /**
   * @param initialse nom avec pNom.
   */
  public void setNom (String pNom)
  {
    mNom = pNom ;
  }
  
  /**
   * @return Retourne la valeur de l'attribut listeIterations.
   */
  public ArrayList getListeIterations ()
  {
    return mListeIterations ;
  }
  
  /**
   * @param initialise listeIterations avec pListeIterations.
   */
  public void setListeIterations (ArrayList pListeIterations)
  {
    mListeIterations = pListeIterations ;
  }
  
  /**
   * @return Retourne la valeur de l'attribut listeRisques.
   */
  public ArrayList getListeRisques ()
  {
    return mListeRisques ;
  }
  
  /**
   * @param initialise listeRisques avec pListeRisques.
   */
  public void setListeRisques (ArrayList pListeRisques)
  {
    mListeRisques = pListeRisques ;
  }
  
  /**
   * @return Retourne la valeur de l'attribut id.
   */
  public int getId ()
  {
    return mId ;
  }
  
  /**
   * @param initialise id avec pId.
   */
  public void setId (int pId)
  {
    mId = pId ;
  }
}
