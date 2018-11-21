//
//  SubjectCell.swift
//  diary
//
//  Created by Арман on 11/17/18.
//  Copyright © 2018 Арман. All rights reserved.
//

import UIKit

class SubjectCell: UICollectionViewCell {
    
    
    
//
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesEnded(touches, with: event)
//
//        self.transform = CGAffineTransform.identity
//
//    }
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//
//        self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
//
//
//    }
//
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesMoved(touches, with: event)
//
//        self.transform = CGAffineTransform.identity
//    }
//
//
//
//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesCancelled(touches, with: event)
//        self.transform = CGAffineTransform.identity
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
//        self.layer.borderWidth = 1
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.shadowOpacity = 0.1
        self.layer.shadowRadius = 6.0
        self.layer.cornerRadius = 9
        self.layer.masksToBounds = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("ooooh, something went wrong")
    }
    
    override func awakeFromNib() {
    }
    
    let name: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)
        label.textColor = textThemeColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let room: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        label.numberOfLines = 3
        label.textAlignment = .center
        label.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.layer.cornerRadius = 20 / 2
        label.layer.masksToBounds = true
        label.textColor = UIColor.black
//        label.textAlignment = NSTextAlignment.right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let startTime: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = textThemeColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let endTime: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = textThemeColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let time: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = textThemeColor
        label.textAlignment = .center
        label.backgroundColor = #colorLiteral(red: 0, green: 0.5675930977, blue: 1, alpha: 1)
        label.layer.cornerRadius = 27 / 2
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let teacher: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = textThemeColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stackViewTop: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .equalSpacing
//        stack.spacing = 50
        stack.addArrangedSubview(name)
//        stack.addArrangedSubview(room)
        return stack
    }()
    
    lazy var stackViewBottom: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .equalSpacing
        stack.spacing = 5
        stack.addArrangedSubview(startTime)
        stack.addArrangedSubview(endTime)
        return stack
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillProportionally
        stack.spacing = 10
        stack.addArrangedSubview(stackViewTop)
        stack.addArrangedSubview(teacher)
        stack.addArrangedSubview(stackViewBottom)
        return stack
    }()
    
    let group: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        label.numberOfLines = 0
        label.textColor = textThemeColor
        label.textAlignment = NSTextAlignment.center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    func setupViews() {
        addSubview(name)
        addSubview(room)
        addSubview(teacher)
        addSubview(time)
        addSubview(group)
        room.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        room.topAnchor.constraint(equalTo: topAnchor, constant: 22).isActive = true
        room.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        room.widthAnchor.constraint(lessThanOrEqualToConstant: frame.width - (frame.width / 1.3) - 5).isActive = true
        room.heightAnchor.constraint(greaterThanOrEqualToConstant: 21).isActive = true
        name.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        group.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        group.topAnchor.constraint(equalTo: room.bottomAnchor, constant: 10).isActive = true
        name.widthAnchor.constraint(lessThanOrEqualToConstant: (frame.width / 1.3) - 15).isActive = true
        name.topAnchor.constraint(equalTo: topAnchor, constant: 22).isActive = true
        teacher.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        teacher.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5).isActive = true
        teacher.widthAnchor.constraint(equalTo: name.widthAnchor).isActive = true
        time.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        time.topAnchor.constraint(equalTo: teacher.bottomAnchor, constant: 10).isActive = true
        time.widthAnchor.constraint(equalToConstant: 183).isActive = true
        time.heightAnchor.constraint(equalToConstant: 27).isActive = true
//        time.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -27).isActive = true
    }
   
}
