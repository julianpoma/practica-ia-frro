# Lista de preguntas para PP8

1. Donde se ponen las condiciones de cierre? Arriba o abajo? Yo supongo que abajo cuando estoy instanciando una variable (contador en 0, lista vacia) y arriba cuando quiero comprobar algo.
2. Supongamos que tenemos que hacer un retract de lo siguiente
```
persona(Id, _, _, Algo)

tengo que hacer:
retract(persona(Id, _, _, Algo))

o puedo hacer:
retract(persona(Id, _, _, _))
```