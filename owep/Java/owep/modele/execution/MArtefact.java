package owep.modele.execution ;

import java.io.File;


import owep.modele.MModeleBase ;
import owep.modele.processus.MProduit;


/**
 * Un artefact représente un sous-ensemble d'un produit, réalisé durant un projet.
 */
public class MArtefact extends MModeleBase
{
  // Indique la disponibilité de l'artefact
  public static final int INDISPONIBLE = 0 ;
  public static final int DISPONIBLE = 1 ;
    
  private int            mId ;            // Identifie l'artefact de manière unique
  private String         mNom ;           // Nom de l'artefact
  private String         mDescription ;   // Description de l'artefact
  private MTache         mTacheEntree ;   // Tâche dont est issu l'artefact.
  private MTache         mTacheSortie ;   // Tâche qui nécessite l'artefact.
  private MProduit       mProduit ;       // Produit que l'artefact instancie.
  private MCollaborateur mCollaborateur ; // Collaborateur responsable de l'artefact.
  private MProjet        mProjet ;        // Projet pour lequel est réalisé l'artefact.
  private File           mFichier;        // fichier correspondant à l'artefact
  

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
  public MArtefact (int pId, String pNom, String pDescription)
  {
    mId          = pId ;
    mNom         = pNom ;
    mDescription = pDescription ;
    mFichier = null;
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
   * Vérifie si un artefact est disponible
   * @return Disponibilité de l'artefact
   */
  public String estDisponible()
  {
      if (mFichier != null && mFichier.exists()) return "V";
      else return "X";
  }
}