package owep.infrastructure ;

import java.util.ArrayList;
import java.util.ResourceBundle;

import owep.modele.configuration.MConfigurationSite;
import owep.modele.execution.MCollaborateur;
import owep.modele.execution.MIteration;
import owep.modele.execution.MProjet;

/**
 * Permet le passage de variable tout au long d'une session utilisateur
 */
public class Session
{
  private MCollaborateur mCollaborateur = null;  // Collaborateur connecté
  private MProjet mProjet = null; // Projet ouvert par le collaborateur connecté
  private ArrayList mListeProjetPossible; // Liste des projets concernant l'utilisateur connecté
  private MIteration mIteration = null; // itération ouverte par le collaborateur connecté
  private ResourceBundle messages = null; // resource bundle
  private MConfigurationSite mConfiguration = null; // Tous les éléments de configuration
  private String URLPagePrecedente = null ; //conserve l'URL de la page précédente pour pouvoire y retourner
  private int idCollabAVisualiser ; // identifiant du collaborateur dont on veut visualiser la liste des taches
  private int mIdCollaborateur = 0;
  private int mIdProjet = 0;
  private int mIdIteration = 0;
  
  /**
   * TODO Récupère idCollabAVisualiser.
   * 
   * @return idCollabAVisualiser.
   */
  public int getIdCollabAVisualiser ()
  {
    return idCollabAVisualiser ;
  }

  /**
   * TODO Initialise idCollabAVisualiser.
   * 
   * @param idCollabAVisualiser idCollabAVisualiser.
   */
  public void setIdCollabAVisualiser (int mIdCollabAVisualiser)
  {
    this.idCollabAVisualiser = mIdCollabAVisualiser ;
  }

  /**
   * Ouvre la session pour le collaborateur passé en paramètre et initialise les variables.
   * 
   * @param Collaborateur connecté.
   */
  public void ouvertureSession (MCollaborateur pCollaborateur)
  {
    mCollaborateur = pCollaborateur ;
    mIdCollaborateur = pCollaborateur.getId();

    if (mListeProjetPossible == null)
      mListeProjetPossible = new ArrayList () ;
  }

  /**
   * Retourne le collaborateur qui a ouvert la session.
   * 
   * @return Collaborateur connecté.
   */
  public MCollaborateur getCollaborateur ()
  {
    return mCollaborateur ;
  }

  /**
   * Retourne le projet ouvert par le collaborateur connecté.
   * 
   * @return Projet ouvert. Retourne null si aucun projet n'est ouvert.
   */
  public MProjet getProjet ()
  {
    return mProjet ;
  }

  /**
   * Ouvre le projet passé en paramètre.
   * 
   * @param Projet qui doit ouvert.
   */
  public void ouvrirProjet (MProjet pProjet)
  {
    mProjet = pProjet ;
    mIdProjet = pProjet.getId();
  }

  /**
   * Ferme le projet ouvert
   */
  public void fermerProjet ()
  {
    mProjet = null ;
    mIdProjet = 0;
  }

  public void setProjet (MProjet pProjet)
  {
    mProjet = pProjet ;
    mIdProjet = pProjet.getId();
  }

  /**
   * Retourne la liste des projets sur lesquels le collaborateur peut travailler.
   * 
   * @return Liste des projets pouvant être ouvert par le collaborateur.
   */
  public ArrayList getListProjetPossible ()
  {
    return mListeProjetPossible ;
  }

  /**
   * Initialise la liste des projets pouvant être ouvert par le collaborateur.
   * 
   * @param Liste des projets pouvant être ouvert par le collaborateur.
   */
  public void setListProjetPossible (ArrayList pListProjetPossible)
  {
    mListeProjetPossible = pListProjetPossible ;
  }

  public MIteration getIteration ()
  {
    return mIteration ;
  }

  public void setIteration (MIteration pIteration)
  {
    mIteration = pIteration ;
    if(pIteration != null)
    mIdIteration = pIteration.getId();
  }

  /**
   * @return Retourne la valeur de l'attribut messages.
   */
  public ResourceBundle getMessages ()
  {
    return messages ;
  }

  /**
   * @param initialse messages avec pMessages.
   */
  public void setMessages (ResourceBundle pMessages)
  {
    messages = pMessages ;
  }

  /**
   * @return Retourne la valeur de l'attribut cofiguration.
   */
  public MConfigurationSite getConfiguration ()
  {
    return mConfiguration ;
  }

  /**
   * @param initialse cofiguration avec pCofiguration.
   */
  public void setConfiguration (MConfigurationSite pCofiguration)
  {
    mConfiguration = pCofiguration ;
  }

  /**
   * @return Retourne la valeur de l'attribut uRLPagePrecedente.
   */
  public String getURLPagePrecedente ()
  {
    return URLPagePrecedente ;
  }

  /**
   * @param initialse uRLPagePrecedente avec pPagePrecedente.
   */
  public void setURLPagePrecedente (String pPagePrecedente)
  {
    URLPagePrecedente = pPagePrecedente ;
  }
  
  /**
   * @return Retourne la valeur de l'attribut idCollaborateur.
   */
  public int getIdCollaborateur ()
  {
    return mIdCollaborateur ;
  }
  
  /**
   * @param initialse idCollaborateur avec pIdCollaborateur.
   */
  public void setIdCollaborateur (int pIdCollaborateur)
  {
    mIdCollaborateur = pIdCollaborateur ;
  }
  
  /**
   * @return Retourne la valeur de l'attribut idIteration.
   */
  public int getIdIteration ()
  {
    return mIdIteration ;
  }
  
  /**
   * @param initialse idIteration avec pIdIteration.
   */
  public void setIdIteration (int pIdIteration)
  {
    mIdIteration = pIdIteration ;
  }
  
  /**
   * @return Retourne la valeur de l'attribut idProjet.
   */
  public int getIdProjet ()
  {
    return mIdProjet ;
  }
  
  /**
   * @param initialse idProjet avec pIdProjet.
   */
  public void setIdProjet (int pIdProjet)
  {
    mIdProjet = pIdProjet ;
  }
}