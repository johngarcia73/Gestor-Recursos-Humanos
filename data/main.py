from pyswip import Prolog

prolog = Prolog()

# Cargar la base de conocimientos y dependencias
prolog.consult('base_conocimientos.pl')
prolog.consult('date.pl')
prolog.consult('empleado.pl')
prolog.consult('tarea.pl')
prolog.consult('cargo.pl')
prolog.consult('score.pl')
prolog.consult('turno.pl')
prolog.consult('human_resources.pl')
prolog.consult('usuario.pl')

def menu_principal():
    print('--- Sistema de Gestión de Recursos Humanos ---')
    print('1. Gestionar empleados')
    print('2. Gestionar cargos')
    print('3. Gestionar tareas')
    print('4. Gestionar turnos')
    print('5. Gestionar puntuaciones')
    print('0. Salir')
    opcion = input('Seleccione una opción: ')
    ejecutar_opcion_principal(opcion)

def ejecutar_opcion_principal(opcion):
    if opcion == '1':
        menu_empleados()
    elif opcion == '2':
        menu_cargos()
    elif opcion == '3':
        menu_tareas()
    elif opcion == '4':
        menu_turnos()
    elif opcion == '5':
        menu_puntuaciones()
    elif opcion == '0':
        prolog.assertz("guardar_base_conocimientos")
        print('Saliendo del sistema...')
        exit()
    else:
        print('Opción no válida, intente de nuevo.')
        continuar(menu_principal)

def menu_empleados():
    print('--- Gestionar Empleados ---')
    print('1. Agregar empleado')
    print('2. Borrar empleado')
    print('3. Consultar empleado')
    print('0. Volver al menú principal')
    opcion = input('Seleccione una opción: ')
    ejecutar_opcion_empleados(opcion)

def ejecutar_opcion_empleados(opcion):
    if opcion == '1':
        nombre = input('Ingrese el nombre del empleado: ')
        for result in prolog.query(f"agregar_empleado_por_nombre('{nombre}')"):
            print(result)
    elif opcion == '2':
        nombre = input('Ingrese el nombre del empleado: ')
        for result in prolog.query(f"borrar_empleado_por_nombre('{nombre}')"):
            print(result)
    elif opcion == '3':
        nombre = input('Ingrese el nombre del empleado: ')
        for result in prolog.query(f"consultar_empleado_por_nombre('{nombre}')"):
            print(result)
    elif opcion == '0':
        menu_principal()
        return
    else:
        print('Opción no válida, intente de nuevo.')
    continuar(menu_empleados)

def menu_cargos():
    print('--- Gestionar Cargos ---')
    print('1. Agregar cargo')
    print('2. Borrar cargo')
    print('3. Consultar cargo')
    print('0. Volver al menú principal')
    opcion = input('Seleccione una opción: ')
    ejecutar_opcion_cargos(opcion)

def ejecutar_opcion_cargos(opcion):
    if opcion == '1':
        nombre_cargo = input('Ingrese el nombre del cargo: ')
        for result in prolog.query(f"agregar_cargo_por_nombre('{nombre_cargo}')"):
            print(result)
    elif opcion == '2':
        nombre_cargo = input('Ingrese el nombre del cargo: ')
        for result in prolog.query(f"borrar_cargo_por_nombre('{nombre_cargo}')"):
            print(result)
    elif opcion == '3':
        nombre_cargo = input('Ingrese el nombre del cargo: ')
        for result in prolog.query(f"consultar_cargo_por_nombre('{nombre_cargo}')"):
            print(result)
    elif opcion == '0':
        menu_principal()
        return
    else:
        print('Opción no válida, intente de nuevo.')
    continuar(menu_cargos)

def menu_tareas():
    print('--- Gestionar Tareas ---')
    print('1. Agregar tarea a empleado')
    print('2. Borrar tarea de empleado')
    print('3. Consultar tarea de empleado')
    print('4. Completar tarea de empleado')
    print('5. Obtener tareas de empleado')
    print('6. Recomendar tareas a empleado')
    print('7. Consultar todas las tareas de un empleado')
    print('0. Volver al menú principal')
    opcion = input('Seleccione una opción: ')
    ejecutar_opcion_tareas(opcion)

def ejecutar_opcion_tareas(opcion):
    if opcion == '1':
        nombre_empleado = input('Ingrese el nombre del empleado: ')
        tarea = input('Ingrese la tarea: ')
        reward = input('Ingrese el valor de la tarea: ')
        for result in prolog.query(f"agregar_tarea_a_empleado('{nombre_empleado}', '{tarea}', {reward})"):
            print(result)
    elif opcion == '2':
        nombre_empleado = input('Ingrese el nombre del empleado: ')
        tarea = input('Ingrese la tarea: ')
        for result in prolog.query(f"borrar_tarea_de_empleado('{nombre_empleado}', '{tarea}')"):
            print(result)
    elif opcion == '3':
        nombre_empleado = input('Ingrese el nombre del empleado: ')
        tarea = input('Ingrese la tarea: ')
        for result in prolog.query(f"consultar_tarea_de_empleado('{nombre_empleado}', '{tarea}')"):
            print(result)
    elif opcion == '4':
        nombre_empleado = input('Ingrese el nombre del empleado: ')
        tarea = input('Ingrese la tarea: ')
        for result in prolog.query(f"completar_tarea_de_empleado('{nombre_empleado}', '{tarea}')"):
            print(result)
    elif opcion == '5':
        nombre_empleado = input('Ingrese el nombre del empleado: ')
        for result in prolog.query(f"obtener_tareas_de_empleado('{nombre_empleado}')"):
            print(result)
    elif opcion == '6':
        nombre_empleado = input('Ingrese el nombre del empleado: ')
        for result in prolog.query(f"recomendar_tareas_a_empleado('{nombre_empleado}')"):
            print(result)
    elif opcion == '7':
        nombre_empleado = input('Ingrese el nombre del empleado: ')
        for result in prolog.query(f"consultar_todas_las_tareas_de_empleado('{nombre_empleado}')"):
            print(result)
    elif opcion == '0':
        menu_principal()
        return
    else:
        print('Opción no válida, intente de nuevo.')
    continuar(menu_tareas)

def menu_turnos():
    print('--- Gestionar Turnos ---')
    print('1. Agregar turno')
    print('2. Borrar turno')
    print('3. Consultar turnos por cargo')
    print('4. Asignar turno a empleado')
    print('5. Planificar turnos para una fecha')
    print('6. Listar asignaciones de turnos para una fecha')
    print('0. Volver al menú principal')
    opcion = input('Seleccione una opción: ')
    ejecutar_opcion_turnos(opcion)

def ejecutar_opcion_turnos(opcion):
    if opcion == '1':
        hora_inicio = input('Ingrese la hora de inicio del turno: ')
        hora_fin = input('Ingrese la hora de fin del turno: ')
        cargo = input('Ingrese el cargo del turno: ')
        cooldown = input('Ingrese el cooldown del turno: ')
        for result in prolog.query(f"agregar_turno_por_detalles({hora_inicio}, {hora_fin}, '{cargo}', {cooldown})"):
            print(result)
    elif opcion == '2':
        id_turno = input('Ingrese el ID del turno: ')
        for result in prolog.query(f"borrar_turno_por_id({id_turno})"):
            print(result)
    elif opcion == '3':
        cargo = input('Ingrese el nombre del cargo: ')
        for result in prolog.query(f"consultar_turnos_por_cargo('{cargo}')"):
            print(result)
    elif opcion == '4':
        nombre_empleado = input('Ingrese el nombre del empleado: ')
        fecha = input('Ingrese la fecha (YYYY-MM-DD): ')
        consultar_turnos_por_cargo(nombre_empleado, fecha)
    elif opcion == '5':
        fecha = input('Ingrese la fecha (YYYY-MM-DD): ')
        for result in prolog.query(f"planificar_turnos_para_fecha('{fecha}')"):
            print(result)
    elif opcion == '6':
        fecha = input('Ingrese la fecha (YYYY-MM-DD): ')
        for result in prolog.query(f"listar_asignaciones_para_fecha('{fecha}')"):
            print(result)
    elif opcion == '0':
        menu_principal()
        return
    else:
        print('Opción no válida, intente de nuevo.')
    continuar(menu_turnos)

def consultar_turnos_por_cargo(nombre_empleado, fecha):
    empleado_query = list(prolog.query(f"empleado(IDEmpleado, '{nombre_empleado}'), cargo_empleado(IDEmpleado, Cargo)"))
    if empleado_query:
        cargo = empleado_query[0]['Cargo']
        turnos_query = list(prolog.query(f"consultar_turnos_por_cargo('{cargo}')"))
        for turno in turnos_query:
            print(turno)
        id_turno = input(f"Seleccione el ID del turno que desea asignar a {nombre_empleado}: ")
        for result in prolog.query(f"asignar_turno_a_empleado_por_nombre('{nombre_empleado}', '{fecha}', {id_turno})"):
            print(result)
    else:
        print(f"Error: Empleado {nombre_empleado} no encontrado o no tiene un cargo asignado.")

def menu_puntuaciones():
    print('--- Gestionar Puntuaciones ---')
    print('1. Incrementar puntuación de empleado')
    print('2. Consultar puntuación de empleado')
    print('3. Evaluar rendimiento de empleado')
    print('4. Evaluar desempeño de empleado en el mes actual')
    print('5. Generar ranking de mejores empleados')
    print('0. Volver al menú principal')
    opcion = input('Seleccione una opción: ')
    ejecutar_opcion_puntuaciones(opcion)

def ejecutar_opcion_puntuaciones(opcion):
    if opcion == '1':
        nombre_empleado = input('Ingrese el nombre del empleado: ')
        reward = input('Ingrese el valor de la puntuación: ')
        for result in prolog.query(f"incrementar_puntuacion_a_empleado('{nombre_empleado}', {reward})"):
            print(result)
    elif opcion == '2':
        nombre_empleado = input('Ingrese el nombre del empleado: ')
        for result in prolog.query(f"consultar_puntuacion_de_empleado('{nombre_empleado}')"):
            print(result)
    elif opcion == '3':
        nombre_empleado = input('Ingrese el nombre del empleado: ')
        for result in prolog.query(f"evaluar_rendimiento_de_empleado('{nombre_empleado}')"):
            print(result)
    elif opcion == '4':
        nombre_empleado = input('Ingrese el nombre del empleado: ')
        for result in prolog.query(f"evaluar_desempeno_de_empleado('{nombre_empleado}')"):
            print(result)
    elif opcion == '5':
        for result in prolog.query("generar_ranking_mejores_empleados"):
            print(result)
    elif opcion == '0':
        menu_principal()
        return
    else:
        print('Opción no válida, intente de nuevo.')
    continuar(menu_puntuaciones)

def continuar(menu_func):
    input('Presione Enter para continuar...')
    menu_func()

if __name__ == '__main__':
    menu_principal()
