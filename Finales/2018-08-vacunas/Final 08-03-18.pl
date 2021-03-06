/*
08-03-2018

ni�o(nombre, edad, [vacunas_aplicadas])
vacunas_edad(edad_desde, edad_hasta, [vacunas_a_aplicarse])
vacuna(nombre, [enfermedad_previene])

1. Ingrese el nombre de un ni�o y segun su edad, mostrar una lista de
las vacunas que faltan aplicarse
2. Ingresar una enfermedad y mostrar una lista de las enfermedades que
previene.
*/

menu:- writeln("Apartado 1."),
    writeln("Apartado 2"),
    read(Opc),
    opc(Opc).

abrir:-
    retractall(nino(_,_,_)),
    retractall(vacunas_edad(_,_,_)),
    retractall(vacunas(_,_)),
    consult("C:/Users/poman/Dropbox/0_Facultad/Inteligencia Artificial/practica-ia/Finales/2018-08-vacunas/db.txt").

opc(1):-
    abrir,
    writeln("Ingrese nombre: "), read(Nombre),
    nino(Nombre, Edad, VacAplicadas),
    determinar_vacunas(Edad, VacAplicadas, VacFaltantes),
    writeln(VacFaltantes).

determinar_vacunas(Edad, VA, [VF|T]):-
    retract(vacunas_edad(Desde, Hasta, Vacunas)),
    Desde=<Edad,
    Hasta>=Edad,
    comparar(Vacunas, VA, VF),
    determinar_vacunas(Edad, VA, T).

determinar_vacunas(_,_,[]).

%Instancio la lista K de vacunas por aplicar, cuando termino de recorrer
%la lista de vacunas de la edad
comparar([], _, []).

%la vacuna a aplicar, ya fue aplicada? Si es asi, no hago nada y
%avanzo en la lista
comparar([H|T], VacunasAplicadas, K):-
    pertenece(H, VacunasAplicadas),
    comparar(T, VacunasAplicadas, K).

% Caso contrario, agrego la vacuna a aplicar a la lista de vacunas por
% aplicar
comparar([H|T1], VacunasAplicadas, [H|T2]):- comparar(T1, VacunasAplicadas, T2).



pertenece(X, [X|_]).
pertenece(X, [_|T]):- pertenece(X,T).


opc(_):- menu.
