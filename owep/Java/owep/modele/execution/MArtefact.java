package owep.modele.execution ;


import owep.modele.MModeleBase ;
import owep.modele.processus.MProduit;


/**
 * Un artefact repr�sente un sous-ensemble d'un produit, r�alis� durant un projet.
 */
public class MArtefact extends MModeleBase
{
  private int            mId ;            // Identifie l'artefact de mani�re unique.
  private String         mNom ;           // Nom de l'artefact.
  private String         mDescription ;   // Description de l'artefact.
  private MTache         mTacheEntree ;   // T�che dont est issu l'artefact.
  private MTache         mTacheSortie ;   // T�che qui n�cessite l'artefact.
  private MProduit       mProduit ;       // Produit que l'artefact instancie.
  private MCollaborateur mCollaborateur ; // Collaborateur responsable de l'artefact.
  private MProjet        mProjet ;        // Projet pour lequel est r�alis� l'artefact.


  /**
   * Cr�e une instance vide de MArtefact.
   */
  public MArtefact ()
  {
  }


  /**
   * Cr�e une instance initialis�e de MArtefact.
   * @param pId Identifiant unique de l'artefact.
   * @param pNom Nom de l'artefact.
   * @param pDescription Description de l'artefact.
   */
  public MArtefact (int pId, String pNom, String pDescription)
  {
    mId          = pId ;
    mNom         = pNom ;
    mDescription = pDescription ;
  }


  /**
   * R�cup�re le collaborateur responsable de l'artefact.
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
   * R�cup�re la description de l'artefact.
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
   * R�cup�re l'identifiant de l'artefact.
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
   * R�cup�re le nom de l'artefact.
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
   * R�cup�re le produit que l'artefact instancie.
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
   * R�cup�re le projet pour lequel est r�alis� l'artefact.
   * @return Projet pour lequel est r�alis� l'artefact.
   */
  public MProjet getProjet ()
  {
    return mProjet ;
  }


  /**
   * Initialise le projet pour lequel est r�alis� l'artefact.
   * @param pProjet Projet pour lequel est r�alis� l'artefact.
   */
  public void setProjet (MProjet pProjet)
  {
    mProjet = pProjet ;
  }


  /**
   * R�cup�re la t�che dont est issu l'artefact.
   * @return T�che dont est issu l'artefact.
   */
  public MTache getTacheEntree ()
  {
    return mTacheEntree ;
  }


  /**
   * Initialise la t�che dont est issu l'artefact.
   * @param pTacheEntree T�che dont est issu l'artefact.
   */
  public void setTacheEntree (MTache pTacheEntree)
  {
    mTacheEntree = pTacheEntree ;
  }


  /**
   * R�cup�re la t�che qui n�cessite l'artefact.
   * @return T�che qui n�cessite l'artefact.
   */
  public MTache getTacheSortie ()
  {
    return mTacheSortie ;
  }


  /**
   * Initialise la t�che qui n�cessite l'artefact.
   * @param pTacheSortie T�che qui n�cessite l'artefact.
   */
  public void setTacheSortie (MTache pTacheSortie)
  {
    mTacheSortie = pTacheSortie ;
  }
}