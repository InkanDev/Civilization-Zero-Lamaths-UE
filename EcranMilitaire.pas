unit EcranMilitaire;

interface

  uses Variables;

  { Affichage de l'écran et appel des fonctions & procédures associées }
  procedure afficher(Joueur : TJoueur);



implementation

  uses sysutils, GestionEcran, OptnAffichage, EcranTribu, EcranCombat;


  { Dépense des points de recrutement pour acheter un Lama (soldat) }
  procedure recruterLama(Joueur : TJoueur);
  begin
    { Nécessite un Enclos niveau 1 ou supérieur }
    if getEnclos(Joueur).niveau >= 1 then
    begin
      { Si le joueur dispose de suffisamment de points de recrutement }
      if getTribu(Joueur).ptsRecrutement >= getLama(Joueur).prix then
      begin
          setTribu_ptsRecrutement(Joueur, getTribu(Joueur).ptsRecrutement - getLama(Joueur).prix);
          setLama_nb(Joueur, getLama(Joueur).nb + 1);
      end
      else setMessage('Pas assez de points de recrutement');
    end
    else setMessage('Enclos non construit');
  end;

  { Dépense des points de recrutement pour acheter un Alpaga (canon) }
  procedure recruterAlpaga(Joueur : TJoueur);
  begin
    { Nécessite un Enclos niveau 1 ou supérieur }
    if getEnclos(Joueur).niveau >= 1 then
    begin
      { Nécessite un Centre de recherches niveau 1 }
      if getCDR(Joueur).niveau >= 1 then
      begin
        { Si le joueur dispose de suffisamment de points de recrutement }
        if getTribu(Joueur).ptsRecrutement >= getAlpaga(Joueur).prix then
        begin
          setTribu_ptsRecrutement(Joueur, getTribu(Joueur).ptsRecrutement - getAlpaga(Joueur).prix);
          setAlpaga_nb(Joueur, getAlpaga(Joueur).nb + 1);
        end
        else setMessage('Pas assez de points de recrutement');
      end
      else setMessage('Centre de recherches niv.1 requis');
    end
    else setMessage('Enclos non construit');
  end;

  { Dépense des points de recrutement pour acheter un Guanaco (cavalier) }
  procedure recruterGuanaco(Joueur : TJoueur);
  begin
    { Nécessite un Enclos niveau 1 ou supérieur }
    if getEnclos(Joueur).niveau >= 1 then
    begin
      { Nécessite un Centre de recherches niveau 2 }
      if getCDR(Joueur).niveau >= 2 then
      begin
        { Si le joueur dispose de suffisamment de points de recrutement }
        if getTribu(Joueur).ptsRecrutement >= getGuanaco(Joueur).prix then
        begin
          setTribu_ptsRecrutement(Joueur, getTribu(Joueur).ptsRecrutement - getGuanaco(Joueur).prix);
          setGuanaco_nb(Joueur, getGuanaco(Joueur).nb + 1);
        end
        else setMessage('Pas assez de points de recrutement');
      end
      else setMessage('Centre de recherches niv.2 requis');
    end
    else setMessage('Enclos non construit');
  end;


  { Détermine l'action à effectuer en fonction du choix de l'utilisateur }
  procedure choisir(Joueur : TJoueur);

  var
    choix : String; // Valeur entrée par la joueur
    nb : Integer; // Compteur (pour acheter plusieurs unités)

  begin
    { Déplace le curseur dans le cadre "Action" }
    deplacerCurseurXY(114,26);
    readln(choix);

    { Liste des choix disponibles }

    if (choix = '1') then
    begin
      recruterLama(Joueur);
      afficher(Joueur);
    end;

    if (choix = '2') then
    begin
      recruterAlpaga(Joueur);
      afficher(Joueur);
    end;

    if (choix = '3') then
    begin
      recruterGuanaco(Joueur);
      afficher(Joueur);
    end;

    if (choix = '7') then
    begin
      for nb := 1 to (getTribu(Joueur).ptsRecrutement div getLama(Joueur).prix) do recruterLama(Joueur);
      afficher(Joueur);
    end;

    if (choix = '8') then
    begin
      for nb := 1 to (getTribu(Joueur).ptsRecrutement div getAlpaga(Joueur).prix) do recruterAlpaga(Joueur);
      afficher(Joueur);
    end;

    if (choix = '9') then
    begin
      for nb := 1 to (getTribu(Joueur).ptsRecrutement div getGuanaco(Joueur).prix) do recruterGuanaco(Joueur);
      afficher(Joueur);
    end;

    { Si le choix correspond à une attaque, on affiche l'écran de combat
      après avoir généré un groupe d'ennemis. }
    if (choix = '4') OR (choix = '5') OR (choix = '6') then
    begin
      if (getLama(Joueur).nb > 0) OR (getAlpaga(Joueur).nb > 0) OR (getGuanaco(Joueur).nb > 0) then
      begin
        if (choix = '4') then EcranCombat.genererEnnemis(Joueur, 'petit');
        if (choix = '5') then EcranCombat.genererEnnemis(Joueur, 'grand');

        if (choix = '6') then
        begin
          if getMultijoueur() = True then
          begin

            if Joueur = Joueur1 then
            begin
              if (getLama(Joueur2).nb = 0) AND (getAlpaga(Joueur2).nb = 0) AND (getGuanaco(Joueur2).nb = 0) then
              begin
                setMessage('L''autre Joueur n''a pas d''armée, c''est déloyal !');
                afficher(Joueur);
              end
              else
              begin
                EcranCombat.genererEnnemis(Joueur, 'joueur');
                EcranCombat.afficher(Joueur);
              end;
            end

            else if Joueur = Joueur2 then
            begin
              if (getLama(Joueur1).nb = 0) AND (getAlpaga(Joueur1).nb = 0) AND (getGuanaco(Joueur1).nb = 0) then
              begin
                setMessage('L''autre Joueur n''a pas d''armée, c''est déloyal !');
                afficher(Joueur);
              end
              else
              begin
                EcranCombat.genererEnnemis(Joueur, 'joueur');
                EcranCombat.afficher(Joueur);
              end;
            end;

          end

          else setMessage('Action non reconnue');
          afficher(Joueur);
        end;

        EcranCombat.afficher(Joueur);
      end
      else setMessage('Impossible d''attaquer sans armée');
      afficher(Joueur);
    end;

    if (choix = '0') then
    begin
      ecranTribu.afficher(Joueur);
    end

    { Valeur saisie invalide }
    else
    begin
      setMessage('Action non reconnue');
      afficher(Joueur);
    end;
  end;

  { Affichage de l'écran et appel des fonctions & procédures associées }
  procedure afficher(Joueur : TJoueur);

  begin
    effacerEcran();

    { Partie supérieure de l'écran }
    afficherEnTete(Joueur);
    dessinerCadreXY(0,6, 119,28, simple, 15,0);
    afficherTitre('ECRAN DE GESTION MILITAIRE ET DIPLOMATIQUE', 6);

    { Corps de l'écran }
    deplacerCurseurXY(3,10);
    write('Liste des troupes disponibles :');
    deplacerCurseurXY(3,11);
    write('¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯');

    // Lamas disponibles
    deplacerCurseurXY(5,12);
    write('    Lamas : ');
    if getLama(Joueur).nb = 0 then couleurTexte(8)
    else couleurtexte(10);
    write(getLama(Joueur).nb);
    couleurTexte(15);

    // Alpagas disponibles
    deplacerCurseurXY(5,13);
    write('  Alpagas : ');
    if getAlpaga(Joueur).nb = 0 then couleurTexte(8)
    else couleurtexte(10);
    write(getAlpaga(Joueur).nb);
    couleurTexte(15);

    // Guanacos disponibles
    deplacerCurseurXY(5,14);
    write(' Guanacos : ');
    if getGuanaco(Joueur).nb = 0 then couleurTexte(8)
    else couleurtexte(10);
    write(getGuanaco(Joueur).nb);
    couleurTexte(15);


    // Points de recrutement
    deplacerCurseurXY(4,16);
    if getTribu(Joueur).ptsRecrutement = 0 then couleurtexte(12)
    else couleurTexte(10);
    write(getTribu(Joueur).ptsRecrutement);
    couleurTexte(15);
    write(' points de recrutement disponibles');



    // Affichage du score du joueur
    { Cadre }
    dessinerCadreXY(74,13, 100,18, simple, 15,0);
    deplacerCurseurXY(76,13);
    write(' Statistiques ');
    { Victoires }
    couleurTexte(10);
    deplacerCurseurXY(79,15);
    write(' Victoires : ', getTribu(Joueur).victoires);
    { Défaites }
    couleurTexte(12);
    deplacerCurseurXY(79,16);
    write(' Défaites  : ', getTribu(Joueur).defaites);
    couleurTexte(15);

    deplacerCurseurXY(71,20);
    write('Fin de la partie dans ', getTribu(Joueur).limDefaites, ' défaites');



    { Choix disponibles }
    if getTribu(Joueur).ptsRecrutement > 0 then
    begin
      // Recruter un LAMA
      afficherAction(3,18, '1', 'Recruter un Lama', 'vert');
      if getTribu(Joueur).ptsRecrutement >= getLama(Joueur).prix then
      afficherAction(24,18, '7', 'x' + IntToStr(getTribu(Joueur).ptsRecrutement div getLama(Joueur).prix), 'vert');

      // Recruter un ALPAGA
      if getCDR(Joueur).niveau > 0 then
      begin
        afficherAction(3,19, '2', 'Recruter un Alpaga', 'vert');
        if getTribu(Joueur).ptsRecrutement >= getAlpaga(Joueur).prix then
        afficherAction(26,19, '8', 'x' + IntToStr(getTribu(Joueur).ptsRecrutement div getAlpaga(Joueur).prix), 'vert');
      end
      else afficherAction(3,19, '2', 'Recruter un Alpaga', 'rouge');


      // Recruter un GUANACO
      if getCDR(Joueur).niveau > 1 then
      begin
        afficherAction(3,20, '3', 'Recruter un Guanaco', 'vert');
        if getTribu(Joueur).ptsRecrutement >= getGuanaco(Joueur).prix then
        afficherAction(27,20, '9', 'x' + IntToStr(getTribu(Joueur).ptsRecrutement div getGuanaco(Joueur).prix), 'vert');
      end
      else afficherAction(3,20, '3', 'Recruter un Guanaco', 'rouge');

    end

    else
    begin
      afficherAction(3,18, '1', 'Recruter un Lama', 'rouge');
      afficherAction(3,19, '2', 'Recruter un Alpaga', 'rouge');
      afficherAction(3,20, '3', 'Recruter un Guanaco', 'rouge');
    end;

    afficherAction(3,22, '4', 'Attaquer un petit pâturage de littéraires', 'vert');
    afficherAction(3,23, '5', 'Attaquer un grand pâturage de littéraires', 'vert');
    if getMultijoueur() = True then afficherAction(3,24, '6', 'Attaquer l''autre Joueur', 'vert');

    afficherAction(3,26, '0', 'Retour au menu', 'jaune');

    { Partie inférieure de l'écran }
    afficherMessage();
    afficherCadreAction();

    choisir(Joueur);
  end;

end.
