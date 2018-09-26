//
//  DetailViewController.swift
//  Tabbar
//
//  Created by chenq@kensence.com on 2018/3/20.
//  Copyright © 2018年 chenq@kensence.com. All rights reserved.
//

import UIKit
import SnapKit

typealias Detailblock = (_ parameValue:String?)->()

class DetailViewController: BaseViewController {
    var block:Detailblock?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
 
        let Backview = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0 ))
        Backview.backgroundColor = UIColor.red
        self.view.addSubview(Backview)
        
        Backview.snp.makeConstraints { (make) in
            make.width.height.equalTo(50)
            make.left.equalTo(30)
            make.top.equalTo(100)
        }
        
        
        
}
  
    override func viewWillDisappear(_ animated: Bool) {
        if (block != nil) {
            block!("1233")
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.barView?.backgroundColor = UIColor.red
    }
    
}
