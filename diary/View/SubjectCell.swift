//
//  SubjectCell.swift
//  diary
//
//  Created by Арман on 11/17/18.
//  Copyright © 2018 Арман. All rights reserved.
//

import UIKit

class SubjectCell: UITableViewCell {
    
    let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.3135865331, green: 0.3139150143, blue: 0.3050451577, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        return view
    }()
    
    let name = CustomLabel()
    
    
    let room = CustomLabel()
    
    let teacher = CustomLabel()
    
    let start = CustomLabel()
    
    let end = CustomLabel()
    
    let group = CustomLabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup() {
//        addSubview(mainView)
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[v0]-5-|", options: NSLayoutConstraint.FormatOptions(),
//                                                           metrics: nil, views: ["v0": mainView]))
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutConstraint.FormatOptions(),
//                                                      metrics: nil, views: ["v0": mainView]))
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        backgroundColor = #colorLiteral(red: 0.1602233052, green: 0.1644028425, blue: 0.1861923337, alpha: 1)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
