package owep.controle.avancement;

import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpSession;
import org.exolab.castor.jdo.OQLQuery;
import org.exolab.castor.jdo.QueryResults;
import owep.controle.CConstante;
import owep.controle.CControleurBase;
import owep.infrastructure.Session;
import owep.modele.execution.MIteration;
import owep.modele.execution.MProjet;
import owep.modele.execution.MTache;

/*
 * Created on 25 janv. 2005
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */



/**
 * @author Emmanuelle et Rémi
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class CAvancementProjet extends CControleurBase{ 
    private MIteration mIteration ; // Iteration choisie
    private Session mSession ; // Session associé à la connexion
    private MProjet mProjet ; //projet ouvert par le collaborateur
    private int mIterationNum ; // Numéro d'itération dont on suit l avancement
    private int mIterationEnCours = -1 ; // Numero de l iteration en cours
        
    /**
     * Récupère les données nécessaire au controleur dans la base de données. 
     * @throws ServletException Si une erreur survient durant la connexion
     * @see owep.controle.CControleurBase#initialiserBaseDonnees()
     */
    public void initialiserBaseDonnees () throws ServletException
    {
      OQLQuery       lRequete ;       // Requête à réaliser sur la base
      QueryResults   lResultat ;      // Résultat de la requête sur la base
      
      try
      {
        // Récupère le projet pour lequel le chef de projet s 'est connecté
        HttpSession session = getRequete ().getSession (true) ;
        mSession = (Session)session.getAttribute("SESSION") ;
        mProjet = mSession.getProjet() ;
        
        getBaseDonnees ().begin () ;
        
        int idProjet = mProjet.getId() ;
        // Récupère le projet dans la BD
        lRequete = getBaseDonnees ().getOQLQuery ("select PROJET from owep.modele.execution.MProjet PROJET where mId = $1") ;
        lRequete.bind (idProjet) ;
        lResultat      = lRequete.execute () ;
        mProjet = (MProjet) lResultat.next () ;
        
        getBaseDonnees ().commit () ;
        
        // recuperation du numero de l iteration choisie dans le menu deroulant
        mIteration = mSession.getIteration() ;
        mIterationNum = mIteration.getNumero();
        
        // recherche de l iteration en cours
        for (int m = 0; m < mProjet.getNbIterations() ; m++)
        {
          if (mProjet.getIteration(m).getEtat()==1)
            mIterationEnCours = mProjet.getIteration(m).getId();
        }

        // si on a demandé l affichage du suivi de l iteration en cours
        // on recharge les taches au cas ou les collaborateurs aient modifiés 
        // des propriétés de la tache
        if (mIterationNum == mIterationEnCours)
        {
          // creation de la liste des taches en cours des collaborateurs
          MTache lTache ;
          // on recupere l'iteration du projet rechargé
          mIteration = mProjet.getIteration(mIterationNum - 1) ;
          ArrayList lListeTache = new ArrayList() ;
          // pour chaque tache de l iteration
          for (int i = 0 ; i < mIteration.getNbTaches() ; i++)
          {
            // on recupere l id de la tache a recharger
            int idTache = mIteration.getTache(i).getId() ;
            
            getBaseDonnees ().begin () ;
              
            // Récupère la tache a recharger dans la BD
            lRequete = getBaseDonnees ().getOQLQuery ("select TACHE from owep.modele.execution.MTache TACHE where mId = $1") ;
            lRequete.bind (idTache) ;
            lResultat      = lRequete.execute () ;
            lTache = (MTache) lResultat.next () ;
            
            getBaseDonnees ().commit () ;
            // ajout de la tache rechargée a la liste des taches rechargées
            lListeTache.add(lTache) ;
          }
          // mise a jour de la liste des tahes de l iteration choisie
          mIteration.setListeTaches(lListeTache) ;
        }
      }
      catch (Exception eException)
      {
        eException.printStackTrace () ;
        throw new ServletException (CConstante.EXC_TRAITEMENT) ;
      }
    }
    
    /**
     * Récupère les paramètres passés au controleur. 
     * @throws ServletException -
     * @see owep.controle.CControleurBase#initialiserParametres()
     */
    public void initialiserParametres () throws ServletException
    {
      try
      {

      }
      catch (Exception eException)
      {
        eException.printStackTrace () ;
        throw new ServletException (CConstante.EXC_TRAITEMENT) ;
      }
    }
    
    
    /**
     * Récupère la liste des tâches d'un collaborateur pour l'itération choisie, et la transmet à la
     * JSP. 
     * @return URL de la page vers laquelle doit être redirigé le client.
     * @throws ServletException Si une erreur survient dans le controleur
     * @see owep.controle.CControleurBase#traiter()
     */
    public String traiter () throws ServletException
    {  
      // Transmet les données à la JSP d'affichage.
      getRequete ().setAttribute (CConstante.PAR_ITERATION, mIteration) ;
      
      // Sauvegarde de l'URL en session pour la liste de itérations
      mSession.setURLPagePrecedente("/Avancement/AvancementProjet");
      
      return "..\\JSP\\Avancement\\TAvancementProjet.jsp" ; 
    }
}
