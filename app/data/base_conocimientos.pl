:- dynamic empleado/2.

empleado(3, 'Pedro Lopez').
empleado(4, 'Ana Martinez').
empleado(5, 'Alicia Vazquez').
empleado(6, 'Jose Agustin').

:- dynamic cargo/1.

cargo(ingeniero).
cargo(disenador).
cargo(programador).
cargo(portero).

:- dynamic cargo_empleado/2.

cargo_empleado(3, programador).
cargo_empleado(4, ingeniero).
cargo_empleado(5, disenador).
cargo_empleado(5, portero).

:- dynamic tarea/3.

tarea(desarrollo, 3, 2).
tarea(pruebas, 5, 3).

:- dynamic evaluacion/4.

evaluacion(3, 2025, 1, 7).
evaluacion(4, 2025, 1, 9).
evaluacion(5, 2025, 1, 10).

:- dynamic registro_accion/4.

registro_accion('Agregar', 'Empleado', 1, '2025-01-14 12:34:56').
registro_accion('Agregar', 'Empleado', 2, '2025-01-14 12:34:57').
registro_accion('Agregar', 'Empleado', 3, '2025-01-14 12:34:58').
registro_accion('Agregar', 'Empleado', 4, '2025-01-14 12:34:59').
registro_accion('Agregar', 'Empleado', 5, '2025-01-15 00:10:35').
registro_accion('Agregar', 'CargoEmpleado', ingeniero, '2025-01-15 00:13:01').
registro_accion('Agregar', 'CargoEmpleado', disenador, '2025-01-15 00:13:02').
registro_accion('Agregar', 'CargoEmpleado', programador, '2025-01-15 00:13:03').
registro_accion('Agregar', 'Empleado', 6, '2025-01-30 21:41:03').
registro_accion('Consultar', 'Empleado', 'Pedro Lopez', '2025-01-30 21:43:25').
registro_accion('Consultar', 'Empleado', 'Juan Perez', '2025-01-30 21:43:39').
registro_accion('Borrar', 'Empleado', 'Juan Perez', '2025-01-30 21:44:46').
registro_accion('Consultar', 'Empleado', 'Alicia Vazquez', '2025-01-30 21:47:02').
registro_accion('Agregar', 'Cargo', portero, '2025-01-30 21:47:33').
registro_accion('Consultar', 'Cargo', portero, '2025-01-30 21:47:46').
registro_accion('Borrar', 'Cargo', portero, '2025-01-30 21:47:58').
registro_accion('Agregar', 'Cargo', portero, '2025-01-30 21:48:11').
registro_accion('Agregar', 'CargoEmpleado', portero, '2025-01-30 21:49:15').
registro_accion('Consultar', 'CargoEmpleado', 'Alicia Vazquez', '2025-01-30 21:49:41').
registro_accion('Agregar', 'Tarea', 'dise�ar_pagina_web', '2025-01-30 21:52:00').
registro_accion('Consultar', 'Tarea', 'dise�ar_pagina_web', '2025-01-30 21:52:40').
registro_accion('Borrar', 'Tarea', 'dise�ar_pagina_web', '2025-01-30 21:54:44').
registro_accion('Consultar', 'Tarea', diseno, '2025-01-30 21:55:46').
registro_accion('Consultar', 'Empleado', 'Jose Agustin', '2025-01-31 00:27:51').
registro_accion('Consultar', 'Empleado', 'Maria Gomez', '2025-01-31 00:28:36').
registro_accion('Borrar', 'Empleado', 'Maria Gomez', '2025-01-31 00:28:45').
registro_accion('Consultar', 'Cargo', ingeniero, '2025-01-31 00:29:13').
registro_accion('Agregar', 'Cargo', gerente, '2025-01-31 00:29:56').
registro_accion('Consultar', 'Cargo', gerente, '2025-01-31 00:30:03').
registro_accion('Borrar', 'Cargo', gerente, '2025-01-31 00:30:09').

:- dynamic id_contador/1.

id_contador(6).

:- dynamic id_contador_turno/1.

id_contador_turno(6).
id_contador_turno(6).
id_contador_turno(7).

:- dynamic turno/5.

turno(6, 9, 17, programador, 3).
turno(1, 9, 17, ingeniero, 2).
turno(2, 17, 1, ingeniero, 2).
turno(3, 9, 17, disenador, 1).
turno(4, 17, 1, disenador, 1).

:- dynamic limite_turnos/2.

limite_turnos(ingeniero, 5).
limite_turnos(disenador, 5).
limite_turnos(programador, 5).

:- dynamic asignacion_turno/3.

asignacion_turno(1, 1, '2025-01-20').
asignacion_turno(2, 3, '2025-01-20').
asignacion_turno(4, 1, '2025-01-22').
asignacion_turno(5, 3, '2025-01-22').
asignacion_turno(3, 5, '2025-02-13').
asignacion_turno(3, 5, '2025-03-20').
asignacion_turno(3, 5, '2025-03-23').
asignacion_turno(4, 1, '2025-02-02').
asignacion_turno(5, 3, '2025-02-03').
asignacion_turno(4, 1, '2025-08-03').
asignacion_turno(5, 3, '2025-08-03').
asignacion_turno(3, 6, '2025-08-03').

:- dynamic cooldown_turno/2.

cooldown_turno(1, '2025-01-18').
cooldown_turno(2, '2025-01-18').
cooldown_turno(4, '2025-08-05').
cooldown_turno(5, '2025-08-04').
cooldown_turno(3, '2025-08-06').

