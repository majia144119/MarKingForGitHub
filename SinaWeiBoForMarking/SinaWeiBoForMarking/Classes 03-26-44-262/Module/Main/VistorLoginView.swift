//
//  VistorLoginView.swift
//  SinaWeiBoForMarking
//
//  Created by mac on 15/10/9.
//  Copyright © 2015年 majia. All rights reserved.
//

import UIKit
protocol VistorLoginViewDelegate:NSObjectProtocol{
    //访客将要登录
    func vistorLoginViewWillLogin()
    //访客将要注册
    func vistorLoginViewWillRegister()
}
class VistorLoginView: UIView {
    weak var delegate:VistorLoginViewDelegate?
    //设置访客信息
    func setupInfo(isHome:Bool , imageName:String,message:String){
        messageLabel.text = message
        iconView.image = UIImage(named: imageName)
        if !isHome {
            homeView.hidden = true
            sendSubviewToBack(maskIconView)
        }else{
            startAnimation()
        }
    
    }
    //启动动画
    private func startAnimation(){
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.toValue = 2 * M_PI
        anim.repeatCount = MAXFLOAT
        anim.duration = 20.0
        anim.removedOnCompletion = false
        iconView.layer.addAnimation(anim, forKey: nil)
    
    }
    
   //MARK -1.设置界面
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        setupUI()
    }
    //MARK：按钮的监听方法实现
    func clickRigesterButton(){
        delegate?.vistorLoginViewWillRegister()
    }
    func clickLoginButton(){
        delegate?.vistorLoginViewWillLogin()
    
    }
  
    private func setupUI(){
        //添加控件
        addSubview(iconView)
        addSubview(maskIconView)
        addSubview(homeView)
        addSubview(messageLabel)
        addSubview(registerButton)
        addSubview(loginButton)
        
        //设置约束
        //1.图标的约束
        iconView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: (-60)))
        //2.房子的约束
        homeView.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: homeView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: homeView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0))
       
        //3.文字的约束
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 30))
        
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 224))
        //4.按钮的约束 - 注册
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: messageLabel, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: messageLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 16))
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 100))
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 35))
        //5.按钮的约束 - 登录
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: messageLabel, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: messageLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 16))
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 100))
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 35))
        
        //.遮罩的约束
        maskIconView.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[maskView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["maskView":maskIconView]))
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[maskView]-(-60)-[registerButton]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views:["maskView":maskIconView,"registerButton":registerButton]))
        //设置背景颜色
        backgroundColor = UIColor(white: 0.93, alpha: 1.0)
    }
    
    
    
    //MARK： 懒加载数据
    //外面的圆环
    private lazy var iconView:UIImageView = {
        let iv = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
        return iv
    }()
    //遮罩视图
    private lazy var maskIconView:UIImageView = {
            let miv = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
        return miv
        }()
    
    //小房子
    private lazy var homeView:UIImageView = {
        let home = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
        return home
    }()
   //描述数据
    private lazy var messageLabel:UILabel = {
        let messageLabel = UILabel()
        messageLabel.font = UIFont.systemFontOfSize(14)
        messageLabel.textColor = UIColor.darkGrayColor()
        messageLabel.text = "我想就这样简简单单的爱下去"
        messageLabel.textAlignment = NSTextAlignment.Center
        messageLabel.numberOfLines = 0
        messageLabel.sizeToFit()
        return messageLabel
    }()
    //注册按钮
    private lazy var registerButton:UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        btn.setTitle("注册", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        //添加点击事件
        btn.addTarget(self, action:"clickRigesterButton", forControlEvents: UIControlEvents.TouchUpInside)
        return btn
    }()
    
    //登录按钮
    private lazy var loginButton:UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        btn.setTitle("登录", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        //添加点击事件
        btn.addTarget(self, action:"clickLoginButton", forControlEvents: UIControlEvents.TouchUpInside)
        return btn
        }()
}
