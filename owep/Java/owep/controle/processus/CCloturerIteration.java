/*
 * Created on 25 févr. 2005
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package owep.controle.processus;

import java.util.Date;

import javax.servlet.ServletException;

import org.exolab.castor.jdo.OQLQuery;
import org.exolab.castor.jdo.QueryResults;

import owep.controle.CConstante;
import owep.controle.CControleurBase;
import owep.infrastructure.Session;
import owep.modele.execution.MIteration;
import owep.modele.execution.MProjet;
import owep.modele.execution.MTache;
import owep.vue.transfert.VTransfert ;

/**
 * @author Victor Nancy
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class CCloturerIteration extends CControleurBase
{

    private MProjet   mProjet ;          // Projet actuellement ouvert.
    private MIteration mIteration ;      // Itération à cloturer.
    
    
    /**
     * Récupère les données nécessaire au controleur dans la base de données. 
     * @throws ServletException Si une erreur survient durant la connexion à la base.
     */
    public void initialiserBaseDonnees () throws ServletException
    {
      Session      lSession ;     // Session actuelle de l'utilisateur.
      OQLQuery     lRequete ;     // Requête à réaliser sur la base.
      QueryResults lResultat ;    // Résultat de la requête sur la base.
      
      lSession     = (Session) getRequete ().getSession ().getAttribute (CConstante.SES_SESSION) ;
      mProjet      = lSession.getProjet () ;
      
      
      try
      {
        getBaseDonnees ().begin () ;
        
        // Récupère le projet actuellement ouvert.
        lRequete = getBaseDonnees ().getOQLQuery ("select PROJET from owep.modele.execution.MProjet PROJET where mId = $1") ;
        lRequete.bind (mProjet.getId ()) ;
        lResultat = lRequete.execute () ;
        // Si on récupère correctement le projet dans la base,
        if (lResultat.hasMore ())
        {
          mProjet = (MProjet) lResultat.next () ;
        }
        // Si le projet n'existe pas,
        else
        {
          throw new ServletException (CConstante.EXC_TRAITEMENT) ;
        }
        
        getBaseDonnees().commit();
        getBaseDonnees().begin();
        
          // Charge l'itération en cours.
          lRequete = getBaseDonnees ().getOQLQuery ("select ITERATION from owep.modele.execution.MIteration ITERATION where mEtat = $1 AND mProjet.mId = $2") ;
          lRequete.bind (MIteration.ETAT_EN_COURS) ;
          lRequete.bind (mProjet.getId ()) ;
          lResultat = lRequete.execute () ;
          // Si on récupère correctement l'itération dans la base,
          if (lResultat.hasMore ())
          {
            mIteration = (MIteration) lResultat.next () ;
          }
          // Si l'itération n'existe pas ou n'appartient pas au projet ouvert,
          else
          {
            throw new ServletException (CConstante.EXC_TRAITEMENT) ;
          }
          
      }
      catch (Exception eException)
      {
        eException.printStackTrace () ;
        throw new ServletException (CConstante.EXC_TRAITEMENT) ;
      }
    }
    
    
    /**
     * Récupère les paramètres passés au contrôleur. 
     * @throws ServletException -
     */
    public void initialiserParametres () throws ServletException
    {
      // Si l'utilisateur valide les données, récupère les données.
      if (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMIT))
      {
        VTransfert.transferer (getRequete (), mIteration, CConstante.PAR_ARBREITERATION) ;
      }
      //Sinon on initialise la date de fin réelle à la date du jour
      else
      {
        mIteration.setDateFinReelle(new Date());
      }
    }
    
    
    /**
     * Transmet le problème à la JSP d'affichage si aucune données n'est soumise. Sinon, met à jour ou
     * insère le problème.
     * @return URL de la page vers laquelle doit être redirigé le client.
     * @throws ServletException Si une erreur survient dans le controleur
     */
    public String traiter () throws ServletException
    {
      try
      {
        // Si l'utilisateur affiche la page pour la première fois,
        if (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_VIDE))
        {
          getBaseDonnees ().commit() ;
          getBaseDonnees ().close () ;
          
          // Si l'utilisateur accède à la page de cloturation, transmet les données à la page.
          getRequete ().setAttribute (CConstante.PAR_ITERATION, mIteration) ;
          getRequete ().setAttribute (CConstante.PAR_PROJET, mProjet) ;
                    
          // Affiche la page de modification de problème.
          return "/JSP/Processus/TCloturerIteration.jsp" ;
        }
        else
        {
          Session      lSession ;     // Session actuelle de l'utilisateur.
          OQLQuery     lRequete ;     // Requête à réaliser sur la base.
          QueryResults lResultat ;    // Résultat de la requête sur la base.
          
          lSession     = (Session) getRequete ().getSession ().getAttribute (CConstante.SES_SESSION) ;
          mProjet      = lSession.getProjet () ;
          
          /*************** Modification de l'itération en cours ************/
         
          //L'état passe à terminée
          mIteration.setEtat(MIteration.ETAT_TERMINE);
          // Si l'utilisateur valide les données, alors on les enregistre dans la base.
          if (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMIT))
          {
            getBaseDonnees().commit();
            getBaseDonnees().begin();
            getBaseDonnees().update (mIteration) ;
          }
          
          
          /***************** Ensuite on change d'itération *****************/
          
          //Récupération de l'itération suivante (numéro sivant)
          MIteration mNouvelleIteration ;
          lRequete = getBaseDonnees ().getOQLQuery ("select ITERATION from owep.modele.execution.MIteration ITERATION where mNumero = $1 AND mProjet.mId = $2") ;
          lRequete.bind (mIteration.getNumero()+1) ;
          lRequete.bind (mProjet.getId ()) ;
          lResultat = lRequete.execute () ;

          // Si on récupère correctement l'itération dans la base,
          if (lResultat.hasMore ())
          {
            mNouvelleIteration = (MIteration) lResultat.next () ;
            
            //On change l'état à en_cours
            mNouvelleIteration.setEtat(MIteration.ETAT_EN_COURS);
            //On valorise la date de début réelle à la date de fin réelle de l'itération précédente
            mNouvelleIteration.setDateDebutReelle(mIteration.getDateFinReelle());
            //On parcour la liste des taches de la nouvelle itération
            //et on passe l'état de celle qui peuvent commencer à prète
            //Une tache est prète à commencer si elle n'a aucune condition
            for (int i = 0; i < mNouvelleIteration.getNbTaches(); i ++)
            {
              MTache lTache = mNouvelleIteration.getTache (i) ;
              if (lTache.getNbConditions()==0)
                lTache.setEtat(MTache.ETAT_NON_DEMARRE);
            }
            getBaseDonnees().commit();
            getBaseDonnees().begin();
            getBaseDonnees ().update (mNouvelleIteration) ;
          }
          // Si l'itération n'existe pas ou n'appartient pas au projet ouvert,
          else
          {
            throw new ServletException (CConstante.EXC_TRAITEMENT) ;
          }

          // Valide les données.
          getBaseDonnees ().commit () ;
          getBaseDonnees ().close () ;
          
          getSession().setIteration(mNouvelleIteration);

          // Affiche la page de visualisation des taches à réaliser dans la nouvelle itération.
          return "/Tache/ListeTacheVisu" ;
        }
      }
      catch (Exception eException)
      {
        eException.printStackTrace () ;
        throw new ServletException (CConstante.EXC_TRAITEMENT) ;
      }
    }
  }
