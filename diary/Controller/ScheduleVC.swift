//
//  DiaryVC.swift
//  diary
//
//  Created by Арман on 11/6/18.
//  Copyright © 2018 Арман. All rights reserved.
//

import UIKit

class ScheduleVC: UICustomViewController {
    
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
//        tableView.separatorInset = UIEdgeInsets.zero
        tableView.separatorStyle = .none
        tableView.backgroundColor = #colorLiteral(red: 0.1602233052, green: 0.1644028425, blue: 0.1861923337, alpha: 1)
        tableView.allowsSelection = false
        tableView.register(SubjectCell.self, forCellReuseIdentifier: "id")
        return tableView
    }()
    
    let errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Произошла ошибочка (-.-)"
        label.textColor = textThemeColor
        return label
    }()
    
    let indicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.style = UIActivityIndicatorView.Style.whiteLarge
        indicator.color = UIColor.red
        return indicator
    }()
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupViews()
        getSchedule()
    }
    
    
    func getSchedule() {
        indicatorView.isHidden = false
        indicatorView.startAnimating()
        tableView.isHidden = true
        Eljur.getSchedule { (daysArray, error) in
            if let array = daysArray {
                self.data.removeAll()
                self.days.removeAll()
                self.data.append(array)
                self.dataKeys =  self.data[0].dictionaryAny?.keys.sorted(by: <)
                for key in self.dataKeys! {
                    print(key)
                    self.subjects[self.data[0][key]!["title"]!.string!] = [Subject]()
                    self.days.append(self.data[0][key]!["title"]!.string!)
                    let dataForLoop = self.data[0][key]!
                    for index in 0...dataForLoop["items"]!.count! - 1 {
                        let dataForItem = dataForLoop["items"]![index]!
                        self.subjects[dataForLoop["title"]!.string!]?.append(Subject(name: dataForItem["name"]!.string!, teacher: dataForItem["teacher"]!.string!, num: dataForItem["num"]!.string!, room: dataForItem["room"]!.string!, start: dataForItem["starttime"]!.string!, end: dataForItem["endtime"]!.string!, group: dataForItem["grp"]?.string))
                    }
                }
                print(self.subjects)
                print(self.days)
                self.errorLabel.isHidden = true
                self.indicatorView.stopAnimating()
                self.indicatorView.isHidden = true
                self.tableView.isHidden = false
                self.tableView.reloadData()
            } else {
                print(error as Any)
                self.errorLabel.isHidden = false
                self.indicatorView.stopAnimating()
                self.indicatorView.isHidden = true
            }
        }

    }
    
    func setupViews() {
        view.addSubview(button)
        view.addSubview(tableView)
        view.addSubview(errorLabel)
        view.addSubview(indicatorView)
        view.bringSubviewToFront(errorLabel)
        
        errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        errorLabel.isHidden = true
        
        indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        indicatorView.isHidden = true
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutConstraint.FormatOptions(),
                                                           metrics: nil, views: ["v0": tableView]))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-25-[v0]-25-|", options: NSLayoutConstraint.FormatOptions(),
                                                           metrics: nil, views: ["v0": button]))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-70-[v0]-[v1]|", options: NSLayoutConstraint.FormatOptions(),
                                                           metrics: nil, views: ["v0": button, "v1" : tableView]))
    }
    
    @objc func loadButtonTapped(_ sender: UIButton) {
        getSchedule()
    }
    
}

extension ScheduleVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects[days[section]]!.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return days.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = days[section]
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.white
        return label
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "id", for: indexPath) as! SubjectCell
        cell.backgroundColor = #colorLiteral(red: 0.1602233052, green: 0.1644028425, blue: 0.1861923337, alpha: 1)
        let subject = subjects[days[indexPath.section]]![indexPath.row]
        let text = subject.num + ". " + subject.name + "\n" + subject.room + "\n" + subject.teacher + "\n" + subject.start + " -> " + subject.end
        cell.textLabel?.text = text
        cell.detailTextLabel?.text = subject.group
        cell.detailTextLabel?.textColor = UIColor.white
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
    
    
    
}
