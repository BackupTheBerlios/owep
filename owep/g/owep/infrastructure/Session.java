/*
 * Created on 9 janv. 2005
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package owep.infrastructure;

import owep.modele.execution.MCollaborateur;


/**
 * @author lalo
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class Session
{
  private MCollaborateur mCollaborateur = null;  // collaborateur connecté
  
  public void ouvertureSession(MCollaborateur pCollaborateur)
  {
    mCollaborateur = pCollaborateur;
  }
  
  public MCollaborateur getCollaborateur()
  {
    return mCollaborateur;
  }
}
