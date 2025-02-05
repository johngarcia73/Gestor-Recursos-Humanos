"use client"

import { useState } from "react"
import { Button } from "@/app/components/components/ui/button"
import { Card, CardContent, CardHeader, CardTitle } from "@/app/components/components/ui/card"
import { Input } from "@/app/components/components/ui/input"

export default function Tareas() {
  const [action, setAction] = useState("")
  const [empleado, setEmpleado] = useState("")
  const [tarea, setTarea] = useState("")
  const [resultado, setResultado] = useState("")

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault()
    // Aquí simularemos la lógica de Prolog
    switch (action) {
      case "agregar":
        setResultado(`Tarea "${tarea}" agregada a ${empleado} exitosamente.`)
        break
      case "borrar":
        setResultado(`Tarea "${tarea}" borrada de ${empleado} exitosamente.`)
        break
      case "consultar":
        setResultado(`Información de la tarea "${tarea}" de ${empleado}: [Datos simulados]`)
        break
      case "completar":
        setResultado(`Tarea "${tarea}" de ${empleado} marcada como completada.`)
        break
      case "obtener":
        setResultado(`Tareas de ${empleado}: [Lista de tareas simulada]`)
        break
      case "recomendar":
        setResultado(`Tareas recomendadas para ${empleado}: [Lista de tareas simulada]`)
        break
      default:
        setResultado("Acción no reconocida")
    }
  }

  return (
    <Card className="w-[350px]">
      <CardHeader>
        <CardTitle>Gestionar Tareas</CardTitle>
      </CardHeader>
      <CardContent>
        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <Button type="button" onClick={() => setAction("agregar")}>
              Agregar tarea
            </Button>
          </div>
          <div>
            <Button type="button" onClick={() => setAction("borrar")}>
              Borrar tarea
            </Button>
          </div>
          <div>
            <Button type="button" onClick={() => setAction("consultar")}>
              Consultar tarea
            </Button>
          </div>
          <div>
            <Button type="button" onClick={() => setAction("completar")}>
              Completar tarea
            </Button>
          </div>
          <div>
            <Button type="button" onClick={() => setAction("obtener")}>
              Obtener tareas
            </Button>
          </div>
          <div>
            <Button type="button" onClick={() => setAction("recomendar")}>
              Recomendar tareas
            </Button>
          </div>
          <Input
            type="text"
            placeholder="Nombre del empleado"
            value={empleado}
            onChange={(e) => setEmpleado(e.target.value)}
          />
          <Input
            type="text"
            placeholder="Nombre de la tarea"
            value={tarea}
            onChange={(e) => setTarea(e.target.value)}
          />
          <Button type="submit">Ejecutar</Button>
        </form>
        {resultado && <p className="mt-4">{resultado}</p>}
      </CardContent>
    </Card>
  )
}

