//
//  DetailViewController.swift
//  WDRouter
//
//  Created by 吴頔 on 17/1/11.
//  Copyright © 2017年 WD. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    let label = UILabel()
    
    var id: NSNumber = 0
    var name: String = ""
    var stu: Student?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        loadUI()
        setNavigation()
        // Do any additional setup after loading the view.
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        WDRouter.shared.sendResponse(name: notificationName(),
                                     result: ["id": id] as AnyObject)
    }
}

extension DetailViewController {
    func loadUI() {
        label.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 500)
        label.center = view.center
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = "id = \(id)\nname = \(name)"
        
        if stu != nil {
            label.text = "id = \(id)\nname = \(name)\n\nthe student info:\nname:\(stu!.name)\nage:\(stu!.age)岁\nheight:\(stu!.height)米\nwieght:\(stu!.weight)KG"
        }
        
        view.addSubview(label)
    }
    
    func setNavigation() {
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAction))
        navigationItem.rightBarButtonItem = addItem
        
        if navigationController?.viewControllers.first == self {
            let dismissItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction))
            navigationItem.leftBarButtonItem = dismissItem
        }
        
    }
    
    func addAction() {
        id = NSNumber(value: id.intValue+10)
        label.text = "\(id)"
    }
    
    func cancelAction() {
        dismiss(animated: true, completion: nil)
    }
}
