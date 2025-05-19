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
        
        if let tabBarController = storyboard?.instantiateViewController(withIdentifier: "navigation") as? UINavigationController {
            
              // tabBarController.selectedIndex = 0

               tabBarController.modalPresentationStyle = .fullScreen
               present(tabBarController, animated: true, completion: nil)
           }
    }
}

