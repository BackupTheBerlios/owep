package owep.infrastructure ;


import java.util.ArrayList ;
import java.util.Hashtable ;

import org.exolab.castor.jdo.Database ;
import org.exolab.castor.jdo.JDO ;
import org.exolab.castor.jdo.OQLQuery ;
import org.exolab.castor.jdo.PersistenceException ;
import org.exolab.castor.jdo.QueryResults ;
import org.xml.sax.Attributes ;
import org.xml.sax.ContentHandler ;
import org.xml.sax.Locator ;
import org.xml.sax.SAXException ;

import owep.infrastructure.localisation.LocalisateurIdentifiant ;
import owep.modele.processus.* ;


/**
 * Parser permettant de lire un fichier dpe et remplis la base de données.
 */
public class Parser implements ContentHandler
{
  private ArrayList mBalise = new ArrayList () ;

  private Hashtable mObjet = new Hashtable () ;
  private Hashtable mLienObjet = new Hashtable () ;
  private Hashtable mIdObjet = new Hashtable () ;

  private static String BALISE_PROCESSUS = "processus" ;
  private static String BALISE_COMPOSANT = "liste_composant" ;
  private static String BALISE_ROLE = "liste_role" ;
  private static String BALISE_PRODUIT = "liste_produit" ;
  private static String BALISE_DEFINITIONTRAVAIL = "liste_definitionTravail" ;
  private static String BALISE_ACTIVITE = "liste_activite" ;

  private static String OBJET_PROCESSUS = "processus" ;
  private static String OBJET_COMPOSANT = "composant" ;
  private static String OBJET_ROLE = "role" ;
  private static String OBJET_PRODUIT = "produit" ;
  private static String OBJET_DEFINITIONTRAVAIL = "definitionTravail" ;
  private static String OBJET_ACTIVITE = "activite" ;
  private static String OBJET_ENTREE = "Entree" ;
  private static String OBJET_SORTIE = "Sortie" ;

  private int nbComposant = 0 ;
  private int nbRole = 0 ;
  private int nbProduit = 0 ;
  private int nbDefinitionTravail = 0 ;
  private int nbActivite = 0 ;


  /*
   * (non-Javadoc)
   * 
   * @see org.xml.sax.ContentHandler#setDocumentLocator(org.xml.sax.Locator)
   */
  public void setDocumentLocator (Locator pArg0)
  {
  }

  /*
   * (non-Javadoc)
   * 
   * @see org.xml.sax.ContentHandler#startDocument()
   */
  public void startDocument () throws SAXException
  {
  }

  /*
   * (non-Javadoc)
   * 
   * @see org.xml.sax.ContentHandler#endDocument()
   */
  public void endDocument ()
  {
    JDO lJdo ; // Charge le système de persistence avec la base de données
    Database mBaseDonnees = null ; // Connexion à la base de données
    OQLQuery lRequete ; // Requête à réaliser sur la base
    QueryResults lResultat ; // Résultat de la requête sur la base

    // Initie la connexion à la base de données.
    try
    {
      JDO.loadConfiguration (LocalisateurIdentifiant.LID_BDCONFIGURATION) ;
      lJdo = new JDO (LocalisateurIdentifiant.LID_BDNOM) ;

      mBaseDonnees = lJdo.getDatabase () ;
      mBaseDonnees.setAutoStore (false) ;
    }
    catch (Exception eException)
    {
      eException.printStackTrace () ;
    }

    // Insertion dans la base de donnée
    try
    {
      mBaseDonnees.begin () ;

      // Processus
      MProcessus lProcessus = (MProcessus) mObjet.get (OBJET_PROCESSUS) ;
      if (lProcessus != null)
      {
        mBaseDonnees.create (lProcessus) ;
      }

      mBaseDonnees.commit () ;

      // Récupération de processus enregistré (id maximum)
      mBaseDonnees.begin () ;
      lRequete = mBaseDonnees.getOQLQuery ("select PROCESSUS from owep.modele.processus.MProcessus PROCESSUS") ;
      lResultat = lRequete.execute () ;
      while(lResultat.hasMore())
      {
        MProcessus tempProcessus = (MProcessus) lResultat.next();
        if(lProcessus.getId() < tempProcessus.getId())
          lProcessus = tempProcessus;
      }
      mObjet.put(OBJET_PROCESSUS,lProcessus);
      mBaseDonnees.commit();
      
      // Composant
      for (int i = 1 ; i <= nbComposant ; i++)
      {
        MComposant lComposant = (MComposant) mObjet.get (OBJET_COMPOSANT + i) ;
        if (lComposant != null)
        {
          mBaseDonnees.begin();
          String cle = OBJET_PROCESSUS ;
          ArrayList listComposant = (ArrayList) mLienObjet.get (cle) ;

          if (listComposant.contains (mIdObjet.get (OBJET_COMPOSANT + i)))
            lComposant.setProcessus (lProcessus) ;

          mObjet.put (OBJET_COMPOSANT + i, lComposant) ;

          mBaseDonnees.create (lComposant) ;
          mBaseDonnees.commit();
        }
      }
      
      // Récupération des composants enregistré dans la base de données
      mBaseDonnees.begin();
      lRequete = mBaseDonnees.getOQLQuery ("select COMPOSANT from owep.modele.processus.MComposant COMPOSANT where mProcessus=$1") ;
      lRequete.bind(lProcessus.getId());
      lResultat = lRequete.execute () ;
      int minComposant = -1;
      while(lResultat.hasMore())
      {
        MComposant tempComposant = (MComposant) lResultat.next();
        if(minComposant == -1)
          minComposant = tempComposant.getId();
        if(minComposant > tempComposant.getId())
          minComposant = tempComposant.getId();
      }
      for(int i = 1 ; i <= nbComposant ; i++)
      {
        lRequete = mBaseDonnees.getOQLQuery("select COMPOSANT from owep.modele.processus.MComposant COMPOSANT where mId = $1");
        lRequete.bind(minComposant+i-1);
        lResultat = lRequete.execute();
        mObjet.put(OBJET_COMPOSANT+i,lResultat.next());
      }
      mBaseDonnees.commit();

      // Definition de travail
      for (int i = 1 ; i <= nbDefinitionTravail ; i++)
      {
        MDefinitionTravail lDefinitionTravail = (MDefinitionTravail) mObjet
          .get (OBJET_DEFINITIONTRAVAIL + i) ;
        if (lDefinitionTravail != null)
        {
          mBaseDonnees.begin();
          for(int j = 1 ; j <= nbComposant ; j++)
          {
            String cle = OBJET_COMPOSANT+j+OBJET_DEFINITIONTRAVAIL;
            ArrayList listDefinitionTravail = (ArrayList) mLienObjet.get (cle) ;
            if(listDefinitionTravail.contains(mIdObjet.get(OBJET_DEFINITIONTRAVAIL+i)))
            {
              MComposant lComposant = (MComposant) mObjet.get(OBJET_COMPOSANT+j);
              lDefinitionTravail.setComposant(lComposant);
            }
          }
          
          mObjet.put(OBJET_DEFINITIONTRAVAIL+i , lDefinitionTravail);
          
          mBaseDonnees.create(lDefinitionTravail);
          mBaseDonnees.commit();
        }
      }
      
      // Récupération des definition de travail enregistré
      mBaseDonnees.begin();
      lRequete = mBaseDonnees.getOQLQuery ("select DEFINITIONTRAVAIL from owep.modele.processus.MDefinitionTravail DEFINITIONTRAVAIL where mComposant>=$1") ;
      lRequete.bind(minComposant);
      lResultat = lRequete.execute () ;
      int minDefinitionTravail = -1;
      while(lResultat.hasMore())
      {
        MDefinitionTravail tempDefinitionTravail = (MDefinitionTravail) lResultat.next();
        if(minDefinitionTravail == -1)
          minDefinitionTravail = tempDefinitionTravail.getId();
        if(minDefinitionTravail > tempDefinitionTravail.getId())
          minDefinitionTravail = tempDefinitionTravail.getId();
      }
      for(int i = 1 ; i <= nbDefinitionTravail ; i++)
      {
        lRequete = mBaseDonnees.getOQLQuery("select DEFINITIONTRAVAIL from owep.modele.processus.MDefinitionTravail DEFINITIONTRAVAIL where mId = $1");
        lRequete.bind(minDefinitionTravail+i-1);
        lResultat = lRequete.execute();
        mObjet.put(OBJET_DEFINITIONTRAVAIL+i,lResultat.next());
      }
      mBaseDonnees.commit();

      // Activite
      for (int i = 1 ; i <= nbActivite ; i++)
      {
        MActivite lActivite = (MActivite) mObjet.get (OBJET_ACTIVITE + i) ;
        if (lActivite != null)
        {
          mBaseDonnees.begin();
          for(int j = 1 ; j <= nbDefinitionTravail ; j++)
          {
            String cle = OBJET_DEFINITIONTRAVAIL+j+OBJET_ACTIVITE;
            ArrayList listActivite = (ArrayList) mLienObjet.get (cle) ;
            if(listActivite.contains(mIdObjet.get(OBJET_ACTIVITE+i)))
            {
              MDefinitionTravail lDefinitionTravail = (MDefinitionTravail) mObjet.get(OBJET_DEFINITIONTRAVAIL+j);
              lActivite.setDefinitionsTravail(lDefinitionTravail);
            }
          }
          
          mObjet.put(OBJET_ACTIVITE+i , lActivite);
          
          mBaseDonnees.create(lActivite);
          mBaseDonnees.commit();
        }
      }

      // Récupération des activités enregistrées
      mBaseDonnees.begin();
      lRequete = mBaseDonnees.getOQLQuery ("select ACTIVITE from owep.modele.processus.MActivite ACTIVITE where mDefinitionTravail >= $1") ;
      lRequete.bind(minDefinitionTravail);
      lResultat = lRequete.execute () ;
      int minActivite = -1;
      while(lResultat.hasMore())
      {
        MActivite tempActivite = (MActivite) lResultat.next();
        if(minActivite == -1)
          minActivite = tempActivite.getId();
        if(minActivite > tempActivite.getId())
          minActivite = tempActivite.getId();
      }
      for(int i = 1 ; i <= nbActivite ; i++)
      {
        lRequete = mBaseDonnees.getOQLQuery("select ACTIVITE from owep.modele.processus.MActivite ACTIVITE where mId = $1");
        lRequete.bind(minActivite+i-1);
        lResultat = lRequete.execute();
        mObjet.put(OBJET_ACTIVITE+i,lResultat.next());
      }
      mBaseDonnees.commit();

      // Role
      for (int i = 1 ; i <= nbRole ; i++)
      {
        MRole lRole = (MRole) mObjet.get (OBJET_ROLE + i) ;
        if (lRole != null)
        {
          mBaseDonnees.begin();
          for(int j = 1 ; j <= nbComposant ; j++)
          {
            String cle = OBJET_COMPOSANT+j+OBJET_ROLE;
            ArrayList listRole = (ArrayList) mLienObjet.get (cle) ;
            if(listRole.contains(mIdObjet.get(OBJET_ROLE+i)))
            {
              MComposant lComposant = (MComposant) mObjet.get(OBJET_COMPOSANT+j);
              lRole.setComposant(lComposant);
            }
          }
          
          mObjet.put(OBJET_ROLE+i , lRole);
          
          mBaseDonnees.create(lRole);
          mBaseDonnees.commit();
        }
      }

      // Récupération des roles
      mBaseDonnees.begin();
      lRequete = mBaseDonnees.getOQLQuery ("select ROLE from owep.modele.processus.MRole ROLE where mComposant >= $1") ;
      lRequete.bind(minComposant);
      lResultat = lRequete.execute () ;
      int minRole = -1;
      while(lResultat.hasMore())
      {
        MRole tempRole = (MRole) lResultat.next();
        if(minRole == -1)
          minRole = tempRole.getId();
        if(minRole > tempRole.getId())
          minRole = tempRole.getId();
      }
      for(int i = 1 ; i <= nbRole ; i++)
      {
        lRequete = mBaseDonnees.getOQLQuery("select ROLE from owep.modele.processus.MRole ROLE where mId = $1");
        lRequete.bind(minRole+i-1);
        lResultat = lRequete.execute();
        mObjet.put(OBJET_ROLE+i,lResultat.next());
      }
      mBaseDonnees.commit();

      // Produit
      for (int i = 1 ; i <= nbProduit ; i++)
      {
        MProduit lProduit = (MProduit) mObjet.get (OBJET_PRODUIT + i) ;
        if (lProduit != null)
        {
          mBaseDonnees.begin();
          for(int j = 1 ; j <= nbComposant ; j++)
          {
            String cle = OBJET_COMPOSANT+j+OBJET_PRODUIT;
            ArrayList listProduit = (ArrayList) mLienObjet.get (cle) ;
            if(listProduit.contains(mIdObjet.get(OBJET_PRODUIT+i)))
            {
              MComposant lComposant = (MComposant) mObjet.get(OBJET_COMPOSANT+j);
              lProduit.setComposant(lComposant);
            }
          }
          
          for(int j = 1 ; j <= nbRole ; j++)
          {
            String cle = OBJET_ROLE+j+OBJET_PRODUIT;
            ArrayList listProduit = (ArrayList) mLienObjet.get (cle) ;
            if(listProduit != null)
            {
              if(listProduit.contains(mIdObjet.get(OBJET_PRODUIT+i)))
              {
                MRole lRole = (MRole) mObjet.get(OBJET_ROLE+j);
                lProduit.setResponsable(lRole);
              }
            }
          }
          
          mObjet.put(OBJET_PRODUIT+i , lProduit);
          
          mBaseDonnees.create(lProduit);
          mBaseDonnees.commit();
        }
      }

      // Récupération des produits
      mBaseDonnees.begin();
      lRequete = mBaseDonnees.getOQLQuery ("select PRODUIT from owep.modele.processus.MProduit PRODUIT where mComposant >= $1") ;
      lRequete.bind(minComposant);
      lResultat = lRequete.execute () ;
      int minProduit = -1;
      while(lResultat.hasMore())
      {
        MProduit tempProduit = (MProduit) lResultat.next();
        if(minProduit == -1)
          minProduit = tempProduit.getId();
        if(minProduit > tempProduit.getId())
          minProduit = tempProduit.getId();
      }
      for(int i = 1 ; i <= nbProduit ; i++)
      {
        lRequete = mBaseDonnees.getOQLQuery("select PRODUIT from owep.modele.processus.MProduit PRODUIT where mId = $1");
        lRequete.bind(minProduit+i-1);
        lResultat = lRequete.execute();
        mObjet.put(OBJET_PRODUIT+i,lResultat.next());
      }
      mBaseDonnees.commit();

      // Liens pour la table r01_act_prd_entree
      for(int i = 1 ; i <= nbActivite ; i++)
      {
        String cle = OBJET_ACTIVITE + i + OBJET_PRODUIT + OBJET_ENTREE;
        ArrayList listProduit = (ArrayList) mLienObjet.get(cle);
        if(listProduit != null)
        {
          for(int j = 1 ; j <= nbProduit ; j++)
          {
            if(listProduit.contains(mIdObjet.get(OBJET_PRODUIT+j)))
            {
              mBaseDonnees.begin();
              MProduit lProduit = (MProduit) mObjet.get(OBJET_PRODUIT+j);
              
              lRequete = mBaseDonnees.getOQLQuery("select PRODUIT from owep.modele.processus.MProduit PRODUIT where mId = $1");
              lRequete.bind(lProduit.getId());
              lResultat = lRequete.execute();
              lProduit = (MProduit) lResultat.next();
              
              MActivite lActivite = (MActivite) mObjet.get(OBJET_ACTIVITE+i);
              lRequete = mBaseDonnees.getOQLQuery("select ACTIVITE from owep.modele.processus.MActivite ACTIVITE where mId = $1");
              lRequete.bind(lActivite.getId());
              lResultat = lRequete.execute();
              lActivite = (MActivite) lResultat.next();
              
              lProduit.addActiviteSortie(lActivite);
              mBaseDonnees.commit();
            }
          }
        }
      }
      
      // Liens pour la table r02_act_prd_sortie
      for(int i = 1 ; i <= nbActivite ; i++)
      {
        String cle = OBJET_ACTIVITE + i + OBJET_PRODUIT + OBJET_SORTIE;
        ArrayList listProduit = (ArrayList) mLienObjet.get(cle);
        if(listProduit != null)
        {
          for(int j = 1 ; j <= nbProduit ; j++)
          {
            if(listProduit.contains(mIdObjet.get(OBJET_PRODUIT+j)))
            {
              mBaseDonnees.begin();
              MProduit lProduit = (MProduit) mObjet.get(OBJET_PRODUIT+j);
              
              lRequete = mBaseDonnees.getOQLQuery("select PRODUIT from owep.modele.processus.MProduit PRODUIT where mId = $1");
              lRequete.bind(lProduit.getId());
              lResultat = lRequete.execute();
              lProduit = (MProduit) lResultat.next();
              
              MActivite lActivite = (MActivite) mObjet.get(OBJET_ACTIVITE+i);
              lRequete = mBaseDonnees.getOQLQuery("select ACTIVITE from owep.modele.processus.MActivite ACTIVITE where mId = $1");
              lRequete.bind(lActivite.getId());
              lResultat = lRequete.execute();
              lActivite = (MActivite) lResultat.next();
              
              lProduit.addActiviteEntree(lActivite);
              mBaseDonnees.commit();
            }
          }
        }
      }
      
      // Liens pour la table r03_act_rol
      for(int i = 1 ; i <= nbRole ; i++)
      {
        String cle = OBJET_ROLE + i + OBJET_ACTIVITE;
        ArrayList listProduit = (ArrayList) mLienObjet.get(cle);
        if(listProduit != null)
        {
          for(int j = 1 ; j <= nbActivite ; j++)
          {
            if(listProduit.contains(mIdObjet.get(OBJET_ACTIVITE+j)))
            {
              mBaseDonnees.begin();
              MActivite lActivite = (MActivite) mObjet.get(OBJET_ACTIVITE+j);
              
              lRequete = mBaseDonnees.getOQLQuery("select ACTIVITE from owep.modele.processus.MActivite ACTIVITE where mId = $1");
              lRequete.bind(lActivite.getId());
              lResultat = lRequete.execute();
              lActivite = (MActivite) lResultat.next();
              
              MRole lRole = (MRole) mObjet.get(OBJET_ROLE+i);
              lRequete = mBaseDonnees.getOQLQuery("select ROLE from owep.modele.processus.MRole ROLE where mId = $1");
              lRequete.bind(lRole.getId());
              lResultat = lRequete.execute();
              lRole = (MRole) lResultat.next();
              
              lActivite.addRole(lRole);
              mBaseDonnees.commit();
            }
          }
        }
      }
      
    }
    catch (PersistenceException e)
    {
      e.printStackTrace () ;
    }
    finally
    {
      try
      {
        mBaseDonnees.close () ;
      }
      catch (PersistenceException e1)
      {
        e1.printStackTrace () ;
      }
    }
  }

  /*
   * (non-Javadoc)
   * 
   * @see org.xml.sax.ContentHandler#startPrefixMapping(java.lang.String, java.lang.String)
   */
  public void startPrefixMapping (String pArg0, String pArg1) throws SAXException
  {
  }

  /*
   * (non-Javadoc)
   * 
   * @see org.xml.sax.ContentHandler#endPrefixMapping(java.lang.String)
   */
  public void endPrefixMapping (String pArg0) throws SAXException
  {
  }

  /*
   * (non-Javadoc)
   * 
   * @see org.xml.sax.ContentHandler#startElement(java.lang.String, java.lang.String,
   *      java.lang.String, org.xml.sax.Attributes)
   */
  public void startElement (String nameSpaceURI, String localName, String pArg2,
                            Attributes attributs) throws SAXException
  {
    mBalise.add (localName) ;
  }

  /*
   * (non-Javadoc)
   * 
   * @see org.xml.sax.ContentHandler#endElement(java.lang.String, java.lang.String,
   *      java.lang.String)
   */
  public void endElement (String nameSpaceUri, String localName, String rawName)
    throws SAXException
  {
    int i = mBalise.lastIndexOf (localName) ;
    mBalise.remove (i) ;
  }

  /*
   * (non-Javadoc)
   * 
   * @see org.xml.sax.ContentHandler#characters(char[], int, int)
   */
  public void characters (char [] ch, int start, int end) throws SAXException
  {
    String lAttribut = new String (ch, start, end) ;

    if (!lAttribut.contains ("\n"))
    {
      // Processus
      if (mBalise.contains (BALISE_PROCESSUS))
      {
        MProcessus lProcessus ;
        if (mObjet.containsKey (OBJET_PROCESSUS))
        {
          lProcessus = (MProcessus) mObjet.get (OBJET_PROCESSUS) ;
        }
        else
        {
          lProcessus = new MProcessus () ;
        }

        if (mBalise.contains ("id"))
        {
          mIdObjet.put (OBJET_PROCESSUS, lAttribut) ;
        }

        if (mBalise.contains ("nom"))
        {
          if (mBalise.contains ("nomAuteur"))
          {
            lProcessus.setNomAuteur (lAttribut) ;
          }
          else
          {
            lProcessus.setNom (lAttribut) ;
          }
        }
        
        if (mBalise.contains ("nomAuteur"))
        {
          lProcessus.setNomAuteur (lAttribut) ;
        }

        if (mBalise.contains ("emailAuteur"))
        {
          lProcessus.setEmailAuteur (lAttribut) ;
        }

        if (mBalise.contains ("description"))
        {
          lProcessus.setDescription (lAttribut) ;
        }

        if (mBalise.contains ("composantId"))
        {
          ArrayList valeur = (ArrayList) mLienObjet.get (OBJET_PROCESSUS) ;
          if (valeur == null)
            valeur = new ArrayList () ;
          valeur.add (lAttribut) ;
          mLienObjet.put (OBJET_PROCESSUS, valeur) ;
        }

        mObjet.put (OBJET_PROCESSUS, lProcessus) ;
      }

      // Composant
      if (mBalise.contains (BALISE_COMPOSANT))
      {
        if (mBalise.contains ("id"))
        {
          nbComposant++ ;
          mIdObjet.put (OBJET_COMPOSANT + nbComposant, lAttribut) ;
        }

        MComposant lComposant ;
        if (mObjet.containsKey (OBJET_COMPOSANT + nbComposant))
        {
          lComposant = (MComposant) mObjet.get (OBJET_COMPOSANT + nbComposant) ;
        }
        else
        {
          lComposant = new MComposant () ;
        }

        if (mBalise.contains ("nom"))
        {
          if (mBalise.contains ("nomAuteur"))
          {
            lComposant.setNomAuteur (lAttribut) ;
          }
          else
          {
            lComposant.setNom (lAttribut) ;
          }
        }

        if (mBalise.contains ("nomAuteur"))
        {
          lComposant.setNomAuteur (lAttribut) ;
        }

        if (mBalise.contains ("emailAuteur"))
        {
          lComposant.setEmailAuteur (lAttribut) ;
        }

        if (mBalise.contains ("description"))
        {
          lComposant.setDescription (lAttribut) ;
        }

        if (mBalise.contains ("roleId"))
        {
          String cle = OBJET_COMPOSANT+nbComposant+OBJET_ROLE ;
          ArrayList valeur = (ArrayList) mLienObjet.get (cle) ;
          if (valeur == null)
            valeur = new ArrayList () ;
          valeur.add (lAttribut) ;
          mLienObjet.put (cle, valeur) ;
        }

        if (mBalise.contains ("produitId"))
        {
          String cle = OBJET_COMPOSANT+nbComposant+OBJET_PRODUIT ;
          ArrayList valeur = (ArrayList) mLienObjet.get (cle) ;
          if (valeur == null)
            valeur = new ArrayList () ;
          valeur.add (lAttribut) ;
          mLienObjet.put (cle, valeur) ;
        }

        if (mBalise.contains ("definitionTravailId"))
        {
          String cle = OBJET_COMPOSANT+nbComposant+OBJET_DEFINITIONTRAVAIL ;
          ArrayList valeur = (ArrayList) mLienObjet.get (cle) ;
          if (valeur == null)
            valeur = new ArrayList () ;
          valeur.add (lAttribut) ;
          mLienObjet.put (cle, valeur) ;
        }

        mObjet.put (OBJET_COMPOSANT + nbComposant, lComposant) ;
      }

      // Definition de travail
      if (mBalise.contains (BALISE_DEFINITIONTRAVAIL))
      {
        if (mBalise.contains ("id"))
        {
          nbDefinitionTravail++ ;
          mIdObjet.put (OBJET_DEFINITIONTRAVAIL + nbDefinitionTravail, lAttribut) ;
        }

        MDefinitionTravail lDefinitionTravail ;
        if (mObjet.containsKey (OBJET_DEFINITIONTRAVAIL + nbDefinitionTravail))
        {
          lDefinitionTravail = (MDefinitionTravail) mObjet.get (OBJET_DEFINITIONTRAVAIL
                                                                + nbDefinitionTravail) ;
        }
        else
        {
          lDefinitionTravail = new MDefinitionTravail () ;
        }

        if (mBalise.contains ("nom"))
        {
          lDefinitionTravail.setNom (lAttribut) ;
        }

        if (mBalise.contains ("activiteId"))
        {
          String cle = OBJET_DEFINITIONTRAVAIL+nbDefinitionTravail+OBJET_ACTIVITE ;
          ArrayList valeur = (ArrayList) mLienObjet.get (cle) ;
          if (valeur == null)
            valeur = new ArrayList () ;
          valeur.add (lAttribut) ;
          mLienObjet.put (cle, valeur) ;
        }

        mObjet.put (OBJET_DEFINITIONTRAVAIL + nbDefinitionTravail, lDefinitionTravail) ;
      }

      // Activite
      if (mBalise.contains (BALISE_ACTIVITE))
      {
        if (mBalise.contains ("id"))
        {
          nbActivite++ ;
          mIdObjet.put (OBJET_ACTIVITE + nbActivite, lAttribut) ;
        }

        MActivite lActivite ;
        if (mObjet.containsKey (OBJET_ACTIVITE + nbActivite))
        {
          lActivite = (MActivite) mObjet.get (OBJET_ACTIVITE + nbActivite) ;
        }
        else
        {
          lActivite = new MActivite () ;
        }

        if (mBalise.contains ("nom"))
        {
          lActivite.setNom (lAttribut) ;
        }

        if (mBalise.contains ("entreeProduit"))
        {
          String cle = OBJET_ACTIVITE+nbActivite+OBJET_PRODUIT + OBJET_ENTREE ;
          ArrayList valeur = (ArrayList) mLienObjet.get (cle) ;
          if (valeur == null)
            valeur = new ArrayList () ;
          valeur.add (lAttribut) ;
          mLienObjet.put (cle, valeur) ;
        }

        if (mBalise.contains ("sortieProduit"))
        {
          String cle = OBJET_ACTIVITE+nbActivite+OBJET_PRODUIT + OBJET_SORTIE ;
          ArrayList valeur = (ArrayList) mLienObjet.get (cle) ;
          if (valeur == null)
            valeur = new ArrayList () ;
          valeur.add (lAttribut) ;
          mLienObjet.put (cle, valeur) ;
        }

        mObjet.put (OBJET_ACTIVITE + nbActivite, lActivite) ;
      }

      // Role
      if (mBalise.contains (BALISE_ROLE))
      {
        if (mBalise.contains ("id"))
        {
          nbRole++ ;
          mIdObjet.put (OBJET_ROLE + nbRole, lAttribut) ;
        }

        MRole lRole ;
        if (mObjet.containsKey (OBJET_ROLE + nbRole))
        {
          lRole = (MRole) mObjet.get (OBJET_ROLE + nbRole) ;
        }
        else
        {
          lRole = new MRole () ;
        }

        if (mBalise.contains ("nom"))
        {
          lRole.setNom (lAttribut) ;
        }

        if (mBalise.contains ("responsabiliteProduit"))
        {
          String cle = OBJET_ROLE+nbRole+OBJET_PRODUIT ;
          ArrayList valeur = (ArrayList) mLienObjet.get (cle) ;
          if (valeur == null)
            valeur = new ArrayList () ;
          valeur.add (lAttribut) ;
          mLienObjet.put (cle, valeur) ;
        }

        if (mBalise.contains ("participationActivite"))
        {
          String cle = OBJET_ROLE+nbRole+OBJET_ACTIVITE ;
          ArrayList valeur = (ArrayList) mLienObjet.get (cle) ;
          if (valeur == null)
            valeur = new ArrayList () ;
          valeur.add (lAttribut) ;
          mLienObjet.put (cle, valeur) ;
        }

        mObjet.put (OBJET_ROLE + nbRole, lRole) ;
      }

      // Produit
      if (mBalise.contains (BALISE_PRODUIT))
      {
        if (mBalise.contains ("id"))
        {
          nbProduit++ ;
          mIdObjet.put (OBJET_PRODUIT + nbProduit, lAttribut) ;
        }

        MProduit lProduit ;
        if (mObjet.containsKey (OBJET_PRODUIT + nbProduit))
        {
          lProduit = (MProduit) mObjet.get (OBJET_PRODUIT + nbProduit) ;
        }
        else
        {
          lProduit = new MProduit () ;
        }

        if (mBalise.contains ("nom"))
        {
          lProduit.setNom (lAttribut) ;
        }

        if (mBalise.contains ("responsabiliteProduit"))
        {
          String cle = OBJET_PRODUIT+nbProduit+OBJET_ROLE ;
          ArrayList valeur = (ArrayList) mLienObjet.get (cle) ;
          if (valeur == null)
            valeur = new ArrayList () ;
          valeur.add (lAttribut) ;
          mLienObjet.put (cle, valeur) ;
        }

        if (mBalise.contains ("entreeActivite"))
        {
          String cle = OBJET_PRODUIT+nbProduit+OBJET_ACTIVITE + OBJET_ENTREE ;
          ArrayList valeur = (ArrayList) mLienObjet.get (cle) ;
          if (valeur == null)
            valeur = new ArrayList () ;
          valeur.add (lAttribut) ;
          mLienObjet.put (cle, valeur) ;
        }

        if (mBalise.contains ("sortieActivite"))
        {
          String cle = OBJET_PRODUIT+nbProduit+OBJET_ACTIVITE + OBJET_SORTIE ;
          ArrayList valeur = (ArrayList) mLienObjet.get (cle) ;
          if (valeur == null)
            valeur = new ArrayList () ;
          valeur.add (lAttribut) ;
          mLienObjet.put (cle, valeur) ;
        }

        mObjet.put (OBJET_PRODUIT + nbProduit, lProduit) ;
      }

    }
  }

  /*
   * (non-Javadoc)
   * 
   * @see org.xml.sax.ContentHandler#ignorableWhitespace(char[], int, int)
   */
  public void ignorableWhitespace (char [] pArg0, int pArg1, int pArg2) throws SAXException
  {
  }

  /*
   * (non-Javadoc)
   * 
   * @see org.xml.sax.ContentHandler#processingInstruction(java.lang.String, java.lang.String)
   */
  public void processingInstruction (String pArg0, String pArg1) throws SAXException
  {
  }

  /*
   * (non-Javadoc)
   * 
   * @see org.xml.sax.ContentHandler#skippedEntity(java.lang.String)
   */
  public void skippedEntity (String pArg0) throws SAXException
  {
  }

}