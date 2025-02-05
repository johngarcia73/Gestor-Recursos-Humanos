"use client"

import { useState } from "react"
import { Button } from "@/app/components/components/ui/button"
import { Card, CardContent, CardHeader, CardTitle } from "@/app/components/components/ui/card"
import { Input } from "@/app/components/components/ui/input"

export default function Puntuaciones() {
  const [action, setAction] = useState("")
  const [empleado, setEmpleado] = useState("")
  const [puntuacion, setPuntuacion] = useState("")
  const [resultado, setResultado] = useState("")

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault()
    // Aquí simularemos la lógica de Prolog
    switch (action) {
      case "incrementar":
        setResultado(`Puntuación de ${empleado} incrementada en ${puntuacion} puntos.`)
        break
      case "consultar":
        setResultado(`Puntuación actual de ${empleado}: [Puntuación simulada]`)
        break
      case "evaluar":
        setResultado(`Evaluación de rendimiento de ${empleado}: [Resultado simulado]`)
        break
      case "desempeno":
        setResultado(`Desempeño de ${empleado} en el mes actual: [Resultado simulado]`)
        break
      case "ranking":
        setResultado(`Ranking de mejores empleados: [Lista simulada]`)
        break
      default:
        setResultado("Acción no reconocida")
    }
  }

  return (
    <Card className="w-[350px]">
      <CardHeader>
        <CardTitle>Gestionar Puntuaciones</CardTitle>
      </CardHeader>
      <CardContent>
        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <Button type="button" onClick={() => setAction("incrementar")}>
              Incrementar puntuación
            </Button>
          </div>
          <div>
            <Button type="button" onClick={() => setAction("consultar")}>
              Consultar puntuación
            </Button>
          </div>
          <div>
            <Button type="button" onClick={() => setAction("evaluar")}>
              Evaluar rendimiento
            </Button>
          </div>
          <div>
            <Button type="button" onClick={() => setAction("desempeno")}>
              Evaluar desempeño mensual
            </Button>
          </div>
          <div>
            <Button type="button" onClick={() => setAction("ranking")}>
              Generar ranking
            </Button>
          </div>
          <Input
            type="text"
            placeholder="Nombre del empleado"
            value={empleado}
            onChange={(e) => setEmpleado(e.target.value)}
          />
          <Input
            type="number"
            placeholder="Puntuación"
            value={puntuacion}
            onChange={(e) => setPuntuacion(e.target.value)}
          />
          <Button type="submit">Ejecutar</Button>
        </form>
        {resultado && <p className="mt-4">{resultado}</p>}
      </CardContent>
    </Card>
  )
}

