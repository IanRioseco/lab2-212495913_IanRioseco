%Nombre: Board
%Dominio: no recibe parametros de entrada
%descripcion: predicado que crea un tablero de conecta4
%Meta Primaria:
%Meta Secunbdaria:
board([F1,F2,F3,F4,F5,F6]):-
    F1=[yellow,vacio,vacio,vacio,vacio,vacio,vacio],
    F2=[yellow,vacio,vacio,vacio,vacio,vacio,vacio],
    F3=[yellow,vacio,vacio,vacio,vacio,vacio,vacio],
    F4=[yellow,vacio,vacio,vacio,vacio,vacio,vacio],
    F5=[vacio,vacio,vacio,vacio,vacio,vacio,vacio],
    F6=[vacio,vacio,vacio,vacio,vacio,vacio,vacio].

%Nombre: can_play.
%Dominio: board.
%descripcion: verifica si es posible jugar una ficha en el tablero.
%Meta Primaria: can_play/1.
%Meta Secunbdaria:no tiene.
can_play(Board):-
    member([vacio|_],Board), !.

%Nombre: play_piece.
%Dominio: Board(board) X Column(int) X Piece(piece) X NewBoard(game).
%descripcion: juega una ficha en el tablero
%Meta Primaria: play_piece/4
%Meta Secunbdaria:
play_piece(Board, Column, Piece, NewBoard) :-
    % Verificar que la columna esté dentro de los límites del tablero
    %length(Board, NumRows),
    length(Board, NumCols),
    Column > 0,
    Column =< NumCols,
    % Encuentra la primera fila desde abajo que tenga un "vacio" en la columna especificada
    find_row_to_place(Board, Column, Piece, NewBoard).
% Predicado para encontrar la fila desde abajo donde colocar la pieza en la columna dada
find_row_to_place(Board, Column, Piece, NewBoard) :-
    reverse(Board, ReversedBoard),
    place_in_column(ReversedBoard, Column, Piece, UpdatedReversedBoard),
    reverse(UpdatedReversedBoard, NewBoard).
% Predicado que coloca la pieza en la primera posición "vacio" de una columna específica en las filas desde abajo
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
%Meta Secunbdaria:
% Verificar victoria vertical
check_vertical_win(Board, Winner) :-
    check_columns(Board, Winner).

% Recorrer las columnas del tablero
check_columns([], 0).  % Caso base: No hay más columnas, no hay ganador
check_columns(Board, Winner) :-
    check_column(Board, 0, Winner),  % Verificar la columna actual
    Winner \= 0.  % Si hay ganador, detener recursión

% Verificar una columna específica
check_column(Board, Index, Winner) :-
    find_column(Board, Index, Column),  % Encontrar la columna en el tablero
    check_consecutive(Column, Winner),  % Verificar las fichas consecutivas en esa columna
    Winner \= 0.

% Encontrar la columna en el tablero dado un índice
find_column([], _, []).  % Caso base: No más filas
find_column([Row|Rest], Index, [Cell|ColumnRest]) :-
    nth0(Index, Row, Cell),  % Obtener la celda en la fila actual
    find_column(Rest, Index, ColumnRest).

% Verificar 4 fichas consecutivas en una columna
check_consecutive(Column, Winner) :-
    length(Column, Length),
    Length >= 4,  % Solo verificamos si la columna tiene al menos 4 filas
    append(_, [C1, C2, C3, C4|_], Column),  % Verificar bloques consecutivos
    C1 = C2, C2 = C3, C3 = C4,  % Comparar las primeras 4 fichas
    (C1 = red -> Winner = 1;  % Si todas son rojas, el jugador 1 gana
     C1 = yellow -> Winner = 2;  % Si todas son amarillas, el jugador 2 gana
     Winner = 0).  % Si no hay 4 consecutivos, no hay ganador



%Nombre: check_horizontal_win
%Dominio: board(board)
%descripcion: predicado que verifica si existe un ganador horizontal
%Meta Primaria: check_horizontal_win/2
%Meta Secunbdaria:
check_horizontal_win(Board, Winner) :-
    check_columns2(Board, Winner).
% Recorrer columnas del tablero
check_columns2([], 0). % Caso base: No hay más columnas, no hay ganador
check_columns2([Column|Rest], Winner) :-
    check_consecutive2(Column, Winner),
    Winner \= 0; % Si hay ganador, detener recursión
    check_columns2(Rest, Winner).
% Verificar 4 fichas consecutivas en una columna
check_consecutive2(Column, Winner) :-
    append(_, [C1, C2, C3, C4|_], Column), % Verificar bloques consecutivos
    C1 = C2, C2 = C3, C3 = C4,
    (C1 = red -> Winner = 1;
     C1 = yellow -> Winner = 2;
     Winner = 0).


%Nombre: check_diagonal_win
%Dominio: Board(board)
%descripcion: predicaco que verifica si existe ganador diagonal
%Meta Primaria: check_diagonal_win/2
%Meta Secunbdaria:
% Verificar victoria diagonal
check_diagonal_win(Board, Winner) :-
    (check_ascending_diagonal(Board, Winner), Winner \= 0;  % Verificar diagonales ascendentes
     check_descending_diagonal(Board, Winner), Winner \= 0), !. % Verificar diagonales descendentes
check_diagonal_win(_, 0).  % Si no hay ganador, devolver 0.

% Verificar diagonales ascendentes
check_ascending_diagonal(Board, Winner) :-
    length(Board, Rows),
    nth0(0, Board, Row), length(Row, Cols), % Obtener dimensiones del tablero
    between(0, Rows, StartRow),             % Iterar sobre filas de inicio
    between(0, Cols, StartCol),             % Iterar sobre columnas de inicio
    check_ascending_from(StartRow, StartCol, Board, Winner).
% Verificar 4 consecutivos en diagonal ascendente desde una posición
check_ascending_from(Row, Col, Board, Winner) :-
    nth0(Row, Board, Line1), nth0(Col, Line1, Cell1),
    Row1 is Row + 1, Col1 is Col + 1,
    nth0(Row1, Board, Line2), nth0(Col1, Line2, Cell2),
    Row2 is Row + 2, Col2 is Col + 2,
    nth0(Row2, Board, Line3), nth0(Col2, Line3, Cell3),
    Row3 is Row + 3, Col3 is Col + 3,
    nth0(Row3, Board, Line4), nth0(Col3, Line4, Cell4),
    (Cell1 = Cell2, Cell2 = Cell3, Cell3 = Cell4,  % Verificar igualdad
     (Cell1 = red -> Winner = 1;
      Cell1 = yellow -> Winner = 2)).
% Verificar diagonales descendentes
check_descending_diagonal(Board, Winner) :-
    length(Board, Rows),
    nth0(0, Board, Row), length(Row, Cols), % Obtener dimensiones del tablero
    between(0, Rows, StartRow),             % Iterar sobre filas de inicio
    between(0, Cols, StartCol),             % Iterar sobre columnas de inicio
    check_descending_from(StartRow, StartCol, Board, Winner).

% Verificar 4 consecutivos en diagonal descendente desde una posición
check_descending_from(Row, Col, Board, Winner) :-
    nth0(Row, Board, Line1), nth0(Col, Line1, Cell1),
    Row1 is Row - 1, Col1 is Col + 1,
    nth0(Row1, Board, Line2), nth0(Col1, Line2, Cell2),
    Row2 is Row - 2, Col2 is Col + 2,
    nth0(Row2, Board, Line3), nth0(Col2, Line3, Cell3),
    Row3 is Row - 3, Col3 is Col + 3,
    nth0(Row3, Board, Line4), nth0(Col3, Line4, Cell4),
    (Cell1 = Cell2, Cell2 = Cell3, Cell3 = Cell4,  % Verificar igualdad
     (Cell1 = red -> Winner = 1;
      Cell1 = yellow -> Winner = 2)).

%Nombre: who_is_winner
%Dominio: Board(board)
%descripcion: predicado que verifica si existe algun ganador.
%Meta Primaria: who_is_winner/2
%Meta Secunbdaria:
who_is_winner(Board, Winner) :-
    (check_horizontal_win(Board, Winner), Winner \= 0);  % Verifica ganador horizontal
    (check_vertical_win(Board, Winner), Winner \= 0);    % Verifica ganador vertical
    (check_diagonal_win(Board, Winner), Winner \= 0),    % Verifica ganador diagonal
    !. % Detiene la evaluación si ya se encontró un ganador

who_is_winner(_, 0). % Caso base: No hay ganador.

