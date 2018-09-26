//
//  SortViewController.swift
//  Tabbar
//
//  Created by chenq@kensence.com on 2018/4/28.
//  Copyright © 2018年 chenq@kensence.com. All rights reserved.
//

import UIKit

class SortViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBarView?.backgroundColor = graybackColor
        self.NavTitle.text = "分类"
        NavigationViewLeft(imageString: "返回", title: "", target: self, action: #selector(backAction), left: true, isBottom: false)
    }
     @objc func backAction(){
        navigationController?.popViewController(animated: true)
    }
}

