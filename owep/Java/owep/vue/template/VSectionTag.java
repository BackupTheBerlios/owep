/*
 * Created on 28 nov. 2004
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package owep.vue.template;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.TagSupport;

/**
 * @author Administrateur
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class VSectionTag extends TagSupport
{
  // Nom de la r�gion dans laquelle doit �tre incluse la section.
  private String   mRegion ;
  // D�finit la section � inclure dans la r�gion.
  private VSection mSection ;
  
  /**
   * 
   */
  public VSectionTag ()
  {
    super() ;
    
    mSection = new VSection () ;
  }
  
  
  /* (non-Javadoc)
   * @see javax.servlet.jsp.tagext.Tag#doStartTag()
   */
  public int doStartTag () throws JspException
  {
    // V�rifie que la balise "section" courante est incluse dans une balise "template".
    assert findAncestorWithClass (this, VTemplateTag.class) != null ;
    // V�rifie que la pile de template a bien �t� cr��e.
    assert pageContext.getAttribute ("TEMPLATE_PILE", PageContext.REQUEST_SCOPE) != null ;
    
    VPileTemplate lPileTemplate = (VPileTemplate) pageContext.getAttribute ("TEMPLATE_PILE", PageContext.REQUEST_SCOPE) ;
    lPileTemplate.ajouterSection (mRegion, mSection) ;
    
    // R�initialise le tag
    mSection = new VSection () ;
    
    return SKIP_BODY ;
  }

  
  /**
   * @param pPage The Page to set.
   */
  public void setTypePage (String pTypePage)
  {
    mSection.setTypePage (pTypePage.equals ("true")) ;
  }
  
  /**
   * @param pRegion The region to set.
   */
  public void setRegion (String pRegion)
  {
    mRegion = pRegion ;
  }
  
  /**
   * @param pVue The vue to set.
   */
  public void setContenu (String pContenu)
  {
    mSection.setContenu (pContenu) ;
  }
}
