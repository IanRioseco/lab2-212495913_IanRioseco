:-module(tdaboard_21249591_ian_rioseco,[
              board/1,
              can_play/1,
              play_piece/4,
              check_vertical_win/2,
              check_horizontal_win/2,
              check_diagonal_win/2,
              who_is_winner/2]).

%Nombre: board
% Dominio: no recibe parámetros de entrada
% Descripción: predicado que crea un tablero de conecta4.
% Meta Primaria: board/1
board([F1,F2,F3,F4,F5,F6]):-
    F1=[vacio,vacio,vacio,vacio,vacio,vacio,vacio],
    F2=[vacio,vacio,vacio,vacio,vacio,vacio,vacio],
    F3=[vacio,vacio,vacio,vacio,vacio,vacio,vacio],
    F4=[vacio,vacio,vacio,vacio,vacio,vacio,vacio],
    F5=[vacio,vacio,vacio,vacio,vacio,vacio,vacio],
    F6=[vacio,vacio,vacio,vacio,vacio,vacio,vacio].

%Nombre: can_play.
%Dominio: board.
%descripcion: verifica si es posible jugar una ficha en el tablero.
%Meta Primaria: can_play/1.
can_play(Board) :-
    member(Column, Board),
    member(vacio, Column),!.

%Nombre: play_piece.
%Dominio: Board(board) X Column(int) X Piece(piece) X NewBoard(game).
%descripcion: juega una ficha en el tablero
%Meta Primaria: play_piece/4
play_piece(Board, Column, Piece, NewBoard) :-
    % Verificar que la columna esté dentro de los límites del tablero
    %length(Board, NumRows),
    length(Board, NumCols),
    Column > 0,
    Column =< NumCols,
    % Encuentra la primera fila desde abajo que tenga un "vacio" en la columna especificada
    find_row_to_place(Board, Column, Piece, NewBoard).



%Nombre: find_row_to_place
%Dominio: Board(board)
%descripcion: funcion para encontrar una fila para poner una pieza.
%Meta Primaria: find_row_to_place/2
find_row_to_place(Board, Column, Piece, NewBoard) :-
    reverse(Board, ReversedBoard),
    place_in_column(ReversedBoard, Column, Piece, UpdatedReversedBoard),
    reverse(UpdatedReversedBoard, NewBoard).

%Nombre: place_in_columns
%Dominio: Board(board)
% descripcion: predicado para colocar la pieza en la primera posicion
% vacioa.
% Meta Primaria: place_in_columns/2 Predicado que coloca la
place_in_column([Row|RestRows], Column, Piece, [NewRow|RestRows]) :-
    nth1(Column, Row, vacio), % Verificar si la posición en la columna es vacía
    replace_in_list(Row, Column, Piece, NewRow).
place_in_column([Row|RestRows], Column, Piece, [Row|NewRestRows]) :-
    place_in_column(RestRows, Column, Piece, NewRestRows).
% Predicado que reemplaza el elemento en una posición específica de una lista
replace_in_list([_|T], 1, Piece, [Piece|T]).
replace_in_list([H|T], Index, Piece, [H|NewT]) :-
    Index > 1,
    Index1 is Index - 1,
    replace_in_list(T, Index1, Piece, NewT).


%Nombre: check_vertical_win
%Dominio: Board(board)
%descripcion: predicado que verifica si es que existe un ganador vertical
%Meta Primaria: check_vertical_win/2
check_vertical_win(Board, Winner) :-
    (   check_columns(Board, Winner),
        Winner \= 0  % Si se encuentra un ganador, detener
    ->  true
    ;   Winner = 0  % Si no se encuentra un ganador, devolver 0
    ).

% %Nombre: check_columns
%Dominio: board(board)
%descripcion: verifica si existe una pieza en alguna de las columnas.
%Meta Primaria: check_columns/2
check_columns([], 0).  % Si no hay más columnas, no hay ganador
check_columns(Board, Winner) :-
    get_column(Board, Column),  % Extraer la primera columna
    check_column(Column, Winner),  % Verificar la columna
    (   Winner \= 0 -> !  % Si hay un ganador, detener
    ;   % Si no hay ganador, continuar con el resto de las columnas
        remove_first_from_board(Board, NewBoard),  % Eliminar la primera celda de cada fila
        check_columns(NewBoard, Winner)  % Continuar verificando
    ).

% %Nombre: get_column
%Dominio: board(board)
%descripcion: obtiene la primera columna del tablero.
%Meta Primaria: get_column/2
get_column([], []).  % Si no hay filas, retornar lista vacía
get_column([Row|RestRows], [First|RestFirsts]) :-
    nth0(0, Row, First),  % Obtener el primer elemento de la fila
    get_column(RestRows, RestFirsts).  % Recursivamente se obtiene el resto de la columna

% %Nombre: check_column
%Dominio: board(board)
%descripcion: verifica si existe una pieza en alguna en una columna.
%Meta Primaria: check_column/2
check_column(Column, Winner) :-
    check_consecutive(Column, 'vacio', 0, Winner).

% %Nombre: check_consecutive
%Dominio: board(board)
%descripcion: verifica las piezas consecutivas.
%Meta Primaria: check_consecutive/2
check_consecutive([], _, Count, 0) :- Count < 4, !.  % No hay ganador si el conteo es menor que 4
check_consecutive([Cell|Rest], PrevCell, Count, Winner) :-
    (   Cell = 'vacio' ->  % Si la celda está vacía
        check_consecutive(Rest, 'vacio', 0, Winner)  % Reiniciar contador
    ;   Cell == PrevCell ->  % Si la celda es igual a la anterior
        NewCount is Count + 1,
        (   NewCount == 4 ->  % Si hay 4 consecutivas
            (   Cell = "red" -> Winner = 1;  % Ganador 1
                Cell = "yellow" -> Winner = 2  % Ganador 2
            )
        ;   check_consecutive(Rest, Cell, NewCount, Winner)  % Continuar contando
        )
    ;   check_consecutive(Rest, Cell, 1, Winner)  % Si no coincide, reiniciar conteo
    ).


% %Nombre: revome_first_from_board
%Dominio: board(board)
%descripcion: Función para eliminar el primer elemento de cada fila de un tablero.
%Meta Primaria: remove_first_from_board/2
remove_first_from_board([], []).  % Caso base: tablero vacío
remove_first_from_board([[_|TailRow] | RestRows], [TailRow | NewRestRows]) :-
    remove_first_from_board(RestRows, NewRestRows).


%Nombre: check_horizontal_win
%Dominio: board(board)
%descripcion: predicado que verifica si existe un ganador horizontal
%Meta Primaria: check_horizontal_win/2
check_horizontal_win(Board, Winner) :-
    check_columns2(Board, Winner).

% %Nombre: check_columns2
%Dominio: board(board)
%descripcion: verifica si existe una pieza en alguna de las columnas.
%Meta Primaria: check_columns2/2
check_columns2([], 0). % Caso base: No hay más columnas, no hay ganador
check_columns2([Column|Rest], Winner) :-
    check_consecutive2(Column, Winner),
    Winner \= 0; % Si hay ganador, detener recursión
    check_columns2(Rest, Winner).

% %Nombre: check_consecutive2
%Dominio: board(board)
%descripcion: verifica las piezas consecutivas.
%Meta Primaria: check_consecutive2/2
check_consecutive2(Column, Winner) :-
    append(_, [C1, C2, C3, C4|_], Column), % Verificaion de fichas consecutivas
    C1 = C2, C2 = C3, C3 = C4,
    (C1 = "red" -> Winner = 1;
     C1 = "yellow" -> Winner = 2;
     Winner = 0).


%Nombre: check_diagonal_win
%Dominio: Board(board)
%descripcion: predicaco que verifica si existe ganador diagonal
%Meta Primaria: check_diagonal_win/2
check_diagonal_win(Board, Winner) :-
    (   check_ascending_diagonal(Board, Winner)
    ;   check_descending_diagonal(Board, Winner)
    ), !.  % Detener si se encuentra un ganador
check_diagonal_win(_, 0).  % Si no hay ganador, devolver 0.

%Nombre: check_ascending_diagonal
%Dominio: Board(board)
%descripcion: verifica las diagonales ascendentes.
%Meta Primaria: check_ascending_diagonal/2
check_ascending_diagonal(Board, Winner) :-
    length(Board, Rows),
    nth0(0, Board, Row), length(Row, Cols), % Obtener dimensiones del tablero
    check_ascending_diagonal_helper(Board, Rows, Cols, Winner, 0, 0).

%Nombre: check_ascending_diagonal_helper
%Dominio: Board(board)
% descripcion: funcion auxiliar de verificacion de las diagonales
% ascendentes.
%Meta Primaria: check_ascending_diagonal_helper/2
check_ascending_diagonal_helper(Board, Rows, Cols, Winner, Row, Col) :-
    (   Row =< Rows - 4, Col =< Cols - 4 ->  % se asegura de que hay espacio para verificar
        nth0(Row, Board, Line1), nth0(Col, Line1, Cell1),
        Row1 is Row + 1, Col1 is Col + 1,
        nth0(Row1, Board, Line2), nth0(Col1, Line2, Cell2),
        Row2 is Row + 2, Col2 is Col + 2,
        nth0(Row2, Board, Line3), nth0(Col2, Line3, Cell3),
        Row3 is Row + 3, Col3 is Col + 3,
        nth0(Row3, Board, Line4), nth0(Col3, Line4, Cell4),
        (Cell1 = Cell2, Cell2 = Cell3, Cell3 = Cell4,  % Verifica la igualdad para ver si existe ganador
            (Cell1 = "red" -> Winner = 1;
             Cell1 = "yellow" -> Winner = 2)
        )
    ;   NextCol is Col + 1,
        (NextCol < Cols ->
            check_ascending_diagonal_helper(Board, Rows, Cols, Winner, Row, NextCol)
        ;
            NextRow is Row + 1,
            check_ascending_diagonal_helper(Board, Rows, Cols, Winner, NextRow, 0)  % mueve hacia la siguiente fila
        )
    ).


%Nombre: check_descending_diagonal
%Dominio: Board(board)
%descripcion: verifica las diagonales decendientes.
%Meta Primaria: check_descending_diagonal/2
check_descending_diagonal(Board, Winner) :-
    length(Board, Rows),
    nth0(0, Board, Row), length(Row, Cols), % Obtener dimensiones del tablero
    check_descending_diagonal_helper(Board, Rows, Cols, Winner, 5, 0).

%Nombre: check_descending_diagonal_helper
%Dominio: Board(board)
%descripcion: auxiliar para verificar las diagonales decendientes.
%Meta Primaria: check_descending_diagonal_helper/2
check_descending_diagonal_helper(Board, Rows, Cols, Winner, Row, Col) :-
    (   Row >= 3, Col =< Cols - 4 ->  % linea que se asegura de que hay espacio para verificar
        nth0(Row, Board, Line1), nth0(Col, Line1, Cell1),
        Row1 is Row - 1, Col1 is Col + 1,
        nth0(Row1, Board, Line2), nth0(Col1, Line2, Cell2),
        Row2 is Row - 2, Col2 is Col + 2,
        nth0(Row2, Board, Line3), nth0(Col2, Line3, Cell3),
        Row3 is Row - 3, Col3 is Col + 3,
        nth0(Row3, Board, Line4), nth0(Col3, Line4, Cell4),
        (Cell1 = Cell2, Cell2 = Cell3, Cell3 = Cell4 ->  % Verifica igualdad para obtener un ganador.
            (Cell1 = "red" -> Winner = 1;
             Cell1 = "yellow" -> Winner = 2)
        )
    ;   NextCol is Col + 1,
        (NextCol < Cols ->
            check_descending_diagonal_helper(Board, Rows, Cols, Winner, Row, NextCol)
        ;
            NextRow is Row - 1,
            check_descending_diagonal_helper(Board, Rows, Cols, Winner, NextRow, 0)  % Mover a la siguiente fila
        )
    ).

%Nombre: who_is_winner
%Dominio: Board(board)
%descripcion: predicado que verifica si existe algun ganador.
%Meta Primaria: who_is_winner/2
who_is_winner(Board, Winner) :-
    (   check_diagonal_win(Board, TempWinner),
        TempWinner \= 0
    ->  Winner = TempWinner
    ;   check_horizontal_win(Board, TempWinner),
        TempWinner \= 0
    ->  Winner = TempWinner
    ;   check_vertical_win(Board, TempWinner),
        TempWinner \= 0
    ->  Winner = TempWinner
    ;   Winner = 0
    ).
