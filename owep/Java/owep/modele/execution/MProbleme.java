package owep.modele.execution;

import java.util.ArrayList;

/**
 * 
 */
public class MProbleme
{
  private int       mId ;           // Identifiant du probl�me
  private String    mDescription ;  // Description du probl�me
  private int       mEtat ;         // Etat du probl�me
  private ArrayList mListeActions ; // Liste des actions � mener pour r�soudre le probl�me
  
  /**
   * Cr�e une instance vide de MProbleme
   */
  public MProbleme ()
  {
    mListeActions = new ArrayList () ;
  }
  
  /**
   * Cr�e une instance de MProbleme
   * @param pId Identifiant du probl�me
   */
  public MProbleme ( int pId)
  {
    mId           = pId;
    mListeActions = new ArrayList ();
  }
  
  /**
   * Cr�e une instance de MProbleme
   * @param pId Identifiant du probl�me
   * @param pDescription Description du probl�me
   * @param pEtat Etat du probl�me
   */
  public MProbleme ( int pId, String pDescription, int pEtat)
  {
    mId           = pId;
    mDescription  = pDescription ;
    mEtat         = pEtat ;
    mListeActions = new ArrayList () ;
  }
  
  /**
   * Cr�e une instance de MProbleme
   * @param pId Identifiant du probl�me
   * @param pDescription Description du probl�me
   * @param pEtat Etat du probl�me
   * @param pListeActions Liste des actions � mener pour r�soudre le probl�me 
   */
  public MProbleme ( int pId, String pDescription, int pEtat, 
                     ArrayList pListeActions)
  {
    mId           = pId;
    mDescription  = pDescription ;
    mEtat         = pEtat ;
    mListeActions = pListeActions ;
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
