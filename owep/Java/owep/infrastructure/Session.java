/*
 * Created on 9 janv. 2005
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package owep.infrastructure;

import owep.modele.execution.MCollaborateur;
import owep.modele.execution.MIteration;
import owep.modele.execution.MProjet;

/**
 * @author lalo
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class Session
{
  private MCollaborateur mCollaborateur = null;  // collaborateur connecté
  private MProjet mProjet = null; // projet ouvert par le collaborateur connecté
  private MIteration mIteration = null; // itération ouvert par le collaborateur connecté
   
  public void ouvertureSession(MCollaborateur pCollaborateur)
  {
    mCollaborateur = pCollaborateur;
  }
  
  public MCollaborateur getCollaborateur()
  {
    return mCollaborateur;
  }
  
  public MProjet getProjet()
  {
    return mProjet;
  }
  
  public void ouvrirProjet(MProjet pProjet)
  {
    mProjet = pProjet;
  }
  
  public MIteration getIteration()
  {
    return mIteration;
  }
  
  public void setIteration(MIteration pIteration)
  {
    mIteration = pIteration;
  }  
  
  public void fermerProjet()
  {
    mProjet = null;
  }
}
