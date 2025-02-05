"use client"

import { useState } from "react"
import { Button } from "@/app/components/components/ui/button"
import { Card, CardContent, CardHeader, CardTitle } from "@/app/components/components/ui/card"
import { Input } from "@/app/components/components/ui/input"

export default function Empleados() {
  const [action, setAction] = useState("")
  const [nombre, setNombre] = useState("")
  const [resultado, setResultado] = useState("")

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault()
    // Aquí simularemos la lógica de Prolog
    switch (action) {
      case "agregar":
        setResultado(`Empleado ${nombre} agregado exitosamente.`)
        break
      case "borrar":
        setResultado(`Empleado ${nombre} borrado exitosamente.`)
        break
      case "consultar":
        setResultado(`Información del empleado ${nombre}: [Datos simulados]`)
        break
      default:
        setResultado("Acción no reconocida")
    }
  }

  return (
    <Card className="w-[350px]">
      <CardHeader>
        <CardTitle>Gestionar Empleados</CardTitle>
      </CardHeader>
      <CardContent>
        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <Button type="button" onClick={() => setAction("agregar")}>
              Agregar empleado
            </Button>
          </div>
          <div>
            <Button type="button" onClick={() => setAction("borrar")}>
              Borrar empleado
            </Button>
          </div>
          <div>
            <Button type="button" onClick={() => setAction("consultar")}>
              Consultar empleado
            </Button>
          </div>
          <Input
            type="text"
            placeholder="Nombre del empleado"
            value={nombre}
            onChange={(e) => setNombre(e.target.value)}
          />
          <Button type="submit">Ejecutar</Button>
        </form>
        {resultado && <p className="mt-4">{resultado}</p>}
      </CardContent>
    </Card>
  )
}

