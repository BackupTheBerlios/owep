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
 * Controleur pour la suppression d'un probl�me.
 */
public class CRisqueSuppr extends CControleurBase
{
  private MRisque mRisque ; // Risque � supprimer.
  
  
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
    String       lIdRisque ; // Identifiant du risque.
    
    lSession  = (Session) getRequete ().getSession ().getAttribute (CConstante.SES_SESSION) ;
    lProjet   = lSession.getProjet () ;
    lIdRisque = getRequete ().getParameter (CConstante.PAR_RISQUE) ;
    
    
    // Si un probl�me est pass� en param�tre,
    if (lIdRisque != null)
    {
      // Charge le probl�me pass� en param�tre.
      try
      {
        getBaseDonnees ().begin () ;
        
        // R�cup�re la liste des probl�mes survenus sur le projet en cours.
        lRequete = getBaseDonnees ().getOQLQuery ("select RISQUE from owep.modele.execution.MRisque RISQUE where mId = $1 AND mProjet.mId = $2") ;
        lRequete.bind (Integer.parseInt (lIdRisque)) ;
        lRequete.bind (lProjet.getId ()) ;
        lResultat = lRequete.execute () ;
        
        // Si on r�cup�re correctement le probl�me dans la base,
        if (lResultat.hasMore ())
        {
          mRisque = (MRisque) lResultat.next () ;
        }
        // Si le probl�me n'existe pas ou n'appartient pas au projet ouvert,
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
    // Si aucun probl�me existant n'est pass� en param�tre,
    else
    {
      throw new ServletException (CConstante.EXC_TRAITEMENT) ;
    }
  }
  
  
  /**
   * R�cup�re les param�tres pass�s au contr�leur. 
   * @throws ServletException -
   */
  public void initialiserParametres () throws ServletException
  {
  }
  
  
  /**
   * Transmet le probl�me � la JSP d'affichage si aucune donn�es n'est soumise. Sinon, met � jour ou
   * ins�re le probl�me.
   * @return URL de la page vers laquelle doit �tre redirig� le client.
   * @throws ServletException Si une erreur survient dans le controleur
   */
  public String traiter () throws ServletException
  {
    try
    {
      // Supprime le probl�me.
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
    
    // Affiche la page de visualisation de la liste des probl�mes.
    getRequete ().setAttribute (CConstante.PAR_MESSAGE, "Le risque \"" + mRisque.getNom () + "\" a �t� supprim�.") ;
    return "/Gestion/ListeRisqueVisu" ;
  }
}