//
//  SearchViewController.swift
//  Tabbar
//
//  Created by chenq@kensence.com on 2018/3/28.
//  Copyright © 2018年 chenq@kensence.com. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController {
    var textV:SearchTextView?
    var textview:SearchTextView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textV?.textfield.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor =  graybackColor
        view.backgroundColor = graybackColor
        addSearchView()
        
        self.navigationBarView?.backgroundColor = .red
    }

    /// 添加搜索视图
    private func addSearchView(){
        if IS_iPhoneX == 1 {
            textview = SearchTextView(frame: CGRect(x: 10, y: Int(TabbarSafeBottomMargin+44)/2, width: Int(ScreenW - 60), height: 32))
        }else
        {
            textview = SearchTextView(frame: CGRect(x: 10, y: Int(TabbarSafeBottomMargin+44)/2 + 4, width: Int(ScreenW - 60), height: 32))
        }
        
        NavigationViewLeft(imageString:"1", title: "取消", target: self, action: #selector(DismissControl), left: false, isBottom: false)
        navigationBarView?.addSubview(textview)
        textV = textview
    }
    
   func DismissControl() {
        self.navigationController?.popViewController(animated: true)
    }
   
    deinit {
        print("销毁了")
    }

}
