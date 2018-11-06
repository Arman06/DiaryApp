//
//  DiaryVC.swift
//  diary
//
//  Created by Арман on 11/6/18.
//  Copyright © 2018 Арман. All rights reserved.
//

import UIKit

class DiaryVC: UIViewController {
    
    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Back", for: .normal)
        button.backgroundColor = UIColor.red
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1602233052, green: 0.1644028425, blue: 0.1861923337, alpha: 1)
        view.addSubview(button)
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-25-[v0]-25-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": button]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-100-[v0]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": button]))
        
    }
    
    @objc func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
