//
//  Public.swift
//  Tabbar
//
//  Created by chenq@kensence.com on 2018/3/17.
//  Copyright © 2018年 chenq@kensence.com. All rights reserved.
//

import Foundation
import UIKit
public let ScreenW = UIScreen.main.bounds.size.width
public let ScreenH = UIScreen.main.bounds.size.height

//status bar height.
public let statusBarHeight = (IS_iPhoneX == 1 ? 44 : 20)

// Tabbar height.
public let TabbarHeight = (IS_iPhoneX == 1 ? (49 + 34) : 49)

// Tabbar safe bottom margin.
public let TabbarSafeBottomMargin = IS_iPhoneX == 1 ? 34 : 0

// Status bar & navigation bar height.
public let NavigationBarHeight = IS_iPhoneX == 1 ? 88 : 64
//判断是否iPhone X
public let IS_iPhoneX  =  UIScreen.main.bounds.size.height >=  812 ? 1:0

public let graybackColor = UIColor.init(hexString: "#F3F5F9")

public let yellowMainNavColor = UIColor.init(hexString: "#FFDA44")

public let graySearchColor = UIColor.init(hexString: "#A2A2A6")

public let blackTitle = UIColor.init(hexString: "#191919")

public let APP_WINDOW = UIApplication.shared.delegate?.window
public let SCREEN_WIDTH = UIScreen.main.bounds.width
public let SCREEN_BOUNDS = UIScreen.main.bounds

///滑动偏移量临界值
public let MAX_PAN_DISTANCE = 150
///在某范围内允许滑动手势，默认全屏
public let PAN_ENABLE_DISTANCE = SCREEN_WIDTH
