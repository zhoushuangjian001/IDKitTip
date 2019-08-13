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
    public func displayLoading(_ centeryMultiplier:CGFloat = 1.0, _ constant:CGFloat = 0) {
        self.displayLoading("com.idkit.tip", centeryMultiplier, constant)
    }
    
    /// 展示有内容的活动指示器
    ///
    /// - Parameters:
    ///   - msg: 展示的内容
    ///   - centeryMultiplier: 相对父视图中心位置的乘数
    ///   - constant: 相对中心位置偏移
    public func displayLoading(_ msg:String, _ centeryMultiplier:CGFloat = 1.0, _ constant:CGFloat = 0) {
        let gbView = self.gbView
        self.addSubview(gbView)
        print(gbView)

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
    
    public func hiddenLoading() {
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
    
    public func displayTip(_ msg:String ,_ centeryMultiplier:CGFloat = 1.0, _ constant:CGFloat = 0, timeInterval:Double = 3) {
        self.displayTip(tipTitle:nil, tipImage: nil, tipMsg: msg, tipActions: nil, centeryMultiplier, constant, timeInterval: timeInterval, method: nil)
    }

    public func displayTip(tipTitle title:String, tipMsg msg:String, _ centeryMultiplier:CGFloat = 1.0, _ constant:CGFloat = 0, timeInterval:Double = 3) {
        self.displayTip(tipTitle: title, tipImage: nil, tipMsg: msg, tipActions: nil, centeryMultiplier, constant, timeInterval: timeInterval, method: nil)
    }

    public func dispalyTip(tipImage image:UIImage, tipMsg msg:String, _ centeryMultiplier:CGFloat = 1.0, _ constant:CGFloat = 0, timeInterval:Double = 3) {
        self.displayTip(tipTitle: nil, tipImage: image, tipMsg: msg, tipActions: nil, centeryMultiplier, constant, timeInterval: timeInterval, method: nil)
    }

    public func displayTip(tipTitle title:String = "温馨提示", tipMsg msg:String, tipActions actions:Array<String>, _ centeryMultiplier:CGFloat = 1.0, _ constant:CGFloat = 0, timeInterval:Double = 3, method:@escaping (_ index:NSInteger)->Void) {
        self.displayTip(tipTitle: title, tipImage: nil, tipMsg: msg, tipActions: actions, centeryMultiplier, constant, timeInterval: timeInterval, method: method)
    }

    func displayTip(tipTitle title:String?, tipImage image:UIImage?, tipMsg msg:String, tipActions actions:Array<String>?, _ centeryMultiplier:CGFloat = 1.0, _ constant:CGFloat = 0, timeInterval:Double = 3,method:((_ index:NSInteger)->Void)?) -> Void {

        let gbView = self.gbView;
        print(gbView)
        self.addSubview(gbView)
        let gbTop = NSLayoutConstraint.init(item: gbView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0);
        let gbLeft = NSLayoutConstraint.init(item: gbView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0)
        let gbBottom = NSLayoutConstraint.init(item: gbView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0)
        let gbRight = NSLayoutConstraint.init(item: gbView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: 0)
        self.addConstraints([gbTop,gbLeft,gbBottom,gbRight])

        let tbView = self.bView;
        gbView.addSubview(tbView)
        let centerX = NSLayoutConstraint.init(item: tbView, attribute: .centerX, relatedBy: .equal, toItem: gbView, attribute: .centerX, multiplier: 1.0, constant: 0)
        let centerY = NSLayoutConstraint.init(item: tbView, attribute: .centerY, relatedBy: .equal, toItem: gbView, attribute: .centerY, multiplier: centeryMultiplier, constant: constant)
        let tbWidth = NSLayoutConstraint.init(item: tbView, attribute: .width, relatedBy: .lessThanOrEqual, toItem: gbView, attribute: .width, multiplier: 0.68, constant: 0)
        gbView.addConstraints([tbWidth,centerX,centerY])

        var tempAny:Any?
        if (title != nil && title?.count != 0) {
            let titleLabel = self.tipTitleLabel
            tempAny = titleLabel
            titleLabel.text = title
            tbView.addSubview(titleLabel)
            let tTop = NSLayoutConstraint.init(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: tbView, attribute: .top, multiplier: 1.0, constant: 15)
            let tLeft = NSLayoutConstraint.init(item: titleLabel, attribute: .left, relatedBy: .lessThanOrEqual, toItem: tbView, attribute: .left, multiplier: 1.0, constant: 30)
            let tRight = NSLayoutConstraint.init(item: titleLabel, attribute: .right, relatedBy: .lessThanOrEqual, toItem: tbView, attribute: .right, multiplier: 1.0, constant: -30)
            let tCenterX = NSLayoutConstraint.init(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: tbView, attribute: .centerX, multiplier: 1.0, constant: 0)
            tbView.addConstraints([tTop, tLeft, tRight, tCenterX])
        }

        if image != nil {
            let imageV = self.tipImageView
            imageV.image = image
            tempAny = imageV
            tbView.addSubview(imageV)
            let imageVTop = NSLayoutConstraint.init(item: imageV, attribute: .top, relatedBy: .equal, toItem: tbView, attribute: .top, multiplier: 1.0, constant: 15)
            let imageVCenterX = NSLayoutConstraint.init(item: imageV, attribute: .centerX, relatedBy: .equal, toItem: tbView, attribute: .centerX, multiplier: 1.0, constant: 0)
            tbView.addConstraints([imageVTop,imageVCenterX])
        }


        let msgLabel = self.tipMsgLabel
        msgLabel.text = msg
        tbView.addSubview(msgLabel)
        let msgTop = NSLayoutConstraint.init(item: msgLabel, attribute: .top, relatedBy: .equal, toItem: tempAny == nil ? tbView:tempAny!, attribute: tempAny == nil ?.top:.bottom, multiplier: 1.0, constant: 15)
        let msgLeft = NSLayoutConstraint.init(item: msgLabel, attribute: .left, relatedBy: .equal, toItem: tbView, attribute: .left, multiplier: 1.0, constant: 15)
        let msgRight = NSLayoutConstraint.init(item: msgLabel, attribute: .right, relatedBy: .equal, toItem: tbView, attribute: .right, multiplier: 1.0, constant: -15)
        tbView.addConstraints([msgTop, msgLeft,  msgRight])

        if actions != nil && actions?.count != 0 {
            let horzLine = self.tipHorizontalLine
            tbView.addSubview(horzLine)
            let hlTop = NSLayoutConstraint.init(item: horzLine, attribute: .top, relatedBy: .equal, toItem: msgLabel, attribute: .bottom, multiplier: 1.0, constant: 15)
            let hlLeft = NSLayoutConstraint.init(item: horzLine, attribute: .left, relatedBy: .equal, toItem: tbView, attribute: .left, multiplier: 1.0, constant: 0)
            let hlRight = NSLayoutConstraint.init(item: horzLine, attribute: .right, relatedBy: .equal, toItem: tbView, attribute: .right, multiplier: 1.0, constant: 0)
            let hlheight = NSLayoutConstraint.init(item: horzLine, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 0.5)
            tbView.addConstraints([hlTop, hlLeft, hlRight,hlheight])
            
            var tempAction:TipAction?
            var index:Int = 0
            actions!.forEach({ (title) in
                let button = self.tipButton
                button.setTitle(title, for: .normal)
                button.tag = index
                
                
            })
            
            if (actions?.count == 1) {
                let btnAction = self.tipButton
                btnAction.setTitle(actions?.first!, for: .normal)
                btnAction.addTarget(self, action:#selector(btnAction(_ :)), for: .touchUpInside)
                btnAction.buttonAction = { index in
                    method!(index)
                }
                tbView.addSubview(btnAction)
                let bCancleTop = NSLayoutConstraint.init(item: btnAction, attribute: .top, relatedBy: .equal, toItem: horzLine, attribute: .bottom, multiplier: 1.0, constant: 0)
                let bCancleLeft = NSLayoutConstraint.init(item: btnAction, attribute: .left, relatedBy: .equal, toItem: tbView, attribute: .left, multiplier: 1.0, constant: 0)
                let bCancleRight = NSLayoutConstraint.init(item: btnAction, attribute: .right, relatedBy: .equal, toItem: tbView, attribute: .right, multiplier: 1.0, constant: 0)
                let bCancleBottom = NSLayoutConstraint.init(item: btnAction, attribute: .bottom, relatedBy: .equal, toItem: tbView, attribute: .bottom, multiplier: 1.0, constant: 0)
                tbView.addConstraints([bCancleTop, bCancleLeft, bCancleBottom, bCancleRight])
            }
            
            if (actions?.count == 2) {
                
            }
            
        } else {
            let msgBottom = NSLayoutConstraint.init(item: msgLabel, attribute: .bottom, relatedBy: .equal, toItem: tbView, attribute: .bottom, multiplier: 1.0, constant: -20)
            tbView.addConstraint(msgBottom)
        }
    }

    public func hiddenTip() {

    }


    /// 按钮事件处理函数
    ///
    /// - Parameter button: 按钮对象
    @objc func btnAction(_ button:TipAction) {
        button.buttonAction!(button.tag)
    }


    var tipTitleLabel:UILabel {
        let label = UILabel.init()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label;
    }

    var tipMsgLabel:UILabel {
        let label = UILabel.init()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }

    var tipImageView:UIImageView {
        let imageView = UIImageView.init()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }

    var tipButton:TipAction {
        let button = TipAction.init(type: .custom)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.blue, for: .normal)
        return button;
    }

    var tipHorizontalLine:IDKitView {
        let view = IDKitView.init()
        view.backgroundColor = .gray
        return view
    }

}


class TipAction: UIButton {

    /// 按钮事件的回调
    var buttonAction:((Int)->Void)?
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
