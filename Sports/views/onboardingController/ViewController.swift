//
//  ViewController.swift
//  Sports
//
//  Created by Macos on 10/05/2025.
//

import UIKit

class ViewController: UIViewController  {
   
    

   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
   

    @IBAction func goToSportScreen(_ sender: Any) {
        
        print("btn clicked")
        
        if let navigationController = storyboard?.instantiateViewController(withIdentifier: "MainNavController") as? UINavigationController {
                navigationController.modalPresentationStyle = .fullScreen
                present(navigationController, animated: true, completion: nil)
            }
    }
}

