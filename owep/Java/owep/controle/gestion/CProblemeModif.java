package owep.controle.gestion ;


import javax.servlet.ServletException ;
import org.exolab.castor.jdo.OQLQuery ;
import org.exolab.castor.jdo.QueryResults ;
import owep.controle.CConstante ;
import owep.controle.CControleurBase ;
import owep.infrastructure.Session ;
import owep.modele.execution.MProbleme ;
import owep.modele.execution.MProjet ;
import owep.vue.transfert.VTransfert ;


/**
 * Controleur pour la visualisation  de la liste des probl�mes.
 */
public class CProblemeModif extends CControleurBase
{
  private MProbleme mProbleme ; // Probl�me � cr�er ou modifier.
  
  
  /**
   * R�cup�re les donn�es n�cessaire au controleur dans la base de donn�es. 
   * @throws ServletException Si une erreur survient durant la connexion � la base.
   */
  public void initialiserBaseDonnees () throws ServletException
  {
    Session      lSession ;    // Session actuelle de l'utilisateur.
    MProjet      lProjet ;     // Projet en cours.
    OQLQuery     lRequete ;    // Requ�te � r�aliser sur la base.
    QueryResults lResultat ;   // R�sultat de la requ�te sur la base.
    String       lIdProbleme ; // Identifiant du probl�me.
    
    lSession    = (Session) getRequete ().getSession ().getAttribute (CConstante.SES_SESSION) ;
    lProjet     = lSession.getProjet () ;
    lIdProbleme = getRequete ().getParameter (CConstante.PAR_PROBLEME) ;
    
    
    // Si un probl�me est pass� en param�tre,
    if (lIdProbleme != null)
    {
      // Charge le probl�me pass� en param�tre.
      try
      {
        getBaseDonnees ().begin () ;
        
        // R�cup�re la liste des probl�mes survenus sur le projet en cours.
        lRequete = getBaseDonnees ().getOQLQuery ("select PROBLEME from owep.modele.execution.MProbleme PROBLEME where mId = $1 AND mTacheProvoque.mIteration.mProjet.mId = $2") ;
        lRequete.bind (Integer.parseInt (lIdProbleme)) ;
        lRequete.bind (lProjet.getId ()) ;
        lResultat = lRequete.execute () ;
        
        // Si on r�cup�re correctement le probl�me dans la base,
        if (lResultat.hasMore ())
        {
          mProbleme = (MProbleme) lResultat.next () ;
        }
        // Si le probl�me n'existe pas ou n'appartient pas au projet ouvert,
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
    // Si aucun probl�me existant n'est pass� en param�tre,
    else
    {
      mProbleme = new MProbleme () ;
    }
  }
  
  
  /**
   * R�cup�re les param�tres pass�s au contr�leur. 
   * @throws ServletException -
   */
  public void initialiserParametres () throws ServletException
  {
    // Si l'utilisateur valide les donn�es, r�cup�re les donn�es.
    if (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMIT))
    {
      VTransfert.transferer (getRequete (), mProbleme, CConstante.PAR_ARBREPROBLEME) ;
    }
  }
  
  
  /**
   * R�cup�re la liste des t�ches d'un collaborateur pour l'it�ration choisie, et la transmet � la
   * JSP.
   * @return URL de la page vers laquelle doit �tre redirig� le client.
   * @throws ServletException Si une erreur survient dans le controleur
   */
  public String traiter () throws ServletException
  {
    // Si l'utilisateur valide les donn�es, les enregistre dans la base.
    if (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMIT))
    {
      try
      {
        // Cr�e l'objet ou le met � jour s'il existe d�j�.
        getBaseDonnees ().begin () ;
        if (mProbleme.getId () == 0)
        {
          getBaseDonnees ().create (mProbleme) ;
        }
        else
        {
          getBaseDonnees ().update (mProbleme) ;
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
      
      // Affiche la page de visualisation de la liste des probl�mes.
      return "/Gestion/ListeProblemeVisu" ;
    }
    // Si l'utilisateur acc�de � la page d'ajout/modification, transmet les donn�es � la page.
    else
    {
      getRequete ().setAttribute (CConstante.PAR_PROBLEME, mProbleme) ;
      try
      {
        getBaseDonnees ().close () ;
      }
      catch (Exception eException)
      {
        eException.printStackTrace () ;
        throw new ServletException (CConstante.EXC_TRAITEMENT) ;
      }
      
      // Affiche la page de modification de probl�me.
      return "/JSP/Gestion/TProblemeModif.jsp" ;
    }
  }
}