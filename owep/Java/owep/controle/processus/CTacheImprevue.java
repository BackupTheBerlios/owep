package owep.controle.processus;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.servlet.ServletException;
import org.exolab.castor.jdo.OQLQuery;
import org.exolab.castor.jdo.QueryResults;
import com.mysql.jdbc.Driver;
import owep.controle.CConstante;
import owep.controle.CControleurBase;
import owep.infrastructure.Session;
import owep.infrastructure.localisation.LocalisateurIdentifiant;
import owep.modele.execution.MActiviteImprevue;
import owep.modele.execution.MArtefact;
import owep.modele.execution.MArtefactImprevue;
import owep.modele.execution.MCollaborateur;
import owep.modele.execution.MCondition;
import owep.modele.execution.MIteration;
import owep.modele.execution.MProjet;
import owep.modele.execution.MTache;
import owep.modele.execution.MTacheImprevue;
import owep.modele.processus.MActivite;
import owep.modele.processus.MComposant;
import owep.modele.processus.MDefinitionTravail;
import owep.modele.processus.MProcessus;
import owep.modele.processus.MProduit;
import owep.vue.transfert.VTransfert;


/**
 * Description de la classe.
 */
public class CTacheImprevue extends CControleurBase
{
  private MProjet    mProjet ;    // Projet actuellement ouvert par l'utilisateur.
  private MIteration mIteration ;
  /**
   * TODO Description de initialiserBaseDonnees.
   * @throws ServletException
   * @see owep.controle.CControleurBase#initialiserBaseDonnees()
   */
  
  public void initialiserBaseDonnees () throws ServletException
  {
    // Si on acc�de pour la premi�re fois au controleur (ajout ou modification d'une it�ration).
    if (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_VIDE) ||
        getRequete ().getParameter (CConstante.PAR_MODIFIER) != null)
    {
      Session          lSession ;  // Session actuelle de l'utilisateur.
      OQLQuery         lRequete ;  // Requ�te � r�aliser sur la base
      QueryResults     lResultat ; // R�sultat de la requ�te sur la base
      
      lSession = (Session) getRequete ().getSession ().getAttribute (CConstante.SES_SESSION) ;
      mProjet  = lSession.getProjet () ;
      
      // Charge une copie du projet ouvert.
      try
      {
        getBaseDonnees ().begin () ;
        
        // R�cup�re la liste des t�ches du collaborateur.
        lRequete = getBaseDonnees ().getOQLQuery ("select PROJET from owep.modele.execution.MProjet PROJET where mId = $1") ;
        lRequete.bind (mProjet.getId ()) ;
        lResultat  = lRequete.execute () ;
        mProjet = (MProjet) lResultat.next () ;
        
        getBaseDonnees ().commit () ;
      }
      catch (Exception eException)
      {
        eException.printStackTrace () ;
        throw new ServletException (CConstante.EXC_TRAITEMENT) ;
      }
    }
  }

  /**
   * TODO Description de initialiserParametres.
   * @throws ServletException
   * @see owep.controle.CControleurBase#initialiserParametres()
   */
  
  public void initialiserParametres () throws ServletException
  {
//  Projet ouvert par l'utilisateur.
    //mIteration      = (MIteration) getRequete ().getSession ().getAttribute (CConstante.SES_ITERATION) ;
    Session    lSession   = (Session) getRequete ().getSession ().getAttribute (CConstante.SES_SESSION) ;
    mIteration = lSession.getIteration () ;
    MProjet lProjet = mIteration.getProjet () ;
    
    // Ajout d'une t�che.
    if (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMITAJOUTER))
    {
      MTacheImprevue lTacheImprevue = new MTacheImprevue () ;
      MCollaborateur lCollaborateur = null;
      MActiviteImprevue      lActiviteImprevue = null ;
      
      int lIdCollaborateur    = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTECOLLABORATEURS)) ;
      int lIdActiviteImprevue = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTEACTIVITESIMPREVUES)) ;
      
      // Recherche du collaborateur affect� � la t�che impr�vue
      for (int i = 0 ; i < lProjet.getNbCollaborateurs () ; i ++) 
      {
        if (lProjet.getCollaborateur (i).getId () == lIdCollaborateur)
        {
          lCollaborateur = lProjet.getCollaborateur (i) ;
        }  
      }  
      
      // recherche de l'activit� impr�vue
      for (int i = 0 ; i <  lProjet.getNbActivitesImprevues () ; i++)
      {
        if (lProjet.getActiviteImprevue(i).getId () == lIdActiviteImprevue)
        {
          lActiviteImprevue = lProjet.getActiviteImprevue (i) ;
        }
      }  
      
      VTransfert.transferer (getRequete (), mIteration, CConstante.PAR_ARBREITERATION) ;
      VTransfert.transferer (getRequete (), lTacheImprevue, CConstante.PAR_ARBRETACHESIMPREVUES) ;
      
      // Met � jour le mod�le.
      lTacheImprevue.setIteration (mIteration) ;
      lTacheImprevue.setCollaborateur (lCollaborateur) ;
      lTacheImprevue.setActiviteImprevue (lActiviteImprevue) ;
      mIteration.addTacheImprevue (lTacheImprevue) ;
      lCollaborateur.addTacheImprevue (lTacheImprevue) ;
      lActiviteImprevue.addTacheImprevue (lTacheImprevue) ;
    }
    //  Modification d'une t�che si on la modifie directement ou si on ajoute, modifie ou supprime un artefact.
    else if ((VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMITMODIFIER)) ||
      (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMITAJOUTER_ARTSORTIES)) ||
      (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMITMODIFIER_ARTSORTIES)) ||
      (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMITSUPPRIMER_ARTSORTIES)))
    {
      MTacheImprevue lTacheImprevueTmp    = new MTacheImprevue () ;
      
      MCollaborateur lCollaborateur = null ;
      MActiviteImprevue      lActiviteImprevue = null ;
      
      int lIdCollaborateur    = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTECOLLABORATEURS)) ;
      int lIdActiviteImprevue = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTEACTIVITESIMPREVUES)) ;
      
      // recherche du collaborateur
      for (int i = 0 ; i < lProjet.getNbCollaborateurs() ; i ++) 
      {
        if (lProjet.getCollaborateur (i).getId () == lIdCollaborateur)
        {
          lCollaborateur = lProjet.getCollaborateur (i) ;
        }  
      }  
      
      // recherche de l'activite impr�vue
      for (int i = 0; i < lProjet.getNbActivitesImprevues (); i ++)
      {
        if (lProjet.getActiviteImprevue (i).getId () == lIdActiviteImprevue)
        {
          lActiviteImprevue = lProjet.getActiviteImprevue (i) ;
        }
      }

      // Indice de la t�che et de l'artefact dans leur liste respective.
      int lIndiceTacheImprevue     = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTETACHESIMPREVUES)) ;
      
      VTransfert.transferer (getRequete (), mIteration, CConstante.PAR_ARBREITERATION) ;
      VTransfert.transferer (getRequete (), lTacheImprevueTmp, CConstante.PAR_ARBRETACHESIMPREVUES) ;
      
      // Met � jour le mod�le.
      // Remarque : On ne met pas � jour la liste des artefacts car l'activit� ne peut �tre
      // modifi�e si un artefact est pr�sent (cf. FIterationModif.jsp)
      MTacheImprevue lTacheImprevue = mIteration.getTacheImprevue (lIndiceTacheImprevue) ;
      lTacheImprevue.setNom (lTacheImprevueTmp.getNom ()) ;
      lTacheImprevue.setChargeInitiale (lTacheImprevueTmp.getChargeInitiale ()) ;
      lTacheImprevue.setDescription (lTacheImprevueTmp.getDescription ()) ;
      lTacheImprevue.setDateDebutPrevue (lTacheImprevueTmp.getDateDebutPrevue ()) ;
      lTacheImprevue.setDateFinPrevue (lTacheImprevueTmp.getDateDebutPrevue ()) ;
      
      lTacheImprevue.getCollaborateur ().supprimerTacheImprevue (lTacheImprevue) ;
      lTacheImprevue.setCollaborateur (lCollaborateur) ;
      lCollaborateur.addTacheImprevue (lTacheImprevue) ;
      lTacheImprevue.getActiviteImprevue ().supprimerTacheImprevue (lTacheImprevue) ;
      lTacheImprevue.setActiviteImprevue (lActiviteImprevue) ;
      lActiviteImprevue.addTacheImprevue (lTacheImprevue) ;
    }
    
    // Supprimer une t�che.
    else if (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMITSUPPRIMER))
    {
      // Indice de la t�che et de l'artefact dans leur liste respective.
      int lIndiceTacheImprevue     = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTETACHESIMPREVUES)) ;
      
      VTransfert.transferer (getRequete (), mIteration, CConstante.PAR_ARBREITERATION) ;
      MTacheImprevue lTacheImprevue = mIteration.getTacheImprevue (lIndiceTacheImprevue) ;
      
      // Met � jour le mod�le.
      mIteration.supprimerTacheImprevue (lIndiceTacheImprevue) ;
      lTacheImprevue.getCollaborateur ().supprimerTacheImprevue (lTacheImprevue) ;
      lTacheImprevue.getActiviteImprevue ().supprimerTacheImprevue (lTacheImprevue) ;
      
      // Supprime la liste des artefacts en entr�es.
      for (int i = 0; i < lTacheImprevue.getNbArtefactsImprevuesEntrees (); i ++)
      {
        MArtefactImprevue lArtefactImprevueEntree = lTacheImprevue.getArtefactImprevueEntree (i) ;
        lTacheImprevue.supprimerArtefactImprevueEntree (i) ;
        lArtefactImprevueEntree.setTacheImprevueEntree (null) ;
      }
      // Supprime la liste des artefacts en sorties.
      for (int i = 0; i < lTacheImprevue.getNbArtefactsImprevuesSorties (); i ++)
      {
        MArtefactImprevue lArtefactImprevueSortie = lTacheImprevue.getArtefactImprevueSortie (i) ;
        
        lTacheImprevue.supprimerArtefactImprevueSortie (i) ;
        lArtefactImprevueSortie.setTacheImprevueSortie (null) ;
        lArtefactImprevueSortie.getTacheImprevueEntree ().supprimerArtefactImprevueEntree (lArtefactImprevueSortie) ;
        lArtefactImprevueSortie.setTacheImprevueEntree (null) ;
        lArtefactImprevueSortie.getResponsable ().supprimerArtefactImprevue (lArtefactImprevueSortie) ;
        lArtefactImprevueSortie.setResponsable (null) ;
        lArtefactImprevueSortie.getProjet ().supprimerArtefactImprevue (lArtefactImprevueSortie) ;
        lArtefactImprevueSortie.setProjet (null) ;
      }
    }
    //  Ajout d'un artefact en sortie.
    if (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMITAJOUTER_ARTSORTIES))
    {
      MArtefactImprevue lArtefactImprevueSortie = new MArtefactImprevue () ;
      VTransfert.transferer (getRequete (), lArtefactImprevueSortie, CConstante.PAR_ARBREARTEFACTSORTIES) ;
      
      // Indice de la t�che et de l'artefact dans leur liste respective.
      int lIndiceTacheImprevue = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTETACHESIMPREVUES)) ;
      int lIndiceResponsable   = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTERESPONSABLES)) ;
      
      MTacheImprevue    lTacheImprevue    = mIteration.getTacheImprevue (lIndiceTacheImprevue) ;
      MActiviteImprevue lActiviteImprevue = lTacheImprevue.getActiviteImprevue () ;
      MCollaborateur lResponsable = lProjet.getCollaborateur (lIndiceResponsable) ;
      
      // Mise � jour du mod�le.
      lArtefactImprevueSortie.setTacheImprevueSortie (lTacheImprevue) ;
      lTacheImprevue.addArtefactImprevueSortie (lArtefactImprevueSortie) ;
      lArtefactImprevueSortie.setProjet (lProjet) ;
      lProjet.addArtefactImprevue (lArtefactImprevueSortie) ;
      lArtefactImprevueSortie.setResponsable (lResponsable) ;
      lResponsable.addArtefactImprevue (lArtefactImprevueSortie) ;
    }
    // Modification d'un artefact.
    else if (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMITMODIFIER_ARTSORTIES))
    {
      // Indice de la t�che et de l'artefact dans leur liste respective.
      int lIndiceTacheImprevue     = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTETACHESIMPREVUES)) ;
      int lIndiceArtImprevueSortie = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTEARTEFACTSSORTIES)) ;
      int lIndiceResponsable = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTERESPONSABLES)) ;
      
      MArtefactImprevue lArtefactImprevueSortieTmp = new MArtefactImprevue () ;
      MArtefactImprevue lArtefactImprevueSortie = mIteration.getTacheImprevue (lIndiceTacheImprevue).getArtefactImprevueSortie (lIndiceArtImprevueSortie) ;
      
      VTransfert.transferer (getRequete (), lArtefactImprevueSortieTmp, CConstante.PAR_ARBREARTEFACTSORTIES) ;
      
      MTacheImprevue         lTacheImprevue       = mIteration.getTacheImprevue (lIndiceTacheImprevue) ;
      MActiviteImprevue      lActiviteImprevue    = lTacheImprevue.getActiviteImprevue () ;
      MCollaborateur lResponsable = lProjet.getCollaborateur (lIndiceResponsable);
      
      lArtefactImprevueSortie.setNom (lArtefactImprevueSortieTmp.getNom ()) ;
      lArtefactImprevueSortie.setDescription (lArtefactImprevueSortieTmp.getDescription ()) ;
      lArtefactImprevueSortie.setResponsable (lResponsable) ;
      
      // Mise � jour du mod�le.
      lArtefactImprevueSortie.getTacheImprevueSortie ().supprimerArtefactImprevueSortie (lArtefactImprevueSortie) ;
      lArtefactImprevueSortie.setTacheImprevueSortie (lTacheImprevue) ;
      lTacheImprevue.addArtefactImprevueSortie (lArtefactImprevueSortie) ;
      lArtefactImprevueSortie.getResponsable ().supprimerArtefactImprevue (lArtefactImprevueSortie) ;
      lArtefactImprevueSortie.setResponsable (lResponsable) ;
      lResponsable.addArtefactImprevue (lArtefactImprevueSortie) ;
    }
    // Supprimer un artefact en sortie.
    else if (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMITSUPPRIMER_ARTSORTIES))
    {
      // Indice de la t�che et de l'artefact dans leur liste respective.
      int lIndiceTacheImprevue     = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTETACHESIMPREVUES)) ;
      int lIndiceArtImprevueSortie = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTEARTEFACTSSORTIES)) ;
      
      MArtefactImprevue lArtefactImprevueSortie = mIteration.getTacheImprevue (lIndiceTacheImprevue).getArtefactImprevueSortie (lIndiceArtImprevueSortie) ;
      
      // Mise � jour du mod�le.
      lArtefactImprevueSortie.getTacheImprevueSortie ().supprimerArtefactImprevueSortie (lArtefactImprevueSortie) ;
      lArtefactImprevueSortie.setTacheImprevueSortie (null) ;
      if (lArtefactImprevueSortie.getTacheImprevueEntree () != null)
      {
        lArtefactImprevueSortie.getTacheImprevueEntree ().supprimerArtefactImprevueEntree (lArtefactImprevueSortie) ;
        lArtefactImprevueSortie.setTacheImprevueEntree (null) ;
      }
      lArtefactImprevueSortie.getResponsable ().supprimerArtefactImprevue (lArtefactImprevueSortie) ;
      lArtefactImprevueSortie.setResponsable (null) ;
      lArtefactImprevueSortie.getProjet ().supprimerArtefactImprevue (lArtefactImprevueSortie) ;
      lArtefactImprevueSortie.setProjet (null) ;
    }
    //  Ajouter un artefact en entr�e
    else if (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMITAJOUTER_ARTENTREES))
    {
     
      int lIndiceTacheImprevue = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTETACHESIMPREVUES)) ;
      int lIdArtImprevueEntree = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTEARTEFACTSPOSSIBLES)) ;
      
      MTacheImprevue    lTacheImprevue          = mIteration.getTacheImprevue (lIndiceTacheImprevue) ;
      MActiviteImprevue lActiviteImprevue = lTacheImprevue.getActiviteImprevue () ;
      MArtefactImprevue lArtImprevueEntree = null;
      
      for (int i = 0; i < mIteration.getNbTachesImprevues (); i++)
      {
        MTacheImprevue lTacheImp = mIteration.getTacheImprevue (i) ;
        for (int j = 0; j < lTacheImp.getNbArtefactsImprevuesSorties (); j++)
        {
          if (lTacheImp.getArtefactImprevueSortie (j).getId () == lIdArtImprevueEntree)
          {
            lArtImprevueEntree = lTacheImp.getArtefactImprevueSortie (j);
          }
        }
      }
      
      lTacheImprevue.addArtefactImprevueEntrees (lArtImprevueEntree) ;
      lArtImprevueEntree.setTacheImprevueEntree (lTacheImprevue) ;
    }
    // Supprimer un artefact en entr�e
    else if (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMITSUPPRIMER_ARTENTREES)) 
    {
      int lIndiceTacheImprevue     = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTETACHESIMPREVUES)) ;
      int lIdArtImprevueEntree = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTEARTEFACTSENTREES)) ;
      
      for (int i = 0; i < mIteration.getTacheImprevue (lIndiceTacheImprevue).getNbArtefactsImprevuesEntrees (); i++)
      {
        MArtefactImprevue lArtImprevueEntTmp =  mIteration.getTacheImprevue (lIndiceTacheImprevue).getArtefactImprevueEntree (i) ;
        if (lArtImprevueEntTmp.getId () == lIdArtImprevueEntree) 
        {
          mIteration.getTacheImprevue (lIndiceTacheImprevue).supprimerArtefactImprevueEntree (i) ;
          lArtImprevueEntTmp.setTacheImprevueEntree (null) ;
        }
      }
    }
    //  Validation de l'it�ration.
    if (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMIT))
    {
      VTransfert.transferer (getRequete (), mIteration, CConstante.PAR_ARBREITERATION) ;
    }
  }

  /**
   * TODO Description de traiter.
   * @return
   * @throws ServletException
   * @see owep.controle.CControleurBase#traiter()
   */
  
  public String traiter () throws ServletException
  {
//  Si l'it�ration est toujours en cours de modification.
    if (! VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMIT))
    {
      // Transmet les donn�es � la JSP d'affichage.
      return "..\\JSP\\Processus\\TTacheImprevue.jsp" ;
    }
    else
    {
    Connection lConnection = null ;
    try
    {
      DriverManager.registerDriver (new Driver ()) ;
      lConnection = DriverManager.getConnection ("jdbc:mysql://localhost/owep", LocalisateurIdentifiant.LID_BDUSER, LocalisateurIdentifiant.LID_BDPASS) ;
      lConnection.setAutoCommit(false);
      
        mIteration.update (lConnection) ;
      
      // Mise � jour de toutes les t�ches dans la BD.
      for (int i = 0; i < mIteration.getNbTachesImprevues (); i++)
      {
        MTacheImprevue lTacheImprevue = mIteration.getTacheImprevue (i) ;
        
        if (lTacheImprevue.getId () == 0)
        {
          lTacheImprevue.create (lConnection) ;
        }
        else
        {
          lTacheImprevue.update (lConnection) ;
        }
      }
        
      // Mise � jour de tous les artefacts et les conditions dans la BD.
      for (int i = 0; i < mIteration.getNbTachesImprevues (); i++)
      {
        MTacheImprevue lTacheImprevue = mIteration.getTacheImprevue (i) ;
        
        // Mise � jour des artefacts en sorties de la tache
        for (int j = 0; j < lTacheImprevue.getNbArtefactsImprevuesSorties (); j ++)
        {
          MArtefactImprevue lArtefactImprevue = lTacheImprevue.getArtefactImprevueSortie (j) ;
          if (lArtefactImprevue.getId () == 0)
          {
            lArtefactImprevue.create (lConnection) ;
          }
          else
          {
            lArtefactImprevue.update (lConnection) ;
          }
        }
        
        // Mise � jour de tous les artefacts en entr�es dans la BD.
        for (int j = 0; j < lTacheImprevue.getNbArtefactsImprevuesEntrees (); j ++)
        {
          MArtefactImprevue lArtefactImprevue = lTacheImprevue.getArtefactImprevueEntree (j) ;
          if (lArtefactImprevue.getId () == 0)
          {
            lArtefactImprevue.create (lConnection) ;
          }
          else
          {
            lArtefactImprevue.update (lConnection) ;
          }
        }
      }

      lConnection.commit () ;
      
      
      
      
      Session lSession ;
      lSession = (Session) getRequete ().getSession ().getAttribute (CConstante.SES_SESSION) ;
      mProjet  = lSession.getProjet () ;
      int mIdProjet = mProjet.getId ();
      OQLQuery lRequete ; // Requ�te � r�aliser sur la base
      QueryResults lResultat ; // R�sultat de la requ�te sur la base
      //MProjet lProjet ; // Projet � ouvrir
      getBaseDonnees ().begin () ;
      // Cherche le projet � ouvrir
      lRequete = getBaseDonnees ()
        .getOQLQuery ("select PROJET from owep.modele.execution.MProjet PROJET where mId = $1") ;
      lRequete.bind (mIdProjet) ;
      lResultat = lRequete.execute () ;

      mProjet = (MProjet) lResultat.next () ;

      getBaseDonnees ().commit () ;
      
      
      // Enregistre le projet � ouvrir dans la session
      getSession ().ouvrirProjet (mProjet) ;
      
      return "..\\JSP\\Processus\\TTacheImprevue.jsp" ;
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
        lConnection.close () ;
      }
      catch (SQLException eException)
      {
        eException.printStackTrace () ;
        throw new ServletException (CConstante.EXC_DECONNEXION) ;
      } 
    }
    }
  }
}
