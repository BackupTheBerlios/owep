package owep.modele.execution;

import java.sql.Date;
import java.util.ArrayList;

/**
 * Une it�ration est une p�riode dans la conception d'un projet.
 */
public class MIteration
{
  private int       mNumero ;           // Num�ro de l'it�ration  
  private Date      mDateDebutPrevue ;  // Date de d�but de l'it�ration
  private Date      mDateFinPrevue ;    // Date de fin pr�vue de l'it�ration
  private Date      mDateDebutReelle ;  // Date de d�but r�elle de l'it�ration
  private Date      mDateFinReelle ;    // Date de fin r�elle de l'it�ration
  private ArrayList mListeTaches ;      // Liste des t�ches composant l'it�ration
 
  /**
   * Cr�e une instance vide de MIteration
   */
  public MIteration ()
  {
    mListeTaches = new ArrayList ();
  }
  
  /**
   * Cr�e une instance de MIteration
   * @param pNumero Numero de l'it�ration
   */
  public MIteration (int pNumero) {
    mNumero      = pNumero ;
    mListeTaches = new ArrayList ();
  }
  
  /**
   * Cr�e une instance de MIteration
   * @param pNumero Num�ro de l'it�ration 
   * @param pDateDebutPrevue Date de d�but pr�vue de l'it�ration 
   * @param pDateFinPrevue Date de fin pr�vue de l'it�ration
   * @param pDateDebutReelle Date de d�but r�elle de l'it�ration
   * @param pDateFinReelle Date de fin r�elle de l'it�ration
   */
  public MIteration (int pNumero, Date pDateDebutPrevue, Date pDateFinPrevue, 
                     Date pDateDebutReelle, Date pDateFinReelle) {
    
    mNumero          = pNumero ;
    mDateDebutPrevue = pDateDebutPrevue ;
    mDateFinPrevue   = pDateFinPrevue ;
    mDateDebutReelle = pDateDebutReelle ;
    mDateFinReelle   = pDateFinReelle ;
    mListeTaches     = new ArrayList ();
  }
  
  /**
   * Cr�e une instance de MIteration
   * @param pNumero Num�ro de l'it�ration 
   * @param pDateDebutPrevue Date de d�but pr�vue de l'it�ration 
   * @param pDateFinPrevue Date de fin pr�vue de l'it�ration
   * @param pDateDebutReelle Date de d�but r�elle de l'it�ration
   * @param pDateFinReelle Date de fin r�elle de l'it�ration
   * @param pListeTachess Liste des taches de l'it�ration 
   */
  public MIteration (int pNumero, Date pDateDebutPrevue, Date pDateFinPrevue, 
                     Date pDateDebutReelle, Date pDateFinReelle, 
                     ArrayList pListeTaches) {
    
    mNumero          = pNumero ;
    mDateDebutPrevue = pDateDebutPrevue ;
    mDateFinPrevue   = pDateFinPrevue ;
    mDateDebutReelle = pDateDebutReelle ;
    mDateFinReelle   = pDateFinReelle ;
    mListeTaches     = pListeTaches;
  }
  
  /**
   * @return Retourne la valeur de l'attribut dateDebutPrevue.
   */
  public Date getDateDebutPrevue ()
  {
    return mDateDebutPrevue ;
  }
  
  /**
   * @param initialise dateDebutPrevue avec pDateDebutPrevue.
   */
  public void setDateDebutPrevue (Date pDateDebutPrevue)
  {
    mDateDebutPrevue = pDateDebutPrevue ;
  }
  
  /**
   * @return Retourne la valeur de l'attribut dateDebutReelle.
   */
  public Date getDateDebutReelle ()
  {
    return mDateDebutReelle ;
  }
  
  /**
   * @param initialise dateDebutReelle avec pDateDebutReelle.
   */
  public void setDateDebutReelle (Date pDateDebutReelle)
  {
    mDateDebutReelle = pDateDebutReelle ;
  }
  
  /**
   * @return Retourne la valeur de l'attribut dateFinPrevue.
   */
  public Date getDateFinPrevue ()
  {
    return mDateFinPrevue ;
  }
  
  /**
   * @param initialise dateFinPrevue avec pDateFinPrevue.
   */
  public void setDateFinPrevue (Date pDateFinPrevue)
  {
    mDateFinPrevue = pDateFinPrevue ;
  }
  
  /**
   * @return Retourne la valeur de l'attribut dateFinReelle.
   */
  public Date getDateFinReelle ()
  {
    return mDateFinReelle ;
  }
  
  /**
   * @param initialise dateFinReelle avec pDateFinReelle.
   */
  public void setDateFinReelle (Date pDateFinReelle)
  {
    mDateFinReelle = pDateFinReelle ;
  }
  
  /**
   * @return Retourne la valeur de l'attribut numero.
   */
  public int getNumero ()
  {
    return mNumero ;
  }
  
  /**
   * @param initialise numero avec pNumero.
   */
  public void setNumero (int pNumero)
  {
    mNumero = pNumero ;
  }
  
  /**
   * @return Retourne la valeur de l'attribut listeActivites.
   */
  public ArrayList getListeActivites ()
  {
    return mListeTaches ;
  }
  
  /**
   * @param initialise listeTaches avec pListeTaches.
   */
  public void setListeActivites (ArrayList pListeTaches)
  {
    mListeTaches = pListeTaches ;
  }
}
