//
//  SearchTextView.swift
//  Tabbar
//
//  Created by chenq@kensence.com on 2018/3/28.
//  Copyright © 2018年 chenq@kensence.com. All rights reserved.
//

import UIKit

class SearchTextView: UIView {
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
       
        addSubview(imageView)
        addSubview(textfield)
        
    }
    
    lazy var imageView:UIImageView = {
        let imgView = UIImageView(frame: CGRect(x: 8, y:self.height / 2 - 10, width: 20, height: 20))
        imgView.image = UIImage(named: "搜索 (1)")
        return imgView
    }()
    lazy var textfield:UITextField = {
        let text = UITextField(frame:CGRect(x: 32, y: 0, width: self.frame.size.width - 40, height: self.frame.size.height))
        text.placeholder = "99草莓"
        return text
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
