package owep.controle.avancement;

import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpSession;
import org.exolab.castor.jdo.OQLQuery;
import org.exolab.castor.jdo.PersistenceException;
import org.exolab.castor.jdo.QueryResults;
import owep.controle.CConstante;
import owep.controle.CControleurBase;
import owep.infrastructure.Session;
import owep.modele.execution.MCollaborateur;
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
 * @author Emmanuelle et R�mi
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class CAvancementTachesCollabs extends CControleurBase{ 
    private MProjet mProjet ; //projet ouvert par le collaborateur
    private Session mSession ; // Session associ� � la connexion
    private MIteration mIteration ; // num�ro d'it�ration dont on veut voir le suivi d'avancement
    private int mIterationNum ; // Num�ro d'it�ration dont on suit l avancement des collaborateurs
    private int mIterationEnCours = -1 ; // Numero de l iteration en cours
        
    /**
     * R�cup�re les donn�es n�cessaire au controleur dans la base de donn�es. 
     * @throws ServletException Si une erreur survient durant la connexion
     * @see owep.controle.CControleurBase#initialiserBaseDonnees()
     */
    public void initialiserBaseDonnees () throws ServletException
    {
      OQLQuery       lRequete ;       // Requ�te � r�aliser sur la base
      QueryResults   lResultat ;      // R�sultat de la requ�te sur la base
      
      try
      {
        // R�cup�re le projet pour lequel le chef de projet s 'est connect�
        HttpSession session = getRequete ().getSession (true) ;
        mSession = (Session)session.getAttribute("SESSION") ;
        mProjet = mSession.getProjet() ;
        
        getBaseDonnees ().begin () ;
        
        int idProjet = mProjet.getId() ;
        // R�cup�re le projet dans la BD
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

        // si on a demand� l affichage du suivi des collaborateurs pour une
        // autre iteration que celle en cours
        if (mIterationNum != mIterationEnCours)
        {
          // creation de la liste des taches des collaborateurs
          MCollaborateur lCollaborateur ;
          MTache lTache ; 
          // pour chaque collaborateur
          for (int i = 0 ; i < mProjet.getNbCollaborateurs() ; i++)
          {
            ArrayList lListeTaches = new ArrayList ();
            lCollaborateur = mProjet.getCollaborateur(i) ;
            // pour chaque tache du collaborateur
            for (int j = 0 ; j < lCollaborateur.getNbTaches() ; j++)
            {
              lTache = lCollaborateur.getTache(j) ;
              // on ne retient que les taches de l iteration selectionn�e
              boolean tacheOK = false ;
              // on regarde si la tache en cours fait partie de l iteration selectionn�e
              for(int k = 0; k<mIteration.getNbTaches();k++)
              {
                if (mIteration.getTache(k).getId() == lTache.getId()) 
                {
                  tacheOK = true ;
                }
              }
              // si la tache en cours appartient a l iteration selectionn�e
              // on l ajoute a la liste des taches du collaborateur a afficher
              if (tacheOK == true)
              {
                lListeTaches.add(lTache) ;
              }
            }
            lCollaborateur.setListeTaches(lListeTaches) ;
            // on ajoute le collaborateur a la liste a afficher
            mProjet.setListe(new Integer(i), lCollaborateur) ;
          }
        }
      }
      catch (Exception eException)
      {
        eException.printStackTrace () ;
        throw new ServletException (CConstante.EXC_TRAITEMENT) ;
      }
      // Ferme la connexion � la base de donn�es.
      finally
      {
        try
        {
          getBaseDonnees ().close () ;
        }
        catch (PersistenceException eException)
        {
          eException.printStackTrace () ;
          throw new ServletException (CConstante.EXC_DECONNEXION) ;
        }
      }
    }
    
    /**
     * R�cup�re les param�tres pass�s au controleur. 
     * @throws ServletException -
     * @see owep.controle.CControleurBase#initialiserParametres()
     */
    public void initialiserParametres () throws ServletException
    {

    }
    
    
    /**
     * R�cup�re la liste des t�ches d'un collaborateur pour l'it�ration choisie, et la transmet � la
     * JSP. 
     * @return URL de la page vers laquelle doit �tre redirig� le client.
     * @throws ServletException Si une erreur survient dans le controleur
     * @see owep.controle.CControleurBase#traiter()
     */
    public String traiter () throws ServletException
    {  
      // si on veut voir l avancement pour une it�ration autre que celle qui est en cours
      if (mIterationNum != mIterationEnCours)
      {
        // Transmet les donn�es � la JSP d'affichage.
        getRequete ().setAttribute (CConstante.PAR_PROJET, mProjet) ;
        
        // Sauvegarde de l'URL en session pour la liste de it�rations
        mSession.setURLPagePrecedente("/Avancement/AvancementTachesCollabs");
        
        return "/JSP/Avancement/TAvancementTachesCollabs.jsp" ; 
      }
      // si on veut voir l avancement pour l'it�ration en cours
      else
      {
        return "/Avancement/AvancementCollaborateur" ; 
      }
    }
}
