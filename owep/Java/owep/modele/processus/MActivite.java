package owep.modele.processus ;


import java.util.ArrayList ;
import owep.modele.MModeleBase ;
import owep.modele.processus.MDefinitionTravail ;


/**
 * Une activité représente une unité de travail, c'est à dire un ensemble d'actions, effectuée par
 * un rôle lors de l'exécution du processus. Une activité peut nécessiter des produits en entrées
 * pour sa réalisation et génère des produits en sorties.
 */
public class MActivite extends MModeleBase
{
  private int                mId ;                 // Identifie l'activité de manière unique.
  private String             mNom ;                // Nom désignant l'activité.
  private String             mDescription ;        // Description de l'activité.
  private ArrayList          mProduitsEntrees ;    // Liste des produits nécessaires à l'activité.
  private ArrayList          mProduitsSorties ;    // Liste des produits réalisés durant l'activité.
  private ArrayList          mRoles ;              // Liste des rôles participant à l'activité.
  private MDefinitionTravail mDefinitionsTravail ; // Définition de travail contenant l'activité.


  /**
   * Construit une instance vide de MActivite.
   */
  public MActivite ()
  {
    super () ;
    
    mProduitsEntrees = new ArrayList () ;
    mProduitsSorties = new ArrayList () ;
    mRoles           = new ArrayList () ;
  }


  /**
   * Construit une instance initialisée de MActivite.
   * @param pId Identifiant unqiue de l'activité.
   * @param pNom Nom désignant l'activité.
   * @param pDescription Description de l'activité.
   * @param pDefinitionsTravail éfinition de travail à laquelle appartient l'activité.
   */
  public MActivite (int pId, String pNom, String pDescription,
                    MDefinitionTravail pDefinitionsTravail)
  {
    super () ;
    
    mId                 = pId ;
    mNom                = pNom ;
    mDescription        = pDescription ;
    mDefinitionsTravail = pDefinitionsTravail ;
    
    mProduitsEntrees = new ArrayList () ;
    mProduitsSorties = new ArrayList () ;
    mRoles           = new ArrayList () ;
  }


  /**
   * Récupère la définition de travail à laquelle appartient l'activité.
   * @return Définition de travail à laquelle appartient l'activité.
   */
  public MDefinitionTravail getDefinitionsTravail ()
  {
    return mDefinitionsTravail ;
  }


  /**
   * Associe la définition de travail à laquelle appartient l'activité.
   * @param pDefinitionsTravail Définition de travail à laquelle appartient l'activité.
   */
  public void setDefinitionsTravail (MDefinitionTravail pDefinitionsTravail)
  {
    mDefinitionsTravail = pDefinitionsTravail ;
  }


  /**
   * Récupère la description de l'activité.
   * @return Description de l'activité.
   */
  public String getDescription ()
  {
    return mDescription ;
  }


  /**
   * Initialise la description de l'activité.
   * @param pDescription Description de l'activité.
   */
  public void setDescription (String pDescription)
  {
    mDescription = pDescription ;
  }


  /**
   * Récupère l'identifiant de l'activité.
   * @return Identifiant unique de l'activité.
   */
  public int getId ()
  {
    return mId ;
  }


  /**
   * Initialise l'identifiant de l'activité.
   * @param pId Identifiant unique de l'activité.
   */
  public void setId (int pId)
  {
    mId = pId ;
  }


  /**
   * Récupère le nom de l'activité.
   * @return Nom désignant l'activité.
   */
  public String getNom ()
  {
    return mNom ;
  }


  /**
   * Initialise le nom de l'activité.
   * @param pNom Nom désignant l'activité.
   */
  public void setNom (String pNom)
  {
    mNom = pNom ;
  }


  /**
   * Récupère la liste des produits en entrées.
   * @return Liste des produits nécessaires à l'activité.
   */
  public ArrayList getListeProduitsEntrees ()
  {
    return mProduitsEntrees ;
  }


  /**
   * Initialise la liste des produits en entrées.
   * @param pProduitsEntrees Liste des produits nécessaires à l'activité.
   */
  public void setListeProduitsEntrees (ArrayList pProduitsEntrees)
  {
    mProduitsEntrees = pProduitsEntrees ;
  }


  /**
   * Récupère le nombre de produits en entrées.
   * @return Nombre de produits nécessaires à l'activité.
   */
  public int getNbProduitsEntrees ()
  {
    return mProduitsEntrees.size () ;
  }


  /**
   * Récupère le produit d'indice spécifié nécessaire à l'activité.
   * @param pIndice Indice du produit en entrée dans la liste.
   * @return Produit nécessaire à l'activité.
   */
  public MProduit getProduitEntree (int pIndice)
  {
    return (MProduit) mProduitsEntrees.get (pIndice) ;
  }


  /**
   * Ajoute le produit spécifié en entrée de l'activité.
   * @param pProduit Produit nécessaire à l'activité.
   */
  public void addProduitEntree (MProduit pProduit)
  {
    mProduitsEntrees.add (pProduit) ;
  }


  /**
   * Récupère la liste des produits en sorties.
   * @return Liste des produits réalisés au cours de l'activité.
   */
  public ArrayList getListeProduitsSorties ()
  {
    return mProduitsSorties ;
  }


  /**
   * Initialise la liste des produits en sorties.
   * @param pProduitsSorties Liste des produits réalisés durant l'activité.
   */
  public void setListeProduitsSorties (ArrayList pProduitsSorties)
  {
    mProduitsSorties = pProduitsSorties ;
  }


  /**
   * Récupère le nombre de produits en sorties.
   * @return Nombre de produits réalisés durant l'activité.
   */
  public int getNbProduitsSorties ()
  {
    return mProduitsEntrees.size () ;
  }


  /**
   * Récupère le produit d'indice spécifié nécessaire à l'activité.
   * @param pIndice Indice du produit en sortie dans la liste.
   * @return Produit nécessaire à l'activité.
   */
  public MProduit getProduitSortie (int pIndice)
  {
    return (MProduit) mProduitsEntrees.get (pIndice) ;
  }


  /**
   * Ajoute le produit spécifié en sortie de l'activité.
   * @param pProduit Produit nécessaire à l'activité.
   */
  public void addProduitSortie (MProduit pProduit)
  {
    mProduitsEntrees.add (pProduit) ;
  }


  /**
   * Récupère la liste des rôles.
   * @return Liste des rôles participant à l'activité.
   */
  public ArrayList getListeRoles ()
  {
    return mRoles ;
  }


  /**
   * Initialise la liste des rôles.
   * @param pRoles Liste des rôles participant à l'activité.
   */
  public void setListeRoles (ArrayList pRoles)
  {
    mRoles = pRoles ;
  }


  /**
   * Récupère le nombre de rôles participant à l'activité.
   * @return Nombre de rôles participant à l'activité.
   */
  public int getNbRolesSorties ()
  {
    return mProduitsEntrees.size () ;
  }


  /**
   * Récupère le rôle d'indice spécifié participant à l'activité.
   * @param pIndice Indice du rôle dans la liste.
   * @return Rôle participant à l'activité.
   */
  public MRole getRoleSortie (int pIndice)
  {
    return (MRole) mProduitsEntrees.get (pIndice) ;
  }


  /**
   * Ajoute le rôle spécifié à l'activité.
   * @param pRole Rôle participant à l'activité.
   */
  public void addRoleSortie (MRole pRole)
  {
    mProduitsEntrees.add (pRole) ;
  }
}