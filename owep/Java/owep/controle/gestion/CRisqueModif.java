package owep.controle.gestion ;


import java.util.StringTokenizer;
import javax.servlet.ServletException ;
import org.exolab.castor.jdo.OQLQuery ;
import org.exolab.castor.jdo.QueryResults ;
import owep.controle.CConstante ;
import owep.controle.CControleurBase ;
import owep.infrastructure.Session ;
import owep.modele.execution.MIteration ;
import owep.modele.execution.MRisque ;
import owep.modele.execution.MProjet ;
import owep.vue.transfert.VTransfert ;


/**
 * Controleur pour la modification d'un probleme.
 */
public class CRisqueModif extends CControleurBase
{
  private MProjet mProjet ; // Projet actuellement ouvert.
  private MRisque mRisque ; // Problème à créer ou modifier.
  
  
  /**
   * Récupère les données nécessaire au controleur dans la base de données. 
   * @throws ServletException Si une erreur survient durant la connexion à la base.
   */
  public void initialiserBaseDonnees () throws ServletException
  {
    Session      lSession ;  // Session actuelle de l'utilisateur.
    OQLQuery     lRequete ;  // Requête à réaliser sur la base.
    QueryResults lResultat ; // Résultat de la requête sur la base.
    String       lIdRisque ; // Identifiant du risque.
    
    lSession    = (Session) getRequete ().getSession ().getAttribute (CConstante.SES_SESSION) ;
    mProjet     = lSession.getProjet () ;
    lIdRisque = getRequete ().getParameter (CConstante.PAR_RISQUE) ;
    
    
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
      if (lIdRisque != null)
      {
        // Charge le problème passé en paramètre.
        getBaseDonnees ().begin () ;
        
        // Récupère le problème choisi par l'utilisateur.
        lRequete = getBaseDonnees ().getOQLQuery ("select RISQUE from owep.modele.execution.MRisque RISQUE where mId = $1 AND mProjet.mId = $2") ;
        lRequete.bind (Integer.parseInt (lIdRisque)) ;
        lRequete.bind (mProjet.getId ()) ;
        lResultat = lRequete.execute () ;
        // Si on récupère correctement le problème dans la base,
        if (lResultat.hasMore ())
        {
          mRisque = (MRisque) lResultat.next () ;
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
        mRisque = new MRisque () ;
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
      VTransfert.transferer (getRequete (), mRisque, CConstante.PAR_ARBRERISQUE) ;
      mRisque.setProjet (mProjet) ;
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
        getRequete ().setAttribute (CConstante.PAR_RISQUE, mRisque) ;
        getRequete ().setAttribute (CConstante.PAR_PROJET, mProjet) ;
        getBaseDonnees ().close () ;
        
        // Affiche la page de modification de problème.
        return "/JSP/Gestion/TRisqueModif.jsp" ;
      }
      else
      {
        // Crée l'objet ou le met à jour s'il existe déjà.
        getBaseDonnees ().begin () ;
        
        // Si l'utilisateur valide les données, alors on les enregistre dans la base.
        String lMessage = "" ;
        if (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMIT))
        {
          if (mRisque.getId () == 0)
          {
            getBaseDonnees ().create (mRisque) ;
            lMessage = "Le risque \"" + mRisque.getNom () + "\" a été créé." ;
          }
          else
          {
            getBaseDonnees ().update (mRisque) ;
            lMessage = "Le risque \"" + mRisque.getNom () + "\" a été mis à jour." ;
          }
        }
        // Valide les données.
        getBaseDonnees ().commit () ;
        getBaseDonnees ().close () ;
        
        // Affiche la page de visualisation de la liste des problèmes.
        getRequete ().setAttribute (CConstante.PAR_MESSAGE, lMessage) ;
        return "/Gestion/ListeRisqueVisu" ;
      }
    }
    catch (Exception eException)
    {
      eException.printStackTrace () ;
      throw new ServletException (CConstante.EXC_TRAITEMENT) ;
    }
  }
}