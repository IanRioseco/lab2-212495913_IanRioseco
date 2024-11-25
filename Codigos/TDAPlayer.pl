:-module(tdaplayer,[player/8, getIdplayer/2, getNameplayer/2, getColorplayer/2, getWinsplayer/2, getLossesplayer/2, getDrawsplayer/2, getRemainingPiecesplayer/2]).

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




