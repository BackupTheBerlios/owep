package owep.modele.execution;

import java.sql.Date;
import java.util.ArrayList;

/**
 * 
 */
public class MRisque
{
  private int       mId ;                  // Identification du risque 
  private int       mPriorite ;            // Priorité du risque
  private Date      mDateIdentification ;  // Date d'indentifiaction du risque
  private String    mNom ;                 // Nom du risque
  private String    mDescription ;         // Description du risque
  private int       mEtat ;                // Etat du risque
  private ArrayList mListeActions ;        // Liste des actions à mener lors que le risque est rencontré     
  
  /**
   * Crée une instance vide de MRisque
   */
  public MRisque ()
  {
    mListeActions = new ArrayList () ;  
  }
  
  /**
   * CRée une instance de MRisque 
   * @param pId Identification du risque 
   */
  public MRisque (int pId)
  {
    mId           = pId;
    mListeActions = new ArrayList ();
  }
  
  /**
   * Ceée une instance de MRisque
   * @param pId Identification du risque
   * @param pPriorite Priorité du risque
   * @param pDateIdentification Date d'identifiaction du risque
   * @param pNom Nom du risque
   * @param pDescription Description du risque
   * @param pEtat Etat du risque
   */
  public MRisque (int pId, int pPriorite, Date pDateIdentification, String pNom,
                  String pDescription, int pEtat)
  {
    mId                 = pId ;
    mPriorite           = pPriorite ;
    mDateIdentification = pDateIdentification ;
    mNom                = pNom ;
    mDescription        = pDescription ;
    mEtat               = pEtat ;
    mListeActions       = new ArrayList ();
  }
  
  /**
   * Ceée une instance de MRisque
   * @param pId Identification du risque
   * @param pPriorite Priorité du risque
   * @param pDateIdentification Date d'identifiaction du risque
   * @param pNom Nom du risque
   * @param pDescription Description du risque
   * @param pEtat Etat du risque
   * @param pListeActions Liste des actions à maner du risque
   */
  public MRisque (int pId, int pPriorite, Date pDateIdentification, String pNom,
                  String pDescription, int pEtat, ArrayList pListeActions)
  {
    mId                 = pId ;
    mPriorite           = pPriorite ;
    mDateIdentification = pDateIdentification ;
    mNom                = pNom ;
    mDescription        = pDescription ;
    mEtat               = pEtat ;
    mListeActions       = pListeActions ;
  }
  
  /**
   * @return Retourne la valeur de l'attribut dateIdentification.
   */
  public Date getDateIdentification ()
  {
    return mDateIdentification ;
  }
  
  /**
   * @param initialise dateIdentification avec pDateIdentification.
   */
  public void setDateIdentification (Date pDateIdentification)
  {
    mDateIdentification = pDateIdentification ;
  }
  
  /**
   * @return Retourne la valeur de l'attribut description.
   */
  public String getDescription ()
  {
    return mDescription ;
  }
  
  /**
   * @param initialise description avec pDescription.
   */
  public void setDescription (String pDescription)
  {
    mDescription = pDescription ;
  }
  
  /**
   * @return Retourne la valeur de l'attribut etat.
   */
  public int getEtat ()
  {
    return mEtat ;
  }
  
  /**
   * @param initialise etat avec pEtat.
   */
  public void setEtat (int pEtat)
  {
    mEtat = pEtat ;
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
  
  /**
   * @return Retourne la valeur de l'attribut priorite.
   */
  public int getPriorite ()
  {
    return mPriorite ;
  }
  
  /**
   * @param initialise priorite avec pPriorite.
   */
  public void setPriorite (int pPriorite)
  {
    mPriorite = pPriorite ;
  }
  
  /**
   * @return Retourne la valeur de l'attribut pNom.
   */
  public String getNom ()
  {
    return mNom ;
  }
  
  /**
   * @param initialise pNom avec pNom.
   */
  public void setNom (String pNom)
  {
    mNom = pNom ;
  }
  
  /**
   * @return Retourne la valeur de l'attribut listeActions.
   */
  public ArrayList getListeActions ()
  {
    return mListeActions ;
  }
  
  /**
   * @param initialise listeActions avec pListeActions.
   */
  public void setListeActions (ArrayList pListeActions)
  {
    mListeActions = pListeActions ;
  }
}
