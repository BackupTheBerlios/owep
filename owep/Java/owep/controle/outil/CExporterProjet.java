package owep.controle.outil;

import java.io.IOException;

import javax.servlet.ServletException;

import owep.controle.CControleurBase;
import owep.infrastructure.Export;
import owep.modele.execution.MProjet;

/**
 * Controleur permettant l'export du projet ouvert
 */
public class CExporterProjet extends CControleurBase
{

  /**
   * Récupère les données nécessaire au controleur dans la base de données.
   * 
   * @throws ServletException Si une erreur survient durant la connexion
   * @see owep.controle.CControleurBase#initialiserBaseDonnees()
   */
  public void initialiserBaseDonnees () throws ServletException
  {
  }

  /**
   * Initialise le controleur et récupère les paramètres.
   * 
   * @throws ServletException Si une erreur sur les paramètres survient
   * @see owep.controle.CControleurBase#initialiserParametres()
   */
  public void initialiserParametres () throws ServletException
  {
  }

  /**
   * Redirige vers la JSP d'affichage de la page d'export d'un projet.
   * 
   * @return URL de la page qui doit être affichée.
   * @throws ServletException si une erreur survient dans le controleur.
   * @see owep.controle.CControleurBase#traiter()
   */
  public String traiter () throws ServletException
  {
    String lChemin = getServletContext ().getRealPath ("/") + "/Processus/";
    MProjet lProjet = getSession().getProjet();
    try
    {
      new Export(lProjet, lChemin);
    }
    catch (IOException e)
    {
      e.printStackTrace();
    }
    getRequete().setAttribute("mFichierExport",lProjet.getId()+"_"+lProjet.getNom()+".xml");
    return "..\\JSP\\Outil\\TExporterProjet.jsp" ;
  }

}
