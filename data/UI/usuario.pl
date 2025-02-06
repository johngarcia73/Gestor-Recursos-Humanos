% Archivo: usuario.pl

% Declarar los predicados como dinámicos
<<<<<<< HEAD
:- dynamic agregar_empleado_por_nombre/2.
:- dynamic agregar_cargo_por_nombre/2.
:- dynamic borrar_cargo_por_nombre/2.
:- dynamic consultar_cargo_por_nombre/2.
:- dynamic asignar_cargo_a_empleado/3.
:- dynamic eliminar_cargo_de_empleado/3.
:- dynamic consultar_cargos_de_empleado/2.
:- dynamic agregar_tarea_a_empleado/4.
:- dynamic borrar_tarea_de_empleado/3.
:- dynamic consultar_tarea_de_empleado/3.
:- dynamic completar_tarea_de_empleado/3.
:- dynamic obtener_tareas_de_empleado/2.
:- dynamic recomendar_tareas_a_empleado/2.
:- dynamic incrementar_puntuacion_a_empleado/3.
:- dynamic consultar_puntuacion_de_empleado/2.
:- dynamic evaluar_rendimiento_de_empleado/2.
:- dynamic evaluar_desempeno_de_empleado/2.
:- dynamic generar_ranking_mejores_empleados/1.
:- dynamic agregar_turno_por_detalles/5.
:- dynamic borrar_turno_por_id/2.
:- dynamic consultar_turno_por_id/2.
:- dynamic planificar_turnos_para_fecha/2.
:- dynamic listar_asignaciones_para_fecha/2.
=======
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
>>>>>>> e19cb75054909062e49d9aae3c48b1d54434c0d2

% Agregar un nuevo empleado
agregar_empleado_por_nombre(Nombre, Resultado) :-
    (empleado(_, Nombre) ->
        Resultado = [error, 'El empleado ya existe']
    ;
        agregar_empleado(Nombre),
        Resultado = [ok, Nombre],
        guardar_datos
    ).

% Borrar un empleado por nombre
<<<<<<< HEAD
borrar_empleado_por_nombre(Nombre, Resultado) :-
    (empleado(ID, Nombre) ->
        borrar_empleado(ID),
        Resultado = [ok, Nombre],
        guardar_datos
    ;
        Resultado = [error, 'Empleado no encontrado']
    ).

% Consultar un empleado por nombre
consultar_empleado_por_nombre(Nombre, Resultado) :-
    (empleado(ID, Nombre) ->
        consultar_empleado(ID, Resultado)
    ;
        Resultado = [error, 'Empleado no encontrado']
=======
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
>>>>>>> e19cb75054909062e49d9aae3c48b1d54434c0d2
    ).

% Agregar un nuevo cargo
agregar_cargo_por_nombre(NombreCargo, Resultado) :-
    (cargo(NombreCargo) ->
        Resultado = [error, 'El cargo ya existe']
    ;
        agregar_cargo(NombreCargo),
        Resultado = [ok, NombreCargo],
        guardar_datos
    ).

% Borrar un cargo por nombre
borrar_cargo_por_nombre(NombreCargo, Resultado) :-
    (cargo(NombreCargo) ->
        borrar_cargo(NombreCargo),
        Resultado = [ok, NombreCargo],
        guardar_datos
    ;
        Resultado = [error, 'Cargo no encontrado']
    ).

% Consultar información de un cargo por nombre
consultar_cargo_por_nombre(NombreCargo, Resultado) :-
    (cargo(NombreCargo) ->
        consultar_cargo(NombreCargo, Resultado)
    ;
        Resultado = [error, 'Cargo no encontrado']
    ).

% Asignar un cargo a un empleado por nombre
asignar_cargo_a_empleado(NombreEmpleado, NombreCargo, Resultado) :-
    (empleado(ID, NombreEmpleado), cargo(NombreCargo) ->
        (cargo_empleado(ID, NombreCargo) ->
            Resultado = [error, 'El empleado ya tiene asignado el cargo']
        ;
            agregar_cargo_empleado(ID, NombreCargo),
            Resultado = [ok, NombreEmpleado, NombreCargo],
            guardar_datos
        )
    ;
        Resultado = [error, 'Empleado o cargo no encontrado']
    ).

% Eliminar un cargo de un empleado por nombre
eliminar_cargo_de_empleado(NombreEmpleado, NombreCargo, Resultado) :-
    (empleado(ID, NombreEmpleado), cargo(NombreCargo) ->
        borrar_cargo_empleado(ID, NombreCargo),
        Resultado = [ok, NombreEmpleado, NombreCargo],
        guardar_datos
    ;
        Resultado = [error, 'Empleado o cargo no encontrado']
    ).

% Consultar los cargos de un empleado por nombre
consultar_cargos_de_empleado(NombreEmpleado, Resultado) :-
    (empleado(ID, NombreEmpleado) ->
        findall(Cargo, cargo_empleado(ID, Cargo), Cargos),
        Resultado = [ok, NombreEmpleado, Cargos]
    ;
        Resultado = [error, 'Empleado no encontrado']
    ).

% Agregar una tarea a un empleado por nombre
<<<<<<< HEAD
agregar_tarea_a_empleado(NombreEmpleado, Tarea, Reward, Resultado) :-
=======
agregar_tarea_a_empleado(NombreEmpleado, Tarea, Reward) :-
>>>>>>> e19cb75054909062e49d9aae3c48b1d54434c0d2
    (empleado(_, NombreEmpleado) ->
        agregar_tarea_por_nombre(NombreEmpleado, Tarea, Reward),
        Resultado = [ok, NombreEmpleado, Tarea, Reward],
        guardar_datos
    ;
        Resultado = [error, 'Empleado no encontrado']
    ).

% Borrar una tarea de un empleado por nombre
<<<<<<< HEAD
borrar_tarea_de_empleado(NombreEmpleado, Tarea, Resultado) :-
=======
borrar_tarea_de_empleado(NombreEmpleado, Tarea) :-
>>>>>>> e19cb75054909062e49d9aae3c48b1d54434c0d2
    (empleado(_, NombreEmpleado) ->
        borrar_tarea_por_nombre(NombreEmpleado, Tarea),
        Resultado = [ok, NombreEmpleado, Tarea],
        guardar_datos
    ;
        Resultado = [error, 'Empleado no encontrado']
    ).

% Consultar una tarea de un empleado por nombre
consultar_tarea_de_empleado(NombreEmpleado, Tarea, Resultado) :-
    (empleado(ID, NombreEmpleado) ->
        (tarea(Tarea, ID, _) ->
<<<<<<< HEAD
            Resultado = [ok, NombreEmpleado, Tarea]
        ;
            Resultado = [error, 'Tarea no encontrada para el empleado']
=======
            consultar_tarea_por_nombre(NombreEmpleado, Tarea),
            format('Tarea ~w de ~w consultada exitosamente.~n', [Tarea, NombreEmpleado])
        ;
            format('Error: Tarea ~w no encontrada para el empleado ~w.~n', [Tarea, NombreEmpleado])
>>>>>>> e19cb75054909062e49d9aae3c48b1d54434c0d2
        )
    ;
        Resultado = [error, 'Empleado no encontrado']
    ).

% Completar una tarea de un empleado por nombre
completar_tarea_de_empleado(NombreEmpleado, Tarea, Resultado) :-
    (empleado(ID, NombreEmpleado) ->
        (tarea(Tarea, ID, _) ->
            completar_tarea_por_nombre(NombreEmpleado, Tarea),
            Resultado = [ok, NombreEmpleado, Tarea],
            guardar_datos
        ;
            Resultado = [error, 'La tarea no está asignada al empleado']
        )
    ;
        Resultado = [error, 'Empleado no encontrado']
    ).

% Obtener todas las tareas de un empleado por nombre
obtener_tareas_de_empleado(NombreEmpleado, Resultado) :-
    (empleado(ID, NombreEmpleado) ->
        findall(Tarea, tarea(Tarea, ID, _), Tareas),
<<<<<<< HEAD
        Resultado = [ok, NombreEmpleado, Tareas]
=======
        format('--- Tareas de ~w ---~n', [NombreEmpleado]),
        (Tareas \= [] ->
            forall(member(Tarea, Tareas), format('  - ~w~n', [Tarea]))
        ;
            format('No hay tareas asignadas.~n')
        ),
        format('--- Fin de las tareas ---~n'),
        guardar_datos
>>>>>>> e19cb75054909062e49d9aae3c48b1d54434c0d2
    ;
        Resultado = [error, 'Empleado no encontrado']
    ).

% Recomendar tareas a un empleado por nombre
<<<<<<< HEAD
recomendar_tareas_a_empleado(NombreEmpleado, Resultado) :-
=======
recomendar_tareas_a_empleado(NombreEmpleado) :-
>>>>>>> e19cb75054909062e49d9aae3c48b1d54434c0d2
    (empleado(_, NombreEmpleado) ->
        recomendar_tareas_por_nombre(NombreEmpleado),
        Resultado = [ok, NombreEmpleado]
    ;
        Resultado = [error, 'Empleado no encontrado']
    ).

% Incrementar la puntuación de un empleado por nombre
<<<<<<< HEAD
incrementar_puntuacion_a_empleado(NombreEmpleado, Reward, Resultado) :-
=======
incrementar_puntuacion_a_empleado(NombreEmpleado, Reward) :-
>>>>>>> e19cb75054909062e49d9aae3c48b1d54434c0d2
    (empleado(_, NombreEmpleado) ->
        incrementar_puntuacion_por_nombre(NombreEmpleado, Reward),
        Resultado = [ok, NombreEmpleado, Reward],
        guardar_datos
    ;
        Resultado = [error, 'Empleado no encontrado']
    ).

% Consultar la puntuación de un empleado por nombre
consultar_puntuacion_de_empleado(NombreEmpleado, Resultado) :-
    (empleado(ID, NombreEmpleado) ->
<<<<<<< HEAD
        consultar_puntuacion(ID, Puntuacion),
        Resultado = [ok, NombreEmpleado, Puntuacion]
=======
        consultar_puntuacion(ID),
        format('Puntuación de ~w consultada exitosamente.~n', [NombreEmpleado])
>>>>>>> e19cb75054909062e49d9aae3c48b1d54434c0d2
    ;
        Resultado = [error, 'Empleado no encontrado']
    ).

% Evaluar el rendimiento de un empleado por nombre
<<<<<<< HEAD
evaluar_rendimiento_de_empleado(NombreEmpleado, Resultado) :-
=======
evaluar_rendimiento_de_empleado(NombreEmpleado) :-
>>>>>>> e19cb75054909062e49d9aae3c48b1d54434c0d2
    (empleado(_, NombreEmpleado) ->
        evaluar_rendimiento_por_nombre(NombreEmpleado),
        Resultado = [ok, NombreEmpleado]
    ;
        Resultado = [error, 'Empleado no encontrado']
    ).

% Evaluar el desempeño de un empleado en el mes actual por nombre
<<<<<<< HEAD
evaluar_desempeno_de_empleado(NombreEmpleado, Resultado) :-
=======
evaluar_desempeno_de_empleado(NombreEmpleado) :-
>>>>>>> e19cb75054909062e49d9aae3c48b1d54434c0d2
    (empleado(_, NombreEmpleado) ->
        evaluar_desempeno_por_nombre(NombreEmpleado),
        Resultado = [ok, NombreEmpleado]
    ;
        Resultado = [error, 'Empleado no encontrado']
    ).

% Generar el ranking de los mejores empleados por cargo
generar_ranking_mejores_empleados(Resultado) :-
    findall((Nombre, Cargo, Puntuacion), ranking_mejores_empleados(Nombre, Cargo, Puntuacion), Ranking),
    Resultado = [ok, Ranking],
    guardar_datos.

% Agregar un turno
agregar_turno_por_detalles(HoraInicio, HoraFin, Cargo, Cooldown, Resultado) :-
    agregar_turno(HoraInicio, HoraFin, Cargo, Cooldown),
    Resultado = [ok, HoraInicio, HoraFin, Cargo, Cooldown],
    guardar_datos.

% Borrar un turno por ID
borrar_turno_por_id(IDTurno, Resultado) :-
    (turno(IDTurno, _, _, _, _) ->
        borrar_turno(IDTurno),
        Resultado = [ok, IDTurno],
        guardar_datos
    ;
        Resultado = [error, 'Turno no encontrado']
    ).

% Consultar información de un turno por ID
consultar_turno_por_id(IDTurno, Resultado) :-
    (turno(IDTurno, HoraInicio, HoraFin, Cargo, Cooldown) ->
        Resultado = [ok, IDTurno, HoraInicio, HoraFin, Cargo, Cooldown]
    ;
        Resultado = [error, 'Turno no encontrado']
    ).

% Planificar turnos para una fecha específica
planificar_turnos_para_fecha(Fecha, Resultado) :-
    planificar_turnos(Fecha),
    Resultado = [ok, Fecha],
    guardar_datos.

% Listar asignaciones de turnos para una fecha específica
<<<<<<< HEAD
listar_asignaciones_para_fecha(Fecha, Resultado) :-
    findall((NombreEmpleado, Cargo, HoraInicio, HoraFin), 
            (asignacion_turno(IDEmpleado, IDTurno, Fecha), 
             empleado(IDEmpleado, NombreEmpleado), 
             turno(IDTurno, HoraInicio, HoraFin, Cargo, _)), 
            Asignaciones), 
    Resultado = [ok, Fecha, Asignaciones].
=======
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

% Modificar el cooldown de un empleado por nombre
modificar_cooldown_de_empleado(NombreEmpleado, NuevaFechaCooldown) :-
    (empleado(ID, NombreEmpleado) ->
        modificar_cooldown_empleado(ID, NuevaFechaCooldown),
        format('Cooldown de ~w modificado exitosamente.~n', [NombreEmpleado])
    ;
        format('Error: Empleado ~w no encontrado.~n', [NombreEmpleado])
    ).
>>>>>>> e19cb75054909062e49d9aae3c48b1d54434c0d2
