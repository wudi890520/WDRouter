//
//  WDRouter.swift
//  WDRouter
//
//  Created by 吴頔 on 17/1/11.
//  Copyright © 2017年 WD. All rights reserved.
//

import UIKit

/// 路由器回调
typealias WDRouterResponse = (AnyObject?) -> Void

let WDScheme = "WDRouterTest://"


final class WDRouter: NSObject {
    
    /// 单例
    static let shared = WDRouter()
    
    
    /// 发送回调
    ///
    /// - Parameters:
    ///   - name: 通知名称
    ///   - result: 回调内容
    func sendResponse(name: NSNotification.Name,
                      result: AnyObject) {
        
        NotificationCenter.default.post(name: name,
                                        object: result)
        
    }
    
    /// 处理回调
    ///
    /// - Parameters:
    ///   - controller: 发送通知的ViewController
    ///   - response: block
    func handleResponse(controller: UIViewController, response: @escaping WDRouterResponse) {
        let name: NSNotification.Name = controller.notificationName()
        var observer: NSObjectProtocol?
        observer = NotificationCenter.default.addObserver(forName: controller.notificationName(), object: nil, queue: nil, using: { (notification) in
            response(notification.object as AnyObject?)
            NotificationCenter.default.removeObserver(observer!, name: name, object: nil)
        })
    }
}

extension WDRouter {
    class func push(request: WDRouterRequest,
                    response: WDRouterResponse?) {
        
        /// 获取appDelegate的window
        let appDelegateWindow = (UIApplication.shared.delegate as! AppDelegate).window
        
        /// 如果root是个UITabBar
        if appDelegateWindow?.rootViewController is UITabBarController {
            let tabBarController = appDelegateWindow?.rootViewController as! UITabBarController
            
            let selectedController = tabBarController.selectedViewController
            
            /// 如果当前选择的是navigationController
            if selectedController is UINavigationController {
                (selectedController as! UINavigationController).pushViewController(request.viewController,
                                                                                   animated: request.animate)
    
                if response != nil {
                    let name: NSNotification.Name = request.viewController.notificationName()
                    var observer: NSObjectProtocol?
                    observer = NotificationCenter.default.addObserver(forName: request.viewController.notificationName(), object: nil, queue: nil, using: { (notification) in
                        response!(notification.object as AnyObject?)
                        NotificationCenter.default.removeObserver(observer!, name: name, object: nil)
                    })
                }
            }
        }
        
    }
    
    class func present(request: WDRouterRequest,
                       response: WDRouterResponse?) {
        let appDelegateWindow = (UIApplication.shared.delegate as! AppDelegate).window
        let navigationController = UINavigationController(rootViewController: request.viewController)
        
        appDelegateWindow?.rootViewController?.present(navigationController, animated: request.animate, completion: nil)
        
        if response != nil {
            let name: NSNotification.Name = request.viewController.notificationName()
            var observer: NSObjectProtocol?
            observer = NotificationCenter.default.addObserver(forName: request.viewController.notificationName(), object: nil, queue: nil, using: { (notification) in
                response!(notification.object as AnyObject?)
                NotificationCenter.default.removeObserver(observer!, name: name, object: nil)
            })
        }
    }
    
    class func open(url: String,
                    isPresent: Bool = false,
                    parameters: [String: AnyObject]? = nil,
                    response: WDRouterResponse?) {
        if !url.isHTTPURL() {
    
            let querys = url.querys()
            let page = url.page()
            
            let type = WDRouterClass.shared.URLDictionary[page]
            
            if type is UIViewController.Type {
                let controller = url.getController()
                
                controller.setPropertys(query: querys)
                if parameters != nil { controller.setPropertys(query: parameters!) }
                
                if isPresent == false {
                    
                    WDRouterExtension.currentViewController().navigationController?.pushViewController(controller, animated: true)
                    
                    if response != nil {
                        let name: NSNotification.Name = controller.notificationName()
                        var observer: NSObjectProtocol?
                        observer = NotificationCenter.default.addObserver(forName: controller.notificationName(), object: nil, queue: nil, using: { (notification) in
                            response!(notification.object as AnyObject?)
                            NotificationCenter.default.removeObserver(observer!, name: name, object: nil)
                        })
                    }
                   
                }else{
                    let navigationController = UINavigationController(rootViewController: controller)
                    
                    WDRouterExtension.currentViewController().present(navigationController, animated: true, completion: nil)
                    
                    if response != nil {
                        let name: NSNotification.Name = controller.notificationName()
                        var observer: NSObjectProtocol?
                        observer = NotificationCenter.default.addObserver(forName: controller.notificationName(), object: nil, queue: nil, using: { (notification) in
                            response!(notification.object as AnyObject?)
                            NotificationCenter.default.removeObserver(observer!, name: name, object: nil)
                        })
                    }
                }
            }else{
                let array = type as! Array<Any>
                let objectType: NSObject.Type = array.first as! NSObject.Type
                let selector = array.last as! Selector
                let obj = objectType.init()
                obj.performSelector(onMainThread: selector, with: url.querys(), waitUntilDone: false)
            }

        }else{
            print("web view")
        }
    }
}
