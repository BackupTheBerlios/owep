/*
 * Created on 27 nov. 2004
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package owep.controle;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.exolab.castor.jdo.Database;
import org.exolab.castor.jdo.DatabaseNotFoundException;
import org.exolab.castor.jdo.JDO;
import org.exolab.castor.jdo.PersistenceException;
import org.exolab.castor.mapping.MappingException;

/**
 * @author Administrateur
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public abstract class CControleurBase extends HttpServlet
{
  private HttpServletRequest  mRequete ;
  private HttpServletResponse mReponse ;
  private Database mBaseDonnees ;
  public static final String CONFIGURATION_DATABASE = "D:\\Projet\\OWEP\\Source\\WEB-INF\\Database.xml" ;
  public static final String NOM_DATABASE = "owep" ;
  
  /**
   * 
   */
  public CControleurBase ()
  {
    super() ;
    // TODO Auto-generated constructor stub
  }
  
  
  /* (non-Javadoc)
   * @see javax.servlet.http.HttpServlet#doGet(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
   */
  protected void doGet (HttpServletRequest pRequete, HttpServletResponse pReponse)
      throws ServletException, IOException
  {
    doPost (pRequete, pReponse) ;
  }
  
  /* (non-Javadoc)
   * @see javax.servlet.http.HttpServlet#doPost(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
   */
  protected void doPost (HttpServletRequest pRequete, HttpServletResponse pReponse)
      throws ServletException, IOException
  {
    RequestDispatcher lRequeteDispatcher ;  // Permet d'appeler la JSP d'affichage.
    
    // initialise les variables membres
    mRequete = pRequete ;
    mReponse = pReponse ;
    
    // Appelle la JSP d'affichage.
    lRequeteDispatcher = pRequete.getRequestDispatcher (traiter ()) ;
    if (lRequeteDispatcher == null)
    {
      throw new ServletException ("La page n'a pu être trouvée.") ;
    }
    else
    {
      lRequeteDispatcher.forward (mRequete, mReponse) ;
    }
  }
  
  public abstract String traiter () throws ServletException ;
  
  /**
   * @return Returns the reponse.
   */
  public HttpServletResponse getReponse ()
  {
    return mReponse ;
  }
  
  /**
   * @return Returns the requete.
   */
  public HttpServletRequest getRequete ()
  {
    return mRequete ;
  }
  
  public void connexionBD () throws MappingException, DatabaseNotFoundException, PersistenceException
  {
    JDO lJdo ; 
   
    JDO.loadConfiguration (CONFIGURATION_DATABASE) ;
    lJdo = new JDO (NOM_DATABASE) ;

    mBaseDonnees = lJdo.getDatabase () ;
    mBaseDonnees.begin () ;  
  }
  
  public void deconnexionBD () throws PersistenceException
  {
    mBaseDonnees.commit();
    mBaseDonnees.close(); 
  }
  
  /**
   * @return Retourne la valeur de l'attribut baseDonnees.
   */
  public Database getBaseDonnees ()
  {
    return mBaseDonnees ;
  }
}
