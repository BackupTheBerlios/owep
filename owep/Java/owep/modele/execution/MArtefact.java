/*
 * Created on 25 nov. 2004
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package owep.modele.execution;


/**
 * @author Administrateur TODO To change the template for this generated type comment go to Window -
 *         Preferences - Java - Code Style - Code Templates
 */
public class MArtefact
{
  private int    mId ;
  private String mNom ;
  private String mDescription ;


  /**
   * 
   */
  public MArtefact ()
  {
  }

  public MArtefact (int pId, String pNom, String pDescription)
  {
    mId          = pId ;
    mNom         = pNom ;
    mDescription = pDescription ;
  }

  /**
   * @return Returns the mDescription.
   */
  public String getDescription ()
  {
    return mDescription ;
  }

  /**
   * @param description The mDescription to set.
   */
  public void setDescription (String pDescription)
  {
    mDescription = pDescription ;
  }

  /**
   * @return Returns the mId.
   */
  public int getId ()
  {
    return mId ;
  }

  /**
   * @param id The mId to set.
   */
  public void setId (int pId)
  {
    mId = pId ;
  }

  /**
   * @return Returns the mNom.
   */
  public String getNom ()
  {
    return mNom ;
  }

  /**
   * @param nom The mNom to set.
   */
  public void setNom (String pNom)
  {
    mNom = pNom ;
  }
}