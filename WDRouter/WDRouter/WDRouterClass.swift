//
//  WDRouterClassesRegisterHelper.swift
//  WDRouter
//
//  Created by 吴頔 on 17/1/11.
//  Copyright © 2017年 WD. All rights reserved.
//

import UIKit

class WDRouterClass: NSObject {

    static let shared = WDRouterClass()
    
    let homeDetail = "home/detail"
    let loginAction = "home/login"
    
    private var _URLDictionary = Dictionary<String, Any>()
    var URLDictionary: Dictionary<String, Any> {
        get {
            if _URLDictionary.keys.count == 0 {
                _URLDictionary = [homeDetail: DetailViewController.self,
                                  loginAction: [LoginModular.self, #selector(LoginModular.login(parameters:))]]
                
            }
            return _URLDictionary
        }
    }

}
