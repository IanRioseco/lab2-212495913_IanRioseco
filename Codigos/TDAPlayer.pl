% Definición del TDA player
player(Id, Name, Color, Wins, Losses, Draws, RemainingPieces, [Id, Name, Color, Wins, Losses, Draws, RemainingPieces]).

% Predicado para obtener el Id de un jugador
getIdplayer(Player, Id):-
    player(Id,_,_,_,_,_,_, Player).

getNameplayer(Player,Name):-
    player(_,Name,_,_,_,_,_, Player).

getColorplayer(Player,Color):-
    player(_,_,Color,_,_,_,_, Player).

getWinsplayer(Player,Wins):-
    player(_,_,_,Wins,_,_,_, Player).

getLossesplayer(Player,Losses):-
    player(_,_,_,_,Losses,_,_, Player).

getDrawsplayer(Player,Draws):-
    player(_,_,_,_,_,Draws,_, Player).

getRemainingPiecesplayer(Player,RemainingPieces):-
    player(_,_,_,_,_,_,RemainingPieces, Player).


