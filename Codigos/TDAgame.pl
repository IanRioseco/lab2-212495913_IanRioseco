%Nombre: game
% Dominio:Player1(player) X Player2(player) X Board(board) X CurrentTurn
% descripcion: crea una partida de conecta4
% Meta Primaria: game/5
% Meta Secunbdaria:no tiene
game(Player1, Player2, Board, CurrentTurn, Game):-
    Game=[Player1, Player2, Board, CurrentTurn, []].

%Nombre: getGamePlayer1
%Dominio: Game(game) X Player1(player)
%descripcion: predicado para obtener al jugador 1
%Meta Primaria: getGamePlayer1/2
%Meta Secunbdaria:
getGamePlayer1([Player1|_], Player1).

%Nombre: getGamePlayer2
%Dominio: Game(game) X Player2(player)
%descripcion: predicado para obtener el jugador 2
%Meta Primaria:
%Meta Secunbdaria:
getGamePlayer2([_, Player2|_], Player2).

%Nombre:getGameBoard
%Dominio: Game(game) X Board(board)
%descripcion:
%Meta Primaria:
%Meta Secunbdaria:
getGameBoard([_, _, Board|_], Board).

%Nombre:getGamePlayer1
%Dominio:
%descripcion:
%Meta Primaria:
%Meta Secunbdaria:
getGameCurrentTurn([_, _, _, CurrentTurn|_], CurrentTurn).

%Nombre:getGamePlayer1
%Dominio:
%descripcion:
%Meta Primaria:
%Meta Secunbdaria:
getGameHistory([_, _, _, _, History], History).

%Nombre:
%Dominio:
%descripcion:
%Meta Primaria:
%Meta Secunbdaria:
