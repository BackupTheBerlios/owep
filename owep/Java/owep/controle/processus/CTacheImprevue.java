package owep.controle.processus;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.servlet.ServletException;
import org.exolab.castor.jdo.ClassNotPersistenceCapableException;
import org.exolab.castor.jdo.DuplicateIdentityException;
import org.exolab.castor.jdo.OQLQuery;
import org.exolab.castor.jdo.PersistenceException;
import org.exolab.castor.jdo.QueryResults;
import org.exolab.castor.jdo.TransactionAbortedException;
import org.exolab.castor.jdo.TransactionNotInProgressException;
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
      getRequete().setAttribute(CConstante.PAR_PROJET, mProjet);
      
      // R�cup�re l'it�ration en cours.
      int lIdIterationCours = mProjet.getIterationEnCours ().getId () ;
      lRequete = getBaseDonnees ().getOQLQuery ("select ITERATION from owep.modele.execution.MIteration ITERATION where mId = $1") ;
      lRequete.bind (lIdIterationCours) ;
      lResultat  = lRequete.execute () ;
      mIteration = (MIteration) lResultat.next () ;
      getRequete().setAttribute (CConstante.PAR_ITERATION, mIteration);
    }
    catch (Exception eException)
    {
      eException.printStackTrace () ;
      throw new ServletException (CConstante.EXC_TRAITEMENT) ;
    }
  }

  /**
   * Cette m�thode permet d'initialiser leparam�tres suites aux formulaires de saisie.
   * @throws ServletException
   * @see owep.controle.CControleurBase#initialiserParametres()
   */
  
  public void initialiserParametres () throws ServletException
  {
    Session          lSession ;  // Session actuelle de l'utilisateur.
    OQLQuery         lRequete ;  // Requ�te � r�aliser sur la base
    QueryResults     lResultat ; // R�sultat de la requ�te sur la base
    
    // Ajout d'une t�che.
    if (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMITAJOUTER))
    {
      boolean trouve = false ;
      MTacheImprevue lTacheImprevue = new MTacheImprevue () ;
      MCollaborateur lCollaborateur = null;
      MActiviteImprevue      lActiviteImprevue = null ;
      
      // R�cup�ration de l'identifiant du collaborateur et de l'activit� impr�vue.
      int lIdCollaborateur    = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTECOLLABORATEURS)) ;
      int lIdActiviteImprevue = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTEACTIVITESIMPREVUES)) ;
      
      // Recherche du collaborateur affect� � la t�che impr�vue
      for (int i = 0 ; !trouve && i < mProjet.getNbCollaborateurs () ; i ++) 
      {
        if (mProjet.getCollaborateur (i).getId () == lIdCollaborateur)
        {
          lCollaborateur = mProjet.getCollaborateur (i) ;
          trouve = true ;
        }  
      }  
      
      // recherche de l'activit� impr�vue
      trouve = false ;
      for (int i = 0 ;!trouve &&  i <  mProjet.getNbActivitesImprevues () ; i++)
      {
        if (mProjet.getActiviteImprevue(i).getId () == lIdActiviteImprevue)
        {
          lActiviteImprevue = mProjet.getActiviteImprevue (i) ;
          trouve = true ;
        }
      }  
      // R�cup�ration de la nouvelle t�che impr�vue.
      VTransfert.transferer (getRequete (), lTacheImprevue, CConstante.PAR_ARBRETACHESIMPREVUES) ;
      
      // Met � jour le mod�le.
      lTacheImprevue.setIteration (mIteration) ;
      lTacheImprevue.setCollaborateur (lCollaborateur) ;
      lTacheImprevue.setActiviteImprevue (lActiviteImprevue) ;
      mIteration.addTacheImprevue (lTacheImprevue) ;
      lCollaborateur.addTacheImprevue (lTacheImprevue) ;
      lActiviteImprevue.addTacheImprevue (lTacheImprevue) ;
      
      try
      {
        // insertion de la nouvelle tache dans la base de donn�es.
        getBaseDonnees ().create (lTacheImprevue) ; 
      }
      catch (ClassNotPersistenceCapableException e)
      {
        e.printStackTrace () ;
        throw new ServletException (CConstante.EXC_TRAITEMENT) ;
      }
      catch (DuplicateIdentityException e)
      {
        e.printStackTrace () ;
        throw new ServletException (CConstante.EXC_TRAITEMENT) ;
      }
      catch (TransactionNotInProgressException e)
      {
        e.printStackTrace () ;
        throw new ServletException (CConstante.EXC_TRAITEMENT) ;
      }
      catch (PersistenceException e)
      {
        e.printStackTrace () ;
        throw new ServletException (CConstante.EXC_TRAITEMENT) ;
      }
    }
    //  Modification d'une t�che si on la modifie directement ou si on ajoute, modifie ou supprime un artefact.
    else if ((VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMITMODIFIER)) ||
      (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMITAJOUTER_ARTSORTIES)) ||
      (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMITMODIFIER_ARTSORTIES)) ||
      (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMITSUPPRIMER_ARTSORTIES)))
    {
      boolean trouve = false ;
      MTacheImprevue lTacheImprevueTmp    = new MTacheImprevue () ;
      MCollaborateur lCollaborateur = null ;
      MActiviteImprevue      lActiviteImprevue = null ;
      
      // R�cup�ration de l'identifiant du collaborateur et celui de la t�che impr�vue.
      int lIdCollaborateur    = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTECOLLABORATEURS)) ;
      int lIdActiviteImprevue = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTEACTIVITESIMPREVUES)) ;
      
      // recherche du collaborateur
      for (int i = 0 ; !trouve && i < mProjet.getNbCollaborateurs() ; i ++) 
      {
        if (mProjet.getCollaborateur (i).getId () == lIdCollaborateur)
        {
          lCollaborateur = mProjet.getCollaborateur (i) ;
          trouve = true ;
        }  
      }  
      
      // recherche de l'activite impr�vue
      trouve = false ;
      for (int i = 0; !trouve && i < mProjet.getNbActivitesImprevues (); i ++)
      {
        if (mProjet.getActiviteImprevue (i).getId () == lIdActiviteImprevue)
        {
          lActiviteImprevue = mProjet.getActiviteImprevue (i) ;
          trouve = true ;
        }
      }

      // Indice de la t�che et de l'artefact dans leur liste respective.
      int lIndiceTacheImprevue     = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTETACHESIMPREVUES)) ;
      
      VTransfert.transferer (getRequete (), lTacheImprevueTmp, CConstante.PAR_ARBRETACHESIMPREVUES) ;
      
      try
      {
        // R�cup�ration de l'identifiant de la t�che impr�vue que l'on souhaite modifier.
        int lIdTacheImprevue = mIteration.getTacheImprevue (lIndiceTacheImprevue).getId () ;
        // On r�cup�re la tache impr�vue que l'on souhaite modifier dans la base.
        lRequete = getBaseDonnees ().getOQLQuery ("select TACHEIMPREVUE from owep.modele.execution.MTacheImprevue TACHEIMPREVUE where mId = $1") ;
        lRequete.bind (lIdTacheImprevue) ;
        lResultat  = lRequete.execute () ;
        MTacheImprevue lTacheImprevue = (MTacheImprevue) lResultat.next () ;
        
        // Mise � jour de la t�che impr�vue.
        lTacheImprevue.setNom (lTacheImprevueTmp.getNom ()) ;
        lTacheImprevue.setChargeInitiale (lTacheImprevueTmp.getChargeInitiale ()) ;
        lTacheImprevue.setDescription (lTacheImprevueTmp.getDescription ()) ;
        lTacheImprevue.setDateDebutPrevue (lTacheImprevueTmp.getDateDebutPrevue ()) ;
        lTacheImprevue.setDateFinPrevue (lTacheImprevueTmp.getDateDebutPrevue ()) ;
        
        // Mise � jour du mod�le.
        lTacheImprevue.getCollaborateur ().supprimerTacheImprevue (lTacheImprevue) ;
        lTacheImprevue.setCollaborateur (lCollaborateur) ;
        lCollaborateur.addTacheImprevue (lTacheImprevue) ;
        lTacheImprevue.getActiviteImprevue ().supprimerTacheImprevue (lTacheImprevue) ;
        lTacheImprevue.setActiviteImprevue (lActiviteImprevue) ;
        lActiviteImprevue.addTacheImprevue (lTacheImprevue) ;

      }
      catch (ClassNotPersistenceCapableException e)
      {
        e.printStackTrace () ;
        throw new ServletException (CConstante.EXC_TRAITEMENT) ;
      }
      catch (TransactionNotInProgressException e)
      {
        e.printStackTrace () ;
        throw new ServletException (CConstante.EXC_TRAITEMENT) ;
      }
      catch (PersistenceException e)
      {
        e.printStackTrace () ;
        throw new ServletException (CConstante.EXC_TRAITEMENT) ;
      }
    }
    
    // TODO : Supprimer une t�che.
    else if (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMITSUPPRIMER))
    {
      // Indice de la t�che et de l'artefact dans leur liste respective.
      int lIndiceTacheImprevue     = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTETACHESIMPREVUES)) ;
      
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
      MCollaborateur lResponsable = mProjet.getCollaborateur (lIndiceResponsable) ;
      
      // Mise � jour du mod�le.
      lArtefactImprevueSortie.setTacheImprevueSortie (lTacheImprevue) ;
      lTacheImprevue.addArtefactImprevueSortie (lArtefactImprevueSortie) ;
      lArtefactImprevueSortie.setProjet (mProjet) ;
      mProjet.addArtefactImprevue (lArtefactImprevueSortie) ;
      lArtefactImprevueSortie.setResponsable (lResponsable) ;
      lResponsable.addArtefactImprevue (lArtefactImprevueSortie) ;
      
      try
      {
        // insertion de l'artefact impr�vue en sortie de la t�che dans la bd.
        getBaseDonnees ().create (lArtefactImprevueSortie) ;
      }
      catch (ClassNotPersistenceCapableException e)
      {
        e.printStackTrace () ;
        throw new ServletException (CConstante.EXC_TRAITEMENT) ;
      }
      catch (DuplicateIdentityException e)
      {
        e.printStackTrace () ;
        throw new ServletException (CConstante.EXC_TRAITEMENT) ;
      }
      catch (TransactionNotInProgressException e)
      {
        e.printStackTrace () ;
        throw new ServletException (CConstante.EXC_TRAITEMENT) ;
      }
      catch (PersistenceException e)
      {
        e.printStackTrace () ;
        throw new ServletException (CConstante.EXC_TRAITEMENT) ;
      }
    }
    // Modification d'un artefact.
    else if (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMITMODIFIER_ARTSORTIES))
    {
      // Indice de la t�che et de l'artefact dans leur liste respective.
      int lIndiceTacheImprevue     = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTETACHESIMPREVUES)) ;
      //int lIndiceArtImprevueSortie = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTEARTEFACTSSORTIES)) ;
      int lIdArtImprevueSortie = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTEARTEFACTSSORTIES)) ;
      int lIndiceResponsable = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTERESPONSABLES)) ;
      
      MArtefactImprevue lArtefactImprevueSortieTmp = new MArtefactImprevue () ;
      VTransfert.transferer (getRequete (), lArtefactImprevueSortieTmp, CConstante.PAR_ARBREARTEFACTSORTIES) ;
      
      try
      {
        lRequete = getBaseDonnees ().getOQLQuery ("select ARTEFACTIMPREVUE from owep.modele.execution.MArtefactImprevue ARTEFACTIMPREVUE where mId = $1") ;
        lRequete.bind (lIdArtImprevueSortie) ;
        lResultat  = lRequete.execute () ;
        MArtefactImprevue lArtefactImprevueSortie = (MArtefactImprevue) lResultat.next () ;
        
        MTacheImprevue         lTacheImprevue       = mIteration.getTacheImprevue (lIndiceTacheImprevue) ;
        MCollaborateur lResponsable = mProjet.getCollaborateur (lIndiceResponsable);
        
        // Mise � jour de l'artefact.
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
      catch (PersistenceException e)
      {
        e.printStackTrace () ;
        throw new ServletException (CConstante.EXC_TRAITEMENT) ;
      }
      
      
      
    }
    // TODO : Supprimer un artefact en sortie.
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
      
      try
      {
        lRequete = getBaseDonnees ().getOQLQuery ("select ARTEFACTIMPREVUE from owep.modele.execution.MArtefactImprevue ARTEFACTIMPREVUE where mId = $1") ;
        lRequete.bind (lIdArtImprevueEntree) ;
        lResultat  = lRequete.execute () ;
        MArtefactImprevue lArtImprevueEntree = (MArtefactImprevue) lResultat.next () ;
        
        lTacheImprevue.addArtefactImprevueEntrees (lArtImprevueEntree) ;
        lArtImprevueEntree.setTacheImprevueEntree (lTacheImprevue) ;
      }
      catch (PersistenceException e)
      {
        e.printStackTrace () ;
        throw new ServletException (CConstante.EXC_TRAITEMENT) ;
      }
      
    }
    // Supprimer un artefact en entr�e
    else if (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMITSUPPRIMER_ARTENTREES)) 
    {
      int lIndiceTacheImprevue     = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTETACHESIMPREVUES)) ;
      int lIdArtImprevueEntree = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTEARTEFACTSENTREES)) ;
      
      try
      {
        lRequete = getBaseDonnees ().getOQLQuery ("select ARTEFACTIMPREVUE from owep.modele.execution.MArtefactImprevue ARTEFACTIMPREVUE where mId = $1") ;
        lRequete.bind (lIdArtImprevueEntree) ;
        lResultat  = lRequete.execute () ;
        MArtefactImprevue lArtImprevueEntree = (MArtefactImprevue) lResultat.next () ;
        
        mIteration.getTacheImprevue(lIndiceTacheImprevue).supprimerArtefactImprevueEntree(lArtImprevueEntree) ;
        lArtImprevueEntree.setTacheImprevueEntree (null) ;
      }
      catch (PersistenceException e)
      {
        e.printStackTrace () ;
        throw new ServletException (CConstante.EXC_TRAITEMENT) ;
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
    /*if (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMIT))
    {
      try
      {
        getBaseDonnees ().update (mIteration) ;
              
        // Mise � jour de toutes les t�ches dans la BD.
        for (int i = 0; i < mIteration.getNbTachesImprevues (); i++)
        {
          MTacheImprevue lTacheImprevue = mIteration.getTacheImprevue (i) ;
        
          if (lTacheImprevue.getId () == 0)
          {
            getBaseDonnees ().create (lTacheImprevue) ;
          }
          else
          {
            getBaseDonnees ().update (lTacheImprevue) ;
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
              getBaseDonnees ().create (lArtefactImprevue) ;
            }
            else
            {
              getBaseDonnees ().update (lArtefactImprevue) ;
            }
          }
        
          // Mise � jour de tous les artefacts en entr�es dans la BD.
          for (int j = 0; j < lTacheImprevue.getNbArtefactsImprevuesEntrees (); j ++)
          {
            MArtefactImprevue lArtefactImprevue = lTacheImprevue.getArtefactImprevueEntree (j) ;
            
            if (lArtefactImprevue.getId () == 0)
            {
              getBaseDonnees ().create (lArtefactImprevue) ;
            }
            else
            {
              getBaseDonnees ().update (lArtefactImprevue) ;
            }
          } 
        }
      
      }
      catch (Exception eException)
      {
        eException.printStackTrace () ;
        throw new ServletException (CConstante.EXC_TRAITEMENT) ;
      }
    }*/
    
    // Ferme la connexion � la base de donn�es.    
    try
    {
      getBaseDonnees ().commit () ;
      getBaseDonnees ().close () ;
      getRequete().setAttribute (CConstante.PAR_ITERATION, mIteration);
    }
    catch (PersistenceException e)
    {
      e.printStackTrace () ;
      throw new ServletException (CConstante.EXC_TRAITEMENT) ;
    }
    return "..\\JSP\\Processus\\TTacheImprevue.jsp" ;
  }
}
