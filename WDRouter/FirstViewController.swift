//
//  FirstViewController.swift
//  WDRouter
//
//  Created by 吴頔 on 17/1/11.
//  Copyright © 2017年 WD. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    let pushButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        print(self)
        loadUI()
        targets()
        title = "ONE"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension FirstViewController {
    func loadUI() {
        pushButton.frame = CGRect(x: 0, y: 0, width: 120, height: 44)
        pushButton.center = view.center
        pushButton.backgroundColor = UIColor.red
        pushButton.setTitle("执行一个方法", for: .normal)
        pushButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        view.addSubview(pushButton)
    }
    
    func targets() {
        pushButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
}

extension FirstViewController {
    func buttonAction() {
        WDRouter.open(url: "WDRouterTest://home/login?mobile=13945110499", response: nil)
    }
}
