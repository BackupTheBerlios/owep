package owep.modele.processus ;


import java.util.ArrayList;

import owep.modele.MModeleBase;


/**
 * Un processus repr�sente un regroupement coh�rent d�activit�s, aliment� par des produits en
 * entr�e, qui sont transform�s en produits de sortie, en y apportant une valeur ajout�e pour le
 * client. MProcessus est la classe centrale du paquetage processus.
 */
public class MProcessus extends MModeleBase
{
  private int       mId ;          // Identifie le processus de mani�re unique.
  private String    mNom ;         // Nom d�signant le processus.
  private String    mDescription ; // Description du processus.
  private String    mNomAuteur ;   // Nom de l'auteur du processus.
  private String    mEmailAuteur ; // Email de l'auteur du processus.
  private ArrayList mComposants ;  // Liste des composants d�finissant le processus.


  /**
   * Construit une instance vide de MProcessus.
   */
  public MProcessus ()
  {
    super () ;
    
    mComposants = new ArrayList () ;
  }


  /**
   * Construit une initialis�e de MProcessus.
   * @param pId Identifiant unique du processus.
   * @param pNom Nom d�signant le processus.
   * @param pDescription Description du processus.
   * @param pNomAuteur Nom de l'auteur du processus.
   * @param pEmailAuteur Email de l'auteur du processus.
   */
  public MProcessus (int pId, String pNom, String pDescription, String pNomAuteur,
                     String pEmailAuteur)
  {
    super () ;
    
    mId          = pId ;
    mNom         = pNom ;
    mDescription = pDescription ;
    mNomAuteur   = pNomAuteur ;
    mEmailAuteur = pEmailAuteur ;
    
    mComposants  = new ArrayList () ;
  }


  /**
   * R�cup�re la liste de composants.
   * @return Liste des composants d�finissant le processus.
   */
  public ArrayList getListeComposants ()
  {
    return mComposants ;
  }


  /**
   * Initialise la liste de composants.
   * @param pComposants Liste des composants d�finissant le processus.
   */
  public void setListeComposants (ArrayList pComposants)
  {
    mComposants = pComposants ;
  }


  /**
   * R�cup�re le nombre de composants d�finissant le processus.
   * @return Nombre de composants d�finissant le processus.
   */
  public int getNbComposants ()
  {
    return mComposants.size () ;
  }


  /**
   * R�cup�re le composant d'indice sp�cifi� d�finissant le processus.
   * @param pIndice Indice du composant dans la liste.
   * @return Composant d�finissant le processus.
   */
  public MComposant getComposant (int pIndice)
  {
    return (MComposant) mComposants.get (pIndice) ;
  }


  /**
   * Ajoute le composant sp�cifi� au processus.
   * @param pComposant Composant d�finissant le processus.
   */
  public void addActivite (MComposant pComposant)
  {
    mComposants.add (pComposant) ;
  }


  /**
   * R�cup�re la description du processus.
   * @return Description du processus.
   */
  public String getDescription ()
  {
    return mDescription ;
  }


  /**
   * Initialise la description du processus.
   * @param pDescription Description du processus.
   */
  public void setDescription (String pDescription)
  {
    mDescription = pDescription ;
  }


  /**
   * R�cup�re l'email de l'auteur du processus.
   * @return Email de l'auteur du processus.
   */
  public String getEmailAuteur ()
  {
    return mEmailAuteur ;
  }


  /**
   * Initialise l'email de l'auteur du processus.
   * @param pEmailAuteur Email de l'auteur du processus.
   */
  public void setEmailAuteur (String pEmailAuteur)
  {
    mEmailAuteur = pEmailAuteur ;
  }


  /**
   * R�cup�re l'identifiant du processus.
   * @return Identifiant unique du processus.
   */
  public int getId ()
  {
    return mId ;
  }


  /**
   * Initialise l'identifiant du processus.
   * @param pId Identifiant unique du processus.
   */
  public void setId (int pId)
  {
    mId = pId ;
  }


  /**
   * R�cup�re le nom du processus.
   * @return Nom d�signant le processus.
   */
  public String getNom ()
  {
    return mNom ;
  }


  /**
   * Initialise le nom du processus.
   * @param pNom Nom d�signant le processus.
   */
  public void setNom (String pNom)
  {
    mNom = pNom ;
  }


  /**
   * R�cup�re le nom de l'auteur du processus.
   * @return Nom de l'auteur du processus.
   */
  public String getNomAuteur ()
  {
    return mNomAuteur ;
  }


  /**
   * Initialise le nom de l'auteur du processus.
   * @param pNomAuteur Nom de l'auteur du processus.
   */
  public void setNomAuteur (String pNomAuteur)
  {
    mNomAuteur = pNomAuteur ;
  }
}