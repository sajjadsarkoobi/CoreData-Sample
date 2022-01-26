//
//  FirstViewController.swift
//  CoreData-Sample
//
//  Created by Sajjad Sarkoobi on 1/26/22.
//

import UIKit

class FirstViewController: UIViewController {

    //IBOutlets:
    @IBOutlet weak var plusButton: UIButton!
    @IBAction func plusButtonAction(_ sender: UIButton) {
        print("Plus")
    }
    @IBOutlet weak var minusButton: UIButton!
    @IBAction func minusButtonAction(_ sender: UIButton) {
        print("Minus")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
