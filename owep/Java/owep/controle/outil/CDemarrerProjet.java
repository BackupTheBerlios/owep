package owep.controle.outil ;


import java.util.Date ;
import java.util.ResourceBundle;

import javax.servlet.ServletException ;

import org.exolab.castor.jdo.OQLQuery ;
import org.exolab.castor.jdo.PersistenceException ;
import org.exolab.castor.jdo.QueryResults ;

import owep.controle.CConstante;
import owep.controle.CControleurBase ;
import owep.modele.execution.MIteration ;
import owep.modele.execution.MTache ;


/**
 * Demarre le projet.
 */
public class CDemarrerProjet extends CControleurBase
{

  /*
   * (non-Javadoc)
   * 
   * @see owep.controle.CControleurBase#initialiserBaseDonnees()
   */
  public void initialiserBaseDonnees () throws ServletException
  {
    // TODO Auto-generated method stub

  }

  /*
   * (non-Javadoc)
   * 
   * @see owep.controle.CControleurBase#initialiserParametres()
   */
  public void initialiserParametres () throws ServletException
  {
    // TODO Auto-generated method stub

  }

  /*
   * (non-Javadoc)
   * 
   * @see owep.controle.CControleurBase#traiter()
   */
  public String traiter () throws ServletException
  {
    int idProjet = getSession ().getIdProjet () ;
    OQLQuery lRequete ;
    QueryResults lResultat ;
    ResourceBundle messages = java.util.ResourceBundle.getBundle("MessagesBundle");
    String lMessage = "";

    try
    {
      getBaseDonnees ().begin () ;
      lRequete = getBaseDonnees ().getOQLQuery ("select ITERATION from owep.modele.execution.MIteration ITERATION where mNumero = $1 AND mProjet.mId = $2") ;
      lRequete.bind(1);
      lRequete.bind (idProjet) ;
      lResultat = lRequete.execute () ;
      MIteration lIteration = (MIteration) lResultat.next () ;

      lIteration.setEtat (MIteration.ETAT_EN_COURS) ;
      Date date = new Date () ;
      lIteration.setDateDebutReelle (date) ;
      //On parcour la liste des taches de la nouvelle it�ration
      //et on passe l'�tat de celle qui peuvent commencer � pr�te
      //Une tache est pr�te � commencer si elle n'a aucune condition
      for (int i = 0 ; i < lIteration.getNbTaches () ; i++)
      {
        MTache lTache = lIteration.getTache (i) ;
        if (lTache.getNbConditions () == 0)
          lTache.setEtat (MTache.ETAT_NON_DEMARRE) ;
      }
      getSession().setIteration(lIteration);
      getBaseDonnees ().commit () ;
    }
    catch (PersistenceException e)
    {
      lMessage = messages.getString("demarrerProjetProbleme");
      e.printStackTrace () ;
    }
    finally
    {
      try
      {
        getBaseDonnees ().close () ;
      }
      catch (PersistenceException e1)
      {
        lMessage = messages.getString("demarrerProjetProbleme");
        e1.printStackTrace () ;
      }
    }

    if(lMessage.equals(""))
      lMessage = messages.getString("demarrerProjet");
    getRequete ().setAttribute (CConstante.PAR_MESSAGE, lMessage) ;
    
    // Affiche la page de visualisation des taches � r�aliser dans la nouvelle it�ration.
    return "/Tache/ListeTacheVisu" ;
  }

}