:- dynamic empleado/2.

empleado(3, 'Pedro Lopez').
empleado(4, 'Ana Martinez').
empleado(8, 'Arnaldo Rodriguez').
empleado(11, victorini).
empleado(15, 'paco pepe').
empleado(16, natsu).
empleado(17, ddd).
empleado(18, julito).
empleado(19, pablo).

:- dynamic cargo/1.

cargo(disenador).
cargo(programador).
cargo(jardinero).
cargo(profe).
cargo(esclavo).

:- dynamic cargo_empleado/2.

cargo_empleado(3, programador).
cargo_empleado(15, esclavo).
cargo_empleado(19, esclavo).
cargo_empleado(16, profe).
cargo_empleado(18, programador).

:- dynamic tarea/2.


:- dynamic tarea/3.

tarea('reparar el baño', 4, 8).
tarea(nada, 11, '44').

:- dynamic evaluacion/4.

evaluacion(3, 2025, 1, 7).
evaluacion(4, 2025, 1, 9).
evaluacion(4, 2025, 2, 1).
evaluacion(19, 2025, 2, '234').
evaluacion(3, 2025, 2, 20).
evaluacion(11, 2025, 2, 5).

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
registro_accion('Agregar', 'Tarea', 'diseñar_pagina_web', '2025-01-30 21:52:00').
registro_accion('Consultar', 'Tarea', 'diseñar_pagina_web', '2025-01-30 21:52:40').
registro_accion('Borrar', 'Tarea', 'diseñar_pagina_web', '2025-01-30 21:54:44').
registro_accion('Consultar', 'Tarea', diseno, '2025-01-30 21:55:46').
registro_accion('Consultar', 'Empleado', 'Jose Agustin', '2025-01-31 00:27:51').
registro_accion('Consultar', 'Empleado', 'Maria Gomez', '2025-01-31 00:28:36').
registro_accion('Borrar', 'Empleado', 'Maria Gomez', '2025-01-31 00:28:45').
registro_accion('Consultar', 'Cargo', ingeniero, '2025-01-31 00:29:13').
registro_accion('Agregar', 'Cargo', gerente, '2025-01-31 00:29:56').
registro_accion('Consultar', 'Cargo', gerente, '2025-01-31 00:30:03').
registro_accion('Borrar', 'Cargo', gerente, '2025-01-31 00:30:09').
registro_accion('Agregar', 'Empleado', 7, '2025-02-02 15:33:41').
registro_accion('Borrar', 'Empleado', 'Juan Marinello', '2025-02-02 15:34:04').
registro_accion('Consultar', 'Empleado', 'Ana Martinez', '2025-02-02 15:56:41').
registro_accion('Agregar', 'Empleado', 8, '2025-02-04 20:04:36').
registro_accion('Borrar', 'Empleado', 'Alicia Vazquez', '2025-02-04 20:04:59').
registro_accion('Consultar', 'Empleado', 'Ana Martinez', '2025-02-04 20:05:47').
registro_accion('Agregar', 'Tarea', 'reparar el baño', '2025-02-04 20:06:45').
registro_accion('Consultar', 'Tarea', 'reparar el baño', '2025-02-04 20:07:06').
registro_accion('Agregar', 'Tarea', diseno, '2025-02-04 20:35:30').
registro_accion('Borrar', 'Tarea', desarrollo, '2025-02-04 20:37:06').
registro_accion('Borrar', 'Tarea', "desarrollo", '2025-02-04 20:57:43').
registro_accion('Borrar', 'Tarea', "diseno", '2025-02-04 21:00:59').
registro_accion('Borrar', 'Tarea', diseno, '2025-02-04 21:03:10').
registro_accion('Agregar', 'Tarea', cocinar, '2025-02-04 21:03:45').
registro_accion('Agregar', 'Tarea', caminar, '2025-02-04 21:08:33').
registro_accion('Agregar', 'Tarea', chambear, '2025-02-04 21:13:04').
registro_accion('Agregar', 'Tarea', comer, '2025-02-04 21:15:09').
registro_accion('Agregar', 'Tarea', 'comer temprano', '2025-02-04 21:19:06').
registro_accion('Agregar', 'Tarea', jugar, '2025-02-04 21:23:26').
registro_accion('Borrar', 'Tarea', jugar, '2025-02-04 21:23:54').
registro_accion('Completar', 'Tarea', 'comer temprano', '2025-02-04 21:24:34').
registro_accion('Completar', 'Tarea', comer, '2025-02-04 21:31:41').
registro_accion('Agregar', 'Cargo', gerente, '2025-02-04 21:56:20').
registro_accion('Agregar', 'CargoEmpleado', portero, '2025-02-04 22:03:14').
registro_accion('Consultar', 'Empleado', 'Jose Agustin', '2025-02-04 22:03:28').
registro_accion('Agregar', 'CargoEmpleado', gerente, '2025-02-04 22:48:21').
registro_accion('Agregar', 'CargoEmpleado', portero, '2025-02-04 22:54:50').
registro_accion('Agregar', 'CargoEmpleado', portero, '2025-02-04 22:56:38').
registro_accion('Agregar', 'Empleado', 9, '2025-02-05 04:18:21').
registro_accion('Borrar', 'Empleado', 'Jose Agiustin', '2025-02-05 04:18:41').
registro_accion('Consultar', 'Empleado', 'Jose Agustin', '2025-02-05 04:18:48').
registro_accion('Agregar', 'Cargo', jardinero, '2025-02-05 04:19:52').
registro_accion('Consultar', 'Cargo', jardinero, '2025-02-05 04:19:59').
registro_accion('Borrar', 'Cargo', gerente, '2025-02-05 04:20:16').
registro_accion('Agregar', 'CargoEmpleado', jardinero, '2025-02-05 04:21:03').
registro_accion('Agregar', 'Tarea', 'Cortar las rosas', '2025-02-05 04:22:09').
registro_accion('Agregar', 'Tarea', pensar, '2025-02-05 04:23:32').
registro_accion('Borrar', 'Tarea', pensar, '2025-02-05 04:23:44').
registro_accion('Completar', 'Tarea', 'Cortar las rosas', '2025-02-05 04:24:39').
registro_accion('Agregar', 'CargoEmpleado', portero, '2025-02-05 04:40:03').
registro_accion('Agregar', 'Cargo', profe, '2025-02-05 05:19:08').
registro_accion('Borrar', 'Cargo', profe, '2025-02-05 05:20:42').
registro_accion('Agregar', 'Cargo', profe, '2025-02-05 05:20:57').
registro_accion('Agregar', 'Cargo', profe, '2025-02-05 05:23:51').
registro_accion('Agregar', 'Cargo', profe, '2025-02-05 05:33:53').
registro_accion('Agregar', 'Cargo', profe, '2025-02-05 05:37:38').
registro_accion('Agregar', 'Tarea', comer, '2025-02-05 06:05:15').
registro_accion('Borrar', 'Tarea', comer, '2025-02-05 06:05:55').
registro_accion('Agregar', 'Tarea', r, '2025-02-05 06:29:24').
registro_accion('Borrar', 'Tarea', r, '2025-02-05 06:29:47').
registro_accion('Agregar', 'Empleado', 10, '2025-02-05 17:41:26').
registro_accion('Agregar', 'Empleado', 11, '2025-02-05 18:24:42').
registro_accion('Agregar', 'Empleado', 12, '2025-02-05 18:41:02').
registro_accion('Agregar', 'Empleado', 13, '2025-02-05 19:22:34').
registro_accion('Agregar', 'Empleado', 14, '2025-02-05 19:40:16').
registro_accion('Borrar', 'Empleado', felipe, '2025-02-05 19:40:27').
registro_accion('Borrar', 'Empleado', corin, '2025-02-05 19:40:51').
registro_accion('Agregar', 'Cargo', chofer, '2025-02-05 19:41:58').
registro_accion('Borrar', 'Cargo', chofer, '2025-02-05 19:42:11').
registro_accion('Borrar', 'Cargo', ingeniero, '2025-02-05 20:00:41').
registro_accion('Borrar', 'Empleado', pepe, '2025-02-05 20:02:32').
registro_accion('Borrar', 'Empleado', 'Jose Agustin', '2025-02-05 20:02:43').
registro_accion('Agregar', 'Empleado', 15, '2025-02-06 00:12:23').
registro_accion('Borrar', 'Empleado', joridama, '2025-02-06 00:13:04').
registro_accion('Agregar', 'Cargo', yutuber, '2025-02-06 00:13:46').
registro_accion('Borrar', 'Cargo', yutuber, '2025-02-06 00:14:06').
registro_accion('Agregar', 'Tarea', 'irse de vacaciones', '2025-02-06 01:00:12').
registro_accion('Borrar', 'Tarea', 'irse de vacaciones', '2025-02-06 01:09:18').
registro_accion('Consultar', 'Cargo', programador, '2025-02-06 01:10:13').
registro_accion('Agregar', 'Cargo', esclavo, '2025-02-06 01:11:35').
registro_accion('Agregar', 'CargoEmpleado', esclavo, '2025-02-06 01:18:44').
registro_accion('Agregar', 'Tarea', relajarse, '2025-02-06 01:23:29').
registro_accion('Agregar', 'Empleado', 16, '2025-02-06 03:46:54').
registro_accion('Agregar', 'Empleado', 17, '2025-02-06 03:47:29').
registro_accion('Agregar', 'Empleado', 18, '2025-02-06 03:51:48').
registro_accion('Agregar', 'Empleado', 19, '2025-02-06 03:52:44').
registro_accion('Agregar', 'Empleado', 20, '2025-02-06 03:54:43').
registro_accion('Agregar', 'Empleado', 21, '2025-02-06 04:06:44').
registro_accion('Borrar', 'Empleado', goku, '2025-02-06 04:08:54').
registro_accion('Borrar', 'Empleado', otro, '2025-02-06 04:09:19').
registro_accion('Borrar', 'Cargo', portero, '2025-02-06 04:26:45').
registro_accion('Agregar', 'CargoEmpleado', esclavo, '2025-02-06 04:39:09').
registro_accion('Agregar', 'Tarea', ' lavar la ropa', '2025-02-06 04:46:07').
registro_accion('Agregar', 'Tarea', comer, '2025-02-06 04:53:46').
registro_accion('Agregar', 'Tarea', cocinar, '2025-02-06 05:19:38').
registro_accion('Agregar', 'Empleado', 22, '2025-02-06 07:46:53').
registro_accion('Borrar', 'Empleado', pancho, '2025-02-06 07:47:00').
registro_accion('Agregar', 'Cargo', periodista, '2025-02-06 07:50:48').
registro_accion('Borrar', 'Cargo', periodista, '2025-02-06 07:50:57').
registro_accion('Agregar', 'CargoEmpleado', profe, '2025-02-06 07:51:43').
registro_accion('Agregar', 'Tarea', entrenar, '2025-02-06 07:52:07').
registro_accion('Borrar', 'Tarea', entrenar, '2025-02-06 07:52:26').
registro_accion('Completar', 'Tarea', comer, '2025-02-06 08:02:51').
registro_accion('Completar', 'Tarea', chambear, '2025-02-06 08:03:45').
registro_accion('Agregar', 'Tarea', lavar, '2025-02-06 08:05:12').
registro_accion('Completar', 'Tarea', relajarse, '2025-02-06 08:08:36').
registro_accion('Agregar', 'Tarea', fregar, '2025-02-06 08:14:24').
registro_accion('Agregar', 'Tarea', nada, '2025-02-06 08:15:14').
registro_accion('Agregar', 'Tarea', nada, '2025-02-06 08:16:56').
registro_accion('Agregar', 'Empleado', 23, '2025-02-06 08:17:36').
registro_accion('Borrar', 'Empleado', veggeta, '2025-02-06 08:17:45').
registro_accion('Agregar', 'CargoEmpleado', programador, '2025-02-06 08:42:41').

:- dynamic id_contador/1.

id_contador(23).

:- dynamic id_contador_turno/1.

id_contador_turno(15).

:- dynamic turno/5.

turno(9, 3, 11, ingeniero, 1).
turno(12, 10, 22, ingeniero, 2).
turno(13, 7, 15, programador, 3).
turno(14, 7, 15, profe, 2).
turno(15, 7, 22, esclavo, 5).

:- dynamic limite_turnos/2.

limite_turnos(ingeniero, 5).
limite_turnos(disenador, 5).
limite_turnos(programador, 5).
limite_turnos(portero, 5).
limite_turnos(profe, 4).
limite_turnos(jardinero, 5).
limite_turnos(chofer, 5).
limite_turnos(yutuber, 4).
limite_turnos(esclavo, 7).
limite_turnos(periodista, '3').

:- dynamic asignacion_turno/3.

asignacion_turno(2, 3, '2025-01-20').
asignacion_turno(5, 3, '2025-01-22').
asignacion_turno(3, 5, '2025-02-13').
asignacion_turno(3, 5, '2025-03-20').
asignacion_turno(3, 5, '2025-03-23').
asignacion_turno(5, 3, '2025-02-03').
asignacion_turno(5, 3, '2025-08-03').

:- dynamic cooldown_turno/2.

cooldown_turno(1, '2025-01-18').
cooldown_turno(2, '2025-01-18').
cooldown_turno(5, '2025-08-04').
cooldown_turno(4, '2025-09-19').
cooldown_turno(6, '2025-08-01').
cooldown_turno(3, '2025-12-12').
cooldown_turno(18, '2025-02-23').
cooldown_turno(16, '2025-02-18').
cooldown_turno(15, '2025-02-21').

