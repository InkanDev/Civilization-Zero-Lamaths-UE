unit OptnAffichage;

interface

  uses Variables;

  { Affiche l'en-tête contenant le nom de la Tribu et le numéro du Jour }
  procedure afficherEnTete(Joueur : TJoueur);

  { Affiche le cadre "Action" dans lequel le Joueur saisit l'action à effectuer }
  procedure afficherCadreAction;
  { Automatise l'affichage d'une action qu'il est possible d'effectuer }
  procedure afficherAction(x,y : Integer; numero, action, couleur : String);

  { Automatise l'affichage du titre d'un écran entré en paramètre }
  procedure afficherTitre(titre : String; y  : Integer);

  { Affiche un éventuel message à gauche du cadre "Action" }
  procedure afficherMessage;
  { Indique le message à afficher lors de l'appel de la procédure afficherMessage }
  procedure setMessage(valeur : String);

  { Affiche un résumé de l'état de la ville aux coordonnées (x,y) }
  procedure afficherElevage(Joueur : TJoueur ; x,y : Integer);



implementation

  uses GestionEcran;

  var
    message : String; // Variable contenant le message à afficher à gauche du cadre "Action"
                      // Ex : 'Action non reconnue' ou 'Construction lancée'


  { Affiche l'en-tête contenant le nom de la Tribu et le numéro du Jour }
  procedure afficherEnTete(Joueur : TJoueur);
  begin
    dessinerCadreXY(0,0, 119,4, simple, 15,0);

    // Nom et archétype de la Tribu
    deplacerCurseurXY(3,2);
    write('Tribu : ');
    couleurTexte(11);
    write(getTribu(Joueur).nom);
    couleurTexte(8);
    write(' (', getTribu(Joueur).archetype,',', getTribu(Joueur).difficulte, ')');
    couleurTexte(15);

    // Affichage du n° du Joueur si c'est une partie 2 Joueurs
    if getMultijoueur = True then
    begin

      { Joueur 1 (magenta) }
      if Joueur = Joueur1 then
      begin
        dessinerCadreXY(50,1, 67,3, double, 13,0);
        deplacerCurseurXY(55,2);
        couleurTexte(13);
        write('Joueur 1');
      end

      { Joueur 2 (jaune) }
      else if Joueur = Joueur2 then
      begin
        dessinerCadreXY(50,1, 67,3, double, 14,0);
        deplacerCurseurXY(55,2);
        couleurTexte(14);
        write('Joueur 2');
      end;

      couleurTexte(15);
    end;

    // Numéro du Jour
    dessinerCadreXY(103,1, 117,3, simple, 15,0);
    deplacerCurseurXY(105,2);
    writeln('Jour : ', getTribu(Joueur).numJour);
  end;

  { Automatise l'affichage du titre d'un écran }
  procedure afficherTitre(titre : String; y  : Integer);
  begin
    // Création du cadre
    if ((length(titre) mod 2) = 0) then
    begin
      dessinerCadreXY( (58 - (length(titre) div 2) - 2), (y-1), (58 + (length(titre) div 2) + 3), (y+1), double, 15, 0);
    end
    else dessinerCadreXY( (58 - (length(titre) div 2) - 2), (y-1), (58 + (length(titre) div 2) + 4), (y+1), double, 15, 0);

    // Ecriture du titre
    deplacerCurseurXY( (58 - (length(titre) div 2) + 1), y);
    writeln(titre);
  end;


  { Affiche le cadre "Action" dans lequel le Joueur saisit l'action à effectuer }
  procedure afficherCadreAction;

  var // Coordonnées auxquelles est affiché le cadre
    x : Integer;
    y : Integer;

  begin
    x := 105;
    y := 26;

    dessinerCadreXY((x-2),(y-1), (x+12),(y+1), Simple, 15,0);
    deplacerCurseurXY(x,y);
    write('Action : ');
  end;

  { Automatise l'affichage d'une action qu'il est possible d'effectuer }
  procedure afficherAction(x,y : Integer; numero, action, couleur : String);
  begin
    // Ecriture du crochet gauche
    deplacerCurseurXY(x,y);
    write('[');

    // Ecriture du numéro de l'action
    if couleur = 'vert' then couleurTexte(10)
    else if couleur = 'cyan' then couleurTexte(11)
    else if couleur = 'rouge' then couleurTexte(12)
    else if couleur = 'magenta' then couleurTexte(13)
    else if couleur = 'jaune' then couleurTexte(14);
    write(numero);
    couleurTexte(15);

    // Ecriture du crochet droit
    write(']');

    // Ecriture de l'intitulé de l'action
    write(' ' + action);
  end;


  { Affiche un éventuel message à gauche du cadre "Action" }
  procedure afficherMessage;
  begin

    { Si la variable message n'est pas vide (''), c'est-à-dire qu'un message a été envoyé
      suite à une action, ce message est affiché à gauche du cadre "Action".
      Après son affichage, le message est réinitialisé à ''. }

    if (message <> '') then
      deplacerCurseurXY(101 - length(message),26); // Calcul automatique de l'origine en fonction
      write(message);                              // de la taille du message.
      message := ''; // Réinitialisation
  end;

  { Indique le message à afficher lors de l'appel de la procédure afficherMessage }
  procedure setMessage(valeur : String);
  begin
    message := valeur;
  end;


  { Affiche l'état de la construction en cours aux coordonnées (x,y) }
  procedure afficherConstruction(Joueur : TJoueur ; x,y : Integer);

  var
    batiment : String;  // Nom du bâtiment en construction
    niveau   : Integer; // Niveau vers lequel le bâtiment est amélioré
    palier   : Integer; // Travail nécessaire pour achever la construction
    compteurNiveau : Integer; // Compteur

  begin
    // Dans tous les cas, on affiche le travail ajouté par tour
    deplacerCurseurXY(x,y);
    write('Équations par jour : ');
    couleurTexte(10);
    write(getElevage(Joueur).equationsJour);
    couleurTexte(15);

    { Si une construction est en cours, l'affichage de son état nécessite d'identifier le nom du bâtiment
      en construction, le niveau vers lequel ce bâtiment est amélioré, et le total d'équations à résoudre (palier)
      pour en achever la construction. Les instructions suivantes ont pour but d'identifier ces valeurs. }

    // Dans le cas où une construction est en cours
    if getElevage(Joueur).construction = True then
    begin

      // Université
      if getUniversite(Joueur).construction = True then
      begin
        batiment := getUniversite(Joueur).nom;
        niveau   := getUniversite(Joueur).niveau + 1;
        palier   := getUniversite(Joueur).PALIERS[niveau];
      end;

      // Centre de recherches
      if getCDR(Joueur).construction = True then
      begin
        batiment := getCDR(Joueur).nom;
        niveau   := getCDR(Joueur).niveau + 1;
        palier   := getCDR(Joueur).PALIERS[niveau];
      end;

      // Laboratoire
      if getLaboratoire(Joueur).construction = True then
      begin
        batiment := getLaboratoire(Joueur).nom;
        niveau   := getLaboratoire(Joueur).niveau + 1;
        palier   := getLaboratoire(Joueur).PALIERS[niveau];
      end;

      // Enclos
      if getEnclos(Joueur).construction = True then
      begin
        batiment := getEnclos(Joueur).nom;
        niveau   := getEnclos(Joueur).niveau + 1;
        palier   := getEnclos(Joueur).PALIERS[niveau];
      end;

      // Bibliothèque
      if getBibliotheque(Joueur).construction = True then
      begin
        batiment := getBibliotheque(Joueur).nom;
        niveau   := getBibliotheque(Joueur).niveau + 1;
        palier   := getBibliotheque(Joueur).PALIERS[niveau];
      end;

      // Archives
      if getArchives(Joueur).construction = True then
      begin
        batiment := getArchives(Joueur).nom;
        niveau   := getArchives(Joueur).niveau + 1;
        palier   := getArchives(Joueur).PALIERS[niveau];
      end;


      { A partir des valeurs identifiées, on affiche le nom du bâtiment en construction
        et le niveau vers lequel il est amélioré ainsi que le total d'équations résolues
        et le nombre d'équations à résoudre pour en achever la construction. }

      deplacerCurseurXY(x,y+1);
      write('Construction : ', batiment, ' niveau ', niveau);
      deplacerCurseurXY(x,y+2);
      write('Équations résolues : ', getElevage(Joueur).equationsResolues, '/', palier);
    end

    // Dans le cas où aucune construction n'est en cours
    else
    begin
      deplacerCurseurXY(x,y+1);
      couleurTexte(8);
      write('Pas de construction en cours');
      couleurTexte(15);
    end;
  end;

  { Affiche l'état de la croissance de l'Elevage aux coordonnées (x,y) }
  procedure afficherCroissance(Joueur : TJoueur ; x,y : Integer);
  begin
    // Dans tous les cas, on affiche le seuil de Savoir à acquir pour croître
    deplacerCurseurXY(x,y);
    write('Savoir acquis : ', getElevage(Joueur).savoirAcquis, '/', getElevage(Joueur).seuilCroissance);

    { S'il y a croissance, on affiche le savoir ajouté à chaque jour et le nombre
      de jours restant avant la croissance (gain de population) de l'élevage. }
    if getElevage(Joueur).savoirJour > 0 then
    begin
      deplacerCurseurXY(x,y+1);
      write('Savoir par jour : ');
      couleurTexte(10);
      write(getElevage(Joueur).savoirJour);
      couleurTexte(15);
      deplacerCurseurXY(x,y+2);
      write('Nb jours avant croissance : ', getElevage(Joueur).nbJourAvCroissance)
    end

    // S'il n'y aucune croissance, on le signale
    else
    begin
      deplacerCurseurXY(x,y+1);
      couleurTexte(8);
      write('Aucune croissance');
      couleurTexte(15);
    end;
  end;

  { Affiche un cadre résumant l'état de l'Elevage aux coordonnées (x,y) }
  procedure afficherElevage(Joueur : TJoueur ; x,y : Integer);

  begin
    // Dessin du cadre
    dessinerCadreXY(2,y-1, 117,y+3, simple, 15,0);

    // Affichage du nom de l'élevage
    deplacerCurseurXY(x,y);
    write('Nom : ');
    couleurTexte(11);
    write(getElevage(Joueur).nom);
    couleurtexte(15);

    // Affichage de sa population
    deplacerCurseurXY(x,y+1);
    writeln('Population : ', getElevage(Joueur).population);

    // Affichage du bonheur
    deplacerCurseurXY(x,y+2);
    write('Bonheur : ');
    if getElevage(Joueur).facteurBonheur <= 0.70 then couleurTexte(14);
    if getElevage(Joueur).facteurBonheur <= 0.30 then couleurTexte(12)
    else CouleurTexte(10);
    write(round(getElevage(Joueur).facteurBonheur*100),'%');
    couleurTexte(15);

    // Affichage de l'état de sa croissance
    afficherCroissance(Joueur, x+30,y);

    // Affichage de l'état de la construction en cours
    afficherConstruction(Joueur, x+68,y);
  end;

end.
