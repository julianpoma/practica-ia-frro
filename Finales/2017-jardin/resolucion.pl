/*
jardin(cod, [tiposSalas]).
salas(cod, tipo, [DniAsistentes]).

1. Dada una Lista de DNIs, y un codigo de JARDIN, devolver una nueva lista
con aquellos DNIs que asisten al Jardin realmente.

2. Dada una lista de JARDINES, y una lista de TIPOS DE SALAS, devolver una lista de esos JARDINES que tengan
realmente esos tipos de SALAS

*/

abrir:- retractall(jardin(_,_)),
    retractall(salas(_,_,_)),
    consult("C:/Users/octas/Desktop/2017-jardin/db.txt").

inicio1:-
    abrir,
    writeln("Ingrese lista DNIs"), leer(LD),
    writeln("Cod Jardin: "), read(CodJ),
    busca(LD, CodJ, Lista), write(Lista).

busca([H|T1], CodJ, [H|T2]):-
    salas(CodJ, _, Asistentes),
    pertenece(H, Asistentes),
    busca(T1, CodJ, T2).
busca([_|T], CodJ, Lista):- busca(T, CodJ, Lista).
busca([], _, []).

pertenece(X, [X|_]).
pertenece(X, [_|T]):- pertenece(X, T).

leer([H|T]):- read(H), H\=[], leer(T).
leer([]).

inicio2:-
    abrir,
    writeln("Lista de Jardines"), leer(LJ),
    writeln("Lista de Salas"), leer(LS),
    compruebaSalas(LJ, LS, Lista), write(Lista).

compruebaSalas([J|T1], LS, [J|T2]):-
    jardin(J, Salas),
    contiene(LS, Salas),
    compruebaSalas(T1, LS, T2).
compruebaSalas([_|T], LS, Lista):- compruebaSalas(T, LS, Lista).
compruebaSalas([], _, []).

contiene([], _).
contiene([S|T], Salas):-
    pertenece(S, Salas),
    contiene(T, Salas).



