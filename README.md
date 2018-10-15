# Practica de Inteligencia Artificial - UTN FRRO ISI

# MacriTips

## DB
Para borrar todo en memoria
```
retractall(hechos_a_borrar).
```

**Ejemplo**
```
retractall(gastos(_,_,_)).
```

## Listas
Leer una lista
```
leer([H|T]):- read(H), H\=[], leer(T).
leer([]). 
```