%Nombre:
%Dominio:
%descripcion:
%Meta Primaria:
%Meta Secunbdaria:
game(Player1, Player2, Board, CurrentTurn, Game):-
    Game=[Player1, Player2, Board, CurrentTurn, []].


%Nombre:
%Dominio:
%descripcion:
%Meta Primaria:
%Meta Secunbdaria:
getGamePlayer1([Player1|_], Player1).

%Nombre:
%Dominio:
%descripcion:
%Meta Primaria:
%Meta Secunbdaria:
getGamePlayer2([_, Player2|_], Player2).

%Nombre:
%Dominio:
%descripcion:
%Meta Primaria:
%Meta Secunbdaria:
getGameBoard([_, _, Board|_], Board).

%Nombre:
%Dominio:
%descripcion:
%Meta Primaria:
%Meta Secunbdaria:
getGameCurrentTurn([_, _, _, CurrentTurn|_], CurrentTurn).

%Nombre:
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
