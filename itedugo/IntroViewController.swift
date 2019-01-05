//
//  IntroViewController.swift
//  itedugo
//
//  Created by 박병탁 on 31/12/2018.
//  Copyright © 2018 박병탁. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

    @IBOutlet weak var startBtn: UIButton! {
        didSet {
            startBtn.layer.cornerRadius = startBtn.frame.height / 2
            startBtn.addTarget(self, action: #selector(startBtnClick), for: .touchUpInside)
        }
    }
    
    @objc func startBtnClick() {
        UserDefaults.standard.set(true, forKey: "showIntro")
        self.performSegue(withIdentifier: "homeSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    



}
