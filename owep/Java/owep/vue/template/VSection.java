/*
 * Created on 28 nov. 2004
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package owep.vue.template;

/**
 * @author Administrateur
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class VSection
{
  private String  mContenu ;  // Nom du fichier ou valeur � inclure dans la r�gion.
  private boolean mTypePage ; // Indique si la section fait r�f�rence � une page ou � une valeur � afficher.
  
  /**
   * 
   */
  public VSection ()
  {
    super () ;
    // TODO Auto-generated constructor stub
  }

  /**
   * @return Returns the Page.
   */
  public boolean isTypePage ()
  {
    return mTypePage ;
  }
  /**
   * @param pPage The Page to set.
   */
  public void setTypePage (boolean pTypePage)
  {
    mTypePage = pTypePage ;
  }
  /**
   * @return Returns the contenu.
   */
  public String getContenu ()
  {
    return mContenu ;
  }
  /**
   * @param pSection The contenu to set.
   */
  public void setContenu (String pContenu)
  {
    mContenu = pContenu ;
  }
}
