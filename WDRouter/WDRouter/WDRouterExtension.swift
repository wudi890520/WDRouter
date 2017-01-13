//
//  WDRouterExtension.swift
//  WDRouter
//
//  Created by 吴頔 on 17/1/11.
//  Copyright © 2017年 WD. All rights reserved.
//

import UIKit

/// 获取当前ViewController
class WDRouterExtension: NSObject {
    
    class func currentViewController() -> UIViewController {
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        return currentTopViewController(rootViewController: rootViewController!)
    }
    
    class func currentTopViewController(rootViewController: UIViewController) -> UIViewController {
        if (rootViewController.isKind(of: UITabBarController.self)) {
            let tabBarController = rootViewController as! UITabBarController
            return currentTopViewController(rootViewController: tabBarController.selectedViewController!)
        }
        
        if (rootViewController.isKind(of: UINavigationController.self)) {
            let navigationController = rootViewController as! UINavigationController
            return currentTopViewController(rootViewController: navigationController.visibleViewController!)
        }
        
        if ((rootViewController.presentedViewController) != nil) {
            return currentTopViewController(rootViewController: rootViewController.presentedViewController!)
        }
        return rootViewController
    }
    
    class func dismissCurrentViewController(animated: Bool = true) {
        currentViewController().dismiss(animated: animated, completion: nil)
    }
    
    class func popCurrentViewController(animated: Bool = true) {
        currentViewController().navigationController!.popViewController(animated: animated)
    }
    
    class func popToRootCurrentViewController(animated: Bool = true) {
        currentViewController().navigationController!.popToRootViewController(animated: animated)
    }
}

// MARK: - 获取类的属性列表
extension NSObject {
    class func propertyList() -> [String] {
        var responseList: [String] = []
        
        var count: UInt32 = 0
        //1.获取类的属性列表,返回属性列表的数组,可选项
        let list = class_copyPropertyList(self, &count)
        for i in 0..<Int(count) {
            //使用guard语法,一次判断每一项是否有值,只要有一项为nil,就不再执行后续的代码
            guard let pty = list?[i],
                let cName = property_getName(pty),
                let name = String(utf8String: cName)
                else {
                    //继续遍历下一个
                    continue
            }
            responseList.append(name)
        }
        free(list)
        return responseList
    }
    
    func notificationName() -> NSNotification.Name {
        return NSNotification.Name(rawValue: "WDNotificationFor\(self.classForCoder)")
    }
}

extension String {
    
    /// 是否包含HTTP
    ///
    /// - Returns: bool
    func isHTTPURL() -> Bool {
        return contains("http://") || contains("https://")
    }
    
    /// 获取url的query参数
    ///
    /// - Returns: Dictionary
    func querys() -> Dictionary<String, String> {
        let query = components(separatedBy: "?").count > 1 ? components(separatedBy: "?").last! : ""
        var querys = Dictionary<String, String>()
        if query.isEmpty == false {
            let queryList = query.components(separatedBy: "&")
            for para in queryList {
                let keyAndValues = para.components(separatedBy: "=")
                if keyAndValues.count == 2 {
                    querys[keyAndValues.first!] = keyAndValues.last
                }
            }
        }
        return querys
    }
    
    /// 获取页面信息
    ///
    /// - Returns: String
    func page() -> String {
        let path = replacingOccurrences(of: WDScheme, with: "")
        return path.components(separatedBy: "?").first!
    }
    
    /// 根据classType创建类实例
    ///
    /// - Returns: UIViewController
    func getController() -> UIViewController {
        let classType: UIViewController.Type = WDRouterClass.shared.URLDictionary[page()] as! UIViewController.Type
        let controller = classType.init()
        controller.hidesBottomBarWhenPushed = true
        return controller
    }
}

extension UIViewController {
    
    /// 设置类的成员属性
    ///
    /// - Parameter query: 属性集合
    func setPropertys(query: Dictionary<String, Any>) {
        
        let propertyList = classForCoder.propertyList()
        
        for (key, value) in query {
            if propertyList.contains(key) {
                setValue(value, forKey: key)
            }
        }
    }
    
    
}
