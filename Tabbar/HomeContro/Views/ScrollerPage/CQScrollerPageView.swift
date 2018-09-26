//
//  CQScrollerPageView.swift
//  Tabbar
//
//  Created by chenq@kensence.com on 2018/5/4.
//  Copyright © 2018年 chenq@kensence.com. All rights reserved.
//

import UIKit

protocol CQScrollerPageViewDelegate {
    
   /// 传出当前点击的Index
   ///
   /// - Parameter Index: Int
   func ScrollerPageDidSelectedAtIndex(Index:Int)
}

class CQScrollerPageView: UIView {
    var itemsArray:NSMutableArray? //图片数组
    var pageControl:UIPageControl!
    var timer:Timer? //自动滚动的定时器
    var titleArray:Array<Any>! //标题数组
    var delegate:CQScrollerPageViewDelegate? //点击的ddelegate
    
    init(frame:CGRect,images:NSArray,titles:Array<Any>){
        super.init(frame: frame)
        self.backgroundColor = .white
        self.frame = frame
        
        titleArray = titles
        itemsArray = NSMutableArray.init(array: images)
        
        //将图片第一张和最后一张添加到数组中的首末位置
        itemsArray?.add(images.firstObject as Any)
        itemsArray?.insert(images.lastObject as Any, at: 0)
        
        self.addSubview(CollectionView)
        CollectionView.contentOffset = CGPoint(x:CollectionView.bounds.size.width, y:0);
        DreawViews()
        pageControl.numberOfPages = images.count;
        
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(Cycle), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: RunLoopMode.commonModes)
    }
    
   @objc func Cycle() {
    if CollectionView.isDragging {
        return
    }
    
    let targetX = CollectionView.contentOffset.x + CollectionView.bounds.size.width
    CollectionView.setContentOffset(CGPoint(x: targetX, y: 0), animated: true)
    
    }

    /// 懒加载Collection
    private lazy var CollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.bounds.size.width, height: self.bounds.size.height)
        layout.minimumLineSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal;
        let collec = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collec.backgroundColor = .white
        collec.showsHorizontalScrollIndicator = false
        collec.isPagingEnabled = true
        collec.register(UINib.init(nibName: "ScrollerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PageScroller")
        collec.delegate = self
        collec.dataSource = self
        return collec
    }()
    
    
    func DreawViews() {
        pageControl = UIPageControl(frame: CGRect(x: self.centerX, y: 0, width: 0, height: 0))
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.numberOfPages = (itemsArray?.count)!
        self.addSubview(pageControl!)
        pageControl.snp.makeConstraints { (make) in
            make.bottom.equalTo(0)
            make.height.equalTo(15)
            make.centerX.equalTo(self.centerX)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        cycleScroll()
        timer?.fireDate = NSDate(timeIntervalSinceNow: 3) as Date
    }
    
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        cycleScroll()
    }
    
    
    //滚动的事件处理
    func cycleScroll(){
        let page = CollectionView.contentOffset.x/CollectionView.bounds.size.width;
        if (page == 0) {//滚动到左边
            CollectionView.contentOffset = CGPoint(x:CollectionView.bounds.size.width * CGFloat(((itemsArray?.count)! - 2)),y:0);
            pageControl.currentPage = (itemsArray?.count)! - 2;
        }else if (page == CGFloat((itemsArray?.count)! - 1)){//滚动到右边
            CollectionView.contentOffset = CGPoint(x:CollectionView.bounds.size.width,y:0);
            pageControl.currentPage = 0;
        }else{
            pageControl.currentPage = Int(page) - 1;
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        guard let timer1 = self.timer
            else{ return }
        timer1.invalidate()
    }
    
}

extension CQScrollerPageView:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (itemsArray?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collec:ScrollerCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PageScroller", for: indexPath) as! ScrollerCollectionViewCell
        let url = URL(string:itemsArray![indexPath.row] as! String)
        collec.Image.kf.setImage(with: url)
        
        if indexPath.row >= 1 && indexPath.row <= ((itemsArray?.count)!-2){
            if (titleArray.count) > 0{
             collec.Title.text = (titleArray?[indexPath.row - 1] as! String)
            }
        }
        return collec
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        timer?.fireDate = NSDate(timeIntervalSinceNow: 3) as Date
        delegate?.ScrollerPageDidSelectedAtIndex(Index: indexPath.row - 1)
    }
}

