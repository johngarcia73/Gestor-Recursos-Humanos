% Archivo: usuario.pl

% Declarar los predicados como dinámicos
:- dynamic agregar_empleado_por_nombre/1.
:- dynamic agregar_cargo_por_nombre/1.
:- dynamic borrar_cargo_por_nombre/1.
:- dynamic consultar_cargo_por_nombre/1.
:- dynamic asignar_cargo_a_empleado/2.
:- dynamic eliminar_cargo_de_empleado/2.
:- dynamic consultar_cargos_de_empleado/1.
:- dynamic agregar_tarea_a_empleado/3.
:- dynamic borrar_tarea_de_empleado/2.
:- dynamic consultar_tarea_de_empleado/2.
:- dynamic completar_tarea_de_empleado/2.
:- dynamic obtener_tareas_de_empleado/1.
:- dynamic recomendar_tareas_a_empleado/1.
:- dynamic incrementar_puntuacion_a_empleado/2.
:- dynamic consultar_puntuacion_de_empleado/1.
:- dynamic evaluar_rendimiento_de_empleado/1.
:- dynamic evaluar_desempeno_de_empleado/1.
:- dynamic generar_ranking_mejores_empleados/0.
:- dynamic agregar_turno_por_detalles/4.
:- dynamic borrar_turno_por_id/1.
:- dynamic consultar_turno_por_id/1.
:- dynamic planificar_turnos_para_fecha/1.
:- dynamic listar_asignaciones_para_fecha/1.

% Agregar un nuevo empleado
agregar_empleado_por_nombre(Nombre) :-
    (empleado(_, Nombre) ->
        format('Error: El empleado ~w ya existe.~n', [Nombre])
    ;
        agregar_empleado(Nombre),
        format('Empleado ~w agregado exitosamente.~n', [Nombre]),
        guardar_datos
    ).

% Borrar un empleado por nombre
borrar_empleado_por_nombre(Nombre) :-
    (empleado(ID, Nombre) ->
        borrar_empleado(ID),
        format('Empleado ~w borrado exitosamente.~n', [Nombre]),
        guardar_datos
    ;
        format('Error: Empleado ~w no encontrado.~n', [Nombre])
    ).

% Consultar un empleado por nombre
consultar_empleado_por_nombre(Nombre) :-
    (empleado(ID, Nombre) ->
        consultar_empleado(ID)
    ;
        format('Error: Empleado ~w no encontrado.~n', [Nombre])
    ).

% Agregar un nuevo cargo
agregar_cargo_por_nombre(NombreCargo) :-
    (cargo(NombreCargo) ->
        format('Error: El cargo ~w ya existe.~n', [NombreCargo])
    ;
        agregar_cargo(NombreCargo),
        format('Cargo ~w agregado exitosamente.~n', [NombreCargo]),
        guardar_datos
    ).

% Borrar un cargo por nombre
borrar_cargo_por_nombre(NombreCargo) :-
    (cargo(NombreCargo) ->
        borrar_cargo(NombreCargo),
        format('Cargo ~w borrado exitosamente.~n', [NombreCargo]),
        guardar_datos
    ;
        format('Error: Cargo ~w no encontrado.~n', [NombreCargo])
    ).

% Consultar información de un cargo por nombre
consultar_cargo_por_nombre(NombreCargo) :-
    (cargo(NombreCargo) ->
        consultar_cargo(NombreCargo),
        format('Información del cargo ~w consultada exitosamente.~n', [NombreCargo])
    ;
        format('Error: Cargo ~w no encontrado.~n', [NombreCargo])
    ).

% Asignar un cargo a un empleado por nombre
asignar_cargo_a_empleado(NombreEmpleado, NombreCargo) :-
    (empleado(ID, NombreEmpleado), cargo(NombreCargo) ->
        (cargo_empleado(ID, NombreCargo) ->
            format('El empleado ~w ya tiene asignado el cargo ~w.~n', [NombreEmpleado, NombreCargo]),
            format('¿Desea reemplazar el cargo? (s/n): '),
            read(Respuesta),
            (Respuesta == 's' ->
                borrar_cargo_empleado(ID, NombreCargo),
                agregar_cargo_empleado(ID, NombreCargo),
                format('Cargo ~w reemplazado para ~w exitosamente.~n', [NombreCargo, NombreEmpleado]),
                guardar_datos
            ;
                format('Operación cancelada.~n')
            )
        ;
            agregar_cargo_empleado(ID, NombreCargo),
            format('Cargo ~w asignado a ~w exitosamente.~n', [NombreCargo, NombreEmpleado]),
            guardar_datos
        )
    ;
        format('Error: Empleado ~w o cargo ~w no encontrado.~n', [NombreEmpleado, NombreCargo])
    ).

% Eliminar un cargo de un empleado por nombre
eliminar_cargo_de_empleado(NombreEmpleado, NombreCargo) :-
    (empleado(ID, NombreEmpleado), cargo(NombreCargo) ->
        borrar_cargo_empleado(ID, NombreCargo),
        format('Cargo ~w eliminado de ~w exitosamente.~n', [NombreCargo, NombreEmpleado]),
        guardar_datos
    ;
        format('Error: Empleado ~w o cargo ~w no encontrado.~n', [NombreEmpleado, NombreCargo])
    ).

% Consultar los cargos de un empleado por nombre
consultar_cargos_de_empleado(NombreEmpleado) :-
    (empleado(ID, NombreEmpleado) ->
        consultar_cargo_empleado(ID),
        format('Cargos de ~w consultados exitosamente.~n', [NombreEmpleado])
    ;
        format('Error: Empleado ~w no encontrado.~n', [NombreEmpleado])
    ).

% Agregar una tarea a un empleado por nombre
agregar_tarea_a_empleado(NombreEmpleado, Tarea, Reward) :-
    (empleado(_, NombreEmpleado) ->
        agregar_tarea_por_nombre(NombreEmpleado, Tarea, Reward),
        format('Tarea ~w agregada a ~w con un valor de ~w puntos exitosamente.~n', [Tarea, NombreEmpleado, Reward]),
        guardar_datos
    ;
        format('Error: Empleado ~w no encontrado.~n', [NombreEmpleado])
    ).

% Borrar una tarea de un empleado por nombre
borrar_tarea_de_empleado(NombreEmpleado, Tarea) :-
    (empleado(_, NombreEmpleado) ->
        borrar_tarea_por_nombre(NombreEmpleado, Tarea),
        format('Tarea ~w borrada de ~w exitosamente.~n', [Tarea, NombreEmpleado]),
        guardar_datos
    ;
        format('Error: Empleado ~w no encontrado.~n', [NombreEmpleado])
    ).

% Consultar una tarea de un empleado por nombre
consultar_tarea_de_empleado(NombreEmpleado, Tarea) :-
    (empleado(ID, NombreEmpleado) ->
        (tarea(Tarea, ID, _) ->
            consultar_tarea_por_nombre(NombreEmpleado, Tarea),
            format('Tarea ~w de ~w consultada exitosamente.~n', [Tarea, NombreEmpleado])
        ;
            format('Error: Tarea ~w no encontrada para el empleado ~w.~n', [Tarea, NombreEmpleado])
        )
    ;
        format('Error: Empleado ~w no encontrado.~n', [NombreEmpleado])
    ).

% Completar una tarea de un empleado por nombre
completar_tarea_de_empleado(NombreEmpleado, Tarea) :-
    (empleado(ID, NombreEmpleado) ->
        (tarea(Tarea, ID, _) ->
            completar_tarea_por_nombre(NombreEmpleado, Tarea),
            format('Tarea ~w completada por ~w exitosamente.~n', [Tarea, NombreEmpleado]),
            guardar_datos
        ;
            format('Error: La tarea ~w no está asignada a ~w.~n', [Tarea, NombreEmpleado])
        )
    ;
        format('Error: Empleado ~w no encontrado.~n', [NombreEmpleado])
    ).

% Obtener todas las tareas de un empleado por nombre
obtener_tareas_de_empleado(NombreEmpleado) :-
    (empleado(ID, NombreEmpleado) ->
        findall(Tarea, tarea(Tarea, ID, _), Tareas),
        format('--- Tareas de ~w ---~n', [NombreEmpleado]),
        (Tareas \= [] ->
            forall(member(Tarea, Tareas), format('  - ~w~n', [Tarea]))
        ;
            format('No hay tareas asignadas.~n')
        ),
        format('--- Fin de las tareas ---~n'),
        guardar_datos
    ;
        format('Error: Empleado ~w no encontrado.~n', [NombreEmpleado])
    ).

% Recomendar tareas a un empleado por nombre
recomendar_tareas_a_empleado(NombreEmpleado) :-
    (empleado(_, NombreEmpleado) ->
        recomendar_tareas_por_nombre(NombreEmpleado),
        format('Tareas recomendadas a ~w exitosamente.~n', [NombreEmpleado])
    ;
        format('Error: Empleado ~w no encontrado.~n', [NombreEmpleado])
    ).

% Incrementar la puntuación de un empleado por nombre
incrementar_puntuacion_a_empleado(NombreEmpleado, Reward) :-
    (empleado(_, NombreEmpleado) ->
        incrementar_puntuacion_por_nombre(NombreEmpleado, Reward),
        format('Puntuación de ~w incrementada en ~w puntos exitosamente.~n', [NombreEmpleado, Reward]),
        guardar_datos
    ;
        format('Error: Empleado ~w no encontrado.~n', [NombreEmpleado])
    ).

% Consultar la puntuación de un empleado por nombre
consultar_puntuacion_de_empleado(NombreEmpleado) :-
    (empleado(ID, NombreEmpleado) ->
        consultar_puntuacion(ID),
        format('Puntuación de ~w consultada exitosamente.~n', [NombreEmpleado])
    ;
        format('Error: Empleado ~w no encontrado.~n', [NombreEmpleado])
    ).

% Evaluar el rendimiento de un empleado por nombre
evaluar_rendimiento_de_empleado(NombreEmpleado) :-
    (empleado(_, NombreEmpleado) ->
        evaluar_rendimiento_por_nombre(NombreEmpleado),
        format('Rendimiento de ~w evaluado exitosamente.~n', [NombreEmpleado])
    ;
        format('Error: Empleado ~w no encontrado.~n', [NombreEmpleado])
    ).

% Evaluar el desempeño de un empleado en el mes actual por nombre
evaluar_desempeno_de_empleado(NombreEmpleado) :-
    (empleado(_, NombreEmpleado) ->
        evaluar_desempeno_por_nombre(NombreEmpleado),
        format('Desempeño de ~w en el mes actual evaluado exitosamente.~n', [NombreEmpleado])
    ;
        format('Error: Empleado ~w no encontrado.~n', [NombreEmpleado])
    ).

% Generar el ranking de los mejores empleados por cargo
generar_ranking_mejores_empleados :-
    ranking_mejores_empleados,
    writeln('Ranking de los mejores empleados generado exitosamente.'),
    guardar_datos.

% Agregar un turno
agregar_turno_por_detalles(HoraInicio, HoraFin, Cargo, Cooldown) :-
    agregar_turno(HoraInicio, HoraFin, Cargo, Cooldown),
    format('Turno agregado: HoraInicio: ~w, HoraFin: ~w, Cargo: ~w, Cooldown: ~w~n', [HoraInicio, HoraFin, Cargo, Cooldown]),
    guardar_datos.

% Borrar un turno por ID
borrar_turno_por_id(IDTurno) :-
    (turno(IDTurno, _, _, _, _) ->
        borrar_turno(IDTurno),
        format('Turno con ID ~w borrado exitosamente.~n', [IDTurno]),
        guardar_datos
    ;
        format('Error: Turno con ID ~w no encontrado.~n', [IDTurno])
    ).

% Consultar información de un turno por ID
consultar_turno_por_id(IDTurno) :-
    (turno(IDTurno, _, _, _, _) ->
        consultar_turno(IDTurno),
        format('Información del turno con ID ~w consultada exitosamente.~n', [IDTurno])
    ;
        format('Error: Turno con ID ~w no encontrado.~n', [IDTurno])
    ).

% Planificar turnos para una fecha específica
planificar_turnos_para_fecha(Fecha) :-
    planificar_turnos(Fecha),
    format('Turnos planificados para la fecha ~w exitosamente.~n', [Fecha]),
    guardar_datos.

% Listar asignaciones de turnos para una fecha específica
listar_asignaciones_para_fecha(Fecha) :-
    listar_asignaciones(Fecha),
    format('Asignaciones de turnos para la fecha ~w listadas exitosamente.~n', [Fecha]).

% Listar todos los turnos disponibles
listar_todos_los_turnos :- 
    findall((IDTurno, HoraInicio, HoraFin, Cargo, Cooldown), turno(IDTurno, HoraInicio, HoraFin, Cargo, Cooldown), Turnos),
    writeln('--- Turnos disponibles ---'),
    (Turnos \= [] ->
        forall(member((IDTurno, HoraInicio, HoraFin, Cargo, Cooldown), Turnos),
               format('ID: ~w, HoraInicio: ~w:00, HoraFin: ~w:00, Cargo: ~w, Cooldown: ~w días~n', [IDTurno, HoraInicio, HoraFin, Cargo, Cooldown]))
    ;
        format('No hay turnos disponibles.~n')
    ),
    writeln('--- Fin de la lista de turnos ---').
