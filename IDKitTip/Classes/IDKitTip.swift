//
//  IDKitTip.swift
//  testApp
//
//  Created by IDKit on 2019/8/6.
//  Copyright © 2019 IDKit. All rights reserved.
//

import Foundation
import UIKit

extension UIView  {
    
    /// 展示无内容的活动指示器
    ///
    /// - Parameters:
    ///   - centeryMultiplier: 相对父视图中心位置的乘数
    ///   - constant: 相对中心位置偏移
    func displayLoading(_ centeryMultiplier:CGFloat = 1.0, _ constant:CGFloat = 0) {
        self.displayLoading("com.idkit.tip", centeryMultiplier, constant)
    }
    
    /// 展示有内容的活动指示器
    ///
    /// - Parameters:
    ///   - msg: 展示的内容
    ///   - centeryMultiplier: 相对父视图中心位置的乘数
    ///   - constant: 相对中心位置偏移
    func displayLoading(_ msg:String, _ centeryMultiplier:CGFloat = 1.0, _ constant:CGFloat = 0) {
        let gbView = self.gbView
        self.addSubview(gbView)
        let marginTop:NSLayoutConstraint = NSLayoutConstraint.init(item: gbView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let marginLeft:NSLayoutConstraint = NSLayoutConstraint.init(item: gbView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0)
        let marginBottom:NSLayoutConstraint = NSLayoutConstraint.init(item: gbView, attribute: .bottom , relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        let marginRight:NSLayoutConstraint = NSLayoutConstraint.init(item: gbView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0)
        self.addConstraints([marginTop,marginLeft,marginBottom,marginRight])
        
        let bView = self.bView
        gbView.addSubview(bView)
        let centerX:NSLayoutConstraint = NSLayoutConstraint.init(item: bView, attribute: .centerX, relatedBy: .equal, toItem: gbView, attribute: .centerX, multiplier: 1.0, constant: 0)
        let centerY:NSLayoutConstraint = NSLayoutConstraint.init(item: bView, attribute: .centerY, relatedBy: .equal, toItem: gbView, attribute: .centerY, multiplier: centeryMultiplier, constant: constant)
        if msg == "com.idkit.tip" {
            let width:NSLayoutConstraint = NSLayoutConstraint.init(item: bView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 80)
            let height:NSLayoutConstraint = NSLayoutConstraint.init(item: bView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 80)
            gbView.addConstraints([width,height,centerX,centerY])
        } else {
            let width:NSLayoutConstraint = NSLayoutConstraint.init(item: bView, attribute: .width, relatedBy: .lessThanOrEqual, toItem: gbView, attribute: .width, multiplier: 0.68, constant: 0)
            gbView.addConstraints([width,centerX,centerY])
        }
        
        let activityIndicatorView:UIActivityIndicatorView = self.activityIndicatorView
        bView.addSubview(activityIndicatorView)
        let aCenterX:NSLayoutConstraint = NSLayoutConstraint.init(item: activityIndicatorView, attribute: .centerX, relatedBy: .equal, toItem: bView, attribute: .centerX, multiplier: 1.0, constant: 0)
        if msg == "com.idkit.tip" {
            let aCenterY:NSLayoutConstraint = NSLayoutConstraint.init(item: activityIndicatorView, attribute: .centerY, relatedBy: .equal, toItem: bView, attribute: .centerY, multiplier: 1.0, constant: 0)
            bView.addConstraints([aCenterX,aCenterY])
        } else {
            let aMarginTop:NSLayoutConstraint = NSLayoutConstraint.init(item: activityIndicatorView, attribute: .top, relatedBy: .equal, toItem: bView, attribute: .top, multiplier: 1, constant: 30)
            bView.addConstraints([aMarginTop,aCenterX])
        }
        
        if msg != "com.idkit.tip" {
            let label:UILabel = self.label
            label.text = msg
            bView.addSubview(label)
            let labelt:NSLayoutConstraint = NSLayoutConstraint.init(item: label, attribute: .top, relatedBy: .equal, toItem: activityIndicatorView, attribute: .bottom, multiplier: 1.0, constant: 25)
            let labell:NSLayoutConstraint = NSLayoutConstraint.init(item: label, attribute: .left, relatedBy: .equal, toItem: bView, attribute: .left, multiplier: 1.0, constant: 15)
            let labelb:NSLayoutConstraint = NSLayoutConstraint.init(item: label, attribute: .bottom, relatedBy: .equal, toItem: bView, attribute: .bottom, multiplier: 1.0, constant: -15)
            let labelr:NSLayoutConstraint = NSLayoutConstraint.init(item: label, attribute: .right, relatedBy: .equal, toItem: bView, attribute: .right, multiplier: 1.0, constant: -15)
            bView.addConstraints([labelt,labell,labelb,labelr])
        }
    }
    
    func hiddenLoading() {
        var view = objc_getAssociatedObject(self, self.markKey) as? IDKitView
        if view != nil {
            DispatchQueue.main.async {
                view?.removeFromSuperview()
                view = nil
            }
        }
    }
    
    // 文字
    var label:UILabel {
        let label = UILabel.init()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        return label
    }
    
    // 标记 Key
    var markKey:UnsafeRawPointer {
        let urPointer = UnsafeRawPointer.init(bitPattern: "com.idkit.tip".hashValue)
        return urPointer!
    }
    
    // 活动指示器
    var activityIndicatorView:UIActivityIndicatorView {
        let activityV = UIActivityIndicatorView.init()
        activityV.translatesAutoresizingMaskIntoConstraints = false
        activityV.activityIndicatorViewStyle = .gray
        let transform:CGAffineTransform = CGAffineTransform.init(scaleX: 2, y: 2);
        activityV.transform = transform;
        activityV.startAnimating()
        return activityV
    }
    
    
}

extension UIView {
    
    
    
}



extension UIView {
    // 底层
    var bView:IDKitView {
        let view = IDKitView.init()
        view.backgroundColor = UIColor.white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 8.0
        return view;
    }
    
    // 基层
    var gbView:IDKitView {
        let view = IDKitView.init()
        view.backgroundColor = UIColor.init(white: 0, alpha: 0.45)
        objc_setAssociatedObject(self, self.markKey, view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return view
    }
}

class IDKitView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
