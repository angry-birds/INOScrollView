//
//  INOScrollView.swift
//  StaffSigning
//
//  Created by angrybirds on 2017/4/6.
//  Copyright © 2017年 YuanMedia. All rights reserved.
//

import UIKit
import Kingfisher


enum INOScrollViewPageAliment {
    case center
    case right
}


protocol INOScrollViewDelegate {
    
    ///点击图片回调
    func scrollView(_ scrollView :INOScrollView, didSelectItemAtIndex index:Int)
    
}





class INOScrollView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {

    private let kIdentifier = "INOScrollViewCell"
    
    /*************** 私有属性 ***********************/
    
    ///

    
    /// timer
    var timer: Timer?
    
    /// 主视图
    private var mainView: UICollectionView!
    
    /// UICollectionViewFlowLayout
    private let flowLayout = UICollectionViewFlowLayout()
    
    /// 小圆点
    private var pageControl: UIPageControl!
    
    /// delegate
    var inoScrollViewDelegate: INOScrollViewDelegate?
    
    /*************** 可定制借口 ***********************/
    
    ///
    
    //滚动方向
    var scrollDirection: UICollectionViewScrollDirection = .horizontal {
        didSet{
            self.flowLayout.scrollDirection = scrollDirection
        }
    }
    
    /// 默认图片
    var placeholder: UIImage?
    
    /// 是否自动滚动 默认true
    var autoScroll = true {
        didSet{
            if self.autoScroll == true {
                
                if imageArray != nil {
                    resetTimer()
                    mainView.scrollToItem(at: IndexPath.init(row: 1, section: 0), at: UICollectionViewScrollPosition.init(rawValue: 0), animated: false)
                }
                
            }else{
                invalidTimer()
            }
            
            //根据数量和对齐方式 设置小圆点
            
            
            
        }
    }
    
    /// 自动滚动间隔时间 默认2s
    var autoScrollTimerInterval: TimeInterval = 2.0{
        
        didSet{
            
            resetTimer()
        }
    }
    
    
    /// 是否无限轮播 默认true
    var infiniteCycle: Bool = true
    
    /// 底部文字数组
    var titleArray: [String]?
    
    /// 图片数组 内存URL String 图片
    var imageArray: [Any]? {
        didSet{
            
            guard let tempArray = self.imageArray else {
                return
            }
            
            guard tempArray.count > 1 else {
                autoScroll = false
                return
            }
            
            pageControl.numberOfPages = self.imageArray!.count
            pageControl.currentPage = 0
            
            setPageDotAliment()
            
            self.imageArray!.insert(tempArray.last as Any, at: 0)
            self.imageArray!.append(tempArray.first!)
            
            resetTimer()
            mainView.reloadData()
            
            mainView.scrollToItem(at: IndexPath.init(row: 1, section: 0), at: UICollectionViewScrollPosition.init(rawValue: 0), animated: false)
            
        }
        
    }
    
    
    /// 是否显示小圆点
    var showPageDot: Bool = true {
        
        didSet{
            
            if showPageDot {
                self.pageControl.isHidden = false
            } else {
                self.pageControl.isHidden = true
            }
        }

    }
    
    /// 小圆点的背景图片
    var pageDotImage:Any?
    
    /// 当前小圆点的背景图片
    var currentPageDotImage:Any?
    
    /// 小圆点颜色
    var pageDotColor: UIColor = UIColor.white
    
    /// 当前小圆点颜色
    var currentDotColor: UIColor = UIColor(white: 1, alpha: 0.5)
    
    /// 小白点的位置
    var pageControlAliment: INOScrollViewPageAliment?{
        
        didSet{
            if pageControlAliment == .center {
                pageControl.contentHorizontalAlignment = .center
            }else{
                pageControl.contentHorizontalAlignment = .right
            }
            
            setPageDotAliment()
        }
    }
    
    /// 是否显示Label
    var showTextLabel: Bool = false {
        
        didSet{
            guard showTextLabel && showPageDot else{
                return
            }
            
            pageControlAliment = .right
        }
        
    }
    
    /// 文本框的高度
    var titleLabelHeight: CGFloat = 30
    
    /// 文字的大小
    var titleLabelFont: UIFont = UIFont.systemFont(ofSize: 14)
    
    /// Label的颜色
    var titleLabelColor: UIColor = UIColor(red: 50/255.0, green: 50/255.0, blue: 50/255.0, alpha: 0.5)
    
    /// 文字的颜色
    var titleLabelTextColor: UIColor = UIColor.white

    /// 图片的ContentModel
    var INOScrollViewContentMode: UIViewContentMode = .scaleAspectFill
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        superview?.layoutSubviews()
        superview?.layoutIfNeeded()
        setupViews()
        
    }
    
    
    convenience init(scrollViewFrame frame: CGRect, delegate: INOScrollViewDelegate, placeholderImage: UIImage, imageArray: [Any]) {
        self.init(frame: frame)
        
        self.imageArray = imageArray
        self.inoScrollViewDelegate = delegate
        self.placeholder = placeholderImage
        
    }
    
    convenience init(scrollViewFrame frame: CGRect, delegate: INOScrollViewDelegate, imageArray: [Any]){
        self.init(frame: frame)
        
        self.imageArray = imageArray
        self.inoScrollViewDelegate = delegate
        
    }
    
    convenience init(scrollViewFrame frame: CGRect, imageArray: [Any]){
        self.init(frame: frame)
        self.imageArray = imageArray
        
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        if newSuperview == nil {
            timer?.invalidate()
        }
        
    }
    
    
    /// 加载视图
    private func setupViews() {
        
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = size
        
        mainView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: width, height: height), collectionViewLayout: flowLayout)
        mainView.backgroundColor = UIColor.clear
        mainView.isPagingEnabled = true
        mainView.showsVerticalScrollIndicator = false
        mainView.showsHorizontalScrollIndicator = false
        mainView.register(INOScrollViewCell.self, forCellWithReuseIdentifier: kIdentifier)
        mainView.delegate = self
        mainView.dataSource = self
        addSubview(mainView!)
        
        
        pageControl = UIPageControl(frame: CGRect.init(x: 0.0, y: height - 30.0, width: width, height: 30.0))
        pageControl.isUserInteractionEnabled = false
        pageControl.pageIndicatorTintColor = pageDotColor
        pageControl.currentPageIndicatorTintColor = currentDotColor
//        pageControl.addTarget(self, action: #selector(pageChanged(sender:)), for: .valueChanged)
        addSubview(pageControl!)
        
        autoScroll = true
        
    }
    
    
    // MARK: - UICollecionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var index = 0
        
        if indexPath.row == 0 {
            index = imageArray!.count - 2
        } else if indexPath.row == imageArray!.count - 1{
            index = 1
        }else{
            index = indexPath.row - 1
        }
        
        inoScrollViewDelegate?.scrollView(self, didSelectItemAtIndex: index)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let array = imageArray {
            return array.count
        }
        
        return 0
    }
    
    
    
    
    // MARK: - UICollecionViewDataSource
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kIdentifier, for: indexPath) as! INOScrollViewCell
        cell.showTextLabel = showTextLabel
        cell.titleLabelHeight = titleLabelHeight
        cell.titleLabelFont = titleLabelFont
        cell.titleLabelColor = titleLabelColor
        cell.titleLabelTextColor = titleLabelTextColor
        cell.INOScrollViewContentMode = INOScrollViewContentMode
        
        print(cell.titleLabel.frame)
        
        let item = imageArray![indexPath.row] as Any

        if item is UIImage {
            cell.imageView.image = (item as! UIImage)
        }else {
            
            var url: URL?
            
            if item is URL {
                url = (item as! URL)
            }else if item is String{
                url = URL.init(string: item as! String)
            }
            
            cell.imageView.kf.setImage(with: url, placeholder: placeholder, options: [.cacheMemoryOnly], progressBlock: { (receive, total) in
                
            }, completionHandler: { (image, error, cacheType, imageURL) in
                
            })
        }
        
        
        //设置label字体
        
        guard showTextLabel else {
            return cell
        }
        
        guard titleArray != nil else {
            return cell
        }
        
        var index = 0
        
        if indexPath.row == 0 {
            index = imageArray!.count - 2
        } else if indexPath.row == imageArray!.count - 1 {
           index = 1
        }else{
            index = indexPath.row - 1
        }
        
        if titleArray!.count > index {
            cell.titleLabel.text = titleArray![index]
            cell.titleLabel.isHidden = false
        }else{
            cell.titleLabel.isHidden = true
        }
        
        return cell;
        
    }
    
    // MARK: - UIScrollViewDelegate
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if autoScroll {
            invalidTimer()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if autoScroll {
            setupTimer()
        }
        
        var index = getCurrentPage()
        
        if index == imageArray!.count - 1 {
            index = 1
            
            let delay = DispatchTime.now()
            
            DispatchQueue.main.asyncAfter(deadline: delay, execute: {
                self.mainView.scrollToItem(at: IndexPath.init(row: index, section: 0), at: UICollectionViewScrollPosition(rawValue: 0), animated: false)
            })
        }
        
        if index == 0 {
            
            index = imageArray!.count - 2
            
            let delay = DispatchTime.now()
            
            DispatchQueue.main.asyncAfter(deadline: delay, execute: {
                self.mainView.scrollToItem(at: IndexPath.init(row: index, section: 0), at: UICollectionViewScrollPosition(rawValue: 0), animated: false)
            })
        }
        
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = getCurrentPage()
        
        if index == 0 {
            pageControl.currentPage = imageArray!.count - 2
        } else if index == imageArray!.count {
            pageControl.currentPage = 1
        } else {
            pageControl.currentPage = index - 1
        }
        
        
//        if index == imageArray!.count - 1 {
//            index = 1
//            
//            let delay = DispatchTime.now()
//            DispatchQueue.main.asyncAfter(deadline: delay, execute: {
//                self.mainView.scrollToItem(at: IndexPath.init(row: index, section: 0), at: UICollectionViewScrollPosition(rawValue: 0), animated: false)
//            })
//        }

        
    }
    
    
    
    
    
    // MARK: - PrivateMethod
    
    
    private func resetTimer() {
     
        invalidTimer()
        setupTimer()
        
    }
    
    private func invalidTimer() {
        
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    
    private func setupTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: autoScrollTimerInterval, target: self, selector: #selector(scrollIndex), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .commonModes)
    }
    
    
    /// 滚动到下一页
    @objc private func scrollIndex() {
    
        var index = getCurrentPage()
       
        mainView.scrollToItem(at: IndexPath.init(row: index+1, section: 0), at: UICollectionViewScrollPosition(rawValue: 0), animated: true)
        
        if index + 1 == imageArray!.count - 1 {
            index = 1

            let delay = DispatchTime.now() + .milliseconds(500)
            
            DispatchQueue.main.asyncAfter(deadline: delay, execute: {
                self.mainView.scrollToItem(at: IndexPath.init(row: index, section: 0), at: UICollectionViewScrollPosition(rawValue: 0), animated: false)
            })
        
            
        }
    }
    
    /// 获取当前页码
    ///
    /// - Returns: 当前页码
    func getCurrentPage() -> Int {
        
        var index = 0
        
        if flowLayout.scrollDirection == .horizontal {
            index = Int((mainView.contentOffset.x + flowLayout.itemSize.width * 0.5) / flowLayout.itemSize.width)
        }else {
            index = Int((mainView.contentOffset.y + flowLayout.itemSize.height * 0.5) / flowLayout.itemSize.height)
        }

        return index
    }
    
    
    func setPageDotAliment() {
        
        if imageArray != nil {
            
            let size = pageControl.size(forNumberOfPages: pageControl.numberOfPages)
            
            let center = pageControl.center
            pageControl.frame = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
            
            if pageControlAliment == .center {
                pageControl.center = center
            } else if pageControlAliment == .right {
                pageControl.center = CGPoint.init(x: width - size.width/2 - 16 , y: center.y)
            }else{
                pageControl.center = center
            }
        }
    }
}



// MARK: - INOScrollView 拓展属性
private extension INOScrollView {
    
    var height: CGFloat {
        return frame.size.height
    }
    
    var width: CGFloat {
        return frame.size.width
    }
    
    var size: CGSize {
        return frame.size
    }
    
}
