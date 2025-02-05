% Archivo: main.pl

% Cargar la base de conocimientos y dependencias
:- consult('base_conocimientos.pl').
:- consult('date.pl').
:- consult('empleado.pl').
:- consult('tarea.pl').
:- consult('cargo.pl').
:- consult('score.pl').
:- consult('turno.pl').
:- consult('human_resources.pl').
:- consult('usuario.pl').

% Guardar la base de datos antes de salir
guardar_base_conocimientos :-
    guardar_datos,
    writeln('Base de conocimientos guardada.').

% Menú principal
menu :-
    writeln('--- Sistema de Gestión de Recursos Humanos ---'),
    writeln('1. Agregar empleado'),
    writeln('2. Borrar empleado'),
    writeln('3. Consultar empleado'),
    writeln('4. Agregar cargo'),
    writeln('5. Borrar cargo'),
    writeln('6. Consultar cargo'),
    writeln('7. Asignar cargo a empleado'),
    writeln('8. Eliminar cargo de empleado'),
    writeln('9. Consultar cargos de empleado'),
    writeln('10. Agregar tarea a empleado'),
    writeln('11. Borrar tarea de empleado'),
    writeln('12. Consultar tarea de empleado'),
    writeln('13. Completar tarea de empleado'),
    writeln('14. Obtener tareas de empleado'),
    writeln('15. Recomendar tareas a empleado'),
    writeln('16. Incrementar puntuación de empleado'),
    writeln('17. Consultar puntuación de empleado'),
    writeln('18. Evaluar rendimiento de empleado'),
    writeln('19. Evaluar desempeño de empleado en el mes actual'),
    writeln('20. Generar ranking de mejores empleados'),
    writeln('21. Agregar turno'),
    writeln('22. Borrar turno'),
    writeln('23. Consultar turno'),
    writeln('24. Planificar turnos para una fecha'),
    writeln('25. Listar asignaciones de turnos para una fecha'),
    writeln('0. Salir'),
    read(Opcion),
    ejecutar_opcion(Opcion).

% Ejecutar opción seleccionada
ejecutar_opcion(1) :-
    writeln('Ingrese el nombre del empleado:'),
    read(Nombre),
    agregar_empleado_por_nombre(Nombre),
    continuar.
ejecutar_opcion(2) :-
    writeln('Ingrese el nombre del empleado:'),
    read(Nombre),
    borrar_empleado_por_nombre(Nombre),
    continuar.
ejecutar_opcion(3) :-
    writeln('Ingrese el nombre del empleado:'),
    read(Nombre),
    consultar_empleado_por_nombre(Nombre),
    continuar.
ejecutar_opcion(4) :-
    writeln('Ingrese el nombre del cargo:'),
    read(NombreCargo),
    agregar_cargo_por_nombre(NombreCargo),
    continuar.
ejecutar_opcion(5) :-
    writeln('Ingrese el nombre del cargo:'),
    read(NombreCargo),
    borrar_cargo_por_nombre(NombreCargo),
    continuar.
ejecutar_opcion(6) :-
    writeln('Ingrese el nombre del cargo:'),
    read(NombreCargo),
    consultar_cargo_por_nombre(NombreCargo),
    continuar.
ejecutar_opcion(7) :-
    writeln('Ingrese el nombre del empleado:'),
    read(NombreEmpleado),
    writeln('Ingrese el nombre del cargo:'),
    read(NombreCargo),
    asignar_cargo_a_empleado(NombreEmpleado, NombreCargo),
    continuar.
ejecutar_opcion(8) :-
    writeln('Ingrese el nombre del empleado:'),
    read(NombreEmpleado),
    writeln('Ingrese el nombre del cargo:'),
    read(NombreCargo),
    eliminar_cargo_de_empleado(NombreEmpleado, NombreCargo),
    continuar.
ejecutar_opcion(9) :-
    writeln('Ingrese el nombre del empleado:'),
    read(NombreEmpleado),
    consultar_cargos_de_empleado(NombreEmpleado),
    continuar.
ejecutar_opcion(10) :-
    writeln('Ingrese el nombre del empleado:'),
    read(NombreEmpleado),
    writeln('Ingrese la tarea:'),
    read(Tarea),
    writeln('Ingrese el valor de la tarea:'),
    read(Reward),
    agregar_tarea_a_empleado(NombreEmpleado, Tarea, Reward),
    continuar.
ejecutar_opcion(11) :-
    writeln('Ingrese el nombre del empleado:'),
    read(NombreEmpleado),
    writeln('Ingrese la tarea:'),
    read(Tarea),
    borrar_tarea_de_empleado(NombreEmpleado, Tarea),
    continuar.
ejecutar_opcion(12) :-
    writeln('Ingrese el nombre del empleado:'),
    read(NombreEmpleado),
    writeln('Ingrese la tarea:'),
    read(Tarea),
    consultar_tarea_de_empleado(NombreEmpleado, Tarea),
    continuar.
ejecutar_opcion(13) :-
    writeln('Ingrese el nombre del empleado:'),
    read(NombreEmpleado),
    writeln('Ingrese la tarea:'),
    read(Tarea),
    completar_tarea_de_empleado(NombreEmpleado, Tarea),
    continuar.
ejecutar_opcion(14) :-
    writeln('Ingrese el nombre del empleado:'),
    read(NombreEmpleado),
    obtener_tareas_de_empleado(NombreEmpleado),
    continuar.
ejecutar_opcion(15) :-
    writeln('Ingrese el nombre del empleado:'),
    read(NombreEmpleado),
    recomendar_tareas_a_empleado(NombreEmpleado),
    continuar.
ejecutar_opcion(16) :-
    writeln('Ingrese el nombre del empleado:'),
    read(NombreEmpleado),
    writeln('Ingrese el valor de la puntuación:'),
    read(Reward),
    incrementar_puntuacion_a_empleado(NombreEmpleado, Reward),
    continuar.
ejecutar_opcion(17) :-
    writeln('Ingrese el nombre del empleado:'),
    read(NombreEmpleado),
    consultar_puntuacion_de_empleado(NombreEmpleado),
    continuar.
ejecutar_opcion(18) :-
    writeln('Ingrese el nombre del empleado:'),
    read(NombreEmpleado),
    evaluar_rendimiento_de_empleado(NombreEmpleado),
    continuar.
ejecutar_opcion(19) :-
    writeln('Ingrese el nombre del empleado:'),
    read(NombreEmpleado),
    evaluar_desempeno_de_empleado(NombreEmpleado),
    continuar.
ejecutar_opcion(20) :-
    generar_ranking_mejores_empleados,
    continuar.
ejecutar_opcion(21) :-
    writeln('Ingrese la hora de inicio del turno:'),
    read(HoraInicio),
    writeln('Ingrese la hora de fin del turno:'),
    read(HoraFin),
    writeln('Ingrese el cargo del turno:'),
    read(Cargo),
    writeln('Ingrese el cooldown del turno:'),
    read(Cooldown),
    agregar_turno_por_detalles(HoraInicio, HoraFin, Cargo, Cooldown),
    continuar.
ejecutar_opcion(22) :-
    writeln('Ingrese el ID del turno:'),
    read(IDTurno),
    borrar_turno_por_id(IDTurno),
    continuar.
ejecutar_opcion(23) :-
    writeln('Ingrese el ID del turno:'),
    read(IDTurno),
    consultar_turno_por_id(IDTurno),
    continuar.
ejecutar_opcion(24) :-
    writeln('Ingrese la fecha (YYYY-MM-DD):'),
    read(Fecha),
    planificar_turnos_para_fecha(Fecha),
    continuar.
ejecutar_opcion(25) :-
    writeln('Ingrese la fecha (YYYY-MM-DD):'),
    read(Fecha),
    listar_asignaciones_para_fecha(Fecha),
    continuar.
ejecutar_opcion(0) :-
    guardar_base_conocimientos,
    writeln('Saliendo del sistema...'),
    halt.
ejecutar_opcion(_) :-
    writeln('Opción no válida, intente de nuevo.'),
    continuar.

% Continuar con el menú
continuar :-
    writeln('Presione Enter para continuar...'),
    read(_),
    menu.

% Iniciar el sistema
:- initialization(menu).
