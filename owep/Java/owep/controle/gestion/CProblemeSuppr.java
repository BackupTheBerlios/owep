package owep.controle.gestion ;


import javax.servlet.ServletException ;
import org.exolab.castor.jdo.OQLQuery ;
import org.exolab.castor.jdo.QueryResults ;
import owep.controle.CConstante ;
import owep.controle.CControleurBase ;
import owep.infrastructure.Session ;
import owep.modele.execution.MProbleme ;
import owep.modele.execution.MProjet ;


/**
 * Controleur pour la suppression d'un problème.
 */
public class CProblemeSuppr extends CControleurBase
{
  private MProbleme mProbleme ; // Problème à créer ou modifier.
  
  
  /**
   * Récupère les données nécessaire au controleur dans la base de données. 
   * @throws ServletException Si une erreur survient durant la connexion à la base.
   */
  public void initialiserBaseDonnees () throws ServletException
  {
    Session      lSession ;    // Session actuelle de l'utilisateur.
    MProjet      lProjet ;     // Projet en cours.
    OQLQuery     lRequete ;    // Requête à réaliser sur la base.
    QueryResults lResultat ;   // Résultat de la requête sur la base.
    String       lIdProbleme ; // Identifiant du problème.
    
    lSession    = (Session) getRequete ().getSession ().getAttribute (CConstante.SES_SESSION) ;
    lProjet     = lSession.getProjet () ;
    lIdProbleme = getRequete ().getParameter (CConstante.PAR_PROBLEME) ;
    
    
    // Si un problème est passé en paramètre,
    if (lIdProbleme != null)
    {
      // Charge le problème passé en paramètre.
      try
      {
        getBaseDonnees ().begin () ;
        
        // Récupère la liste des problèmes survenus sur le projet en cours.
        lRequete = getBaseDonnees ().getOQLQuery ("select PROBLEME from owep.modele.execution.MProbleme PROBLEME where mId = $1 AND mTacheProvoque.mIteration.mProjet.mId = $2") ;
        lRequete.bind (Integer.parseInt (lIdProbleme)) ;
        lRequete.bind (lProjet.getId ()) ;
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
      getBaseDonnees ().begin () ;
      getBaseDonnees ().remove (mProbleme) ;
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
    return "/Gestion/ListeProblemeVisu" ;
  }
}