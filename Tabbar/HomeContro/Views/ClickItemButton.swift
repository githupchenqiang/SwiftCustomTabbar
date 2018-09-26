//
//  ClickItemButton.swift
//  Tabbar
//
//  Created by chenq@kensence.com on 2018/3/27.
//  Copyright © 2018年 chenq@kensence.com. All rights reserved.
//

import UIKit

typealias clickAction = ()->()


class ClickItemButton: UIButton {
    /// 图片是否靠左侧显示
    var Isleft = true
    var block:clickAction?
    
    
    init(frame: CGRect,image:UIImage,title:String,isleft:Bool,target:Any,action:Selector) {
        super.init(frame: frame)
        Isleft = isleft
        setTitleColor(.black, for: .normal)
        self.addTarget(target, action: action, for: .touchUpInside)
        setImage(image, for: UIControlState.normal)
        setTitle(title, for: .normal)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if Isleft {
            self.titleLabel?.height = 10
            self.titleLabel?.font = UIFont.systemFont(ofSize: 9)
            self.titleLabel?.x = 0
            
            self.titleLabel?.y = self.height - 12
            
            self.imageView?.y = 0
            self.imageView?.Width = 18
            self.imageView?.height = 18
            self.imageView?.x = 0
        }else
        {
            self.titleLabel?.height = 10
            self.titleLabel?.font = UIFont.systemFont(ofSize: 9)
            self.titleLabel?.x = self.centerX*2 - 18
            self.titleLabel?.y = self.height - 12
            
            self.imageView?.y = 0
            self.imageView?.Width = 18
            self.imageView?.height = 18
            self.imageView?.x = self.centerX*2 - 18
            
        }
  
    }
   
}
