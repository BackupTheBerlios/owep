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
  private MRisque mRisque ; // Probl�me � cr�er ou modifier.
  
  
  /**
   * R�cup�re les donn�es n�cessaire au controleur dans la base de donn�es. 
   * @throws ServletException Si une erreur survient durant la connexion � la base.
   */
  public void initialiserBaseDonnees () throws ServletException
  {
    Session      lSession ;  // Session actuelle de l'utilisateur.
    OQLQuery     lRequete ;  // Requ�te � r�aliser sur la base.
    QueryResults lResultat ; // R�sultat de la requ�te sur la base.
    String       lIdRisque ; // Identifiant du risque.
    
    lSession    = (Session) getRequete ().getSession ().getAttribute (CConstante.SES_SESSION) ;
    mProjet     = lSession.getProjet () ;
    lIdRisque = getRequete ().getParameter (CConstante.PAR_RISQUE) ;
    
    
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
      
      
      // Si un probl�me est pass� en param�tre,
      if (lIdRisque != null)
      {
        // Charge le probl�me pass� en param�tre.
        getBaseDonnees ().begin () ;
        
        // R�cup�re le probl�me choisi par l'utilisateur.
        lRequete = getBaseDonnees ().getOQLQuery ("select RISQUE from owep.modele.execution.MRisque RISQUE where mId = $1 AND mProjet.mId = $2") ;
        lRequete.bind (Integer.parseInt (lIdRisque)) ;
        lRequete.bind (mProjet.getId ()) ;
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
        
        getBaseDonnees ().commit () ;
      }
      // Si aucun probl�me existant n'est pass� en param�tre,
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
   * R�cup�re les param�tres pass�s au contr�leur. 
   * @throws ServletException -
   */
  public void initialiserParametres () throws ServletException
  {
    // Si l'utilisateur valide les donn�es, r�cup�re les donn�es.
    if (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMIT))
    {
      VTransfert.transferer (getRequete (), mRisque, CConstante.PAR_ARBRERISQUE) ;
      mRisque.setProjet (mProjet) ;
    }
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
      // Si l'utilisateur affiche la page pour la premi�re fois,
      if (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_VIDE))
      {
        // Si l'utilisateur acc�de � la page d'ajout/modification, transmet les donn�es � la page.
        getRequete ().setAttribute (CConstante.PAR_RISQUE, mRisque) ;
        getRequete ().setAttribute (CConstante.PAR_PROJET, mProjet) ;
        getBaseDonnees ().close () ;
        
        // Affiche la page de modification de probl�me.
        return "/JSP/Gestion/TRisqueModif.jsp" ;
      }
      else
      {
        // Cr�e l'objet ou le met � jour s'il existe d�j�.
        getBaseDonnees ().begin () ;
        
        // Si l'utilisateur valide les donn�es, alors on les enregistre dans la base.
        String lMessage = "" ;
        if (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMIT))
        {
          if (mRisque.getId () == 0)
          {
            getBaseDonnees ().create (mRisque) ;
            lMessage = "Le risque \"" + mRisque.getNom () + "\" a �t� cr��." ;
          }
          else
          {
            getBaseDonnees ().update (mRisque) ;
            lMessage = "Le risque \"" + mRisque.getNom () + "\" a �t� mis � jour." ;
          }
        }
        // Valide les donn�es.
        getBaseDonnees ().commit () ;
        getBaseDonnees ().close () ;
        
        // Affiche la page de visualisation de la liste des probl�mes.
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