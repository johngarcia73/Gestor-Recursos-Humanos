"use client"

import { useState } from "react"
import { Button } from "@/app/components/components/ui/button"
import { Card, CardContent, CardHeader, CardTitle } from "@/app/components/components/ui/card"
import Empleados from "./components/Empleados"
import Cargos from "./components/Cargos"
import Tareas from "./components/Tareas"
import Turnos from "./components/Turnos"
import Puntuaciones from "./components/Puntuaciones"

export default function GestorRRHH() {
  const [currentSection, setCurrentSection] = useState("main")

  const renderSection = () => {
    switch (currentSection) {
      case "empleados":
        return <Empleados />
      case "cargos":
        return <Cargos />
      case "tareas":
        return <Tareas />
      case "turnos":
        return <Turnos />
      case "puntuaciones":
        return <Puntuaciones />
      default:
        return (
          <Card className="w-[350px]">
            <CardHeader>
              <CardTitle>Gestor de Recursos Humanos</CardTitle>
            </CardHeader>
            <CardContent className="grid gap-4">
              <Button onClick={() => setCurrentSection("empleados")}>Gestionar empleados</Button>
              <Button onClick={() => setCurrentSection("cargos")}>Gestionar cargos</Button>
              <Button onClick={() => setCurrentSection("tareas")}>Gestionar tareas</Button>
              <Button onClick={() => setCurrentSection("turnos")}>Gestionar turnos</Button>
              <Button onClick={() => setCurrentSection("puntuaciones")}>Gestionar puntuaciones</Button>
            </CardContent>
          </Card>
        )
    }
  }

  return <div className="min-h-screen bg-gray-100 flex items-center justify-center">{renderSection()}</div>
}

