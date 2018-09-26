//
//  cq_CustomNavigationBar.swift
//  Tabbar
//
//  Created by chenq@kensence.com on 2018/3/28.
//  Copyright © 2018年 chenq@kensence.com. All rights reserved.
//

import UIKit

class cq_CustomNavigationBar: UINavigationBar {

    override func layoutSubviews() {
        super.layoutSubviews()
        if #available(iOS 11, *) {
            self.layoutMargins = UIEdgeInsets.zero
            for subview in self.subviews{
                if NSStringFromClass(subview.superclass!).contains("ContentView"){
                  subview.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
                }
            }
        }
    }

}
