:-use_module(tdaplayer).
:-use_module(tdaboard).

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
%Meta Primaria: getGamePlayer2/2
%Meta Secunbdaria:
getGamePlayer2([_, Player2|_], Player2).

%Nombre:getGameBoard
%Dominio: Game(game) X Board(board)
%descripcion: predicado para obtener el tablero
%Meta Primaria: getGameBoard/2
%Meta Secunbdaria:
getGameBoard([_, _, Board|_], Board).

%Nombre:getGameCurrentTurn
%Dominio: Game(game) X CurrentTurn(int)
%descripcion: predicado para obtener el turno actual
%Meta Primaria: getGameCurrentTurn/2
%Meta Secunbdaria:
getGameCurrentTurn([_, _, _, CurrentTurn|_], CurrentTurn).

%Nombre:getGameHistory
%Dominio: Game(game) X History(lista)
%descripcion: predicado para obtener el historial
%Meta Primaria:
%Meta Secunbdaria:
getGameHistory([_, _, _, _, History], History).

%Nombre:
%Dominio:
%descripcion:
%Meta Primaria:
%Meta Secunbdaria:
is_draw(Game) :-
    getGameBoard(Game, Board),
    getGamePlayer1(Game, P1),
    getGamePlayer2(Game, P2),
    getRemainingPiecesplayer(P1, Pieces1),
    getRemainingPiecesplayer(P2, Pieces2),

    % Verificar si el tablero está lleno
    (  \+ can_play(Board)
    ->  write('Tablero lleno, empate detectado'), nl, true
    ;   % Si no está lleno, verificar si ambos jugadores se quedaron sin piezas
        (Pieces1 == 0, Pieces2 == 0
        ->  write('Ambos jugadores sin piezas, empate detectado'), nl, true
        ;   false
        )
    ).



%Nombre:
%Dominio:
%descripcion:
%Meta Primaria:
%Meta Secunbdaria:
