package owep.controle.processus;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.servlet.ServletException;
import org.exolab.castor.jdo.OQLQuery;
import org.exolab.castor.jdo.QueryResults;
import com.mysql.jdbc.Driver;
import owep.controle.CConstante;
import owep.controle.CControleurBase;
import owep.infrastructure.Session;
import owep.modele.execution.MActiviteImprevue;
import owep.modele.execution.MProjet;
import owep.vue.transfert.VTransfert;



/**
 * Description de la classe.
 */
public class CActiviteImprevue extends CControleurBase
{
  private MProjet    mProjet ;    // Projet actuellement ouvert par l'utilisateur.
  private MActiviteImprevue mActiviteImprevue ; // Activit� impr�vue � cr�er

  /**
   * TODO Description de initialiserBaseDonnees.
   * @throws ServletException
   * @see owep.controle.CControleurBase#initialiserBaseDonnees()
   */
  
  public void initialiserBaseDonnees () throws ServletException
  {
    // Si on acc�de pour la premi�re fois au controleur (ajout ou modification d'une it�ration).
    if (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_VIDE) ||
        getRequete ().getParameter (CConstante.PAR_MODIFIER) != null)
    {
      Session          lSession ;  // Session actuelle de l'utilisateur.
      OQLQuery         lRequete ;  // Requ�te � r�aliser sur la base
      QueryResults     lResultat ; // R�sultat de la requ�te sur la base
      
      lSession = (Session) getRequete ().getSession ().getAttribute (CConstante.SES_SESSION) ;
      mProjet  = lSession.getProjet () ;
      
      // Charge une copie du projet ouvert.
      try
      {
        getBaseDonnees ().begin () ;
        
        // R�cup�re la liste des t�ches du collaborateur.
        lRequete = getBaseDonnees ().getOQLQuery ("select PROJET from owep.modele.execution.MProjet PROJET where mId = $1") ;
        lRequete.bind (mProjet.getId ()) ;
        lResultat  = lRequete.execute () ;
        mProjet = (MProjet) lResultat.next () ;
        
        getBaseDonnees ().commit () ;
      }
      catch (Exception eException)
      {
        eException.printStackTrace () ;
        throw new ServletException (CConstante.EXC_TRAITEMENT) ;
      }
    }
  }

  /**
   * TODO Description de initialiserParametres.
   * @throws ServletException
   * @see owep.controle.CControleurBase#initialiserParametres()
   */
  
  public void initialiserParametres () throws ServletException
  {
  }

  /**
   * TODO Description de traiter.
   * @return
   * @throws ServletException
   * @see owep.controle.CControleurBase#traiter()
   */
  
  public String traiter () throws ServletException
  {
    if (! VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMIT))
    {
      // Transmet les donn�es � la JSP d'affichage.
      return "..\\JSP\\Processus\\TActiviteImprevue.jsp" ;
    }
    else
    {    
      Connection lConnection = null ;
      try
      {
        mActiviteImprevue = new MActiviteImprevue ();
        VTransfert.transferer (getRequete (), mActiviteImprevue, CConstante.PAR_ARBREACTIVITE) ;
        mActiviteImprevue.setProjet (mProjet);
        
        DriverManager.registerDriver (new Driver ()) ;
        lConnection = DriverManager.getConnection ("jdbc:mysql://localhost/owep", "root", "mysql") ;
        lConnection.setAutoCommit(false);
        mActiviteImprevue.create (lConnection) ;
        lConnection.commit () ;
        
        

        mProjet.addActiviteImprevue (mActiviteImprevue) ;
        getSession ().ouvrirProjet (mProjet) ;
        return "..\\JSP\\Processus\\TActiviteImprevue.jsp" ;
      }
      catch (Exception eException)
      {
        eException.printStackTrace () ;
        throw new ServletException (CConstante.EXC_TRAITEMENT) ;
      }
      // Ferme la connexion � la base de donn�es.
      finally
      {        
        try
        {
          lConnection.close () ;
        }
        catch (SQLException eException)
        {
          eException.printStackTrace () ;
          throw new ServletException (CConstante.EXC_DECONNEXION) ;
        } 
      }
    }    
  }
}
