package owep.controle.processus ;


import java.io.File ;
import java.io.IOException ;
import java.util.ArrayList;
import java.util.Iterator ;
import java.util.List ;

import javax.servlet.ServletException ;

import org.exolab.castor.jdo.OQLQuery;
import org.exolab.castor.jdo.PersistenceException;
import org.exolab.castor.jdo.QueryResults;
import org.xml.sax.SAXException ;
import org.xml.sax.XMLReader ;
import org.xml.sax.helpers.XMLReaderFactory ;

import owep.controle.CControleurBase ;
import owep.infrastructure.Parser ;
import owep.infrastructure.fileupload.DiskFileUpload ;
import owep.infrastructure.fileupload.FileItem ;
import owep.infrastructure.fileupload.FileUploadException ;
import owep.modele.processus.MProcessus;
import owep.modele.execution.MCollaborateur;
import owep.modele.execution.MProjet;


/**
 * Controleur pour la cr�ation et l'export d'un projet.
 */
public class CGererProjet extends CControleurBase
{
  private String mNom ; // Nom du projet
  private String mDescription ; // Description du projet
  private String mDateDebut ; // Date de d�but du projet
  private String mDateFin ; // Date de fin du projet
  private String mResponsable ; // Identifiant du collaborateur responsable du projet
  private File mFichierProcessus = null ; // Fichier du processus
  FileItem itemFichier = null ;


  /*
   * (non-Javadoc)
   * 
   * @see owep.controle.CControleurBase#initialiserBaseDonnees()
   */
  public void initialiserBaseDonnees () throws ServletException
  {
    OQLQuery       lRequete ;       // Requ�te � r�aliser sur la base
    QueryResults   lResultat ;      // R�sultat de la requ�te sur la base

    try
    {
      getBaseDonnees().begin();
      lRequete = getBaseDonnees().getOQLQuery("select COLLABORATEUR from owep.modele.execution.MCollaborateur COLLABORATEUR");
      lResultat = lRequete.execute();
      ArrayList listCollaborateur = new ArrayList();
      while(lResultat.hasMore())
      {
        listCollaborateur.add(lResultat.next());
      }
      getBaseDonnees().commit();
      getRequete().setAttribute("mListCollaborateur",listCollaborateur);
    }
    catch (PersistenceException e)
    {
      e.printStackTrace();
    }
    finally
    {
/*      try
      {
        getBaseDonnees().close();
      }
      catch (PersistenceException e1)
      {
        e1.printStackTrace();
      }*/
    }
  }

  /*
   * (non-Javadoc)
   * 
   * @see owep.controle.CControleurBase#initialiserParametres()
   */
  public void initialiserParametres () throws ServletException
  {
    DiskFileUpload upload = new DiskFileUpload () ;
    if (DiskFileUpload.isMultipartContent (getRequete ()))
    {
      try
      {
        List items = upload.parseRequest (getRequete ()) ;
        Iterator itr = items.iterator () ;
        //parcour de la liste
        while (itr.hasNext ())
        {
          //r�cup�ration des �l�ments de la liste dans item
          FileItem item = (FileItem) itr.next () ;
          String fieldName = item.getFieldName () ;

          //si l'�l�ment est le fichier
          if (fieldName.equals ("mFichierProcessus"))
          {
            itemFichier = item ;
            mFichierProcessus = new File (item.getName ()) ;
          }

          // Si l'�l�ment est le nom
          if (fieldName.equals ("mNom"))
          {
            mNom = item.getString () ;
          }

          // Si l'�l�ment est la description
          if (fieldName.equals ("mDescription"))
            mDescription = item.getString () ;

          // Si l'�l�ment est la date de debut
          if (fieldName.equals ("mDateDebut"))
            mDateDebut = item.getString () ;

          // Si l'�l�ment est la date de fin
          if (fieldName.equals ("mDateFin"))
            mDateFin = item.getString () ;
          
          // Si l'�l�ment est l'id du responsable de projet
          if(fieldName.equals("mResponsable"))
            mResponsable = item.getString();
        }
      }
      catch (FileUploadException e)
      {
        e.printStackTrace () ;
      }
    }
  }

  /*
   * (non-Javadoc)
   * 
   * @see owep.controle.CControleurBase#traiter()
   */
  public String traiter () throws ServletException
  {
    OQLQuery       lRequete ;       // Requ�te � r�aliser sur la base
    QueryResults   lResultat ;      // R�sultat de la requ�te sur la base

    if (mFichierProcessus != null)
    {
      // Cr�ation du r�pertoire
      (new File (getServletContext ().getRealPath ("/") + "/Processus/Import")).mkdirs () ;
      // Cr�ation du fichier
      File savedFile = new File (getServletContext ().getRealPath ("/") + "/Processus/Import/",
                                 "temp") ;
      try
      {
        // Sauvegarde du fichier
        itemFichier.write (savedFile) ;
      }
      catch (Exception e)
      {
        e.printStackTrace () ;
      }

      // Enregistrement des donn�es du fichier en entr�e � l'aide du parser
      XMLReader saxReader ;
      try
      {
        saxReader = XMLReaderFactory.createXMLReader ("org.apache.xerces.parsers.SAXParser") ;
        saxReader.setContentHandler (new Parser ()) ;
        saxReader.parse (savedFile.toURI ().toString ()) ;
      }
      catch (SAXException e1)
      {
        e1.printStackTrace () ;
      }
      catch (IOException e)
      {
        e.printStackTrace () ;
      }
      
      try
      {
        getBaseDonnees().begin();
        
        // R�cup�ration du processus
        lRequete = getBaseDonnees().getOQLQuery("select PROCESSUS from owep.modele.processus.MProcessus PROCESSUS");
        lResultat = lRequete.execute();
        MProcessus lProcessus = (MProcessus) lResultat.next();
        int maxIdProcessus = lProcessus.getId();
        while(lResultat.hasMore())
        {
          MProcessus tmpProcessus = (MProcessus) lResultat.next();
          if(maxIdProcessus < tmpProcessus.getId())
          {
            maxIdProcessus = tmpProcessus.getId();
            lProcessus = tmpProcessus;
          }
        }
        
        // R�cup�ration du responsable
        lRequete = getBaseDonnees().getOQLQuery("select COLLABORATEUR from owep.modele.execution.MCollaborateur COLLABORATEUR where mId = $1");
        lRequete.bind(mResponsable);
        lResultat = lRequete.execute();
        MCollaborateur lCollaborateur = (MCollaborateur) lResultat.next();
        
        // Cr�ation du projet
        MProjet lProjet = new MProjet();
        lProjet.setNom(mNom);
        lProjet.setDateDebutPrevue(java.sql.Date.valueOf(mDateDebut));
        lProjet.setDateFinPrevue(java.sql.Date.valueOf(mDateFin));
        lProjet.setDescription(mDescription);
        lProjet.setProcessus(lProcessus);
        lProjet.setChefProjet(lCollaborateur);
        
        getBaseDonnees().create(lProjet);
        getBaseDonnees().commit();
        getBaseDonnees().begin();

        // R�cup�ration du dernier projet cr��
        lRequete = getBaseDonnees().getOQLQuery("select PROJET from owep.modele.execution.MProjet PROJET");
        lResultat = lRequete.execute();
        lProjet = (MProjet) lResultat.next();
        int maxIdProjet = lProjet.getId();
        while(lResultat.hasMore())
        {
          MProjet tmpProjet = (MProjet) lResultat.next();
          if(maxIdProjet < tmpProjet.getId())
          {
            maxIdProjet = tmpProjet.getId();
            lProjet = tmpProjet;
          }
        }
        
        // R�cup�ration du collaborateur responsable du projet
        lRequete = getBaseDonnees().getOQLQuery("select COLLABORATEUR from owep.modele.execution.MCollaborateur COLLABORATEUR where mId = $1");
        lRequete.bind(lCollaborateur.getId());
        lResultat = lRequete.execute();
        lCollaborateur = (MCollaborateur) lResultat.next();
        
        // Liaison du responsable de projet avec le projet
        lCollaborateur.addProjet(lProjet);
        lProjet.addCollaborateur(lCollaborateur);
        
        getBaseDonnees().commit();
        
        // Ajout du projet � la liste des projets possibles si utilisateur connect� est le responsable
        if(getSession().getCollaborateur().getId() == lCollaborateur.getId())
        {
          ArrayList listProjetPossible = getSession().getListProjetPossible();
          listProjetPossible.add(lProjet);
          getSession().setListProjetPossible(listProjetPossible);
        }
        
        // Renommage du fichier processus
        File f = new File(getServletContext ().getRealPath ("/") + "/Processus/Import/",
                                 "temp");
        f.renameTo(new File(getServletContext ().getRealPath ("/") + "/Processus/Import/",
                                 lProjet.getId()+"_"+lProjet.getNom()+".xml"));
      }
      catch (PersistenceException e2)
      {
        e2.printStackTrace();
      }
      finally
      {
        try
        {
          getBaseDonnees().close();
        }
        catch (PersistenceException e3)
        {
          e3.printStackTrace();
        }
      }
    }
    else
    {
      try
      {
        getBaseDonnees().close();
      }
      catch (PersistenceException e)
      {
        // TODO Auto-generated catch block
        e.printStackTrace();
      }
    }

    return "..\\JSP\\Processus\\TGererProjet.jsp" ;
    
  }

}