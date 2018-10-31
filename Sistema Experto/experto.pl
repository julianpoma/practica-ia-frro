:- dynamic(celular/2).
:- dynamic(feature/2).
:- dynamic(si/1).

abrir:-
    retractall(celular(_,_)),
    retractall(feature(_,_)),
    retractall(si(_)),
    consult("db.txt").

/*
 * Abrimos la base de hechos y comenzamos con la busqueda
 */
inicio:-
    writeln("Bienvenido. Responda las siguientes preguntas para ayudarlo en su eleccion"),
    abrir,
    buscaCelular.

/*
 * Tomamos el primer celular de la DB, y preguntamos por sus caracteristicas.
 * Si el metodo falla, significa que no se pudo encontrar un celular.
 */
buscaCelular:-
    celular(Modelo, Features),
    preguntar(Modelo, Features).
buscaCelular:- writeln("Lo lamentamos, pero no pudimos encontrar un telefono con las caracteristicas que desea").

/*
 * Analizamos la lista de caracteristicas del modelo pasado como parametro.
 * 1. Tomamos la primer caracteristica, si ya fue respondida como 'si', avanzamos en la lista
 * 2. Si no fue respondida como 'si', preguntamos sobre la misma.
 * 3. Verificamos la respuesta dada por el usuario
 * 4. Si la lista de caracteristicas es vacia, significa que cumple con lo que el usuario busca,
 *    ya que todas las respuestas fueron positivas
 */
preguntar(Modelo, []):- write("Le recomendamos el siguiente modelo: "), write(Modelo).
preguntar(Modelo, [H|T]):-
    si(H),
    preguntar(Modelo, T).
preguntar(Modelo, [H|T]):-
    feature(H, Preg),
    write(Preg), writeln(" (S/N): "),
    read(Rta),
    verificar(Rta, Modelo, H, T).
/*
 * Si se responde por si a una caracteristica, se guarda en la DB la respuesta positiva y
 * se prosigue a preguntar por la proxima
 */
verificar('s', Modelo, Feature, T):-
    assertz(si(Feature)),
    preguntar(Modelo, T).

/*
 * Si se responde por no, se guarda la respuesta negativa
 * Se llama a la funcion para descartar todos los celulares que poseen esa caracteristica
 * no deseada por el usuario
 * Si responde cualquier cosa, vuelve a preguntar
 */
verificar('n', _, Feature, _):-
    descartarCelulares(Feature).

verificar(_, Modelo, Feature, T):-
    writeln("Ha ingresado una respuesta no valida!"),
    preguntar(Modelo, [Feature|T]).

/*
 * Busca los celulares con dicha caracteristica, y los elimina de la base.
 * Cuando no haya mas celulares para eliminar, continua con la busqueda.
 */
descartarCelulares(Feature):-
    celular(Modelo, Lista),
    pertenece(Feature, Lista),
    retract(celular(Modelo, Lista)),
    descartarCelulares(Feature).
descartarCelulares(_):- buscaCelular.

pertenece(X, [X|_]).
pertenece(X, [_|T]):- pertenece(X, T).






