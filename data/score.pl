% Incrementar puntuacion de empleado
incrementar_puntuacion(ID, Reward) :-
    fecha_separada(_, Mes, Anio),
    empleado(ID, Nombre),

    (evaluacion(ID, Anio, Mes, Puntuacion) ->
        NuevaPuntuacion is Puntuacion + Reward,
        retractall(evaluacion(ID, Anio, Mes, _)),
        assertz(evaluacion(ID, Anio, Mes, NuevaPuntuacion)),
        write('Puntuación incrementada para '), write(Nombre), write(' en el mes '), write(Mes), write(' del año '), write(Anio), write('. Puntuación actual: '), writeln(NuevaPuntuacion), nl
    ;
        assertz(evaluacion(ID, Anio, Mes, Reward)),
        write('Evaluación inicial establecida para '), write(Nombre), write(' en el mes '), write(Mes), write(' del año '), write(Anio), write('. Puntuación actual: '), writeln(Reward), nl
    ),
    guardar_datos.

% Incrementar puntuacion por nombre de empleado
incrementar_puntuacion_por_nombre(NombreEmpleado, Reward) :-
    empleado(ID, NombreEmpleado),
    incrementar_puntuacion(ID, Reward).

% Consultar puntuacion
consultar_puntuacion(ID) :-
    fecha_actual_separada(_, MesActual, AnioActual),
    empleado(ID, Nombre),
    findall((Anio, Mes, Puntuacion), 
            (evaluacion(ID, Anio, Mes, Puntuacion), 
             Anio =:= AnioActual, 
             Mes >= MesActual - 2, 
             Mes =< MesActual), 
            Puntuaciones),
    format('--- Puntuaciones de los últimos 3 meses para ~w ---~n', [Nombre]),
    forall(member((Anio, Mes, Puntuacion), Puntuaciones),
           format('Mes: ~w, Año: ~w, Puntuación: ~w~n', [Mes, Anio, Puntuacion])),
    nl.

% Consultar puntuacion por nombre de empleado
consultar_puntuacion_por_nombre(NombreEmpleado) :-
    empleado(ID, NombreEmpleado),
    consultar_puntuacion(ID), nl.

% Evaluar el rendimiento de los empleados
evaluar_rendimiento(ID) :-
    fecha_actual_separada(_, MesActual, AnioActual),
    findall((Anio, Mes, Puntuacion), 
            (evaluacion(ID, Anio, Mes, Puntuacion), 
             Anio =:= AnioActual, 
             Mes >= max(1, MesActual - 2), 
             Mes =< MesActual), 
            Puntuaciones),
    empleado(ID, Nombre),
    format('--- Rendimiento del empleado ~w ---~n', [Nombre]),
    findall(PromedioMensual, 
            (between(1, MesActual, Mes), 
             Mes >= max(1, MesActual - 2),
             findall(P, member((AnioActual, Mes, P), Puntuaciones), PuntuacionesMes),
             sum_list(PuntuacionesMes, TotalMes),
             length(PuntuacionesMes, NumEvaluacionesMes),
             (NumEvaluacionesMes > 0 -> PromedioMensual is TotalMes / NumEvaluacionesMes ; PromedioMensual is 0),
             format('Mes: ~w, Promedio Mensual: ~w~n', [Mes, PromedioMensual])
            ), PromediosMensuales),
    sum_list(PromediosMensuales, TotalPromedios),
    length(PromediosMensuales, NumMeses),
    (NumMeses > 0 -> PromedioAcumulado is TotalPromedios / NumMeses ; PromedioAcumulado is 0),
    format('--- Promedio Acumulado de los últimos 3 meses: ~w ---~n', [PromedioAcumulado]).

% Obtener la fecha actual separada en día, mes y año
fecha_actual_separada(Dia, Mes, Anio) :-
    get_time(Timestamp),
    stamp_date_time(Timestamp, DateTime, local),
    DateTime = date(Anio, Mes, Dia, _, _, _, _, _, _).

% Evaluar rendimiento por nombre de empleado
evaluar_rendimiento_por_nombre(NombreEmpleado) :-
    empleado(ID, NombreEmpleado),
    evaluar_rendimiento(ID).

% Sumar los elementos de una lista
sum_list([], 0).
sum_list([Cabeza|Cola], Suma) :-
    sum_list(Cola, SumaCola),
    Suma is Cabeza + SumaCola.

% Evaluar el desempeño de un empleado en el mes actual
evaluar_desempeno(ID) :-
    fecha_actual_separada(_, Mes, Anio),
    findall(Puntuacion, evaluacion(ID, Anio, Mes, Puntuacion), Puntuaciones),
    sum_list(Puntuaciones, PuntuacionTotal),
    empleado(ID, Nombre),
    format('Desempeño del empleado ~w en el mes ~w del año ~w:~n', [Nombre, Mes, Anio]),
    format('Puntuación total: ~w~n', [PuntuacionTotal]).

% Evaluar el desempeño por nombre de empleado
evaluar_desempeno_por_nombre(NombreEmpleado) :-
    empleado(ID, NombreEmpleado),
    evaluar_desempeno(ID).

% Calcular la puntuación total acumulada de un empleado
calcular_puntuacion_total(ID, PuntuacionTotal) :-
    findall(Puntuacion, evaluacion(ID, _, _, Puntuacion), Puntuaciones),
    sum_list(Puntuaciones, PuntuacionTotal).

% Generar el ranking de los mejores empleados por cargo
ranking_mejores_empleados :-
    findall(Cargo, cargo(Cargo), Cargos),
    forall(member(Cargo, Cargos), ranking_mejores_empleados_por_cargo(Cargo)).

% Generar el ranking de los mejores empleados para un cargo específico
ranking_mejores_empleados_por_cargo(Cargo) :-
    findall(PuntuacionTotal-IDEmpleado,
            (cargo_empleado(IDEmpleado, Cargo), calcular_puntuacion_total(IDEmpleado, PuntuacionTotal)),
            Empleados),
    keysort(Empleados, EmpleadosOrdenados),
    reverse(EmpleadosOrdenados, EmpleadosOrdenadosDesc),
    format('Mejores empleados para el cargo ~w:~n', [Cargo]), nl,
    findall(_, (nth1(Pos, EmpleadosOrdenadosDesc, PuntuacionTotal-IDEmpleado),
               Pos =< 3,
               empleado(IDEmpleado, Nombre),
               format('Empleado: ~w, Puntuación total: ~w~n', [Nombre, PuntuacionTotal])), _).