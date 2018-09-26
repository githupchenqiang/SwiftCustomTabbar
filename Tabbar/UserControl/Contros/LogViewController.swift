//
//  LogViewController.swift
//  Tabbar
//
//  Created by chenq@kensence.com on 2018/4/12.
//  Copyright © 2018年 chenq@kensence.com. All rights reserved.
//

import UIKit
class LogViewController: BaseViewController {

    @IBOutlet weak var AccountText: UITextField!
    @IBOutlet weak var PassText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        NavTitle.text = "我的"
    
    }

    @IBAction func LogAction(_ sender: UIButton) {
//        let long_Param =

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
