% Declarar los predicados como dinámicos
:- dynamic agregar_empleado/1.
:- dynamic borrar_empleado/1.
:- dynamic borrar_empleado_por_nombre/1.
:- dynamic consultar_empleado/1.
:- dynamic consultar_empleado_por_nombre/1.

inicializar_id_contador :- 
    (retract(id_contador(_)); true), 
    assertz(id_contador(0)).

% Generar un nuevo ID de turno
nuevo_id(NuevoID) :- 
    retract(id_contador(ActualID)), 
    NuevoID is ActualID + 1, 
    assertz(id_contador(NuevoID)).

% Funciones CRUD para empleados
agregar_empleado(Nombre) :-
    nuevo_id(ID),
    assertz(empleado(ID, Nombre)),
    write('Empleado agregado: '), write(ID), write(' - '), write(Nombre), nl,
    registrar_accion('Agregar', 'Empleado', ID),
    guardar_datos.

borrar_empleado(ID) :-
    empleado(ID, Nombre),
    retractall(empleado(ID, Nombre)),
    retractall(cargo_empleado(ID, _)),
    retractall(tarea(_, ID)),
    retractall(evaluacion(ID, _, _, _)),
    write('Empleado borrado: '), write(ID), write(' - '), write(Nombre), nl,
    registrar_accion('Borrar', 'Empleado', Nombre),
    guardar_datos.

% % Borrar empleado por nombre
% borrar_empleado_por_nombre(Nombre) :-
%     empleado(ID, Nombre),
%     borrar_empleado(ID),
%     write('Empleado borrado: '), write(Nombre), nl.

consultar_empleado(ID) :-
    empleado(ID, Nombre),
    format('--- Información del Empleado ---~n'),
    format('ID: ~w~n', [ID]),
    format('Nombre: ~w~n', [Nombre]),
    findall(Cargo, cargo_empleado(ID, Cargo), Cargos),
    format('Cargos: ~w~n', [Cargos]),
    findall((Tarea, Reward), tarea(Tarea, ID, Reward), Tareas),
    format('Tareas:~n'),
    forall(member((Tarea, Reward), Tareas),
           format('  - Tarea: ~w, Puntos: ~w~n', [Tarea, Reward])),
    findall((IDTurno, Fecha), asignacion_turno(ID, IDTurno, Fecha), Turnos),
    format('Turnos:~n'),
    forall(member((IDTurno, Fecha), Turnos),
           (turno(IDTurno, HoraInicio, HoraFin, Cargo, _),
            format('  - Turno ID: ~w, Fecha: ~w, HoraInicio: ~w:00, HoraFin: ~w:00, Cargo: ~w~n', [IDTurno, Fecha, HoraInicio, HoraFin, Cargo]))),
    format('--- Fin de la Información ---~n'),
    registrar_accion('Consultar', 'Empleado', Nombre).

% % Consultar empleado por nombre
% consultar_empleado_por_nombre(Nombre) :-
%     empleado(ID, Nombre),
%     consultar_empleado(ID),
%     write('Empleado consultado: '), write(Nombre), nl.
