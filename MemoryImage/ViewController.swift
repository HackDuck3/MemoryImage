//
//  ViewController.swift
//  MemoryImage
//
//  Created by Atik Mahbub Adil on 17/10/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnTapped(_ sender: Any) {
        let striryboard = self.storyboard?.instantiateViewController(withIdentifier: "gameViewController") as! gameViewController
        self.navigationController?.pushViewController(striryboard, animated: true)
    }
    
}

