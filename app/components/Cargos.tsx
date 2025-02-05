"use client"

import { useState } from "react"
import { Button } from "@/app/components/components/ui/button"
import { Card, CardContent, CardHeader, CardTitle } from "@/app/components/components/ui/card"
import { Input } from "@/app/components/components/ui/input"

export default function Cargos() {
  const [action, setAction] = useState("")
  const [cargo, setCargo] = useState("")
  const [resultado, setResultado] = useState("")

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault()
    // Aquí simularemos la lógica de Prolog
    switch (action) {
      case "agregar":
        setResultado(`Cargo ${cargo} agregado exitosamente.`)
        break
      case "borrar":
        setResultado(`Cargo ${cargo} borrado exitosamente.`)
        break
      case "consultar":
        setResultado(`Información del cargo ${cargo}: [Datos simulados]`)
        break
      default:
        setResultado("Acción no reconocida")
    }
  }

  return (
    <Card className="w-[350px]">
      <CardHeader>
        <CardTitle>Gestionar Cargos</CardTitle>
      </CardHeader>
      <CardContent>
        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <Button type="button" onClick={() => setAction("agregar")}>
              Agregar cargo
            </Button>
          </div>
          <div>
            <Button type="button" onClick={() => setAction("borrar")}>
              Borrar cargo
            </Button>
          </div>
          <div>
            <Button type="button" onClick={() => setAction("consultar")}>
              Consultar cargo
            </Button>
          </div>
          <Input type="text" placeholder="Nombre del cargo" value={cargo} onChange={(e) => setCargo(e.target.value)} />
          <Button type="submit">Ejecutar</Button>
        </form>
        {resultado && <p className="mt-4">{resultado}</p>}
      </CardContent>
    </Card>
  )
}

