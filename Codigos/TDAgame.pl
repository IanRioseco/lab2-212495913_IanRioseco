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
getGamePlayer1(Game, Player1):-
    game(Player1,_,_,_, Game).

%Nombre: getGamePlayer2
%Dominio: Game(game) X Player2(player)
%descripcion: predicado para obtener el jugador 2
%Meta Primaria: getGamePlayer2/2
%Meta Secunbdaria:
getGamePlayer2(Game, Player2):-
    game(_,Player2,_,_, Game).

%Nombre:getGameBoard
%Dominio: Game(game) X Board(board)
%descripcion: predicado para obtener el tablero
%Meta Primaria: getGameBoard/2
%Meta Secunbdaria:
getGameBoard(Game, Board):-
    game(_,_,Board,_, Game).

%Nombre:getGameCurrentTurn
%Dominio: Game(game) X CurrentTurn(int)
%descripcion: predicado para obtener el turno actual
%Meta Primaria: getGameCurrentTurn/2
%Meta Secunbdaria:
getGameCurrentTurn(Game, CurrentTurn):-
    game(_,_,_,CurrentTurn, Game).

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
    getGamePlayer1(Game, Player1),
    getGamePlayer2(Game, Player2),
    getRemainingPiecesplayer(Player1, Pieces1),
    getRemainingPiecesplayer(Player2, Pieces2),

    % Verificar si el tablero est� lleno
    (  \+ can_play(Board)
    ->  write('Tablero lleno, empate detectado'), nl, true
    ;   % Si no est� lleno, verificar si ambos jugadores se quedaron sin piezas
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


%Nombre: get_current_player
%Dominio:
%descripcion:
%Meta Primaria:
%Meta Secunbdaria:
get_current_player(Game, CurrentPlayer) :-
    getGameCurrentTurn(Game, CurrentTurn),
    (   CurrentTurn == 1
    ->  getGamePlayer1(Game, CurrentPlayer),
        write('Jugador 1: '), write(CurrentPlayer), nl
    ;   getGamePlayer2(Game, CurrentPlayer),
        write('Jugador 2: '), write(CurrentPlayer), nl
    ).
