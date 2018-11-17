//
//  CustomViewController.swift
//  diary
//
//  Created by Арман on 11/17/18.
//  Copyright © 2018 Арман. All rights reserved.
//

import UIKit

class UICustomViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = #colorLiteral(red: 0.1602233052, green: 0.1644028425, blue: 0.1861923337, alpha: 1)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
