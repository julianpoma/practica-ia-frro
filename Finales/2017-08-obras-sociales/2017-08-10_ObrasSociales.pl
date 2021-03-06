/*
persona(dni,nombre,edad,obraSocial,plan).
obraSocial (obra,plan, medicamento,%cobertura).
1- devolver una lista con los DNI de las personas que tengan m�s de 65 a�os y cuyo plan cubra al menos 10 medicamentos al 100%.
2- devolver los datos de aquellas personas que tengan m�s de una obra social.
*/

:- dynamic(osocial/4).
:- dynamic(persona/5).


abrirOS:-
    retractall(osocial(_,_,_,_,_)),
    consult("c:/Users/poman/Dropbox/0_Facultad/Inteligencia Artificial/practica-ia/Finales/2017-08-obras-sociales/os.txt").

abrirPersona:-
    retractall(persona(_,_,_,_,_)),
    consult("c:/Users/poman/Dropbox/0_Facultad/Inteligencia Artificial/practica-ia/Finales/2017-08-obras-sociales/personas.txt").



inicio1:- abrirPersona, abrirOS, listado(Lista), write(Lista).

listado([Dni|T]):-
    retract(persona(Dni, _, Edad, OS, Plan)),
    Edad>=65,
    cobertura(OS, Plan, Cant),
    Cant>=3,
    listado(T).
listado([]).

cobertura(OS, Plan, Cant):-
    retract(osocial(OS, Plan, _, 100)),
    cobertura(OS, Plan, CC),
    Cant is CC + 1.
cobertura(_, _, 0):- abrirOS.

/*
 * Tengo que separar en 2 db los hechos, porque necesito recargar las
 * obras sociales, ya que al hacer el retract y no recargarlas, no estan
 * disponibles para otras personas que pueden llegar a tener la misma
 * obtra social y plan
 */


inicio2:- abrirPersona, filtrar(Lista), write(Lista).

filtrar([Dni|T]):-
    retract(persona(Dni, _, _, _, _)),
    cantOS(Dni, Cant),
    Cant > 1,
    filtrar(T).
filtrar([]).

cantOS(Dni, Cant):-
    retract(persona(Dni, _, _, _, _)),
    cantOS(Dni, C),
    Cant is C + 1.
cantOS(_, 1).



