//
//  AppDelegate.swift
//  SinaWeiBoForMarking
//
//  Created by mac on 15/10/8.
//  Copyright © 2015年 majia. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        //设置外观
        setupAppearance()
        
        window = UIWindow(frame:UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.redColor()
        window?.rootViewController = MainViewController()
        window?.makeKeyAndVisible()
        
        
        return true
    }

    private func setupAppearance() {
        UINavigationBar.appearance().tintColor = UIColor.orangeColor()
        UITabBar.appearance().tintColor = UIColor.orangeColor()
    }
}
