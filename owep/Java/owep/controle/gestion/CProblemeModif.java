package owep.controle.gestion ;


import java.util.StringTokenizer;
import javax.servlet.ServletException ;
import org.exolab.castor.jdo.OQLQuery ;
import org.exolab.castor.jdo.QueryResults ;
import owep.controle.CConstante ;
import owep.controle.CControleurBase ;
import owep.infrastructure.Session ;
import owep.modele.execution.MIteration ;
import owep.modele.execution.MProbleme ;
import owep.modele.execution.MProjet ;
import owep.modele.execution.MTache ;
import owep.modele.execution.MTacheImprevue ;
import owep.vue.transfert.VTransfert ;


/**
 * Controleur pour la modification d'un probleme.
 */
public class CProblemeModif extends CControleurBase
{
  private MProjet   mProjet ;          // Projet actuellement ouvert.
  private MProbleme mProbleme ;        // Problème à créer ou modifier.
  
  
  /**
   * Récupère les données nécessaire au controleur dans la base de données. 
   * @throws ServletException Si une erreur survient durant la connexion à la base.
   */
  public void initialiserBaseDonnees () throws ServletException
  {
    Session      lSession ;    // Session actuelle de l'utilisateur.
    OQLQuery     lRequete ;    // Requête à réaliser sur la base.
    QueryResults lResultat ;   // Résultat de la requête sur la base.
    String       lIdProbleme ; // Identifiant du problème.
    
    lSession    = (Session) getRequete ().getSession ().getAttribute (CConstante.SES_SESSION) ;
    mProjet     = lSession.getProjet () ;
    lIdProbleme = getRequete ().getParameter (CConstante.PAR_PROBLEME) ;
    
    
    try
    {
      getBaseDonnees ().begin () ;
      
      // Récupère le projet actuellement ouvert.
      lRequete = getBaseDonnees ().getOQLQuery ("select PROJET from owep.modele.execution.MProjet PROJET where mId = $1") ;
      lRequete.bind (mProjet.getId ()) ;
      lResultat = lRequete.execute () ;
      // Si on récupère correctement le projet dans la base,
      if (lResultat.hasMore ())
      {
        mProjet = (MProjet) lResultat.next () ;
      }
      // Si le projet n'existe pas,
      else
      {
        throw new ServletException (CConstante.EXC_TRAITEMENT) ;
      }
      
      getBaseDonnees ().commit () ;
      
      
      // Si un problème est passé en paramètre,
      if (lIdProbleme != null)
      {
        // Charge le problème passé en paramètre.
        getBaseDonnees ().begin () ;
        
        // Récupère le problème choisi par l'utilisateur.
        lRequete = getBaseDonnees ().getOQLQuery ("select PROBLEME from owep.modele.execution.MProbleme PROBLEME where mId = $1 AND mTacheProvoque.mIteration.mProjet.mId = $2") ;
        lRequete.bind (Integer.parseInt (lIdProbleme)) ;
        lRequete.bind (mProjet.getId ()) ;
        lResultat = lRequete.execute () ;
        // Si on récupère correctement le problème dans la base,
        if (lResultat.hasMore ())
        {
          mProbleme = (MProbleme) lResultat.next () ;
        }
        // Si le problème n'existe pas ou n'appartient pas au projet ouvert,
        else
        {
          throw new ServletException (CConstante.EXC_TRAITEMENT) ;
        }
        
        getBaseDonnees ().commit () ;
      }
      // Si aucun problème existant n'est passé en paramètre,
      else
      {
        mProbleme = new MProbleme () ;
      }
    }
    catch (Exception eException)
    {
      eException.printStackTrace () ;
      try
      {
        getBaseDonnees ().close () ;
      }
      catch (Exception eCloseException)
      {
        eCloseException.printStackTrace () ;
      }
      throw new ServletException (CConstante.EXC_TRAITEMENT) ;
    }
  }
  
  
  /**
   * Récupère les paramètres passés au contrôleur. 
   * @throws ServletException -
   */
  public void initialiserParametres () throws ServletException
  {
    // Si l'utilisateur valide les données, récupère les données.
    if (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMIT))
    {
      VTransfert.transferer (getRequete (), mProbleme, CConstante.PAR_ARBREPROBLEME) ;
    
      // Récupère la liste des tâches provoquant le problème.
      mProbleme.getListeTacheProvoque ().clear () ;
      mProbleme.getListeTacheImprevueProvoque ().clear () ;
      StringTokenizer lTokenizer = new StringTokenizer (getRequete ().getParameter (CConstante.PAR_LISTETACHESPROVOQUE), "-") ;
      while (lTokenizer.hasMoreTokens ())
      {
        if (lTokenizer.nextToken ().equals ("i"))
        {
          MTacheImprevue lTache = chercherTacheImprevue (Integer.parseInt (lTokenizer.nextToken ())) ;
          mProbleme.addTacheImprevueProvoque (lTache) ;
          lTache.addProblemeEntree (mProbleme) ;
        }
        else
        {
          MTache lTache = chercherTache (Integer.parseInt (lTokenizer.nextToken ())) ;
          mProbleme.addTacheProvoque (lTache) ;
          lTache.addProblemeEntree (mProbleme) ;
        }
      }
      
      // Récupère la liste des tâches résolvant le problème.
      mProbleme.getListeTacheResout ().clear () ;
      mProbleme.getListeTacheImprevueResout ().clear () ;
      lTokenizer = new StringTokenizer (getRequete ().getParameter (CConstante.PAR_LISTETACHESRESOUT), "-") ;
      while (lTokenizer.hasMoreTokens ())
      {
        if (lTokenizer.nextToken ().equals ("i"))
        {
          MTacheImprevue lTache = chercherTacheImprevue (Integer.parseInt (lTokenizer.nextToken ())) ;
          mProbleme.addTacheImprevueResout (lTache) ;
          lTache.addProblemeSortie (mProbleme) ;
        }
        else
        {
          MTache lTache = chercherTache (Integer.parseInt (lTokenizer.nextToken ())) ;
          mProbleme.addTacheResout (lTache) ;
          lTache.addProblemeSortie (mProbleme) ;
        }
      }
    }
  }
  
  
  /**
   * Transmet le problème à la JSP d'affichage si aucune données n'est soumise. Sinon, met à jour ou
   * insère le problème.
   * @return URL de la page vers laquelle doit être redirigé le client.
   * @throws ServletException Si une erreur survient dans le controleur
   */
  public String traiter () throws ServletException
  {
    try
    {
      // Si l'utilisateur affiche la page pour la première fois,
      if (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_VIDE))
      {
        // Si l'utilisateur accède à la page d'ajout/modification, transmet les données à la page.
        getRequete ().setAttribute (CConstante.PAR_PROBLEME, mProbleme) ;
        getRequete ().setAttribute (CConstante.PAR_PROJET, mProjet) ;
        getBaseDonnees ().close () ;
        
        // Affiche la page de modification de problème.
        return "/JSP/Gestion/TProblemeModif.jsp" ;
      }
      else
      {
        // Crée l'objet ou le met à jour s'il existe déjà.
        getBaseDonnees ().begin () ;
        
        // Si l'utilisateur valide les données, alors on les enregistre dans la base.
        String lMessage = "" ;
        if (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMIT))
        {
          if (mProbleme.getId () == 0)
          {
            mProbleme.create (getBaseDonnees ()) ;
            lMessage = "Le problème \"" + mProbleme.getNom () + "\" a été créé." ;
          }
          else
          {
            getBaseDonnees ().update (mProbleme) ;
            lMessage = "Le problème \"" + mProbleme.getNom () + "\" a été mis à jour." ;
          }
        }
        // Valide les données.
        getBaseDonnees ().commit () ;
        getBaseDonnees ().close () ;
        
        // Affiche la page de visualisation de la liste des problèmes.
        getRequete ().setAttribute (CConstante.PAR_MESSAGE, lMessage) ;
        return "/Gestion/ListeProblemeVisu" ;
      }
    }
    catch (Exception eException)
    {
      eException.printStackTrace () ;
      throw new ServletException (CConstante.EXC_TRAITEMENT) ;
    }
  }
  
  
  /**
   * Récupère une tâche à partir de son identifiant.
   * @param pId Identifiant de la tâche
   * @return Tache d'identifiant pId.
   * @throws ServletException Si la tâche recherché n'est pas trouvée.
   */
  private MTache chercherTache (int pId) throws ServletException
  {
    for (int i = 0; i < mProjet.getNbIterations (); i ++)
    {
      MIteration lIteration = mProjet.getIteration (i) ;
      for (int j = 0; j < lIteration.getNbTaches (); j ++)
      {
        if (lIteration.getTache (j).getId () == pId)
        {
          return lIteration.getTache (j) ;
        }
      }
    }
    throw new ServletException (CConstante.EXC_TRAITEMENT) ;
  }
  
  
  /**
   * Récupère une tâche à partir de son identifiant.
   * @param pId Identifiant de la tâche
   * @return Tache d'identifiant pId.
   * @throws ServletException Si la tâche recherché n'est pas trouvée.
   */
  private MTacheImprevue chercherTacheImprevue (int pId) throws ServletException
  {
    for (int i = 0; i < mProjet.getNbIterations (); i ++)
    {
      MIteration lIteration = mProjet.getIteration (i) ;
      for (int j = 0; j < lIteration.getNbTachesImprevues (); j ++)
      {
        if (lIteration.getTacheImprevue (j).getId () == pId)
        {
          return lIteration.getTacheImprevue (j) ;
        }
      }
    }
    throw new ServletException (CConstante.EXC_TRAITEMENT) ;
  }
}