//
//  BaseViewController.swift
//  Tabbar
//
//  Created by chenq@kensence.com on 2018/3/27.
//  Copyright © 2018年 chenq@kensence.com. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var navigationBar:UINavigationBar?
    var barView:UIView?
    var navigationBarView:UIView?
    var navbutton:UIButton!
    var NavTitle:UILabel!
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    
    override func viewDidLoad() {
     
        var safeaArea:CGFloat?
        super.viewDidLoad()
        navigationItem.title = tabBarItem.title
        view.backgroundColor = UIColor.white
        
        if #available(iOS 11, *) {
            safeaArea = self.view.safeAreaInsets.bottom
        }
        
        if IS_iPhoneX  == 1{
            view.y = CGFloat(TabbarSafeBottomMargin + 44)
            view.height = UIScreen.main.bounds.size.height - CGFloat(TabbarHeight + TabbarSafeBottomMargin + 44)
        }else
        {
            view.y  = 64
            view.height = UIScreen.main.bounds.size.height - CGFloat(TabbarHeight + 64)
        }
        addnavigationView()
    }
 
  
    private func addnavigationView(){
        
        if (navigationBar == nil) {
            if IS_iPhoneX == 1{
                navigationBarView = UIView(frame: CGRect(x: 0, y: 0, width: Int(ScreenW), height: TabbarSafeBottomMargin + 44))
                navigationBarView?.backgroundColor = UIColor.init(hexString: "#FFDA44")
                self.view.addSubview(navigationBarView!)
                navigationBar = UINavigationBar(frame: CGRect(x: 0, y:TabbarSafeBottomMargin, width: Int(ScreenW), height: NavigationBarHeight))
            }else
            {
                navigationBarView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenW, height: 20 + 44))
                navigationBarView?.backgroundColor = UIColor.init(hexString: "#FFDA44")
                self.view.addSubview(navigationBarView!)
                navigationBar = UINavigationBar(frame: CGRect(x: 0, y:TabbarSafeBottomMargin + 20, width: Int(ScreenW), height: NavigationBarHeight))
            }
            navigationBar?.setBackgroundImage(UIImage(), for: .default)
            navigationBar?.shadowImage = UIImage()
            navigationBar?.isTranslucent = true
            navigationBar?.barTintColor = UIColor.init(hexString:"#FFDA44")
            self.view.addSubview(self.navigationBar!)
        }
        NavTitle = UILabel(frame: CGRect(x: (navigationBarView?.centerX)! - 40, y: (navigationBarView?.centerY)!, width: 80, height: 30))
        NavTitle.textColor = .black
        NavTitle.font = .systemFont(ofSize: 14)
        NavTitle.textAlignment = .center
        navigationBarView?.addSubview(NavTitle)
    }
    
    /// 设置naviagtionbar left Or right item
    ///
    /// - Parameters:
    ///   - imageString: image
    ///   - title: title
    ///   - target: 对象
    ///   - action: 事件
    ///   - left: 是左边按钮还是右边按钮
    ///   - isBottom: 问题是否显示在图片下方
    public func NavigationViewLeft(imageString:String?,title:String?,target:Any?,action:Selector?,left:Bool,isBottom:Bool){
     
//        let button:UIButton
        if isBottom {
            
             if IS_iPhoneX == 1{
                if left{
                    navbutton = ClickItemButton(frame: CGRect(x:10, y:navigationBarView!.centerY + 2, width: 40, height: 35), image:UIImage(named:imageString!)! , title: title!,isleft:true,target:self , action: action!)
                }else
                {
                    navbutton = ClickItemButton(frame: CGRect(x:(navigationBarView?.Width)! - 28, y:navigationBarView!.centerY + 2, width: 40, height: 35), image:UIImage(named:imageString!)! , title: title!,isleft:true,target:self , action: action!)
                }
            }else
             {
                if left{
                    navbutton = ClickItemButton(frame: CGRect(x:10, y:navigationBarView!.centerY - 5, width: 40, height: 35), image:UIImage(named:imageString!)! , title: title!,isleft:true,target:self , action: action!)
                }else
                {
                    navbutton = ClickItemButton(frame: CGRect(x:(navigationBarView?.Width)! - 28, y:navigationBarView!.centerY - 5, width: 40, height: 35), image:UIImage(named:imageString!)! , title: title!,isleft:true,target:self , action: action!)
                }
            }
        }else{
           
            navbutton = UIButton(type: .custom)
            navbutton.setTitle(title, for: UIControlState.normal)
            navbutton.addTarget(target, action: action!, for: .touchUpInside)
            navbutton.setImage(UIImage(named: imageString!), for: UIControlState.normal)
            navbutton.setTitleColor(.darkGray, for: .normal)
            navbutton.titleLabel?.font = .systemFont(ofSize: 15)
            navbutton.sizeToFit()
        
             if IS_iPhoneX == 1{
                if left{
                    navbutton.frame = CGRect(x:10, y:navigationBarView!.centerY, width: 35, height: 44)
                    navbutton.titleLabel?.textAlignment = .left
                }else
                {
                    navbutton.frame = CGRect(x:(navigationBarView?.Width)! - 40, y:navigationBarView!.centerY - 7, width: 35, height: 44)
                    navbutton.titleLabel?.textAlignment = .right
                }
            }else
             {
                 if left{
                     navbutton.frame = CGRect(x:10, y:navigationBarView!.centerY, width: 35, height: 44)
                    navbutton.titleLabel?.textAlignment = .left
                }else
                 {
                    navbutton.frame = CGRect(x:(navigationBarView?.Width)! - 40, y:navigationBarView!.centerY, width: 35, height: 22)
                    navbutton.titleLabel?.textAlignment = NSTextAlignment.right
                }
            }
            if title == ""{
               navbutton.height = 30
            }
            
        }
        view.addSubview(navbutton)
    }
}
