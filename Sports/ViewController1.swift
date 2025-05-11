//
//  ViewController1.swift
//  Sports
//
//  Created by Macos on 11/05/2025.
//

import UIKit
import Lottie

class ViewController1: UIViewController {

    var animationView: LottieAnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationView = LottieAnimationView(name: "balls")
        animationView?.frame = self.view.bounds
        animationView?.contentMode = .scaleAspectFit
        animationView?.loopMode = .loop
        animationView?.play()

        
        if let animationView = animationView {
            self.view.addSubview(animationView)
        }
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        // Stop the animation when view disappears
//        animationView?.stop()
//    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        animationView?.frame = self.view.bounds
    }
}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


