unit Variables;

interface

  type

  TJoueur = (Joueur1,Joueur2);

  { Représente une Tribu (Civilisation) et ses caractéristiques }
  TTribu = record
    nom        : String;  // Nom de la Tribu
    numJour    : Integer; // Numéro du Jour (Tour)
    niveauMax  : Integer; // Niveau maximum que peuvent atteindre les bâtiments des élevages la Tribu

    archetype  : String; // Archétype de la Tribu
    difficulte : String; // Difficulté du jeu, propre à la Tribu du joueur

    victoires   : Integer;   // Nombres de victoires en combat
    defaites    : Integer;   // Nombre de défaites en combat
    limDefaites : Integer; // Limite de défaites que peut encaisser le joueur avant de perdre la partie

    ptsRecrutement     : Integer; // Points de recrutement dont dispose le joueur
    ptsRecrutementJour : Integer; // Points de recrutement dont dispose le joueur par jour
  end;

  { Représente un Elevage (Ville) et ses caractéristiques }
  TElevage = record
    nom          : String;   // Nom de l'élevage
    population   : Integer;  // Population totale de l'élevage
    construction : Boolean ; // Etat de construction de l'élevage

    bonheur        : Integer; // 'Points' de bonheur de l'élevage
    facteurBonheur : Real;    // Facteur calculé en fonction du bonheur et de la population

    savoirJourAbsolu : Integer; // Valeur absolue du savoir acquis chaque jour
    savoirJour       : Integer; // Valeur réelle du savoir acquis chaque jour (- la population)
    savoirAcquis     : Integer; // Savoir total acquis pendant la phase de croissance

    facteurCroissance  : Integer; // Facteur intervenant dans le calcul du seuilCroissance
    seuilCroissance    : Integer; // Savoir à acquérir pour croître (+1 population)
    nbJourAvCroissance : Integer; // Nb de jours restant avant de croître

    equationsJour     : Integer; // Nb d'équations résolues par jour
    equationsResolues : Integer; // Nb total d'équations résolues pendant la phase de construction
  end;

  { Représente un bâtiment et ses caractéristiques }
  TBatiment = record
    nom          : String;    // Nom du bâtiment
    niveau       : Integer;   // Niveau du bâtiment
    construction : Boolean;   // Etat de construction du bâtiment
    PALIERS      : Array[0..3] of Integer;  // Paliers de construction/amélioration à atteindre
    BONUS        : Array[0..3] of Integer;  // Bonus apportés par le bâtiment
  end;

  { Représente une unité de combat et ses caractéristiques }
  TUnite = record
    nom        : String;  // Nom de l'unité
    nb         : Integer; // Nombre d'éléments de l'unité
    ptsAttaque : Integer; // Pts d'attaque que vaut une unité
    prix       : Integer; // Pts à dépenser pour acquérir une unité
  end;



  { FONCTIONS & PROCEDURES }
    { Les GETTERS sont utilisés afin de récupérer l'information d'une entité locale depuis une autre unité. }
    { Les SETTERS sont utilisés afin de modifier une entité locale depuis d'une autre unité. }


  // MULTIJOUEUR
    { Get }
    function getMultijoueur : Boolean;
    { Set }
    procedure setMultijoueur(boolMultijoueur : Boolean);


  // TRIBU
    { Get }
      function getTribu(Joueur : TJoueur) : TTribu;
    { Set }
      procedure setTribu_nom                (Joueur : TJoueur ; nom : String);
      procedure setTribu_numJour            (Joueur : TJoueur ; numJour : Integer);
      procedure setTribu_archetype          (Joueur : TJoueur ; archetype : String);
      procedure setTribu_difficulte         (Joueur : TJoueur ; difficulte : String);
      procedure setTribu_niveauMax          (Joueur : TJoueur ; niveauMax : Integer);
      procedure setTribu_victoires          (Joueur : TJoueur ; victoires : Integer);
      procedure setTribu_defaites           (Joueur : TJoueur ; defaites : Integer);
      procedure setTribu_limDefaites        (Joueur : TJoueur ; limDefaites : Integer);
      procedure setTribu_ptsRecrutement     (Joueur : TJoueur ; ptsRecrutement : Integer);
      procedure setTribu_ptsRecrutementJour (Joueur : TJoueur ; ptsRecrutementJour : Integer);


  // ELEVAGE
    { Get }
      function getElevage(Joueur : TJoueur) : TElevage;
    { Set }
      procedure setElevage_nom                (Joueur : TJoueur ; nom : String);
      procedure setElevage_population         (Joueur : TJoueur ; population : Integer);
      procedure setElevage_construction       (Joueur : TJoueur ; construction : Boolean);
      procedure setElevage_bonheur            (Joueur : TJoueur ; bonheur : Integer);
      procedure setElevage_facteurBonheur     (Joueur : TJoueur ; facteurBonheur : Real);
      procedure setElevage_savoirJourAbsolu   (Joueur : TJoueur ; savoirJourAbsolu : Integer);
      procedure setElevage_savoirJour         (Joueur : TJoueur ; savoirJour : Integer);
      procedure setElevage_savoirAcquis       (Joueur : TJoueur ; savoirAcquis : Integer);
      procedure setElevage_facteurCroissance  (Joueur : TJoueur ; facteurCroissance : Integer);
      procedure setElevage_seuilCroissance    (Joueur : TJoueur ; seuilCroissance : Integer);
      procedure setElevage_nbJourAvCroissance (Joueur : TJoueur ; nbJourAvCroissance : Integer);
      procedure setElevage_equationsJour      (Joueur : TJoueur ; equationsJour : Integer);
      procedure setElevage_equationsResolues  (Joueur : TJoueur ; equationsResolues : Integer);


  // UNIVERSITE
    { Get }
      function getUniversite(Joueur : TJoueur) : TBatiment;
    { Set }
      procedure setUniversite_niveau       (Joueur : TJoueur ; niveau : Integer);
      procedure setUniversite_construction (Joueur : TJoueur ; construction : Boolean);

  // CENTRE DE RECHERCHES
    { Get }
      function getCDR(Joueur : TJoueur) : TBatiment;
    { Set }
      procedure setCDR_niveau       (Joueur : TJoueur ; niveau : Integer);
      procedure setCDR_construction (Joueur : TJoueur ; construction : Boolean);

  // LABORATOIRE
    { Get }
      function getLaboratoire(Joueur : TJoueur) : TBatiment;
    { Set }
      procedure setLaboratoire_niveau       (Joueur : TJoueur ; niveau : Integer);
      procedure setLaboratoire_construction (Joueur : TJoueur ; construction : Boolean);

  // ENCLOS
    { Get }
      function getEnclos(Joueur : TJoueur) : TBatiment;
    { Set }
      procedure setEnclos_niveau       (Joueur : TJoueur ; niveau : Integer);
      procedure setEnclos_construction (Joueur : TJoueur ; construction : Boolean);

  // BIBLIOHÈQUE
    { Get }
      function getBibliotheque(Joueur : TJoueur) : TBatiment;
    { Set }
      procedure setBibliotheque_niveau       (Joueur : TJoueur ; niveau : Integer);
      procedure setBibliotheque_construction (Joueur : TJoueur ; construction : Boolean);

  // ARCHIVES
    { Get }
      function getArchives(Joueur : TJoueur) : TBatiment;
    { Set }
      procedure setArchives_niveau       (Joueur : TJoueur ; niveau : Integer);
      procedure setArchives_construction (Joueur : TJoueur ; construction : Boolean);


  // LAMA
    { Get }
      function getLama(Joueur : TJoueur) : TUnite;
    { Set }
      procedure setLama_nb(Joueur : TJoueur ; nb : Integer);

  // ALPAGA
    { Get }
      function getAlpaga(Joueur : TJoueur) : TUnite;
    { Set }
      procedure setAlpaga_nb(Joueur : TJoueur ; nb : Integer);

  // GUANACO
    { Get }
      function getGuanaco(Joueur : TJoueur) : TUnite;
    { Set }
      procedure setGuanaco_nb(Joueur : TJoueur ; nb : Integer);



  { INITIALISATION DU JOUEUR }
    procedure initJoueur(Joueur : TJoueur);



  { ARCHETYPE & DIFFICULTE }
    { Les procédues suivantes modifient certaines propriétés en fonction
      de l'archétype de Tribu et de la difficulté choisis par le joueur. }

    // Applique les changements liés à l'archétype de la Tribu
    procedure appliquerArchetype(Joueur : TJoueur);

    // Applique les changements liés à la difficulté de la partie
      { ATTENTION : La difficulté influe aussi sur le nb d'unités présentes dans les pâturages ennemis.
        Se référer à la procédure genererEnnemis() de l'unit EcranCombat. }
    procedure appliquerDifficulte(Joueur : TJoueur);






implementation

  var

     Multijoueur : Boolean; // FALSE : 1 Joueur, TRUE : 2 Joueurs


    { Création des principales entités du jeu }

    { JOUEUR 1 }

      Tribu : TTribu; // Tribu (Civilisation)
      Elevage : TElevage; // Elevage (Ville)
      Universite   : TBatiment; // Bâtiment UNIVERSITE (Ferme)
      CDR          : TBatiment; // Bâtiment CENTRE DE RECHERCHES (Mine)
      Laboratoire  : TBatiment; // Bâtiment LABORATOIRE (Carrière)
      Enclos       : TBatiment; // Bâtiment ENCLOS (Caserne)
      Bibliotheque : TBatiment; // Bâtiment BIBLIOTHÈQUE (Parc *amélioration*)
      Archives     : TBatiment; // Bâtiment ARCHIVES *amélioration personnelle*
      Lama    : TUnite; // Unité LAMA (Soldat)
      Alpaga  : TUnite; // Unité ALPAGA (Canon)
      Guanaco : TUnite; // Unité GUANACO (Cavalier)


    { JOUEUR 2 }

      Tribu2 : TTribu; // Tribu (Civilisation)
      Elevage2 : TElevage; // Elevage (Ville)
      Universite2   : TBatiment; // Bâtiment UNIVERSITE (Ferme)
      CDR2          : TBatiment; // Bâtiment CENTRE DE RECHERCHES (Mine)
      Laboratoire2  : TBatiment; // Bâtiment LABORATOIRE (Carrière)
      Enclos2       : TBatiment; // Bâtiment ENCLOS (Caserne)
      Bibliotheque2 : TBatiment; // Bâtiment BIBLIOTHÈQUE (Parc *amélioration*)
      Archives2     : TBatiment; // Bâtiment ARCHIVES *amélioration personnelle*
      Lama2    : TUnite; // Unité LAMA (Soldat)
      Alpaga2  : TUnite; // Unité ALPAGA (Canon)
      Guanaco2 : TUnite; // Unité GUANACO (Cavalier)



  { FONCTIONS & PROCEDURES }
    { Les GETTERS sont utilisés afin de récupérer l'information d'une entité locale depuis une autre unité. }
    { Les SETTERS sont utilisés afin de modifier une entité locale depuis d'une autre unité. }


  // MULTIJOUEUR
    { Get }
    function getMultijoueur : Boolean;
    begin
      getMultijoueur := Multijoueur;
    end;
    { Set }
    procedure setMultijoueur(boolMultijoueur : Boolean);
    begin
      Multijoueur := boolMultijoueur;
    end;


  // TRIBU
    { Get }
      function getTribu(Joueur : TJoueur) : TTribu;
      begin
        if Joueur = Joueur1 then getTribu := Tribu
        else if Joueur = Joueur2 then getTribu := Tribu2;

      end;
    { Set }
      procedure setTribu_nom                (Joueur : TJoueur ; nom : String);
      begin
        if Joueur = Joueur1 then Tribu.nom := nom
        else if Joueur = Joueur2 then Tribu2.nom := nom;
      end;
      procedure setTribu_numJour            (Joueur : TJoueur ; numJour : Integer);
      begin
        if Joueur = Joueur1 then Tribu.numJour := numjour
        else if Joueur = Joueur2 then Tribu2.numJour := numJour;
      end;
      procedure setTribu_niveauMax          (Joueur : TJoueur ; niveauMax : Integer);
      begin
        if Joueur = Joueur1 then Tribu.niveauMax := niveauMax
        else if Joueur = Joueur2 then Tribu2.niveauMax := niveauMax;
      end;
      procedure setTribu_archetype          (Joueur : TJoueur ; archetype : String);
      begin
        if Joueur = Joueur1 then Tribu.archetype := archetype
        else if Joueur = Joueur2 then Tribu2.archetype := archetype;
      end;
      procedure setTribu_difficulte         (Joueur : TJoueur ; difficulte : String);
      begin
        if Joueur = Joueur1 then Tribu.difficulte := difficulte
        else if Joueur = Joueur2 then Tribu2.difficulte := difficulte;
      end;
      procedure setTribu_victoires          (Joueur : TJoueur ; victoires : Integer);
      begin
        if Joueur = Joueur1 then Tribu.victoires := victoires
        else if Joueur = Joueur2 then Tribu2.victoires := victoires;
      end;
      procedure setTribu_defaites           (Joueur : TJoueur ; defaites : Integer);
      begin
        if Joueur = Joueur1 then Tribu.defaites := defaites
        else if Joueur = Joueur2 then Tribu2.defaites := defaites;
      end;
      procedure setTribu_limDefaites        (Joueur : TJoueur ; limDefaites : Integer);
      begin
        if Joueur = Joueur1 then Tribu.limDefaites := limDefaites
        else if Joueur = Joueur2 then Tribu2.limDefaites := limDefaites;
      end;
      procedure setTribu_ptsRecrutement     (Joueur : TJoueur ; ptsRecrutement : Integer);
      begin
        if Joueur = Joueur1 then Tribu.ptsRecrutement := ptsRecrutement
        else if Joueur = Joueur2 then Tribu2.ptsRecrutement := ptsRecrutement;
      end;
      procedure setTribu_ptsRecrutementJour (Joueur : TJoueur ; ptsRecrutementJour : Integer);
      begin
        if Joueur = Joueur1 then Tribu.ptsRecrutementJour := ptsRecrutementJour
        else if Joueur = Joueur2 then Tribu2.ptsRecrutementJour := ptsRecrutementJour;
      end;


  // ELEVAGE
    { Get }
      function getElevage(Joueur : TJoueur) : TElevage;
      begin
        if Joueur = Joueur1 then getElevage := Elevage
        else if Joueur = Joueur2 then getElevage := Elevage2;
      end;
    { Set }
      procedure setElevage_nom                (Joueur : TJoueur ; nom : String);
      begin
        if Joueur = Joueur1 then Elevage.nom := nom
        else if Joueur = Joueur2 then Elevage2.nom := nom;
      end;
      procedure setElevage_population         (Joueur : TJoueur ; population : Integer);
      begin
        if Joueur = Joueur1 then Elevage.population := population
        else if Joueur = Joueur2 then Elevage2.population := population;
      end;
      procedure setElevage_construction       (Joueur : TJoueur ; construction : Boolean);
      begin
        if Joueur = Joueur1 then Elevage.construction := construction
        else if Joueur = Joueur2 then Elevage2.construction := construction;
      end;
      procedure setElevage_bonheur            (Joueur : TJoueur ; bonheur : Integer);
      begin
        if Joueur = Joueur1 then Elevage.bonheur := bonheur
        else if Joueur = Joueur2 then Elevage2.bonheur := bonheur;
      end;
      procedure setElevage_facteurBonheur     (Joueur : TJoueur ; facteurBonheur : Real);
      begin
        if Joueur = Joueur1 then Elevage.facteurBonheur := facteurBonheur
        else if Joueur = Joueur2 then Elevage2.facteurBonheur := facteurBonheur;
      end;
      procedure setElevage_savoirJourAbsolu   (Joueur : TJoueur ; savoirJourAbsolu : Integer);
      begin
        if Joueur = Joueur1 then Elevage.savoirJourAbsolu := savoirJourAbsolu
        else if Joueur = Joueur2 then Elevage2.savoirJourAbsolu := savoirJourAbsolu;
      end;
      procedure setElevage_savoirJour         (Joueur : TJoueur ; savoirJour : Integer);
      begin
        if Joueur = Joueur1 then Elevage.savoirJour := savoirJour
        else if Joueur = Joueur2 then Elevage2.savoirJour := savoirJour;
      end;
      procedure setElevage_savoirAcquis       (Joueur : TJoueur ; savoirAcquis : Integer);
      begin
        if Joueur = Joueur1 then Elevage.savoirAcquis := savoirAcquis
        else if Joueur = Joueur2 then Elevage2.savoirAcquis := savoirAcquis;
      end;
      procedure setElevage_facteurCroissance  (Joueur : TJoueur ; facteurCroissance : Integer);
      begin
        if Joueur = Joueur1 then Elevage.facteurCroissance := facteurCroissance
        else if Joueur = Joueur2 then Elevage2.facteurCroissance := facteurCroissance;
      end;
      procedure setElevage_seuilCroissance    (Joueur : TJoueur ; seuilCroissance : Integer);
      begin
        if Joueur = Joueur1 then Elevage.seuilCroissance := seuilCroissance
        else if Joueur = Joueur2 then Elevage2.seuilCroissance := seuilCroissance;
      end;
      procedure setElevage_nbJourAvCroissance (Joueur : TJoueur ; nbJourAvCroissance : Integer);
      begin
        if Joueur = Joueur1 then Elevage.nbJourAvCroissance := nbJourAvCroissance
        else if Joueur = Joueur2 then Elevage2.nbJourAvCroissance := nbJourAvCroissance;
      end;
      procedure setElevage_equationsJour      (Joueur : TJoueur ; equationsJour : Integer);
      begin
        if Joueur = Joueur1 then Elevage.equationsJour := equationsJour
        else if Joueur = Joueur2 then Elevage2.equationsJour := equationsJour;
      end;
      procedure setElevage_equationsResolues  (Joueur : TJoueur ; equationsResolues : Integer);
      begin
        if Joueur = Joueur1 then Elevage.equationsResolues := equationsResolues
        else if Joueur = Joueur2 then Elevage2.equationsResolues := equationsResolues;
      end;


  // UNIVERSITE
    { Get }
      function getUniversite(Joueur : TJoueur) : TBatiment;
      begin
        if Joueur = Joueur1 then getUniversite := Universite
        else if Joueur = Joueur2 then getUniversite := Universite2;
      end;
    { Set }
      procedure setUniversite_niveau       (Joueur : TJoueur ; niveau : Integer);
      begin
        if Joueur = Joueur1 then Universite.niveau := niveau
        else if Joueur = Joueur2 then Universite2.niveau := niveau;
      end;
      procedure setUniversite_construction (Joueur : TJoueur ; construction : Boolean);
      begin
        if Joueur = Joueur1 then Universite.construction := construction
        else if Joueur = Joueur2 then Universite2.construction := construction;
      end;

  // CENTRE DE RECHERCHES
    { Get }
      function getCDR(Joueur : TJoueur) : TBatiment;
      begin
        if Joueur = Joueur1 then getCDR := CDR
        else if Joueur = Joueur2 then
      end;
    { Set }
      procedure setCDR_niveau       (Joueur : TJoueur ; niveau : Integer);
      begin
        if Joueur = Joueur1 then CDR.niveau := niveau
        else if Joueur = Joueur2 then CDR2.niveau := niveau;
      end;
      procedure setCDR_construction (Joueur : TJoueur ; construction : Boolean);
      begin
        if Joueur = Joueur1 then CDR.construction := construction
        else if Joueur = Joueur2 then CDR2.construction := construction;
      end;

  // LABORATOIRE
    { Get }
      function getLaboratoire(Joueur : TJoueur) : TBatiment;
      begin
        if Joueur = Joueur1 then getLaboratoire := Laboratoire
        else if Joueur = Joueur2 then getLaboratoire := Laboratoire2;
      end;
    { Set }
      procedure setLaboratoire_niveau       (Joueur : TJoueur ; niveau : Integer);
      begin
        if Joueur = Joueur1 then Laboratoire.niveau := niveau
        else if Joueur = Joueur2 then Laboratoire2.niveau := niveau;
      end;
      procedure setLaboratoire_construction (Joueur : TJoueur ; construction : Boolean);
      begin
        if Joueur = Joueur1 then Laboratoire.construction := construction
        else if Joueur = Joueur2 then Laboratoire2.construction := construction;
      end;

  // ENCLOS
    { Get }
      function getEnclos(Joueur : TJoueur) : TBatiment;
      begin
        if Joueur = Joueur1 then getEnclos := Enclos
        else if Joueur = Joueur2 then getEnclos := Enclos2;
      end;
    { Set }
      procedure setEnclos_niveau       (Joueur : TJoueur ; niveau : Integer);
      begin
        if Joueur = Joueur1 then Enclos.niveau := niveau
        else if Joueur = Joueur2 then Enclos2.niveau := niveau;
      end;
      procedure setEnclos_construction (Joueur : TJoueur ; construction : Boolean);
      begin
        if Joueur = Joueur1 then Enclos.construction := construction
        else if Joueur = Joueur2 then Enclos2.construction := construction;
      end;

  // BIBLIOHÈQUE
    { Get }
      function getBibliotheque(Joueur : TJoueur) : TBatiment;
      begin
        if Joueur = Joueur1 then getBibliotheque := Bibliotheque
        else if Joueur = Joueur2 then getBibliotheque := Bibliotheque2;
      end;
    { Set }
      procedure setBibliotheque_niveau       (Joueur : TJoueur ; niveau : Integer);
      begin
        if Joueur = Joueur1 then Bibliotheque.niveau := niveau
        else if Joueur = Joueur2 then Bibliotheque2.niveau := niveau
      end;
      procedure setBibliotheque_construction (Joueur : TJoueur ; construction : Boolean);
      begin
        if Joueur = Joueur1 then Bibliotheque.construction := construction
        else if Joueur = Joueur2 then Bibliotheque2.construction := construction
      end;

  // ARCHIVES
    { Get }
      function getArchives(Joueur : TJoueur) : TBatiment;
      begin
        if Joueur = Joueur1 then getArchives := Archives
        else if Joueur = Joueur2 then getArchives := Archives2;
      end;
    { Set }
      procedure setArchives_niveau       (Joueur : TJoueur ; niveau : Integer);
      begin
        if Joueur = Joueur1 then Archives.niveau := niveau
        else if Joueur = Joueur2 then Archives2.niveau := niveau;
      end;
      procedure setArchives_construction (Joueur : TJoueur ; construction : Boolean);
      begin
        if Joueur = Joueur1 then Archives.construction := construction
        else if Joueur = Joueur2 then Archives2.construction := construction;
      end;


  // LAMA
    { Get }
      function getLama(Joueur : TJoueur) : TUnite;
      begin
        if Joueur = Joueur1 then getLama := Lama
        else if Joueur = Joueur2 then getLama := Lama2
      end;
    { Set }
      procedure setLama_nb(Joueur : TJoueur ; nb : Integer);
      begin
        if Joueur = Joueur1 then Lama.nb := nb
        else if Joueur = Joueur2 then Lama2.nb := nb;
      end;

  // ALPAGA
    { Get }
      function getAlpaga(Joueur : TJoueur) : TUnite;
      begin
        if Joueur = Joueur1 then getAlpaga := Alpaga
        else if Joueur = Joueur2 then getAlpaga := Alpaga2;
      end;
    { Set }
      procedure setAlpaga_nb(Joueur : TJoueur ; nb : Integer);
      begin
        if Joueur = Joueur1 then Alpaga.nb := nb
        else if Joueur = Joueur2 then Alpaga2.nb := nb;
      end;

  // GUANACO
    { Get }
      function getGuanaco(Joueur : TJoueur) : TUnite;
      begin
        if Joueur = Joueur1 then getGuanaco := Guanaco
        else if Joueur = Joueur2 then getGuanaco := Guanaco2;
      end;
    { Set }
      procedure setGuanaco_nb(Joueur : TJoueur ; nb : Integer);
      begin
        if Joueur = Joueur1 then Guanaco.nb := nb
        else if Joueur = Joueur2 then Guanaco2.nb := nb;
      end;




  { INITIALISATION DES VARIABLES }
    { Les procédures suivantes servent à initialiser les variables de jeu. }

    // TRIBU
      procedure initTribu(Joueur : TJoueur);
      begin
        if Joueur = Joueur1 then
        begin
          with Tribu do
          begin
            nom                := 'TribuParDefaut';
            numJour            := 1;
            niveaumax          := 3;

            archetype          := 'ArchetypeParDefaut';
            difficulte         := 'DifficulteParDefaut';

            victoires          := 0;
            defaites           := 0;
            limDefaites        := 4;

            ptsRecrutement     := 0;
            ptsRecrutementJour := 0;
          end;
        end

        else if Joueur = Joueur2 then
        begin
          with Tribu2 do
          begin
            nom                := 'TribuParDefaut';
            numJour            := 1;
            niveaumax          := 3;

            archetype          := 'ArchetypeParDefaut';
            difficulte         := 'DifficulteParDefaut';

            victoires          := 0;
            defaites           := 0;
            limDefaites        := 4;

            ptsRecrutement     := 0;
            ptsRecrutementJour := 0;
          end;
        end;
      end;

    // Elevage
      procedure initElevage(Joueur : TJoueur);
      begin
        if Joueur = Joueur1 then
        begin
          with Elevage do
          begin
            nom           := 'ElevageParDefaut';
            population    := 1;
            construction  := False;

            bonheur        := 1;
            facteurBonheur := 1 - population/10 + bonheur/10;

            savoirJourAbsolu := 20;
            savoirJour       := round( (savoirJourAbsolu - population*10) * facteurBonheur );
            savoirAcquis     := 0;

            facteurCroissance  := 100;
            seuilCroissance    := population * facteurCroissance;
            nbJourAvCroissance := seuilCroissance div savoirJour;

            equationsJour     := 20;
            equationsResolues := 0;
          end;
        end

        else if Joueur = Joueur2 then
        begin
          with Elevage2 do
          begin
            nom           := 'ElevageParDefaut';
            population    := 1;
            construction  := False;

            bonheur        := 1;
            facteurBonheur := 1 - population/10 + bonheur/10;

            savoirJourAbsolu := 20;
            savoirJour       := round( (savoirJourAbsolu - population*10) * facteurBonheur );
            savoirAcquis     := 0;

            facteurCroissance  := 100;
            seuilCroissance    := population * facteurCroissance;
            nbJourAvCroissance := seuilCroissance div savoirJour;

            equationsJour     := 20;
            equationsResolues := 0;
          end;
        end;
      end;

    // BATIMENTS
      { Université }
        procedure initUniversite(Joueur : TJoueur);
        begin
          if Joueur = Joueur1 then
          begin
            with Universite do
            begin
              nom          := 'Université';
              niveau       := 0;
              construction := False;

              PALIERS[0] := 0;
              PALIERS[1] := 400;
              PALIERS[2] := 1800;
              PALIERS[3] := 2800;

              BONUS[0] := 0;
              BONUS[1] := 20;
              BONUS[2] := 60;
              BONUS[3] := 90;
            end;
          end

          else if Joueur = Joueur2 then
          begin
            with Universite2 do
            begin
              nom          := 'Université';
              niveau       := 0;
              construction := False;

              PALIERS[0] := 0;
              PALIERS[1] := 400;
              PALIERS[2] := 1800;
              PALIERS[3] := 2800;

              BONUS[0] := 0;
              BONUS[1] := 20;
              BONUS[2] := 60;
              BONUS[3] := 90;
            end;
          end;
        end;
      { Centre de recherches }
        procedure initCDR(Joueur : TJoueur);
        begin
          if Joueur = Joueur1 then
          begin
            with CDR do
            begin
              nom          := 'Centre de recherches';
              niveau       := 0;
              construction := False;

              PALIERS[0] := 0;
              PALIERS[1] := 800;
              PALIERS[2] := 1600;
              PALIERS[3] := 3000;

              BONUS[0] := 0;
              BONUS[1] := 10;
              BONUS[2] := 40;
              BONUS[3] := 70;
            end;
          end;

          if Joueur = Joueur2 then
          begin
            with CDR2 do
            begin
              nom          := 'Centre de recherches';
              niveau       := 0;
              construction := False;

              PALIERS[0] := 0;
              PALIERS[1] := 800;
              PALIERS[2] := 1600;
              PALIERS[3] := 3000;

              BONUS[0] := 0;
              BONUS[1] := 10;
              BONUS[2] := 40;
              BONUS[3] := 70;
            end;
          end;
        end;
      { Laboratoire }
        procedure initLaboratoire(Joueur : TJoueur);
        begin
          if Joueur = Joueur1 then
          begin
            with Laboratoire do
            begin
              nom          := 'Laboratoire';
              niveau       := 0;
              construction := False;

              PALIERS[0] := 0;
              PALIERS[1] := 800;
              PALIERS[2] := 1600;
              PALIERS[3] := 3000;

              BONUS[0] := 0;
              BONUS[1] := 30;
              BONUS[2] := 60;
              BONUS[3] := 90;
            end;
          end

          else if Joueur = Joueur2 then
          begin
            with Laboratoire2 do
            begin
              nom          := 'Laboratoire';
              niveau       := 0;
              construction := False;

              PALIERS[0] := 0;
              PALIERS[1] := 800;
              PALIERS[2] := 1600;
              PALIERS[3] := 3000;

              BONUS[0] := 0;
              BONUS[1] := 30;
              BONUS[2] := 60;
              BONUS[3] := 90;
            end;
          end;
        end;
      { Enclos }
        procedure initEnclos(Joueur : TJoueur);
        begin
          if Joueur = Joueur1 then
          begin
            with Enclos do
            begin
              nom          := 'Enclos';
              niveau       := 0;
              construction := False;

              PALIERS[0] := 0;
              PALIERS[1] := 800;
              PALIERS[2] := 2400;
              PALIERS[3] := 4800;

              BONUS[0] := 0;
              BONUS[1] := 8;
              BONUS[2] := 16;
              BONUS[3] := 24;
            end;
          end

          else if Joueur = Joueur2 then
          begin
            with Enclos2 do
            begin
              nom          := 'Enclos';
              niveau       := 0;
              construction := False;

              PALIERS[0] := 0;
              PALIERS[1] := 800;
              PALIERS[2] := 2400;
              PALIERS[3] := 4800;

              BONUS[0] := 0;
              BONUS[1] := 10;
              BONUS[2] := 20;
              BONUS[3] := 30;
            end;
          end;
        end;
      { Bibliothèque }
        procedure initBibliotheque(Joueur : TJoueur);
        begin
          if Joueur = Joueur1 then
          begin
            with Bibliotheque do
            begin
              nom          := 'Bibliothèque';
              niveau       := 0;
              construction := False;

              PALIERS[0] := 0;
              PALIERS[1] := 400;
              PALIERS[2] := 1800;
              PALIERS[3] := 2800;

              BONUS[0] := 1;
              BONUS[1] := 4;
              BONUS[2] := 6;
              BONUS[3] := 8;
            end;
          end;

          if Joueur = Joueur2 then
          begin
            with Bibliotheque2 do
            begin
              nom          := 'Bibliothèque';
              niveau       := 0;
              construction := False;

              PALIERS[0] := 0;
              PALIERS[1] := 400;
              PALIERS[2] := 1800;
              PALIERS[3] := 2800;

              BONUS[0] := 1;
              BONUS[1] := 4;
              BONUS[2] := 6;
              BONUS[3] := 8;
            end;
          end;
        end;
        { Archives }
        procedure initArchives(Joueur : TJoueur);
        begin
          if Joueur = Joueur1 then
          begin
            with Archives do
            begin
              nom          := 'Archives';
              niveau       := 0;
              construction := False;

              PALIERS[0] := 0;
              PALIERS[1] := 800;
              PALIERS[2] := 1800;
              PALIERS[3] := 3000;

              BONUS[0] := 4;
              BONUS[1] := 5;
              BONUS[2] := 6;
              BONUS[3] := 7;
            end;
          end

          else if Joueur = Joueur2 then
          begin
            with Archives2 do
            begin
              nom          := 'Archives';
              niveau       := 0;
              construction := False;

              PALIERS[0] := 0;
              PALIERS[1] := 800;
              PALIERS[2] := 1800;
              PALIERS[3] := 3000;

              BONUS[0] := 4;
              BONUS[1] := 5;
              BONUS[2] := 6;
              BONUS[3] := 7;
            end;
          end;
        end;

    // UNITES
      { Lama }
        procedure initLama(Joueur : TJoueur);
        begin
          if Joueur = Joueur1 then
          begin
            with Lama do
            begin
              nom        := 'Lama';
              nb         := 30;
              ptsAttaque := 1;
              prix       := 1;
            end;
          end

          else if Joueur = Joueur2 then
          begin
            with Lama2 do
            begin
              nom        := 'Lama';
              nb         := 30;
              ptsAttaque := 1;
              prix       := 1;
            end;
          end;
        end;
      { Alpaga }
        procedure initAlpaga(Joueur : TJoueur);
        begin
          if Joueur = Joueur1 then
          begin
            with Alpaga do
            begin
              nom        := 'Alpaga';
              nb         := 10;
              ptsAttaque := 2;
              prix       := 2;
            end;
          end

          else if Joueur = Joueur2 then
          begin
            with Alpaga2 do
            begin
              nom        := 'Alpaga';
              nb         := 10;
              ptsAttaque := 2;
              prix       := 2;
            end;
          end;
        end;
      { Guanaco }
        procedure initGuanaco(Joueur : TJoueur);
        begin
          if Joueur = Joueur1 then
          begin
            with Guanaco do
            begin
              nom        := 'Guanaco';
              nb         := 3;
              ptsAttaque := 4;
              prix       := 3;
            end;
          end

          else if Joueur = Joueur2 then
          begin
            with Guanaco2 do
            begin
              nom        := 'Guanaco';
              nb         := 3;
              ptsAttaque := 4;
              prix       := 3;
            end;
          end;
        end;

    // INITIALISATION DU JOUEUR (regroupe tous les init)
    procedure initJoueur(Joueur : TJoueur);
    begin
      initTribu(Joueur);
      initElevage(Joueur);

      initUniversite(Joueur);
      initCDR(Joueur);
      initLaboratoire(Joueur);
      initEnclos(Joueur);
      initBibliotheque(Joueur);
      initArchives(Joueur);

      initLama(Joueur);
      initAlpaga(Joueur);
      initGuanaco(Joueur);
    end;




  { ARCHETYPE & DIFFICULTE }
    { Les procédures suivantes modifient certaines propriétés en fonction
      de l'archétype de Tribu et de la difficulté choisis par le joueur. }

    // Applique les changements liés à l'archétype de la Tribu
    procedure appliquerArchetype;
    begin
      if Joueur = Joueur1 then
      begin
        // Archétype ALGÉBRISTE
        if (Tribu.archetype = 'Algébriste') then
        begin
          { Il ne se passe rien quand on joue Algébriste ! :^( }
        end;

        // Archétype GÉOMÈTRE
        { Le bonheur reste constant }
        if (Tribu.archetype = 'Géomètre') then
        begin
          Elevage.facteurBonheur := 1;
        end;

        // Archétype BORÉLIENNE
        { L'armée initiale est renforcée }
        if (Tribu.archetype = 'Borélienne') then
        begin
          Lama.nb    := 100;
          Alpaga.nb  := 40;
          Guanaco.nb := 10;
        end;

        // Archétype ARCHIVISTE
        { L'archétype Archiviste bénéficie d'un bonus de défaites tolérées }
        if (Tribu.archetype = 'Archiviste') then
        begin
          with Archives do
          begin
              BONUS[0] := 7;
              BONUS[1] := 8;
              BONUS[2] := 9;
              BONUS[3] := 10;
          end;

          Tribu.limDefaites := Archives.BONUS[0];

        end;

        // Archétype Probabiliste
        { Probabilité d'assaut réduite }
        if (Tribu.archetype = 'Probabiliste') then
        begin
          { Le changement intervient au niveau de la procédure tourSuivant,
            où la portée du nb aléatoire généré est plus grande. }
        end;
      end

      else if Joueur = Joueur2 then
      begin
        // Archétype ALGÉBRISTE
        if (Tribu2.archetype = 'Algébriste') then
        begin
          { Il ne se passe rien quand on joue Algébriste ! :^( }
        end;

        // Archétype GÉOMÈTRE
        { Le bonheur reste constant }
        if (Tribu2.archetype = 'Géomètre') then
        begin
          Elevage2.facteurBonheur := 1;
        end;

        // Archétype BORÉLIENNE
        { L'armée initiale est renforcée }
        if (Tribu2.archetype = 'Borélienne') then
        begin
          Lama2.nb    := 300;
          Alpaga2.nb  := 200;
          Guanaco2.nb := 100;
        end;

        // Archétype ARCHIVISTE
        { L'archétype Archiviste bénéficie d'un bonus de défaites tolérées }
        if (Tribu2.archetype = 'Archiviste') then
        begin
          with Archives2 do
          begin
              BONUS[0] := 7;
              BONUS[1] := 8;
              BONUS[2] := 9;
              BONUS[3] := 10;
          end;

          Tribu2.limDefaites := Archives.BONUS[0];

        end;

        // Archétype Probabiliste
        { Probabilité d'assaut réduite }
        if (Tribu2.archetype = 'Probabiliste') then
        begin
          { Le changement intervient au niveau de la procédure tourSuivant,
            où la portée du nb aléatoire généré est plus grande. }
        end;
      end;
    end;

    // Applique les changements liés à la difficulté de la partie
    procedure appliquerDifficulte;
    begin

      { ATTENTION : La difficulté influe aussi sur le nb d'unités présentes dans les pâturages ennemis.
        Se référer à la procédure genererEnnemis() de l'unit EcranCombat. }

      if Joueur = Joueur1 then
      begin
        // Difficulté Linéaire
        if (Tribu.difficulte = 'Linéaire') then
        begin
          { Coûts de construction }

            // Université
            with Universite do
            begin
              PALIERS[0] := 0;
              PALIERS[1] := 200;
              PALIERS[2] := 800;
              PALIERS[3] := 1600;
            end;

            // Centre de recherches
            with CDR do
            begin
              PALIERS[0] := 0;
              PALIERS[1] := 600;
              PALIERS[2] := 1200;
              PALIERS[3] := 2400;
            end;

            // Laboratoire
            with Laboratoire do
            begin
              PALIERS[0] := 0;
              PALIERS[1] := 600;
              PALIERS[2] := 1200;
              PALIERS[3] := 2400;
            end;

            // Enclos
            with Enclos do
            begin
              PALIERS[0] := 0;
              PALIERS[1] := 600;
              PALIERS[2] := 1600;
              PALIERS[3] := 2200;
            end;

            // Bibliothèque
            with Bibliotheque do
            begin
              PALIERS[0] := 0;
              PALIERS[1] := 200;
              PALIERS[2] := 800;
              PALIERS[3] := 1600;
            end;

            // Archives
            with Archives do
            begin
              PALIERS[0] := 0;
              PALIERS[1] := 600;
              PALIERS[2] := 1200;
              PALIERS[3] := 2600;
            end;
        end;

        // Difficulté Appliqué
        if (Tribu.difficulte = 'Appliqué') then
        begin
          { Coûts de construction }

            // Université
            with Universite do
            begin
              PALIERS[0] := 0;
              PALIERS[1] := 400;
              PALIERS[2] := 1800;
              PALIERS[3] := 2800;
            end;

            // Centre de recherches
            with CDR do
            begin
              PALIERS[0] := 0;
              PALIERS[1] := 800;
              PALIERS[2] := 1600;
              PALIERS[3] := 3000;
            end;

            // Laboratoire
            with Laboratoire do
            begin
              PALIERS[0] := 0;
              PALIERS[1] := 800;
              PALIERS[2] := 1600;
              PALIERS[3] := 3000;
            end;

            // Enclos
            with Enclos do
            begin
              PALIERS[0] := 0;
              PALIERS[1] := 800;
              PALIERS[2] := 2400;
              PALIERS[3] := 4800;
            end;

            // Bibliothèque
            with Bibliotheque do
            begin
              PALIERS[0] := 0;
              PALIERS[1] := 400;
              PALIERS[2] := 1800;
              PALIERS[3] := 2800;
            end;

            // Archives
            with Archives do
            begin
              PALIERS[0] := 0;
              PALIERS[1] := 800;
              PALIERS[2] := 1800;
              PALIERS[3] := 3000;
            end;
        end;

        // Difficulté Quantique
        if (Tribu.difficulte = 'Quantique') then
        begin
          { Coûts de construction }

            // Université
            with Universite do
            begin
              PALIERS[0] := 0;
              PALIERS[1] := 600;
              PALIERS[2] := 2200;
              PALIERS[3] := 3200;
            end;

            // Centre de recherches
            with CDR do
            begin
              PALIERS[0] := 0;
              PALIERS[1] := 1000;
              PALIERS[2] := 2200;
              PALIERS[3] := 3400;
            end;

            // Laboratoire
            with Laboratoire do
            begin
              PALIERS[0] := 0;
              PALIERS[1] := 1000;
              PALIERS[2] := 2200;
              PALIERS[3] := 3400;
            end;

            // Enclos
            with Enclos do
            begin
              PALIERS[0] := 0;
              PALIERS[1] := 1000;
              PALIERS[2] := 2800;
              PALIERS[3] := 5600;
            end;

            // Bibliothèque
            with Bibliotheque do
            begin
              PALIERS[0] := 0;
              PALIERS[1] := 600;
              PALIERS[2] := 2200;
              PALIERS[3] := 3200;
            end;

            // Archives
            with Archives do
            begin
              PALIERS[0] := 0;
              PALIERS[1] := 1000;
              PALIERS[2] := 2200;
              PALIERS[3] := 3400;
            end;
        end;
      end



      else if Joueur = Joueur2 then
      begin
        // Difficulté Linéaire
        if (Tribu2.difficulte = 'Linéaire') then
        begin
          { Coûts de construction }

            // Université
            with Universite2 do
            begin
              PALIERS[0] := 0;
              PALIERS[1] := 200;
              PALIERS[2] := 800;
              PALIERS[3] := 1600;
            end;

            // Centre de recherches
            with CDR2 do
            begin
              PALIERS[0] := 0;
              PALIERS[1] := 600;
              PALIERS[2] := 1200;
              PALIERS[3] := 2400;
            end;

            // Laboratoire
            with Laboratoire2 do
            begin
              PALIERS[0] := 0;
              PALIERS[1] := 600;
              PALIERS[2] := 1200;
              PALIERS[3] := 2400;
            end;

            // Enclos
            with Enclos2 do
            begin
              PALIERS[0] := 0;
              PALIERS[1] := 600;
              PALIERS[2] := 1600;
              PALIERS[3] := 2200;
            end;

            // Bibliothèque
            with Bibliotheque2 do
            begin
              PALIERS[0] := 0;
              PALIERS[1] := 200;
              PALIERS[2] := 800;
              PALIERS[3] := 1600;
            end;

            // Archives
            with Archives2 do
            begin
              PALIERS[0] := 0;
              PALIERS[1] := 600;
              PALIERS[2] := 1200;
              PALIERS[3] := 2600;
            end;
        end;

        // Difficulté Appliqué
        if (Tribu2.difficulte = 'Appliqué') then
        begin
          { Coûts de construction }

            // Université
            with Universite2 do
            begin
              PALIERS[0] := 0;
              PALIERS[1] := 400;
              PALIERS[2] := 1800;
              PALIERS[3] := 2800;
            end;

            // Centre de recherches
            with CDR2 do
            begin
              PALIERS[0] := 0;
              PALIERS[1] := 800;
              PALIERS[2] := 1600;
              PALIERS[3] := 3000;
            end;

            // Laboratoire
            with Laboratoire2 do
            begin
              PALIERS[0] := 0;
              PALIERS[1] := 800;
              PALIERS[2] := 1600;
              PALIERS[3] := 3000;
            end;

            // Enclos
            with Enclos2 do
            begin
              PALIERS[0] := 0;
              PALIERS[1] := 800;
              PALIERS[2] := 2400;
              PALIERS[3] := 4800;
            end;

            // Bibliothèque
            with Bibliotheque2 do
            begin
              PALIERS[0] := 0;
              PALIERS[1] := 400;
              PALIERS[2] := 1800;
              PALIERS[3] := 2800;
            end;

            // Archives
            with Archives2 do
            begin
              PALIERS[0] := 0;
              PALIERS[1] := 800;
              PALIERS[2] := 1800;
              PALIERS[3] := 3000;
            end;
        end;

        // Difficulté Quantique
        if (Tribu2.difficulte = 'Quantique') then
        begin
          { Coûts de construction }

            // Université
            with Universite2 do
            begin
              PALIERS[0] := 0;
              PALIERS[1] := 600;
              PALIERS[2] := 2200;
              PALIERS[3] := 3200;
            end;

            // Centre de recherches
            with CDR2 do
            begin
              PALIERS[0] := 0;
              PALIERS[1] := 1000;
              PALIERS[2] := 2200;
              PALIERS[3] := 3400;
            end;

            // Laboratoire
            with Laboratoire2 do
            begin
              PALIERS[0] := 0;
              PALIERS[1] := 1000;
              PALIERS[2] := 2200;
              PALIERS[3] := 3400;
            end;

            // Enclos
            with Enclos2 do
            begin
              PALIERS[0] := 0;
              PALIERS[1] := 1000;
              PALIERS[2] := 2800;
              PALIERS[3] := 5600;
            end;

            // Bibliothèque
            with Bibliotheque2 do
            begin
              PALIERS[0] := 0;
              PALIERS[1] := 600;
              PALIERS[2] := 2200;
              PALIERS[3] := 3200;
            end;

            // Archives
            with Archives2 do
            begin
              PALIERS[0] := 0;
              PALIERS[1] := 1000;
              PALIERS[2] := 2200;
              PALIERS[3] := 3400;
            end;
        end;
      end;
    end;

end.
