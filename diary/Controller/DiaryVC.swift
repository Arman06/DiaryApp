//
//  DiaryVC.swift
//  diary
//
//  Created by Арман on 11/6/18.
//  Copyright © 2018 Арман. All rights reserved.
//

import UIKit

class DiaryVC: UIViewController {
    
    var data = [SuperJSON]()
    var dataKeys: [String]?
    var subjects = [String:[Subject]]()
    var days = [String]()
    
    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Load", for: .normal)
        button.backgroundColor = UIColor.red
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(loadButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.backgroundColor = #colorLiteral(red: 0.1602233052, green: 0.1644028425, blue: 0.1861923337, alpha: 1)
        tableView.allowsSelection = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "id")
        return tableView
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = #colorLiteral(red: 0.1602233052, green: 0.1644028425, blue: 0.1861923337, alpha: 1)
        view.addSubview(button)
        view.addSubview(tableView)
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": tableView]))

        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-25-[v0]-25-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": button]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-100-[v0]-[v1]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": button, "v1" : tableView]))
        
    }
    
    @objc func loadButtonTapped(_ sender: UIButton) {
        
        Eljur.getSchedule { (daysArray, error) in
            if let array = daysArray {
                self.data.append(array)
                self.dataKeys =  self.data[0].dictionaryAny?.keys.sorted(by: >)
                for key in self.dataKeys! {
                    self.subjects[key] = [Subject]()
                    let dataForLoop = self.data[0][key]!["items"]!
                    for index in 0...dataForLoop.count! - 1 {
                        self.subjects[key]?.append(Subject(name: dataForLoop[index]!["name"]!.string!, teacher: dataForLoop[index]!["teacher"]!.string!))
                    }
                }
                self.days = self.subjects.keys.sorted(by: <)
                self.tableView.reloadData() 
            }
        }
    }
    
}

extension DiaryVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects[days[section]]!.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return days.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = days[section]
        label.backgroundColor = UIColor.lightGray
        return label
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "id", for: indexPath)
        cell.backgroundColor = #colorLiteral(red: 0.1602233052, green: 0.1644028425, blue: 0.1861923337, alpha: 1)
        cell.textLabel?.text = "\(subjects[days[indexPath.section]]![indexPath.row].name)"
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
    
    
    
}
