/*
 * Created on 25 nov. 2004
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package owep.controle ;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException ;

import owep.modele.execution.MCollaborateur;


/**
 * @author Administrateur TODO To change the template for this generated type comment go to Window -
 *         Preferences - Java - Code Style - Code Templates
 */
public class CConsultationTache extends CControleurBase
{
  /* (non-Javadoc)
   * @see owep.controle.CControleurBase#traiter(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
   */
  public String traiter () throws ServletException
  {
    MCollaborateur lCollaborateur ;        // Collaborateur ayant ouvert la session.
    int lProjetId ;                        // Identifiant du projet consulté. 
    int lIterationNum ;                    // Numéro d'itération dont on liste les tâches.
    RequestDispatcher lRequeteDispatcher ; // Permet d'appeler la JSP d'affichage.

    // Récupération des paramètres de la requête.
    lCollaborateur = (MCollaborateur) getRequete ().getSession ().getAttribute ("pCollaborateur") ;
    lProjetId      = Integer.parseInt ((String) getRequete ().getAttribute ("pProjetId")) ;
    if (getRequete ().getAttribute ("pIterationNum") == null)
    {
      // requete recup it en cours
      lIterationNum = 0 ;
    }
    else
    {
      lIterationNum = Integer.parseInt ((String) getRequete ().getAttribute ("pIterationNum")) ;
    }
    
    // Appelle la JSP d'affichage.
    getRequete ().setAttribute ("pCollaborateur", lCollaborateur) ;
    return "\\JSP\\Tache\\TListeTacheVisu.jsp" ;
  }
}