/*
 * Created on 28 nov. 2004
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package owep.vue.template;

import java.util.HashMap ;
import java.util.Stack ;

/**
 * @author Administrateur
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class VPileTemplate
{
  private Stack mPileTemplate ;
  
  /**
   * 
   */
  public VPileTemplate ()
  {
    super() ;

    mPileTemplate = new Stack () ;
  }
  
  public void empilerTemplate ()
  {
    mPileTemplate.push (new HashMap ()) ;
  }

  public void depilerTemplate ()
  {
    mPileTemplate.pop () ;
  }

  public void ajouterSection (String pNomRegion, VSection pSection)
  {
    ((HashMap) mPileTemplate.peek ()).put (pNomRegion, pSection) ;
  }

  public VSection getSection (String pNomRegion)
  {
    return (VSection) ((HashMap) mPileTemplate.peek ()).get (pNomRegion) ;
  }
}
