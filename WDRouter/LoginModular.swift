//
//  LoginModular.swift
//  WDRouter
//
//  Created by 吴頔 on 17/1/12.
//  Copyright © 2017年 WD. All rights reserved.
//

import UIKit

class LoginModular: NSObject {

    func login(parameters: [String: String]) {
        print("login action !!")
        print(parameters)
        
        UIAlertView(title: "拨打电话", message: parameters["mobile"], delegate: nil, cancelButtonTitle: "确定").show()

    }
    
}
