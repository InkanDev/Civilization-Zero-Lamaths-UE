unit EcranElevage;

interface

  uses Variables;

  { Affichage de l'�cran et appel des fonctions & proc�dures associ�es }
  procedure afficher(Joueur : TJoueur);

  { V�rifie l'�tat d'avancement d'une construction
    et met � jour les variables une fois celle-ci termin�e. }
  procedure majConstruction(Joueur : TJoueur);

  { V�rifie l'�tat d'avancement de la croissance de l'�levage
    et met � jour les variables une fois celle-ci achev�e }
  procedure majCroissance(Joueur : TJoueur);



implementation

  uses GestionEcran, OptnAffichage, EcranTribu;


  { Lance la construction d'un b�timent (Universite, CDR, Laboratoire, Enclos) }
  procedure construire(Joueur : TJoueur ; nomBatiment : String);

  var
    sommeNiveau : Integer; // Somme du niveau de chaque b�timent

  begin
    { Si aucune construction n'est en cours }
    if getElevage(Joueur).construction = False then
    begin

      // Calcul de la somme du niveau de chaque b�timent
      sommeNiveau := getUniversite(Joueur).niveau
                   + getCDR(Joueur).niveau
                   + getLaboratoire(Joueur).niveau
                   + getEnclos(Joueur).niveau
                   + getBibliotheque(Joueur).niveau
                   + getArchives(Joueur).niveau;

      { Si la somme du niveau de chaque b�timent est inf�rieure � la population }
      if (sommeNiveau < getElevage(Joueur).population) then
      begin

        // Universit�
        if nomBatiment = 'Universite' then
        begin
          { Si le b�timent n'est pas d�j� au niveau maximum }
          if (getUniversite(Joueur).niveau < getTribu(Joueur).niveauMax) then
          begin
              setElevage_construction(Joueur, True);
              setUniversite_construction(Joueur, True);
              setMessage('Construction lanc�e');
          end
          else setMessage('Ce b�timent est d�j� au niveau maximum');
        end;

        // Centre de recherches
        if nomBatiment = 'CDR' then
        begin
          { Si le b�timent n'est pas d�j� au niveau maximum }
          if (getCDR(Joueur).niveau < getTribu(Joueur).niveauMax) then
          begin
              setElevage_construction(Joueur, True);
              setCDR_construction(Joueur, True);
              setMessage('Construction lanc�e');
          end
          else setMessage('Ce b�timent est d�j� au niveau maximum');
        end;

        // Laboratoire
        if nomBatiment = 'Laboratoire' then
        begin
          { Si le b�timent n'est pas d�j� au niveau maximum }
          if (getLaboratoire(Joueur).niveau < getTribu(Joueur).niveauMax) then
          begin
              setElevage_construction(Joueur, True);
              setLaboratoire_construction(Joueur, True);
              setMessage('Construction lanc�e');
          end
          else setMessage('Ce b�timent est d�j� au niveau maximum');
        end;

        // Enclos
        if nomBatiment = 'Enclos' then
        begin
          { Si le b�timent n'est pas d�j� au niveau maximum }
          if (getEnclos(Joueur).niveau < getTribu(Joueur).niveauMax) then
          begin
              setElevage_construction(Joueur, True);
              setEnclos_construction(Joueur, True);
              setMessage('Construction lanc�e');
          end
          else setMessage('Ce b�timent est d�j� au niveau maximum');
        end;

        // Biblioth�que
        if nomBatiment = 'Biblioth�que' then
        begin
          { Si le b�timent n'est pas d�j� au niveau maximum }
          if (getBibliotheque(Joueur).niveau < getTribu(Joueur).niveauMax) then
          begin
              setElevage_construction(Joueur, True);
              setBibliotheque_construction(Joueur, True);
              setMessage('Construction lanc�e');
          end
          else setMessage('Ce b�timent est d�j� au niveau maximum');
        end;

        // Archives
        if nomBatiment = 'Archives' then
        begin
          { Si le b�timent n'est pas d�j� au niveau maximum }
          if (getArchives(Joueur).niveau < getTribu(Joueur).niveauMax) then
          begin
              setElevage_construction(Joueur, True);
              setArchives_construction(Joueur, True);
              setMessage('Construction lanc�e');
          end
          else setMessage('Ce b�timent est d�j� au niveau maximum');
        end;


      end
      else setMessage('Population insuffisante');

    end
    else setMessage('Une construction est d�j� en cours');

  end;

  { Remet � 0 les variables li�es � la construction }
  procedure reinitConstruction(Joueur : TJoueur);
  begin
    setElevage_construction(Joueur, False);
    setElevage_equationsResolues(Joueur, 0);
    setUniversite_construction(Joueur, False);
    setCDR_construction(Joueur, False);
    setLaboratoire_construction(Joueur, False);
    setEnclos_construction(Joueur, False);
    setBibliotheque_construction(Joueur, False);
  end;

  { V�rifie l'�tat d'avancement d'une construction
    et met � jour les variables une fois celle-ci termin�e. }
  procedure majConstruction(Joueur : TJoueur);
  begin
    { Si une construction (encore ind�termin�e) est en cours }
    if getElevage(Joueur).construction = True then
    begin

      { On d�termine d'abord quel b�timent est en construction. Ensuite on regarde si le travail accumul� est
        suffisant pour passer au niveau sup�rieur. Dans le cas d'un passage au niveau sup�rieur, on met � jour
        le niveau du b�timent et les bonus li�s, et on r�initialise l'�tat de construction. }


      { Si la construction de l'UNIVERSITE est en cours }
      if getUniversite(Joueur).construction = True then
      begin
        { Si les �quations r�solues sont suffisantes pour passer au niveau suivant }
        if getElevage(Joueur).equationsResolues >= getUniversite(Joueur).PALIERS[getUniversite(Joueur).niveau+1] then
        begin
          setUniversite_niveau(Joueur, getUniversite(Joueur).niveau + 1 );
          setElevage_savoirJourAbsolu(Joueur, getElevage(Joueur).savoirJourAbsolu
                                            + getUniversite(Joueur).BONUS[getUniversite(Joueur).niveau] );
          setElevage_savoirJour(Joueur, round( getElevage(Joueur).savoirJourAbsolu * getElevage(Joueur).facteurBonheur ));
          reinitConstruction(Joueur);
        end;
      end;


      { Si la construction du LABORATOIRE est en cours }
      if getLaboratoire(Joueur).construction = True then
      begin
        { Si les �quations r�solues sont suffisantes pour passer au niveau suivant }
        if getElevage(Joueur).equationsResolues >= getLaboratoire(Joueur).PALIERS[getLaboratoire(Joueur).niveau+1] then
        begin
          setLaboratoire_niveau(Joueur, getLaboratoire(Joueur).niveau + 1 );
          setElevage_equationsJour(Joueur, round(( getElevage(Joueur).population*10
                                          + getLaboratoire(Joueur).BONUS[getLaboratoire(Joueur).niveau]
                                          + getCDR(Joueur).BONUS[getCDR(Joueur).niveau] )
                                          * getElevage(Joueur).facteurBonheur) );
          reinitConstruction(Joueur);
        end;
      end;


      { Si la construction du CDR est en cours }
      if getCDR(Joueur).construction = True then
      begin
        { Si les �quations r�solues sont suffisantes pour passer au niveau suivant }
        if getElevage(Joueur).equationsResolues >= getCDR(Joueur).PALIERS[getCDR(Joueur).niveau+1] then
        begin
          setCDR_niveau(Joueur, getCDR(Joueur).niveau + 1 );
          setElevage_equationsJour(Joueur, round(( getElevage(Joueur).population*10
                                          + getLaboratoire(Joueur).BONUS[getLaboratoire(Joueur).niveau]
                                          + getCDR(Joueur).BONUS[getCDR(Joueur).niveau] )
                                          * getElevage(Joueur).facteurBonheur) );
          reinitConstruction(Joueur);
        end;
      end;

      { Si la construction de l'ENCLOS est en cours }
      if getEnclos(Joueur).construction = True then
      begin
        { Si les �quations r�solues sont suffisantes pour passer au niveau suivant }
        if getElevage(Joueur).equationsResolues >= getEnclos(Joueur).PALIERS[getEnclos(Joueur).niveau+1] then
        begin
          setEnclos_niveau(Joueur, getEnclos(Joueur).niveau + 1 );
          setTribu_ptsRecrutementJour(Joueur, getEnclos(Joueur).BONUS[getEnclos(Joueur).niveau]);
          reinitConstruction(Joueur);
        end;
      end;

      { Si la construction de la BIBLIOTH�QUE est en cours }
      if getBibliotheque(Joueur).construction = True then
      begin
        { Si les �quations r�solues sont suffisantes pour passer au niveau suivant }
        if getElevage(Joueur).equationsResolues >= getBibliotheque(Joueur).PALIERS[getBibliotheque(Joueur).niveau+1] then
        begin
          setBibliotheque_niveau(Joueur, getBibliotheque(Joueur).niveau+1);

          // L'arch�type ANALYSTE b�n�ficie d'un bonheur constant (100%)
          if getTribu(Joueur).archetype <> 'G�om�tre' then
          begin
            setElevage_bonheur(Joueur, getBibliotheque(Joueur).BONUS[getBibliotheque(Joueur).niveau]);
            setElevage_facteurBonheur(Joueur, 1 - getElevage(Joueur).population/10 + getElevage(Joueur).bonheur/10);
          end;

          setElevage_savoirJourAbsolu(Joueur, getElevage(Joueur).savoirJourAbsolu
                                            + getUniversite(Joueur).BONUS[getUniversite(Joueur).niveau] );
          setElevage_savoirJour(Joueur, round( getElevage(Joueur).savoirJourAbsolu * getElevage(Joueur).facteurBonheur ));

          setElevage_equationsJour(Joueur, round(( getElevage(Joueur).population*10
                                         + getLaboratoire(Joueur).BONUS[getLaboratoire(Joueur).niveau]
                                         + getCDR(Joueur).BONUS[getCDR(Joueur).niveau] )
                                         * getElevage(Joueur).facteurBonheur) );

          reinitConstruction(Joueur);
        end;
      end;

      { Si la construction des ARCHIVES est en cours }
      if getArchives(Joueur).construction = True then
      begin
        { Si les �quations r�solues sont suffisantes pour passer au niveau suivant }
        if getElevage(Joueur).equationsResolues >= getArchives(Joueur).PALIERS[getArchives(Joueur).niveau+1] then
        begin
          setArchives_niveau(Joueur, getArchives(Joueur).niveau+1);
          setTribu_limDefaites(Joueur, getArchives(Joueur).BONUS[getArchives(Joueur).niveau]);
          reinitConstruction(Joueur);
        end;
      end;

    end;

  end;

  { V�rifie l'�tat d'avancement de la croissance de l'�levage
    et met � jour les variables une fois celle-ci achev�e }
  procedure majCroissance(Joueur : TJoueur);
  begin

    { Calcul du savoir/j � partir du savoir/j absolu }
    setElevage_savoirJour(Joueur, round( ( getElevage(Joueur).savoirJourAbsolu
                                         - getElevage(Joueur).population*10 )
                                         * getElevage(Joueur).facteurBonheur ) );

    { Si le savoir acquis permet de cro�tre en population }
    if getElevage(Joueur).savoirAcquis >= getElevage(Joueur).seuilCroissance then
    begin
      setElevage_savoirAcquis(Joueur, 0);
      setElevage_population(Joueur, getElevage(Joueur).population + 1);

      // L'arch�type ANALYSTE b�n�ficie d'un bonheur constant (100%)
      if getTribu(Joueur).archetype <> 'G�om�tre' then
      begin
        setElevage_facteurBonheur(Joueur, 1 - getElevage(Joueur).population/10 + getElevage(Joueur).bonheur/10);
      end;


      setElevage_savoirJour(Joueur, round( ( getElevage(Joueur).savoirJourAbsolu
                                           - getElevage(Joueur).population*10 )
                                           * getElevage(Joueur).facteurBonheur ) );

      setElevage_equationsJour(Joueur, round( ( getElevage(Joueur).population*10
                                              + getLaboratoire(Joueur).BONUS[getLaboratoire(Joueur).niveau]
                                              + getCDR(Joueur).BONUS[getCDR(Joueur).niveau] )
                                              * getElevage(Joueur).facteurBonheur ) );

      setElevage_seuilCroissance(Joueur, getElevage(Joueur).population * getElevage(Joueur).facteurCroissance);
    end;

    { Permet de passer directement � une croissance nulle ; �vite la division par 0 dans le calcul suivant }
    if getElevage(Joueur).savoirJour = 0 then setElevage_nbJourAvCroissance(Joueur, 0)
    else setElevage_nbJourAvCroissance(Joueur, ( getElevage(Joueur).seuilCroissance
                                               - getElevage(Joueur).savoirAcquis
                                               + ( getElevage(Joueur).seuilCroissance mod getElevage(Joueur).savoirJour))
                                                 div getElevage(Joueur).savoirJour )
  end;


  { Affiche la liste des b�timents construits aux coordonn�es (x,y) }
  procedure afficherBatimentsConstruits(Joueur : TJoueur ; x,y : Integer);
  begin
    deplacerCurseurXY(x,y);
    write('B�timents construits :');
    deplacerCurseurXY(x,y+1);
    write('����������������������');

    { On regarde simplement quel b�timent est construit (niveau > 0)
      et on affiche son nom et son niveau. }

    // Universit�
    if getUniversite(Joueur).niveau > 0 then
    begin
      deplacerCurseurXY(x+2,y+2);
      write('- Universit� (niv ', getUniversite(Joueur).niveau,')');
    end;

    // Centre de recherches
    if getCDR(Joueur).niveau > 0 then
    begin
      deplacerCurseurXY(x+2,y+3);
      write('- Centre de recherches (niv ', getCDR(Joueur).niveau,')');
    end;

    // Laboratoire
    if getLaboratoire(Joueur).niveau > 0 then
    begin
      deplacerCurseurXY(x+2,y+4);
      write('- Laboratoire (niv ', getLaboratoire(Joueur).niveau,')');
    end;

    // Enclos
    if getEnclos(Joueur).niveau > 0 then
    begin
      deplacerCurseurXY(x+2,y+5);
      write('- Enclos (niv ', getEnclos(Joueur).niveau,')');
    end;

    // Biblioth�que
    if getBibliotheque(Joueur).niveau > 0 then
    begin
      deplacerCurseurXY(x+2,y+6);
      write('- Biblioth�que (niv ', getBibliotheque(Joueur).niveau,')');
    end;

    // Archives
    if getArchives(Joueur).niveau > 0 then
    begin
      deplacerCurseurXY(x+2,y+7);
      write('- Archives (niv ', getArchives(Joueur).niveau,')');
    end;

  end;

  { Affiche la liste des bonus accumul�s aux coordonn�es (x,y) }
  procedure afficherBonus(Joueur : TJoueur ; x,y : Integer);

  begin
    deplacerCurseurXY(x,y);
    write('Bonus accumul�s :');
    deplacerCurseurXY(x,y+1);
    write('�����������������');

    { Chaque bonus s'affiche en gris s'il est nul ou False
      et en vert s'il est positif ou True. }

    // Savoir/j
    deplacerCurseurXY(x+2,y+2);
    write('Savoir/j : ');
    if getUniversite(Joueur).BONUS[getUniversite(Joueur).niveau] = 0 then couleurTexte(8)
    else couleurTexte(10);
    write('+ ', getUniversite(Joueur).BONUS[getUniversite(Joueur).niveau]);
    couleurTexte(15);

    // Equations/j
    deplacerCurseurXY(x+2,y+3);
    write('�quations/j : ');
    if getCDR(Joueur).BONUS[getCDR(Joueur).niveau] + getLaboratoire(Joueur).BONUS[getLaboratoire(Joueur).niveau] = 0 then couleurTexte(8)
    else couleurTexte(10);
    write('+ ', getCDR(Joueur).BONUS[getCDR(Joueur).niveau] + getLaboratoire(Joueur).BONUS[getLaboratoire(Joueur).niveau]);
    couleurTexte(15);

    // Points de bonheur
    deplacerCurseurXY(x+2,y+4);
    write('Bonheur : ');
    if getBibliotheque(Joueur).BONUS[getBibliotheque(Joueur).niveau] = 0 then couleurTexte(8)
    else couleurTexte(10);
    write(getBibliotheque(Joueur).BONUS[getBibliotheque(Joueur).niveau], ' points');
    couleurTexte(15);

    // Points de recrutement
    deplacerCurseurXY(x+2,y+5);
    write('Recrutement : ');
    if getEnclos(Joueur).BONUS[getEnclos(Joueur).niveau] = 0 then couleurTexte(8)
    else couleurTexte(10);
    write(getEnclos(Joueur).BONUS[getEnclos(Joueur).niveau], ' points');
    couleurTexte(15);

    // Lamas
    deplacerCurseurXY(x+2,y+6);
    write('Lamas : ');
    if getEnclos(Joueur).niveau > 0 then
    begin
      couleurTexte(10);
      write('D�verouill�s');
    end
    else
    begin
      couleurtexte(8);
      write('Verouill�s');
    end;
    couleurtexte(15);

    // Alpagas
    deplacerCurseurXY(x+2,y+7);
    write('Alpagas : ');
    if getCDR(Joueur).niveau >= 1 then
    begin
      couleurTexte(10);
      write('D�verouill�s');
    end
    else
    begin
      couleurtexte(8);
      write('Verouill�s');
    end;
    couleurtexte(15);

    // Guanacos
    deplacerCurseurXY(x+2,y+8);
    write('Guanacos : ');
    if getCDR(Joueur).niveau >= 2 then
    begin
      couleurTexte(10);
      write('D�verouill�s');
    end
    else
    begin
      couleurtexte(8);
      write('Verouill�s');
    end;
    couleurtexte(15);


  end;


  { R�cup�re le choix du joueur et d�termine l'action � effectuer }
  procedure choisir(Joueur : TJoueur);

  var
    choix : String; // Valeur entr�e par la joueur

  begin
    { D�place le curseur dans le cadre "Action" }
    deplacerCurseurXY(114,26);
    readln(choix);

    { Liste des choix disponibles }

    if (choix = '1') then
    begin
      construire(Joueur, 'Universite');
      majConstruction(Joueur);
      afficher(Joueur);
    end;

    if (choix = '2') then
    begin
      construire(Joueur, 'CDR');
      majConstruction(Joueur);
      afficher(Joueur);
    end;

    if (choix = '3') then
    begin
      construire(Joueur, 'Laboratoire');
      majConstruction(Joueur);
      afficher(Joueur);
    end;

    if (choix = '4') then
    begin
      construire(Joueur, 'Enclos');
      majConstruction(Joueur);
      afficher(Joueur);
    end;

    if (choix = '5') then
    begin
      construire(Joueur, 'Biblioth�que');
      majConstruction(Joueur);
      afficher(Joueur);
    end;

    if (choix = '6') then
    begin
      construire(Joueur, 'Archives');
      majConstruction(Joueur);
      afficher(Joueur);
    end;

    if (choix = '0') then
    begin
      EcranTribu.afficher(Joueur);
    end

    { Valeur saisie invalide }
    else
    begin
      setMessage('Action non reconnue');
      afficher(Joueur);
    end;
  end;

  { Affichage de l'�cran et appel des fonctions & proc�dures associ�es }
  procedure afficher(Joueur : TJoueur);

  begin
    effacerEcran();

    { Partie sup�rieure de l'�cran }
    afficherEntete(Joueur);
    dessinerCadreXY(0,6, 119,28, simple, 15,0);
    afficherTitre('ECRAN DE GESTION DE : ' + getElevage(Joueur).nom, 6);

    { Corps de l'�cran }
    afficherElevage(Joueur, 4,10);
    afficherBatimentsConstruits(Joueur, 46,15);
    afficherBonus(Joueur, 84,15);

    { Choix disponibles }

    if getElevage(Joueur).construction = True then
    begin
      afficherAction(3,19, '1', 'Construire : Universit�', 'rouge');
      afficherAction(3,20, '2', 'Construire : Centre de recherches', 'rouge');
      afficherAction(3,21, '3', 'Construire : Laboratoire', 'rouge');
      afficherAction(3,22, '4', 'Construire : Enclos', 'rouge');
      afficherAction(3,23, '5', 'Construire : Biblioth�que', 'rouge');
      afficherAction(3,24, '6', 'Construire : Archives', 'rouge');
    end

    else
    begin
      if ( getUniversite(Joueur).niveau
         + getCDR(Joueur).niveau
         + getLaboratoire(Joueur).niveau
         + getEnclos(Joueur).niveau
         + getBibliotheque(Joueur).niveau
         + getArchives(Joueur).niveau ) < getElevage(Joueur).population then
      begin

        if (getUniversite(Joueur).niveau < getTribu(Joueur).niveauMax) then
        afficherAction(3,19, '1', 'Construire : Universit�', 'vert')
        else afficherAction(3,19, '1', 'Construire : Universit�', 'rouge');

        if (getCDR(Joueur).niveau < getTribu(Joueur).niveauMax) then
        afficherAction(3,20, '2', 'Construire : Centre de recherches', 'vert')
        else afficherAction(3,20, '2', 'Construire : Centre de recherches', 'rouge');

        if (getLaboratoire(Joueur).niveau < getTribu(Joueur).niveauMax) then
        afficherAction(3,21, '3', 'Construire : Laboratoire', 'vert')
        else afficherAction(3,21, '3', 'Construire : Laboratoire', 'rouge');

        if (getEnclos(Joueur).niveau < getTribu(Joueur).niveauMax) then
        afficherAction(3,22, '4', 'Construire : Enclos', 'vert')
        else afficherAction(3,22, '4', 'Construire : Enclos', 'rouge');

        if (getBibliotheque(Joueur).niveau < getTribu(Joueur).niveauMax) then
        afficherAction(3,23, '5', 'Construire : Biblioth�que', 'vert')
        else afficherAction(3,23, '5', 'Construire : Biblioth�que', 'rouge');

        if (getArchives(Joueur).niveau < getTribu(Joueur).niveauMax) then
        afficherAction(3,24, '6', 'Construire : Archives', 'vert')
        else afficherAction(3,24, '6', 'Construire : Archives', 'rouge');

      end;
    end;

    afficherAction(3,26, '0', 'Retour au menu', 'jaune');


    { Partie inf�rieure de l'�cran }
    afficherMessage();
    afficherCadreAction();

    choisir(Joueur);
  end;

end.
