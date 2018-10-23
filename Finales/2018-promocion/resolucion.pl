/*
2018 Promocion

1. Ingresar un usuario, y devolver una lista de todos los NO amigos del
usuario ingresado, que sean de la misma ciudad y tengan mas de 42 años

2. Ingresar una LISTA de usuarios, y devolver otra LISTA de usuarios que
tengan como amigos a todos los usuarios de la lista INGRESADA.

Tip: Suma puntos extra si creas una funcion propia llamada no_pertenece

Tambien se podria usar not(pertenece).

*/

abrir:-
    retractall(usu(_,_,_,_)),
    consult("c:/Users/poman/Dropbox/0_Facultad/Inteligencia Artificial/practica-ia/Finales/2018-promocion/db.txt").


inicio1:- abrir,
    writeln("Ingrese Usuario: "), read(Usu),
    retract(usu(Usu, Ciu, _, LA)),
    busNoAmigos(LA, Ciu, Lista),
    write(Lista).

busNoAmigos(LA, Ciu, [Id|T]):-
    usu(Id, Ciu, Edad, _),
    noPertenece(Id, LA),
    Edad>42,
    retract(usu(Id, Ciu, Edad, _)),
    busNoAmigos(LA, Ciu, T).
busNoAmigos(_,_,[]).

noPertenece(_, []).
noPertenece(X, [H|T]):- X\=H, noPertenece(X, T).

inicio2:- abrir,
    writeln("Ingrese lista"), leer(LU),
    busUsuarios(LU, Lista), write(Lista).

busUsuarios(LU, [Id | T]):-
    usu(Id, _, _, LA),
    contiene(LU, LA),
    retract(usu(Id, _, _, LA)),
    busUsuarios(LU, T).
busUsuarios(_, []).

contiene([], _).
contiene([H|T], LA):-
    pertenece(H, LA),
    contiene(T, LA).

pertenece(X, [X|_]).
pertenece(X, [_|T]):- pertenece(X,T).

leer([H|T]):- read(H), H\=[], leer(T).
leer([]).
