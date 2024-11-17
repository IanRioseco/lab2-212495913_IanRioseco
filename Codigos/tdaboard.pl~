%Nombre:
%Dominio:
%descripcion:
%Meta Primaria:
%Meta Secunbdaria:
board([C1,C2,C3,C4,C5,C6]):-
    C1=[vacio,vacio,vacio,vacio,vacio,vacio,vacio],
    C2=[vacio,vacio,vacio,vacio,vacio,vacio,vacio],
    C3=[vacio,vacio,vacio,vacio,vacio,vacio,vacio],
    C4=[vacio,vacio,vacio,vacio,vacio,vacio,vacio],
    C5=[vacio,vacio,vacio,vacio,vacio,vacio,vacio],
    C6=[vacio,vacio,vacio,vacio,vacio,vacio,vacio].

%Nombre:
%Dominio:
%descripcion:
%Meta Primaria:
%Meta Secunbdaria:
can_play(Board):-
    member([vacio|_],Board), !.

%Nombre:
%Dominio:
%descripcion:
%Meta Primaria:
%Meta Secunbdaria:
% Predicado play_piece/4: coloca una ficha en la posición más baja disponible de la columna especificada
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


%Nombre:
%Dominio:
%descripcion:
%Meta Primaria:
%Meta Secunbdaria:


%Nombre:
%Dominio:
%descripcion:
%Meta Primaria:
%Meta Secunbdaria:


%Nombre:
%Dominio:
%descripcion:
%Meta Primaria:
%Meta Secunbdaria:


%Nombre:
%Dominio:
%descripcion:
%Meta Primaria:
%Meta Secunbdaria:
