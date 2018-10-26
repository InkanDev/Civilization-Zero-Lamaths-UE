unit EcranGrimoire;

interface

  { Affiche l'index du Grimoire }
  procedure afficherGrimoire;



implementation

  uses OptnAffichage, GestionEcran, EcranAccueil;

  { Ces déclarations 'forward' sont nécessaires pour indiquer qu'on appelle les procédures
    suivantes avant leur déclaration dans le programme. }
  procedure afficherPage_Histoire; forward;
  procedure afficherPage_Histoire2; forward;
  procedure afficherPage_Ressources; forward;
  procedure afficherPage_Batiments; forward;
  procedure afficherPage_Unites; forward;


  { Automatise l'affichage du squelette d'une page de Grimoire }
  procedure afficherCorpsPage;

  var y : Integer; // Compteur associé à une coordonnée y

  begin
    dessinerCadreXY(1,2, 118,24, simple, 15,0);

    // Dessin de la séparation centrale
    for y := 5 to 22 do
    begin
      deplacerCurseurXY(59,y);
      writeln('.');
    end;

    // Affichage des choix disponibles (Navigation)
    dessinerCadreXY(2,26, 20,28, simple, 15,0);
    deplacerCurseurXY(6,27);
    writeln('0 - Retour');

    dessinerCadreXY(32,26, 58,28, simple, 15,0);
    deplacerCurseurXY(36,27);
    writeln('1 - Page précédente');

    dessinerCadreXY(60,26, 84,28, simple, 15,0);
    deplacerCurseurXY(64,27);
    writeln('2 - Page suivante');

    dessinerCadreXY(102,26, 117,28, simple, 15,0);
    deplacerCurseurXY(105,27);
    writeln('Action : ');
  end;


  { Affiche l'index du Grimoire }
  procedure afficherGrimoire;

  var choix : String; // Valeur entrée par la joueur

  begin
    effacerEcran();
    dessinerCadreXY(1,2, 118,24, simple, 15,0);
    afficherTitre('GRIMOIRE : Sommaire', 2);


    deplacerCurseurXY(11,6);
    write('───────────────────────────');
    deplacerCurseurXY(12,7);
    write('┌─┐┬ ┬┌─┐┌─┐┬┌┬┐┬─┐┌─┐┌─┐');
    deplacerCurseurXY(12,8);
    write('│  ├─┤├─┤├─┘│ │ ├┬┘├┤ └─┐');
    deplacerCurseurXY(12,9);
    write('└─┘┴ ┴┴ ┴┴  ┴ ┴ ┴└─└─┘└─┘');
    deplacerCurseurXY(11,10);
    write('───────────────────────────');

    afficherAction(16,12, '1', 'Histoire', 'vert');
    afficherAction(16,14, '2', 'Histoire (suite)', 'vert');
    afficherAction(16,16, '3', 'Ressources', 'vert');
    afficherAction(16,18, '4', 'Bâtiments', 'vert');
    afficherAction(16,20, '5', 'Unités', 'vert');



    deplacerCurseurXY(70,7);
    writeln('      _.--._  _.--._             ');
    deplacerCurseurXY(70,8);
    writeln(',-=.-":;:;:;\'':;:;:;"-._        ');
    deplacerCurseurXY(70,9);
    writeln('\\\:;:;:;:;:;\:;:;:;:;:;\        ');
    deplacerCurseurXY(70,10);
    writeln(' \\\:;:;:;:;:;\:;:;:;:;:;\       ');
    deplacerCurseurXY(70,11);
    writeln('  \\\:;:;:;:;:;\:;:;:;:;:;\      ');
    deplacerCurseurXY(70,12);
    writeln('   \\\:;:;:;:;:;\:;::;:;:;:\     ');
    deplacerCurseurXY(70,13);
    writeln('    \\\;:;::;:;:;\:;:;:;::;:\    ');
    deplacerCurseurXY(70,14);
    writeln('     \\\;;:;:_:--:\:_:--:_;:;\   ');
    deplacerCurseurXY(70,15);
    writeln('      \\\_.-"      :      "-._\  ');
    deplacerCurseurXY(70,16);
    writeln('       \`_..--""--.;.--""--.._=> ');
    deplacerCurseurXY(70,17);
    writeln('        "                        ');

    deplacerCurseurXY(63,19);
    write('────────────────────────────────────────────────');
    deplacerCurseurXY(64,20);
    write('Bien plus qu''un simple manuel de mathématiques');
    deplacerCurseurXY(63,21);
    write('────────────────────────────────────────────────');


    dessinerCadreXY(2,26, 20,28, simple, 15,0);
    deplacerCurseurXY(6,27);
    write('0 - Retour');

    dessinerCadreXY(87,26, 117,28, simple, 15,0);
    deplacerCurseurXY(90,27);
    write('Consulter le chapitre : ');

    { Liste des choix disponibles }
    deplacerCurseurXY(114,27);
    readln(choix);
    if (choix = '0') then EcranAccueil.afficher();
    if (choix = '1') then afficherPage_Histoire();
    if (choix = '2') then afficherPage_Histoire2();
    if (choix = '3') then afficherPage_Ressources();
    if (choix = '4') then afficherPage_Batiments();
    if (choix = '5') then afficherPage_Unites()
    else
    begin
      setMessage('Action non reconnue');
      afficherGrimoire();
    end;
  end;


  { Affiche la page du Guide concernant l'histoire du jeu }
  procedure afficherPage_Histoire;

  var choix : String; // Valeur entrée par la joueur

  begin
    effacerEcran();
    afficherCorpsPage;
    afficherTitre('GRIMOIRE : Histoire', 2);

    deplacerCurseurXY(4,7);
    write('LES ORIGINES');
    couleurTexte(8);

    deplacerCurseurXY(6,9);
    write('En 2042, les progrès de l''informatique quantique');
    deplacerCurseurXY(6,10);
    write('rendent possible une application de l''expérience');
    deplacerCurseurXY(6,11);
    write('du chat de Simönger... avec un Lama.');

    deplacerCurseurXY(6,13);
    write('Mais un chat curieux perturba l''expérience ');
    deplacerCurseurXY(6,14);
    write('et provoqua une intrication quantique incontrôlée.');

    deplacerCurseurXY(6,16);
    write('Cet incident créa un nouvel état quantique de notre');
    deplacerCurseurXY(6,17);
    write('monde dans lequel les Lamas et ses cousins camélidés');
    deplacerCurseurXY(6,18);
    write('détiennent tout le savoir de l''humanité.');
    couleurTexte(15);



    deplacerCurseurXY(63,7);
    write('UN NOUVEAU MONDE');
    couleurTexte(8);

    deplacerCurseurXY(65,9);
    write('Dans cet univers parallèle, les Lamas se regroupent');
    deplacerCurseurXY(65,10);
    write('en Tribus et vivent une vie prospère dans des');
    deplacerCurseurXY(65,11);
    writeln('élevages.');

    deplacerCurseurXY(65,13);
    write('Chaque Tribu possède un domaine de prédilection,');
    deplacerCurseurXY(65,14);
    write('une compétence qui définit sa structure');
    deplacerCurseurXY(65,15);
    write('fondamentale ; il s''agit de son archétype.');
    couleurTexte(15);


    { Déplace le curseur dans le cadre "Action" }
    deplacerCurseurXY(114,27);
    readln(choix);

    { Liste des choix disponibles }
    if (choix = '0') then afficherGrimoire();
    if (choix = '1') then afficherPage_Unites();
    if (choix = '2') then afficherPage_Histoire2()

    { Valeur saisie invalide }
    else afficherPage_Histoire();

  end;

  { Affiche la page du Guide concernant l'histoire du jeu }
  procedure afficherPage_Histoire2;

  var choix : String; // Valeur entrée par la joueur

  begin
    effacerEcran();
    afficherCorpsPage;
    afficherTitre('GRIMOIRE : Histoire (suite)', 2);


    deplacerCurseurXY(4,7);
    write('LA GRANDE GUERRE');
    couleurTexte(8);

    deplacerCurseurXY(6,9);
    write('Néanmoins un conflit millénaire avait survécu à');
    deplacerCurseurXY(6,10);
    write('l''expérience : celui qui oppose les scientifiques');
    deplacerCurseurXY(6,11);
    write('aux littéraires.');

    deplacerCurseurXY(6,13);
    write('Aujourd''hui encore, les scientifiques et les');
    deplacerCurseurXY(6,14);
    write('littéraires se livrent une guerre sans merci et');
    deplacerCurseurXY(6,15);
    write('se disputent le contrôle de pâturages verdoyants.');
    couleurTexte(15);


    deplacerCurseurXY(63,7);
    write('DÉNOUEMENT');
    couleurTexte(8);

    deplacerCurseurXY(65,9);
    write('Mais ce monde est au bord du chaos, la guerre');
    deplacerCurseurXY(65,10);
    write('doit toucher à sa fin et la cohabitation n''est');
    deplacerCurseurXY(65,11);
    write('pas une solution. (Les algébristes ont pourtant');
    deplacerCurseurXY(65,12);
    write('tenté un pivot de Gauss)');

    deplacerCurseurXY(65,14);
    write('Civilization Zero : Lamaths Edition vous propulse à');
    deplacerCurseurXY(65,15);
    write('la tête d''une Tribu de Lamas mathématiciens, et');
    deplacerCurseurXY(65,16);
    write('c''est à vous de mener la bataille finale.');
    couleurTexte(15);

    deplacerCurseurXY(64,19);
    write('──────────────────────────────────────────────────');
    deplacerCurseurXY(65,20);
    write('Le destin des mathématiques est entre vos mains.');
    deplacerCurseurXY(64,21);
    write('──────────────────────────────────────────────────');




    { Déplace le curseur dans le cadre "Action" }
    deplacerCurseurXY(114,27);
    readln(choix);

    { Liste des choix disponibles }
    if (choix = '0') then afficherGrimoire();
    if (choix = '1') then afficherPage_Histoire();
    if (choix = '2') then afficherPage_Ressources()

    { Valeur saisie invalide }
    else afficherPage_Histoire();

  end;

  { Affiche la page du Guide concernant les ressources }
  procedure afficherPage_Ressources;

  var choix : String; // Valeur entrée par la joueur

  begin
    effacerEcran();
    afficherCorpsPage;
    afficherTitre('GRIMOIRE : Ressources', 2);

    // Savoir
    deplacerCurseurXY(4,7);
    writeln('SAVOIR');
    couleurTexte(8);
    deplacerCurseurXY(6,8);
    writeln('Les camélidés mathématiciens se nourissent');
    deplacerCurseurXY(6,9);
    writeln('de savoir et d''eau fraîche. Le savoir');
    deplacerCurseurXY(6,10);
    writeln('permet de faire croître l''élevage et');
    deplacerCurseurXY(6,11);
    writeln('d''augmenter sa population.');
    couleurTexte(15);

    // Équations
    deplacerCurseurXY(4,14);
    writeln('ÉQUATIONS');
    couleurTexte(8);
    deplacerCurseurXY(6,15);
    writeln('C''est en résolvant des équations complexes');
    deplacerCurseurXY(6,16);
    writeln('que les camélidés mathématiciens construisent');
    deplacerCurseurXY(6,17);
    writeln('leurs bâtiments. Résoudre des équations permet');
    deplacerCurseurXY(6,18);
    writeln('de construire et d''améliorer vos bâtiments.');
    couleurTexte(15);

    // Points de recrutement
    deplacerCurseurXY(63,7);
    writeln('PTS DE RECRUTEMENT');
    couleurTexte(8);
    deplacerCurseurXY(65,8);
    writeln('Les points de recrutement vous serviront à recruter');
    deplacerCurseurXY(65,9);
    writeln('divers camélidés dans votre armée.');
    couleurTexte(15);

    // Bonheur
    deplacerCurseurXY(63,12);
    writeln('BONHEUR');
    couleurTexte(8);
    deplacerCurseurXY(65,13);
    writeln('Généré par le Parc, le bonheur est indispensable à');
    deplacerCurseurXY(65,14);
    writeln('la croissance de votre élevage. Un lama heureux est');
    deplacerCurseurXY(65,15);
    writeln('un lama productif !');
    couleurTexte(15);

    { Déplace le curseur dans le cadre "Action" }
    deplacerCurseurXY(114,27);
    readln(choix);

    { Liste des choix disponibles }
    if (choix = '0') then afficherGrimoire();
    if (choix = '1') then afficherPage_Histoire2();
    if (choix = '2') then afficherPage_Batiments()

    { Valeur saisie invalide }
    else afficherPage_Ressources();

  end;

  { Affiche la page du Guide concernant les bâtiments }
  procedure afficherPage_Batiments;

  var choix : String; // Valeur entrée par la joueur

  begin
    effacerEcran();
    afficherCorpsPage;
    afficherTitre('GRIMOIRE : Bâtiments', 2);

    // Université
    deplacerCurseurXY(4,7);
    writeln('UNIVERSITÉ');
    couleurTexte(8);
    deplacerCurseurXY(6,8);
    writeln('Lieu d''aprentissage, l''Université sert');
    deplacerCurseurXY(6,9);
    writeln('à accroître le savoir acquis chaque jour.');
    couleurTexte(15);

    // Centre de recherches
    deplacerCurseurXY(4,12);
    writeln('CENTRE DE RECHERCHES');
    couleurTexte(8);
    deplacerCurseurXY(6,13);
    writeln('Le Centre de recherches (CDR) permet');
    deplacerCurseurXY(6,14);
    writeln('d''augmenter le nombre d''équations résolues');
    deplacerCurseurXY(6,15);
    writeln('chaque jour et de débloquer de nouvelles unités.');
    couleurTexte(15);

    // Laboratoire
    deplacerCurseurXY(4,18);
    writeln('LABORATOIRE');
    couleurTexte(8);
    deplacerCurseurXY(6,19);
    writeln('Coeur de votre élevage savant, le Laboratoire');
    deplacerCurseurXY(6,20);
    writeln('entraîne vos camélidés à résoudre davantage');
    deplacerCurseurXY(6,21);
    writeln('d''équations par jour.');
    couleurTexte(15);

    // Enclos
    deplacerCurseurXY(63,7);
    writeln('ENCLOS');
    couleurTexte(8);
    deplacerCurseurXY(65,8);
    writeln('Un espace vert et paisible où vos unités peuvent');
    deplacerCurseurXY(65,9);
    writeln('se reposer avant le combat. Génère des points de');
    deplacerCurseurXY(65,10);
    writeln('recrutement.');
    couleurTexte(15);

    // Bibliothèque
    deplacerCurseurXY(63,13);
    writeln('BIBLIOTHEQUE');
    couleurTexte(8);
    deplacerCurseurXY(65,14);
    writeln('Le calme et la concentration sont rois au sein de');
    deplacerCurseurXY(65,15);
    writeln('la Bibliothèque. Cet espace de travail contribue');
    deplacerCurseurXY(65,16);
    writeln('au bonheur de votre population.');
    couleurTexte(15);

    // Archives
    deplacerCurseurXY(63,19);
    writeln('ARCHIVES');
    couleurTexte(8);
    deplacerCurseurXY(65,20);
    writeln('Les Archives assurent la pérennité de vos');
    deplacerCurseurXY(65,21);
    writeln('recherches et augmentent le nombre de défaites');
    deplacerCurseurXY(65,22);
    writeln('que votre Tribu peut encaisser.');
    couleurTexte(15);


    { Déplace le curseur dans le cadre "Action" }
    deplacerCurseurXY(114,27);
    readln(choix);

    { Liste des choix disponibles }
    if (choix = '0') then afficherGrimoire();
    if (choix = '1') then afficherPage_Ressources();
    if (choix = '2') then afficherPage_Unites()

    { Valeur saisie invalide }
    else afficherPage_Batiments();

  end;

  { Affiche la page du Guide concernant les unités }
  procedure afficherPage_Unites;

  var choix : String; // Valeur entrée par la joueur

  begin
    effacerEcran();


    afficherCorpsPage;
    afficherTitre('GRIMOIRE : Unités', 2);


    // Lama
    deplacerCurseurXY(4,7);
    writeln('LAMA');
    couleurTexte(8);
    deplacerCurseurXY(6,8);
    writeln('Le Lama est un camélidé domestique originaire');
    deplacerCurseurXY(6,9);
    writeln('d''Amérique du Sud. Il vaut 1 point d''attaque');
    deplacerCurseurXY(6,10);
    writeln('et le recruter ne vous coûtera qu''1 point.');
    couleurTexte(15);

    // Alpaga
    deplacerCurseurXY(4,13);
    writeln('ALPAGA');
    couleurTexte(8);
    deplacerCurseurXY(6,14);
    writeln('Derrière cette boule de laine se cache un');
    deplacerCurseurXY(6,15);
    writeln('soldat sans pitié. Construisez un Centre de');
    deplacerCurseurXY(6,16);
    writeln('recherches niv.1 et dépensez 2 pts de recrutement');
    deplacerCurseurXY(6,17);
    writeln('pour profiter de ses 2 points d''attaque.');
    couleurTexte(15);

    // Guanaco
    deplacerCurseurXY(63,7);
    writeln('GUANACO');
    couleurTexte(8);
    deplacerCurseurXY(65,8);
    writeln('Parent sauvage du Lama, le Guanaco est un ');
    deplacerCurseurXY(65,9);
    writeln('véritable berserker et anéantira vos ennemis');
    deplacerCurseurXY(65,10);
    writeln('sur le champ de bataille. Profiter de ses 4 pts');
    deplacerCurseurXY(65,11);
    writeln('d''attaque requiert un Centre de recherches niv 2');
    deplacerCurseurXY(65,12);
    writeln('et 3 points de recrutement.');
    couleurTexte(15);


    { Déplace le curseur dans le cadre "Action" }
    deplacerCurseurXY(114,27);
    readln(choix);

    { Liste des choix disponibles }
    if (choix = '0') then afficherGrimoire();
    if (choix = '1') then afficherPage_Batiments();
    if (choix = '2') then afficherPage_Histoire()

    { Valeur saisie invalide }
    else afficherPage_Unites();

  end;

end.
