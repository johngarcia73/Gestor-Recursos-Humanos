% Archivo: tarea.pl

% Declarar los predicados como dinámicos
:- dynamic tarea/3.
:- dynamic empleado/2.
:- dynamic cargo_empleado/2.
:- dynamic registro_accion/4.

% Funciones CRUD para tareas
agregar_tarea(ID, Tarea, Reward) :-
    (tarea(Tarea, ID, SetReward) ->
        write('El empleado '), write(ID), write(' ya tiene asignada la tarea '), write(Tarea), write(' con un valor de '), write(SetReward), writeln(' puntos.')
    ;
        assertz(tarea(Tarea, ID, Reward)),
        write('Tarea agregada: '), write(Tarea), write(' para '), write(ID), write(' con un valor de '), write(Reward), writeln(' puntos.'),
        nl,
        registrar_accion('Agregar', 'Tarea', Tarea),
        guardar_datos
    ).

borrar_tarea(ID, Tarea) :-
    retractall(tarea(Tarea, ID, _)),
    empleado(ID, Nombre),
    write('Tarea borrada: '), write(Tarea), write(' para '), write(Nombre), nl,
    registrar_accion('Borrar', 'Tarea', Tarea),
    guardar_datos.

consultar_tarea(ID, Tarea) :-
    tarea(Tarea, ID, Reward),
    empleado(ID, Nombre),
    write('Tarea: '), write(Tarea), nl,
    write('Empleado: '), writeln(Nombre),
    write('Puntos: '), writeln(Reward),
    registrar_accion('Consultar', 'Tarea', Tarea).

% Consultas empleado-cargo-tarea
empleado_cargo_tarea(ID, Cargo, Tarea) :-
    cargo_empleado(ID, Cargo),
    tarea(Tarea, ID, _).

empleado_cargo_tarea(ID, Cargo) :-
    findall(Tarea, (cargo_empleado(ID, Cargo), tarea(Tarea, ID, _)), Tareas),
    empleado(ID, Nombre),
    write('Tareas de '), write(Nombre), write(' en el cargo de '), write(Cargo), writeln(':'),
    writeln(Tareas).

empleado_cargo_tarea(ID) :-
    findall((Cargo, Tarea), (cargo_empleado(ID, Cargo), tarea(Tarea, ID, _)), Combinaciones),
    empleado(ID, Nombre),
    write('Cargos y tareas de '), write(Nombre), writeln(':'),
    writeln(Combinaciones).

% Completar tarea de empleado
completar_tarea(ID, Tarea) :-
    empleado(ID, Nombre),
    (tarea(Tarea, ID, Reward) ->
        retract(tarea(Tarea, ID, Reward)),
        write('Tarea completada: '), write(Tarea), write(' para '), write(Nombre), nl,
        incrementar_puntuacion(ID, Reward),
        registrar_accion('Completar', 'Tarea', Tarea),
        guardar_datos
    ;   
        write('Error: La tarea '), write(Tarea), write(' no está asignada a '), write(Nombre), nl
    ).

% Nueva función para obtener todas las tareas de un empleado
obtener_tareas_empleado(ID) :-
    findall(Tarea, tarea(Tarea, ID, _), Tareas),
    empleado(ID, Nombre),
    write('Tareas de '), write(Nombre), writeln(':'),
    writeln(Tareas).

% Nueva función para obtener todas las tareas de un cargo
obtener_tareas_cargo(Cargo) :-
    findall((ID, Tarea), (cargo_empleado(ID, Cargo), tarea(Tarea, ID, _)), Combinaciones),
    write('Tareas del cargo de '), write(Cargo), writeln(':'),
    writeln(Combinaciones).

% Recomendar tareas basadas en el cargo del empleado
recomendar_tareas(ID) :-
    cargo_empleado(ID, Cargo),
    findall(Tarea, tarea(Tarea, _, _), Tareas),
    write('Recomendaciones de tareas para el empleado con ID '), write(ID), write(' en el cargo de '), write(Cargo), writeln(':'),
    writeln(Tareas).

% Agregar tarea por nombre de empleado
agregar_tarea_por_nombre(NombreEmpleado, Tarea, Reward) :-
    empleado(ID, NombreEmpleado),
    agregar_tarea(ID, Tarea, Reward),
    write('Tarea agregada: '), write(Tarea), write(' para '), write(NombreEmpleado), write(' con un valor de '), write(Reward), writeln(' puntos.').

% Borrar tarea por nombre de empleado
borrar_tarea_por_nombre(NombreEmpleado, Tarea) :-
    empleado(ID, NombreEmpleado),
    borrar_tarea(ID, Tarea),
    write('Tarea borrada: '), write(Tarea), write(' para '), write(NombreEmpleado), nl.

% Consultar tarea por nombre de empleado
consultar_tarea_por_nombre(NombreEmpleado, Tarea) :-
    empleado(ID, NombreEmpleado),
    consultar_tarea(ID, Tarea),
    write('Tarea: '), write(Tarea), nl,
    write('Empleado: '), writeln(NombreEmpleado).

% Completar tarea por nombre de empleado
completar_tarea_por_nombre(NombreEmpleado, Tarea) :-
    empleado(ID, NombreEmpleado),
    completar_tarea(ID, Tarea),
    write('Tarea completada: '), write(Tarea), write(' para '), write(NombreEmpleado), nl.

% Obtener tareas de empleado por nombre
obtener_tareas_empleado_por_nombre(NombreEmpleado) :-
    empleado(ID, NombreEmpleado),
    obtener_tareas_empleado(ID),
    write('Tareas de '), write(NombreEmpleado), writeln(':'), nl.

% Recomendar tareas por nombre de empleado
recomendar_tareas_por_nombre(NombreEmpleado) :-
    empleado(ID, NombreEmpleado),
    recomendar_tareas(ID),
    write('Recomendaciones de tareas para '), write(NombreEmpleado), writeln(':').
