/*
 * Created on 25 nov. 2004
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package owep.controle;


import javax.servlet.ServletException;

import org.exolab.castor.jdo.OQLQuery;
import org.exolab.castor.jdo.PersistenceException;
import org.exolab.castor.jdo.QueryResults;

import owep.modele.execution.MCollaborateur;


/**
 * @author Administrateur TODO To change the template for this generated type comment go to Window -
 *         Preferences - Java - Code Style - Code Templates
 */
public class CListeTacheVisu extends CControleurBase
{
  /* (non-Javadoc)
   * @see owep.controle.CControleurBase#traiter(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
   */
  public String traiter () throws ServletException
  {
    MCollaborateur lCollaborateur=null ;        // Collaborateur ayant ouvert la session.
    //int lProjetId ;                        // Identifiant du projet consulté. 
    int lIterationNum ;                    // Numéro d'itération dont on liste les tâches.
       
    if (getRequete ().getParameter ("pIterationNum") == null)
    {
      // requete recup it en cours
      lIterationNum = 0 ;
    }
    else
    {
      lIterationNum = Integer.parseInt (getRequete ().getParameter ("pIterationNum")) ;
    }
    lIterationNum = 1;

    try
    {
      connexionBD();
      OQLQuery     oql;
      QueryResults results;
      oql = getBaseDonnees().getOQLQuery( "select C from owep.modele.execution.MCollaborateur C where mId=$1" );
      oql.bind (1) ;
      // Retrieve results and print each one
      results = oql.execute () ;  
      while (results.hasMore ())
      {
        lCollaborateur = (MCollaborateur) results.next () ;       
      }
    }
    catch (Exception eException)
    {
      // TODO Auto-generated catch block
      eException.printStackTrace();
    }
    finally
    {
      try
      {
        deconnexionBD();
      }
      catch (PersistenceException eException)
      {
        // TODO Auto-generated catch block
        eException.printStackTrace();
      }
    }
    
    // Appelle la JSP d'affichage.
    getRequete ().setAttribute ("pCollaborateur", lCollaborateur) ;
    getRequete ().setAttribute ("pNumIteration", new Integer(lIterationNum));
    return "..\\JSP\\Tache\\TListeTacheVisu.jsp" ;
  }
}