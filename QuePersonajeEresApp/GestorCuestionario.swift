//
//  GestorCuestionario.swift
//  QuePersonajeEresApp
//
//  Created by Jenny Zizeth Bernardo de Jesus on 02/06/25.
//

import Foundation

class GestorCuestionario {
    private var preguntas: [Pregunta]
    private var personajes: [Personaje]
    private var indicePreguntaActual: Int = 0
    private var puntajeUsuario: Int = 0
    private var respuestasSeleccionadas: [Int?] = [] // Almacena el índice de la opción seleccionada por el usuario para cada pregunta

    init() {
        // Inicializar preguntas y personajes
        // Puedes cargar esto desde un archivo JSON, una base de datos, o directamente aquí.
        self.preguntas = [
            Pregunta(texto: "¿Cuál es tu pasatiempo favorito?", opciones: ["Leer libros de fantasía", "Practicar deportes extremos", "Resolver enigmas y misterios", "Ayudar a los demás en lo que sea", "Experimentar con nuevas tecnologías"], valoresOpciones: [5, 10, 8, 3, 7]),
            Pregunta(texto: "¿Qué cualidad valoras más en una persona?", opciones: ["Inteligencia", "Coraje", "Empatía", "Humor", "Lealtad"], valoresOpciones: [8, 10, 5, 7, 9]),
            Pregunta(texto: "¿Qué tipo de superpoder te gustaría tener?", opciones: ["Volar", "Super fuerza", "Control mental", "Invisibilidad", "Teletransportación"], valoresOpciones: [7, 9, 10, 6, 8]),
            Pregunta(texto: "¿Cómo reaccionas ante un desafío?", opciones: ["Lo enfrento con determinación", "Busco soluciones creativas", "Pido ayuda a mis amigos", "Me adapto a la situación", "Analizo todas las opciones antes de actuar"], valoresOpciones: [9, 8, 5, 7, 10]),
            Pregunta(texto: "¿Qué tipo de películas prefieres?", opciones: ["Acción y aventura", "Ciencia ficción", "Comedia", "Drama", "Documentales"], valoresOpciones: [9, 8, 6, 5, 7])
        ]

        self.personajes = [
            Personaje(nombre: "Batman", descripcion: "Eres un detective brillante, con gran ingenio y un fuerte sentido de la justicia. Te gusta resolver problemas y proteger a los demás.", puntajeMinimo: 40, puntajeMaximo: 50),
            Personaje(nombre: "Superman", descripcion: "Eres un símbolo de esperanza y coraje, siempre dispuesto a ayudar a los indefensos y luchar por lo que es correcto.", puntajeMinimo: 30, puntajeMaximo: 39),
            Personaje(nombre: "Hermione Granger", descripcion: "Eres increíblemente inteligente, lógica y siempre buscas el conocimiento para superar los obstáculos.", puntajeMinimo: 20, puntajeMaximo: 29),
            Personaje(nombre: "Spider-Man", descripcion: "Tienes un gran sentido del humor y la responsabilidad. Aunque a veces te sientes abrumado, siempre haces lo correcto.", puntajeMinimo: 10, puntajeMaximo: 19),
            Personaje(nombre: "Gandalf", descripcion: "Eres sabio y misterioso, con un profundo conocimiento del mundo y la capacidad de guiar a otros en tiempos difíciles.", puntajeMinimo: 0, puntajeMaximo: 9) // Ajusta estos rangos según la lógica de puntuación
        ]

        // Inicializa el array de respuestas seleccionadas con nil para cada pregunta
        self.respuestasSeleccionadas = Array(repeating: nil, count: preguntas.count)
    }

    func obtenerPreguntaActual() -> Pregunta? {
        guard indicePreguntaActual < preguntas.count else {
            return nil // Ya no hay más preguntas
        }
        return preguntas[indicePreguntaActual]
    }

    func seleccionarRespuesta(indiceOpcion: Int) {
        guard indicePreguntaActual < preguntas.count else { return }
        respuestasSeleccionadas[indicePreguntaActual] = indiceOpcion
    }

    func avanzarSiguientePregunta() -> Bool {
        // Asegurarse de que se haya seleccionado una respuesta antes de avanzar
        guard respuestasSeleccionadas[indicePreguntaActual] != nil else { return false }

        // Sumar los puntos de la respuesta seleccionada
        if let indiceOpcionSeleccionada = respuestasSeleccionadas[indicePreguntaActual] {
            puntajeUsuario += preguntas[indicePreguntaActual].valoresOpciones[indiceOpcionSeleccionada]
        }

        indicePreguntaActual += 1
        return indicePreguntaActual < preguntas.count
    }

    func esUltimaPregunta() -> Bool {
        return indicePreguntaActual == preguntas.count - 1
    }

    func obtenerPersonajeResultado() -> Personaje? {
        for personaje in personajes {
            if puntajeUsuario >= personaje.puntajeMinimo && puntajeUsuario <= personaje.puntajeMaximo {
                return personaje
            }
        }
        return nil // En caso de que el puntaje no encaje en ningún rango (debería ser manejado)
    }

    func reiniciarCuestionario() {
        indicePreguntaActual = 0
        puntajeUsuario = 0
        respuestasSeleccionadas = Array(repeating: nil, count: preguntas.count)
    }

    // Funciones auxiliares para la UI
    func obtenerNumeroPregunta() -> Int {
        return indicePreguntaActual + 1
    }

    func obtenerTotalPreguntas() -> Int {
        return preguntas.count
    }

    func estaRespuestaSeleccionadaParaPreguntaActual() -> Bool {
        return respuestasSeleccionadas[indicePreguntaActual] != nil
    }
}
