//
//  ViewController.swift
//  MemoryImage
//
//  Created by Atik Mahbub Adil on 17/10/23.
//

import UIKit

class CalculateViewController: UIViewController {
    
    @IBOutlet var imageViews: [UIImageView]!
    var randomImageOrder: [UIImage] = [] 
    var nameImagesRandom = ""
    @IBOutlet var numberTextField1: UITextField!
    @IBOutlet var numberTextField2: UITextField!
    @IBOutlet var numberTextField3: UITextField!
    @IBOutlet var numberTextField4: UITextField!
    @IBOutlet var numberTextField5: UITextField!
    @IBOutlet weak var calculateButton: UIButton!
    
    var userGuesses: [Int] = [] // Respuestas ingresadas por el usuario
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Mostrar las imágenes en UIImageView según el orden específico
        for (index, image) in images.enumerated() {
            imageViews[index].image = image
        }
        
        // Configurar los textfields para aceptar solo números
        numberTextField1.delegate = self
        numberTextField1.keyboardType = .numberPad
        
        numberTextField2.delegate = self
        numberTextField2.keyboardType = .numberPad
        
        numberTextField3.delegate = self
        numberTextField3.keyboardType = .numberPad
        
        numberTextField4.delegate = self
        numberTextField4.keyboardType = .numberPad
        
        numberTextField5.delegate = self
        numberTextField5.keyboardType = .numberPad
        
        // Configurar la acción del botón de cálculo
        calculateButton.addTarget(self, action: #selector(calculateScore), for: .touchUpInside)
    }
    
    @objc func calculateScore() {
        // Obtener los valores ingresados por el usuario
        userGuesses = [
            Int(numberTextField1.text ?? "") ?? 0,
            Int(numberTextField2.text ?? "") ?? 0,
            Int(numberTextField3.text ?? "") ?? 0,
            Int(numberTextField4.text ?? "") ?? 0,
            Int(numberTextField5.text ?? "") ?? 0
        ]
        
        // Comparar los valores ingresados con el orden aleatorio y calcular la puntuación
        var correctGuesses = 0
        for (index, imageNumber) in imageRandom.enumerated() {
            let guess = userGuesses[imageNumber - 1]
            if index == guess - 1 {
                correctGuesses += 1
            }
        }
        
        // Calcular la puntuación final
        let score = Double(correctGuesses) / Double(randomImageOrder.count) * 100.0
        print(score)
        
        // Guardar la puntuación en UserDefaults (historial de puntuaciones)
        saveScore(score)

        // Realizar la transición a ResultViewController
        performSegue(withIdentifier: "showResult", sender: score)
    }
    
    func saveScore(_ score: Double) {
        var scores = UserDefaults.standard.array(forKey: "scores") as? [Double] ?? []
        scores.append(score)

        // Guardar solo las últimas 5 puntuaciones
        if scores.count > 5 {
            scores.removeFirst(scores.count - 5)
        }

        UserDefaults.standard.set(scores, forKey: "scores")
        UserDefaults.standard.synchronize()
    }
}

    extension CalculateViewController: UITextFieldDelegate {
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResult" {
            if let destinationVC = segue.destination as? ResultViewController,
               let score = sender as? Double {
                destinationVC.score = score
            }
        }
    }
}
