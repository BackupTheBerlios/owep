package owep.modele.execution ;


import owep.modele.MModeleBase ;
import owep.modele.processus.MProduit;


/**
 * Un artefact représente un sous-ensemble d'un produit, réalisé durant un projet.
 */
public class MArtefact extends MModeleBase
{
  private int            mId ;            // Identifie l'artefact de manière unique.
  private String         mNom ;           // Nom de l'artefact.
  private String         mDescription ;   // Description de l'artefact.
  private String         mNomFichier ;    // Nom du fichier correspondant à l'artefact.
  private MTache         mTacheEntree ;   // Tâche dont est issu l'artefact.
  private MTache         mTacheSortie ;   // Tâche qui nécessite l'artefact.
  private MProduit       mProduit ;       // Produit que l'artefact instancie.
  private MCollaborateur mCollaborateur ; // Collaborateur responsable de l'artefact.
  private MProjet        mProjet ;        // Projet pour lequel est réalisé l'artefact.

  public String PATH_ARTEFACT = "Artefacts/"; //Variable global avec le path vers les artefacts (à mettre dans un fichier avec des variables globales)
  
  /**
   * Crée une instance vide de MArtefact.
   */
  public MArtefact ()
  {
  }


  /**
   * Crée une instance initialisée de MArtefact.
   * @param pId Identifiant unique de l'artefact.
   * @param pNom Nom de l'artefact.
   * @param pDescription Description de l'artefact.
   */
  public MArtefact (int pId, String pNom, String pDescription, String pNomFichier)
  {
    mId          = pId ;
    mNom         = pNom ;
    mDescription = pDescription ;
    mNomFichier  = pNomFichier ; 

  }


  /**
   * Récupère le collaborateur responsable de l'artefact.
   * @return Collaborateur responsable de l'artefact.
   */
  public MCollaborateur getCollaborateur ()
  {
    return mCollaborateur ;
  }


  /**
   * Associe le collaborateur responsable de l'artefact.
   * @param pCollaborateur Collaborateur responsable de l'artefact.
   */
  public void setCollaborateur (MCollaborateur pCollaborateur)
  {
    mCollaborateur = pCollaborateur ;
  }


  /**
   * Récupère la description de l'artefact.
   * @return Description de l'artefact.
   */
  public String getDescription ()
  {
    return mDescription ;
  }


  /**
   * Initialise la description de l'artefact.
   * @param pDescription Description de l'artefact.
   */
  public void setDescription (String pDescription)
  {
    mDescription = pDescription ;
  }


  /**
   * Récupère l'identifiant de l'artefact.
   * @return Identifiant unique de l'artefact.
   */
  public int getId ()
  {
    return mId ;
  }


  /**
   * Initialise l'identifiant de l'artefact.
   * @param pId Identifiant unique de l'artefact.
   */
  public void setId (int pId)
  {
    mId = pId ;
  }


  /**
   * Récupère le nom de l'artefact.
   * @return Nom de l'artefact.
   */
  public String getNom ()
  {
    return mNom ;
  }


  /**
   * Initialise le nom de l'artefact.
   * @param pNom Nom de l'artefact.
   */
  public void setNom (String pNom)
  {
    mNom = pNom ;
  }

  /**
   * Récupère le nom du fichier de l'artefact.
   * @return Nom du fichier de l'artefact.
   */
  public String getNomFichier ()
  {
    return mNomFichier ;
  }


  /**
   * Initialise le nom du fichier de l'artefact.
   * @param pNomFichier Nom du fichier de l'artefact.
   */
  public void setNomFichier (String pNomFichier)
  {
    mNomFichier = pNomFichier ;
  }

  /**
   * Récupère le produit que l'artefact instancie.
   * @return Produit que l'artefact instancie.
   */
  public MProduit getProduit ()
  {
    return mProduit ;
  }


  /**
   * Associe le produit que l'artefact instancie.
   * @param pProduit Produit que l'artefact instancie.
   */
  public void setProduit (MProduit pProduit)
  {
    mProduit = pProduit ;
  }


  /**
   * Récupère le projet pour lequel est réalisé l'artefact.
   * @return Projet pour lequel est réalisé l'artefact.
   */
  public MProjet getProjet ()
  {
    return mProjet ;
  }


  /**
   * Initialise le projet pour lequel est réalisé l'artefact.
   * @param pProjet Projet pour lequel est réalisé l'artefact.
   */
  public void setProjet (MProjet pProjet)
  {
    mProjet = pProjet ;
  }


  /**
   * Récupère la tâche dont est issu l'artefact.
   * @return Tâche dont est issu l'artefact.
   */
  public MTache getTacheEntree ()
  {
    return mTacheEntree ;
  }


  /**
   * Initialise la tâche dont est issu l'artefact.
   * @param pTacheEntree Tâche dont est issu l'artefact.
   */
  public void setTacheEntree (MTache pTacheEntree)
  {
    mTacheEntree = pTacheEntree ;
  }


  /**
   * Récupère la tâche qui nécessite l'artefact.
   * @return Tâche qui nécessite l'artefact.
   */
  public MTache getTacheSortie ()
  {
    return mTacheSortie ;
  }


  /**
   * Initialise la tâche qui nécessite l'artefact.
   * @param pTacheSortie Tâche qui nécessite l'artefact.
   */
  public void setTacheSortie (MTache pTacheSortie)
  {
    mTacheSortie = pTacheSortie ;
  }
  
  /**
   * Récupère le lien vers le fichier correspondant à l'artefact.
   * @return le lien vers le fichier correspondant à l'artefact si il existe.
   */
  public String getPathFichier ()
  {
    if (mNomFichier!=null)
    {
      return PATH_ARTEFACT+mProjet.getNom()+"/"+mTacheEntree.getIteration().getNumero()+"/"+mProduit.getNom()+"/" ;
    }
    else
    {
      return "Non disponible";
    }
  }
 
}