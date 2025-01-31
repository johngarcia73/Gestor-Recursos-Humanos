% Archivo: motor_inferencia.pl

% Declarar los predicados como dinámicos
:- dynamic empleado/2.
:- dynamic cargo/1.
:- dynamic cargo_empleado/2.
:- dynamic tarea/3.
:- dynamic evaluacion/4.
:- dynamic registro_accion/4.
:- dynamic id_contador/1.
:- dynamic preferencia/3.
:- dynamic asignacion_turno/3.

% Registrar una acción
registrar_accion(TipoAccion, Entidad, Detalles) :-
    fecha_actual(Fecha),
    assertz(registro_accion(TipoAccion, Entidad, Detalles, Fecha)).

% Generar reporte de acciones
generar_reporte :-
    findall((TipoAccion, Entidad, Detalles, Fecha), registro_accion(TipoAccion, Entidad, Detalles, Fecha), Registros),
    write('Reporte de acciones:'), nl,
    writeln(Registros).

% Guardar la base de datos en un archivo
guardar_datos :-
    tell('base_conocimientos.pl'),
    listing(empleado),
    listing(cargo),
    listing(cargo_empleado),
    listing(tarea),
    listing(evaluacion),
    listing(registro_accion),
    listing(id_contador),
    listing(id_contador_turno),
    listing(turno),
    listing(limite_turnos),
    listing(asignacion_turno),
    listing(cooldown_turno),
    told.

% Cargar la base de datos desde un archivo
cargar_datos :-
    consult('base_conocimientos.pl').

