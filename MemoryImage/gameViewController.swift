//
//  gameViewController.swift
//  MemoryImage
//
//  Created by Atik Mahbub Adil on 18/10/23.
//

import UIKit

class gameViewController: UIViewController {

    var images: [UIImage] = [
        UIImage(named: "image1")!,
        UIImage(named: "image2")!,
        UIImage(named: "image3")!,
        UIImage(named: "image4")!,
        UIImage(named: "image5")!,
    ]
    
    // Array que contendrá el orden aleatorio de las imágenes
    var randomImageOrder: [UIImage] = []

    var currentImageIndex = 0
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Mezcla aleatoriamente las imágenes cuando se carga el controlador
        randomImageOrder = images.shuffled()
        
        // Inicia el temporizador para cambiar imágenes cada 1.5 segundos
        timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(changeImage), userInfo: nil, repeats: true)
        
        // Detiene el temporizador después de mostrar todas las imágenes
        Timer.scheduledTimer(withTimeInterval: Double(images.count) * 1.5, repeats: false) { _ in
            self.timer?.invalidate() // Detiene el temporizador
            
            // Cuando todas las imágenes se han mostrado, pasa el orden aleatorio a la siguiente pantalla
            //self.performSegue(withIdentifier: "changeScreen", sender: self)
        }
    }

    @IBAction func btnNextScreen(_ sender: Any) {
        // Pasa el orden aleatorio de las imágenes a la siguiente pantalla
        self.performSegue(withIdentifier: "changeScreen", sender: self)
    }
    
    
    
    @IBOutlet weak var imgController: UIImageView!
    
    @objc func changeImage() {
        imgController.image = randomImageOrder[currentImageIndex]
        currentImageIndex += 1
        if currentImageIndex == 5 {
            timer?.invalidate()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeScreen" {
            if let destinationVC = segue.destination as? CalculateViewController {
                // Pasa el orden aleatorio de las imágenes a la siguiente pantalla
                destinationVC.images = randomImageOrder
            }
        }
    }
}
