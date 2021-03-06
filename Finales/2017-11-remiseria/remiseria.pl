/*
 * Si no recuerdo mal fue de una remiser�a. Era algo as�:
auto(nro_movil, patente, un par de cosas mas)
viaje(nro_movil, costo)
Y te ped�an:
1. Monto total acumulado por cada auto
2. Dada una lista de autos devolver de esa lista cuales tenian al menos un viaje con costo mayor a 300
 *
 */

leerbase:-
    retractall(auto(_,_)),
    retractall(viaje(_,_)),
    consult("C:/Users/poman/Dropbox/0_Facultad/Inteligencia Artificial/practica-ia/Finales/2017-11-remiseria/db.txt").

menu:- writeln("1. 2."), read(Opc),
    leerbase,
    apartado(Opc).

apartado(1):-
    retract(auto(Cod,_)),
    acumulado(Cod, Suma),
    write("Auto: "), writeln(Cod),
    write("Suma: "), writeln(Suma),
    apartado(1).
apartado(1).


acumulado(Cod, Suma):-
    retract(viaje(Cod, Parcial)),
    acumulado(Cod, Sum),
    Suma is Sum + Parcial.
acumulado(_, 0).

apartado(2):-
    writeln("Ingrese lista de autos: "),
    leer(Lista),
    filtrar(Lista, ListaFiltrada),
    write(ListaFiltrada).

filtrar([Auto|T1], [Auto|T2]):-
    retract(viaje(Auto,Costo)),
    Costo>100,
    filtrar(T1, T2).

filtrar([_|T],Lista):- filtrar(T, Lista).

filtrar([],[]).

leer([H|T]):- read(H), H\=[], leer(T).
leer([]).


