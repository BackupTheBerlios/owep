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
import owep.infrastructure.localisation.LocalisateurIdentifiant;
import owep.infrastructure.Session;
import owep.modele.execution.MActiviteImprevue;
import owep.modele.execution.MProjet;
import owep.modele.execution.MTacheImprevue;
import owep.vue.transfert.VTransfert;



/**
 * Description de la classe.
 */
public class CActiviteImprevue extends CControleurBase
{
  private MProjet    mProjet ;    // Projet actuellement ouvert par l'utilisateur.
  private MActiviteImprevue mActiviteImprevue ; // Activité imprévue à créer

  /**
   * TODO Description de initialiserBaseDonnees.
   * @throws ServletException
   * @see owep.controle.CControleurBase#initialiserBaseDonnees()
   */
  
  public void initialiserBaseDonnees () throws ServletException
  {
    // Si on accède pour la première fois au controleur (ajout ou modification d'une itération).
    if (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_VIDE) ||
        getRequete ().getParameter (CConstante.PAR_MODIFIER) != null)
    {
      Session          lSession ;  // Session actuelle de l'utilisateur.
      OQLQuery         lRequete ;  // Requête à réaliser sur la base
      QueryResults     lResultat ; // Résultat de la requête sur la base
      
      lSession = (Session) getRequete ().getSession ().getAttribute (CConstante.SES_SESSION) ;
      mProjet  = lSession.getProjet () ;
      
      // Charge une copie du projet ouvert.
      try
      {
        getBaseDonnees ().begin () ;
        
        // Récupère la liste des tâches du collaborateur.
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
    if ((! VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMIT)) &&
        (! VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMITMODIFIER)) &&
        (! VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMITSUPPRIMER)))
    {
      // Transmet les données à la JSP d'affichage.
      return "..\\JSP\\Processus\\TActiviteImprevue.jsp" ;
    }
    else
    {    
        Connection lConnection = null ;
        
        try
        {
          DriverManager.registerDriver (new Driver ()) ;
	      lConnection = DriverManager.getConnection ("jdbc:mysql://localhost/owep", LocalisateurIdentifiant.LID_BDUSER, LocalisateurIdentifiant.LID_BDPASS) ;
	      lConnection.setAutoCommit(false);
          if (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMIT))
          {
            
            mActiviteImprevue = new MActiviteImprevue ();
            VTransfert.transferer (getRequete (), mActiviteImprevue, CConstante.PAR_ARBREACTIVITE) ;
	        mActiviteImprevue.setProjet (mProjet);
	        
	    //    getBaseDonnees().begin();
	      //  getBaseDonnees().create(mActiviteImprevue);
	        //getBaseDonnees ().commit () ;
	        mActiviteImprevue.create (lConnection) ;
	        lConnection.commit () ;
	
	        mProjet.addActiviteImprevue (mActiviteImprevue) ;
	        getSession ().ouvrirProjet (mProjet) ;
          }
          else if(VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMITSUPPRIMER))
          {
            int lIndiceActiviteImprevue = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTEACTIVITESIMPREVUES));
            MActiviteImprevue lActiviteImprevue = mProjet.getActiviteImprevue (lIndiceActiviteImprevue);
            for (int i =lActiviteImprevue.getNbTachesImprevues (); i > 0; i--){
              MTacheImprevue lTacheImprevue = lActiviteImprevue.getTacheImprevue(i);
              for (int j = lTacheImprevue.getNbArtefactsImprevuesEntrees (); j > 0; j--){
                lTacheImprevue.supprimerArtefactImprevueEntree (j) ;
              }
              for (int j = lTacheImprevue.getNbArtefactsImprevuesSorties (); j > 0; j--){
                lTacheImprevue.supprimerArtefactImprevueSortie (j) ;
              }
              lActiviteImprevue.supprimerTacheImprevue (i);
            }
            lActiviteImprevue.delete (lConnection) ;
            mProjet.supprimerActiviteImprevue (lIndiceActiviteImprevue) ;
            lConnection.commit ();
          }
          else if(VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMITMODIFIER))
          {
            int lIndiceActiviteImprevue     = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTEACTIVITESIMPREVUES)) ;
            MActiviteImprevue lActiviteImprevueTmp = new MActiviteImprevue ();
            VTransfert.transferer (getRequete (), lActiviteImprevueTmp, CConstante.PAR_ARBREACTIVITE) ;
            
            MActiviteImprevue lActiviteImprevue = mProjet.getActiviteImprevue(lIndiceActiviteImprevue);
            lActiviteImprevue.setNom(lActiviteImprevueTmp.getNom());
            lActiviteImprevue.setDescription(lActiviteImprevueTmp.getDescription());
            lActiviteImprevue.update(lConnection);
            lConnection.commit();
          }   
        }
        catch (Exception eException)
        {
          eException.printStackTrace () ;
          throw new ServletException (CConstante.EXC_TRAITEMENT) ;
        }
        // Ferme la connexion à la base de données.
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
    return "..\\JSP\\Processus\\TActiviteImprevue.jsp" ;
  }
}
