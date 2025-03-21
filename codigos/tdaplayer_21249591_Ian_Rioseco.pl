:- module(tdaplayer_21249591_ian_rioseco,[
              player/8,
              getIdplayer/2,
              getNameplayer/2,
              getColorplayer/2,
              getWinsplayer/2,
              getLossesplayer/2,
              getDrawsplayer/2,
              getRemainingPiecesplayer/2,
              decreasePieces/2,
              update_wins/3,
              update_losses/3,
              update_draws/3]).

%Nombre: player
%Dominio: id(int) X Nombre(string) X color(string) X Wins(int) X Losses(int) X Draws(int) X RemainingPieces(int) X Player
%descripcion: Predicado que permite crear un jugador.
%Meta Primaria: player/8.
%Meta Secunbdaria: no contiene.
player(Id, Name, Color, Wins, Losses, Draws, RemainingPieces, [Id, Name, Color, Wins, Losses, Draws, RemainingPieces]).


%Nombre: getIdplayer
%Dominio: player X Id
/*Descripcion: Obtiene el id del jugador*/
%Meta Primaria: getIdplayer/2
%Meta Secundaria: player(Id,_,_,_,_,_,_,player).
getIdplayer(Player, Id):-
    player(Id,_,_,_,_,_,_, Player).

%Nombre: getNameplayer
%Dominio: player X Name
/*Descripcion: Obtiene el nombre del jugador*/
%Meta Primaria: getNameplayer/2
%Meta Secundaria: player(_,Name,_,_,_,_,_;player).
getNameplayer(Player,Name):-
    player(_,Name,_,_,_,_,_, Player).

%Nombre: getColorplayer
%Dominio: player X Color
/*Descripcion: Obtiene el color del jugador*/
%Meta Primaria: getColorplayer/2
%Meta Secundaria: player(_,_,Color,_,_,_,_;player).
getColorplayer(Player,Color):-
    player(_,_,Color,_,_,_,_, Player).

%Nombre: getWinsplayer
%Dominio: player X Wins
/*Descripcion: Obtiene el nunero de victorias del jugador*/
%Meta Primaria: getWinsplayer/2
%Meta Secundaria: player(_,_,_,Wins,_,_,_;player).
getWinsplayer(Player,Wins):-
    player(_,_,_,Wins,_,_,_, Player).

%Nombre: getLossesplayer
%Dominio: player X Name
/*Descripcion: Obtiene el numero de derrotas del jugador*/
%Meta Primaria: getNameplayer/2
%Meta Secundaria: player(_,Name,_,_,_,_,_;player).
getLossesplayer(Player,Losses):-
    player(_,_,_,_,Losses,_,_, Player).

%Nombre: getDrawplayer
%Dominio: player X Draws
/*Descripcion: Obtiene el numero de empates del jugador*/
%Meta Primaria: getDrawplayer/2
%Meta Secundaria: player(_,_,_,_,_,Draws,_;player).
getDrawsplayer(Player,Draws):-
    player(_,_,_,_,_,Draws,_, Player).

%Nombre: getRemainingPiecesplayer
%Dominio: player X RemainingPieces
/*Descripcion: Obtiene el numero de piezas restantes del jugador*/
%Meta Primaria: getRemainingPiecesplayer/2
%Meta Secundaria: player(_,_,_,_,_,_,RemainingPieces;player).
getRemainingPiecesplayer(Player,RemainingPieces):-
    player(_,_,_,_,_,_,RemainingPieces, Player).


%Nombre: decreasepieces
% Dominio: player(Player) X UpdatedPlayer(Player)
% Descripción: Disnimuye la cantidad de piezas restantes del jugador.
% Meta Primaria: decreasePieces/2
decreasePieces(Player,UpdatedPlayer) :-
    % Obtener el ID, nombre, color, victorias, derrotas, empates y las piezas restantes del jugador
    nth1(1, Player, ID),
    nth1(2, Player, Name),
    nth1(3, Player, Color),
    nth1(4, Player, Victories),
    nth1(5, Player, Defeats),
    nth1(6, Player, Draws),
    nth1(7, Player, RemainingPieces),

    % se Resta 1 a la cantidad de piezas restantes
    NewRemainingPieces is RemainingPieces - 1,

    % se Crea el jugador actualizado con la nueva cantidad de piezas
    UpdatedPlayer = [ID, Name, Color, Victories, Defeats, Draws, NewRemainingPieces].



% Nombre: update_wins
% DOM: player(Player) X wins(int)
% Meta primaria: update_wins/3
update_wins([ID, Name, Color, Wins, Losses, Draws, Pieces], victory,
             [ID, Name, Color, NewWins, Losses, Draws, Pieces]) :-
    NewWins is Wins + 1.

% Nombre: update_losses
% DOM: player(Player) X losses(int)
% Meta primaria: update_losses/3
update_losses([ID, Name, Color, Wins, Losses, Draws, Pieces], defeat,
             [ID, Name, Color, Wins, NewLosses, Draws, Pieces]) :-
    NewLosses is Losses + 1.

% Nombre: update_draws
% DOM: player(Player) X draws(int)
% Meta primaria: update_draws/3
update_draws([ID, Name, Color, Wins, Losses, Draws, Pieces], draw,
             [ID, Name, Color, Wins, Losses, NewDraws, Pieces]) :-
    NewDraws is Draws + 1.
