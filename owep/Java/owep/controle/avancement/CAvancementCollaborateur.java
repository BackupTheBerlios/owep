package owep.controle.avancement;

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
public class CAvancementCollaborateur extends CControleurBase{ 
    private MProjet mProjet ; //projet ouvert par le collaborateur
    private Session mSession ; // Session associé à la connexion
    private MIteration mIteration ; // numéro d'itération dont on veut voir le suivi d'avancement
    private int mIterationNum ; // Numéro d'itération dont on suit l avancement des collaborateurs
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

        // si on a demandé l affichage du suivi des collaborateurs pour l iteration en cours
        if (mIterationNum == mIterationEnCours)
        {
          // creation de la liste des taches en cours des collaborateurs
          MTache lTacheEnCours ; 
          for (int i = 0 ; i < mProjet.getNbCollaborateurs() ; i++)
          {
            // on recupere la tache en cours du collaborateur
            int idTacheEnCours = mProjet.getCollaborateur(i).getTacheEnCours() ;
            
            // si le collaborateur n'a pas de tache en cours, on met null a l indice
            // du collaborateur dans le tableau des taches en cours
            if (idTacheEnCours == -1)
            {
              mProjet.setListe(new Integer(i) , null) ;
            }
            // sinon on recherche la tache en cours dans la BD
            else
            {
  
              getBaseDonnees ().begin () ;
              
              // Récupère la tache en cours du collaborateur dans la BD
              lRequete = getBaseDonnees ().getOQLQuery ("select TACHE from owep.modele.execution.MTache TACHE where mId = $1") ;
              lRequete.bind (idTacheEnCours) ;
              lResultat      = lRequete.execute () ;
              lTacheEnCours = (MTache) lResultat.next () ;
              
              getBaseDonnees ().commit () ;
              
              boolean tacheOK = false ;
              // on regarde si la tache en cours fait partie de l iteration selectionnée
              for(int k = 0; k<mIteration.getNbTaches();k++)
              {
                if (mIteration.getTache(k).getId() == lTacheEnCours.getId()) 
                {
                  tacheOK = true ;
                }
              }
              // si la tache en cours appartient a l iteration selectionnée
              if (tacheOK == true)
              {
                // ajout de la tache en cours a l indice du collaborateur correspondant
                mProjet.setListe(new Integer(i), lTacheEnCours) ;
              }
              else
              {
                mProjet.setListe(new Integer(i) , null) ;
              }
            }
          }
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
      // si on veut voir l avancement pour l'itération en cours
      if (mIterationNum == mIterationEnCours)
      {
        // Transmet les données à la JSP d'affichage.
        getRequete ().setAttribute (CConstante.PAR_PROJET, mProjet) ;
        
        // Sauvegarde de l'URL en session pour la liste de itérations
        mSession.setURLPagePrecedente("/Avancement/AvancementCollaborateur");
        
        return "/JSP/Avancement/TAvancementCollaborateur.jsp" ; 
      }
      // si on veut voir l avancement pour une itération autre que celle qui est en cours
      else
      {
        // Transmet les données à la JSP d'affichage.
        getRequete ().setAttribute (CConstante.PAR_ITERATION, getRequete ().getParameter (CConstante.PAR_ITERATION)) ;
        
        return "/Avancement/AvancementTachesCollabs" ; 
      }
    }
}
