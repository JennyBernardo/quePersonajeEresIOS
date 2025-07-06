//
//  ViewControllerCuestionario.swift
//  QuePersonajeEresApp
//
//  Created by Jenny Zizeth Bernardo de Jesus on 02/06/25.
//

import UIKit

class ViewControllerCuestionario: UIViewController {
    
    @IBOutlet weak var etiquetaNumeroPregunta: UILabel!
    @IBOutlet weak var etiquetaTextoPregunta: UILabel!
    @IBOutlet var botonesOpcion: [UIButton]! // Conectado todos los botones de opción
    @IBOutlet weak var botonSiguiente: UIButton!
    
    var gestorCuestionario = GestorCuestionario()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurarUI()
        cargarPregunta()
    }
    
    func configurarUI() {
        // Configuración inicial
        for boton in botonesOpcion {
            boton.layer.cornerRadius = 8
            boton.layer.borderWidth = 1
            boton.layer.borderColor = UIColor.lightGray.cgColor
            boton.backgroundColor = .systemBackground
            boton.setTitleColor(.label, for: .normal)
        }
        botonSiguiente.isEnabled = false // Deshabilitar el botón "Siguiente" al inicio
    }
    
    func cargarPregunta() {
        if let preguntaActual = gestorCuestionario.obtenerPreguntaActual() {
            etiquetaNumeroPregunta.text = "Pregunta \(gestorCuestionario.obtenerNumeroPregunta()) de \(gestorCuestionario.obtenerTotalPreguntas())"
            etiquetaTextoPregunta.text = preguntaActual.texto
            
            // Configurar los títulos de los botones de opción
            for (indice, opcion) in preguntaActual.opciones.enumerated() {
                if indice < botonesOpcion.count {
                    botonesOpcion[indice].setTitle(opcion, for: .normal)
                    botonesOpcion[indice].backgroundColor = .systemBackground // Resetear color
                    botonesOpcion[indice].setTitleColor(.label, for: .normal)
                }
            }
            botonSiguiente.isEnabled = false // Asegurarse de que el botón Siguiente esté deshabilitado para la nueva pregunta
        } else {
            // No hay más preguntas, ir a la pantalla de resultados
            mostrarResultado()
        }
    }
    
    @IBAction func botonOpcionPresionado(_ sender: UIButton) {
        // Deseleccionar todas las opciones visualmente
        for boton in botonesOpcion {
            boton.backgroundColor = .systemBackground
            boton.setTitleColor(.label, for: .normal)
        }
        
        // Seleccionar la opción tapada
        sender.backgroundColor = .systemBlue // Color para la opción seleccionada
        sender.setTitleColor(.white, for: .normal)
        
        if let indiceSeleccionado = botonesOpcion.firstIndex(of: sender) {
            gestorCuestionario.seleccionarRespuesta(indiceOpcion: indiceSeleccionado)
            botonSiguiente.isEnabled = true // Habilitar el botón "Siguiente"
        }
    }
    
    @IBAction func botonSiguientePresionado(_ sender: UIButton) {
        if gestorCuestionario.avanzarSiguientePregunta() {
            cargarPregunta()
        } else {
            mostrarResultado()
        }
    }
    
    func mostrarResultado() {
        if let personajeResultado = gestorCuestionario.obtenerPersonajeResultado() {
            // Navegar a la pantalla de resultados
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let resultadoVC = storyboard.instantiateViewController(withIdentifier: "ResultadoViewController") as? ResultadoViewController {
                resultadoVC.personaje = personajeResultado
                
                resultadoVC.onDismiss = { [weak self] in
                    // Este código se ejecutará cuando ResultadoViewController se cierre
                    print("onDismiss en ViewControllerCuestionario ejecutado. Llamando a reiniciarCuestionario().")
                    self?.reiniciarCuestionario()
                }
                
                self.present(resultadoVC, animated: true, completion: nil) // O navigationController?.pushViewController
            }
        }
    }
    
    func reiniciarCuestionario() {
        print("Inicio de reiniciarCuestionario().")
        gestorCuestionario.reiniciarCuestionario() // Resetea puntaje, respuestas
        configurarUI()
        cargarPregunta()
        print("Cuestionario ha sido reiniciado con éxito y UI actualizada para la pregunta 1.")
    }
    
}
