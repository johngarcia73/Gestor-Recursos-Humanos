import tkinter as tk
from tkinter import messagebox
from pyswip import Prolog

# Inicializa Prolog
prolog = Prolog()
prolog.consult('base_conocimientos.pl')
prolog.consult('date.pl')
prolog.consult('empleado.pl')
prolog.consult('tarea.pl')
prolog.consult('cargo.pl')
prolog.consult('score.pl')
prolog.consult('turno.pl')
prolog.consult('human_resources.pl')
prolog.consult('usuario.pl')
# ... agrega los demás archivos .pl según sea necesario

def iniciar_aplicacion():
    ventana = tk.Tk()
    ventana.title('Sistema de Gestión de Recursos Humanos')
    ventana.geometry('800x600')  # Ajusta el tamaño de la ventana (anchura x altura)

    # Creamos un contenedor principal
    contenedor_principal = tk.Frame(ventana)
    contenedor_principal.pack(fill='both', expand=True)

    # Función para mostrar el menú principal
    def menu_principal():
        # Limpiamos el contenedor antes de mostrar el menú
        for widget in contenedor_principal.winfo_children():
            widget.destroy()

        tk.Label(contenedor_principal, text='--- Sistema de Gestión de Recursos Humanos ---', font=('Helvetica', 16)).pack(pady=20)

        tk.Button(contenedor_principal, text='Gestionar empleados', width=30, command=menu_empleados).pack(pady=10)
        tk.Button(contenedor_principal, text='Gestionar cargos', width=30, command=menu_cargos).pack(pady=10)
        tk.Button(contenedor_principal, text='Gestionar tareas', width=30, command=menu_tareas).pack(pady=10)
        tk.Button(contenedor_principal, text='Gestionar turnos', width=30, command=menu_turnos).pack(pady=10)
        # Añade más botones para otras opciones si es necesario
        tk.Button(contenedor_principal, text='Salir', width=30, command=ventana.quit).pack(pady=10)

    # Funciones para las diferentes secciones
    def menu_empleados():
        # Limpiamos el contenedor antes de mostrar la sección
        for widget in contenedor_principal.winfo_children():
            widget.destroy()

        tk.Label(contenedor_principal, text='--- Gestionar Empleados ---', font=('Helvetica', 16)).pack(pady=20)

        tk.Button(contenedor_principal, text='Agregar empleado', width=30, command=agregar_empleado).pack(pady=10)
        tk.Button(contenedor_principal, text='Borrar empleado', width=30, command=borrar_empleado).pack(pady=10)
        tk.Button(contenedor_principal, text='Consultar empleado', width=30, command=consultar_empleado).pack(pady=10)
        tk.Button(contenedor_principal, text='Mostrar empleados', width=30, command=mostrar_empleados).pack(pady=10)
        tk.Button(contenedor_principal, text='Volver al menú principal', width=30, command=menu_principal).pack(pady=20)

    def menu_cargos():
        # Similar a menu_empleados(), implementa la lógica para gestionar cargos
        for widget in contenedor_principal.winfo_children():
            widget.destroy()

        tk.Label(contenedor_principal, text='--- Gestionar Cargos ---', font=('Helvetica', 16)).pack(pady=20)

        # Añade botones y funcionalidad según tus necesidades
        tk.Button(contenedor_principal, text='Agregar cargo', width=30, command=agregar_cargo).pack(pady=10)
        tk.Button(contenedor_principal, text='Borrar cargo', width=30, command=borrar_cargo).pack(pady=10)
        tk.Button(contenedor_principal, text='Consultar cargo', width=30, command=consultar_cargo).pack(pady=10)
        tk.Button(contenedor_principal, text='Asignar cargo a empleado', width=30, command=asignar_cargo_empleado).pack(pady=10)
        tk.Button(contenedor_principal, text='Volver al menú principal', width=30, command=menu_principal).pack(pady=20)
        
        
        
    def menu_tareas():
        # Similar a menu_empleados(), implementa la lógica para gestionar cargos
        for widget in contenedor_principal.winfo_children():
            widget.destroy()

        tk.Label(contenedor_principal, text='--- Gestionar Tareas ---', font=('Helvetica', 16)).pack(pady=20)

        # Añade botones y funcionalidad según tus necesidades
        tk.Button(contenedor_principal, text='Agregar tarea a empleado', width=30, command=agregar_tarea_empleado).pack(pady=10)
        tk.Button(contenedor_principal, text='Borrar tarea de empleado', width=30, command=borrar_tarea_empleado).pack(pady=10)
        tk.Button(contenedor_principal, text='Completar tarea de empleado', width=30, command=completar_tarea_empleado).pack(pady=10)
        tk.Button(contenedor_principal, text='Obtener tareas de empleado', width=30, command=obtener_tarea_empleado).pack(pady=10)
        tk.Button(contenedor_principal, text='Volver al menú principal', width=30, command=menu_principal).pack(pady=20)



    def menu_turnos():
        # Similar a menu_empleados(), implementa la lógica para gestionar cargos
        for widget in contenedor_principal.winfo_children():
            widget.destroy()

        tk.Label(contenedor_principal, text='--- Gestionar Turnos ---', font=('Helvetica', 16)).pack(pady=20)

        # Añade botones y funcionalidad según tus necesidades
        tk.Button(contenedor_principal, text='Agregar turno', width=30, command=agregar_turno).pack(pady=10)
        tk.Button(contenedor_principal, text='Mostrar turnos', width=30, command=listar_todos_los_turnos).pack(pady=10)
        tk.Button(contenedor_principal, text='Borrar turno', width=30, command=borrar_turno).pack(pady=10)
        tk.Button(contenedor_principal, text='Consultar turnos por cargo', width=30, command=completar_tarea_empleado).pack(pady=10)
        tk.Button(contenedor_principal, text='Planificar automáticamente turnos para una fecha', width=30, command=obtener_tarea_empleado).pack(pady=10)
        tk.Button(contenedor_principal, text='Volver al menú principal', width=30, command=menu_principal).pack(pady=20)


    # Funciones de gestión de empleados
    def agregar_empleado():
        for widget in contenedor_principal.winfo_children():
            widget.destroy()

        tk.Label(contenedor_principal, text='Agregar Empleado', font=('Helvetica', 16)).pack(pady=20)

        tk.Label(contenedor_principal, text='Ingrese el nombre del empleado:').pack(pady=5)
        entrada_nombre = tk.Entry(contenedor_principal)
        entrada_nombre.pack(pady=5)

       
        def ejecutar_agregar():
            nombre = entrada_nombre.get()
            if not nombre :
                messagebox.showwarning('Advertencia', 'Por favor, complete todos los campos.')
                return
            try:
                consulta=f"agregar_empleado_por_nombre('{nombre}',Resultado)"
                resultado= list(prolog.query(consulta))
                if resultado:
                    res=resultado[0]['Resultado']
                    if res[0]=='ok':
                        messagebox.showinfo('Éxito', f"Empleado {nombre} agregado exitosamente.")
                    elif res[0]=='error':
                        messagebox.showerror('Error', res[1])
                else:
                    messagebox.showerror('Error', 'No se obtuvo respuesta de Prolog.')
            except Exception as e:
                messagebox.showerror('Error', f"Ocurrió un error: {e}")
            menu_empleados()

        tk.Button(contenedor_principal, text='Agregar', command=ejecutar_agregar).pack(pady=10)
        tk.Button(contenedor_principal, text='Volver', command=menu_empleados).pack(pady=5)
        
    def borrar_empleado():
        for widget in contenedor_principal.winfo_children():
            widget.destroy()

        tk.Label(contenedor_principal, text='Borrar Empleado', font=('Helvetica', 16)).pack(pady=20)

        tk.Label(contenedor_principal, text='Ingrese el nombre del empleado a borrar:').pack(pady=5)
        entrada_nombre = tk.Entry(contenedor_principal)
        entrada_nombre.pack(pady=5)

        def ejecutar_borrar():
            nombre = entrada_nombre.get()
            if not nombre:
                messagebox.showwarning('Advertencia', 'Por favor, ingrese el nombre del empleado.')
                return
            try:
                consulta=f"borrar_empleado_por_nombre('{nombre}',Resultado)"
                resultado= list(prolog.query(consulta))
                if resultado:
                    res=resultado[0]['Resultado']
                    if res[0]=='ok':
                        messagebox.showinfo('Éxito', f"Empleado {nombre} borrado exitosamente.")
                    elif res[0]=='error':
                        messagebox.showerror('Error', res[1])
                else:
                    messagebox.showerror('Error', 'No se obtuvo respuesta de Prolog.')
            except Exception as e:
                messagebox.showerror('Error', f"Ocurrió un error: {e}")
            menu_empleados()

        tk.Button(contenedor_principal, text='Borrar', command=ejecutar_borrar).pack(pady=10)
        tk.Button(contenedor_principal, text='Volver', command=menu_empleados).pack(pady=5)

    def consultar_empleado():
        for widget in contenedor_principal.winfo_children():
            widget.destroy()

        tk.Label(contenedor_principal, text='Consultar Empleado', font=('Helvetica', 16)).pack(pady=20)

        tk.Label(contenedor_principal, text='Ingrese el nombre del empleado a consultar:').pack(pady=5)
        entrada_nombre = tk.Entry(contenedor_principal)
        entrada_nombre.pack(pady=5)

        def ejecutar_consultar():
            nombre = entrada_nombre.get()
            if not nombre:
                messagebox.showwarning('Advertencia', 'Por favor, ingrese el nombre del empleado.')
                return
            try:
                empleado_query = list(prolog.query(f"empleado(ID, '{nombre}')"))
                if empleado_query:
                    info = empleado_query[0]
                    mensaje = f"ID: {info['ID']}\nNombre: {nombre}"
                    messagebox.showinfo('Información del Empleado', mensaje)
                else:
                    messagebox.showerror('Error', f"Empleado {nombre} no encontrado.")
            except Exception as e:
                messagebox.showerror('Error', f"Ocurrió un error: {e}")
            menu_empleados()

        tk.Button(contenedor_principal, text='Consultar', command=ejecutar_consultar).pack(pady=10)
        tk.Button(contenedor_principal, text='Volver', command=menu_empleados).pack(pady=5)

    def mostrar_empleados():
        for widget in contenedor_principal.winfo_children():
            widget.destroy()

        tk.Label(contenedor_principal, text='--- Empleados Disponibles ---', font=('Helvetica', 16)).pack(pady=20)

        canvas = tk.Canvas(contenedor_principal)
        scrollbar = tk.Scrollbar(contenedor_principal, orient="vertical", command=canvas.yview)
        scroll_frame = tk.Frame(canvas)

        scroll_frame.bind(
            "<Configure>",
            lambda e: canvas.configure(
                scrollregion=canvas.bbox("all")
            )
        )

        canvas.create_window((0, 0), window=scroll_frame, anchor='nw')
        canvas.configure(yscrollcommand=scrollbar.set)

        cargos = list(prolog.query("cargo(NombreCargo)"))
        if not cargos:
            tk.Label(scroll_frame, text="No hay cargos disponibles.").pack()
        else:
            for cargo in cargos:
                nombre_cargo = cargo['NombreCargo']
                tk.Label(scroll_frame, text=f"Cargo: {nombre_cargo}", font=('Helvetica', 12, 'bold')).pack(pady=5, anchor='w')

                empleados = list(prolog.query(f"cargo_empleado(ID, '{nombre_cargo}'), empleado(ID, Nombre)"))
                if empleados:
                    for empleado in empleados:
                        tk.Label(scroll_frame, text=f"  ID: {empleado['ID']}, Nombre: {empleado['Nombre']}", anchor='w').pack(pady=2, anchor='w')
                else:
                    tk.Label(scroll_frame, text="  No hay empleados asignados a este cargo.", anchor='w').pack(pady=2, anchor='w')

        canvas.pack(side="left", fill="both", expand=True)
        scrollbar.pack(side="right", fill="y")

        tk.Button(contenedor_principal, text='Volver', command=menu_empleados).pack(pady=20)

    # Funciones de gestion de cargo
    def agregar_cargo():
        for widget in contenedor_principal.winfo_children():
            widget.destroy()

        tk.Label(contenedor_principal, text='Agregar Cargo', font=('Helvetica', 16)).pack(pady=20)

        tk.Label(contenedor_principal, text='Ingrese el nombre del cargo:').pack(pady=5)
        entrada_nombre = tk.Entry(contenedor_principal)
        entrada_nombre.pack(pady=5)
        
        tk.Label(contenedor_principal, text='Ingrese límite de turnos a la semana:').pack(pady=5)
        entrada_limite_turnos = tk.Entry(contenedor_principal)
        entrada_limite_turnos.pack(pady=5)
        

        def ejecutar_agregar():
            nombre = entrada_nombre.get()
            limite_turnos=entrada_limite_turnos.get()
            if not nombre or not limite_turnos:
                messagebox.showwarning('Advertencia', 'Por favor, complete todos los campos.')
                return
            try:
                for result in prolog.query(f"agregar_cargo_por_nombre('{nombre}')"):
                    messagebox.showinfo('Resultado', result)
                for result in prolog.query(f"agregar_limite_semanal('{nombre}', {limite_turnos})"):
                    messagebox.showinfo('Resultado', result) 
            except Exception as e:
                messagebox.showerror('Error', f"Ocurrió un error: {e}")
            menu_cargos()

        tk.Button(contenedor_principal, text='Agregar', command=ejecutar_agregar).pack(pady=10)
        tk.Button(contenedor_principal, text='Volver', command=menu_cargos).pack(pady=5)

    def borrar_cargo():
        for widget in contenedor_principal.winfo_children():
            widget.destroy()

        tk.Label(contenedor_principal, text='Borrar Cargo', font=('Helvetica', 16)).pack(pady=20)

        tk.Label(contenedor_principal, text='Ingrese el nombre del cargo a borrar:').pack(pady=5)
        entrada_nombre = tk.Entry(contenedor_principal)
        entrada_nombre.pack(pady=5)

        def ejecutar_borrar():
            nombre = entrada_nombre.get()
            if not nombre:
                messagebox.showwarning('Advertencia', 'Por favor, ingrese el nombre del cargo.')
                return
            try:
                consulta=f"borrar_cargo_por_nombre('{nombre}',Resultado)"
                resultado= list(prolog.query(consulta))
                if resultado:
                    res=resultado[0]['Resultado']
                    if res[0]=='ok':
                        messagebox.showinfo('Éxito', f"Cargo {nombre} borrado exitosamente.")
                    elif res[0]=='error':
                        messagebox.showerror('Error', res[1])
                else:
                    messagebox.showerror('Error', 'No se obtuvo respuesta de Prolog.')
            except Exception as e:
                messagebox.showerror('Error', f"Ocurrió un error: {e}")
            menu_cargos()

        tk.Button(contenedor_principal, text='Borrar', command=ejecutar_borrar).pack(pady=10)
        tk.Button(contenedor_principal, text='Volver', command=menu_cargos).pack(pady=5)

    def consultar_cargo():
        for widget in contenedor_principal.winfo_children():
            widget.destroy()

        tk.Label(contenedor_principal, text='Consultar cargo', font=('Helvetica', 16)).pack(pady=20)

        tk.Label(contenedor_principal, text='Ingrese el nombre del cargo a consultar:').pack(pady=5)
        entrada_nombre = tk.Entry(contenedor_principal)
        entrada_nombre.pack(pady=5)

        def ejecutar_consultar():
            nombre = entrada_nombre.get()
            if not nombre:
                messagebox.showwarning('Advertencia', 'Por favor, ingrese el nombre del cargo.')
                return
            try:
                cargo_query = list(prolog.query(f"cargo('{nombre}')"))
                if cargo_query:
                    mensaje = f"Nombre: {nombre}"
                    messagebox.showinfo('Cargo', mensaje)
                else:
                    messagebox.showerror('Error', f"Cargo {nombre} no encontrado.")
            except Exception as e:
                messagebox.showerror('Error', f"Ocurrió un error: {e}")
            menu_cargos()

        tk.Button(contenedor_principal, text='Consultar', command=ejecutar_consultar).pack(pady=10)
        tk.Button(contenedor_principal, text='Volver', command=menu_empleados).pack(pady=5)

    def asignar_cargo_empleado():
        for widget in contenedor_principal.winfo_children():
            widget.destroy()

        tk.Label(contenedor_principal, text='Asignar cargo.', font=('Helvetica', 16)).pack(pady=20)
        
        tk.Label(contenedor_principal, text='Ingrese el nombre del cargo :').pack(pady=5)
        entrada_nombre_cargo = tk.Entry(contenedor_principal)
        entrada_nombre_cargo.pack(pady=5)
        
        tk.Label(contenedor_principal, text='Ingrese el nombre del empleado:').pack(pady=5)
        entrada_nombre_empleado = tk.Entry(contenedor_principal)
        entrada_nombre_empleado.pack(pady=5)
        
        def asignar():
            cargo=entrada_nombre_cargo.get()
            empleado=entrada_nombre_empleado.get()
            if not cargo or not empleado:
                messagebox.showwarning('Advertencia', 'Por favor, rellene todos los campos.')
                return
            else:    
                try:
                    consulta=f"asignar_cargo_a_empleado('{empleado}','{cargo}',Resultado)"
                    resultado= list(prolog.query(consulta))
                    if resultado:
                        res=resultado[0]['Resultado']
                    if res[0]=='ok':
                        messagebox.showinfo('Éxito', f"Asignado exitosamente.")
                    elif res[0]=='error':
                        messagebox.showerror('Error', res[1])
                    else:
                        messagebox.showerror('Error', 'No se obtuvo respuesta de Prolog.')
                except Exception as e:
                    messagebox.showerror('Error', f"Ocurrió un error: {e}")
            
            menu_cargos()
            
        tk.Button(contenedor_principal, text='Asignar', command=asignar).pack(pady=10)
        tk.Button(contenedor_principal, text='Volver', command=menu_cargos).pack(pady=5)
        
        
    # Funciones de gestion de tareas
    def agregar_tarea_empleado():
        for widget in contenedor_principal.winfo_children():
            widget.destroy()

        tk.Label(contenedor_principal, text='Agregar Tarea de Empleado', font=('Helvetica', 16)).pack(pady=20)

        tk.Label(contenedor_principal, text='Ingrese el nombre del empleado:').pack(pady=5)
        entrada_nombre = tk.Entry(contenedor_principal)
        entrada_nombre.pack(pady=5)
        
        tk.Label(contenedor_principal, text='Ingrese la tarea:').pack(pady=5)
        entrada_tarea = tk.Entry(contenedor_principal)
        entrada_tarea.pack(pady=5)
        
        tk.Label(contenedor_principal, text='Ingrese el valor de la tarea:').pack(pady=5)
        entrada_valor = tk.Entry(contenedor_principal)
        entrada_valor.pack(pady=5)
        
        def ejecutar_agregar():
            empleado = entrada_nombre.get()
            tarea = entrada_tarea.get()
            valor = entrada_valor.get()
            if not empleado or not tarea or not valor :
                messagebox.showwarning('Advertencia', 'Por favor, complete todos los campos.')
                return
            try:
                consulta=f"agregar_tarea_a_empleado('{empleado}','{tarea}','{valor}',Resultado)"
                resultado= list(prolog.query(consulta))
                if resultado:
                    res=resultado[0]['Resultado']
                    if res[0]=='ok':
                        messagebox.showinfo('Éxito', f"Tarea agregado a empleado {empleado}  exitosamente.")
                    elif res[0]=='error':
                        messagebox.showerror('Error', res[1])
                else:
                    messagebox.showerror('Error', 'No se obtuvo respuesta de Prolog.')
            except Exception as e:
                messagebox.showerror('Error', f"Ocurrió un error: {e}")
            menu_tareas()

        tk.Button(contenedor_principal, text='Agregar', command=ejecutar_agregar).pack(pady=10)
        tk.Button(contenedor_principal, text='Volver', command=menu_tareas).pack(pady=5)
    
    def borrar_tarea_empleado():
        for widget in contenedor_principal.winfo_children():
            widget.destroy()

        tk.Label(contenedor_principal, text='Borrar Tarea de Empleado', font=('Helvetica', 16)).pack(pady=20)

        tk.Label(contenedor_principal, text='Ingrese el nombre del empleado:').pack(pady=5)
        entrada_nombre = tk.Entry(contenedor_principal)
        entrada_nombre.pack(pady=5)
        
        tk.Label(contenedor_principal, text='Ingrese la tarea a borrar:').pack(pady=5)
        entrada_tarea = tk.Entry(contenedor_principal)
        entrada_tarea.pack(pady=5)
        
        def ejecutar_borrar():
            nombre = entrada_nombre.get()
            tarea=entrada_tarea.get()
            if not nombre or not tarea:
                messagebox.showwarning('Advertencia', 'Por favor, rellene todos los campos.')
                return
            try:
                consulta=f"borrar_tarea_de_empleado('{nombre}','{tarea}',Resultado)"
                resultado= list(prolog.query(consulta))
                if resultado:
                    res=resultado[0]['Resultado']
                    if res[0]=='ok':
                        messagebox.showinfo('Éxito', f"Tarea borrada exitosamente.")
                    elif res[0]=='error':
                        messagebox.showerror('Error', res[1])
                else:
                    messagebox.showerror('Error', 'No se obtuvo respuesta de Prolog.')
            except Exception as e:
                messagebox.showerror('Error', f"Ocurrió un error: {e}")
            menu_tareas()

        tk.Button(contenedor_principal, text='Borrar', command=ejecutar_borrar).pack(pady=10)
        tk.Button(contenedor_principal, text='Volver', command=menu_tareas).pack(pady=5)

    def completar_tarea_empleado():
        for widget in contenedor_principal.winfo_children():
            widget.destroy()

        tk.Label(contenedor_principal, text='Agregar Empleado', font=('Helvetica', 16)).pack(pady=20)

        tk.Label(contenedor_principal, text='Ingrese el nombre del empleado:').pack(pady=5)
        entrada_nombre = tk.Entry(contenedor_principal)
        entrada_nombre.pack(pady=5)
        
        tk.Label(contenedor_principal, text='Ingrese la tarea a completar:').pack(pady=5)
        entrada_tarea = tk.Entry(contenedor_principal)
        entrada_tarea.pack(pady=5)
        
        def completar():
            nombre = entrada_nombre.get()
            tarea=entrada_tarea.get()
            if not nombre or not tarea:
                messagebox.showwarning('Advertencia', 'Por favor, complete todos los campos.')
                return
            try:
                consulta=f"completar_tarea_de_empleado('{nombre}','{tarea}',Resultado)"
                resultado= list(prolog.query(consulta))
                if resultado:
                    res=resultado[0]['Resultado']
                    if res[0]=='ok':
                        messagebox.showinfo('Éxito', f"Tarea completada exitosamente.")
                    elif res[0]=='error':
                        messagebox.showerror('Error', res[1])
                else:
                    messagebox.showerror('Error', 'No se obtuvo respuesta de Prolog.')
            except Exception as e:
                messagebox.showerror('Error', f"Ocurrió un error: {e}")
            menu_tareas()

        tk.Button(contenedor_principal, text='Agregar', command=completar).pack(pady=10)
        tk.Button(contenedor_principal, text='Volver', command=menu_tareas).pack(pady=5)
        
    def obtener_tarea_empleado():
        for widget in contenedor_principal.winfo_children():
            widget.destroy()

        tk.Label(contenedor_principal, text='Tareas', font=('Helvetica', 16)).pack(pady=20)

        tk.Label(contenedor_principal, text='Ingrese el nombre del empleado:').pack(pady=5)
        entrada_nombre = tk.Entry(contenedor_principal)
        entrada_nombre.pack(pady=5)
        
        def ejecutar():
            nombre = entrada_nombre.get()
            if not nombre:
                messagebox.showwarning('Advertencia', 'Por favor, ingrese el nombre del empleado.')
                return
            try:
                consulta = f"obtener_tareas_de_empleado('{nombre}', Resultado)"
                resultado = list(prolog.query(consulta))
                if resultado:
                    res = resultado[0]['Resultado']
                    if res[0] == 'ok':
                        tareas = res[2]
                        mensaje = f"Tareas de {nombre}:\n" + "\n".join(tareas)
                        messagebox.showinfo('Tareas', mensaje)
                    elif res[0] == 'error':
                        messagebox.showerror('Error', res[1])
                else:
                    messagebox.showerror('Error', 'No se obtuvo respuesta de Prolog.')
            except Exception as e:
                messagebox.showerror('Error', f"Ocurrió un error: {e}")
            menu_tareas()

        tk.Button(contenedor_principal, text='Mostrar', command=ejecutar).pack(pady=10)
        tk.Button(contenedor_principal, text='Volver', command=menu_tareas).pack(pady=5)
        
        
    # Funciones de gestion de turnos
    def agregar_turno():
        for widget in contenedor_principal.winfo_children():
            widget.destroy()

        tk.Label(contenedor_principal, text='Agregar Turno', font=('Helvetica', 16)).pack(pady=20)

        tk.Label(contenedor_principal, text='Ingrese la hora de inicio del turno:').pack(pady=5)
        entrada_inicio = tk.Entry(contenedor_principal)
        entrada_inicio.pack(pady=5)
        
        tk.Label(contenedor_principal, text='Ingrese la hora de fin del turno:').pack(pady=5)
        entrada_fin = tk.Entry(contenedor_principal)
        entrada_fin.pack(pady=5)
        
        tk.Label(contenedor_principal, text='Ingrese el cargo del turno: ').pack(pady=5)
        entrada_cargo = tk.Entry(contenedor_principal)
        entrada_cargo.pack(pady=5)
        
        tk.Label(contenedor_principal, text='Ingrese el cooldown del turno: ').pack(pady=5)
        entrada_cooldown = tk.Entry(contenedor_principal)
        entrada_cooldown.pack(pady=5)
        
        
        def ejecutar_agregar():
            inicio = entrada_inicio.get()
            fin= entrada_fin.get()
            cargo = entrada_cargo.get()
            cooldown = entrada_cooldown.get()
            if not inicio or not fin or not cargo or not cooldown :
                messagebox.showwarning('Advertencia', 'Por favor, complete todos los campos.')
                return
            try:
                consulta=f"agregar_turno_por_detalles({inicio},{fin},{cargo},{cooldown},Resultado)"
                resultado= list(prolog.query(consulta))
                if resultado:
                    res=resultado[0]['Resultado']
                    if res[0]=='ok':
                        messagebox.showinfo('Éxito', f"Turno agregado exitosamente.")
                    elif res[0]=='error':
                        messagebox.showerror('Error', res[1])
                else:
                    messagebox.showerror('Error', 'No se obtuvo respuesta de Prolog.')
            except Exception as e:
                messagebox.showerror('Error', f"Ocurrió un error: {e}")
            menu_turnos()

        tk.Button(contenedor_principal, text='Agregar', command=ejecutar_agregar).pack(pady=10)
        tk.Button(contenedor_principal, text='Volver', command=menu_turnos).pack(pady=5)
        
    def listar_todos_los_turnos():
        for widget in contenedor_principal.winfo_children():
            widget.destroy()

        canvas = tk.Canvas(contenedor_principal)
        scrollbar = tk.Scrollbar(contenedor_principal, orient="vertical", command=canvas.yview)
        scroll_frame = tk.Frame(canvas)

        scroll_frame.bind(
            "<Configure>",
            lambda e: canvas.configure(
                scrollregion=canvas.bbox("all")
            )
        )

        canvas.create_window((0, 0), window=scroll_frame, anchor='nw')
        canvas.configure(yscrollcommand=scrollbar.set)

        tk.Label(scroll_frame, text="--- Turnos Disponibles ---", font=('Helvetica', 16)).pack(pady=20)

        try:
            turnos = list(prolog.query('listar_todos_los_turnos'))
            if turnos:
                for turno in turnos[0]['Turnos']:
                    tk.Label(scroll_frame, text=f"ID: {turno[0]}, HoraInicio: {turno[1]}:00, HoraFin: {turno[2]}:00, Cargo: {turno[3]}, Cooldown: {turno[4]} días", font=('Helvetica', 12)).pack(anchor='w', pady=2)
            else:
                tk.Label(scroll_frame, text="No hay turnos disponibles.", font=('Helvetica', 12)).pack(anchor='w', pady=2)
        except Exception as e:
            messagebox.showerror('Error', f"Ocurrió un error: {e}")

        canvas.pack(side="left", fill="both", expand=True)
        scrollbar.pack(side="right", fill="y")

        tk.Button(contenedor_principal, text='Volver', command=menu_turnos).pack(pady=5)

    
        
    # Inicializamos mostrando el menú principal
    menu_principal()
    ventana.mainloop()

# Ejecutamos la aplicación
if __name__ == '__main__':
    iniciar_aplicacion()
