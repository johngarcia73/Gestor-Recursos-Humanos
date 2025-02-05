% Archivo: turno.pl

% Declarar los predicados como dinámicos
:- dynamic turno/5.
:- dynamic limite_turnos/2.
:- dynamic asignacion_turno/3.
:- dynamic cooldown_turno/2.
:- dynamic id_contador_turno/1.

:- use_module(library(date)).

% Estructura de turno: turno(IDTurno, HoraInicio, HoraFin, Cargo, Cooldown)
% Estructura de límite de turnos: limite_turnos(Cargo, Limite)
% Estructura de asignación de turno: asignacion_turno(IDEmpleado, IDTurno, Fecha)
% Estructura de cooldown de turnos: cooldown_turno(IDEmpleado, FechaFin)

% Inicializar el contador de ID de turnos
inicializar_id_contador_turno :- 
    (retract(id_contador_turno(_)); true), 
    assertz(id_contador_turno(0)).

% Generar un nuevo ID de turno
nuevo_id_turno(NuevoID) :- 
    retract(id_contador_turno(ActualID)), 
    NuevoID is ActualID + 1, 
    assertz(id_contador_turno(NuevoID)).


% Agregar turno
agregar_turno(HoraInicio, HoraFin, Cargo, Cooldown) :-
    (HoraInicio >= 0, HoraInicio =< 23, HoraFin >= 0, HoraFin =< 23 ->
        (cargo(Cargo) ->
            (turno(_, HoraInicio, HoraFin, Cargo, Cooldown) ->
                format('Error: El turno con HoraInicio: ~w, HoraFin: ~w, Cargo: ~w, Cooldown: ~w ya existe.~n', [HoraInicio, HoraFin, Cargo, Cooldown])
            ;
                nuevo_id_turno(IDTurno),
                assertz(turno(IDTurno, HoraInicio, HoraFin, Cargo, Cooldown)),
                format('Turno agregado: ID ~w, HoraInicio: ~w, HoraFin: ~w, Cargo: ~w, Cooldown: ~w~n', [IDTurno, HoraInicio, HoraFin, Cargo, Cooldown])
            )
        ;
            format('Error: El cargo ~w no existe.~n', [Cargo])
        )
    ;
        format('Error: La hora de inicio y fin deben estar entre 0 y 23.~n')
    ).


% Agregar turno por detalles
agregar_turno_por_detalles(HoraInicio, HoraFin, Cargo, Cooldown) :-
    agregar_turno(HoraInicio, HoraFin, Cargo, Cooldown).


% Borrar turno
borrar_turno(IDTurno) :- 
    listar_todos_los_turnos,
    retractall(turno(IDTurno, _, _, _, _)), 
    retractall(asignacion_turno(_, IDTurno, _)),
    format('Turno borrado: ID ~w~n', [IDTurno]).

% Listar todos los turnos disponibles
listar_todos_los_turnos :- 
    findall((IDTurno, HoraInicio, HoraFin, Cargo, Cooldown), turno(IDTurno, HoraInicio, HoraFin, Cargo, Cooldown), Turnos),
    writeln('Turnos disponibles:'),
    forall(member((IDTurno, HoraInicio, HoraFin, Cargo, Cooldown), Turnos),
           format('ID: ~w, HoraInicio: ~w:00, HoraFin: ~w:00, Cargo: ~w, Cooldown: ~w días~n', [IDTurno, HoraInicio, HoraFin, Cargo, Cooldown])).

% Verificar diferencia de días entre dos fechas
fecha_diferencia(Fecha1, Fecha2, Dias) :- 
    parse_time(Fecha1, iso_8601, Timestamp1), 
    parse_time(Fecha2, iso_8601, Timestamp2), 
    Dias is abs(Timestamp2 - Timestamp1) / 86400.

% Calcular la fecha final del cooldown
calcular_fecha_fin(FechaInicio, Dias, FechaFin) :- 
    parse_time(FechaInicio, iso_8601, TimestampInicio), 
    TimestampFin is TimestampInicio + (Dias + 1) * 86400, 
    format_time(atom(FechaFin), '%Y-%m-%d', TimestampFin).

% Verificar el cooldown de un empleado
verificar_cooldown(IDEmpleado, Fecha) :- 
    ( cooldown_turno(IDEmpleado, FechaFin) ->
        parse_time(Fecha, iso_8601, TimestampFecha), 
        parse_time(FechaFin, iso_8601, TimestampFechaFin), 
        TimestampFecha >= TimestampFechaFin
    ; true ).


limite_semanal(IDEmpleado, Cargo, Fecha) :-
    parse_time(Fecha, iso_8601, Timestamp),
    TimestampInicio is Timestamp - 6 * 86400, % 7 días consecutivos
    format_time(atom(_FechaInicio), '%Y-%m-%d', TimestampInicio),
    findall(FechaAsignada, 
            (asignacion_turno(IDEmpleado, IDTurno, FechaAsignada), 
             turno(IDTurno, _, _, Cargo, _), 
             parse_time(FechaAsignada, iso_8601, TimestampAsignada), 
             TimestampAsignada >= TimestampInicio, 
             TimestampAsignada =< Timestamp), 
            FechasAsignadas),
    length(FechasAsignadas, NumeroTurnos),
    limite_turnos(Cargo, Limite),
    NumeroTurnos < Limite.


% Asignar turnos automáticamente considerando cooldown y límite semanal
asignar_turno(IDEmpleado, IDTurno, Fecha) :- 
    turno(IDTurno, HoraInicio, HoraFin, Cargo, Cooldown), 
    empleado(IDEmpleado, Nombre), 
    cargo_empleado(IDEmpleado, Cargo), 
    (not(asignacion_turno(IDEmpleado, _, Fecha)) ->
        (verificar_cooldown(IDEmpleado, Fecha) ->
            (limite_semanal(IDEmpleado, Cargo, Fecha) ->
                assertz(asignacion_turno(IDEmpleado, IDTurno, Fecha)), 
                calcular_fecha_fin(Fecha, Cooldown, FechaFin), 
                retractall(cooldown_turno(IDEmpleado, _)), 
                assertz(cooldown_turno(IDEmpleado, FechaFin)), 
                format('Empleado: ~w, Cargo: ~w, se le asigna el turno ~w:00-~w:00 en la fecha ~w~n', [Nombre, Cargo, HoraInicio, HoraFin, Fecha]),
                guardar_datos
            ;
                format('Error: El empleado ~w ha alcanzado el límite semanal de turnos para el cargo ~w.~n', [Nombre, Cargo])
            )
        ;
            cooldown_turno(IDEmpleado, FechaFin),
            format('Error: El empleado ~w está en cooldown hasta la fecha ~w.~n', [Nombre, FechaFin])
        )
    ;
        format('Error: El empleado ~w ya tiene un turno asignado en la fecha ~w.~n', [Nombre, Fecha])
    ).

% Planificar turnos recorriendo todos los cargos y asignando turnos a empleados disponibles
planificar_turnos(Fecha) :- 
    findall(Cargo, cargo(Cargo), Cargos), 
    asignar_turnos_por_cargo(Cargos, Fecha), 
    write('Turnos planificados para la fecha '), writeln(Fecha), 
    listar_asignaciones(Fecha).

% Asignar turnos por cargo
asignar_turnos_por_cargo([], _).
asignar_turnos_por_cargo([Cargo | Resto], Fecha) :- 
    findall(IDTurno, turno(IDTurno, _, _, Cargo, _), Turnos), 
    asignar_turnos_empleados(Cargo, Turnos, Fecha), 
    asignar_turnos_por_cargo(Resto, Fecha).

% Asignar turnos a empleados disponibles para un cargo específico
asignar_turnos_empleados(_, [], _).
asignar_turnos_empleados(Cargo, [IDTurno | RestoTurnos], Fecha) :- 
    findall(IDEmpleado, cargo_empleado(IDEmpleado, Cargo), Empleados), 
    asignar_empleado(IDTurno, Empleados, Fecha), 
    asignar_turnos_empleados(Cargo, RestoTurnos, Fecha).

% Asignar un turno a un empleado disponible
asignar_empleado(IDTurno, [IDEmpleado | RestoEmpleados], Fecha) :- 
    (   asignar_turno(IDEmpleado, IDTurno, Fecha)
    ->  true
    ;   asignar_empleado(IDTurno, RestoEmpleados, Fecha)).
asignar_empleado(_, [], _) :- true.

% Listar asignaciones de turnos para una fecha específica
listar_asignaciones(Fecha) :- 
    findall((NombreEmpleado, Cargo, HoraInicio, HoraFin), 
            (asignacion_turno(IDEmpleado, IDTurno, Fecha), 
             empleado(IDEmpleado, NombreEmpleado), 
             turno(IDTurno, HoraInicio, HoraFin, Cargo, _)), 
            Asignaciones), 
    write('Asignaciones para la fecha '), write(Fecha), writeln(':'), 
    forall(member((NombreEmpleado, Cargo, HoraInicio, HoraFin), Asignaciones), 
           format('Empleado: ~w, Cargo: ~w, Turno: ~w:00-~w:00~n', [NombreEmpleado, Cargo, HoraInicio, HoraFin])).

% Consultar turnos por cargo
consultar_turnos_por_cargo(Cargo) :-
    findall((IDTurno, HoraInicio, HoraFin), turno(IDTurno, HoraInicio, HoraFin, Cargo, _), Turnos),
    format('Turnos disponibles para el cargo ~w:~n', [Cargo]),
    forall(member((IDTurno, HoraInicio, HoraFin), Turnos),
           format('ID: ~w, HoraInicio: ~w:00, HoraFin: ~w:00~n', [IDTurno, HoraInicio, HoraFin])).

% Asignar turno a un empleado por nombre
asignar_turno_a_empleado_por_nombre(NombreEmpleado, Fecha, IDTurno) :-
    (empleado(IDEmpleado, NombreEmpleado), cargo_empleado(IDEmpleado, Cargo) ->
        (turno(IDTurno, _, _, Cargo, _) ->
            asignar_turno(IDEmpleado, IDTurno, Fecha)
        ;
            format('Error: Turno con ID ~w no encontrado para el cargo ~w.~n', [IDTurno, Cargo])
        )
    ;
        format('Error: Empleado ~w no encontrado o no tiene un cargo asignado.~n', [NombreEmpleado])
    ).

% Eliminar una asignación de turno en una fecha específica
eliminar_asignacion_turno_por_fecha(NombreEmpleado, Fecha) :-
    empleado(IDEmpleado, NombreEmpleado),
    (asignacion_turno(IDEmpleado, IDTurno, Fecha) ->
        retract(asignacion_turno(IDEmpleado, IDTurno, Fecha)),
        format('Asignación de turno eliminada para el empleado ~w en la fecha ~w~n', [NombreEmpleado, Fecha]),
        guardar_datos
    ;
        format('Error: No se encontró una asignación de turno para el empleado ~w en la fecha ~w~n', [NombreEmpleado, Fecha])
    ).

% Eliminar todas las asignaciones de turno en una fecha específica
eliminar_todas_asignaciones_para_fecha(Fecha) :-
    findall((IDEmpleado, IDTurno), asignacion_turno(IDEmpleado, IDTurno, Fecha), Asignaciones),
    forall(member((IDEmpleado, IDTurno), Asignaciones),
           retract(asignacion_turno(IDEmpleado, IDTurno, Fecha))),
    format('Todas las asignaciones de turno eliminadas para la fecha ~w~n', [Fecha]),
    guardar_datos.

% Modificar el cooldown de un empleado
modificar_cooldown_empleado(IDEmpleado, NuevaFechaCooldown) :-
    (cooldown_turno(IDEmpleado, _) ->
        retractall(cooldown_turno(IDEmpleado, _)),
        assertz(cooldown_turno(IDEmpleado, NuevaFechaCooldown)),
        format('Cooldown modificado para el empleado con ID ~w. Nuevo cooldown hasta la fecha ~w.~n', [IDEmpleado, NuevaFechaCooldown]),
        guardar_datos
    ;
        format('Error: No se encontró un cooldown existente para el empleado con ID ~w.~n', [IDEmpleado])
    ).

% Obtener la fecha actual en formato ISO 8601
obtener_fecha_actual(FechaActual) :-
    get_time(Timestamp),
    format_time(atom(FechaActual), '%Y-%m-%d', Timestamp).

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
