//
//  RootTabBarController.swift
//  diary
//
//  Created by Арман on 11/17/18.
//  Copyright © 2018 Арман. All rights reserved.
//

import UIKit

class RootTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let sheduleVC = UINavigationController(rootViewController: ScheduleVC())
        let diaryVC = UINavigationController(rootViewController: DiaryVC())
        let gradesVC = UINavigationController(rootViewController: GradesVC())
        diaryVC.tabBarItem.image = UIImage(named: "notebook")
        diaryVC.tabBarItem.title = "Diary"
        gradesVC.tabBarItem.image = UIImage(named: "grades")
        gradesVC.tabBarItem.title = "Grades"
        sheduleVC.navigationController?.isNavigationBarHidden = true
        sheduleVC.tabBarItem.image = UIImage(named: "calendarBlack")
        sheduleVC.tabBarItem.title = "Schedule"
        tabBar.barStyle = UIBarStyle.black
        tabBar.tintColor = #colorLiteral(red: 1, green: 0.3513356447, blue: 0.3235116899, alpha: 1)
        viewControllers = [sheduleVC, diaryVC, gradesVC]
    }
    
}
