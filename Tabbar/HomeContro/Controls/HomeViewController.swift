//
//  HomeViewController.swift
//  Tabbar
//
//  Created by chenq@kensence.com on 2018/3/16.
//  Copyright © 2018年 chenq@kensence.com. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    fileprivate var FishCellID = "FreeFish"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.init(hexString:"#FFDA44")
        self.automaticallyAdjustsScrollViewInsets = false
        title = "首页"
        
        setNavigationBar()
        view.addSubview(FreeFishTableView)
        let imageA = [
            "http://ygjkclass.com/pdres/ext_images/banner1.png",
            "http://ygjkclass.com/pdres/ext_images/banner3.png",
            "http://ygjkclass.com/pdres/ext_images/banner2.png",
            "http://ygjkclass.com/pdres/ext_images/tnb-2.png",
            "http://ygjkclass.com/pdres/ext_images/shimian-1.jpg"]
        
        let titleArray = ["第一张图片","第二张图片","第三张图片","第四张图片","第五张图片"]
        
        let scroller = CQScrollerPageView(frame: CGRect(x:0,y:0,width:ScreenW,height:150), images: imageA as NSArray,titles:titleArray)
        scroller.delegate = self
        FreeFishTableView.tableHeaderView?.addSubview(scroller)
//        view.addSubview(CollectionView);
//        laodData(page: 1)
//        CollectionView.reloadData()
        
//       let moneyArray = [10,20,30,40]
//
//        let stringArray = moneyArray.map {
//          print($0)
//        }
        
        NetWorkRequest.sharedInstance.getRequest(UrlString:BaseUrl, params:nil, success: { (response) in
            print(response)
        }) { (error) in
            
        }
        
        getPropertyList()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    ///设置navigationitemView
    func setNavigationBar(){
        self.NavigationViewLeft(imageString: "扫码", title: "扫码", target: self, action: #selector(leftAction),left:true,isBottom:true)
        self.NavigationViewLeft(imageString: "分类", title: "分类", target: self, action: #selector(RightAction),left:false,isBottom:true)
        let Titleview = UIView(frame: CGRect(x: 50, y: 6, width:ScreenW - 100, height: 32))
        self.navigationBar!.addSubview(Titleview)
        let searchBar = SearchText(frame: CGRect(x:0, y:0, width:ScreenW - 100, height: 32)) {
            let searchControl = SearchViewController()
              let nav  = CQ_NavigationController(navigationBarClass: cq_CustomNavigationBar.classForCoder(), toolbarClass: nil)
            nav.setViewControllers([searchControl], animated: false)
          self.navigationController?.pushViewController(searchControl, animated: true)
        }
        Titleview.addSubview(searchBar)
    }
    
    ///左边按钮的点击事件
    func leftAction(){
      let QrCodeVC = QrCodeViewController()
        navigationController?.pushViewController(QrCodeVC, animated: true)
    }
    
    ///右边按钮的点击事件
    func RightAction(){
       
    }
   
    func laodData(page:NSInteger){
        self.shopsArray = PublicSource.getBundleData(pathName: "1")
    }
    
    lazy var shopsArray: NSMutableArray = {
        let shop = NSMutableArray()
        return shop
    }()

    
    lazy var CollectionView:UICollectionView = {
        let layout:cqWaterFlowLayout = cqWaterFlowLayout()
        layout.delegate = self
        let collection = UICollectionView(frame:CGRect(x:self.view.x, y:self.view.y, width:self.view.frame.size.width,height:self.view.frame.size.height), collectionViewLayout: layout)
        collection.backgroundColor = UIColor.white
        collection.register(UINib.init(nibName: "ShopsCell", bundle: nil), forCellWithReuseIdentifier: "shops")
        collection.dataSource = self
        collection.delegate = self;
        return collection;
    }()
    
    
    lazy var FreeFishTableView:UITableView = {
        let table = UITableView(frame: CGRect(x:self.view.x, y:self.view.y,width:self.view.frame.size.width,height:self.view.frame.size.height), style: .plain)
        table.register(UINib.init(nibName: "FreeFishTableViewCell", bundle: nil), forCellReuseIdentifier:"FreeFish")
        let View = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 300))
        View.backgroundColor = UIColor.red
        table.tableHeaderView = View
        table.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 0.001))
        table.delegate = self
        table.dataSource = self
        
        return table
    }()
    
    
    
    func getPropertyList() {
        var count:UInt32 = 0
        let ivars = class_copyMethodList(HomeViewController.self, &count)
        for i in 0..<Int(count) {
            let ivar = ivars?[i]
            if ivar != nil {
//                let tempName/ = String(cString:method_getName(ivar!))
                
                print("方法名:\(NSStringFromSelector(method_getName(ivar)))")
            }
        
        }
        free(ivars)
    }
}

extension HomeViewController:UITableViewDelegate,UITableViewDataSource,CQScrollerPageViewDelegate{
   
    func ScrollerPageDidSelectedAtIndex(Index: Int) {
        print(Index)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"FreeFish" , for: indexPath)
        return cell
    }
    
    
    
}



extension HomeViewController:UICollectionViewDataSource,cqWaterFlowLayoutDelegate,UICollectionViewDelegate{
    
    //返回的是item的高度
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shopsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:ShopsCell = CollectionView.dequeueReusableCell(withReuseIdentifier: "shops", for: indexPath) as! ShopsCell
        let model:Source = shopsArray[indexPath.row] as! Source
        cell.setShopsData(shop: model)
        return cell
    }
    ///item列数
    func columnCountInWaterflowLayout(waterflowLayout: cqWaterFlowLayout) -> CGFloat {
        return 3
    }
    
    func waterflowLayout(waterflowLayout: cqWaterFlowLayout, heightForItemIndex: NSInteger, itemWidth: CGFloat) -> CGFloat {
        let model:Source = shopsArray[heightForItemIndex] as! Source
        
        return itemWidth * model.h! / model.w!
    }
    ///item左右间距
    func columnMarginInWaterflowLayout(waterflowLayout: cqWaterFlowLayout) -> CGFloat {
        return 5
    }
    ///item上下的间距
    func rowMarginInWaterflowLayout(waterflowLayout: cqWaterFlowLayout) -> CGFloat {
        return 10;
    }
    ///layout距离边框的距离
    func edgeInsetsInWaterflowLayout(waterflowLayout: cqWaterFlowLayout) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 10, 10, 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detail = DetailViewController()
        detail.block = {(parameValue)->() in
            print(parameValue ?? String())
        }
        navigationController?.pushViewController(detail, animated: true)
    }
}
