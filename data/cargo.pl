% Funciones CRUD para cargos
agregar_cargo(NombreCargo) :-
    (cargo(NombreCargo) ->
        write('El cargo '), write(NombreCargo), write(' ya existe.'), nl
    ;
        assertz(cargo(NombreCargo)),
        write('Cargo agregado: '), write(NombreCargo), nl,
        registrar_accion('Agregar', 'Cargo', NombreCargo),
        guardar_datos
    ).

borrar_cargo(NombreCargo) :-
    cargo(NombreCargo),
    retractall(cargo(NombreCargo)),
    retractall(cargo_empleado(_, NombreCargo)),
    write('Cargo borrado: '), write(NombreCargo), nl,
    registrar_accion('Borrar', 'Cargo', NombreCargo),
    guardar_datos.

consultar_cargo(NombreCargo) :-
    cargo(NombreCargo),
    write('Nombre del cargo: '), writeln(NombreCargo),
    findall(ID-Nombre, (cargo_empleado(ID, NombreCargo), empleado(ID, Nombre)), Empleados),
    write('Empleados con este cargo: '), writeln(Empleados),
    registrar_accion('Consultar', 'Cargo', NombreCargo).

agregar_limite_semanal(NombreCargo, LimiteTurnos) :-
    (cargo(NombreCargo) ->
        assertz(limite_turnos(NombreCargo, LimiteTurnos)),
        write('Límite de turnos semanal del cargo: '), write(LimiteTurnos), nl,
        guardar_datos
    ;
        write('El cargo '), write(NombreCargo), write(' no existe.'), nl    
    ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Funciones CRUD para relacion cargo-empleado
agregar_cargo_empleado(ID, NombreCargo) :-
    empleado(ID, Nombre),
    cargo(NombreCargo),
    (cargo_empleado(ID, NombreCargo) ->
        write('Error: El empleado '), write(Nombre), write(' ya tiene asignado el cargo '), writeln(NombreCargo)
    ;
        assertz(cargo_empleado(ID, NombreCargo)),
        write('Cargo '), write(NombreCargo), write(' asignado a '), write(Nombre), nl,
        registrar_accion('Agregar', 'CargoEmpleado', NombreCargo),
        guardar_datos
    ).

borrar_cargo_empleado(ID, NombreCargo) :-
    empleado(ID, Nombre),
    retractall(cargo_empleado(ID, NombreCargo)),
    write('Cargo '), write(NombreCargo), write(' eliminado para '), write(Nombre), nl,
    registrar_accion('Borrar', 'CargoEmpleado', NombreCargo),
    guardar_datos.

consultar_cargo_empleado(ID) :-
    empleado(ID, Nombre),
    findall(Cargo, cargo_empleado(ID, Cargo), Cargos),
    write('Cargos de '), write(Nombre), writeln(':'),
    writeln(Cargos),
    registrar_accion('Consultar', 'CargoEmpleado', Nombre).
