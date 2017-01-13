//
//  SecondViewController.swift
//  WDRouter
//
//  Created by 吴頔 on 17/1/11.
//  Copyright © 2017年 WD. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    let presentButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        loadUI()
        targets()
        title = "TWO"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension SecondViewController {
    func loadUI() {
        presentButton.frame = CGRect(x: 0, y: 0, width: 120, height: 44)
        presentButton.center = view.center
        presentButton.backgroundColor = UIColor.orange
        presentButton.setTitle("present detail", for: .normal)
        presentButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        view.addSubview(presentButton)
    }
    
    func targets() {
        presentButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
}

extension SecondViewController {
    func buttonAction() {
        
        WDRouter.open(url: "WDRouterTest://home/detail?id=1&name=china",
                      isPresent: true,
                      parameters: nil) { (response) in
            print(response!)
        }

    }
}
