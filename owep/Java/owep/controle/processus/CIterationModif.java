package owep.controle.processus ;


import javax.servlet.ServletException ;
import org.exolab.castor.jdo.ClassNotPersistenceCapableException;
import org.exolab.castor.jdo.DuplicateIdentityException;
import org.exolab.castor.jdo.OQLQuery ;
import org.exolab.castor.jdo.PersistenceException;
import org.exolab.castor.jdo.QueryResults ;
import org.exolab.castor.jdo.TransactionNotInProgressException;
import owep.controle.CConstante ;
import owep.controle.CControleurBase ;
import owep.infrastructure.Session ;
import owep.modele.execution.MArtefact ;
import owep.modele.execution.MCollaborateur ;
import owep.modele.execution.MCondition;
import owep.modele.execution.MIteration ;
import owep.modele.execution.MProjet ;
import owep.modele.execution.MTache ;
import owep.modele.processus.MActivite ;
import owep.modele.processus.MComposant ;
import owep.modele.processus.MDefinitionTravail ;
import owep.modele.processus.MProcessus ;
import owep.modele.processus.MProduit ;
import owep.vue.transfert.VTransfert ;


/**
 * Controleur pour la modification d'une it�ration (ajout de t�ches, d'artefact, ...) conform�ment
 * � un processus.
 */
public class CIterationModif extends CControleurBase
{
  private MProjet    mProjet ;    // Projet actuellement ouvert par l'utilisateur.
  private MIteration mIteration; // It�ration modifi�e ou ajout�e.
  
  
  /**
   * R�cup�re les donn�es n�cessaire au controleur dans la base de donn�es. 
   * @throws ServletException Si une erreur survient durant la connexion
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
      mProjet = (MProjet)lResultat.next () ;
      
      getRequete ().setAttribute(CConstante.PAR_PROJET, mProjet);
      
      if ((VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_VIDE)) &&
          (getRequete ().getParameter (CConstante.PAR_MODIFIER) == null))
      {
//        Initialise une nouvelle it�ration.
        mIteration = new MIteration () ;
        mIteration.setNom ("") ;
        mIteration.setNumero (mProjet.getNbIterations () + 1) ;
        mIteration.setProjet (mProjet) ;
        mProjet.addIteration(mIteration);

        try
        {
          // cr�ation de l'it�ration dans la base de donn�es.
          getBaseDonnees ().create (mIteration) ;
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
      
      int lIdIteration ;
      // si c'est une modification, r�cup�ration de l'identifiant de l'it�ration � modifier
      if (getRequete ().getParameter (CConstante.PAR_MODIFIER) != null)
      {
        lIdIteration = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_ITERATION)) ;
      }
      // sinon on r�cup�re l'identifiant de l'it�ration que l'on vient de rajouter dans la BD.
      else
      {
        lIdIteration = mIteration.getId () ;
      }
      
      lRequete = getBaseDonnees ().getOQLQuery ("select ITERATION from owep.modele.execution.MIteration ITERATION where mId = $1") ;
      lRequete.bind (lIdIteration) ;
      lResultat  = lRequete.execute () ;
      mIteration = (MIteration) lResultat.next () ;
      getRequete().getSession().setAttribute (CConstante.PAR_ITERATION, mIteration);

    }
    catch (Exception eException)
    {
      eException.printStackTrace () ;
      throw new ServletException (CConstante.EXC_TRAITEMENT) ;
    }
  }
  
  
  /**
   * R�cup�re les param�tres pass�s au controleur. 
   * @throws ServletException -
   */
  public void initialiserParametres () throws ServletException
  {
    Session          lSession ;  // Session actuelle de l'utilisateur.
    OQLQuery         lRequete ;  // Requ�te � r�aliser sur la base
    QueryResults     lResultat ; // R�sultat de la requ�te sur la base
    
    // Modification d'une it�ration.
    if (getRequete ().getParameter (CConstante.PAR_MODIFIER) != null)
    {
      // R�cup�re l'it�ration � modifier et la met dans la session.
      int lIdIteration = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_ITERATION)) ;
      
      try
      {
        lRequete = getBaseDonnees ().getOQLQuery ("select ITERATION from owep.modele.execution.MIteration ITERATION where mId = $1") ;
        lRequete.bind (lIdIteration) ;
        lResultat  = lRequete.execute () ;
        mIteration = (MIteration) lResultat.next () ;
      }
      catch (PersistenceException e)
      {
        e.printStackTrace () ;
        throw new ServletException (CConstante.EXC_TRAITEMENT) ;
      }
      
      getRequete ().getSession ().setAttribute (CConstante.PAR_ITERATION, mIteration) ;
    }
    //else
   // {
      // Projet ouvert par l'utilisateur.
      //mIteration      = (MIteration) getRequete ().getSession ().getAttribute (CConstante.SES_ITERATION) ;
      //MProjet lProjet = mIteration.getProjet () ;
      MProcessus lProcessus = mProjet.getProcessus () ; 
      
      // Ajout d'une t�che.
      if (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMITAJOUTER))
      {
        boolean trouve = false ;
        MTache lTache = new MTache () ;
        MCollaborateur lCollaborateur = null;
        MActivite      lActivite = null ;
        
        int lIdCollaborateur = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTECOLLABORATEURS)) ;
        int lIdActivite      = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTEACTIVITES)) ;
        
        // Recherche du collaborateur effectuant cette t�che.
        for (int i = 0 ; !trouve && i < mProjet.getNbCollaborateurs () ; i ++) 
        {
          if (mProjet.getCollaborateur (i).getId () == lIdCollaborateur)
          {
            lCollaborateur = mProjet.getCollaborateur (i) ;
            trouve = true ;
          }  
        }  

        // Recherche de l'activit� � laquelle est li�e la t�che
        trouve = false ;
        for (int i = 0 ;!trouve &&  i <  lProcessus.getNbComposants () ; i++)
        {
          MComposant lComposant = lProcessus.getComposant (i) ;
          for (int j = 0 ; !trouve && j < lComposant.getNbDefinitionsTravail (); j++)
          {
            MDefinitionTravail lDefTrav = lComposant.getDefinitionTravail (j) ;
            for (int k = 0 ; !trouve && k < lDefTrav.getNbActivites (); k++)
            {
              if (lDefTrav.getActivite(k).getId() == lIdActivite)
              {
                lActivite = lDefTrav.getActivite(k) ;
                trouve = true ;
              }  
            }
          }  
        }  
        
        if (mIteration.getNom() == "")
        {
          MIteration lIterationTmp = new MIteration ();
          // R�cup�ration des donn�es de l'it�ration ainsi que celle pour la t�che.
          VTransfert.transferer (getRequete (), lIterationTmp, CConstante.PAR_ARBREITERATION) ;  
          mIteration.setDateDebutPrevue (lIterationTmp.getDateDebutPrevue ());
          mIteration.setDateFinPrevue (lIterationTmp.getDateFinPrevue ());
          mIteration.setNom (lIterationTmp.getNom ());
        }
        
        VTransfert.transferer (getRequete (), lTache, CConstante.PAR_ARBRETACHES) ;

        // Met � jour le mod�le.
        lTache.setIteration (mIteration) ;
        lTache.setCollaborateur (lCollaborateur) ;
        lTache.setActivite (lActivite) ;
        mIteration.addTache (lTache) ;
        lCollaborateur.addTache (lTache) ;
        lActivite.addTache (lTache) ;
        
        try
        {
          // ajout de la t�che dans la base de donn�es.
          getBaseDonnees ().create (lTache);
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
      // Modification d'une t�che si on la modifie directement ou si on ajoute, modifie ou supprime un artefact.
      else if ((VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMITMODIFIER)) ||
        (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMITAJOUTER_ARTSORTIES)) ||
        (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMITMODIFIER_ARTSORTIES)) ||
        (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMITSUPPRIMER_ARTSORTIES)))
      {
        boolean trouve = false ;
        MTache lTacheTmp    = new MTache () ;
        MCollaborateur lCollaborateur = null ;
        MActivite      lActivite = null ;
        
        int lIdCollaborateur = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTECOLLABORATEURS)) ;
        int lIdActivite      = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTEACTIVITES)) ;
        
        // Recherche du collaborateur effectuant la t�che.
        for (int i = 0 ; !trouve && i < mProjet.getNbCollaborateurs() ; i ++) 
        {
          if (mProjet.getCollaborateur (i).getId () == lIdCollaborateur)
          {
            lCollaborateur = mProjet.getCollaborateur (i) ;
            trouve = true ;
          }  
        }  
        
        // Recherche de l'activit� � laquelle est li�e la t�che.
        trouve = false ;
        for (int i = 0 ; !trouve && i <  lProcessus.getNbComposants () ; i++)
        {
          MComposant lComposant = lProcessus.getComposant (i) ;
          for (int j = 0 ; j < lComposant.getNbDefinitionsTravail (); j++)
          {
            MDefinitionTravail lDefTrav = lComposant.getDefinitionTravail (j) ;
            for (int k = 0 ; k < lDefTrav.getNbActivites (); k++)
            {
              if (lDefTrav.getActivite(k).getId() == lIdActivite)
              {
                lActivite = lDefTrav.getActivite(k) ;
                trouve = true ;
              }  
            }
          }  
        }  

        // Indice de la t�che et de l'artefact dans leur liste respective.
        int lIndiceTache     = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTETACHES)) ;
        
        //VTransfert.transferer (getRequete (), mIteration, CConstante.PAR_ARBREITERATION) ;
        VTransfert.transferer (getRequete (), lTacheTmp, CConstante.PAR_ARBRETACHES) ;
        
        try
        {
          // R�cup�ration de l'identifiant de la t�che impr�vue que l'on souhaite modifier.
          int lIdTache = mIteration.getTache (lIndiceTache).getId () ;
          // On r�cup�re la tache impr�vue que l'on souhaite modifier dans la base.
          lRequete = getBaseDonnees ().getOQLQuery ("select TACHE from owep.modele.execution.MTache TACHE where mId = $1") ;
          lRequete.bind (lIdTache) ;
          lResultat  = lRequete.execute () ;
          MTache lTache = (MTache) lResultat.next () ;
          
          // Mise � jour de la t�che.
          lTache.setNom (lTacheTmp.getNom ()) ;
          lTache.setChargeInitiale (lTacheTmp.getChargeInitiale ()) ;
          lTache.setDescription (lTacheTmp.getDescription ()) ;
          lTache.setDateDebutPrevue (lTacheTmp.getDateDebutPrevue ()) ;
          lTache.setDateFinPrevue (lTacheTmp.getDateDebutPrevue ()) ;
          
          // Mise � jour du mod�le.
          lTache.getCollaborateur ().supprimerTache (lTache) ;
          lTache.setCollaborateur (lCollaborateur) ;
          lCollaborateur.addTache (lTache) ;
          lTache.getActivite ().supprimerTache (lTache) ;
          lTache.setActivite (lActivite) ;
          lActivite.addTache (lTache) ;

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
        int lIndiceTache     = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTETACHES)) ;
        
        VTransfert.transferer (getRequete (), mIteration, CConstante.PAR_ARBREITERATION) ;
        MTache lTache = mIteration.getTache (lIndiceTache) ;
        
        // Met � jour le mod�le.
        mIteration.supprimerTache (lIndiceTache) ;
        lTache.getCollaborateur ().supprimerTache (lTache) ;
        lTache.getActivite ().supprimerTache (lTache) ;
        
        // Supprime la liste des artefacts en entr�es.
        for (int i = 0; i < lTache.getNbArtefactsEntrees (); i ++)
        {
          MArtefact lArtefactEntree = lTache.getArtefactEntree (i) ;
          lTache.supprimerArtefactEntree (i) ;
          lArtefactEntree.setTacheEntree (null) ;
        }
        // Supprime la liste des artefacts en sorties.
        for (int i = 0; i < lTache.getNbArtefactsSorties (); i ++)
        {
          MArtefact lArtefactSortie = lTache.getArtefactSortie (i) ;
          
          lTache.supprimerArtefactSortie (i) ;
          lArtefactSortie.setTacheSortie (null) ;
          lArtefactSortie.getTacheEntree ().supprimerArtefactEntree (lArtefactSortie) ;
          lArtefactSortie.setTacheEntree (null) ;
          lArtefactSortie.getProduit ().supprimerArtefact (lArtefactSortie) ;
          lArtefactSortie.setProduit (null) ;
          lArtefactSortie.getResponsable ().supprimerArtefact (lArtefactSortie) ;
          lArtefactSortie.setResponsable (null) ;
          lArtefactSortie.getProjet ().supprimerArtefact (lArtefactSortie) ;
          lArtefactSortie.setProjet (null) ;
        }
        // Supprime les d�pendance de la t�che
        for (int i = 0; i < lTache.getNbConditions (); i++)
        {
          lTache.supprimerCondition (i) ;
        }
        
        // Suppression de toutes les d�pendances qu'il y avait avec cette t�che
        for (int i = 0; i < mIteration.getNbTaches (); i ++)
        {
          MTache lTacheTmp = mIteration.getTache (i) ;
          for (int j = lTacheTmp.getNbConditions () - 1; j != 0; j --)
          {
            MCondition lCondition = lTacheTmp.getCondition (j) ;
            if (lCondition.getTachePrecedente ().getId () == lTache.getId ())
            {
              lTacheTmp.supprimerCondition (j) ;
            }
          }
        }
      }
      
      // Ajout des d�pendances entre t�ches
      if (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMITAJOUTER_TACDEPEND)) 
      {
        MCondition lCondition = new MCondition () ;
        
        int lIndiceTache     = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTETACHES)) ;
        int lIndiceTachePre  = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTETACHESPOSSIBLES)) ;
        int lIndiceCondition = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTETACHESCONDITION)) ;
        
        MTache    lTache    = mIteration.getTache (lIndiceTache) ;
        MTache    lTachePre = mIteration.getTache (lIndiceTachePre) ;

        
        lCondition.setTache (lTache) ;
        lCondition.setTachePrecedente (lTachePre) ;
        // si l'utilisateur a choisi en cours
        if (lIndiceCondition == 0)
        {
          lCondition.setEtat (1) ;
        }
        // sinon il a choisi termin�
        else
        {
          lCondition.setEtat (3) ;
        }
        lTache.addCondition (lCondition) ;  
        
        try
        {
          // ajout de la condition dans la base de donn�es.
          getBaseDonnees ().create (lCondition) ;
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
      // TODO : Supprimer d�pendance entre t�che.
      else if (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMITSUPPRIMER_TACDEPEND))
      {
        int lIndiceTache    = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTETACHES)) ;
        int lIndiceTacheDep =  Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTETACHESDEPENDANTES)) ;
        
        MTache lTache = mIteration.getTache (lIndiceTache) ;
        lTache.supprimerCondition (lIndiceTacheDep) ;
      }
      
      // Ajout d'un artefact en sortie.
      if (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMITAJOUTER_ARTSORTIES))
      {
        MArtefact lArtefactSortie = new MArtefact () ;
        VTransfert.transferer (getRequete (), lArtefactSortie, CConstante.PAR_ARBREARTEFACTSORTIES) ;
        
        // Indice de la t�che et de l'artefact dans leur liste respective.
        int lIndiceTache       = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTETACHES)) ;
        int lIndiceProduit     = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTEPRODUITS)) ;
        int lIndiceResponsable = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTERESPONSABLES)) ;
        
        MTache         lTache       = mIteration.getTache (lIndiceTache) ;
        MActivite      lActivite    = lTache.getActivite () ;
        MProduit       lProduit     = lActivite.getProduitSortie (lIndiceProduit) ;
        MCollaborateur lResponsable = lProduit.getResponsable ().getCollaborateur (lIndiceResponsable) ;
        
        // Mise � jour du mod�le.
        lArtefactSortie.setTacheSortie (lTache) ;
        lTache.addArtefactSortie (lArtefactSortie) ;
        lArtefactSortie.setProjet (mProjet) ;
        mProjet.addArtefact (lArtefactSortie) ;
        lArtefactSortie.setProduit (lProduit) ;
        lProduit.addArtefact (lArtefactSortie) ;
        lArtefactSortie.setResponsable (lResponsable) ;
        lResponsable.addArtefact (lArtefactSortie) ;
        
        try
        {
          // ajout de l'artefact dans la base de donn�es.
          getBaseDonnees ().create (lArtefactSortie) ;
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
        int lIndiceTache     = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTETACHES)) ;
        int lIndiceArtSortie = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTEARTEFACTSSORTIES)) ;
        int lIndiceProduit     = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTEPRODUITS)) ;
        int lIndiceResponsable = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTERESPONSABLES)) ;
        
        
        int lIdArtefactSortie = mIteration.getTache (lIndiceTache).getArtefactSortie (lIndiceArtSortie).getId () ;
        
        MArtefact lArtefactSortieTmp = new MArtefact () ;
        VTransfert.transferer (getRequete (), lArtefactSortieTmp, CConstante.PAR_ARBREARTEFACTSORTIES) ;
        
        try
        {
          lRequete = getBaseDonnees ().getOQLQuery ("select ARTEFACT from owep.modele.execution.MArtefact ARTEFACT where mId = $1") ;
          lRequete.bind (lIdArtefactSortie) ;
          lResultat  = lRequete.execute () ;
          MArtefact lArtefactSortie = (MArtefact) lResultat.next () ;
          
          MTache         lTache       = mIteration.getTache (lIndiceTache) ;
          MActivite      lActivite    = lTache.getActivite () ;
          MProduit       lProduit     = lActivite.getProduitSortie (lIndiceProduit) ;
          MCollaborateur lResponsable = lProduit.getResponsable ().getCollaborateur (lIndiceResponsable) ;
          
          // Mise � jour de l'artefact.
          lArtefactSortie.setNom (lArtefactSortieTmp.getNom ()) ;
          lArtefactSortie.setDescription (lArtefactSortieTmp.getDescription ()) ;
          lArtefactSortie.setProduit (lActivite.getProduitSortie (lIndiceProduit)) ;
          lArtefactSortie.setResponsable (lProduit.getResponsable ().getCollaborateur (lIndiceResponsable)) ;
          
          // Mise � jour du mod�le.
          lArtefactSortie.getTacheSortie ().supprimerArtefactSortie (lArtefactSortie) ;
          lArtefactSortie.setTacheSortie (lTache) ;
          lTache.addArtefactSortie (lArtefactSortie) ;
          lArtefactSortie.getProduit ().supprimerArtefact (lArtefactSortie) ;
          lArtefactSortie.setProduit (lProduit) ;
          lProduit.addArtefact (lArtefactSortie) ;
          lArtefactSortie.getResponsable ().supprimerArtefact (lArtefactSortie) ;
          lArtefactSortie.setResponsable (lResponsable) ;
          lResponsable.addArtefact (lArtefactSortie) ;
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
        int lIndiceTache     = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTETACHES)) ;
        int lIndiceArtSortie = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTEARTEFACTSSORTIES)) ;
        
        MArtefact lArtefactSortie = mIteration.getTache (lIndiceTache).getArtefactSortie (lIndiceArtSortie) ;
        
        // Mise � jour du mod�le.
        lArtefactSortie.getTacheSortie ().supprimerArtefactSortie (lArtefactSortie) ;
        lArtefactSortie.setTacheSortie (null) ;
        if (lArtefactSortie.getTacheEntree () != null)
        {
          lArtefactSortie.getTacheEntree ().supprimerArtefactEntree (lArtefactSortie) ;
          lArtefactSortie.setTacheEntree (null) ;
        }
        lArtefactSortie.getProduit ().supprimerArtefact (lArtefactSortie) ;
        lArtefactSortie.setProduit (null) ;
        lArtefactSortie.getResponsable ().supprimerArtefact (lArtefactSortie) ;
        lArtefactSortie.setResponsable (null) ;
        lArtefactSortie.getProjet ().supprimerArtefact (lArtefactSortie) ;
        lArtefactSortie.setProjet (null) ;
      }
      // Ajouter un artefact en entr�e
      else if (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMITAJOUTER_ARTENTREES))
      {
       
        int lIndiceTache = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTETACHES)) ;
        int lIdArtEntree = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTEARTEFACTSPOSSIBLES)) ;
        
        MTache    lTache          = mIteration.getTache (lIndiceTache) ;
        MActivite lActivite = lTache.getActivite () ;
        
        try
        {
          lRequete = getBaseDonnees ().getOQLQuery ("select ARTEFACT from owep.modele.execution.MArtefact ARTEFACT where mId = $1") ;
          lRequete.bind (lIdArtEntree) ;
          lResultat  = lRequete.execute () ;
          MArtefact lArtEntree = (MArtefact) lResultat.next () ;
          
          lTache.addArtefactEntrees (lArtEntree) ;
          lArtEntree.setTacheEntree (lTache) ;
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
        int lIndiceTache     = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTETACHES)) ;
        int lIdArtEntree = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTEARTEFACTSENTREES)) ;
        
        try
        {
          lRequete = getBaseDonnees ().getOQLQuery ("select ARTEFACT from owep.modele.execution.MArtefact ARTEFACT where mId = $1") ;
          lRequete.bind (lIdArtEntree) ;
          lResultat  = lRequete.execute () ;
          MArtefact lArtEntree = (MArtefact) lResultat.next () ;
          
          mIteration.getTache(lIndiceTache).supprimerArtefactEntree(lArtEntree) ;
          lArtEntree.setTacheEntree (null) ;
        }
        catch (PersistenceException e)
        {
          e.printStackTrace () ;
          throw new ServletException (CConstante.EXC_TRAITEMENT) ;
        }
      }
      // Validation de l'it�ration.
      else if (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMIT))
      {
        VTransfert.transferer (getRequete (), mIteration, CConstante.PAR_ARBREITERATION) ;
      }
    //}
  }
  
  
  /**
   * R�cup�re la liste des t�ches d'un collaborateur pour l'it�ration choisie, et la transmet � la
   * JSP. 
   * @return URL de la page vers laquelle doit �tre redirig� le client.
   * @throws ServletException Si une erreur survient dans le controleur.
   */
  public String traiter () throws ServletException
  {
    
//  Ferme la connexion � la base de donn�es.    
    try
    {
      getBaseDonnees ().commit () ;
      getBaseDonnees ().close () ;
      getRequete().getSession().setAttribute (CConstante.PAR_ITERATION, mIteration);
    }
    catch (PersistenceException e)
    {
      e.printStackTrace () ;
      throw new ServletException (CConstante.EXC_TRAITEMENT) ;
    }
    if (! VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMIT))
    {
      return "..\\JSP\\Processus\\TIterationModif.jsp" ;
    }
    else
    {
      return "..\\JSP\\Processus\\TProjetVisu.jsp" ;
    }
  }
}