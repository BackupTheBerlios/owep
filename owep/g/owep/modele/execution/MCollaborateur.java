package owep.modele.execution ;


import java.util.ArrayList;

import owep.modele.MModeleBase;
import owep.modele.processus.MRole;


/**
 * Un collaborateur repr�sente une personne travaillant sur un ou plusieurs projet.
 */
public class MCollaborateur extends MModeleBase
{
  private int       mId ;           // Identifie le collaborateur de mani�re unique.
  private String    mPrenom ;       // Pr�nom du collaborateur.
  private String    mNom ;          // Nom du collaborateur.
  private String    mAdresse ;      // Adresse du collaborateur.
  private String    mTelephone ;    // T�l�phone du collaborateur.
  private String    mPortable ;     // Portable du collaborateur.
  private String    mEmail ;        // Email du collaborateur.
  private String    mCommentaires ; // Commentaires du chef de projet sur le collaborateur.
  private String    mUtilisateur ;  // Nom d'utilisateur pour la connexion.
  private String    mMotDePasse ;   // Mot de passe lors de la connexion.
  private ArrayList mArtefacts ;    // Artefacts dont le collaborateur est responsable.
  private ArrayList mRoles ;        // R�les tenues par le collaborateur.
  private ArrayList mTaches ;       // Listes des t�ches que doient r�aliser le collaborateur.


  /**
   * Cr�e une instance vide de MCollaborateur.
   */
  public MCollaborateur ()
  {
    mTaches = new ArrayList () ;
  }


  /**
   * Cr�e une instance initialis�e de MArtefact.
   * @param pId Identifiant unique de l'artefact.
   * @param pPrenom Pr�nom du collaborateur.
   * @param pNom Nom du collaborateur.
   * @param pAdresse Adresse du collaborateur.
   * @param pTelephone T�l�phone du collaborateur.
   * @param pPortable Portable du collaborateur.
   * @param pEmail Email du collaborateur.
   * @param pCommentaires Commentaires du chef de projet sur le collaborateur.
   */
  public MCollaborateur (int pId, String pPrenom, String pNom, String pAdresse, String pTelephone,
                         String pPortable, String pEmail, String pCommentaires)
  {
    mId           = pId ;
    mPrenom       = pPrenom ;
    mNom          = pNom ;
    mAdresse      = pAdresse ;
    mTelephone    = pTelephone ;
    mPortable     = pPortable ;
    mEmail        = pEmail ;
    mCommentaires = pCommentaires ;
    
    mTaches = new ArrayList () ;
  }


  /**
   * R�cup�re l'adresse du collaborateur.
   * @return Adresse du collaborateur.
   */
  public String getAdresse ()
  {
    return mAdresse ;
  }


  /**
   * Initialise l'adresse du collaborateur.
   * @param pAdresse Adresse du collaborateur.
   */
  public void setAdresse (String pAdresse)
  {
    mAdresse = pAdresse ;
  }


  /**
   * R�cup�re les artefacts dont le collaborateur est responsable.
   * @return Artefacts dont le collaborateur est responsable.
   */
  public ArrayList getListeArtefacts ()
  {
    return mArtefacts ;
  }


  /**
   * Initialise les artefacts dont le collaborateur est responsable.
   * @param pArtefacts Artefacts dont le collaborateur est responsable.
   */
  public void setListeArtefacts (ArrayList pArtefacts)
  {
    mArtefacts = pArtefacts ;
  }


  /**
   * R�cup�re le nombre d'artefacts dont le collaborateur est responsable.
   * @return Nombre d'artefacts dont le collaborateur est responsable.
   */
  public int getNbArtefacts ()
  {
    return mArtefacts.size () ;
  }


  /**
   * R�cup�re l'artefact d'indice sp�cifi� dont le collaborateur est responsable.
   * @param pIndice Indice de l'artefact dont le collaborateur est responsable.
   * @return Artefact dont le collaborateur est responsable.
   */
  public MArtefact getArtefact (int pIndice)
  {
    return (MArtefact) mArtefacts.get (pIndice) ;
  }


  /**
   * Ajoute un artefact dont le collaborateur est responsable.
   * @param pArtefact Artefact dont le collaborateur est responsable.
   */
  public void addArtefact (MArtefact pArtefact)
  {
    mArtefacts.add (pArtefact) ;
  }


  /**
   * R�cup�re les commentaires du chef de projet.
   * @return Commentaires du chef de projet sur le collaborateur.
   */
  public String getCommentaires ()
  {
    return mCommentaires ;
  }


  /**
   * Initialise les commentaires du chef de projet.
   * @param pCommentaires Commentaires du chef de projet sur le collaborateur.
   */
  public void setCommentaires (String pCommentaires)
  {
    mCommentaires = pCommentaires ;
  }


  /**
   * R�cup�re l'email du collaborateur.
   * @return Email du collaborateur.
   */
  public String getEmail ()
  {
    return mEmail ;
  }


  /**
   * Initialise l'email du collaborateur.
   * @param pEmail Email du collaborateur.
   */
  public void setEmail (String pEmail)
  {
    mEmail = pEmail ;
  }


  /**
   * R�cup�re l'identifiant du collaborateur.
   * @return Identifiant unique du collaborateur.
   */
  public int getId ()
  {
    return mId ;
  }


  /**
   * Initialise l'identifiant du collaborateur.
   * @param pId Identifiant unique du collaborateur.
   */
  public void setId (int pId)
  {
    mId = pId ;
  }


  /**
   * R�cup�re le mot de passe.
   * @return Mot de passe lors de la connexion.
   */
  public String getMotDePasse ()
  {
    return mMotDePasse ;
  }


  /**
   * Initialise le mot de passe.
   * @param pMotDePasse Mot de passe lors de la connexion.
   */
  public void setMotDePasse (String pMotDePasse)
  {
    mMotDePasse = pMotDePasse ;
  }


  /**
   * R�cup�re le nom du collaborateur.
   * @return Nom du collaborateur.
   */
  public String getNom ()
  {
    return mNom ;
  }


  /**
   * Initialise le nom du collaborateur.
   * @param pNom Nom du collaborateur.
   */
  public void setNom (String pNom)
  {
    mNom = pNom ;
  }


  /**
   * R�cup�re le portable du collaborateur.
   * @return Portable du collaborateur.
   */
  public String getPortable ()
  {
    return mPortable ;
  }


  /**
   * Initialise le portable du collaborateur.
   * @param pPortable Portable du collaborateur.
   */
  public void setPortable (String pPortable)
  {
    mPortable = pPortable ;
  }


  /**
   * R�cup�re le pr�nom du collaborateur.
   * @return Pr�nom du collaborateur.
   */
  public String getPrenom ()
  {
    return mPrenom ;
  }


  /**
   * Initialise le pr�nom du collaborateur.
   * @param pPrenom Pr�nom du collaborateur.
   */
  public void setPrenom (String pPrenom)
  {
    mPrenom = pPrenom ;
  }


  /**
   * R�cup�re les r�les tenues par le collaborateur.
   * @return R�les tenues par le collaborateur.
   */
  public ArrayList getListeRoles ()
  {
    return mRoles ;
  }


  /**
   * R�cup�re les r�les tenues par le collaborateur.
   * @param pRoles R�les tenues par le collaborateur.
   */
  public void setListeRoles (ArrayList pRoles)
  {
    mRoles = pRoles ;
  }


  /**
   * R�cup�re le nombre de Roles que doit r�aliser le collaborateur.
   * @return Nombre de r�les tenus par le collaborateur.
   */
  public int getNbRoles ()
  {
    return mRoles.size () ;
  }


  /**
   * R�cup�re le r�le d'indice sp�cifi� tenu par le collaborateur.
   * @param pIndice Indice du r�le dans la liste.
   * @return R�le tenu par le collaborateur.
   */
  public MRole getRole (int pIndice)
  {
    return (MRole) mRoles.get (pIndice) ;
  }


  /**
   * Ajoute un r�le tenu par le collaborateur.
   * @param pRole R�le tenu par le collaborateur.
   */
  public void addRole (MRole pRole)
  {
    mRoles.add (pRole) ;
  }


  /**
   * R�cup�re la liste des t�ches que doit r�aliser le collaborateur.
   * @return Liste des t�ches que doit r�aliser le collaborateur.
   */
  public ArrayList getListeTaches ()
  {
    return mTaches ;
  }


  /**
   * Initialise la liste des t�ches que doit r�aliser le collaborateur.
   * @param pTaches Liste des t�ches que doit r�aliser le collaborateur.
   */
  public void setListeTaches (ArrayList pTaches)
  {
    mTaches = pTaches ;
  }


  /**
   * R�cup�re le nombre de t�ches que doit r�aliser le collaborateur.
   * @return Nombre de t�ches que doit r�aliser le collaborateur.
   */
  public int getNbTaches ()
  {
    return mTaches.size () ;
  }


  /**
   * R�cup�re la t�che d'indice sp�cifi� que doit r�aliser le collaborateur.
   * @param pIndice Indice de la t�che dans la liste.
   * @return T�che que doit r�aliser le collaborateur.
   */
  public MTache getTache (int pIndice)
  {
    return (MTache) mTaches.get (pIndice) ;
  }


  /**
   * Ajoute la t�che sp�cifi�e au collaborateur.
   * @param pTache T�che que doit r�aliser le collaborateur.
   */
  public void addTache (MTache pTache)
  {
    mTaches.add (pTache) ;
  }


  /**
   * R�cup�re le t�l�pone du collaborateur.
   * @return T�l�pone du collaborateur.
   */
  public String getTelephone ()
  {
    return mTelephone ;
  }


  /**
   * Initialise le t�l�pone du collaborateur.
   * @param pTelephone T�l�phone du collaborateur.
   */
  public void setTelephone (String pTelephone)
  {
    mTelephone = pTelephone ;
  }


  /**
   * R�cup�re le nom d'utilisateur pour la connexion.
   * @return Nom d'utilisateur pour la connexion.
   */
  public String getUtilisateur ()
  {
    return mUtilisateur ;
  }


  /**
   * Initialise le nom d'utilisateur pour la connexion.
   * @param pUtilisateur Nom d'utilisateur pour la connexion.
   */
  public void setUtilisateur (String pUtilisateur)
  {
    mUtilisateur = pUtilisateur ;
  }
}