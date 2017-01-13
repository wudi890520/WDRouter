//
//  ThirdViewController.swift
//  WDRouter
//
//  Created by 吴頔 on 17/1/11.
//  Copyright © 2017年 WD. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    let pushButton = UIButton()
    
    let stu = Student()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        loadUI()
        title = "THREE"
    }
}

extension ThirdViewController {
    func loadUI() {
        pushButton.frame = CGRect(x: 0, y: 0, width: 120, height: 44)
        pushButton.center = view.center
        pushButton.backgroundColor = UIColor.red
        pushButton.setTitle("push detail", for: .normal)
        pushButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        pushButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        view.addSubview(pushButton)
    }
}

extension ThirdViewController {
    func buttonAction() {
        WDRouter.open(url: "WDRouterTest://home/detail?id=1&name=china",
                      parameters: ["stu": stu]) { (response) in
            print(response!)
        }
    }
}
