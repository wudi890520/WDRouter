//
//  TabBarViewController.swift
//  WDRouter
//
//  Created by 吴頔 on 17/1/11.
//  Copyright © 2017年 WD. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    let firstNavigationController = UINavigationController(rootViewController: FirstViewController())
    let secondNavigationController = UINavigationController(rootViewController: SecondViewController())
    let thirdNavigationController = UINavigationController(rootViewController: ThirdViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        firstNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        secondNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        thirdNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 2)
        
        tabBar.tintColor = UIColor(red: 250/255, green: 146/255, blue: 241/255, alpha: 1)
        
        
        viewControllers = [firstNavigationController,
                           secondNavigationController,
                           thirdNavigationController]
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
