package owep.modele.execution;

/**
 * D�crit les actions � mener pour r�soudre un probl�me ou un risque
 */
public class MAction
{
  private int   mId ;            // Identifiant de l'action
  private String mDescription ;  // Description de l'action
  
  /**
   * Cr�e une instance vide de MAction
   */
  public MAction ()
  {
  }
  
  /**
   * Cr�e une instance de MAction
   * @param pId Identifiant de l'action
   */
  public MAction (int pId)
  {
    mId = pId ;
  }
  
  /**
   * Cr�e une instance de MAction
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
