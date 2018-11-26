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
        return button
    }()
    
   
    let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        return layout
    }()
    
    
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let cellSize = CGSize(width: view.frame.width - 25, height: view.frame.height / 3.2)
        flowLayout.minimumLineSpacing = 25
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.itemSize = cellSize
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = #colorLiteral(red: 0.1602233052, green: 0.1644028425, blue: 0.1861923337, alpha: 1)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(SubjectCell.self, forCellWithReuseIdentifier: "subj")
        return collectionView
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        setupViews()
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = #colorLiteral(red: 1, green: 0.3513356447, blue: 0.3235116899, alpha: 1)
        refreshControl.addTarget(self, action: #selector(didRefresh), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        collectionView.sendSubviewToBack(refreshControl)
        indicatorView.isHidden = false
        indicatorView.startAnimating()
        getSchedule(completion: nil)
    }
    
    @objc func didRefresh() {
        guard let refreshControl = collectionView.refreshControl else { return }
        self.getSchedule { (success) in
            refreshControl.endRefreshing()
        }

    }
    
    func getSchedule(completion: ((Bool) -> Void)?) {

//        tableView.isHidden = true
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
//                self.tableView.isHidden = false
                self.collectionView.reloadData()
                guard let fun = completion else {return}
                fun(true)
            } else {
                print(error as Any)
                self.errorLabel.isHidden = false
                self.indicatorView.stopAnimating()
                self.indicatorView.isHidden = true
                guard let fun = completion else {return}
                fun(false)
            }
        }

    }
    
    func setupViews() {
//        view.addSubview(button)
        view.addSubview(collectionView)
        view.addSubview(errorLabel)
        view.addSubview(indicatorView)
        view.bringSubviewToFront(errorLabel)
        
        errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        errorLabel.isHidden = true
        
        indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        indicatorView.isHidden = true
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutConstraint.FormatOptions(),metrics: nil, views: ["v0": collectionView]))
        

        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    

    
}

extension ScheduleVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 25, height: view.frame.height / 3.2)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subjects[days[section]]!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "subj", for: indexPath) as! SubjectCell
        cell.backgroundColor = #colorLiteral(red: 0.1785729825, green: 0.1843303144, blue: 0.2109975219, alpha: 1)
        let subject = subjects[days[indexPath.section]]![indexPath.row]
        cell.name.text = subject.name
        cell.teacher.text = subject.teacher
        cell.startTime.text = subject.start
        cell.endTime.text = subject.end
        cell.time.text = subject.start + " -> " + subject.end
        cell.room.text = subject.room == "" ? "none" : subject.room
        cell.group.text = subject.group
            return cell
    }
    
    
}
