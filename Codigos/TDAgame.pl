:-use_module(tdaplayer).
:-use_module(tdaboard).
:-use_module(tdapiece).

%Nombre: game
% Dominio:Player1(player) X Player2(player) X Board(board) X CurrentTurn
% descripcion: crea una partida de conecta4
% Meta Primaria: game/5
% Meta Secunbdaria:no tiene
game(Player1, Player2, Board, CurrentTurn,Game):-
    Game=[Player1, Player2, Board, CurrentTurn,[]].

%getter
%Nombre: getGamePlayer1
%Dominio: Game(game) X Player1(player)
%descripcion: predicado para obtener al jugador 1
%Meta Primaria: getGamePlayer1/2
%Meta Secunbdaria:
getGamePlayer1([Player1,_,_,_,_], Player1).

%getter
%Nombre: getGamePlayer2
%Dominio: Game(game) X Player2(player)
%descripcion: predicado para obtener el jugador 2
%Meta Primaria: getGamePlayer2/2
%Meta Secunbdaria:
getGamePlayer2([_,Player2,_,_,_], Player2).

%getter
%Nombre:getGameCurrentTurn
%Dominio: Game(game) X CurrentTurn(int)
%descripcion: predicado para obtener el turno actual
%Meta Primaria: getGameCurrentTurn/2
%Meta Secunbdaria:
getGameCurrentTurn([_,_,_,CurrentTurn,_], CurrentTurn).

%Nombre:Game_History
%Dominio: Game(game) X History(lista)
%descripcion: predicado para obtener el historial
%Meta Primaria:
%Meta Secunbdaria:
game_history([_, _, _, _, History], History).

%Nombre:
%Dominio:
%descripcion:
%Meta Primaria:
%Meta Secunbdaria:
is_draw(Game) :-
    game_get_board(Game, Board),
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



%Nombre: update_stats
%Dominio:
%descripcion:
%Meta Primaria:
%Meta Secunbdaria:
update_stats(Game, Oldstats, Newstats) :-
    game_get_board(Game, Board),
    getIdplayer(Oldstats, Id),

    (   who_is_winner(Board, Winner)  % Verificamos si hay un ganador
    ->  (   Winner == Id  % Si el jugador ha ganado
        ->  update(Oldstats, victory, Newstats)
        ;   (   Winner \= 0  % Si hay un ganador distinto al jugador
            ->  update(Oldstats, defeat, Newstats)
            ;   Newstats = Oldstats  % Si no hay ganador, no hay cambio
            )
        )
    ;   (   is_draw(Game)  % Si hay empate
        ->  update(Oldstats, draw, Newstats)
        ;   Newstats = Oldstats  % Si el juego no ha terminado, no hay cambio
        )
    ).

%Nombre: end_game
%Dominio:
%descripcion:
%Meta Primaria:
%Meta Secunbdaria:
% Actualiza las estadisticas de un jugador
update([ID, Name, Color, Wins, Losses, Draws, Pieces], victory,
             [ID, Name, Color, NewWins, Losses, Draws, Pieces]) :-
    NewWins is Wins + 1.

update([ID, Name, Color, Wins, Losses, Draws, Pieces], defeat,
             [ID, Name, Color, Wins, NewLosses, Draws, Pieces]) :-
    NewLosses is Losses + 1.

update([ID, Name, Color, Wins, Losses, Draws, Pieces], draw,
             [ID, Name, Color, Wins, Losses, NewDraws, Pieces]) :-
    NewDraws is Draws + 1.

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


%Nombre:getGameBoard
%Dominio: Game(game) X Board(board)
%descripcion: predicado para obtener el tablero
%Meta Primaria: getGameBoard/2
%Meta Secunbdaria:
game_get_board([_,_,Board,_,_], Board).



%Nombre: end_game
%Dominio:
%descripcion:
%Meta Primaria:
%Meta Secunbdaria:
end_game(Game,EndGame):-
    getGamePlayer1(Game,Player1),
    getGamePlayer2(Game,Player2),
    game_get_board(Game,Board),
    getGameCurrentTurn(Game,Turn),
    game_history(Game,History),
    update_stats(Game,Player1,UpdateP1),
    update_stats(Game,Player2,UpdateP2),
    EndGame = [UpdateP1,UpdateP2,Board,Turn,History].


%Nombre: player_play
%Dominio:
%descripcion:
%Meta Primaria:
%Meta Secunbdaria:
player_play(Game, Player, Column, NewGame) :-
    % Obtener los jugadores y el turno actual
    getGamePlayer1(Game, Player1),
    getGamePlayer2(Game, Player2),
    getGameCurrentTurn(Game, CurrentTurn),
    game_get_board(Game,Board),
    % Verificar turno del jugador
    (   CurrentTurn == 1
    ->  Pactual = Player1
    ;   Pactual = Player2
    ),
    getIdplayer(Player,Idplayer),
    getIdplayer(Pactual,Idactual),
    (   Idplayer == Idactual
    ->  PlayerToUse = Pactual
    ;   write('no es el turno del jugador'),nl,fail
    ),

    % ver piezas restantes
    getRemainingPiecesplayer(PlayerToUse,Pieces),
    Pieces>0,

    % color de la pieza
    getColorplayer(PlayerToUse,Color),

    % jugar pieza
    play_piece(Board,Column,Color,NewBoard),

    % creacion historial
    update_game_history(Game,Column,Color,NewGameHistory),
    game_history(NewGameHistory,History),

    % disminuir piezas
    decreasePieces(PlayerToUse,NewPlayer),
    (   CurrentTurn == 1
    ->  NGame = [NewPlayer,Player2,NewBoard,NewTurn,History]
    ;   NGame = [Player1,NewPlayer,NewBoard,NewTurn,History]
    ),

    % actualizar turno
    NewTurn is 3 - CurrentTurn,

    % verificar estado del juego
    (   who_is_winner(NewBoard,Winner), Winner \= 0
    ->  end_game(NGame,NewGame)
    ;   is_draw(NGame)
    ->  end_game(NGame,NewGame)
    ;   (   CurrentTurn == 1
        ->  NewGame = [NewPlayer,Player2,NewBoard,NewTurn,History]
        ;   NewGame = [Player1,NewPlayer,NewBoard,NewTurn,History]
        )
    ).

%Nombre: player_play
%Dominio:
%descripcion:
%Meta Primaria:
%Meta Secunbdaria:
decreasePieces(Player,UpdatedPlayer) :-
    % Obtener el ID, nombre, color, victorias, derrotas, empates y las piezas restantes del jugador
    nth1(1, Player, ID),
    nth1(2, Player, Name),
    nth1(3, Player, Color),
    nth1(4, Player, Victories),
    nth1(5, Player, Defeats),
    nth1(6, Player, Draws),
    nth1(7, Player, RemainingPieces),

    % Restar 1 a la cantidad de piezas restantes
    NewRemainingPieces is RemainingPieces - 1,

    % Crear el jugador actualizado con la nueva cantidad de piezas
    UpdatedPlayer = [ID, Name, Color, Victories, Defeats, Draws, NewRemainingPieces].

%Nombre: player_play
%Dominio:
%descripcion:
%Meta Primaria:
%Meta Secunbdaria:
% Predicado que actualiza el historial del juego
update_game_history(Game, Column, Color, NewGame) :-
    % Obtener el historial actual
    game_history(Game, History),

    % Crear el nuevo movimiento (columna y color de la pieza)
    Move = [Column, Color],  % Representa el movimiento

    % A�adir el movimiento al historial existente
    append(History, [Move], NewHistory),

    % Obtener los dem�s elementos del juego (jugadores, tablero, etc.)
    getGamePlayer1(Game, Player1),
    getGamePlayer2(Game, Player2),
    game_get_board(Game, Board),
    getGameCurrentTurn(Game, CurrentTurn),

    % Crear el nuevo estado del juego con el historial actualizado
    NewGame = [Player1, Player2, Board, CurrentTurn, NewHistory].
