//
//  SettingsVC.swift
//  diary
//
//  Created by Арман on 11/18/18.
//  Copyright © 2018 Арман. All rights reserved.
//

import UIKit

class SettingsVC: UICustomViewController {
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Hello Settings"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        view.addSubview(label)
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
}
