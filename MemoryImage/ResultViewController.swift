//
//  ViewController.swift
//  MemoryImage
//
//  Created by Atik Mahbub Adil on 17/10/23.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!

    var score: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    func updateUI() {
        scoreLabel.text = "\(score)"
    }
}

