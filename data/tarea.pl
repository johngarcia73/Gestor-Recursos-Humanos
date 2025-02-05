% Archivo: tarea.pl

% Declarar los predicatos como dinámicos
:- dynamic tarea/3.
:- dynamic empleado/2.
:- dynamic cargo_empleado/2.
:- dynamic registro_accion/4.

% Funciones CRUD para tareas
agregar_tarea(ID, Tarea, Reward) :-
    atom_string(TareaAtom, Tarea),
    (tarea(TareaAtom, ID, SetReward) ->
        write('El empleado '), write(ID), write(' ya tiene asignada la tarea '), write(TareaAtom), write(' con un valor de '), write(SetReward), writeln(' puntos.')
    ;
        assertz(tarea(TareaAtom, ID, Reward)),
        write('Tarea agregada: '), write(TareaAtom), write(' para '), write(ID), write(' con un valor de '), write(Reward), writeln(' puntos.'),
        nl,
        registrar_accion('Agregar', 'Tarea', TareaAtom),
        guardar_datos
    ).

borrar_tarea(ID, Tarea) :-
    atom_string(TareaAtom, Tarea),
    retractall(tarea(TareaAtom, ID, _)),
    empleado(ID, Nombre),
    write('Tarea borrada: '), write(TareaAtom), write(' para '), write(Nombre), nl,
    registrar_accion('Borrar', 'Tarea', TareaAtom),
    guardar_datos.

consultar_tarea(ID, Tarea) :-
    atom_string(TareaAtom, Tarea),
    tarea(TareaAtom, ID, Reward),
    empleado(ID, Nombre),
    write('Tarea: '), write(TareaAtom), nl,
    write('Empleado: '), writeln(Nombre),
    write('Puntos: '), writeln(Reward),
    registrar_accion('Consultar', 'Tarea', TareaAtom).

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
    atom_string(TareaAtom, Tarea),
    empleado(ID, Nombre),
    (tarea(TareaAtom, ID, Reward) ->
        retract(tarea(TareaAtom, ID, Reward)),
        write('Tarea completada: '), write(TareaAtom), write(' para '), write(Nombre), nl,
        incrementar_puntuacion(ID, Reward),
        registrar_accion('Completar', 'Tarea', TareaAtom),
        guardar_datos
    ;   
        write('Error: La tarea '), write(TareaAtom), write(' no está asignada a '), write(Nombre), nl
    ).

% Nueva función para obtener todas las tareas de un empleado
obtener_tareas_empleado(ID) :-
    findall((Tarea, Reward), tarea(Tarea, ID, Reward), Tareas),
    empleado(ID, Nombre),
    write('Tareas de '), write(Nombre), writeln(':'),
    forall(member((Tarea, Reward), Tareas),
           format('  - Tarea: ~w, Puntos: ~w~n', [Tarea, Reward])).

% Nueva función para obtener todas las tareas de un cargo
obtener_tareas_cargo(Cargo) :-
    findall((ID, Tarea, Reward), (cargo_empleado(ID, Cargo), tarea(Tarea, ID, Reward)), Combinaciones),
    write('Tareas del cargo de '), write(Cargo), writeln(':'),
    forall(member((ID, Tarea, Reward), Combinaciones),
           format('  - Empleado ID: ~w, Tarea: ~w, Puntos: ~w~n', [ID, Tarea, Reward])).

% Recomendar tareas basadas en el cargo del empleado
recomendar_tareas(ID) :-
    cargo_empleado(ID, Cargo),
    findall((Tarea, Count), (tarea(Tarea, _, _), findall(ID, tarea(Tarea, ID, _), IDs), length(IDs, Count)), Tareas),
    sort(2, @=<, Tareas, TareasOrdenadas),
    length(TareasOrdenadas, Len),
    (Len > 2 -> length(TareasRecomendadas, 2), append(TareasRecomendadas, _, TareasOrdenadas) ; TareasRecomendadas = TareasOrdenadas),
    write('Recomendaciones de tareas para el empleado con ID '), write(ID), write(' en el cargo de '), write(Cargo), writeln(':'),
    forall(member((Tarea, Count), TareasRecomendadas),
           format('  - Tarea: ~w, Asignada a ~w empleados~n', [Tarea, Count])).

% Agregar tarea por nombre de empleado
agregar_tarea_por_nombre(NombreEmpleado, Tarea, Reward) :-
    empleado(ID, NombreEmpleado),
    atom_string(TareaAtom, Tarea),
    agregar_tarea(ID, TareaAtom, Reward),
    write('Tarea agregada: '), write(TareaAtom), write(' para '), write(NombreEmpleado), write(' con un valor de '), write(Reward), writeln(' puntos.').

% Borrar tarea por nombre de empleado
borrar_tarea_por_nombre(NombreEmpleado) :-
    empleado(ID, NombreEmpleado),
    findall((Tarea, Reward), tarea(Tarea, ID, Reward), Tareas),
    (Tareas \= [] ->
        (write('Tareas asignadas a '), write(NombreEmpleado), writeln(':'),
         forall(member((Tarea, Reward), Tareas),
                format('  - Tarea: ~w, Puntos: ~w~n', [Tarea, Reward])),
         write('Ingrese la tarea a borrar: '),
         read_line_to_string(user_input, TareaString),
         borrar_tarea(ID, TareaString),
         write('Tarea borrada: '), write(TareaString), write(' para '), write(NombreEmpleado), nl)
    ;
        write('El empleado '), write(NombreEmpleado), writeln(' no tiene tareas asignadas.')
    ).

% Consultar tarea por nombre de empleado
consultar_tarea_por_nombre(NombreEmpleado, Tarea) :-
    atom_string(TareaAtom, Tarea),
    (empleado(ID, NombreEmpleado) ->
        consultar_tarea(ID, TareaAtom),
        write('Tarea: '), write(TareaAtom), nl,
        write('Empleado: '), writeln(NombreEmpleado)
    ;
        format('Error: Empleado ~w no encontrado.~n', [NombreEmpleado])
    ).

% Completar tarea por nombre de empleado
completar_tarea_por_nombre(NombreEmpleado) :-
    empleado(ID, NombreEmpleado),
    findall((Tarea, Reward), tarea(Tarea, ID, Reward), Tareas),
    (Tareas \= [] ->
        (write('Tareas asignadas a '), write(NombreEmpleado), writeln(':'),
         forall(member((Tarea, Reward), Tareas),
                format('  - Tarea: ~w, Puntos: ~w~n', [Tarea, Reward])),
         write('Ingrese la tarea a completar: '),
         read_line_to_string(user_input, TareaString),
         completar_tarea(ID, TareaString),
         write('Tarea completada: '), write(TareaString), write(' para '), write(NombreEmpleado), nl)
    ;
        write('El empleado '), write(NombreEmpleado), writeln(' no tiene tareas asignadas.')
    ).

% Consultar todas las tareas de un empleado
consultar_todas_las_tareas_de_empleado(ID) :-
    findall(Tarea, tarea(Tarea, ID, _), Tareas),
    empleado(ID, Nombre),
    write('Tareas de '), write(Nombre), writeln(':'), writeln(Tareas).

% Obtener tareas de empleado por nombre
obtener_tareas_empleado_por_nombre(NombreEmpleado) :-
    empleado(ID, NombreEmpleado),
    obtener_tareas_empleado(ID).

% Recomendar tareas por nombre de empleado
recomendar_tareas_por_nombre(NombreEmpleado) :-
    empleado(ID, NombreEmpleado),
    recomendar_tareas(ID),
    write('Recomendaciones de tareas para '), write(NombreEmpleado), writeln(':').
