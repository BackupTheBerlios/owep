package owep.modele.processus ;


import java.util.ArrayList ;
import owep.modele.MModeleBase ;
import owep.modele.processus.MDefinitionTravail ;


/**
 * Une activit� repr�sente une unit� de travail, c'est � dire un ensemble d'actions, effectu�e par
 * un r�le lors de l'ex�cution du processus. Une activit� peut n�cessiter des produits en entr�es
 * pour sa r�alisation et g�n�re des produits en sorties.
 */
public class MActivite extends MModeleBase
{
  private int                mId ;                 // Identifie l'activit� de mani�re unique.
  private String             mNom ;                // Nom d�signant l'activit�.
  private String             mDescription ;        // Description de l'activit�.
  private ArrayList          mProduitsEntrees ;    // Liste des produits n�cessaires � l'activit�.
  private ArrayList          mProduitsSorties ;    // Liste des produits r�alis�s durant l'activit�.
  private ArrayList          mRoles ;              // Liste des r�les participant � l'activit�.
  private MDefinitionTravail mDefinitionsTravail ; // D�finition de travail contenant l'activit�.


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
   * Construit une instance initialis�e de MActivite.
   * @param pId Identifiant unqiue de l'activit�.
   * @param pNom Nom d�signant l'activit�.
   * @param pDescription Description de l'activit�.
   * @param pDefinitionsTravail �finition de travail � laquelle appartient l'activit�.
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
   * R�cup�re la d�finition de travail � laquelle appartient l'activit�.
   * @return D�finition de travail � laquelle appartient l'activit�.
   */
  public MDefinitionTravail getDefinitionsTravail ()
  {
    return mDefinitionsTravail ;
  }


  /**
   * Associe la d�finition de travail � laquelle appartient l'activit�.
   * @param pDefinitionsTravail D�finition de travail � laquelle appartient l'activit�.
   */
  public void setDefinitionsTravail (MDefinitionTravail pDefinitionsTravail)
  {
    mDefinitionsTravail = pDefinitionsTravail ;
  }


  /**
   * R�cup�re la description de l'activit�.
   * @return Description de l'activit�.
   */
  public String getDescription ()
  {
    return mDescription ;
  }


  /**
   * Initialise la description de l'activit�.
   * @param pDescription Description de l'activit�.
   */
  public void setDescription (String pDescription)
  {
    mDescription = pDescription ;
  }


  /**
   * R�cup�re l'identifiant de l'activit�.
   * @return Identifiant unique de l'activit�.
   */
  public int getId ()
  {
    return mId ;
  }


  /**
   * Initialise l'identifiant de l'activit�.
   * @param pId Identifiant unique de l'activit�.
   */
  public void setId (int pId)
  {
    mId = pId ;
  }


  /**
   * R�cup�re le nom de l'activit�.
   * @return Nom d�signant l'activit�.
   */
  public String getNom ()
  {
    return mNom ;
  }


  /**
   * Initialise le nom de l'activit�.
   * @param pNom Nom d�signant l'activit�.
   */
  public void setNom (String pNom)
  {
    mNom = pNom ;
  }


  /**
   * R�cup�re la liste des produits en entr�es.
   * @return Liste des produits n�cessaires � l'activit�.
   */
  public ArrayList getListeProduitsEntrees ()
  {
    return mProduitsEntrees ;
  }


  /**
   * Initialise la liste des produits en entr�es.
   * @param pProduitsEntrees Liste des produits n�cessaires � l'activit�.
   */
  public void setListeProduitsEntrees (ArrayList pProduitsEntrees)
  {
    mProduitsEntrees = pProduitsEntrees ;
  }


  /**
   * R�cup�re le nombre de produits en entr�es.
   * @return Nombre de produits n�cessaires � l'activit�.
   */
  public int getNbProduitsEntrees ()
  {
    return mProduitsEntrees.size () ;
  }


  /**
   * R�cup�re le produit d'indice sp�cifi� n�cessaire � l'activit�.
   * @param pIndice Indice du produit en entr�e dans la liste.
   * @return Produit n�cessaire � l'activit�.
   */
  public MProduit getProduitEntree (int pIndice)
  {
    return (MProduit) mProduitsEntrees.get (pIndice) ;
  }


  /**
   * Ajoute le produit sp�cifi� en entr�e de l'activit�.
   * @param pProduit Produit n�cessaire � l'activit�.
   */
  public void addProduitEntree (MProduit pProduit)
  {
    mProduitsEntrees.add (pProduit) ;
  }


  /**
   * R�cup�re la liste des produits en sorties.
   * @return Liste des produits r�alis�s au cours de l'activit�.
   */
  public ArrayList getListeProduitsSorties ()
  {
    return mProduitsSorties ;
  }


  /**
   * Initialise la liste des produits en sorties.
   * @param pProduitsSorties Liste des produits r�alis�s durant l'activit�.
   */
  public void setListeProduitsSorties (ArrayList pProduitsSorties)
  {
    mProduitsSorties = pProduitsSorties ;
  }


  /**
   * R�cup�re le nombre de produits en sorties.
   * @return Nombre de produits r�alis�s durant l'activit�.
   */
  public int getNbProduitsSorties ()
  {
    return mProduitsEntrees.size () ;
  }


  /**
   * R�cup�re le produit d'indice sp�cifi� n�cessaire � l'activit�.
   * @param pIndice Indice du produit en sortie dans la liste.
   * @return Produit n�cessaire � l'activit�.
   */
  public MProduit getProduitSortie (int pIndice)
  {
    return (MProduit) mProduitsEntrees.get (pIndice) ;
  }


  /**
   * Ajoute le produit sp�cifi� en sortie de l'activit�.
   * @param pProduit Produit n�cessaire � l'activit�.
   */
  public void addProduitSortie (MProduit pProduit)
  {
    mProduitsEntrees.add (pProduit) ;
  }


  /**
   * R�cup�re la liste des r�les.
   * @return Liste des r�les participant � l'activit�.
   */
  public ArrayList getListeRoles ()
  {
    return mRoles ;
  }


  /**
   * Initialise la liste des r�les.
   * @param pRoles Liste des r�les participant � l'activit�.
   */
  public void setListeRoles (ArrayList pRoles)
  {
    mRoles = pRoles ;
  }


  /**
   * R�cup�re le nombre de r�les participant � l'activit�.
   * @return Nombre de r�les participant � l'activit�.
   */
  public int getNbRolesSorties ()
  {
    return mProduitsEntrees.size () ;
  }


  /**
   * R�cup�re le r�le d'indice sp�cifi� participant � l'activit�.
   * @param pIndice Indice du r�le dans la liste.
   * @return R�le participant � l'activit�.
   */
  public MRole getRoleSortie (int pIndice)
  {
    return (MRole) mProduitsEntrees.get (pIndice) ;
  }


  /**
   * Ajoute le r�le sp�cifi� � l'activit�.
   * @param pRole R�le participant � l'activit�.
   */
  public void addRoleSortie (MRole pRole)
  {
    mProduitsEntrees.add (pRole) ;
  }
}