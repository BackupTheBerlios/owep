package owep.controle.gestion ;


import java.util.ArrayList ;
import javax.servlet.ServletException ;
import org.exolab.castor.jdo.OQLQuery ;
import org.exolab.castor.jdo.QueryResults ;
import owep.controle.CConstante ;
import owep.controle.CControleurBase ;
import owep.infrastructure.Session ;
import owep.modele.execution.MProbleme;
import owep.modele.execution.MProjet ;


/**
 * Controleur pour la visualisation  de la liste des probl�mes.
 */
public class CListeProblemeVisu extends CControleurBase
{
  private ArrayList mListeProblemes ; // Liste des probl�mes survenus sur le projet en cours.
  
  
  /**
   * R�cup�re les donn�es n�cessaire au controleur dans la base de donn�es. 
   * @throws ServletException Si une erreur survient durant la connexion � la base.
   */
  public void initialiserBaseDonnees () throws ServletException
  {
    Session      lSession ;  // Session actuelle de l'utilisateur.
    MProjet      lProjet ;   // Projet en cours.
    OQLQuery     lRequete ;  // Requ�te � r�aliser sur la base.
    QueryResults lResultat ; // R�sultat de la requ�te sur la base.
    
    lSession = (Session) getRequete ().getSession ().getAttribute (CConstante.SES_SESSION) ;
    lProjet  = lSession.getProjet () ;
    
    // Charge la liste des probl�mes pour le projet ouvert.
    try
    {
      getBaseDonnees ().begin () ;
      
      // Ex�cute la requ�te de r�cup�ration des probl�mes.
      // TODO : Filtrer sur les it�rations directement dans la requ�te.
      lRequete = getBaseDonnees ().getOQLQuery ("select PROBLEME from owep.modele.execution.MProbleme PROBLEME") ;
      lResultat = lRequete.execute () ;
      
      // Parcours le r�sultat de la requ�te et ajoute chaque probl�me � la liste.
      mListeProblemes = new ArrayList () ;
      while (lResultat.hasMore ())
      {
        MProbleme lProbleme = (MProbleme) lResultat.next () ;
        // Prend en compte le probl�me que s'il appartient au projet ouvert.
        if (lProbleme.getTacheProvoque (0).getIteration ().getProjet ().getId () == lProjet.getId ())
        {
          mListeProblemes.add (lProbleme) ;
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
   * R�cup�re les param�tres pass�s au controleur. 
   * @throws ServletException -
   */
  public void initialiserParametres () throws ServletException
  {
  }
  
  
  /**
   * R�cup�re la liste des t�ches d'un collaborateur pour l'it�ration choisie, et la transmet � la
   * JSP. 
   * @return URL de la page vers laquelle doit �tre redirig� le client.
   * @throws ServletException Si une erreur survient dans le controleur
   */
  public String traiter () throws ServletException
  {
    getRequete ().setAttribute (CConstante.PAR_LISTEPROBLEMES, mListeProblemes) ;
    
    // Transmet les donn�es � la JSP d'affichage.
    return "/JSP/Gestion/TListeProblemeVisu.jsp" ;
  }
}