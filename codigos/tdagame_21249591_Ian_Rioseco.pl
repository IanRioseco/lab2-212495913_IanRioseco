:- module(tdagame_21249591_ian_rioseco,[
              game/5,
              getGamePlayer1/2,
              getGamePlayer2/2,
              getGameCurrentTurn/2,
              game_history/2, is_draw/1,
              update_stats/3,
              get_current_player/2,
              game_get_board/2,
              end_game/2,
              player_play/4,
              update_game_history/4]).
:- use_module(tdaplayer_21249591_ian_rioseco).
:- use_module(tdaboard_21249591_ian_rioseco).
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
%Meta Secunbdaria: ninguna
getGamePlayer1([Player1,_,_,_,_], Player1).

%getter
%Nombre: getGamePlayer2
%Dominio: Game(game) X Player2(player)
%descripcion: predicado para obtener el jugador 2
%Meta Primaria: getGamePlayer2/2
%Meta Secunbdaria: ninguna
getGamePlayer2([_,Player2,_,_,_], Player2).

%getter
%Nombre:getGameCurrentTurn
%Dominio: Game(game) X CurrentTurn(int)
%descripcion: predicado para obtener el turno actual
%Meta Primaria: getGameCurrentTurn/2
%Meta Secunbdaria: ninguna
getGameCurrentTurn([_,_,_,CurrentTurn,_], CurrentTurn).

%Nombre:Game_History
%Dominio: Game(game) X History(lista)
%descripcion: predicado para obtener el historial
%Meta Primaria: game_history/2
%Meta Secunbdaria: ninguna
game_history([_, _, _, _, History], History).


%Nombre: is_draw
%Dominio: Game(game)
%descripcion: determina si el juego termina en empate o no
%Meta Primaria: is_draw/1
%Meta Secunbdaria:%   - game_get_board/2
                  %   - getGamePlayer1/2
                  %   - getGamePlayer2/2
                  %   - getRemainingPiecesplayer/2
                  %   - can_play/1
is_draw(Game) :-
    game_get_board(Game, Board),
    who_is_winner(Board, Winner),
    (Winner =:= 0 ->  % Si no hay ganador
        getGamePlayer1(Game, Player1),
        getGamePlayer2(Game, Player2),
        getRemainingPiecesplayer(Player1, Pieces1),
        getRemainingPiecesplayer(Player2, Pieces2),
        (Pieces1 =:= 0, Pieces2 =:= 0 -> true ; false)  % Si ambos jugadores no tienen piezas restantes
    ;
        false  % Si hay un ganador, no es empate
    ).

%Nombre: update_stats
%Dominio: Game(game) X Oldstats(player) X Newstats(player)
%descripcion: actualiza las estadisticas de la partida.
%Meta Primaria: update_stats/3
%Meta Secunbdaria:%   - game_get_board/2
                  %   - getIdplayer/2
                  %   - who_is_winner/2
                  %   - is_draw/1
update_stats(Game, Oldstats, Newstats) :-
    game_get_board(Game, Board),
    getIdplayer(Oldstats, Id),

    (   who_is_winner(Board, Winner)  % Verificamos si hay un ganador
    ->  (   Winner == Id  % Si el jugador ha ganado
        ->  update_wins(Oldstats, victory, Newstats)
        ;   (   Winner \= 0  % Si hay un ganador distinto al jugador
            ->  update_losses(Oldstats, defeat, Newstats)
            ;   Newstats = Oldstats  % Si no hay ganador, no hay cambio
            )
        )
    ;   (   is_draw(Game)  % Si hay empate
        ->  update_draws(Oldstats, draw, Newstats)
        ;   Newstats = Oldstats  % Si el juego no ha terminado, no hay cambio
        )
    ).


%Nombre: get_current_player
%Dominio: Game(game) X Player(player)
%descripcion: obtiene el jugador actual del juego
%Meta Primaria: get_current_player/2
%Meta Secunbdaria: ninguna
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
%Meta Primaria: game_get_board/2
%Meta Secunbdaria: ninguna
game_get_board([_,_,Board,_,_], Board).



%Nombre: end_game
%Dominio: Game(game) X Endgame(game)
%descripcion: genera el estado final del juego
%Meta Primaria: end_game/2
end_game(Game,EndGame):-
    getGamePlayer1(Game,Player1),
    getGamePlayer2(Game,Player2),
    game_get_board(Game,Board),
    getGameCurrentTurn(Game,Turn),
    game_history(Game,History),
    update_stats(Game,Player1,UpdateP1),
    update_stats(Game,Player2,UpdateP2),
    getWinsplayer(Player1 ,Wins1),
    getWinsplayer(Player2 ,Wins2),
    getDrawsplayer(Player1 ,Draws1),
    (   Wins1 \= 0
    ->  EndGame = [Player1, Player2, Board, Turn, History]
    ;
    ( Wins2 \= 0
    ->   EndGame = [Player1, Player2, Board, Turn, History]
    ;
    (   Draws1 \= 0
    ->   EndGame = [Player1, Player2, Board, Turn, History]
    ;    EndGame = [UpdateP1, UpdateP2, Board, Turn, History]))).


%Nombre: player_play
% Dominio: Game(game) X Player(player) X Column(int) X NewGame(game)
% Descripci�n: Realiza un movimiento para un jugador en la columna especificada.
% Meta Primaria: player_play/4
% Meta Secundaria: %   - getGamePlayer1/2
                   %   - getGamePlayer2/2
                   %   - getGameCurrentTurn/2
                   %   - game_get_board/2
                   %   - getIdplayer/2
                   %   - getRemainingPiecesplayer/2
                   %   - getColorplayer/2
                   %   - play_piece/4
                   %   - decreasePieces/2
                   %   - update_game_history/3
                   %   - who_is_winner/2
                   %   - is_draw/1
player_play(Game, Player, Column, NewGame) :-
    % Obtener los jugadores y el turno actual
    getGamePlayer1(Game, Player1),
    getGamePlayer2(Game, Player2),
    getGameCurrentTurn(Game, CurrentTurn),
    game_get_board(Game, Board),

    % Verificar turno del jugador
    (   CurrentTurn = 1
    ->  Pactual = Player1
    ;   Pactual = Player2
    ),
    getIdplayer(Player, Idplayer),
    getIdplayer(Pactual, Idactual),
    (   Idplayer = Idactual
    ->  PlayerToUse = Pactual
    ;   write('No es el turno del jugador'), nl, fail
    ),

    % Verificar piezas restantes
    getRemainingPiecesplayer(PlayerToUse, Pieces),
    (   Pieces > 0
    ->  true
    ;   write('El jugador no tiene piezas suficientes.'), nl, fail
    ),

    % Obtener color de la pieza
    getColorplayer(PlayerToUse, Color),

    % Intentar jugar la pieza
    (   play_piece(Board, Column, Color, NewBoard)
    ->  true
    ;   write('La columna est� llena o es inv�lida.'), nl, fail
    ),

    % Actualizar el historial del juego
    update_game_history(Game, Column, Color, NewGameHistory),
    game_history(NewGameHistory, History),

    % Disminuir piezas del jugador
    decreasePieces(PlayerToUse, NewPlayer),

    % Actualizar el turno
    NewTurn is 3 - CurrentTurn,

    % Crear el nuevo estado del juego
    (   CurrentTurn = 1
    ->  NGame = [NewPlayer, Player2, NewBoard, NewTurn, History]
    ;   NGame = [Player1, NewPlayer, NewBoard, NewTurn, History]
    ),

    % Verificar el estado del juego
    (   who_is_winner(NewBoard, Winner), Winner \= 0 ->
        end_game(NGame, NewGame)
    ;   is_draw(NewBoard) ->
        write('El juego termin� en empate.'), nl,
        end_game(NGame, NewGame)
    ;
        NewGame = NGame
    ).

%Nombre: update_game_history
%Dominio: Game(game) X Column(int) X Color(color) X Newgame(game)
%descripcion: genera un juego con el hiztorial actualizado
%Meta Primaria: update_game_history/4
%Meta Secunbdaria:
% Predicado que actualiza el historial del juego
update_game_history(Game, Column, Color, NewGame) :-
    % Obtener el historial actual
    game_history(Game, History),

    % se Crea el nuevo movimiento (columna y color de la pieza)
    Move = [Column, Color],  % Representa el movimiento

    % se A�ade el movimiento al historial existente
    append(History, [Move], NewHistory),

    % se Obtienen los dem�s elementos del juego (jugadores, tablero, etc.)
    getGamePlayer1(Game, Player1),
    getGamePlayer2(Game, Player2),
    game_get_board(Game, Board),
    getGameCurrentTurn(Game, CurrentTurn),

    % Crear el nuevo estado del juego con el historial actualizado
    NewGame = [Player1, Player2, Board, CurrentTurn, NewHistory].






