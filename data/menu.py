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
                for result in prolog.query(f"agregar_empleado_por_nombre('{nombre}')"):
                    messagebox.showinfo('Resultado', result)
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
                empleado_query = list(prolog.query(f"empleado(ID, '{nombre}')"))
                if empleado_query:
                    for result in prolog.query(f"borrar_empleado_por_nombre('{nombre}')"):
                        messagebox.showinfo('Resultado', f"Empleado {nombre} borrado exitosamente.")
                else:
                    messagebox.showerror('Error', f"Empleado {nombre} no encontrado.")
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
                    # Si tienes más información, agrégala aquí
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
                empleado_query = list(prolog.query(f"cargo('{nombre}')"))
                if empleado_query:
                    for result in prolog.query(f"borrar_cargo_por_nombre('{nombre}')"):
                        messagebox.showinfo('Resultado', f"Cargo {nombre} borrado exitosamente.")
                else:
                    messagebox.showerror('Error', f"Cargo {nombre} no encontrado.")
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
                    for result in prolog.query(f"consultar_cargo_por_nombre('{nombre}')"):
                        messagebox.showinfo('Información del Cargo', result)
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
            empleado_query = list(prolog.query(f"empleado('{empleado}')"))
            cargo_query=list(prolog.query(f"cargo('{cargo}')"))
            if  not empleado_query or not cargo_query:
                messagebox.showerror('Error', f"Cargo {cargo} o Empleado {empleado} no encontrado.")
            else:    
                try:
                    for result in prolog.query(f"asignar_cargo_a_empleado({empleado}, {cargo})"):
                        messagebox.showinfo('Resultado', result) 
                except Exception as e:
                    messagebox.showerror('Error', f"Ocurrió un error: {e}")
            
            menu_cargos()
            
        tk.Button(contenedor_principal, text='Asignar', command=asignar).pack(pady=10)
        tk.Button(contenedor_principal, text='Volver', command=menu_cargos).pack(pady=5)
        
    # Inicializamos mostrando el menú principal
    menu_principal()
    ventana.mainloop()

# Ejecutamos la aplicación
if __name__ == '__main__':
    iniciar_aplicacion()
