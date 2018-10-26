program Main;

{ Programme développé par Ange Pagel }

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  GestionEcran in 'GestionEcran.pas',
  Variables in 'Variables.pas',
  OptnAffichage in 'OptnAffichage.pas',
  EcranAccueil in 'EcranAccueil.pas',
  EcranTribu in 'EcranTribu.pas',
  EcranElevage in 'EcranElevage.pas',
  EcranMilitaire in 'EcranMilitaire.pas',
  EcranCombat in 'EcranCombat.pas',
  EcranGrimoire in 'EcranGrimoire.pas';

procedure ecranTitre;

  var
    x      : Integer; // Coordonnée x d'origine du dessin
    espace : String;  // Espace séparant chaque figure géométrique

  begin
    // Initialisation des variables de travail
    espace := ' ';
    x := 32;

    { Fonctionne par pas de 2 'manuel', d'où le while plutôt qu'un for }
    while x >= 14 do
    begin

      // Changement de la couleur des figures au fur et à mesure de la progression de l'animation
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
    deplacerCurseurXY(13,10);
    writeln(' ██████╗██╗██╗   ██╗██╗██╗     ██╗███████╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗     ██████╗');
    attendre(40);
    deplacerCurseurXY(13,11);
    writeln('██╔════╝██║██║   ██║██║██║     ██║╚══███╔╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║    ██╔═████╗');
    attendre(40);
    deplacerCurseurXY(13,12);
    writeln('██║     ██║██║   ██║██║██║     ██║  ███╔╝ ███████║   ██║   ██║██║   ██║██╔██╗ ██║    ██║██╔██║');
    attendre(40);
    deplacerCurseurXY(13,13);
    writeln('██║     ██║╚██╗ ██╔╝██║██║     ██║ ███╔╝  ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║    ████╔╝██║');
    attendre(40);
    deplacerCurseurXY(13,14);
    writeln('╚██████╗██║ ╚████╔╝ ██║███████╗██║███████╗██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║    ╚██████╔╝');
    attendre(40);
    deplacerCurseurXY(13,15);
    writeln(' ╚═════╝╚═╝  ╚═══╝  ╚═╝╚══════╝╚═╝╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝     ╚═════╝ ');


    // Le joueur appuie sur ENTRER et l'écran d'accueil s'affiche
    dessinerCadreXY(41,26, 77,28, simple, 15,0);
    deplacerCurseurXY(43,27);
    writeln('Appuyez sur ENTRER pour continuer');
    deplacerCurseurXY(76,27);
    readln;
    EcranAccueil.afficher;
  end;

begin

  initJoueur(Joueur1);
  initJoueur(Joueur2);

  couleurTexte(15);
  ecranTitre();

end.

