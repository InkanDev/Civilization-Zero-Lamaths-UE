
unit EcranCombat;

interface

  uses GestionEcran, OptnAffichage, Variables;

  { Affichage de l'écran et appel des fonctions & procédures associées }
  procedure afficher(Joueur : TJoueur);

  { Lance un assaut contre le joueur }
  procedure assautAleatoire(Joueur : TJoueur);

  { Génère un nombre aléatoire de troupes ennemis en fonction de la taille indiquée }
  procedure genererEnnemis(Joueur : TJoueur ; taille : String); // 'petit' ou 'grand'



implementation

  uses EcranMilitaire, EcranAccueil;

  var

    LamaEnnemi    : TUnite; // Unité LAMA (Soldat) ennemie
    AlpagaEnnemi  : TUnite; // Unité ALPAGA (Canon) ennemie
    GuanacoEnnemi : TUnite; // Unité GUANACO (Cavalier) ennemie

    nomEnnemi        : String;  // Nom de l'opposant
    messageCombat    : Boolean; // Le message de déroulement du combat est-il affiché ?

    unite            : String;  // Unité ennemie attaquée pendant le tour
    uniteEnnemi      : String;  // Unité alliée attaquée pendant le tour
    nbElim           : Integer; // Nombre de troupes ennemies éliminées pendant le tour
    nbElimEnnemi     : Integer; // Nombre de troupes allées éliminées pendant le tour



  { Initialisation de la TUnite LamaEnnemi }
  procedure initLamaEnnemi;
  begin
    with LamaEnnemi do
    begin
      nom        := 'Lama';
      nb         := 0;
      ptsAttaque := 1;
      prix       := 1;
    end;
  end;

  { Initialisation de la TUnite AlpagaEnnemi }
  procedure initAlpagaEnnemi;
  begin
    with AlpagaEnnemi do
    begin
      nom        := 'Alpaga';
      nb         := 0;
      ptsAttaque := 2;
      prix       := 2;
    end;
  end;

  { Initialisation de la TUnite GuanacoEnnemi }
  procedure initGuanacoEnnemi;
  begin
    with GuanacoEnnemi do
    begin
      nom        := 'Guanaco';
      nb         := 0;
      ptsAttaque := 4;
      prix       := 3;
    end;
  end;



  { Lance un assaut contre le joueur }
  procedure assautAleatoire(Joueur : TJoueur);
  begin
    effacerEcran();

    // Affichage de l'en-tête
    afficherEnTete(Joueur);

    // Dessin du cadre principal et affichage du titre de l'écran
    dessinerCadreXY(0,6, 119,28, simple, 15,0);
    afficherTitre('COMBAT CONTRE : assaut littéraire' , 6);

    // Affichage du message "Assaut"
    couleurTexte(14);
    deplacerCurseurXY(29,9);
    write(' ______     ______     ______     ______     __  __     ______  ');
    deplacerCurseurXY(29,10);
    write('/\  __ \   /\  ___\   /\  ___\   /\  __ \   /\ \/\ \   /\__  _\ ');
    deplacerCurseurXY(29,11);
    write('\ \  __ \  \ \___  \  \ \___  \  \ \  __ \  \ \ \_\ \  \/_/\ \/ ');
    deplacerCurseurXY(29,12);
    write(' \ \_\ \_\  \/\_____\  \/\_____\  \ \_\ \_\  \ \_____\    \ \_\ ');
    deplacerCurseurXY(29,13);
    write('  \/_/\/_/   \/_____/   \/_____/   \/_/\/_/   \/_____/     \/_/ ');
    couleurTexte(15);

    dessinerCadreXY(32,17, 90,23, simple, 15,0);
    deplacerCurseurXY(34,17);
    write(' L''ennemi lance un assaut contre vous ! ');

    deplacerCurseurXY(37,19);
    write('Vous n''avez d''autre choix que de contre-attaquer.');


    attendre(4800);

    genererEnnemis(Joueur, 'assaut');
    afficher(Joueur);

  end;

  { Génère un nombre aléatoire d'unités ennemies en fonction de la taille
    indiquée (petit, grand, surprise, joueur) et de la difficulté. }
  procedure genererEnnemis(Joueur : TJoueur ; taille : String);
  begin

    { (ré)Initialisation des troupes ennemies }
    initLamaEnnemi();
    initAlpagaEnnemi();
    initGuanacoEnnemi();

    Randomize;

    // Dans le cas d'un PETIT groupe d'ennemis
    if taille = 'petit' then
    begin

      nomEnnemi := 'petit pâturage de littéraires';

      { Génération aléatoire du nb d'ennemis en fonction de la difficulté choisie }

        // Difficulté Linéaire
        if getTribu(Joueur).difficulte = 'Linéaire' then
        begin
          LamaEnnemi.nb    := 1 + Random(20);
          AlpagaEnnemi.nb  := Random(10);
          GuanacoEnnemi.nb := 0 ;
        end;

        // Difficulté Appliqué
        if getTribu(Joueur).difficulte = 'Appliqué' then
        begin
          LamaEnnemi.nb    := 5 + Random(20);
          AlpagaEnnemi.nb  := 2 + Random(10);
          GuanacoEnnemi.nb := Random(4);
        end;

        // Difficulté Quantique
        if getTribu(Joueur).difficulte = 'Quantique' then
        begin
          LamaEnnemi.nb    := 10 + Random(30);
          AlpagaEnnemi.nb  := 5 + Random(20);
          GuanacoEnnemi.nb := 2 + Random(6);
        end;
    end;

    // Dans le cas d'un GRAND groupe d'ennemis
    if taille = 'grand' then
    begin

      nomEnnemi := 'grand pâturage de littéraires';

      { Génération aléatoire du nb d'ennemis en fonction de la difficulté choisie }

        // Difficulté Linéaire
        if getTribu(Joueur).difficulte = 'Linéaire' then
        begin
          LamaEnnemi.nb    := 50 + Random(50);
          AlpagaEnnemi.nb  := 20 + Random(20);
          GuanacoEnnemi.nb := 5 + Random(10);
        end;

        // Difficulté Appliqué
        if getTribu(Joueur).difficulte = 'Appliqué' then
        begin
          LamaEnnemi.nb    := 70 + Random(70);
          AlpagaEnnemi.nb  := 30 + Random(30);
          GuanacoEnnemi.nb := 10 + Random(20);
        end;

        // Difficulté Appliqué
        if getTribu(Joueur).difficulte = 'Quantique' then
        begin
          LamaEnnemi.nb    := 80 + Random(80);
          AlpagaEnnemi.nb  := 40 + Random(40);
          GuanacoEnnemi.nb := 15 + Random(30);
        end;
    end;

    // Dans le cas d'un ASSAUT
    if taille = 'assaut' then
    begin

      nomEnnemi := 'assaut littéraire';

      { Génération aléatoire du nb d'ennemis en fonction de la difficulté choisie }

        // Difficulté Linéaire
        if getTribu(Joueur).difficulte = 'Linéaire' then
        begin
          LamaEnnemi.nb    := 1 + Random(5);
          AlpagaEnnemi.nb  := Random(5);
          GuanacoEnnemi.nb := 0 ;
        end;

        // Difficulté Appliqué
        if getTribu(Joueur).difficulte = 'Appliqué' then
        begin
          LamaEnnemi.nb    := 5 + Random(10);
          AlpagaEnnemi.nb  := 2 + Random(5);
          GuanacoEnnemi.nb := Random(2);
        end;

        // Difficulté Quantique
        if getTribu(Joueur).difficulte = 'Quantique' then
        begin
          LamaEnnemi.nb    := 5 + Random(20);
          AlpagaEnnemi.nb  := 2 + Random(10);
          GuanacoEnnemi.nb := Random(4);
        end;
    end;

    // Dans le cas particulier d'une attaque menée contre l'AUTRE JOUEUR
    if taille = 'joueur' then
    begin
      if Joueur = Joueur1 then nomEnnemi := 'Joueur 2'
      else if Joueur = Joueur2 then nomEnnemi := 'Joueur 1';
    end;

  end;



  { Lance une attaque contre l'unité indiquée (Lamas, Alpagas, Guanacos) }
  procedure attaquer(Joueur : TJoueur ; troupe : String);

  var
    scoreAttaque       : Integer; // Score d'attaque du joueur
    scoreAttaqueEnnemi : Integer; // Score d'attaque de l'ordinateur

  begin

    // Calcul du score d'attaque du joueur
    scoreAttaque := ( getLama(Joueur).nb    * getLama(Joueur).ptsAttaque )
                  + ( getAlpaga(Joueur).nb  * getAlpaga(Joueur).ptsAttaque )
                  + ( getGuanaco(Joueur).nb * getGuanaco(Joueur).ptsAttaque );

    // Calcul du score d'attaque de l'ordinateur
    scoreAttaqueEnnemi := ( LamaEnnemi.nb    * LamaEnnemi.ptsAttaque )
                        + ( AlpagaEnnemi.nb  * AlpagaEnnemi.ptsAttaque )
                        + ( GuanacoEnnemi.nb * GuanacoEnnemi.ptsAttaque );


    { Tour de jeu : JOUEUR }

      // Calcul du nb d'unités ennemies réellement éliminées
      nbElim := random(scoreAttaque);

      // Cas dans lequel les LAMAS (Soldats) ennemis sont attaqués
      if (troupe = 'Lamas') then
      begin
        unite := 'Lamas';
        if nbElim > LamaEnnemi.nb then nbElim := LamaEnnemi.nb;
        LamaEnnemi.nb := LamaEnnemi.nb - nbElim;
        if LamaEnnemi.nb < 0 then LamaEnnemi.nb := 0;
      end;

      // Cas dans lequel les ALPAGAS (Canons) ennemis sont attaqués
      if (troupe = 'Alpagas') then
      begin
        unite := 'Alpagas';
        if nbElim > AlpagaEnnemi.nb then nbElim := AlpagaEnnemi.nb;
        AlpagaEnnemi.nb := AlpagaEnnemi.nb - nbElim;
        if AlpagaEnnemi.nb < 0 then AlpagaEnnemi.nb := 0;
      end;

      // Cas dans lequel les GUANACOS (Cavaliers) ennemis sont attaqués
      if (troupe = 'Guanacos') then
      begin
        unite := 'Guanacos';
        if nbElim > GuanacoEnnemi.nb then nbElim := GuanacoEnnemi.nb;
        GuanacoEnnemi.nb := GuanacoEnnemi.nb - nbElim;
        if GuanacoEnnemi.nb < 0 then GuanacoEnnemi.nb := 0;
      end;

    { Tour de jeu : ORDINATEUR }

      // Calcul du nb d'unités alliées réellement éliminées
      nbElimEnnemi := random(scoreAttaqueEnnemi);

      { L'Ordinateur attaque en priorité les Lamas (Soldats) ; dès qu'il n'y en a plus,
        il attaque les Alpagas (Canons)et enfin les Guanacos (Cavaliers). }

      // Cas dans lequel les LAMAS (Soldats) alliés sont attaqués
      if getLama(Joueur).nb <> 0 then
      begin
        uniteEnnemi := 'Lamas';
        if nbElimEnnemi > getLama(Joueur).nb then nbElimEnnemi := getLama(Joueur).nb;
        setLama_nb(Joueur, getLama(Joueur).nb - nbElimEnnemi);
        if getLama(Joueur).nb < 0 then setLama_nb(Joueur, 0);
      end

      // Cas dans lequel les ALPAGAS (Canons) alliés sont attaqués
      else if getAlpaga(Joueur).nb <> 0 then
      begin
        uniteEnnemi := 'Alpagas';
        if nbElimEnnemi > getAlpaga(Joueur).nb then nbElimEnnemi := getAlpaga(Joueur).nb;
        setAlpaga_nb(Joueur, getAlpaga(Joueur).nb - nbElimEnnemi);
        if getAlpaga(Joueur).nb < 0 then setAlpaga_nb(Joueur, 0);
      end

      // Cas dans lequel les GUANACOS (Cavaliers) alliés sont attaqués
      else if getGuanaco(Joueur).nb <> 0 then
      begin
        uniteEnnemi := 'Guanacos';
        if nbElimEnnemi > getGuanaco(Joueur).nb then nbElimEnnemi := getGuanaco(Joueur).nb;
        setGuanaco_nb(Joueur, getGuanaco(Joueur).nb - nbElimEnnemi);
        if getGuanaco(Joueur).nb < 0 then setGuanaco_nb(Joueur, 0);
      end;


    messageCombat := True;
    afficher(Joueur);
  end;

  { Procédure spéciale dérivée de la procédure attaquer() configurée pour
    opposer l'armée du joueur attaquant à celle du joueur défenseur. }
  procedure attaquerJoueur(Joueur : TJoueur ; troupe : String);

  var
    Attaquant : TJoueur; // Joueur ATTAQUANT
    Defenseur : TJoueur; // Joueur ATTAQUÉ (Défenseur)

    scoreAttaqueAttaquant       : Integer; // Score d'attaque du joueur attaquant
    scoreAttaqueDefenseur       : Integer; // Score d'attaque du joueur attaqué (défenseur)

  begin

    // Identifie l'Attaquant et le Défenseur à partir du Joueur à l'origine de l'attaque

      { Joueur 1 }
      if Joueur = Joueur1 then
      begin
        Attaquant := Joueur1;
        Defenseur := Joueur2;
      end

      { Joueur 2 }
      else if Joueur = Joueur2 then
      begin
        Attaquant := Joueur2;
        Defenseur := Joueur1;
      end;


    // Calcul du score d'attaque du joueur attaquant
    scoreAttaqueAttaquant := ( getLama(Attaquant).nb    * getLama(Attaquant).ptsAttaque )
                           + ( getAlpaga(Attaquant).nb  * getAlpaga(Attaquant).ptsAttaque )
                           + ( getGuanaco(Attaquant).nb * getGuanaco(Attaquant).ptsAttaque );

    // Calcul du score d'attaque du joueur attaqué (défenseur)
    scoreAttaqueDefenseur := ( getLama(Defenseur).nb    * getLama(Defenseur).ptsAttaque )
                           + ( getAlpaga(Defenseur).nb  * getAlpaga(Defenseur).ptsAttaque )
                           + ( getGuanaco(Defenseur).nb * getGuanaco(Defenseur).ptsAttaque );


    { Tour de jeu : ATTAQUANT }

      // Calcul du nb d'unités ennemies réellement éliminées
      nbElim := random(scoreAttaqueAttaquant);

      // Cas dans lequel les LAMAS (Soldats) ennemis sont attaqués
      if (troupe = 'Lamas') then
      begin
        unite := 'Lamas';
        if nbElim > getLama(Defenseur).nb then nbElim := getLama(Defenseur).nb;
        setLama_nb(Defenseur, getLama(Defenseur).nb - nbElim);
        if getLama(Defenseur).nb < 0 then setLama_nb(Defenseur,0);
      end;

      // Cas dans lequel les ALPAGAS (Canons) ennemis sont attaqués
      if (troupe = 'Alpagas') then
      begin
        unite := 'Alpagas';
        if nbElim > getAlpaga(Defenseur).nb then nbElim := getAlpaga(Defenseur).nb;
        setAlpaga_nb(Defenseur, getAlpaga(Defenseur).nb - nbElim);
        if getAlpaga(Defenseur).nb < 0 then setAlpaga_nb(Defenseur,0);
      end;

      // Cas dans lequel les GUANACOS (Cavaliers) ennemis sont attaqués
      if (troupe = 'Guanacos') then
      begin
        unite := 'Guanacos';
        if nbElim > getGuanaco(Defenseur).nb then nbElim := getGuanaco(Defenseur).nb;
        setGuanaco_nb(Defenseur, getGuanaco(Defenseur).nb - nbElim);
        if getGuanaco(Defenseur).nb < 0 then setGuanaco_nb(Defenseur,0);
      end;

    { Tour de jeu : DÉFENSEUR }

    { Le Défenseur ne joue pas à proprement parler ; les actions de son armée sont décidées
      de la même manière que s'il s'agissait d'un ordinateur. }

      // Calcul du nb d'unités alliées réellement éliminées
      nbElimEnnemi := random(scoreAttaqueDefenseur);

      { L'Ordinateur attaque en priorité les Lamas (Soldats) ; dès qu'il n'y en a plus,
        il attaque les Alpagas (Canons)et enfin les Guanacos (Cavaliers). }

      // Cas dans lequel les LAMAS (Soldats) alliés sont attaqués
      if getLama(Joueur).nb <> 0 then
      begin
        uniteEnnemi := 'Lamas';
        if nbElimEnnemi > getLama(Joueur).nb then nbElimEnnemi := getLama(Joueur).nb;
        setLama_nb(Joueur, getLama(Joueur).nb - nbElimEnnemi);
        if getLama(Joueur).nb < 0 then setLama_nb(Joueur, 0);
      end

      // Cas dans lequel les ALPAGAS (Canons) alliés sont attaqués
      else if getAlpaga(Joueur).nb <> 0 then
      begin
        uniteEnnemi := 'Alpagas';
        if nbElimEnnemi > getAlpaga(Joueur).nb then nbElimEnnemi := getAlpaga(Joueur).nb;
        setAlpaga_nb(Joueur, getAlpaga(Joueur).nb - nbElimEnnemi);
        if getAlpaga(Joueur).nb < 0 then setAlpaga_nb(Joueur, 0);
      end

      // Cas dans lequel les GUANACOS (Cavaliers) alliés sont attaqués
      else if getGuanaco(Joueur).nb <> 0 then
      begin
        uniteEnnemi := 'Guanacos';
        if nbElimEnnemi > getGuanaco(Joueur).nb then nbElimEnnemi := getGuanaco(Joueur).nb;
        setGuanaco_nb(Joueur, getGuanaco(Joueur).nb - nbElimEnnemi);
        if getGuanaco(Joueur).nb < 0 then setGuanaco_nb(Joueur, 0);
      end;


    messageCombat := True;
    afficher(Joueur);
  end;



  { Génère aléatoirement un butin (bonus) en fonction d'une taille donnée (petit, grand, assaut) }
  procedure genererButin(Joueur : TJoueur ; taille : String);

  var
    alea : Integer ; // Nombre aléatoire déterminant la catégorie du butin

    { Variables de gain }
    gainSavoir    : Integer; // Gain en savoir acquis
    gainEquations : Integer; // Gain en équations résolues
    gainLama      : Integer; // Gain en Lamas
    gainAlpaga    : Integer; // Gain en Alpagas
    gainGuanaco   : Integer; // Gain en Guanacos

  begin

    Randomize;

    alea := random(4);

    if (taille = 'petit') OR (taille = 'assaut') then
    { Note : Bien que l'armée ennemie soit réduite dans un assaut,
      on va dire que le côté "surprise" justifie un butin équivalent
      à la victoire contre un petit pâturage de littéraires. }
    begin
      if alea = 0 then
      begin
        gainSavoir := random(100);
        setElevage_savoirAcquis(Joueur, getElevage(Joueur).savoirAcquis + gainSavoir);
      end;

      if alea = 1 then
      begin
        gainEquations := random(120);
        setElevage_equationsResolues(Joueur, getElevage(Joueur).equationsResolues + gainEquations);
      end;

      if alea = 2 then
      begin
        gainLama := random(20);
        setLama_nb(Joueur, getLama(Joueur).nb + gainLama);
      end;

      if alea = 3 then
      begin
        gainAlpaga := random(10);
        setAlpaga_nb(Joueur, getAlpaga(Joueur).nb + gainAlpaga);
      end;

      if alea = 4 then
      begin
        gainGuanaco := random(5);
        setGuanaco_nb(Joueur, getGuanaco(Joueur).nb + gainGuanaco);
      end;
    end;

    if taille = 'grand' then
    begin
      if alea = 0 then
      begin
        gainSavoir := random(400);
        setElevage_savoirAcquis(Joueur, getElevage(Joueur).savoirAcquis + gainSavoir);
      end;

      if alea = 1 then
      begin
        gainEquations := random(1000);
        setElevage_equationsResolues(Joueur, getElevage(Joueur).equationsResolues + gainEquations);
      end;

      if alea = 2 then
      begin
        gainLama := random(80);
        setLama_nb(Joueur, getLama(Joueur).nb + gainLama);
      end;

      if alea = 3 then
      begin
        gainAlpaga := random(40);
        setAlpaga_nb(Joueur, getAlpaga(Joueur).nb + gainAlpaga);
      end;

      if alea = 4 then
      begin
        gainGuanaco := random(20);
        setGuanaco_nb(Joueur, getGuanaco(Joueur).nb + gainGuanaco);
      end;
    end;


    deplacerCurseurXY(36,21);
    if alea = 0 then write('Le savoir acquis par votre élevage augmente de ', gainSavoir);
    if alea = 1 then write('Votre élevage a résolu ', gainEquations, ' équations supplémentaires');
    if alea = 2 then write(gainLama, ' Lamas ont rejoint votre noble cause mathématique');
    if alea = 3 then write(gainAlpaga, ' Alpagas ont rejoint votre noble cause mathématique');
    if alea = 4 then write(gainGuanaco, ' Guanacos ont rejoint votre noble cause mathématique');

  end;



  { Affiche l'écran de game over }
  procedure perdrePartie(Joueur : TJoueur);

  var
    x      : Integer; // Coordonnée x d'origine du dessin
    espace : String;  // Espace séparant chaque pavé

  begin

    { Dans un premier temps, une animation similaire à celle de l'écran titre est lancée
      pour signaler au joueur qu'il a perdu. On affiche ensuite un bilan de la partie jouée. }

    effacerEcran;

    // Initialisation des variables de travail
    espace := ' ';
    x := 32;

    { Fonctionne par pas de 2 'manuel', d'où le while plutôt qu'un for }
    while x >= 14 do
    begin

      if x = 30 then attendre(100);
      if x = 28 then couleurTexte(5);
      if x = 26 then couleurTexte(13);
      if x = 24 then couleurTexte(9);
      if x = 22 then couleurTexte(11);
      if x = 20 then couleurTexte(10);
      if x = 18 then couleurTexte(14);
      if x = 16 then couleurTexte(12);
      if x = 14 then couleurTexte(15);

      // Dessin des formes HAUT
      deplacerCurseurXY(x,1);
      writeln('+------+.   ',espace,'+------+  ',espace,'+------+',espace,'  +------+',espace,'   .+------+');
      deplacerCurseurXY(x,2);
      writeln('|`.    | `. ',espace,'|\     |\ ',espace,'|      |',espace,' /|     /|',espace,' .'' |    .''|');
      deplacerCurseurXY(x,3);
      writeln('|  `+--+---+',espace,'| +----+-+',espace,'+------+',espace,'+-+----+ |',espace,'+---+--+''  |');
      deplacerCurseurXY(x,4);
      writeln('|   |  |   |',espace,'| |    | |',espace,'|      |',espace,'| |    | |',espace,'|   |  |   |');
      deplacerCurseurXY(x,5);
      writeln('+---+--+.  |',espace,'+-+----+ |',espace,'+------+',espace,'| +----+-+',espace,'|  .+--+---+');
      deplacerCurseurXY(x,6);
      writeln(' `. |    `.|',espace,' \|     \|',espace,'|      |',espace,'|/     |/ ',espace,'|.''    | .''');
      deplacerCurseurXY(x,7);
      writeln('   `+------+',espace,'  +------+',espace,'+------+',espace,'+------+  ',espace,'+------+'' ');

      // Dessin des formes BAS
      deplacerCurseurXY(x,18);
      writeln('   .+------+',espace,'  +------+',espace,'+------+',espace,'+------+',espace,'  +------+.');
      deplacerCurseurXY(x,19);
      writeln(' .'' |    .''|',espace,' /|     /|',espace,'|      |',espace,'|\     |\',espace,' |`.    | `.');
      deplacerCurseurXY(x,20);
      writeln('+---+--+''  |',espace,'+-+----+ |',espace,'+------+',espace,'| +----+-+',espace,'|  `+--+---+');
      deplacerCurseurXY(x,21);
      writeln('|   |  |   |',espace,'| |    | |',espace,'|      |',espace,'| |    | |',espace,'|   |  |   |');
      deplacerCurseurXY(x,22);
      writeln('|  ,+--+---+',espace,'| +----+-+',espace,'+------+',espace,'+-+----+ |',espace,'+---+--+   |');
      deplacerCurseurXY(x,23);
      writeln('|.''    | .''',espace,' |/     |/',espace,' |      |',espace,' \|     \|',espace,' `. |   `. |');
      deplacerCurseurXY(x,24);
      writeln('+------+''',espace,'   +------+',espace,'  +------+',espace,'  +------+',espace,'   `+------+');

      // Délai d'attente entre chaque image
      attendre(100);

      // On rajoute un espace pour disperser davantage les pavés
      espace := espace + ' ';

      // x est décrémenté de 2 pour garder le dessin centré
      x := x - 2;

    end;


    attendre(40);
    deplacerCurseurXY(49,10);
    write('███████╗██╗███╗   ██╗');
    attendre(40);
    deplacerCurseurXY(49,11);
    write('██╔════╝██║████╗  ██║');
    attendre(40);
    deplacerCurseurXY(49,12);
    write('█████╗  ██║██╔██╗ ██║');
    attendre(40);
    deplacerCurseurXY(49,13);
    write('██╔══╝  ██║██║╚██╗██║');
    attendre(40);
    deplacerCurseurXY(49,14);
    write('██║     ██║██║ ╚████║');
    attendre(40);
    deplacerCurseurXY(49,15);
    write('╚═╝     ╚═╝╚═╝  ╚═══╝');


    // Le joueur appuie sur ENTRER et l'écran de fin de partie s'affiche
    dessinerCadreXY(41,26, 77,28, simple, 15,0);
    deplacerCurseurXY(43,27);
    writeln('Appuyez sur ENTRER pour continuer');
    deplacerCurseurXY(76,27);
    readln;

    effacerEcran;

    // Dessin du titre
    deplacerCurseurXY(46,2);
    write(' ______   __     __   __    ');
    deplacerCurseurXY(46,3);
    write('/\  ___\ /\ \   /\ "-.\ \   ');
    deplacerCurseurXY(46,4);
    write('\ \  __\ \ \ \  \ \ \-.  \  ');
    deplacerCurseurXY(46,5);
    write(' \ \_\    \ \_\  \ \_\\"\_\ ');
    deplacerCurseurXY(46,6);
    write('  \/_/     \/_/   \/_/ \/_/ ');


    // Bilan de la partie

      dessinerCadreXY(32,10, 90,20, simple, 15,0);
      deplacerCurseurXY(34,10);
      write(' Fin de la partie : Statistiques ');

      deplacerCurseurXY(38,13);
      write('La Tribu ', getTribu(Joueur).archetype, ' ');
      couleurTexte(11);
      write(getTribu(Joueur).nom);
      couleurTexte(15);

      deplacerCurseurXY(38,14);
      write('a survécu ');
      write(getTribu(Joueur).numJour);
      write(' jours en difficulté ');
      couleurTexte(13);
      write(getTribu(Joueur).difficulte);
      couleurTexte(15);
      write('.');

      deplacerCurseurXY(38,16);
      write('Ses troupes ont victorieusement mené ');
      couleurTexte(10);
      write(getTribu(Joueur).victoires);
      couleurTexte(15);
      write(' combats');

      deplacerCurseurXY(38,17);
      write('mais ont été défaites lors de ');
      couleurTexte(12);
      write(getTribu(Joueur).defaites);
      couleurTexte(15);
      write(' batailles.');


    deplacerCurseurXY(36,23);
    couleurTexte(8);
    write('Vous allez être redirigé vers le menu principal');
    couleurTexte(15);


    // Le joueur appuie sur ENTRER et est renvoyé à l'écran d'accueil
    dessinerCadreXY(41,26, 77,28, simple, 15,0);
    deplacerCurseurXY(43,27);
    write('Appuyez sur ENTRER pour continuer');
    deplacerCurseurXY(76,27);
    readln;
    EcranAccueil.afficher();

  end;

  { Affiche l'écran de victoire }
  procedure victoire(Joueur : TJoueur);
  begin
    effacerEcran();

    // Affichage de l'en-tête
    afficherEnTete(Joueur);

    // Le nombre de victoires en combat du joueur est incrémenté
    setTribu_victoires(Joueur, getTribu(Joueur).victoires + 1);

    // Si l'attaque a été menée contre l'autre joueur, ce dernier gagne une défaite
    if (nomEnnemi = 'Joueur 1') OR (nomEnnemi = 'Joueur 2') then
    begin
      if Joueur = Joueur1 then setTribu_defaites(Joueur2, getTribu(Joueur2).defaites + 1);
      if Joueur = Joueur2 then setTribu_defaites(Joueur1, getTribu(Joueur1).defaites + 1);
    end;

    // Dessin du cadre principal et affichage du titre de l'écran
    dessinerCadreXY(0,6, 119,28, simple, 15,0);
    afficherTitre('COMBAT CONTRE : ' + nomEnnemi , 6);

    // Affichage du message "Victoire"
    couleurTexte(10);
    deplacerCurseurXY(22,9);
    write(' __   __   __     ______     ______   ______     __     ______     ______ ');
    deplacerCurseurXY(22,10);
    write('/\ \ / /  /\ \   /\  ___\   /\__  _\ /\  __ \   /\ \   /\  == \   /\  ___\ ');
    deplacerCurseurXY(22,11);
    write('\ \ \''/   \ \ \  \ \ \____  \/_/\ \/ \ \ \/\ \  \ \ \  \ \  __<   \ \  __\   ');
    deplacerCurseurXY(22,12);
    write(' \ \__|    \ \_\  \ \_____\    \ \_\  \ \_____\  \ \_\  \ \_\ \_\  \ \_____\ ');
    deplacerCurseurXY(22,13);
    write('  \/_/      \/_/   \/_____/     \/_/   \/_____/   \/_/   \/_/ /_/   \/_____/ ');
    couleurTexte(15);

    dessinerCadreXY(32,17, 90,23, simple, 15,0);
    deplacerCurseurXY(34,17);
    write(' Vous triomphez de l''ennemi ! ');

    deplacerCurseurXY(42,19);
    write('Votre nombre de victoires s''élève à ');
    couleurTexte(10);
    write(getTribu(Joueur).victoires);

    // Génère et affiche un butin aléatoire
    if nomEnnemi = 'petit pâturage de littéraires' then genererButin(Joueur, 'petit')
    else if nomEnnemi = 'grand pâturage de littéraires' then genererButin(Joueur, 'grand')
    else if nomEnnemi = 'assaut littéraire' then genererButin(Joueur, 'assaut');
    couleurTexte(15);


    // Le message du déroulement du combat n'est plus affiché
    messageCombat := False;

    // Le joueur appuie sur ENTRER et est renvoyé à l'écran de gestion Militaire et Diplomatique
    deplacerCurseurXY(43,26);
    write('Appuyez sur ENTRER pour continuer');
    deplacerCurseurXY(76,26);
    readln;
    EcranMilitaire.afficher(Joueur);
  end;

  { Affiche l'écran de défaite }
  procedure defaite(Joueur : TJoueur);
  begin
    effacerEcran();

    // Affichage de l'en-tête
    afficherEnTete(Joueur);

    // Le nombre de défaites en combat du joueur est incrémenté
    setTribu_defaites(Joueur, getTribu(Joueur).defaites + 1);

    // Si l'attaque a été menée contre l'autre joueur, ce dernier gagne une victoire
    if (nomEnnemi = 'Joueur 1') OR (nomEnnemi = 'Joueur 2') then
    begin
      if Joueur = Joueur1 then setTribu_victoires(Joueur2, getTribu(Joueur2).victoires + 1);
      if Joueur = Joueur2 then setTribu_victoires(Joueur1, getTribu(Joueur1).victoires + 1);
    end;

    // Dessin du cadre principal et affichage du titre de l'écran
    dessinerCadreXY(0,6, 119,28, simple, 15,0);
    afficherTitre('COMBAT CONTRE : ' + nomEnnemi , 6);

    // Affichage du message "Défaite"
    couleurTexte(12);
    deplacerCurseurXY(27,9);
    write(' _____     ______     ______   ______     __     ______   ______    ');
    deplacerCurseurXY(27,10);
    write('/\  __-.  /\  ___\   /\  ___\ /\  __ \   /\ \   /\__  _\ /\  ___\   ');
    deplacerCurseurXY(27,11);
    write('\ \ \/\ \ \ \  __\   \ \  __\ \ \  __ \  \ \ \  \/_/\ \/ \ \  __\   ');
    deplacerCurseurXY(27,12);
    write(' \ \____-  \ \_____\  \ \_\    \ \_\ \_\  \ \_\    \ \_\  \ \_____\ ');
    deplacerCurseurXY(27,13);
    write('  \/____/   \/_____/   \/_/     \/_/\/_/   \/_/     \/_/   \/_____/ ');
    couleurTexte(15);


    dessinerCadreXY(32,17, 90,23, simple, 15,0);
    deplacerCurseurXY(34,17);
    write(' L''ennemi a eu raison de vous ! ');

    deplacerCurseurXY(43,19);
    write('Votre nombre de défaites s''élève à ');
    couleurTexte(12);
    write(getTribu(Joueur).defaites);

    // Affiche le nombre de défaites restantes avant la fin de la partie
    deplacerCurseurXY(37,21);
    if getTribu(Joueur).defaites = getTribu(Joueur).limDefaites then write('Ces ', getTribu(Joueur).limDefaites, ' défaites ont été fatales pour votre Tribu.')
    else write('Vos recherches seront anéanties dans ', getTribu(Joueur).limDefaites - getTribu(Joueur).defaites, ' défaites.');
    couleurTexte(15);


    // Le message du déroulement du combat n'est plus affiché
    messageCombat := False;


    // Le joueur appuie sur ENTRER et est renvoyé à l'écran de gestion Militaire et Diplomatique
    deplacerCurseurXY(43,26);
    write('Appuyez sur ENTRER pour continuer');
    deplacerCurseurXY(76,26);
    readln;

    // Si c'était la défaite de trop, le joueur perd la partie
    if getTribu(Joueur).defaites = getTribu(Joueur).limDefaites then perdrePartie(Joueur)
    else EcranMilitaire.afficher(Joueur);
  end;



  { Affiche un message résumant le déroulement du combat si messageCombat = True }
  procedure afficherMsgCombat;
  begin
    { Cadre du message }
    dessinerCadreXY(58,14, 109,19, simple, 15,0);
    deplacerCurseurXY(60,14);
    write(' Champ de bataille ');

    { Si le combat a commencé }
    if messageCombat = True then
    begin
      // Bilan de l'attaque du Joueur
      deplacerCurseurXY(62,16);
      if nbElim > 0 then couleurTexte(10)
      else couleurTexte(8);
      write('Vos troupes crachent sur ', nbElim, ' ', unite, ' ennemis.');

      // Bilan de l'attaque de l'Ordinateur
      deplacerCurseurXY(62,17);
      if nbElimEnnemi > 0 then couleurTexte(12)
      else couleurTexte(8);
      write('L''ennemi crache sur ', nbElimEnnemi, ' de vos ', uniteEnnemi, '.');
      couleurTexte(15);
    end

    { Dans le cas où le combat vient de commencer }
    else
    begin
      deplacerCurseurXY(62,16);
      write('Préparez-vous au combat !');
    end;
  end;



  { Récupère le choix du joueur et détermine l'action à effectuer }
  procedure choisir(Joueur : TJoueur);

  var
    choix : String; // Valeur entrée par la joueur

  begin
    { Déplace le curseur dans le cadre "Action" }
    deplacerCurseurXY(114,26);
    readln(choix);

    { Liste des choix disponibles }

    { Si le combat oppose deux joueurs, on fait appel à la procédure spéciale
      attaquerJoueur pour jouer un tour de combat. }
    if (nomEnnemi = 'Joueur 1') OR (nomEnnemi = 'Joueur 2') then
    begin
      if (choix = '1') then attaquerJoueur(Joueur, 'Lamas');
      if (choix = '2') then attaquerJoueur(Joueur, 'Alpagas');
      if (choix = '3') then attaquerJoueur(Joueur, 'Guanacos')

      { Valeur saisie invalide }
      else
      begin
        setMessage('Action non reconnue');
        afficher(Joueur);
      end;
    end

    else
    begin
      if (choix = '1') then attaquer(Joueur, 'Lamas');
      if (choix = '2') then attaquer(Joueur, 'Alpagas');
      if (choix = '3') then attaquer(Joueur, 'Guanacos')

      { Valeur saisie invalide }
      else
      begin
        setMessage('Action non reconnue');
        afficher(Joueur);
      end;
    end

  end;

  { Affichage de l'écran et appel des fonctions & procédures associées }
  procedure afficher(Joueur : TJoueur);

  var
    Defenseur : TJoueur; // Joueur Défenseur

  begin

    // Dans le cas d'une partie multijoueur, identifie le Défenseur d'après le Joueur à l'origine de l'attaque

    if getMultijoueur() = True then
    begin
      { Joueur 1 }
      if Joueur = Joueur1 then
      begin
        Defenseur := Joueur2;
      end
      { Joueur 2 }
      else if Joueur = Joueur2 then
      begin
        Defenseur := Joueur1;
      end;
    end;

    { On vérifie d'abord si l'un des deux belligérants a remporté le combat,
      auquel cas on affiche l'écran de Victoire/Défaite. }

    if (getLama(Joueur).nb = 0) AND (getAlpaga(Joueur).nb = 0) AND (getGuanaco(Joueur).nb = 0) then defaite(Joueur);

    // Si le combat oppose deux joueurs, la victoire est identifiée à partir de l'armée du défenseur
    if (nomEnnemi = 'Joueur 1') OR (nomEnnemi = 'Joueur 2') then
    begin
      if (getLama(Defenseur).nb = 0) AND (getAlpaga(Defenseur).nb = 0) AND (getGuanaco(Defenseur).nb = 0) then victoire(Joueur);
    end
    // Sinon la victoire est identifiée à partir de l'armée de l'ordinateur
    else if (LamaEnnemi.nb = 0) AND (AlpagaEnnemi.nb = 0) AND (GuanacoEnnemi.nb = 0) then victoire(Joueur);

    { INSTRUCTIONS D'AFFICHAGE }

    effacerEcran();

    { Partie supérieure de l'écran }
    afficherEnTete(Joueur);
    dessinerCadreXY(0,6, 119,28, simple, 15,0);
    afficherTitre('COMBAT CONTRE : ' + nomEnnemi , 6);

    { Corps de l'écran }

      // Armée du Joueur
      deplacerCurseurXY(3,10);
      write('Descriptif de vos forces :');
      deplacerCurseurXY(3,11);
      write('¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯');

        // Lamas
        deplacerCurseurXY(5,12);
        write('    Lamas : ');
        if getLama(Joueur).nb = 0 then couleurTexte(8)
        else couleurtexte(10);
        write(getLama(Joueur).nb);
        couleurTexte(15);

        // Alpagas
        deplacerCurseurXY(5,13);
        write('  Alpagas : ');
        if getAlpaga(Joueur).nb = 0 then couleurTexte(8)
        else couleurtexte(10);
        write(getAlpaga(Joueur).nb);
        couleurTexte(15);

        // Guanacos
        deplacerCurseurXY(5,14);
        write(' Guanacos : ');
        if getGuanaco(Joueur).nb = 0 then couleurTexte(8)
        else couleurtexte(10);
        write(getGuanaco(Joueur).nb);
        couleurTexte(15);


      // Armée ennemie
      deplacerCurseurXY(3,16);
      write('Descriptif des forces ennemies :');
      deplacerCurseurXY(3,17);
      write('¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯');

        // Lamas ennemis
        deplacerCurseurXY(5,18);
        write('    Lamas : ');
        if (nomEnnemi = 'Joueur 1') OR (nomEnnemi = 'Joueur 2') then
        begin
          if getLama(Defenseur).nb = 0 then couleurTexte(8)
          else couleurtexte(12);
          write(getLama(Defenseur).nb);
        end

        else
        begin
          if LamaEnnemi.nb = 0 then couleurTexte(8)
          else couleurtexte(12);
          write(LamaEnnemi.nb);
        end;
        couleurTexte(15);

        // Alpagas ennemis
        deplacerCurseurXY(5,19);
        write('  Alpagas : ');
        if (nomEnnemi = 'Joueur 1') OR (nomEnnemi = 'Joueur 2') then
        begin
          if getAlpaga(Defenseur).nb = 0 then couleurTexte(8)
          else couleurtexte(12);
          write(getAlpaga(Defenseur).nb);
        end

        else
        begin
          if AlpagaEnnemi.nb = 0 then couleurTexte(8)
          else couleurtexte(12);
          write(AlpagaEnnemi.nb);
        end;
        couleurTexte(15);

        // Guanacos ennemis
        deplacerCurseurXY(5,20);
        write(' Guanacos : ');
        if (nomEnnemi = 'Joueur 1') OR (nomEnnemi = 'Joueur 2') then
        begin
          if getGuanaco(Defenseur).nb = 0 then couleurTexte(8)
          else couleurtexte(12);
          write(getGuanaco(Defenseur).nb);
        end

        else
        begin
          if GuanacoEnnemi.nb = 0 then couleurTexte(8)
          else couleurtexte(12);
          write(GuanacoEnnemi.nb);
        end;
        couleurTexte(15);


    // Affichage du message résumant le déroulement du tour combat
    afficherMsgCombat();

    { Choix disponibles }
    afficherAction(3,24, '1', 'Cracher sur les lamas ennemis', 'vert');
    afficherAction(3,25, '2', 'Cracher sur les Alpagas ennemis', 'vert');
    afficherAction(3,26, '3', 'Cracher sur les Guanacos ennemis', 'vert');

    { Partie inférieure de l'écran }
    afficherMessage();
    afficherCadreAction();

    choisir(Joueur);
  end;

end.
