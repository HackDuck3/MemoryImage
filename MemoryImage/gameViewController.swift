//
//  gameViewController.swift
//  MemoryImage
//
//  Created by Atik Mahbub Adil on 18/10/23.
//

import UIKit
//var imageNames: [String] = ["image1", "image2", "image3", "image4", "image5"] // Nombres de las imágenes
var imageNames: [Int] = [1, 2, 3, 4, 5] // Nombres de las imágenes
var imageRandom: [Int] = []
var images: [UIImage] = [
    UIImage(named: "image1")!,
    UIImage(named: "image2")!,
    UIImage(named: "image3")!,
    UIImage(named: "image4")!,
    UIImage(named: "image5")!,
]

class gameViewController: UIViewController {
    
    // Array que contendrá el orden aleatorio de las imágenes
    var randomImageOrder: [UIImage] = []
    var nameImagesRandom = 0
    var currentImageIndex = 0
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Mezcla aleatoriamente las imágenes cuando se carga el controlador
        randomImageOrder = images.shuffled()
        
        // Imprime los nombres de las imágenes en el orden aleatorio
        print("Nombres de las imágenes en el orden aleatorio:")
        imageRandom.removeAll()
        for image in randomImageOrder {
            if let index = images.firstIndex(of: image), index < imageNames.count {
                print(imageNames[index])
                nameImagesRandom = imageNames[index]
                imageRandom.append(imageNames[index])
            }
        }
        
        
        // Inicia el temporizador para cambiar imágenes cada 1.5 segundos
        timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(changeImage), userInfo: nil, repeats: true)
        
        // Detiene el temporizador después de mostrar todas las imágenes
        Timer.scheduledTimer(withTimeInterval: Double(images.count) * 1.5, repeats: false) { _ in
            self.timer?.invalidate() // Detiene el temporizador
            
        }
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
                destinationVC.randomImageOrder = randomImageOrder
                //destinationVC.nameImagesRandom = nameImagesRandom
            }
        }
    }
}
