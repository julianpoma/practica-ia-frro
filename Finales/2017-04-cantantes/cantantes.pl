/*

1)Ingrese un álbum y una lista [] de temas y a partir de esto devolver una lista
con aquellos temas de la lista original que correspondan al álbum ingresado.

2)Informar cuantos álbumes fueron lanzados en un determinado año (dato de entrada)
por cantantes de origen sueco.

3)Ingresar un cantante y devolver una lista con todos los albumes que haya lanzado
a lo largo de su carrera y cuya cantidad de copias supere el millón.

*/
:- dynamic(album/5).
:- dynamic(cantante/2).


abrir:- retractall(album(_,_,_,_,_)),
    retractall(cantante(_,_)),
    consult("c:/Users/poman/Dropbox/0_Facultad/Inteligencia Artificial/practica-ia/Finales/2017-04-cantantes/db.txt").

inicio1:-
    abrir,
    writeln("Ingrese un album"), read(Album),
    writeln("Ingrese lista de temas"), leer(Temas),
    album(Album,_,TemasOrig,_,_),
    busca(Temas, TemasOrig, Lista), write(Lista).

busca([H|T1], TemasOrig, [H|T2]):-
    pertenece(H, TemasOrig),
    busca(T1, TemasOrig, T2).
busca([_|T1], TemasOrig, Lista):- busca(T1, TemasOrig, Lista).
busca([], _, []).

pertenece(X, [X|_]).
pertenece(X, [_|T]):- pertenece(X,T).

leer([H|T]):- read(H), H\=[], leer(T).
leer([]).


inicio2:- abrir,
    writeln("Ingrese anio"), read(A),
    cuantos(A, Suma), write(Suma).

cuantos(A, Suma):-
    retract(cantante(Cantante, 'suecia')),
    contarAlbum(Cantante, A, C),
    cuantos(A, Acum),
    Suma is C + Acum.
cuantos(_, 0).

contarAlbum(Cantante, A, Cant):-
    album(_, Cantante, _, Fecha, _),
    sub_atom(Fecha, _, 4, 0, A),
    retract(album(_, Cantante,_,Fecha,_)),
    contarAlbum(Cantante, A, Acum),
    Cant is Acum + 1.
contarAlbum(_,_,0).

inicio3:- abrir,
    writeln("Ingresar un cantante"), read(Cantante),
    cantante(Cantante, _),
    buscarAlbum(Cantante, Lista), write(Lista).

buscarAlbum(C, [A|T]):-
    album(A, C,_,_, Copias),
    Copias > 1000000,
    retract(album(A, _, _, _, Copias)),
    buscarAlbum(C, T).
buscarAlbum(_, []).
