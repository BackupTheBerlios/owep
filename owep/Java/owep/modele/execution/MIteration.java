package owep.modele.execution;

import java.sql.Date;
import java.util.ArrayList;

/**
 * Une itération est une période dans la conception d'un projet.
 */
public class MIteration
{
  private int       mNumero ;           // Numéro de l'itération  
  private Date      mDateDebutPrevue ;  // Date de début de l'itération
  private Date      mDateFinPrevue ;    // Date de fin prévue de l'itération
  private Date      mDateDebutReelle ;  // Date de début réelle de l'itération
  private Date      mDateFinReelle ;    // Date de fin réelle de l'itération
  private ArrayList mListeTaches ;      // Liste des tâches composant l'itération
 
  /**
   * Crée une instance vide de MIteration
   */
  public MIteration ()
  {
    mListeTaches = new ArrayList ();
  }
  
  /**
   * Crée une instance de MIteration
   * @param pNumero Numero de l'itération
   */
  public MIteration (int pNumero) {
    mNumero      = pNumero ;
    mListeTaches = new ArrayList ();
  }
  
  /**
   * Crée une instance de MIteration
   * @param pNumero Numéro de l'itération 
   * @param pDateDebutPrevue Date de début prévue de l'itération 
   * @param pDateFinPrevue Date de fin prévue de l'itération
   * @param pDateDebutReelle Date de début réelle de l'itération
   * @param pDateFinReelle Date de fin réelle de l'itération
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
   * Crée une instance de MIteration
   * @param pNumero Numéro de l'itération 
   * @param pDateDebutPrevue Date de début prévue de l'itération 
   * @param pDateFinPrevue Date de fin prévue de l'itération
   * @param pDateDebutReelle Date de début réelle de l'itération
   * @param pDateFinReelle Date de fin réelle de l'itération
   * @param pListeTachess Liste des taches de l'itération 
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
