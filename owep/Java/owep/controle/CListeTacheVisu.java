/*
 * Created on 25 nov. 2004
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package owep.controle;


import java.util.Date;

import javax.servlet.ServletException ;

import owep.modele.execution.MActivite;
import owep.modele.execution.MArtefact;
import owep.modele.execution.MCollaborateur;
import owep.modele.execution.MTache;


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
    MCollaborateur lCollaborateur ;        // Collaborateur ayant ouvert la session.
    //int lProjetId ;                        // Identifiant du projet consulté. 
    int lIterationNum ;                    // Numéro d'itération dont on liste les tâches.
    
    // Récupération des paramètres de la requête.
    // lCollaborateur = (MCollaborateur) getRequete ().getSession ().getAttribute ("pCollaborateur") ;
    // lProjetId      = Integer.parseInt ((String) getRequete ().getSession ().getAttribute ("pProjetId")) ;
    if (getRequete ().getParameter ("pIterationNum") == null)
    {
      // requete recup it en cours
      lIterationNum = 0 ;
    }
    else
    {
      lIterationNum = Integer.parseInt (getRequete ().getParameter ("pIterationNum")) ;
    }
    lCollaborateur = new MCollaborateur(1, "prenom1", "nom1", "adresse1", "tel1", "port1", "email1", "comm1");
    MTache lTache1 = new MTache(1, "tache1", "desc1", 1.0, new Date(), new Date(), new MActivite ());
    MTache lTache2 = new MTache(2, "tache2", "desc2", 2.0, new Date(), new Date(), new MActivite ());
    MArtefact lArtefact1 = new MArtefact(1, "artefact1", "description1");
    MArtefact lArtefact2 = new MArtefact(2, "artefact2", "description2");
    MArtefact lArtefact3 = new MArtefact(3, "artefact3", "description3");
    
    lTache1.ajouterArtefactEntree(lArtefact1);
    lTache1.ajouterArtefactSortie(lArtefact2);
    
    lTache2.ajouterArtefactSortie(lArtefact1);
    lTache2.ajouterArtefactSortie(lArtefact3);
    
    lCollaborateur.ajouterTache(lTache1);
    lCollaborateur.ajouterTache(lTache2);
    
    lIterationNum = 1;
    
    // Appelle la JSP d'affichage.
    getRequete ().setAttribute ("pCollaborateur", lCollaborateur) ;
    getRequete ().setAttribute ("pNumIteration", new Integer(lIterationNum));
    return "..\\JSP\\Tache\\TListeTacheVisu.jsp" ;
  }
}