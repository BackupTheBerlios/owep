/*
 * Created on 28 nov. 2004
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package owep.vue.template;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.TagSupport;

/**
 * @author Administrateur
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class VRegionTag extends TagSupport
{
  // Nom de la r�gion, � partir de laquelle la section est r�cup�r�e.
  private String  mNom ;
  
  /**
   * 
   */
  public VRegionTag ()
  {
    super() ;
  }
  
  
  /* (non-Javadoc)
   * @see javax.servlet.jsp.tagext.Tag#doStartTag()
   */
  public int doStartTag () throws JspException
  {
    // V�rifie que la pile de template a bien �t� cr��e.
    assert pageContext.getAttribute ("TEMPLATE_PILE", PageContext.REQUEST_SCOPE) != null ;
    
    
    // R�cup�re la section � inclure.
    VSection lSection = ((VPileTemplate) pageContext.getAttribute ("TEMPLATE_PILE", PageContext.REQUEST_SCOPE)).getSection (mNom) ;
    
    // Si la section � inclure a �t� d�finie
    if (lSection != null)
    {
      // Si la section est de type page, ins�re le contenu de celle-ci dans la r�gion.
      if (lSection.isTypePage ())
      {
        // Affiche le texte
        try
        {
          pageContext.getOut ().flush () ;
          pageContext.include (lSection.getContenu ()) ;
        }
        catch(Exception lException)
        { 
          throw new JspException (lException.getMessage()) ;
        }
      }
      else
      // Si la section est de type texte, ins�re la valeur de celui-ci dans la r�gion.
      {
        try
        {
          pageContext.getOut ().print (lSection.getContenu ()) ;
          pageContext.getOut ().flush () ;
        }
        catch (IOException lException)
        {
          throw new JspException (lException.getMessage()) ;
        }
      }
    }

    return SKIP_BODY;
  }

  
  /**
   * @param pNom The nom to set.
   */
  public void setNom (String pNom)
  {
    mNom = pNom ;
  }
}
