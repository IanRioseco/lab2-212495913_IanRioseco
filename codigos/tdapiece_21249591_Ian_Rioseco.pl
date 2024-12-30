:- module(tdapiece_21249591_ian_rioseco,[
              piece/2]).


%Nombre: piece.
%Dominio: color(string).
%descripcion: Predicado que permite crear una ficha.
%Meta Primaria: piece/1.
%Meta Secunbdaria: no contiene.
piece(Color, PieceColor):-
    PieceColor = [Color].
