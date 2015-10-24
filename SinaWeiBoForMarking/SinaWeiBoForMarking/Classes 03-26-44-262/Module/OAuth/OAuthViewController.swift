//
//  OAuthViewController.swift
//  SinaWeiBoForMarking
//
//  Created by mac on 15/10/10.
//  Copyright © 2015年 majia. All rights reserved.
//

import UIKit
import SVProgressHUD

class OAuthViewController: UIViewController,UIWebViewDelegate {

//    private lazy var webView = UIWebView()
    //懒加载网页视图
    lazy var webView:UIWebView = {
        return UIWebView()
        }()
    override func loadView() {
        view = webView
        webView.delegate = self
        title = "新浪微博"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "关闭", style:UIBarButtonItemStyle.Plain, target: self, action: "close")
        
    }
    
    func close() {
        SVProgressHUD.dismiss()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //加载授权页面
        webView.loadRequest(NSURLRequest(URL: NetWorkingTools.sharedTools.oauthUrl()))
//        print(NetWorkingTools.sharedTools.oauthUrl())
    }
    
    
    func webViewDidStartLoad(webView:UIWebView){
    
        SVProgressHUD.show()
    }
    func webViewDidFinishLoad(webView:UIWebView){
        SVProgressHUD.dismiss()
    }
   

    //如果请求的URL 包含 回掉地址 需要判断参数，否则继续加载
    func webView(webView:UIWebView ,shouldStartLoadWithRequest request:NSURLRequest, navigationType:UIWebViewNavigationType)->Bool{
        // absoluteString取出完整的字符串
        let urlString = request.URL!.absoluteString
        //判断是否包含回调地址
      if  !urlString.hasPrefix(NetWorkingTools.sharedTools.redirectUrl){
            return true
        }
        print("判断参数")
        // query 就是url后面的code=部分
//        print(request.URL?.query)
        //hasPrefix  是否有前缀
        if  let query = request.URL?.query where query.hasPrefix("code=") {
            //从query中截取授权码
            let code = (query as NSString).substringFromIndex(5)
            
            loadAccessToken(code)
        }else{
        close()
        }
        
        return false
        
    }
    private func loadAccessToken(code: String){
        
        NetWorkingTools.sharedTools.loadAccessToken(code){(result,error)->()in
            //如果错误不等于空或者结果为空，显示你的网络不给力。没有获取到数据
            if  error != nil || result == nil{
            SVProgressHUD.showInfoWithStatus("你的网络不给力")
                //延时一段时间关闭
                let when = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * NSEC_PER_SEC))
                    dispatch_after(when, dispatch_get_main_queue()){
                        self.close()
                }
                return
            }
            //字典转模型
            let accout = UserAccount(dict:result!)
            accout.saveAccount()
            
            NetWorkingTools.sharedTools.loadUserInfo(accout.uid!, finished: { (result, error) -> () in
                print("看这里")
                print(result)
            })

//            print(accout)
        }
 }
}
