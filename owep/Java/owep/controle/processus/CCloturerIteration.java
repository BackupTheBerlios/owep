/*
 * Created on 25 f�vr. 2005
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
    private MIteration mIteration ;      // It�ration � cloturer.
    
    
    /**
     * R�cup�re les donn�es n�cessaire au controleur dans la base de donn�es. 
     * @throws ServletException Si une erreur survient durant la connexion � la base.
     */
    public void initialiserBaseDonnees () throws ServletException
    {
      Session      lSession ;     // Session actuelle de l'utilisateur.
      OQLQuery     lRequete ;     // Requ�te � r�aliser sur la base.
      QueryResults lResultat ;    // R�sultat de la requ�te sur la base.
      
      lSession     = (Session) getRequete ().getSession ().getAttribute (CConstante.SES_SESSION) ;
      mProjet      = lSession.getProjet () ;
      
      
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
        
        getBaseDonnees().commit();
        getBaseDonnees().begin();
        
          // Charge l'it�ration en cours.
          lRequete = getBaseDonnees ().getOQLQuery ("select ITERATION from owep.modele.execution.MIteration ITERATION where mEtat = $1 AND mProjet.mId = $2") ;
          lRequete.bind (MIteration.ETAT_EN_COURS) ;
          lRequete.bind (mProjet.getId ()) ;
          lResultat = lRequete.execute () ;
          // Si on r�cup�re correctement l'it�ration dans la base,
          if (lResultat.hasMore ())
          {
            mIteration = (MIteration) lResultat.next () ;
          }
          // Si l'it�ration n'existe pas ou n'appartient pas au projet ouvert,
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
     * R�cup�re les param�tres pass�s au contr�leur. 
     * @throws ServletException -
     */
    public void initialiserParametres () throws ServletException
    {
      // Si l'utilisateur valide les donn�es, r�cup�re les donn�es.
      if (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMIT))
      {
        VTransfert.transferer (getRequete (), mIteration, CConstante.PAR_ARBREITERATION) ;
      }
      //Sinon on initialise la date de fin r�elle � la date du jour
      else
      {
        mIteration.setDateFinReelle(new Date());
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
          getBaseDonnees ().commit() ;
          getBaseDonnees ().close () ;
          
          // Si l'utilisateur acc�de � la page de cloturation, transmet les donn�es � la page.
          getRequete ().setAttribute (CConstante.PAR_ITERATION, mIteration) ;
          getRequete ().setAttribute (CConstante.PAR_PROJET, mProjet) ;
                    
          // Affiche la page de modification de probl�me.
          return "/JSP/Processus/TCloturerIteration.jsp" ;
        }
        else
        {
          Session      lSession ;     // Session actuelle de l'utilisateur.
          OQLQuery     lRequete ;     // Requ�te � r�aliser sur la base.
          QueryResults lResultat ;    // R�sultat de la requ�te sur la base.
          
          lSession     = (Session) getRequete ().getSession ().getAttribute (CConstante.SES_SESSION) ;
          mProjet      = lSession.getProjet () ;
          
          /*************** Modification de l'it�ration en cours ************/
         
          //L'�tat passe � termin�e
          mIteration.setEtat(MIteration.ETAT_TERMINE);
          // Si l'utilisateur valide les donn�es, alors on les enregistre dans la base.
          if (VTransfert.getValeurTransmise (getRequete (), CConstante.PAR_SUBMIT))
          {
            getBaseDonnees().commit();
            getBaseDonnees().begin();
            getBaseDonnees().update (mIteration) ;
          }
          
          
          /***************** Ensuite on change d'it�ration *****************/
          
          //R�cup�ration de l'it�ration suivante (num�ro sivant)
          MIteration mNouvelleIteration ;
          lRequete = getBaseDonnees ().getOQLQuery ("select ITERATION from owep.modele.execution.MIteration ITERATION where mNumero = $1 AND mProjet.mId = $2") ;
          lRequete.bind (mIteration.getNumero()+1) ;
          lRequete.bind (mProjet.getId ()) ;
          lResultat = lRequete.execute () ;

          // Si on r�cup�re correctement l'it�ration dans la base,
          if (lResultat.hasMore ())
          {
            mNouvelleIteration = (MIteration) lResultat.next () ;
            
            //On change l'�tat � en_cours
            mNouvelleIteration.setEtat(MIteration.ETAT_EN_COURS);
            //On valorise la date de d�but r�elle � la date de fin r�elle de l'it�ration pr�c�dente
            mNouvelleIteration.setDateDebutReelle(mIteration.getDateFinReelle());
            //On parcour la liste des taches de la nouvelle it�ration
            //et on passe l'�tat de celle qui peuvent commencer � pr�te
            //Une tache est pr�te � commencer si elle n'a aucune condition
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
          // Si l'it�ration n'existe pas ou n'appartient pas au projet ouvert,
          else
          {
            throw new ServletException (CConstante.EXC_TRAITEMENT) ;
          }

          // Valide les donn�es.
          getBaseDonnees ().commit () ;
          getBaseDonnees ().close () ;
          
          getSession().setIteration(mNouvelleIteration);

          // Affiche la page de visualisation des taches � r�aliser dans la nouvelle it�ration.
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
