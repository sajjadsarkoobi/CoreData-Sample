//
//  FirstViewController.swift
//  CoreData-Sample
//
//  Created by Sajjad Sarkoobi on 1/26/22.
//

import UIKit

class FirstViewController: UIViewController {

    //IBOutlets:
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBAction func plusButtonAction(_ sender: UIButton) {
        viewModel.savePlyaer()
    }
    @IBOutlet weak var minusButton: UIButton!
    @IBAction func minusButtonAction(_ sender: UIButton) {
        viewModel.deletePlayer()
    }
    
    //Viewmodel
    var viewModel: FirstViewModel = FirstViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        viewModel.updateCounter()
    }

    func bindViewModel(){
        viewModel.counter.bind { [weak self] count in
            guard let count = count, let self = self else {
                return
            }
            DispatchQueue.main.async {
                self.counterLabel.text = "\(count)"
            }
        }
    }
}
