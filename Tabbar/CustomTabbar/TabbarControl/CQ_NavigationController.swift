//
//  CQ_NavigationController.swift
//  Tabbar
//
//  Created by chenq@kensence.com on 2018/3/16.
//  Copyright © 2018年 chenq@kensence.com. All rights reserved.
//

import UIKit

class ScreenShotView: UIView {
    var imageView: UIImageView?
    var maskViews: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView = UIImageView(frame: SCREEN_BOUNDS)
        addSubview(imageView!)
        maskViews = UIView(frame: SCREEN_BOUNDS)
        maskViews?.backgroundColor = UIColor.clear
        addSubview(maskViews!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension UIViewController{
    func cq_prefersNavigationBarHiden() -> Bool {
        return (objc_getAssociatedObject(self, "key") != nil)
    }
    
    func set_perfersNavigationBarHiden(){
//        objc_setAssociatedObject(self, #selector(cq_prefersNavigationBarHiden), @(hiden), OBJC_ASSOCIATION_RETAIN)
    }
}

class CQ_NavigationController: UINavigationController {
    
    enum FullScreenpopGestureStyle {
        case FullscreenPopGestureGradientStyle   // 根据滑动偏移量背景颜色渐变
        case FullscreenPopGestureShadowStyle      // 侧边阴影效果，类似系统的滑动样式
    }
    
    ///影藏NavigationBar
    var cq_perfersNavigationBarHiden:Bool?
    ///关闭某个控制器的pop手势
    var cq_interactivePopdisabled:Bool?
    ///自定义的滑动返回手势是否与其他手势共存,默认不予其他手势共存
    var cq_recognizeSimultanEnbable:Bool?
    ///返回样式
    var popGestureType:FullScreenpopGestureStyle?
    
    
    var PopDelegate:Any?
    override func viewDidLoad() {
        super.viewDidLoad()
        let appearance = UINavigationBar.appearance()
        let att = NSMutableDictionary()
        att[NSFontAttributeName] = UIFont.systemFont(ofSize: 20)
        att[NSForegroundColorAttributeName] = UIColor.yellow
        appearance.titleTextAttributes = att as? [String : Any]
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        
        //设置导航条的背景
//        appearance .setBackgroundImage(UIImage.ima, for: .defaultPrompt)
        //设置文字
        appearance.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white,NSFontAttributeName:UIFont(name:"Heiti SC" ,size:16)!]
        navigationController?.navigationItem.backBarButtonItem?.tintColor = UIColor.red
        PopDelegate = interactivePopGestureRecognizer?.delegate
        self.delegate = self
        navigationBar.barStyle = UIBarStyle.black
        navigationBar.shadowImage = UIImage()
//        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationBar.isHidden = true
        navigationBar.isTranslucent = false;
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            let BarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
            BarButtonItem.width = 0
            //设置导航栏按钮
            let backButton = UIBarButtonItem.SetButtonItemImage(ImageName:"navigationbar_back_image", hightImage: "navigationbar_back_image",target: self, action:#selector(back))
            viewController.navigationItem.leftBarButtonItems = [BarButtonItem,backButton]
            self.interactivePopGestureRecognizer?.delegate = nil
            
        }
         super.pushViewController(viewController, animated: animated)
    }

    func back(){
    self.popViewController(animated: true)
    }
   
}


extension CQ_NavigationController:UINavigationControllerDelegate{
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if viewController == viewControllers.first {
            self.interactivePopGestureRecognizer?.delegate = PopDelegate as? UIGestureRecognizerDelegate
        }
    }
}

extension UIBarButtonItem {
    class func SetButtonItemImage(ImageName:NSString,hightImage:NSString,target:Any?, action:Selector) -> UIBarButtonItem {
        let button = UIButton.init()
        //设置背景图片
        
        button.setBackgroundImage(UIImage(named: ImageName as String), for: .normal)
        if hightImage.length > 0 {
            button.setBackgroundImage(UIImage(named: hightImage as String), for: .highlighted)
        }
        
        //设置按钮的尺寸为背景图片的尺寸
        button.frame.size = (button.currentBackgroundImage?.size)!
        button.adjustsImageWhenHighlighted = false
//
        //监听按钮的点击
        button.addTarget(target, action: action, for: .touchUpInside)
        return UIBarButtonItem.init(customView: button)
        
    }
 
}

extension CQ_NavigationController:UIGestureRecognizerDelegate{
    
    
}


