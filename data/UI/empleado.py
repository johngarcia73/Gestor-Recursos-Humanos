import tkinter as tk
from tkinter import messagebox
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

def menu_empleados():
    ventana = tk.Tk()
    ventana.title('Gestionar Empleados')


    tk.Label(ventana, text='--- Gestionar Empleados ---').pack(pady=10)
    tk.Button(ventana, text='1. Agregar empleado', width=30, command=agregar_empleado).pack(pady=5)
    tk.Button(ventana, text='2. Borrar empleado', width=30, command=borrar_empleado).pack(pady=5)
    tk.Button(ventana, text='3. Consultar empleado', width=30, command=consultar_empleado).pack(pady=5)
    tk.Button(ventana, text='0. Volver al menú principal', width=30, command= ventana.destroy).pack(pady=5)

    ventana.mainloop()    

def agregar_empleado():
    ventana_agregar = tk.Toplevel()
    ventana_agregar.title('Agregar Empleado')

    tk.Label(ventana_agregar, text='Ingrese el nombre del empleado:').pack(pady=5)
    entrada_nombre = tk.Entry(ventana_agregar)
    entrada_nombre.pack(pady=5)

    def ejecutar_agregar():
        nombre = entrada_nombre.get()
        for result in prolog.query(f"agregar_empleado_por_nombre('{nombre}')"):
            messagebox.showinfo('Resultado', result)
        ventana_agregar.destroy()

    tk.Button(ventana_agregar, text='Agregar', command=ejecutar_agregar).pack(pady=10)

def borrar_empleado():
    ventana_borrar = tk.Toplevel()
    ventana_borrar.title('Borrar Empleado')

    mostrar_empleados()

    tk.Label(ventana_borrar, text='Ingrese el nombre del empleado:').pack(pady=5)
    entrada_nombre = tk.Entry(ventana_borrar)
    entrada_nombre.pack(pady=5)

    def ejecutar_borrar():
        nombre = entrada_nombre.get()
        for result in prolog.query(f"borrar_empleado_por_nombre('{nombre}')"):
            messagebox.showinfo('Resultado', result)
        ventana_borrar.destroy()

    tk.Button(ventana_borrar, text='Borrar', command=ejecutar_borrar).pack(pady=10)

def consultar_empleado():
    ventana_consultar = tk.Toplevel()
    ventana_consultar.title('Consultar Empleado')

    mostrar_empleados()

    tk.Label(ventana_consultar, text='Ingrese el nombre del empleado:').pack(pady=5)
    entrada_nombre = tk.Entry(ventana_consultar)
    entrada_nombre.pack(pady=5)

    def ejecutar_consultar():
        nombre = entrada_nombre.get()
        empleado_query = list(prolog.query(f"empleado(ID, '{nombre}')"))
        if empleado_query:
            for result in prolog.query(f"consultar_empleado_por_nombre('{nombre}')"):
                messagebox.showinfo('Resultado', result)
        else:
            messagebox.showerror('Error', f"Empleado {nombre} no encontrado.")
        ventana_consultar.destroy()

    tk.Button(ventana_consultar, text='Consultar', command=ejecutar_consultar).pack(pady=10)


def mostrar_empleados():
    ventana_empleados = tk.Toplevel()
    ventana_empleados.title('Empleados disponibles')

    tk.Label(ventana_empleados, text='--- Empleados disponibles ---').pack(pady=10)

    cargos = list(prolog.query("cargo(NombreCargo)"))
    if not cargos:
        tk.Label(ventana_empleados, text="No hay cargos disponibles.").pack()
    else:
        for cargo in cargos:
            nombre_cargo = cargo['NombreCargo']
            tk.Label(ventana_empleados, text=f"Cargo: {nombre_cargo}").pack(pady=5, anchor='w')

            empleados = list(prolog.query(f"cargo_empleado(ID, '{nombre_cargo}'), empleado(ID, Nombre)"))
            if empleados:
                for empleado in empleados:
                    tk.Label(ventana_empleados, text=f"  ID: {empleado['ID']}, Nombre: {empleado['Nombre']}").pack(anchor='w')
            else:
                tk.Label(ventana_empleados, text="  No hay empleados asignados a este cargo.").pack(anchor='w')

    tk.Label(ventana_empleados, text='--- Fin de la lista de empleados ---').pack(pady=10)
    tk.Button(ventana_empleados, text='Cerrar', command=ventana_empleados.destroy).pack(pady=5)