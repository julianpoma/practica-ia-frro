/*

Final 9/3/2017

Cliente(dni,nombre,obrasocial).
Practica(cod,medico,fecha,dnicliente,asistio).

Ingresar un dni y buscar si el cliente entre todas sus practicas falto mas de un 80% y asi escribir si es posible que falte o no.

Si no hay practicas registradas para ese cliente informar que no hay datos suficientes para saberlo.

*/

:- dynamic(cliente/2).
:- dynamic(practica/5).

abrir:-
    retractall(cliente(_,_,_)),
    retractall(practica(_,_,_,_,_)),
    consult("c:/Users/poman/Dropbox/0_Facultad/Inteligencia Artificial/practica-ia/Finales/2017-03-practica-medica/db.txt").

inicio:- write("Ingrese DNI"), read(Dni),
    abrir,
    calcular(Dni, Cant),
    abrir,
    sumar(Dni, Total),
    mensaje(Cant, Total).

calcular(Dni, Contador):-
    retract(practica(_, _, _, Dni, 1)),
    calcular(Dni, Acum),
    Contador is Acum + 1.
calcular(_,0).

sumar(Dni, Suma):-
    retract(practica(_, _, _, Dni, _)),
    sumar(Dni, Acum),
    Suma is Acum + 1.
sumar(_, 0).

mensaje(_, 0):- writeln("No se poseen datos").
mensaje(Cont, Total):- X is Cont/Total, X>0.8, writeln("Asistira").
mensaje(_,_):- writeln("No asistira").
