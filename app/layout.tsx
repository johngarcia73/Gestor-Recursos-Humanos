import "./globals.css"
import type { Metadata } from "next"
import { Inter } from "next/font/google"
import type React from "react" // Added import for React

const inter = Inter({ subsets: ["latin"] })

export const metadata: Metadata = {
  title: "Gestor de Recursos Humanos",
  description: "Aplicación web para gestionar recursos humanos",
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="es">
      <body className={inter.className}>{children}</body>
    </html>
  )
}

