package owep.modele.execution ;


/**
 * MCondition permet de stocker une dépendance entre deux tâches. Si la tâche à l'origine de la
 * dépendance est dans l'état souhaité, la condition est considérée comme vérifiée.
 */
public class MCondition
{
  private MTache mTache ;           // Tâche ayant une dépendance.
  private MTache mTachePrecedente ; // Tâche vers laquelle il y a une dépendance.
  private int    mEtat ;            // Etat de la tâche nécessaire pour que la condition soit vrai.


  /**
   * Construit une instance vide de MCondition.
   */
  public MCondition ()
  {
    super () ;
  }


  /**
   * Construit une instance initialisée de MCondition.
   * @param pTache Identifiant de la tâche ayant une dépendance.
   * @param pTachePrecedente Tâche vers laquelle il y a une dépendance.
   * @param pEtat Etat de la tâche nécessaire pour que la condition soit vrai.
   */
  public MCondition (MTache pTache, MTache pTachePrecedente, int pEtat)
  {
    super () ;
    
    mTache           = pTache ;
    mTachePrecedente = pTachePrecedente ;
    mEtat            = pEtat ;
  }


  /**
   * Récupère l'état de la tâche nécessaire pour que la condition soit vrai.
   * @return Etat de la tâche nécessaire pour que la condition soit vrai.
   */
  public int getEtat ()
  {
    return mEtat ;
  }


  /**
   * Initialise l'état de la tâche nécessaire pour que la condition soit vrai.
   * @param pEtat Etat de la tâche nécessaire pour que la condition soit vrai.
   */
  public void setEtat (int pEtat)
  {
    mEtat = pEtat ;
  }


  /**
   * Récupère la tâche ayant une dépendance.
   * @return Tâche ayant une dépendance.
   */
  public MTache getTache ()
  {
    return mTache ;
  }


  /**
   * Initialise la tâche ayant une dépendance.
   * @param pTache Tâche ayant une dépendance.
   */
  public void setTache (MTache pTache)
  {
    mTache = pTache ;
  }


  /**
   * Récupère la tâche vers laquelle il y a une dépendance.
   * @return Tâche vers laquelle il y a une dépendance.
   */
  public MTache getTachePrecedente ()
  {
    return mTachePrecedente ;
  }


  /**
   * Associe la tâche vers laquelle il y a une dépendance.
   * @param pTachePrecedente Tâche vers laquelle il y a une dépendance.
   */
  public void setTachePrecedente (MTache pTachePrecedente)
  {
    mTachePrecedente = pTachePrecedente ;
  }
  
  
  /**
   * Indique si la condition est vérifiée, c'est à dire si la tâche à l'origine de la dépendance est
   * dans l'état souhaité.
   * @return True si la condition est vérifiée et False sinon.
   */
  boolean estVerifiee ()
  {
    return mTachePrecedente.getEtat () == mEtat ;
  }
}