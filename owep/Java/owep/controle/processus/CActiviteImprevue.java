package owep.controle.processus;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.servlet.ServletException;
import org.exolab.castor.jdo.OQLQuery;
import org.exolab.castor.jdo.PersistenceException;
import org.exolab.castor.jdo.QueryResults;
import org.exolab.castor.jdo.TransactionAbortedException;
import org.exolab.castor.jdo.TransactionNotInProgressException;
import com.mysql.jdbc.Driver;
import owep.controle.CConstante;
import owep.controle.CControleurBase;
import owep.infrastructure.localisation.LocalisateurIdentifiant;
import owep.infrastructure.Session;
import owep.modele.execution.MActiviteImprevue;
import owep.modele.execution.MArtefactImprevue;
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
    if ((! VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMIT)) ||
      (! VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMITMODIFIER)) ||
      (! VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMITSUPPRIMER)))
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
        
        // Récupère le projet ouvert.
        lRequete = getBaseDonnees ().getOQLQuery ("select PROJET from owep.modele.execution.MProjet PROJET where mId = $1") ;
        lRequete.bind (mProjet.getId ()) ;
        lResultat  = lRequete.execute () ;
        mProjet = (MProjet) lResultat.next () ;
        
        getRequete ().setAttribute (CConstante.PAR_PROJET, mProjet) ;
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
      try
      {
        getBaseDonnees().commit();
      }
      catch (TransactionNotInProgressException e)
      {
        // TODO Ecrire le bloc try-catch.
        e.printStackTrace () ;
      }
      catch (TransactionAbortedException e)
      {
        // TODO Ecrire le bloc try-catch.
        e.printStackTrace () ;
      }
      finally
      {        
        try
        {
          getBaseDonnees().close () ;
        }
        catch (PersistenceException e)
        {
          // TODO Ecrire le bloc try-catch.
          e.printStackTrace () ;
        }
      }
    }
    else
    {    
        try
        {
          // Ajout d'une activité imprévue
          if (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMIT))
          {
            
            mActiviteImprevue = new MActiviteImprevue ();
            VTransfert.transferer (getRequete (), mActiviteImprevue, CConstante.PAR_ARBREACTIVITE) ;
	        mActiviteImprevue.setProjet (mProjet);
	        mProjet.addActiviteImprevue (mActiviteImprevue) ;
	        
	        getBaseDonnees().create(mActiviteImprevue);
	        //getSession ().setProjet(mProjet) ;
          }
          // Suppression d'une activité imprévue
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
            mProjet.supprimerActiviteImprevue (lIndiceActiviteImprevue) ;
           }
          // Modification d'une activité imprévue.
          else if(VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMITMODIFIER))
          {
            Session          lSession ;  // Session actuelle de l'utilisateur.
            OQLQuery         lRequete ;  // Requête à réaliser sur la base
            QueryResults     lResultat ; // Résultat de la requête sur la base
            
            int lIndiceActiviteImprevue     = Integer.parseInt (getRequete ().getParameter (CConstante.PAR_LISTEACTIVITESIMPREVUES)) ;
            MActiviteImprevue lActiviteImprevueTmp = new MActiviteImprevue ();
            VTransfert.transferer (getRequete (), lActiviteImprevueTmp, CConstante.PAR_ARBREACTIVITE) ;
            
            int lIdActiviteImprevue = mProjet.getActiviteImprevue (lIndiceActiviteImprevue).getId () ;
            
            lRequete = getBaseDonnees ().getOQLQuery ("select ACTIVITEIMPREVUE from owep.modele.execution.MActiviteImprevue ACTIVITEIMPREVUE where mId = $1") ;
            lRequete.bind (lIdActiviteImprevue) ;
            lResultat  = lRequete.execute () ;
            MActiviteImprevue lActiviteImprevue = (MActiviteImprevue) lResultat.next () ;
            
            lActiviteImprevue.setNom(lActiviteImprevueTmp.getNom());
            lActiviteImprevue.setDescription(lActiviteImprevueTmp.getDescription());
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
            getBaseDonnees ().commit () ;
            getBaseDonnees().close () ;
            getRequete ().setAttribute (CConstante.PAR_PROJET, mProjet) ;
          }
          catch (PersistenceException e)
          {
            // TODO Ecrire le bloc try-catch.
            e.printStackTrace () ;
          }
        }
      }
    return "..\\JSP\\Processus\\TActiviteImprevue.jsp" ;
  }
}
