//
//  BaseTableViewController.swift
//  SinaWeiBoForMarking
//
//  Created by mac on 15/10/9.
//  Copyright © 2015年 majia. All rights reserved.
//

import UIKit
/*/ Type 'BaseTableViewController' does not conform to protocol 'VistorLoginViewDelegate'
*/
class BaseTableViewController: UITableViewController,VistorLoginViewDelegate{
    //用户登录成功标记
    var userLogon = UserAccount.loadAccount() != nil
    //访客视图
    var vistorView:VistorLoginView?
    
    override func loadView() {
        userLogon ? super.loadView() : setupVistorView()
    }
    ///设置访客视图
    private func setupVistorView(){
        vistorView = VistorLoginView()
        vistorView?.delegate = self
        view = vistorView
        //添加导航条的内容
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.Plain, target: self, action: "vistorLoginViewWillRegister")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.Plain, target: self, action: "vistorLoginViewWillLogin")
        
    }
    
    //MARK: 实现代理方法
    func vistorLoginViewWillLogin() {
        let nav = UINavigationController(rootViewController: OAuthViewController())
        presentViewController(nav, animated: true, completion: nil)
    }
    func vistorLoginViewWillRegister() {
        print("注册")
    }
   }
