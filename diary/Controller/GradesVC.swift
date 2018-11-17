//
//  GradesVC.swift
//  diary
//
//  Created by Арман on 11/17/18.
//  Copyright © 2018 Арман. All rights reserved.
//

import UIKit


class GradesVC: UICustomViewController {
    
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hello Grades"
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
