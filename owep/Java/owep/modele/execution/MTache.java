/*
 * Created on 22 nov. 2004
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package owep.modele.execution;


import java.util.ArrayList ;
import java.util.Date ;


/**
 * @author Administrateur TODO To change the template for this generated type comment go to Window -
 *         Preferences - Java - Code Style - Code Templates
 */
public class MTache
{
  public static final int ETAT_EN_COURS    = 0 ;
  public static final int ETAT_TERMINE     = 1 ;
  public static final int ETAT_NON_DEMARRE = 2 ;

  /**/
  private int             mId ;
  private String          mNom ;
  private String          mDescription ;
  private double          mChargeInitiale ;
  private double          mTempsPasse ;
  private double          mResteAPasser ;
  private Date            mDateDebutPrevue ;
  private Date            mDateDebutReelle ;
  private Date            mDateFinPrevue ;
  private Date            mDateFinReelle ;
  private ArrayList       mListArtefactEntree ;
  private ArrayList       mListArtefactSortie ;
  private MActivite       mActivite ;


  /**
   * 
   */
  public MTache ()
  {
    mListArtefactEntree = new ArrayList () ;
    mListArtefactSortie = new ArrayList () ;
  }

  public MTache (int pId, String pNom, String pDescription, double pChargeInitiale,
      Date pDateDebutPrevue, Date pDateFinPrevue, MActivite pActivite)
  {
    mId = pId ;
    mNom = pNom ;
    mDescription = pDescription ;
    mChargeInitiale = pChargeInitiale ;
    mDateDebutPrevue = pDateDebutPrevue ;
    mDateFinPrevue = pDateFinPrevue ;
    mActivite = pActivite ;
    mListArtefactEntree = new ArrayList () ;
    mListArtefactSortie = new ArrayList () ;
  }

  public MTache (int pId, String pNom, String pDescription, double pChargeInitiale,
      double pTempsPasse, double pResteAPasser, Date pDateDebutPrevue, Date pDateDebutReelle,
      Date pDateFinPrevue, Date pDateFinReelle, MActivite pActivite)
  {
    mId = pId ;
    mNom = pNom ;
    mDescription = pDescription ;
    mChargeInitiale = pChargeInitiale ;
    mTempsPasse = pTempsPasse ;
    mResteAPasser = pResteAPasser ;
    mDateDebutPrevue = pDateDebutPrevue ;
    mDateDebutReelle = pDateDebutReelle ;
    mDateFinPrevue = pDateFinPrevue ;
    mDateFinReelle = pDateFinReelle ;
    mActivite = pActivite ;
    mListArtefactEntree = new ArrayList () ;
    mListArtefactSortie = new ArrayList () ;
  }


  public void ajouterArtefactEntree (MArtefact pArtefactEntree)
  {
    mListArtefactEntree.add(pArtefactEntree) ;
  }

  public MArtefact getArtefactEntree (int pIndice)
  {
    return (MArtefact) mListArtefactEntree.get(pIndice) ;
  }

  public int getNbArtefactEntree ()
  {
    return mListArtefactEntree.size() ;
  }

  public void ajouterArtefactSortie (MArtefact pArtefactSortie)
  {
    mListArtefactSortie.add (pArtefactSortie) ;
  }

  public MArtefact getArtefactSortie (int pIndice)
  {
    return (MArtefact) mListArtefactSortie.get(pIndice) ;
  }

  public int getNbArtefactSortie ()
  {
    return mListArtefactSortie.size() ;
  }

  public int getEtat ()
  {
    if (mTempsPasse == 0)
    {
      return ETAT_NON_DEMARRE ;
    }
    else if (mResteAPasser == 0)
    {
      return ETAT_TERMINE ;
    }
    else
    {
      return ETAT_EN_COURS ;
    }
  }

  public double getBudgetConsomme ()
  {
    return mTempsPasse / mChargeInitiale ;
  }

  public double getHJDepassementCharge ()
  {
    return mTempsPasse + mResteAPasser - mChargeInitiale ;
  }

  public double getPrcDepassementCharge ()
  {
    return (mTempsPasse + mResteAPasser) / mChargeInitiale ;
  }

  public double getPrcAvancement ()
  {
    if ((mTempsPasse == 0) && (mResteAPasser == 0))
    {
      return 100 ;
    }
    else
    {
      return (mTempsPasse / (mTempsPasse + mResteAPasser)) * 100 ;
    }
  }

  /**
   * @return Returns the mChargeInitiale.
   */
  public double getChargeInitiale ()
  {
    return mChargeInitiale ;
  }

  /**
   * @param chargeInitiale The mChargeInitiale to set.
   */
  public void setChargeInitiale (double chargeInitiale)
  {
    mChargeInitiale = chargeInitiale ;
  }

  /**
   * @return Returns the mDateDebutPrevue.
   */
  public Date getDateDebutPrevue ()
  {
    return mDateDebutPrevue ;
  }

  /**
   * @param dateDebutPrevue The mDateDebutPrevue to set.
   */
  public void setDateDebutPrevue (Date dateDebutPrevue)
  {
    mDateDebutPrevue = dateDebutPrevue ;
  }

  /**
   * @return Returns the mDateDebutReelle.
   */
  public Date getDateDebutReelle ()
  {
    return mDateDebutReelle ;
  }

  /**
   * @param dateDebutReelle The mDateDebutReelle to set.
   */
  public void setDateDebutReelle (Date dateDebutReelle)
  {
    mDateDebutReelle = dateDebutReelle ;
  }

  /**
   * @return Returns the mDateFinPrevue.
   */
  public Date getDateFinPrevue ()
  {
    return mDateFinPrevue ;
  }

  /**
   * @param dateFinPrevue The mDateFinPrevue to set.
   */
  public void setDateFinPrevue (Date dateFinPrevue)
  {
    mDateFinPrevue = dateFinPrevue ;
  }

  /**
   * @return Returns the mDateFinReelle.
   */
  public Date getDateFinReelle ()
  {
    return mDateFinReelle ;
  }

  /**
   * @param dateFinReelle The mDateFinReelle to set.
   */
  public void setDateFinReelle (Date dateFinReelle)
  {
    mDateFinReelle = dateFinReelle ;
  }

  /**
   * @return Returns the mDescription.
   */
  public String getDescription ()
  {
    return mDescription ;
  }

  /**
   * @param description The mDescription to set.
   */
  public void setDescription (String description)
  {
    mDescription = description ;
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
   * @return Returns the mResteAPasser.
   */
  public double getResteAPasser ()
  {
    return mResteAPasser ;
  }

  /**
   * @param resteAPasser The mResteAPasser to set.
   */
  public void setResteAPasser (double resteAPasser)
  {
    mResteAPasser = resteAPasser ;
  }

  /**
   * @return Returns the mTempsPasse.
   */
  public double getTempsPasse ()
  {
    return mTempsPasse ;
  }

  /**
   * @param tempsPasse The mTempsPasse to set.
   */
  public void setTempsPasse (double tempsPasse)
  {
    mTempsPasse = tempsPasse ;
  }

  /**
   * @return Returns the mListArtefactEntree.
   */
  public ArrayList getListArtefactEntree ()
  {
    return mListArtefactEntree ;
  }

  /**
   * @param listArtefactEntree The mListArtefactEntree to set.
   */
  public void setListArtefactEntree (ArrayList listArtefactEntree)
  {
    mListArtefactEntree = listArtefactEntree ;
  }

  /**
   * @return Returns the mListArtefactSortie.
   */
  public ArrayList getListArtefactSortie ()
  {
    return mListArtefactSortie ;
  }

  /**
   * @param listArtefactSortie The mListArtefactSortie to set.
   */
  public void setListArtefactSortie (ArrayList listArtefactSortie)
  {
    mListArtefactSortie = listArtefactSortie ;
  }

  /**
   * @return Returns the mActivite.
   */
  public MActivite getActivite ()
  {
    return mActivite ;
  }

  /**
   * @param nomActiviteLiee The mActivite to set.
   */
  public void setActivite (MActivite pActivite)
  {
    mActivite = pActivite ;
  }
}