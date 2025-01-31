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
    nuevo_id_turno(IDTurno), 
    assertz(turno(IDTurno, HoraInicio, HoraFin, Cargo, Cooldown)), 
    format('Turno agregado: ID ~w, HoraInicio: ~w, HoraFin: ~w, Cargo: ~w, Cooldown: ~w~n', [IDTurno, HoraInicio, HoraFin, Cargo, Cooldown]).

% Borrar turno
borrar_turno(IDTurno) :- 
    retractall(turno(IDTurno, _, _, _, _)), 
    format('Turno borrado: ID ~w~n', [IDTurno]).

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
    not(asignacion_turno(IDEmpleado, _, Fecha)), 
    verificar_cooldown(IDEmpleado, Fecha), 
    limite_semanal(IDEmpleado, Cargo, Fecha), % Verificar límite semanal
    assertz(asignacion_turno(IDEmpleado, IDTurno, Fecha)), 
    calcular_fecha_fin(Fecha, Cooldown, FechaFin), 
    retractall(cooldown_turno(IDEmpleado, _)), 
    assertz(cooldown_turno(IDEmpleado, FechaFin)), 
    format('Empleado: ~w, Cargo: ~w, se le asigna el turno ~w:00-~w:00 en la fecha ~w~n', [Nombre, Cargo, HoraInicio, HoraFin, Fecha]).

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
