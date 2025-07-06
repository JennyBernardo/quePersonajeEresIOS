//
//  ResultadoViewController.swift
//  QuePersonajeEresApp
//
//  Created by Jenny Zizeth Bernardo de Jesus on 02/06/25.
//

import UIKit

class ResultadoViewController: UIViewController {
    
    @IBOutlet weak var etiquetaTituloResultado: UILabel!
    @IBOutlet weak var imagenPersonaje: UIImageView!
    @IBOutlet weak var etiquetaDescripcionPersonaje: UILabel!
    @IBOutlet weak var botonVolverAJugar: UIButton!
    
    var personaje: Personaje?
    
    var onDismiss: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mostrarResultado()
    }
    
    func mostrarResultado() {
        if let personaje = personaje {
            etiquetaTituloResultado.text = "¡Eres \(personaje.nombre)!"
            etiquetaDescripcionPersonaje.text = personaje.descripcion
            
            switch personaje.nombre {
            case "Batman":
                imagenPersonaje.image = UIImage(named: "batman")
            case "Superman":
                imagenPersonaje.image = UIImage(named: "superman")
            case "Hermione Granger":
                imagenPersonaje.image = UIImage(named: "hermione")
            case "Spider-Man":
                imagenPersonaje.image = UIImage(named: "spiderman")
            case "Gandalf":
                imagenPersonaje.image = UIImage(named: "gandalf")
            default:
                imagenPersonaje.image = UIImage(named: "default") // Una imagen por defecto si no hay coincidencia
                print("Advertencia: No se encontró imagen para el personaje: \(personaje.nombre)")
            }
        }
    }
    
    @IBAction func botonVolverAJugarPresionado(_ sender: UIButton) {
        print("Botón 'Volver a Jugar' presionado en ResultadoViewController.")
        // Llama a dismiss, y en su completion handler, invoca el closure onDismiss
        self.dismiss(animated: true) { [weak self] in
            self?.onDismiss?() // notifica a ViewControllerCuestionario
            print("ResultadoViewController dismissed y onDismiss closure ejecutado.")
        }
    }
}
