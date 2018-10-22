/*
 * Base de hechos
vehículo (Cod,...,[Características]).
características puede ser A/C, levanta vidrios,etc
ventas(CodVeh, Fecha....).
Fecha tiene formato dd/mm/aaaa
1)Ingresar una característica y devolver una lista [] con los códigos de todos los autos que tengan esa característica.
2)Ingresar una lista [] de códigos de auto y un Año y armar una nueva lista [] con los códigos de esos autos, que tengan más de 10 ventas.
*
*/
:- dynamic(vehiculo/2).
:- dynamic(ventas/2).

abrir():- retractall(vehiculo(_,_)),
    retractall(ventas(_,_)),
    consult('C:/Users/poman/Dropbox/0_Facultad/Inteligencia Artificial/practica-ia/Finales/2017-promocion/base.txt').

menu:- writeln("1. Apartado 1 2. Apartado 2"), read(Opc), apartado(Opc).

apartado(1):-
    abrir,
    writeln("Ingrese una caracteristica: "), read(Caract),
    mostrar(Caract, Lista), write(Lista).

mostrar(Caract, [Cod|T]):-
    retract(vehiculo(Cod, ListaCaract)),
    pertenece(Caract, ListaCaract),
    mostrar(Caract, T).

mostrar(_, []).

pertenece(X,[X|_]).
pertenece(X,[_|T]):- pertenece(X,T).

apartado(2):- writeln("Ingrese una lista de codigos "), leer(ListaCod),
    writeln("Ingrese un anio: "), read(Anio),
    abrir,
    filtrar(ListaCod, Anio, ListaFinal), write(ListaFinal).

filtrar([Cod|T1], Anio, [Cod|T2]):-
    cuenta_ventas(Cod, Anio, Cant),
    Cant>2,
    filtrar(T1, Anio, T2).
filtrar([_|T], Anio, ListaFinal):- filtrar(T, Anio, ListaFinal).
filtrar([], _, []).

cuenta_ventas(Cod, Anio, Contador):-
    retract(ventas(Cod, Fecha)),
    sub_atom(Fecha,_,_,_,Anio),
    cuenta_ventas(Cod, Anio, C),
    Contador is C + 1.
cuenta_ventas(_, _, 0).

leer([H|T]):- read(H), H\=[], leer(T).
leer([]).
