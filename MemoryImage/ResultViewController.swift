//
//  ViewController.swift
//  MemoryImage
//
//  Created by Atik Mahbub Adil on 17/10/23.
//

import UIKit
import Supabase

class ResultViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var uploadButton: UIButton!

    let supabase = SupabaseClient(supabaseURL: URL(string: "https://ncbqxdgcvkdgrdbfdmxw.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5jYnF4ZGdjdmtkZ3JkYmZkbXh3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTYzMTc1NDEsImV4cCI6MjAxMTg5MzU0MX0.zWGkhRrXm7XKRnJeo6eU-uLm4DCNy4VeTe38W6MYx30")
    var score: Double = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    func updateUI() {
        scoreLabel.text = "\(score)"
        nameTextField.delegate = self
        nameTextField.text = "" // Limpiar el campo de nombre
    }
    
    @IBAction func uploadScoreButtonTapped(_ sender: UIButton) {
        Task { @MainActor in
            guard let playerName = nameTextField.text, !playerName.isEmpty else {
                // Mostrar una alerta indicando que el nombre es obligatorio
                showAlert(message: "Ingrese un nombre válido.")
                return
            }
            
            // Subir la puntuación a Supabase junto con el nombre del jugador
            await uploadScore(playerName: playerName, score: score)
        }
    }

    func uploadScore(playerName: String, score: Double) async {
        struct Data: Encodable {
            let id: Int?
            let user_name: String
            let user_point: Double
        }

        let data = Data(id: nil, user_name: playerName, user_point: score)
        do {
            try await supabase.database
                .from("users")
                .insert(data)
                .execute()
            // Muestra una alerta indicando que la puntuación se ha subido con éxito
            showAlert(message: "Puntuación subida con éxito. ¡Gracias por jugar!")
        } catch {
            print("Error al subir la puntuación:", error.localizedDescription)
        }
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alerta", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
