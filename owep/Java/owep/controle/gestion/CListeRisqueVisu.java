package owep.controle.gestion ;


import java.util.ArrayList ;
import javax.servlet.ServletException ;
import org.exolab.castor.jdo.OQLQuery ;
import org.exolab.castor.jdo.QueryResults ;
import owep.controle.CConstante ;
import owep.controle.CControleurBase ;
import owep.infrastructure.Session ;
import owep.modele.execution.MRisque;
import owep.modele.execution.MProjet ;


/**
 * Controleur pour la visualisation  de la liste des problèmes.
 */
public class CListeRisqueVisu extends CControleurBase
{
  private ArrayList mListeRisques ; // Liste des risques survenus sur le projet en cours.
  
  
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
    
    lSession = (Session) getRequete ().getSession ().getAttribute (CConstante.SES_SESSION) ;
    lProjet  = lSession.getProjet () ;
    
    // Charge la liste des problèmes pour le projet ouvert.
    try
    {
      getBaseDonnees ().begin () ;
      
      // Exécute la requête de récupération des problèmes.
      lRequete  = getBaseDonnees ().getOQLQuery ("select RISQUE from owep.modele.execution.MRisque RISQUE") ;
      lResultat = lRequete.execute () ;
      
      // Parcours le résultat de la requête et ajoute chaque problème à la liste.
      mListeRisques = new ArrayList () ;
      while (lResultat.hasMore ())
      {
        MRisque lRisque = (MRisque) lResultat.next () ;
        // Prend en compte le problème que s'il appartient au projet ouvert.
        if (lRisque.getProjet ().getId () == lProjet.getId ())
        {
          mListeRisques.add (lRisque) ;
        }
      }
      
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
  }
  
  
  /**
   * Récupère les paramètres passés au controleur. 
   * @throws ServletException -
   */
  public void initialiserParametres () throws ServletException
  {
  }
  
  
  /**
   * Récupère la liste des tâches d'un collaborateur pour l'itération choisie, et la transmet à la
   * JSP. 
   * @return URL de la page vers laquelle doit être redirigé le client.
   * @throws ServletException Si une erreur survient dans le controleur
   */
  public String traiter () throws ServletException
  {
    getRequete ().setAttribute (CConstante.PAR_LISTERISQUES, mListeRisques) ;
    
    // Transmet les données à la JSP d'affichage.
    return "/JSP/Gestion/TListeRisqueVisu.jsp" ;
  }
}