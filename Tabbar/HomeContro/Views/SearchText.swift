//
//  SearchText.swift
//  Tabbar
//
//  Created by chenq@kensence.com on 2018/3/27.
//  Copyright © 2018年 chenq@kensence.com. All rights reserved.
//

import UIKit

typealias SearchBlock = ()->()

class SearchText: UIView {
    var label:UILabel?
    var Block:SearchBlock?
    init(frame: CGRect,block:@escaping SearchBlock) {
        super.init(frame: frame)
        self.Block = block
        self.backgroundColor = .white
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = true
        label = UILabel(frame: CGRect(x: 0, y: 0, width:10, height: 20))
        label?.text = "草莓"
        label?.sizeToFit()
        label?.font = UIFont.systemFont(ofSize: 12)
        label?.centerX = centerX + 15
        self.addSubview(label!)
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.image = UIImage(named: "搜索 (1)")
        imageView.centerX = self.centerX - 15
        if IS_iPhoneX == 1 {
            imageView.centerY  = CGFloat(NavigationBarHeight / 2) - self.height / 2 - 10
            label?.centerY = CGFloat(NavigationBarHeight / 2) - self.height / 2 - 10
        }else
        {
            imageView.centerY  = CGFloat(NavigationBarHeight / 2) - self.height / 2;
            label?.centerY = CGFloat(NavigationBarHeight / 2) - self.height / 2
        }
        self.addSubview(imageView)
        let tap = UITapGestureRecognizer(target: self, action: #selector(jump))
        addGestureRecognizer(tap)
    }
    
    func jump() {
        if (Block != nil) {
            Block!()
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
