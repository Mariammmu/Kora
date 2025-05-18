//
//  MyPageViewController.swift
//  Sports
//
//  Created by Macos on 11/05/2025.
//

import UIKit

class MyPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    
  
    var pages = [UIViewController]() //array of pagesViewControllers
    //let pageControl = UIPageControl()//external that's not part of underlying pages
    //let initialPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let initialPage = self.storyboard?.instantiateViewController(withIdentifier: "v1")
        let secondPage = self.storyboard?.instantiateViewController(withIdentifier: "v2")
        let thirdPage = self.storyboard?.instantiateViewController(withIdentifier: "v3")
        
        if let initialPage = initialPage, let secondPage = secondPage, let thirdPage = thirdPage {
            pages.append(initialPage)
            pages.append(secondPage)
            pages.append(thirdPage)
        }

        
        self.delegate = self
        self.dataSource = self

        
        
//        if let initialPage = pages.first{ setViewControllers([initialPage], direction: .forward, animated: true, completion: nil)
//        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let initialPage = pages.first {
            setViewControllers([initialPage], direction: .forward, animated: true, completion: nil)
        }
    }

    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    
        guard let currentIndex = pages.firstIndex(of: viewController) else{
            return nil
        }
        let previousIndex = currentIndex-1
        
        guard previousIndex >= 0 else { //circular queue
            return pages.last
        }
        return pages[previousIndex]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        
            guard let currentIndex = pages.firstIndex(of: viewController) else{
                return nil
            }
            let afterIndex = currentIndex+1
            
        guard afterIndex < pages.count else { //circular queue
                return nil
            }
            return pages[afterIndex]
    }

//    override func viewDidAppear(_ animated: Bool) {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//               if let tabBarController = self.tabBarController {
//                   tabBarController.selectedIndex = 0 // Index of the TableViewController tab
//               }
//           }
//       }
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
