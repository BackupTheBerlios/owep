package owep.controle.gestion ;


import javax.servlet.ServletException ;
import org.exolab.castor.jdo.OQLQuery ;
import org.exolab.castor.jdo.QueryResults ;
import owep.controle.CConstante ;
import owep.controle.CControleurBase ;
import owep.infrastructure.Session ;
import owep.modele.execution.MRisque ;
import owep.modele.execution.MProjet ;


/**
 * Controleur pour la suppression d'un problème.
 */
public class CRisqueSuppr extends CControleurBase
{
  private MRisque mRisque ; // Risque à supprimer.
  
  
  /**
   * Récupère les données nécessaire au controleur dans la base de données. 
   * @throws ServletException Si une erreur survient durant la connexion à la base.
   */
  public void initialiserBaseDonnees () throws ServletException
  {
    Session      lSession ;  // Session actuelle de l'utilisateur.
    MProjet      lProjet ;   // Projet en cours.
    OQLQuery     lRequete ;  // Requête à réaliser sur la base.
    QueryResults lResultat ; // Résultat de la requête sur la base.
    String       lIdRisque ; // Identifiant du risque.
    
    lSession  = (Session) getRequete ().getSession ().getAttribute (CConstante.SES_SESSION) ;
    lProjet   = lSession.getProjet () ;
    lIdRisque = getRequete ().getParameter (CConstante.PAR_RISQUE) ;
    
    
    // Si un problème est passé en paramètre,
    if (lIdRisque != null)
    {
      // Charge le problème passé en paramètre.
      try
      {
        getBaseDonnees ().begin () ;
        
        // Récupère la liste des problèmes survenus sur le projet en cours.
        lRequete = getBaseDonnees ().getOQLQuery ("select RISQUE from owep.modele.execution.MRisque RISQUE where mId = $1 AND mProjet.mId = $2") ;
        lRequete.bind (Integer.parseInt (lIdRisque)) ;
        lRequete.bind (lProjet.getId ()) ;
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
    // Si aucun problème existant n'est passé en paramètre,
    else
    {
      throw new ServletException (CConstante.EXC_TRAITEMENT) ;
    }
  }
  
  
  /**
   * Récupère les paramètres passés au contrôleur. 
   * @throws ServletException -
   */
  public void initialiserParametres () throws ServletException
  {
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
      // Supprime le problème.
      getBaseDonnees ().remove (mRisque) ;
      getBaseDonnees ().commit () ;
    }
    catch (Exception eException)
    {
      eException.printStackTrace () ;
      throw new ServletException (CConstante.EXC_TRAITEMENT) ;
    }
    finally
    {
      try
      {
        getBaseDonnees ().close () ;
      }
      catch (Exception eException)
      {
        eException.printStackTrace () ;
        throw new ServletException (CConstante.EXC_TRAITEMENT) ;
      }
    }
    
    // Affiche la page de visualisation de la liste des problèmes.
    getRequete ().setAttribute (CConstante.PAR_MESSAGE, "Le risque \"" + mRisque.getNom () + "\" a été supprimé.") ;
    return "/Gestion/ListeRisqueVisu" ;
  }
}