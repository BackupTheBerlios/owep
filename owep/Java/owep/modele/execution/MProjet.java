package owep.modele.execution ;


import java.util.Date ;
import java.util.ArrayList ;
import java.util.Iterator ;

import owep.modele.MModeleBase ;
import owep.modele.processus.MProcessus ;


/**
 * Un projet est constitu� d'un ensemble de t�ches, de produits et de collaborateurs. MProjet est la
 * classe centrale du paquetage execution.
 */
public class MProjet extends MModeleBase
{
  private int            mId ;                // Identifie le projet de mani�re unique.
  private String         mNom ;               // Nom du projet.
  private String         mDescription ;       // Description du projet.
  private String         mBilan ;             // Bilan du projet.
  private Date           mDateDebutPrevue ;   // Date de d�but pr�vue pour le projet.
  private Date           mDateFinPrevue ;     // Date de fin pr�vue pour le projet.
  private Date           mDateDebutReelle ;   // Date de d�but r�elle du projet.
  private Date           mDateFinReelle ;     // Date de fin r�elle du projet.
  private int            mEtat ;              // Etat de l iteration
  private double         mBudget ;            // Budget allou� au projet
  private ArrayList      mArtefacts ;         // Liste des artefacts r�alis�s durant le projet.
  private ArrayList      mCollaborateurs ;    // Liste des collaborateurs travaillant sur le projet.
  private ArrayList      mIterations ;        // Liste des it�rations r�alis�es durant le projet.
  private MProcessus     mProcessus ;         // Processus utilis� par le projet.
  private MCollaborateur mChefProjet ;        // Chef de projet.
  private ArrayList      mActivitesImprevues ; // Listes des activit�s impr�vues de ce projet
  private ArrayList      mArtefactsImprevues ; // Liste des artefacts impr�vues r�alis�s durant le
  // projet.
  private ArrayList      mRisques ;           // Liste des risques qui doivent �tre g�rer sur le
  // projet.
  private ArrayList      mIndicateurs ;       // Liste des indicateurs associ�s au projet.


  /**
   * Cr�e une instance vide de MProjet.
   */
  public MProjet ()
  {
    super () ;
    mIterations = new ArrayList () ;
    mArtefacts = new ArrayList () ;
    mCollaborateurs = new ArrayList () ;
    mActivitesImprevues = new ArrayList () ;
    mArtefactsImprevues = new ArrayList () ;
    mRisques = new ArrayList () ;
    mIndicateurs = new ArrayList () ;
  }

  /**
   * @param pId
   */
  public MProjet (int pId)
  {
    super () ;
    mId = pId ;

    mIterations = new ArrayList () ;
    mArtefacts = new ArrayList () ;
    mCollaborateurs = new ArrayList () ;
    mActivitesImprevues = new ArrayList () ;
    mArtefactsImprevues = new ArrayList () ;
    mRisques = new ArrayList () ;
    mIndicateurs = new ArrayList () ;
  }

  /**
   * Cr�e une instance initialis�e de MProjet.
   * 
   * @param pId Identifiant du projet.
   * @param pNom Nom du projet.
   * @param pDescription Description du projet.
   * @param pDateDebutPrevue Date de d�but pr�vue du projet.
   * @param pDateFinPrevue Date de fin pr�vue du projet.
   */
  public MProjet (int pId, String pNom, String pDescription, Date pDateDebutPrevue,
                  Date pDateFinPrevue)
  {
    super () ;
    mId = pId ;
    mNom = pNom ;
    mDescription = pDescription ;
    mDateDebutPrevue = pDateDebutPrevue ;
    mDateFinPrevue = pDateFinPrevue ;

    mIterations = new ArrayList () ;
    mArtefacts = new ArrayList () ;
    mCollaborateurs = new ArrayList () ;
    mActivitesImprevues = new ArrayList () ;
    mArtefactsImprevues = new ArrayList () ;
    mRisques = new ArrayList () ;
    mIndicateurs = new ArrayList () ;
  }

  /**
   * Permet de r�cup�rer l'it�ration en cours du projet.
   * 
   * @return l'it�ration en cours.
   */
  public MIteration getIterationEnCours ()
  {
    for (int i = 0 ; i < getNbIterations () ; i++)
    {
      MIteration lIteration = getIteration (i) ;
      if (lIteration.getEtat () == 1)
      {
        return lIteration ;
      }
    }
    return null ;
  }

  /**
   * R�cup�re la liste des artefacts r�alis�s durant le projet.
   * 
   * @return Liste des artefacts r�alis�s durant le projet.
   */
  public ArrayList getListeArtefacts ()
  {
    return mArtefacts ;
  }

  /**
   * Initialise la liste des artefacts r�alis�s durant le projet.
   * 
   * @param pArtefacts Liste des artefacts r�alis�s durant le projet.
   */
  public void setListeArtefacts (ArrayList pArtefacts)
  {
    mArtefacts = pArtefacts ;
  }

  /**
   * R�cup�re le nombre d'artefacts r�alis�s durant le projet.
   * 
   * @return Nombre d'artefacts r�alis�es durant le projet.
   */
  public int getNbArtefacts ()
  {
    return mArtefacts.size () ;
  }

  /**
   * R�cup�re l'artefact d'indice sp�cifi� r�alis�e durant le projet.
   * 
   * @param pIndice Indice de l'artefact dans la liste.
   * @return Artefact r�alis� durant le projet.
   */
  public MArtefact getArtefact (int pIndice)
  {
    return (MArtefact) mArtefacts.get (pIndice) ;
  }

  /**
   * Ajoute l'artefact sp�cifi� au projet.
   * 
   * @param pArtefact Artefact r�alis� durant le projet.
   */
  public void addArtefact (MArtefact pArtefact)
  {
    mArtefacts.add (pArtefact) ;
  }

  /**
   * Supprime l'artefact sp�cifi� au projet.
   * 
   * @param pArtefact Artefact r�alis� durant le projet.
   */
  public void supprimerArtefact (MArtefact pArtefact)
  {
    mArtefacts.remove (pArtefact) ;
  }

  /**
   * R�cup�re le chef de projet.
   * 
   * @return Chef de projet.
   */
  public MCollaborateur getChefProjet ()
  {
    return mChefProjet ;
  }

  /**
   * Initialise le chef de projet et l'ajoute � la liste des collaborateurs du projet.
   * 
   * @param pChefProjet Chef de projet.
   */
  public void setChefProjet (MCollaborateur pChefProjet)
  {
    mChefProjet = pChefProjet ;
    if (!pChefProjet.getListeProjetsChef ().contains (this))
      pChefProjet.addProjetChef (this) ;
    addCollaborateur (pChefProjet) ;
  }

  /**
   * R�cup�re la liste des collaborateurs sur le projet.
   * 
   * @return Liste des collaborateurs sur le projet.
   */
  public ArrayList getListeCollaborateurs ()
  {
    return mCollaborateurs ;
  }

  /**
   * Initialise la liste des collaborateurs sur le projet.
   * 
   * @param pCollaborateurs Liste des collaborateurs sur le projet.
   */
  public void setListeCollaborateurs (ArrayList pCollaborateurs)
  {
    mCollaborateurs = pCollaborateurs ;
    Iterator it = pCollaborateurs.iterator () ;
    while (it.hasNext ())
    {
      MCollaborateur lCollaborateur = (MCollaborateur) it.next () ;
      if (!lCollaborateur.getListeProjets ().contains (this))
        lCollaborateur.addProjet (this) ;
    }
  }

  /**
   * R�cup�re le nombre de collaborateurs sur le projet.
   * 
   * @return Nombre de collaborateurs sur le projet.
   */
  public int getNbCollaborateurs ()
  {
    return mCollaborateurs.size () ;
  }

  /**
   * R�cup�re le collaborateur d'indice sp�cifi� sur le projet.
   * 
   * @param pIndice Indice du collaborateur dans la liste.
   * @return Collaborateur sur le projet.
   */
  public MCollaborateur getCollaborateur (int pIndice)
  {
    return (MCollaborateur) mCollaborateurs.get (pIndice) ;
  }

  /**
   * Ajoute le collaborateur sp�cifi� au projet.
   * 
   * @param pCollaborateur Collaborateur sur le projet.
   */
  public void addCollaborateur (MCollaborateur pCollaborateur)
  {
    if (!mCollaborateurs.contains (pCollaborateur))
      mCollaborateurs.add (pCollaborateur) ;
    if (!pCollaborateur.getListeProjets ().contains (this))
      pCollaborateur.addProjet (this) ;
  }

  /**
   * R�cup�re la date de d�but pr�vue pour le projet.
   * 
   * @return Date de d�but pr�vue pour le projet.
   */
  public Date getDateDebutPrevue ()
  {
    return mDateDebutPrevue ;
  }

  /**
   * Initialise la date de d�but pr�vue pour le projet.
   * 
   * @param pDateDebutPrevue Date de d�but pr�vue pour le projet.
   */
  public void setDateDebutPrevue (Date pDateDebutPrevue)
  {
    mDateDebutPrevue = pDateDebutPrevue ;
  }

  /**
   * R�cup�re la date de fin pr�vue pour le projet.
   * 
   * @return Date de fin pr�vue pour le projet.
   */
  public Date getDateFinPrevue ()
  {
    return mDateFinPrevue ;
  }

  /**
   * Initialise la date de fin pr�vue pour le projet.
   * 
   * @param pDateFinPrevue Date de fin pr�vue pour le projet.
   */
  public void setDateFinPrevue (Date pDateFinPrevue)
  {
    mDateFinPrevue = pDateFinPrevue ;
  }

  /**
   * R�cup�re mBudget.
   * 
   * @return mBudget.
   */
  public double getBudget ()
  {
    return mBudget ;
  }

  /**
   * Initialise mBudget.
   * 
   * @param budget mBudget.
   */
  public void setBudget (double pBudget)
  {
    mBudget = pBudget ;
  }

  /**
   * R�cup�re la description du projet.
   * 
   * @return Description du projet.
   */
  public String getDescription ()
  {
    return mDescription ;
  }

  /**
   * Initialise la description du projet.
   * 
   * @param pDescription Description du projet.
   */
  public void setDescription (String pDescription)
  {
    mDescription = pDescription ;
  }

  /**
   * R�cup�re la liste des it�rations r�alis�es durant le projet.
   * 
   * @return Liste des it�rations r�alis�es durant le projet.
   */
  public ArrayList getListeIterations ()
  {
    return mIterations ;
  }

  /**
   * Initialise la liste des it�rations r�alis�es durant le projet.
   * 
   * @param pIterations Liste des it�rations r�alis�es durant le projet.
   */
  public void setListeIterations (ArrayList pIterations)
  {
    mIterations = pIterations ;
  }

  /**
   * R�cup�re le nombre d'it�rations r�alis�es durant le projet.
   * 
   * @return Nombre d'it�rations r�alis�es durant le projet.
   */
  public int getNbIterations ()
  {
    return mIterations.size () ;
  }

  /**
   * R�cup�re l'it�ration d'indice sp�cifi� r�alis�e durant le projet.
   * 
   * @param pIndice Indice de l'it�ration dans la liste.
   * @return It�ration r�alis�e durant le projet.
   */
  public MIteration getIteration (int pIndice)
  {
    return (MIteration) mIterations.get (pIndice) ;
  }

  /**
   * Ajoute l'it�ration sp�cifi�e au projet.
   * 
   * @param pTache It�ration r�alis�e durant le projet.
   */
  public void addIteration (MIteration pIteration)
  {
    mIterations.add (pIteration) ;
  }

  /**
   * R�cup�re l'identifiant du projet.
   * 
   * @return Identifie le projet de mani�re unique.
   */
  public int getId ()
  {
    return mId ;
  }

  /**
   * Initialise l'identifiant du projet.
   * 
   * @param pId Identifie le projet de mani�re unique.
   */
  public void setId (int pId)
  {
    mId = pId ;
  }

  /**
   * R�cup�re le nom du projet.
   * 
   * @return Nom du projet.
   */
  public String getNom ()
  {
    return mNom ;
  }

  /**
   * Initialise le nom du projet.
   * 
   * @param pNom Nom du projet.
   */
  public void setNom (String pNom)
  {
    mNom = pNom ;
  }

  /**
   * R�cup�re le processus utilis� par le projet.
   * 
   * @return Processus utilis� par le projet.
   */
  public MProcessus getProcessus ()
  {
    return mProcessus ;
  }

  /**
   * Associe le processus utilis� par le projet.
   * 
   * @param pProcessus Processus utilis� par le projet.
   */
  public void setProcessus (MProcessus pProcessus)
  {
    mProcessus = pProcessus ;
  }

  /**
   * R�cup�re la liste des t�ches impr�vues.
   * 
   * @return mActivitesImprevues la liste des t�ches impr�vues.
   */
  public ArrayList getListeActivitesImprevues ()
  {
    return mActivitesImprevues ;
  }

  /**
   * Initialise la liste des t�ches impr�vues.
   * 
   * @param pActivitesImprevues la liste des t�ches impr�vues.
   */
  public void setListeActivitesImprevues (ArrayList pActivitesImprevues)
  {
    mActivitesImprevues = pActivitesImprevues ;
  }

  /**
   * R�cup�re l'activite impr�vue d'indice sp�cifi� n�cessaire au projet.
   * 
   * @param pIndice Indice de l'activit� imprevue dans la liste.
   * @return Activit� impr�vue n�cessaire au projet.
   */
  public MActiviteImprevue getActiviteImprevue (int pIndice)
  {
    return (MActiviteImprevue) mActivitesImprevues.get (pIndice) ;
  }

  /**
   * Ajoute l'activit� impr�vue sp�cifi� au projet.
   * 
   * @param pActiviteImprevue Activit� impr�vue au projet.
   */
  public void addActiviteImprevue (MActiviteImprevue pActiviteImprevue)
  {
    mActivitesImprevues.add (pActiviteImprevue) ;
  }

  /**
   * Supprime l'activit� impr�vue sp�cifi� au projet.
   * 
   * @param pIndice Indice de l'activit� impr�vue dans la liste.
   */
  public void supprimerActiviteImprevue (int pIndice)
  {
    mActivitesImprevues.remove (pIndice) ;
  }

  /**
   * Supprime l'activit� impr�vue sp�cifi� au projet.
   * 
   * @param pActiviteImprevue Activit� impr�vue au projet.
   */
  public void supprimerActiviteImprevue (MActiviteImprevue pActiviteImprevue)
  {
    mActivitesImprevues.remove (pActiviteImprevue) ;
  }

  /**
   * R�cup�re le nombre d'activit�s impr�vues du projet.
   * 
   * @return le nombre d'activit�s impr�vues du projet.
   */
  public int getNbActivitesImprevues ()
  {
    return mActivitesImprevues.size () ;
  }

  /**
   * R�cup�re la liste des artefacts r�alis�s durant le projet.
   * 
   * @return Liste des artefacts r�alis�s durant le projet.
   */
  public ArrayList getListeArtefactsImprevues ()
  {
    return mArtefactsImprevues ;
  }

  /**
   * Initialise la liste des artefacts r�alis�s durant le projet.
   * 
   * @param pArtefacts Liste des artefacts r�alis�s durant le projet.
   */
  public void setListeArtefactsImprevues (ArrayList pArtefactsImprevues)
  {
    mArtefactsImprevues = pArtefactsImprevues ;
  }

  /**
   * R�cup�re le nombre d'artefacts r�alis�s durant le projet.
   * 
   * @return Nombre d'artefacts r�alis�es durant le projet.
   */
  public int getNbArtefactsImprevues ()
  {
    return mArtefactsImprevues.size () ;
  }

  /**
   * R�cup�re l'artefact d'indice sp�cifi� r�alis�e durant le projet.
   * 
   * @param pIndice Indice de l'artefact dans la liste.
   * @return Artefact r�alis� durant le projet.
   */
  public MArtefactImprevue getArtefactImprevue (int pIndice)
  {
    return (MArtefactImprevue) mArtefactsImprevues.get (pIndice) ;
  }

  /**
   * Ajoute l'artefact sp�cifi� au projet.
   * 
   * @param pArtefact Artefact r�alis� durant le projet.
   */
  public void addArtefactImprevue (MArtefactImprevue pArtefactImprevue)
  {
    mArtefactsImprevues.add (pArtefactImprevue) ;
  }

  /**
   * Supprime l'artefact sp�cifi� au projet.
   * 
   * @param pArtefact Artefact r�alis� durant le projet.
   */
  public void supprimerArtefactImprevue (MArtefactImprevue pArtefactImprevue)
  {
    mArtefactsImprevues.remove (pArtefactImprevue) ;
  }

  /**
   * R�cup�re la liste des indicateurs associ�s au projet.
   * 
   * @return Liste des indicateurs associ�s au projet.
   */
  public ArrayList getListeIndicateurs ()
  {
    return mIndicateurs ;
  }

  /**
   * Initialise la liste des indicateurs associ�s au projet.
   * 
   * @param pArtefacts Liste des indicateurs associ�s au projet.
   */
  public void setListeIndicateurs (ArrayList pIndicateurs)
  {
    mIndicateurs = pIndicateurs ;
  }

  /**
   * R�cup�re le nombre de risques qui doivent �tre g�rer sur le projet.
   * 
   * @return Nombre de risques qui doivent �tre g�rer sur le projet.
   */
  public int getNbRisques ()
  {
    return mRisques.size () ;
  }

  /**
   * R�cup�re le risque d'indice sp�cifi� pour le projet.
   * 
   * @param pIndice Indice du risque dans la liste.
   * @return Risque � g�rer.
   */
  public MRisque getRisque (int pIndice)
  {
    return (MRisque) mRisques.get (pIndice) ;
  }

  /**
   * R�cup�re le risque d'indice sp�cifi� pour le projet.
   * 
   * @param pRisque Risque � ajouter.
   */
  public void addRisque (MRisque pRisque)
  {
    mRisques.add (pRisque) ;
  }

  /**
   * R�cup�re la liste des risques qui doivent �tre g�rer sur le projet.
   * 
   * @return Liste des risques qui doivent �tre g�rer sur le projet.
   */
  public ArrayList getListeRisques ()
  {
    return mRisques ;
  }

  /**
   * Initialise la liste des risques qui doivent �tre g�rer sur le projet.
   * 
   * @param pRisques Liste des risques qui doivent �tre g�rer sur le projet.
   */
  public void setListeRisques (ArrayList pRisques)
  {
    mRisques = pRisques ;
  }

  /**
   * R�cup�re le nombre d'indicateurs sur le projet.
   * 
   * @return Nombre d'indicateurs sur le projet.
   */
  public int getNbIndicateurs ()
  {
    return mIndicateurs.size () ;
  }

  /**
   * R�cup�re l'indicateur d'indice sp�cifi� pour le projet.
   * 
   * @param pIndice Indice de l'indicateur dans la liste.
   * @return Indicateur du projet.
   */
  public MIndicateur getIndicateur (int pIndice)
  {
    return (MIndicateur) mIndicateurs.get (pIndice) ;
  }

  /**
   * Ajoute l'indicateur sp�cifi� au projet.
   * 
   * @param pIndicateur Indicateur � ajouter au projet.
   */
  public void addIndicateur (MIndicateur pIndicateur)
  {
    if (!mIndicateurs.contains (pIndicateur))
      mIndicateurs.add (pIndicateur) ;
    if (pIndicateur.getProjet () != this)
      pIndicateur.setProjet (this) ;
  }

  /**
   * @return Retourne la valeur de l'attribut bilan.
   */
  public String getBilan ()
  {
    return mBilan ;
  }

  /**
   * @param initialse bilan avec pBilan.
   */
  public void setBilan (String pBilan)
  {
    mBilan = pBilan ;
  }

  /**
   * @return Retourne la valeur de l'attribut dateDebutReelle.
   */
  public Date getDateDebutReelle ()
  {
    return mDateDebutReelle ;
  }

  /**
   * @param initialse dateDebutReelle avec pDateDebutReelle.
   */
  public void setDateDebutReelle (Date pDateDebutReelle)
  {
    mDateDebutReelle = pDateDebutReelle ;
  }

  /**
   * @return Retourne la valeur de l'attribut dateFinReelle.
   */
  public Date getDateFinReelle ()
  {
    return mDateFinReelle ;
  }

  /**
   * @param initialse dateFinReelle avec pDateFinReelle.
   */
  public void setDateFinReelle (Date pDateFinReelle)
  {
    mDateFinReelle = pDateFinReelle ;
  }
  
  /**
   * @return Retourne la valeur de l'attribut etat.
   */
  public int getEtat ()
  {
    return mEtat ;
  }
  
  /**
   * @param initialse etat avec pEtat.
   */
  public void setEtat (int pEtat)
  {
    mEtat = pEtat ;
  }
}