package owep.infrastructure;

import java.util.ArrayList;

import owep.modele.execution.MCollaborateur;
import owep.modele.execution.MIteration;
import owep.modele.execution.MProjet;

/**
 * Permet le passage de variable tout au long d'une session utilisateur
 */
public class Session
{
  private MCollaborateur mCollaborateur = null;  // Collaborateur connect�
  private MProjet mProjet = null; // Projet ouvert par le collaborateur connect�
  private ArrayList mListeProjetPossible; // Liste des projets concernant l'utilisateur connect�
  private MIteration mIteration = null; // it�ration ouvert par le collaborateur connect�
  
  /**
   * Ouvre la session pour le collaborateur pass� en param�tre et initialise les variables.
   * @param Collaborateur connect�.
   */
  public void ouvertureSession(MCollaborateur pCollaborateur)
  {
    mCollaborateur = pCollaborateur;
    
    mListeProjetPossible = new ArrayList();
  }
  
  /**
   * Retourne le collaborateur qui a ouvert la session.
   * @return Collaborateur connect�.
   */
  public MCollaborateur getCollaborateur()
  {
    return mCollaborateur;
  }
  
  /**
   * Retourne le projet ouvert par le collaborateur connect�.
   * @return Projet ouvert. Retourne null si aucun projet n'est ouvert.
   */
  public MProjet getProjet()
  {
    return mProjet;
  }
  
  /**
   * Ouvre le projet pass� en param�tre.
   * @param Projet qui doit ouvert.
   */
  public void ouvrirProjet(MProjet pProjet)
  {
    mProjet = pProjet;
  }
  
  /**
   * Ferme le projet ouvert
   */
  public void fermerProjet()
  {
    mProjet = null;
  }
  
  public void setProjet(MProjet pProjet)
  {
    mProjet = pProjet;
  }
  
  /**
   * Retourne la liste des projets sur lesquels le collaborateur peut travailler.
   * @return Liste des projets pouvant �tre ouvert par le collaborateur.
   */
  public ArrayList getListProjetPossible()
  {
    return mListeProjetPossible;
  }
  
  /**
   * Initialise la liste des projets pouvant �tre ouvert par le collaborateur.
   * @param Liste des projets pouvant �tre ouvert par le collaborateur.
   */
  public void setListProjetPossible(ArrayList pListProjetPossible)
  {
    mListeProjetPossible = pListProjetPossible;
  }
  
  public MIteration getIteration()
  {
    return mIteration;
  }
  
  public void setIteration(MIteration pIteration)
  {
    mIteration = pIteration;
  }  
  
}
