unit EcranTribu;

interface

  uses Variables;

  { Affichage de l'�cran et appel des fonctions & proc�dures associ�es }
  procedure afficher(Joueur : TJoueur);



implementation

  uses GestionEcran, OptnAffichage, EcranAccueil, EcranElevage, EcranMilitaire, EcranCombat;



  { Actions effectu�es lors d'un passage au tour suivant }
  procedure tourSuivant(Joueur : TJoueur);
  begin
    // On passe au jour suivant
    setTribu_numJour(Joueur, getTribu(Joueur).numJour + 1);

    // Augmentation du savoir acquis (croissance)
    setElevage_savoirAcquis(Joueur, getElevage(Joueur).savoirAcquis + getElevage(Joueur).savoirJour);

    // Les points de recrutement sont recharg�s
    setTribu_ptsRecrutement(Joueur, getTribu(Joueur).ptsRecrutementJour);

    // Si une construction est en cours, on augmente le total d'�quations r�solues (travail)
    if getElevage(Joueur).construction = True then setElevage_equationsResolues(Joueur,  getElevage(Joueur).equationsResolues
                                                                                       + getElevage(Joueur).equationsJour);

    // V�rification des �tats d'avancement de la croissance et de la construction
    majConstruction(Joueur);
    majCroissance(Joueur);

    // Si l'arch�type choisi est 'Analyste', le bonheur reste constant
    if getTribu(Joueur).archetype = 'Analyste' then setElevage_bonheur(Joueur, 1);


    { Simulation pour d�terminer si le joueur subit un assaut }
    Randomize;

      // Une Tribu Probabiliste a moins de chance de se faire attaquer par surprise
      if getTribu(Joueur).archetype = 'Probabiliste' then if Random(100) = Random(100) then assautAleatoire(Joueur)
      else else if Random(40) = Random(40) then assautAleatoire(Joueur);


    // S'il s'agit d'une partie multijoueur, c'est au tour de l'autre joueur de jouer
    if getMultijoueur() = True then
    begin
      if Joueur = Joueur1 then afficher(Joueur2)
      else if Joueur = Joueur2 then afficher(Joueur1);
    end

    else afficher(Joueur1);

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
      EcranElevage.afficher(Joueur);
    end;

    if (choix = '2') then
    begin
      EcranMilitaire.afficher(Joueur);
    end;

    if (choix = '9') then tourSuivant(Joueur);

    if (choix = '0') then EcranAccueil.verifQuitter(Joueur)

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
    afficherEnTete(Joueur);
    dessinerCadreXY(0,6, 119,28, simple, 15,0);
    afficherTitre('ECRAN DE GESTION DE LA TRIBU', 6);

    { Corps de l'�cran }
    deplacerCurseurXY(3,10);
    write('Liste des �levages :');
    deplacerCurseurXY(3,11);
    write('��������������������');
    afficherElevage(Joueur, 4,13);


    { Choix disponibles }

    afficherAction(3,22, '1', 'G�rer l''�levage : ' + getElevage(Joueur).nom, 'vert');
    afficherAction(3,23, '2', 'Gestion militaire et diplomatique', 'vert');

    afficherAction(3,25, '9', 'Fin du tour', 'vert');
    afficherAction(3,26, '0', 'Quitter la partie', 'jaune');


    { Partie inf�rieure de l'�cran }
    afficherMessage();
    afficherCadreAction();

    choisir(Joueur);
  end;

end.
