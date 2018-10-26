unit EcranAccueil;

interface

  uses Variables;

  {Affiche l'écran d'accueil du jeu}
  procedure afficher;

  { Affiche un écran de vérification Quitter ? Oui/Non }
  procedure verifQuitter(Joueur : TJoueur);



implementation

  uses GestionEcran, OptnAffichage, EcranGrimoire, EcranTribu;

  { Déclaration 'forward' nécessaire pour indiquer qu'on appelle la procédure
    suivante avant sa déclaration dans le programme. }
  procedure choisirDifficulte(Joueur : TJoueur); forward;

  { Affiche le numéro du joueur dans le coin haut gauche de l'écran }
  procedure afficherJoueur(Joueur : TJoueur);
  begin

    dessinerCadreXY(2,1, 27,3, double, 15,0);
    deplacerCurseurXY(5,2);
    write('Sélection : ');

    if Joueur = Joueur1 then
    begin
      couleurTexte(13);
      write('Joueur 1');
    end

    else if Joueur = Joueur2 then
    begin
      couleurTexte(14);
      write('Joueur 2');
    end;

    couleurTexte(15);
  end;

  { Propose au joueur de nommer sa Tribu et son Elevage principal }
  procedure creerTribu(Joueur : TJoueur);

  var
    nomTribu, nomElevage : String; // Noms saisis par le joueur

  begin
    { Création de la Tribu }
    effacerEcran();
    if getMultijoueur() = True then afficherJoueur(Joueur);
    afficherTitre('QUEL EST LE NOM DE VOTRE TRIBU ?', 10);
    deplacerCurseurXY(48,14);
    write('Nom :');
    deplacerCurseurXY(55,14);
    readln(nomTribu);

    { Création de l'Elevage }
    effacerEcran();
    if getMultijoueur() = True then afficherJoueur(Joueur);
    afficherTitre('NOM DE SON ELEVAGE PRINCIPAL', 10);
    deplacerCurseurXY(48,14);
    write('Nom :');
    deplacerCurseurXY(55,14);
    readln(nomElevage);

    { Affectation des noms saisis }
    setTribu_nom(Joueur, nomTribu);
    setElevage_nom(Joueur, nomElevage);


    if getMultijoueur = True then
    begin
      if Joueur = Joueur1 then choisirDifficulte(Joueur2)
      else if Joueur = Joueur2 then EcranTribu.afficher(Joueur1);
    end;

    { Début de la partie }
    EcranTribu.afficher(Joueur);
  end;

  { Propose au joueur de choisir l'archétype de sa Tribu }
  procedure choisirArchetype(Joueur : TJoueur);

  var
    choix : String; // Valeur entrée par la joueur

  begin
    effacerEcran();

    { Corps de l'écran }
    if getMultijoueur() = True then afficherJoueur(Joueur);
    afficherTitre('CHOIX DE L''ARCHÉTYPE DE VOTRE TRIBU', 4);

    // Tribu Algébriste
    afficherAction(40,8, '1', 'TRIBU ALGÉBRISTE', 'vert');
    deplacerCurseurXY(44,9);
    couleurTexte(8);
    write('Aucun modificateur');
    couleurTexte(15);

    // Tribu Analyste
    afficherAction(40,12, '2', 'TRIBU GÉOMÈTRE', 'vert');
    deplacerCurseurXY(44,13);
    couleurTexte(8);
    write('Le bonheur de votre population reste constant');
    couleurTexte(15);

    // Tribu Borélienne
    afficherAction(40,16, '3', 'TRIBU BORÉLIENNE', 'vert');
    deplacerCurseurXY(44,17);
    couleurTexte(8);
    write('L''armée de départ est renforcée');
    couleurTexte(15);

    // Tribu Géomètre
    afficherAction(40,20, '4', 'TRIBU ARCHIVISTE', 'vert');
    deplacerCurseurXY(44,21);
    couleurTexte(8);
    write('Votre Tribu peut encaisser davantage de défaites');
    couleurTexte(15);

    // Tribu Probabiliste
    afficherAction(40,24, '5', 'TRIBU PROBABILISTE', 'vert');

    deplacerCurseurXY(44,25);
    couleurTexte(8);
    write('Probabilité de se faire attaquer réduite');
    couleurTexte(15);


    { Partie inférieure de l'écran }
    afficherAction(8,26, '0', 'Retour', 'jaune');
    afficherMessage();
    afficherCadreAction();

    { Déplace le curseur dans le cadre "Action" }
    deplacerCurseurXy(114,26);
    readln(choix);

    { Liste des choix disponibles }
    if (choix = '0') then choisirDifficulte(Joueur);
    if (choix = '1') then setTribu_archetype(Joueur, 'Algébriste');
    if (choix = '2') then setTribu_archetype(Joueur, 'Géomètre');
    if (choix = '3') then setTribu_archetype(Joueur, 'Borélienne');
    if (choix = '4') then setTribu_archetype(Joueur, 'Archiviste');
    if (choix = '5') then setTribu_archetype(Joueur, 'Probabiliste');

    if (choix = '1') OR (choix = '2') OR (choix = '3') OR (choix = '4') OR (choix = '5') then
    begin
      appliquerArchetype(Joueur);
      creerTribu(Joueur);
    end

    { Valeur saisie invalide }
    else
    begin
      setMessage('Vous devez choisir un archétype');
      choisirArchetype(Joueur);
    end;
  end;

  { Propose au joueur de choisir la difficulté du jeu }
  procedure choisirDifficulte(Joueur : TJoueur);

  var
    choix : String; // Valeur entrée par la joueur

  begin
    effacerEcran();

    { Corps de l'écran }
    if getMultijoueur() = True then afficherJoueur(Joueur);
    afficherTitre('CHOIX DE LA DIFFICULTÉ DU JEU', 4);

    // Difficulté Linéaire
    afficherAction(44,10, '1', 'LINÉAIRE', 'vert');
    deplacerCurseurXY(48,11);
    couleurTexte(8);
    write('Perdre devient le challenge');
    couleurTexte(15);

    // Difficulté Appliqué
    afficherAction(44,15, '2', 'APPLIQUÉ', 'vert');
    deplacerCurseurXY(48,16);
    couleurTexte(8);
    write('Une expérience de jeu classique');
    couleurTexte(15);

    // Difficulté Quantique
    afficherAction(44,20, '3', 'QUANTIQUE', 'vert');
    deplacerCurseurXY(48,21);
    couleurTexte(8);
    write('Ça vous intrique ?');
    couleurTexte(15);


    { Partie inférieure de l'écran }
    afficherAction(8,26, '0', 'Retour', 'jaune');
    afficherMessage();
    afficherCadreAction();

    { Déplace le curseur dans le cadre "Action" }
    deplacerCurseurXy(114,26);
    readln(choix);

    { Liste des choix disponibles }
    if (choix = '0') then afficher();
    if (choix = '1') then setTribu_difficulte(Joueur, 'Linéaire');
    if (choix = '2') then setTribu_difficulte(Joueur, 'Appliqué');
    if (choix = '3') then setTribu_difficulte(Joueur, 'Quantique');

    if (choix = '1') OR (choix = '2') OR (choix = '3') then
    begin
      appliquerDifficulte(Joueur);
      choisirArchetype(Joueur)
    end

    { Valeur saisie invalide }
    else
    begin
      setMessage('Vous devez choisir une difficulté');
      choisirDifficulte(Joueur);
    end;
  end;



  { Récupère le choix du joueur et détermine l'action à effectuer }
  procedure choisir;

  var
    choix : String; // Valeur entrée par la joueur

  begin
    { Déplace le curseur dans le cadre "Action" }
    deplacerCurseurXY(114,26);
    readln(choix);

    { Liste des choix disponibles }

    if (choix = '1') then
    begin
      choisirDifficulte(Joueur1);
    end;

    if (choix = '2') then
    begin
      setMultijoueur(True);
      choisirDifficulte(Joueur1);
    end;

    if (choix = '3') then
    begin
      EcranGrimoire.afficherGrimoire();
    end;

    if (choix = '0') then halt

    { Valeur saisie invalide }
    else
    begin
      setMessage('Action non reconnue');
      afficher();
    end;
  end;

  { Affichage de l'écran et appel des fonctions & procédures associées }
  procedure afficher;
  begin
    effacerEcran();

    // (ré)Initialisation des deux Joueurs
    initJoueur(Joueur1);
    initJoueur(Joueur2);
    // Réinitialisation du booléen Multijoueur
    setMultijoueur(False);


    { TITRE }
    couleurTexte(15);
    deplacerCurseurXY(13,1);
    write('─────────────────────────────────────────────────────────────────────────────────────────────');
    deplacerCurseurXY(13,3);
    write(' ██████╗██╗██╗   ██╗██╗██╗     ██╗███████╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗     ██████╗');
    deplacerCurseurXY(13,4);
    write('██╔════╝██║██║   ██║██║██║     ██║╚══███╔╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║    ██╔═████╗');
    deplacerCurseurXY(13,5);
    write('██║     ██║██║   ██║██║██║     ██║  ███╔╝ ███████║   ██║   ██║██║   ██║██╔██╗ ██║    ██║██╔██║');
    deplacerCurseurXY(13,6);
    write('██║     ██║╚██╗ ██╔╝██║██║     ██║ ███╔╝  ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║    ████╔╝██║');
    deplacerCurseurXY(13,7);
    write('╚██████╗██║ ╚████╔╝ ██║███████╗██║███████╗██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║    ╚██████╔╝');
    deplacerCurseurXY(13,8);
    write(' ╚═════╝╚═╝  ╚═══╝  ╚═╝╚══════╝╚═╝╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝     ╚═════╝ ');

    deplacerCurseurXY(13,9);
    write('                           ╦  ╔═╗╔╦╗╔═╗╔╦╗╦ ╦╔═╗  ╔═╗╔╦╗╦╔╦╗╦╔═╗╔╗╔');
    deplacerCurseurXY(13,10);
    write('────────────────────────── ║  ╠═╣║║║╠═╣ ║ ╠═╣╚═╗  ║╣  ║║║ ║ ║║ ║║║║ ──────────────────────────');
    deplacerCurseurXY(13,11);
    write('                           ╩═╝╩ ╩╩ ╩╩ ╩ ╩ ╩ ╩╚═╝  ╚═╝═╩╝╩ ╩ ╩╚═╝╝╚╝');
    deplacerCurseurXY(13,12);


    { INTRODUCTION }
    deplacerCurseurXY(4,14);
    write('Bienvenue dans Civilization 0 — Lamaths Edition');

    couleurTexte(8);
    deplacerCurseurXY(4,16);
    write('À la tête d''une Tribu de Lamas mathématiciens, vous menez une guerre sans merci contre les hordes littéraires');
    deplacerCurseurXY(4,17);
    write('qui menacent vos recherches. Affirmez votre supériorité ; résolvez des équations pour améliorer votre élevage');
    deplacerCurseurXY(4,18);
    write('et étalez votre savoir afin de conquérir les pâturages tombés entre les sabots de l''ennemi.');

    deplacerCurseurXY(4,20);
    write('Que les axiomes vous guident !');
    couleurTexte(15);


    { CHOIX }
    afficherAction(4,23, '1', 'Débuter une nouvelle partie (Solo)', 'vert');
    afficherAction(4,24, '2', 'Mode 2 Joueurs', 'vert');
    afficherAction(4,26, '3', 'Consulter le Grimoire', 'vert');
    afficherAction(4,27, '0', 'Quitter le jeu', 'jaune');


    afficherMessage();
    afficherCadreAction();
    choisir();
  end;

  { Affiche un écran de vérification Quitter ? Oui/Non }
  procedure verifQuitter(Joueur : TJoueur);

  var
    choix : String; // Valeur entrée par la joueur

  begin
    effacerEcran();

    { Corps de l'écran }
    afficherTitre('VOULEZ-VOUS VRAIMENT QUITTER LA PARTIE ?', 10);
    afficherAction(53,14, '1', 'Non', 'vert');
    afficherAction(53,16, '2', 'Oui', 'vert');

    { Partie inférieure de l'écran }
    afficherMessage();
    afficherCadreAction();

    { Déplace le curseur dans le cadre "Action" }
    deplacerCurseurXy(114,26);
    readln(choix);

    { Liste des choix disponibles }
    if (choix = '1') then EcranTribu.afficher(Joueur);
    if (choix = '2') then EcranAccueil.afficher()


    { Valeur saisie invalide }
    else
    begin
      setMessage('Action non reconnue');
      verifQuitter(Joueur);
    end;

  end;

end.
