/*
 * Created on 22 nov. 2004
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package owep.modele.execution;


import java.util.ArrayList ;


/**
 * @author Administrateur TODO To change the template for this generated type comment go to Window -
 *         Preferences - Java - Code Style - Code Templates
 */
public class MCollaborateur
{
  private int       mId ;
  private String    mPrenom ;
  private String    mNom ;
  private String    mAdresse ;
  private String    mTelephone ;
  private String    mPortable ;
  private String    mEmail ;
  private String    mCommentaires ;
  private ArrayList mListesTaches ;


  /**
   * 
   */
  public MCollaborateur ()
  {
    mListesTaches = new ArrayList () ;
  }

  public MCollaborateur (int pId, String pPrenom, String pNom, String pAdresse, String pTelephone,
      String pPortable, String pEmail, String pCommentaires)
  {
    mId = pId ;
    mPrenom = pPrenom ;
    mNom = pNom ;
    mAdresse = pAdresse ;
    mTelephone = pTelephone ;
    mPortable = pPortable ;
    mEmail = pEmail ;
    mCommentaires = pCommentaires ;
    mListesTaches = new ArrayList () ;
  }

  public void ajouterTache (MTache lTache)
  {
    mListesTaches.add(lTache) ;
  }

  public MTache getTache (int pIndice)
  {
    return (MTache) mListesTaches.get(pIndice) ;
  }

  public int getNbTache ()
  {
    return mListesTaches.size() ;
  }

  /**
   * @return Returns the mAdresse.
   */
  public String getAdresse ()
  {
    return mAdresse ;
  }

  /**
   * @param adresse The mAdresse to set.
   */
  public void setAdresse (String adresse)
  {
    mAdresse = adresse ;
  }

  /**
   * @return Returns the mCommentaires.
   */
  public String getCommentaires ()
  {
    return mCommentaires ;
  }

  /**
   * @param commentaires The mCommentaires to set.
   */
  public void setCommentaires (String commentaires)
  {
    mCommentaires = commentaires ;
  }

  /**
   * @return Returns the mEmail.
   */
  public String getEmail ()
  {
    return mEmail ;
  }

  /**
   * @param email The mEmail to set.
   */
  public void setEmail (String email)
  {
    mEmail = email ;
  }

  /**
   * @return Returns the mListesTaches.
   */
  public ArrayList getListesTaches ()
  {
    return mListesTaches ;
  }

  /**
   * @param listesTaches The mListesTaches to set.
   */
  public void setListesTaches (ArrayList listesTaches)
  {
    mListesTaches = listesTaches ;
  }

  /**
   * @return Returns the mNom.
   */
  public String getNom ()
  {
    return mNom ;
  }

  /**
   * @param nom The mNom to set.
   */
  public void setNom (String nom)
  {
    mNom = nom ;
  }

  /**
   * @return Returns the mPortable.
   */
  public String getPortable ()
  {
    return mPortable ;
  }

  /**
   * @param portable The mPortable to set.
   */
  public void setPortable (String portable)
  {
    mPortable = portable ;
  }

  /**
   * @return Returns the mPrenom.
   */
  public String getPrenom ()
  {
    return mPrenom ;
  }

  /**
   * @param prenom The mPrenom to set.
   */
  public void setPrenom (String prenom)
  {
    mPrenom = prenom ;
  }

  /**
   * @return Returns the mTelephone.
   */
  public String getTelephone ()
  {
    return mTelephone ;
  }

  /**
   * @param telephone The mTelephone to set.
   */
  public void setTelephone (String telephone)
  {
    mTelephone = telephone ;
  }

  /**
   * @return Returns the mId.
   */
  public int getId ()
  {
    return mId ;
  }

  /**
   * @param id The mId to set.
   */
  public void setId (int id)
  {
    mId = id ;
  }
}