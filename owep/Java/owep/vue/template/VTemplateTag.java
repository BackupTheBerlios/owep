/*
 * Created on 28 nov. 2004
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package owep.vue.template;

import javax.servlet.jsp.JspException ;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.TagSupport ;

/**
 * @author Administrateur
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class VTemplateTag extends TagSupport
{
  // Nom du fichier contenant le template.
  private String mNom ;
  // Pile contenant les d�finitions de templates. Celles-ci enregistre les associations
  // r�gion/section. Une pile est utilis� afin de pouvoir ins�rer des templates � l'int�rieur
  // d'autre template.
  private VPileTemplate mPileTemplate ; 
  

  /**
   * 
   */
  public VTemplateTag ()
  {
    super() ;
  }

  /**
   * @param pTemplate The template to set.
   */
  public void setNom (String pNom)
  {
    mNom = pNom ;
  }
  
  /* (non-Javadoc)
   * @see javax.servlet.jsp.tagext.Tag#doStartTag()
   */
  public int doStartTag () throws JspException
  {
    // R�cup�re la pile de template ou l'initialise si elle n'existe pas.
    mPileTemplate = (VPileTemplate) pageContext.getAttribute ("TEMPLATE_PILE", PageContext.REQUEST_SCOPE) ;
    if (mPileTemplate == null)
    {
      mPileTemplate = new VPileTemplate () ;
      pageContext.setAttribute ("TEMPLATE_PILE", mPileTemplate, PageContext.REQUEST_SCOPE);
    }
    
    // Met la table qui contiendra la d�finition du template courant dans la pile.
    mPileTemplate.empilerTemplate () ;
    
    return EVAL_BODY_INCLUDE ;
  }
  
  /* (non-Javadoc)
   * @see javax.servlet.jsp.tagext.Tag#doEndTag()
   */
  public int doEndTag () throws JspException
  {
    // Inclu le template.
    try
    {
      pageContext.include (mNom) ;
    }
    catch(Exception lException)
    {
      throw new JspException(lException.getMessage());
    }
    
    // Supprime la d�finition de template de la pile.
    mPileTemplate.depilerTemplate ();

    return EVAL_PAGE ;
  }
}
