//
//  QrCodeViewController.swift
//  Tabbar
//
//  Created by chenq@kensence.com on 2018/3/28.
//  Copyright © 2018年 chenq@kensence.com. All rights reserved.
//

import UIKit
import AVFoundation

class QrCodeViewController: UIViewController {
    private var device: AVCaptureDevice!
    private var input: AVCaptureInput!
    private var output: AVCaptureMetadataOutput!
    private var session: AVCaptureSession!
    private var preview: AVCaptureVideoPreviewLayer!

    @IBOutlet weak var BottomImage: UIImageView!
    @IBOutlet weak var MoveingImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
    }

    func chaeckAuthor() -> Bool{
        let is_Author = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
        if  is_Author == AVAuthorizationStatus.authorized || is_Author == AVAuthorizationStatus.notDetermined {
            return true
        }else
        {
            return false
        }
        
    }
    
    deinit {
        print("这个销毁了")
    }

}
