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
 * Controleur pour la modification d'une itération (ajout de tâches, d'artefact, ...) conformément
 * à un processus.
 */
public class CIterationModif extends CControleurBase
{
  private MProjet    mProjet ;    // Projet actuellement ouvert par l'utilisateur.
  private MIteration mIteration; // Itération modifiée ou ajoutée.
  
  
  /**
   * Récupère les données nécessaire au controleur dans la base de données. 
   * @throws ServletException Si une erreur survient durant la connexion
   */
  public void initialiserBaseDonnees () throws ServletException
  {
    Session          lSession ;  // Session actuelle de l'utilisateur.
    OQLQuery         lRequete ;  // Requête à réaliser sur la base
    QueryResults     lResultat ; // Résultat de la requête sur la base
    
    lSession = (Session) getRequete ().getSession ().getAttribute (CConstante.SES_SESSION) ;
    mProjet  = lSession.getProjet () ;
    
    // Charge une copie du projet ouvert.
    try
    {
      getBaseDonnees ().begin () ;
      
      // Récupère la liste des tâches du collaborateur.
      lRequete = getBaseDonnees ().getOQLQuery ("select PROJET from owep.modele.execution.MProjet PROJET where mId = $1") ;
      lRequete.bind (mProjet.getId ()) ;
      lResultat  = lRequete.execute () ;
      mProjet = (MProjet)lResultat.next () ;
      
      getRequete ().setAttribute(CConstante.PAR_PROJET, mProjet);
      
      if ((VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_VIDE)) &&
          (getRequete ().getParameter (CConstante.PAR_MODIFIER) == null))
      {
//        Initialise une nouvelle itération.
        mIteration = new MIteration () ;
        mIteration.setNom ("") ;
        mIteration.setNumero (mProjet.getNbIterations () + 1) ;
        mIteration.setProjet (mProjet) ;
        mProjet.addIteration(mIteration);

        try
        {
          // création de l'itération dans la base de données.
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
      // si c'est une modification, récupération de l'identifiant de l'itération à modifier
      if (getRequete ().getParameter (CConstante.PAR_MODIFIER) != null)
      {
        lIdIteration = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_ITERATION)) ;
      }
      // sinon on récupère l'identifiant de l'itération que l'on vient de rajouter dans la BD.
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
   * Récupère les paramètres passés au controleur. 
   * @throws ServletException -
   */
  public void initialiserParametres () throws ServletException
  {
    Session          lSession ;  // Session actuelle de l'utilisateur.
    OQLQuery         lRequete ;  // Requête à réaliser sur la base
    QueryResults     lResultat ; // Résultat de la requête sur la base
    
    // Modification d'une itération.
    if (getRequete ().getParameter (CConstante.PAR_MODIFIER) != null)
    {
      // Récupère l'itération à modifier et la met dans la session.
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
      
      // Ajout d'une tâche.
      if (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMITAJOUTER))
      {
        boolean trouve = false ;
        MTache lTache = new MTache () ;
        MCollaborateur lCollaborateur = null;
        MActivite      lActivite = null ;
        
        int lIdCollaborateur = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTECOLLABORATEURS)) ;
        int lIdActivite      = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTEACTIVITES)) ;
        
        // Recherche du collaborateur effectuant cette tâche.
        for (int i = 0 ; !trouve && i < mProjet.getNbCollaborateurs () ; i ++) 
        {
          if (mProjet.getCollaborateur (i).getId () == lIdCollaborateur)
          {
            lCollaborateur = mProjet.getCollaborateur (i) ;
            trouve = true ;
          }  
        }  

        // Recherche de l'activité à laquelle est liée la tâche
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
          // Récupération des données de l'itération ainsi que celle pour la tâche.
          VTransfert.transferer (getRequete (), lIterationTmp, CConstante.PAR_ARBREITERATION) ;  
          mIteration.setDateDebutPrevue (lIterationTmp.getDateDebutPrevue ());
          mIteration.setDateFinPrevue (lIterationTmp.getDateFinPrevue ());
          mIteration.setNom (lIterationTmp.getNom ());
        }
        
        VTransfert.transferer (getRequete (), lTache, CConstante.PAR_ARBRETACHES) ;

        // Met à jour le modèle.
        lTache.setIteration (mIteration) ;
        lTache.setCollaborateur (lCollaborateur) ;
        lTache.setActivite (lActivite) ;
        mIteration.addTache (lTache) ;
        lCollaborateur.addTache (lTache) ;
        lActivite.addTache (lTache) ;
        
        try
        {
          // ajout de la tâche dans la base de données.
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
      // Modification d'une tâche si on la modifie directement ou si on ajoute, modifie ou supprime un artefact.
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
        
        // Recherche du collaborateur effectuant la tâche.
        for (int i = 0 ; !trouve && i < mProjet.getNbCollaborateurs() ; i ++) 
        {
          if (mProjet.getCollaborateur (i).getId () == lIdCollaborateur)
          {
            lCollaborateur = mProjet.getCollaborateur (i) ;
            trouve = true ;
          }  
        }  
        
        // Recherche de l'activité à laquelle est liée la tâche.
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

        // Indice de la tâche et de l'artefact dans leur liste respective.
        int lIndiceTache     = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTETACHES)) ;
        
        //VTransfert.transferer (getRequete (), mIteration, CConstante.PAR_ARBREITERATION) ;
        VTransfert.transferer (getRequete (), lTacheTmp, CConstante.PAR_ARBRETACHES) ;
        
        try
        {
          // Récupération de l'identifiant de la tâche imprévue que l'on souhaite modifier.
          int lIdTache = mIteration.getTache (lIndiceTache).getId () ;
          // On récupère la tache imprévue que l'on souhaite modifier dans la base.
          lRequete = getBaseDonnees ().getOQLQuery ("select TACHE from owep.modele.execution.MTache TACHE where mId = $1") ;
          lRequete.bind (lIdTache) ;
          lResultat  = lRequete.execute () ;
          MTache lTache = (MTache) lResultat.next () ;
          
          // Mise à jour de la tâche.
          lTache.setNom (lTacheTmp.getNom ()) ;
          lTache.setChargeInitiale (lTacheTmp.getChargeInitiale ()) ;
          lTache.setDescription (lTacheTmp.getDescription ()) ;
          lTache.setDateDebutPrevue (lTacheTmp.getDateDebutPrevue ()) ;
          lTache.setDateFinPrevue (lTacheTmp.getDateDebutPrevue ()) ;
          
          // Mise à jour du modèle.
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
      // TODO : Supprimer une tâche.
      else if (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMITSUPPRIMER))
      {
        // Indice de la tâche et de l'artefact dans leur liste respective.
        int lIndiceTache     = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTETACHES)) ;
        
        VTransfert.transferer (getRequete (), mIteration, CConstante.PAR_ARBREITERATION) ;
        MTache lTache = mIteration.getTache (lIndiceTache) ;
        
        // Met à jour le modèle.
        mIteration.supprimerTache (lIndiceTache) ;
        lTache.getCollaborateur ().supprimerTache (lTache) ;
        lTache.getActivite ().supprimerTache (lTache) ;
        
        // Supprime la liste des artefacts en entrées.
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
        // Supprime les dépendance de la tâche
        for (int i = 0; i < lTache.getNbConditions (); i++)
        {
          lTache.supprimerCondition (i) ;
        }
        
        // Suppression de toutes les dépendances qu'il y avait avec cette tâche
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
      
      // Ajout des dépendances entre tâches
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
        // sinon il a choisi terminé
        else
        {
          lCondition.setEtat (3) ;
        }
        lTache.addCondition (lCondition) ;  
        
        try
        {
          // ajout de la condition dans la base de données.
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
      // TODO : Supprimer dépendance entre tâche.
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
        
        // Indice de la tâche et de l'artefact dans leur liste respective.
        int lIndiceTache       = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTETACHES)) ;
        int lIndiceProduit     = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTEPRODUITS)) ;
        int lIndiceResponsable = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTERESPONSABLES)) ;
        
        MTache         lTache       = mIteration.getTache (lIndiceTache) ;
        MActivite      lActivite    = lTache.getActivite () ;
        MProduit       lProduit     = lActivite.getProduitSortie (lIndiceProduit) ;
        MCollaborateur lResponsable = lProduit.getResponsable ().getCollaborateur (lIndiceResponsable) ;
        
        // Mise à jour du modèle.
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
          // ajout de l'artefact dans la base de données.
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
        // Indice de la tâche et de l'artefact dans leur liste respective.
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
          
          // Mise à jour de l'artefact.
          lArtefactSortie.setNom (lArtefactSortieTmp.getNom ()) ;
          lArtefactSortie.setDescription (lArtefactSortieTmp.getDescription ()) ;
          lArtefactSortie.setProduit (lActivite.getProduitSortie (lIndiceProduit)) ;
          lArtefactSortie.setResponsable (lProduit.getResponsable ().getCollaborateur (lIndiceResponsable)) ;
          
          // Mise à jour du modèle.
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
        // Indice de la tâche et de l'artefact dans leur liste respective.
        int lIndiceTache     = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTETACHES)) ;
        int lIndiceArtSortie = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTEARTEFACTSSORTIES)) ;
        
        MArtefact lArtefactSortie = mIteration.getTache (lIndiceTache).getArtefactSortie (lIndiceArtSortie) ;
        
        // Mise à jour du modèle.
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
      // Ajouter un artefact en entrée
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
      // Supprimer un artefact en entrée
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
      // Validation de l'itération.
      else if (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMIT))
      {
        VTransfert.transferer (getRequete (), mIteration, CConstante.PAR_ARBREITERATION) ;
      }
    //}
  }
  
  
  /**
   * Récupère la liste des tâches d'un collaborateur pour l'itération choisie, et la transmet à la
   * JSP. 
   * @return URL de la page vers laquelle doit être redirigé le client.
   * @throws ServletException Si une erreur survient dans le controleur.
   */
  public String traiter () throws ServletException
  {
    
//  Ferme la connexion à la base de données.    
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