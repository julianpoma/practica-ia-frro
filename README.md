# Practica de Inteligencia Artificial - UTN FRRO ISI

# MacriTips

## DB
### Borrar todo en memoria
```
retractall(hechos_a_borrar).
```

```
Ejemplo: retractall(gastos(_,_,_)).
```

### El predicado Fail
Se trata de un predicado que siempre falla. Se utiliza para obligar al Prolog a dar un fallo.

El predicado `fail.` se utiliza para realizar búsquedas en la base de datos y no quedarnos únicamente con la primera solución que satisface la búsqueda, por tanto, implica la realización del proceso de retroceso para que se generen nuevas soluciones.

Una aplicación de este predicado es entonces la generación de todas las posibles soluciones para un problema.

Recordemos que cuando la máquina Prolog encuentra una solución para y devuelve el resultado de la ejecución. Con `fail.` podemos forzar a que no pare y siga construyendo el árbol de búsqueda hasta que no queden más soluciones que mostrar.

### Porque usamos Dynamic
`:-dynamic(estudiantes/3).`
En este caso, indica que estudiantes es un predicado dinámico de aridad tres, es decir, que toma tres argumentos.

Esto tiene que ser declarado para poder utilizar los predicados y `assert | retract`

## Listas
Leer una lista
```pl
leer([H|T]):- read(H), H\=[], leer(T).
leer([]). 
```

Pertenece un elemento a una lista
```pl
pertenece(X, [X|_]).
pertenece(X, [_, T]):- pertenece(X, T).
```

**No** pertenece un elemento a una lista
```pl
noPertenece(_, []).
noPertenece(X, [H|T]):- X\=H, noPertenece(X, T).
```

Una alternativa al no pertenece
```pl
not(pertenece(X, Lista)).
```

Verificar que la L1 este contenida en L2
```pl
contenida([], _). //Cuando L1 sea vacia (la recorri toda), significa que todos los elementos estan incluidos.

contenida([H|T], L2):-
    pertenece(H, L2),
    contenida(T, L2).
```