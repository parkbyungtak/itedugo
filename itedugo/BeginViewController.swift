//
//  BeginViewController.swift
//  itedugo
//
//  Created by 박병탁 on 31/12/2018.
//  Copyright © 2018 박병탁. All rights reserved.
//

import UIKit

class BeginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let time = DispatchTime.now() + .seconds(3)
        DispatchQueue.main.asyncAfter(deadline: time) {
            
            if UserDefaults.standard.bool(forKey: "showIntro") == false || UserDefaults.standard.object(forKey: "showIntro") == nil {
                
                self.performSegue(withIdentifier: "introSegue", sender: nil)
                
            } else {
                
                self.performSegue(withIdentifier: "mainSegue", sender: nil)
                
            }
            
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

}
