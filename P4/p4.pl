%Funciones generales

abrir_base:- retractall(personas(_,_)), consult('db.txt').

save(Data):- tell('db.txt'), listing(Data), told.

%1
nuevo_gasto:- writeln("Nombre: "), read(Nombre),
    writeln("Impuesto: "), read(Impuesto),
    writeln("Monto: "), read(Monto),
    assert(gasto(Nombre, Impuesto, Monto)).

listar_gasto(Nombre):- gasto(Nombre, I, M),
    write(I), write('-'), write(M),
    fail.
listar_gasto(_).

menu1:- writeln("1. Cargar"), writeln("2. Consultar"), read(Opcion), switch(Opcion).

switch(1):- abrir_base, nuevo_gasto, save(gasto).

switch(2):- abrir_base, writeln("Nombre de la persona: "), read(Nombre), listar_gasto(Nombre).

switch(_):- menu1.

%2
%personas(codigo, nombre).

inicio2:- abrir_base,
    writeln("Ingrese cod: "), read(Cod),
    buscar(Cod).

buscar(Cod):- personas(Cod, Nom),
    retract(personas(Cod, Nom)),
    writeln("Corresponde a: "), write(Nom).
buscar(Cod):- ingresar_nuevo(Cod).

ingresar_nuevo(Cod):- writeln("No se encontraron personas"),
    writeln("Ingrese Nombre: "), read(Nom),
    assertz(personas(Cod, Nom)),
    save(personas).

%3
% alimentacion(animal, comida)
% bebida(animal, cantidad)

abrir_animal:-
    retractall(alimentacion(_,_)),
    retractall(bebida(_,_)),
    consult('C:\\Users\\poman\\Dropbox\\0_Facultad\\Inteligencia Artificial\\practica-ia\\P4\\animal.txt').

save_animal(Data):- tell('animal.txt'), listing(Data), told.

menu3:- writeln("1. Buscar habitos de animal 2. Buscar animales el habito"),
    read(Opc),
    abrir_animal,
    buscar_animales(Opc).

buscar_animales(1):- writeln("Ing animal :"), read(Animal),
    listar_alimentos(Animal),
    listar_bebidas(Animal).

buscar_animales(_):- menu3.

listar_alimentos(Animal):-
    alimentacion(Animal, Comida),
    retract(alimentacion(Animal, Comida)),
    write("Comida: "), writeln(Comida),
    listar_alimentos(Animal).
listar_alimentos(_).

listar_bebidas(Animal):-
    bebida(Animal, Cantidad),
    retract(bebida(Animal, Cantidad)),
    write("Toma agua: "), writeln(Cantidad),
    listar_bebidas(Animal).
listar_bebidas(_).


