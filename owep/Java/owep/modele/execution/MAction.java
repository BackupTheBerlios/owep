package owep.modele.execution;

/**
 * Décrit les actions à mener pour résoudre un problème ou un risque
 */
public class MAction
{
  private int   mId ;            // Identifiant de l'action
  private String mDescription ;  // Description de l'action
  
  /**
   * Crée une instance vide de MAction
   */
  public MAction ()
  {
  }
  
  /**
   * Crée une instance de MAction
   * @param pId Identifiant de l'action
   */
  public MAction (int pId)
  {
    mId = pId ;
  }
  
  /**
   * Crée une instance de MAction
   * @param pId Identifiant de l'action
   * @param pDescription Description de l'action
   */
  public MAction (int pId, String pDescription)
  {
    mId = pId ;
    mDescription = pDescription ;
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
