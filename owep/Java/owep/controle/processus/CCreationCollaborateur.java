package owep.controle.processus ;


import javax.servlet.ServletException ;

import org.exolab.castor.jdo.OQLQuery ;
import org.exolab.castor.jdo.PersistenceException ;
import org.exolab.castor.jdo.QueryResults ;

import owep.controle.CConstante ;
import owep.controle.CControleurBase ;
import owep.modele.execution.MCollaborateur ;


/**
 * Controleur pour la cr�ation d'un collaborateur
 */
public class CCreationCollaborateur extends CControleurBase
{
  private String mPageSource ; // Page appelant la cr�ation d'un collaborateur

  private String mNom ; // Nom du collaborateur � cr�er
  private String mPrenom ; // Prenom du collaborateur � cr�er
  private String mLogin ; // Login du collaborateur � cr�er
  private String mMail ; // Email du collaborateur � cr�er
  private String mAdresse ; // Adresse du collaborateur � cr�er
  private String mTelephone ; // Num�ro du telephone du collaborateur � cr�er
  private String mPortable ; // Num�ro du portable du collaborateur � cr�er
  private String mCommentaire ; // Commentaire du collaborateur � cr�er
  private String mMdp ; // Mot de passe du collaborateur � cr�er

  private MCollaborateur mCollaborateur ; // Collaborateur � cr�er


  /**
   * R�cup�re les donn�es n�cessaire au controleur dans la base de donn�es.
   * 
   * @throws ServletException Si une erreur survient durant la connexion
   * @see owep.controle.CControleurBase#initialiserBaseDonnees()
   */
  public void initialiserBaseDonnees () throws ServletException
  {
  }

  /**
   * Initialise le controleur et r�cup�re les param�tres.
   * 
   * @throws ServletException Si une erreur sur les param�tres survient
   * @see owep.controle.CControleurBase#initialiserParametres()
   */
  public void initialiserParametres () throws ServletException
  {
    mPageSource = getRequete ().getParameter ("mPageSource") ;

    mNom = getRequete ().getParameter ("mNom") ;
    mPrenom = getRequete ().getParameter ("mPrenom") ;
    mLogin = getRequete ().getParameter ("mLogin") ;
    mMail = getRequete ().getParameter ("mMail") ;
    mAdresse = getRequete ().getParameter ("mAdresse") ;
    mTelephone = getRequete ().getParameter ("mTelephone") ;
    mPortable = getRequete ().getParameter ("mPortable") ;
    mCommentaire = getRequete ().getParameter ("mCommentaire") ;
    mMdp = mLogin ;
  }

  /**
   * Redirige vers la JSP d'affichage de la page de cr�ation d'un collaborateur.
   * 
   * @return URL de la page qui doit �tre affich�e.
   * @throws ServletException si une erreur survient dans le controleur.
   * @see owep.controle.CControleurBase#traiter()
   */
  public String traiter () throws ServletException
  {
    OQLQuery lRequete ; // Requ�te � r�aliser sur la base
    QueryResults lResultat ; // R�sultat de la requ�te sur la base

    if (mNom == null)
    {
      getRequete ().setAttribute ("mPageSource", getRequete ().getHeader ("referer")) ;
      return "..\\JSP\\Processus\\CreationCollaborateur.jsp" ;
    }

    if (mNom.equals (""))
    {
      renvoieAttribut () ;
      getRequete ().setAttribute ("mProbleme", "nom") ;
      return "..\\JSP\\Processus\\CreationCollaborateur.jsp" ;
    }

    if (mLogin.equals (""))
    {
      renvoieAttribut () ;
      getRequete ().setAttribute ("mProbleme", "login") ;
      return "..\\JSP\\Processus\\CreationCollaborateur.jsp" ;
    }

    if (mMail.equals (""))
    {
      renvoieAttribut () ;
      getRequete ().setAttribute ("mProbleme", "mail") ;
      return "..\\JSP\\Processus\\CreationCollaborateur.jsp" ;
    }

    try
    {
      getBaseDonnees ().begin () ;

      // Cherche la pr�sence de collaborateur ayant le login demand� par le nouveau
      lRequete = getBaseDonnees ()
        .getOQLQuery (
                      "select COLLABORATEUR from owep.modele.execution.MCollaborateur COLLABORATEUR where mUtilisateur = $1") ;
      lRequete.bind (mLogin) ;
      lResultat = lRequete.execute () ;

      // V�rifie que le compte utilisateur n'est pas d�j� pr�sent
      if (lResultat.size () != 0)
      {
        getBaseDonnees ().commit () ;
        getBaseDonnees ().close () ;

        getRequete ().setAttribute ("mProbleme", "unique") ;
        renvoieAttribut () ;
        return "..\\JSP\\Processus\\CreationCollaborateur.jsp" ;
      }

      // Cr�� le nouveau collaborateur
      mCollaborateur = new MCollaborateur (mPrenom, mNom, mAdresse, mTelephone, mPortable, mMail,
                                           mCommentaire, mLogin, mMdp) ;

      // Enregistre le nouveau collaborateur dans la base de donn�es
      getBaseDonnees ().create (mCollaborateur) ;
      getBaseDonnees ().commit () ;
      getBaseDonnees ().close () ;

      getRequete ().setAttribute ("mProbleme", "false") ;
      getRequete ().setAttribute ("mPageSource", mPageSource) ;
      return "..\\JSP\\Processus\\CreationCollaborateur.jsp" ;
    }
    catch (PersistenceException e)
    {
      e.printStackTrace () ;
      throw new ServletException (CConstante.EXC_TRAITEMENT) ;
    }
    // Ferme la connexion � la base de donn�es.
    finally
    {
      try
      {
        getBaseDonnees ().close () ;
      }
      catch (PersistenceException eException)
      {
        eException.printStackTrace () ;
        throw new ServletException (CConstante.EXC_DECONNEXION) ;
      }
    }

  }

  /**
   * Transmet les attributs � la page jsp
   */
  private void renvoieAttribut ()
  {
    getRequete ().setAttribute ("mPageSource", mPageSource) ;

    getRequete ().setAttribute ("mNom", (mNom == null ? "" : mNom)) ;
    getRequete ().setAttribute ("mPrenom", (mPrenom == null ? "" : mPrenom)) ;
    getRequete ().setAttribute ("mLogin", (mLogin == null ? "" : mLogin)) ;
    getRequete ().setAttribute ("mMail", (mMail == null ? "" : mMail)) ;
    getRequete ().setAttribute ("mAdresse", (mAdresse == null ? "" : mAdresse)) ;
    getRequete ().setAttribute ("mTelephone", (mTelephone == null ? "" : mTelephone)) ;
    getRequete ().setAttribute ("mPortable", (mPortable == null ? "" : mPortable)) ;
    getRequete ().setAttribute ("mCommentaire", (mCommentaire == null ? "" : mCommentaire)) ;
  }

}