//
//  ViewController.swift
//  IDKitTip
//
//  Created by zhoushuangjian001 on 08/09/2019.
//  Copyright (c) 2019 zhoushuangjian001. All rights reserved.
//

import UIKit
import IDKitTip


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let view1 = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height * 0.5))
        view1.backgroundColor = .red
        self.view.addSubview(view1)

        let view2 = UIView.init(frame: CGRect.init(x: 0, y: UIScreen.main.bounds.size.height * 0.5, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height * 0.5))
        view2.backgroundColor = .purple
        self.view.addSubview(view2)

        view1.displayTip(tipTitle: "温馨", tipMsg: "提", tipActions: ["确定"], 1.0, 0, timeInterval: 5) { (index) in
            print("我点击的是第一行：\(index)")
        }
        view2.dispalyTip(tipImage: UIImage.init(named: "dog.png")!, tipMsg: "你是一条小奶狗", 0.5, 0, timeInterval: 5)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

