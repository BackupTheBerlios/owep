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
 * Controleur pour la visualisation  de la liste des probl�mes.
 */
public class CListeRisqueVisu extends CControleurBase
{
  private MProjet mProjet ; // Contient la liste des risques.
  
  
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
    mProjet  = lSession.getProjet () ;
    
    // Charge la liste des probl�mes pour le projet ouvert.
    try
    {
      getBaseDonnees ().begin () ;
      
      // R�cup�re le projet actuellement ouvert.
      lRequete = getBaseDonnees ().getOQLQuery ("select PROJET from owep.modele.execution.MProjet PROJET where mId = $1") ;
      lRequete.bind (mProjet.getId ()) ;
      lResultat = lRequete.execute () ;
      // Si on r�cup�re correctement le projet dans la base,
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
    getRequete ().setAttribute (CConstante.PAR_PROJET, mProjet) ;
    
    // Transmet les donn�es � la JSP d'affichage.
    return "/JSP/Gestion/TListeRisqueVisu.jsp" ;
  }
}