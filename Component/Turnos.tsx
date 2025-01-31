"use client"

import { useState } from "react"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Input } from "@/components/ui/input"

export default function Turnos() {
  const [action, setAction] = useState("")
  const [turno, setTurno] = useState("")
  const [empleado, setEmpleado] = useState("")
  const [fecha, setFecha] = useState("")
  const [resultado, setResultado] = useState("")

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault()
    // Aquí simularemos la lógica de Prolog
    switch (action) {
      case "agregar":
        setResultado(`Turno ${turno} agregado exitosamente.`)
        break
      case "borrar":
        setResultado(`Turno ${turno} borrado exitosamente.`)
        break
      case "consultar":
        setResultado(`Turnos para el cargo: [Lista de turnos simulada]`)
        break
      case "asignar":
        setResultado(`Turno asignado a ${empleado} para la fecha ${fecha}.`)
        break
      case "planificar":
        setResultado(`Turnos planificados para la fecha ${fecha}.`)
        break
      case "listar":
        setResultado(`Asignaciones de turnos para la fecha ${fecha}: [Lista simulada]`)
        break
      default:
        setResultado("Acción no reconocida")
    }
  }

  return (
    <Card className="w-[350px]">
      <CardHeader>
        <CardTitle>Gestionar Turnos</CardTitle>
      </CardHeader>
      <CardContent>
        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <Button type="button" onClick={() => setAction("agregar")}>
              Agregar turno
            </Button>
          </div>
          <div>
            <Button type="button" onClick={() => setAction("borrar")}>
              Borrar turno
            </Button>
          </div>
          <div>
            <Button type="button" onClick={() => setAction("consultar")}>
              Consultar turnos por cargo
            </Button>
          </div>
          <div>
            <Button type="button" onClick={() => setAction("asignar")}>
              Asignar turno a empleado
            </Button>
          </div>
          <div>
            <Button type="button" onClick={() => setAction("planificar")}>
              Planificar turnos para fecha
            </Button>
          </div>
          <div>
            <Button type="button" onClick={() => setAction("listar")}>
              Listar asignaciones de turnos
            </Button>
          </div>
          <Input type="text" placeholder="ID del turno" value={turno} onChange={(e) => setTurno(e.target.value)} />
          <Input
            type="text"
            placeholder="Nombre del empleado"
            value={empleado}
            onChange={(e) => setEmpleado(e.target.value)}
          />
          <Input
            type="date"
            placeholder="Fecha (YYYY-MM-DD)"
            value={fecha}
            onChange={(e) => setFecha(e.target.value)}
          />
          <Button type="submit">Ejecutar</Button>
        </form>
        {resultado && <p className="mt-4">{resultado}</p>}
      </CardContent>
    </Card>
  )
}

