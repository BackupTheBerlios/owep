package owep.controle.outil ;


import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * @author lalo TODO To change the template for this generated type comment go to Window -
 *         Preferences - Java - Code Style - Code Templates
 */
public class CConnexion extends HttpServlet
{
  private HttpServletRequest  mRequete ;              // Requ�te HTTP � l'origine de l'appel du controleur
  private HttpServletResponse mReponse ;              // R�ponse HTTP du controleur � la requ�te
  private Database            mBaseDonnees ;          // Connexion � la base de donn�es
  private MCollaborateur      mCollaborateur = null ; // Collaborateur correspondant au login et mot de passe
  private String              mLogin         = null ; // Login saisi
  private String              mPassword      = null ; // mot de passe saisi


  /**
   * Appell� lors d'une requ�te d'un client. Redirige le client vers la page retourn� par la m�thode
   * traiter.
   * @param pRequete Requ�te HTTP � l'origine de l'appel du controleur
   * @param pReponse R�ponse HTTP du controleur � la requ�te
   * @throws ServletException Si une erreur survient durant le traitement de la page.
   * @throws IOException Si une erreur survient durant le traitement de la page.
   */
  protected void doGet (HttpServletRequest pRequete, HttpServletResponse pReponse)
    throws ServletException, IOException
  {
    doPost (pRequete, pReponse) ;
  }


  /**
   * Appell� lors d'une requ�te d'un client contenant des donn�es transmises. Redirige le client
   * vers la page retourn� par la m�thode traiter.
   * @param pRequete Requ�te HTTP � l'origine de l'appel du controleur
   * @param pReponse R�ponse HTTP du controleur � la requ�te
   * @throws ServletException Si une erreur survient durant le traitement de la page.
   * @throws IOException Si une erreur survient durant le traitement de la page.
   */
  protected void doPost (HttpServletRequest pRequete, HttpServletResponse pReponse)
    throws ServletException, IOException
  {
    RequestDispatcher lRequeteDispatcher ; // Permet d'appeler la JSP d'affichage.
    JDO lJdo ; // Charge le syst�me de persistence avec la base de donn�es
    
    // Initialise les variables membres.
    mRequete = pRequete ;
    mReponse = pReponse ;
    
    // Initie la connexion � la base de donn�es.
    try
    {
      JDO.loadConfiguration (LocalisateurIdentifiant.LID_BDCONFIGURATION) ;
      lJdo         = new JDO (LocalisateurIdentifiant.LID_BDNOM) ;
      mBaseDonnees = lJdo.getDatabase () ;
      mBaseDonnees.setAutoStore (false) ;
    }
    catch (Exception eException)
    {
      eException.printStackTrace () ;
      throw new ServletException (CConstante.EXC_CONNEXION) ;
    }
    
    // Appelle la JSP d'affichage retourn�e par traiter.
    initialiserParametres () ;
    initialiserBaseDonnees () ;
    lRequeteDispatcher = pRequete.getRequestDispatcher (traiter ()) ;
    if (lRequeteDispatcher == null)
    {
      throw new ServletException (CConstante.EXC_FORWARD) ;
    }
    else
    {
      lRequeteDispatcher.forward (mRequete, mReponse) ;
    }
  }


  /**
   * R�cup�re une connexion � la base de donn�es.
   * @return Connexion � la base de donn�es.
   */
  public Database getBaseDonnees ()
  {
    return mBaseDonnees ;
  }


  /**
   * R�cup�re la r�ponse HTTP que le controleur va fournir au client.
   * @return R�ponse HTTP du controleur.
   */
  public HttpServletResponse getReponse ()
  {
    return mReponse ;
  }


  /**
   * R�cup�re la requ�te HTTP � l'origine de l'appel du controleur.
   * @return Requ�te HTTP � l'origine de l'appel du controleur.
   */
  public HttpServletRequest getRequete ()
  {
    return mRequete ;
  }


  private void initialiserBaseDonnees () throws ServletException
  {
    OQLQuery lRequete ;      // Requ�te � r�aliser sur la base
    QueryResults lResultat ; // R�sultat de la requ�te sur la base
    
    try
    {
      getBaseDonnees ().begin () ;
      
      // R�cup�re la liste des t�ches du collaborateur.
      lRequete = getBaseDonnees ().getOQLQuery ("select COLLABORATEUR from owep.modele.execution.MCollaborateur COLLABORATEUR where mUtilisateur = $1") ;
      lRequete.bind (mLogin) ;
      lResultat = lRequete.execute () ;
      
      if (lResultat.size () > 0)
      {
        // On suppose que le nom est unique
        mCollaborateur = (MCollaborateur) lResultat.next () ;
      }
      getBaseDonnees ().commit () ;
    }
    catch (Exception eException)
    {
      eException.printStackTrace () ;
      throw new ServletException (CConstante.EXC_TRAITEMENT) ;
    }
  }


  /**
   * R�cup�re les param�tres pass�s au controleur.
   */
  public void initialiserParametres ()
  {
    mLogin    = getRequete ().getParameter ("login") ;
    mPassword = getRequete ().getParameter ("pwd") ;
  }


  /**
   * Effectue tout le tra�tement du controleur puis retourne l'URL vers laquelle le client doit �tre
   * redirig�.
   * @return URL de la page vers laquelle doit �tre redirig� le client.
   */
  public String traiter ()
  {
    if (mCollaborateur != null && mPassword.equals (mCollaborateur.getMotDePasse ()))
    {
      // Cr�ation de la classe Session
      Session mSession = new Session () ;
      mSession.ouvertureSession (mCollaborateur) ;
      
      // Cr�ation de la session HTTP
      HttpSession session = getRequete ().getSession (true) ;
      session.setAttribute ("SESSION", mSession) ;
      return "..\\Tache\\ListeTacheVisu" ;
    }
    else
    {
      getRequete ().getSession ().invalidate () ;
      return "..\\JSP\\Tache\\Erreur.jsp" ;
    }
  }
}