% Archivo: usuario.pl

% Declarar los predicados como dinámicos
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
:- dynamic modificar_cooldown_de_empleado/3.
:- dynamic asignar_turno_a_empleado_por_nombre/4.
:- dynamic eliminar_asignacion_turno_por_fecha/3.
:- dynamic eliminar_todas_asignaciones_para_fecha/2.

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
        findall((Nombre, Cargo, Tarea), cargo_empleado(Nombre, Cargo), tarea(Tarea, IDEmpleado, Reward) , Resultados),
        Resultado = [ok, Resultados]
    ;
        Resultado = [error, 'Empleado no encontrado']
    ).

% Agregar un nuevo cargo
agregar_cargo_por_nombre(NombreCargo, LimiteSemanal, Resultado) :-
    (cargo(NombreCargo) ->
        Resultado = [error, 'El cargo ya existe']
    ;
        agregar_cargo(NombreCargo),
        assertz(limite_turnos(NombreCargo, LimiteSemanal)),
        Resultado = [ok, NombreCargo, LimiteSemanal],
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
agregar_tarea_a_empleado(NombreEmpleado, Tarea, Reward, Resultado) :-
    (empleado(_, NombreEmpleado) ->
        agregar_tarea_por_nombre(NombreEmpleado, Tarea, Reward),
        Resultado = [ok, NombreEmpleado, Tarea, Reward],
        guardar_datos
    ;
        Resultado = [error, 'Empleado no encontrado']
    ).

% Borrar una tarea de un empleado por nombre
borrar_tarea_de_empleado(NombreEmpleado, Tarea, Resultado) :-
    (empleado(_, NombreEmpleado) ->
        (tarea(Tarea, ID, _) ->

            borrar_tarea(ID, Tarea),
            Resultado = [ok, NombreEmpleado, Tarea],
            guardar_datos
        ;
            Resultado = [error, 'La tarea no está asignada al empleado']
        )
    ;
        Resultado = [error, 'Empleado no encontrado']
    ).

% Consultar una tarea de un empleado por nombre
consultar_tarea_de_empleado(NombreEmpleado, Tarea, Resultado) :-
    (empleado(ID, NombreEmpleado) ->
        (tarea(Tarea, ID, _) ->
            Resultado = [ok, NombreEmpleado, Tarea]
        ;
            Resultado = [error, 'Tarea no encontrada para el empleado']
        )
    ;
        Resultado = [error, 'Empleado no encontrado']
    ).

% Completar una tarea de un empleado por nombre
completar_tarea_de_empleado(NombreEmpleado, Tarea, Resultado) :-
    (empleado(ID, NombreEmpleado) ->
        (tarea(Tarea, ID, _) ->
            completar_tarea(ID, Tarea),
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
        Resultado = [ok, NombreEmpleado, Tareas]
    ;
        Resultado = [error, 'Empleado no encontrado']
    ).

% Recomendar tareas a un empleado por nombre
recomendar_tareas_a_empleado(NombreEmpleado, Resultado) :-
    (empleado(_, NombreEmpleado) ->
        recomendar_tareas_por_nombre(NombreEmpleado),
        Resultado = [ok, NombreEmpleado]
    ;
        Resultado = [error, 'Empleado no encontrado']
    ).

% Incrementar la puntuación de un empleado por nombre
incrementar_puntuacion_a_empleado(NombreEmpleado, Reward, Resultado) :-
    (empleado(ID, NombreEmpleado) ->
        incrementar_puntuacion(ID, Reward),
        Resultado = [ok, NombreEmpleado, Reward],
        guardar_datos
    ;
        Resultado = [error, 'Empleado no encontrado']
    ).

% Consultar la puntuación de un empleado por nombre
consultar_puntuacion_de_empleado(NombreEmpleado, Resultado) :-
    (empleado(ID, NombreEmpleado) ->
        findall((Anio, Mes, Puntuacion), evaluacion(ID, Anio, Mes, Puntuacion), Puntuaciones),
        Resultado = [ok, NombreEmpleado, Puntuaciones]
    ;
        Resultado = [error, 'Empleado no encontrado']
    ).

% Evaluar el rendimiento de un empleado por nombre
evaluar_rendimiento_de_empleado(NombreEmpleado, Resultado) :-
    (empleado(ID, NombreEmpleado) ->
        fecha_actual_separada(_, MesActual, AnioActual),
        findall((Anio, Mes, Puntuacion), 
                (evaluacion(ID, Anio, Mes, Puntuacion), 
                 Anio =:= AnioActual, 
                 Mes >= max(1, MesActual - 2), 
                 Mes =< MesActual), 
                Puntuaciones),
        findall(PromedioMensual, 
                (between(1, MesActual, Mes), 
                 Mes >= max(1, MesActual - 2),
                 findall(P, member((AnioActual, Mes, P), Puntuaciones), PuntuacionesMes),
                 sum_list(PuntuacionesMes, TotalMes),
                 length(PuntuacionesMes, NumEvaluacionesMes),
                 (NumEvaluacionesMes > 0 -> PromedioMensual is TotalMes / NumEvaluacionesMes ; PromedioMensual is 0)
                ), PromediosMensuales),
        sum_list(PromediosMensuales, TotalPromedios),
        length(PromediosMensuales, NumMeses),
        (NumMeses > 0 -> PromedioAcumulado is TotalPromedios / NumMeses ; PromedioAcumulado is 0),
        Resultado = [ok, NombreEmpleado, PromedioAcumulado]
    ;
        Resultado = [error, 'Empleado no encontrado']
    ).

% Evaluar el desempeño de un empleado en el mes actual por nombre
evaluar_desempeno_de_empleado(NombreEmpleado, Resultado) :-
    (empleado(ID, NombreEmpleado) ->
        fecha_actual_separada(_, Mes, Anio),
        findall(Puntuacion, evaluacion(ID, Anio, Mes, Puntuacion), Puntuaciones),
        sum_list(Puntuaciones, PuntuacionTotal),
        Resultado = [ok, NombreEmpleado, PuntuacionTotal]
    ;
        Resultado = [error, 'Empleado no encontrado']
    ).

% Generar el ranking de los mejores empleados por cargo
generar_ranking_mejores_empleados(Resultado) :-
    findall(Cargo, cargo(Cargo), Cargos),
    findall((Cargo, Nombre, PuntuacionTotal),
            (member(Cargo, Cargos),
             findall(PuntuacionTotal-IDEmpleado,
                     (cargo_empleado(IDEmpleado, Cargo), calcular_puntuacion_total(IDEmpleado, PuntuacionTotal)),
                     Empleados),
             keysort(Empleados, EmpleadosOrdenados),
             reverse(EmpleadosOrdenados, EmpleadosOrdenadosDesc),
             nth1(Pos, EmpleadosOrdenadosDesc, PuntuacionTotal-IDEmpleado),
             Pos =< 3,
             empleado(IDEmpleado, Nombre)
            ), Ranking),
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
listar_asignaciones_para_fecha(Fecha, Resultado) :-
    findall((NombreEmpleado, Cargo, HoraInicio, HoraFin), 
            (asignacion_turno(IDEmpleado, IDTurno, Fecha), 
             empleado(IDEmpleado, NombreEmpleado), 
             turno(IDTurno, HoraInicio, HoraFin, Cargo, _)), 
            Asignaciones), 
    Resultado = [ok, Fecha, Asignaciones].

% Modificar el cooldown de un empleado por nombre
modificar_cooldown_de_empleado(NombreEmpleado, NuevaFechaCooldown, Resultado) :-
    (empleado(ID, NombreEmpleado) ->
        modificar_cooldown_empleado(ID, NuevaFechaCooldown),
        Resultado = [ok, NombreEmpleado, NuevaFechaCooldown],
        guardar_datos
    ;
        Resultado = [error, 'Empleado no encontrado']
    ).

% Asignar turno a un empleado por nombre
asignar_turno_a_empleado_por_nombre(NombreEmpleado, Fecha, IDTurno, Resultado) :-
    (empleado(IDEmpleado, NombreEmpleado), cargo_empleado(IDEmpleado, Cargo) ->
        (turno(IDTurno, _, _, Cargo, _) ->
            asignar_turno(IDEmpleado, IDTurno, Fecha),
            Resultado = [ok, NombreEmpleado, IDTurno, Fecha],
            guardar_datos
        ;
            Resultado = [error, 'Turno no encontrado para el cargo']
        )
    ;
        Resultado = [error, 'Empleado no encontrado o no tiene un cargo asignado']
    ).

% Eliminar una asignación de turno en una fecha específica
eliminar_asignacion_turno_por_fecha(NombreEmpleado, Fecha, Resultado) :-
    (empleado(IDEmpleado, NombreEmpleado) ->
        (asignacion_turno(IDEmpleado, IDTurno, Fecha) ->
            retract(asignacion_turno(IDEmpleado, IDTurno, Fecha)),
            Resultado = [ok, NombreEmpleado, Fecha],
            guardar_datos
        ;
            Resultado = [error, 'No se encontró una asignación de turno para el empleado en la fecha']
        )
    ;
        Resultado = [error, 'Empleado no encontrado']
    ).

% Eliminar todas las asignaciones de turno en una fecha específica
eliminar_todas_asignaciones_para_fecha(Fecha, Resultado) :-
    findall((IDEmpleado, IDTurno), asignacion_turno(IDEmpleado, IDTurno, Fecha), Asignaciones),
    forall(member((IDEmpleado, IDTurno), Asignaciones),
           retract(asignacion_turno(IDEmpleado, IDTurno, Fecha))),
    Resultado = [ok, Fecha],
    guardar_datos.

% Obtener todos los turnos con sus respectivos cargos y horarios
obtener_todos_los_turnos(Resultado) :-
    findall((IDTurno, HoraInicio, HoraFin, Cargo, Cooldown), turno(IDTurno, HoraInicio, HoraFin, Cargo, Cooldown), Turnos),
    (Turnos \= [] ->
        Resultado = [ok, Turnos]
    ;
        Resultado = [error, 'No hay turnos disponibles']
    ).
