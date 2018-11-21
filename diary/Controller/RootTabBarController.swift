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
        let messagesVC = UINavigationController(rootViewController: MessagesVC())
        let settingsVC = UINavigationController(rootViewController: SettingsVC())
        
        messagesVC.tabBarItem.image = UIImage(named: "messages")
        messagesVC.tabBarItem.title = "Messages"

        settingsVC.tabBarItem.image = UIImage(named: "settings")
        settingsVC.tabBarItem.title = "Settings"
        
        diaryVC.tabBarItem.image = UIImage(named: "notebook")
        diaryVC.tabBarItem.title = "Diary"
        
        gradesVC.tabBarItem.image = UIImage(named: "grades")
        gradesVC.tabBarItem.title = "Grades"
        
        sheduleVC.tabBarItem.image = UIImage(named: "calendarBlack")
        sheduleVC.tabBarItem.title = "Schedule"
        
        tabBar.barStyle = UIBarStyle.black
        tabBar.tintColor = #colorLiteral(red: 0, green: 0.5675930977, blue: 1, alpha: 1)
        viewControllers = [sheduleVC, diaryVC, gradesVC, messagesVC, settingsVC]
    }
    
}
