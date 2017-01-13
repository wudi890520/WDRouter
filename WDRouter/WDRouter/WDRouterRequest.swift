//
//  WDRouterRequest.swift
//  WDRouter
//
//  Created by 吴頔 on 17/1/11.
//  Copyright © 2017年 WD. All rights reserved.
//

import UIKit

class WDRouterRequest: NSObject {

    var viewController: UIViewController!
    var parameters: [String: AnyObject]?
    var animate: Bool = true
    
    
    init(viewControllerName: String,
         parameters: [String: AnyObject]? = nil,
         animate: Bool = true) {
        
        guard let clsName = Bundle.main.infoDictionary!["CFBundleExecutable"] else {
            print("命名空间不存在")
            return
        }
        
        let classType: AnyObject.Type = NSClassFromString("\(clsName).\(viewControllerName)")!
        let objectType: UIViewController.Type = classType as! UIViewController.Type
        viewController = objectType.init()
        viewController.hidesBottomBarWhenPushed = true
        self.parameters = parameters
        
        if parameters != nil {
            let nextControllerPropertyList = objectType.propertyList()
            
            for (key, value) in parameters! {
                if nextControllerPropertyList.contains(key) {
                    viewController.setValue(value, forKey: key)
                }
            }
        }
        
        self.animate = animate
    }
    
}


