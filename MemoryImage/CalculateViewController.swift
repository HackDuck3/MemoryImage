//
//  ViewController.swift
//  MemoryImage
//
//  Created by Atik Mahbub Adil on 17/10/23.
//

import UIKit

class CalculateViewController: UIViewController {

    var images: [UIImage] = [] // Esta es la propiedad para almacenar las imágenes aleatorias

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnNextScreen(_ sender: Any) {
        let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "gameViewController") as! gameViewController
        storyboard.images = images // Asigna las imágenes aleatorias al GameViewController
        self.navigationController?.pushViewController(storyboard, animated: true)
    }
    
    
    
}
