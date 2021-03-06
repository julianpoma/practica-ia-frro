/*Los ... son datos que no eran relevantes para el desarrollo del ejercicio):

catedra(nombre_catedra,...).
comision(nombre_catedra,comision,ciclo,...,[legajos de inscriptos]).
alumno(legajo,nombre,...).

* Aclaracion: una catedra puede tener muchas comisiones *

Te pedia:
1- Devolver lista [] de las catedras del ciclo 2017 que tengan m�s de 100 inscriptos en sus comisiones.
2- Mostrar las catedras en las que se encuentra inscripto un alumno
(ingresando el legajo) tambien en el ciclo 2017.*/

abrir():-
    retractall(catedra(_,_)),
    retractall(comision(_,_,_,_)),
    retractall(alumno(_,_)),
    consult("C:/Users/poman/Dropbox/0_Facultad/Inteligencia Artificial/practica-ia/Finales/2017-09-comisiones/db.txt").


inicio1():- abrir, filtrar(Lista), write(Lista).

filtrar([Cat|T]):-
    retract(catedra(Cat,_)),
    contar(Cat, Cant),
    Cant > 9,
    filtrar(T).
filtrar([]).

contar(Cat, CantCatedra):-
    retract(comision(Cat, _, 2017, LA)),
    contarLista(LA, CantLista),
    contar(Cat, CC),
    CantCatedra is CC + CantLista.
contar(_, 0).

contarLista([_|T], Cant):-
    contarLista(T, C),
    Cant is C + 1.
contarLista([], 0).


inicio2():- abrir,
    write("Ingresar alumno: "), read(Nombre),
    retract(alumno(Alu, Nombre)),
    busca(Alu).

busca(Alu):-
    retract(comision(Catedra, _, 2017, ListaAlumno)),
    pertenece(Alu, ListaAlumno),
    write(Catedra), writeln("-"),
    busca(Alu).
busca(_).

pertenece(X, [X|_]).
pertenece(X, [_|T]):- pertenece(X,T).
