# INOScrollView
学习swift, 模仿SDCycleScrollView写了一个swift

换了公司, 启动新项目, 刚好用一下swift, 
所以自己模仿了一个SDCycleScrollView的swift版, 最基础的功能应该有了, 后续在慢慢追加


####使用方法
```
init(scrollViewFrame frame: CGRect)
```
```
init(scrollViewFrame frame: CGRect, imageArray: [Any])
```
```
init(scrollViewFrame frame: CGRect, delegate: INOScrollViewDelegate, imageArray: [Any])
```
```
init(scrollViewFrame frame: CGRect, delegate: INOScrollViewDelegate, placeholderImage: UIImage, imageArray: [Any]) 
```

可定制属性
```
//滚动方向
var scrollDirection: UICollectionViewScrollDirection = .horizontal

/// 默认图片
var placeholder: 

/// 是否自动滚动 默认true
var autoScroll = true

/// 自动滚动间隔时间 默认2s
var autoScrollTimerInterval: TimeInterval = 2.0

/// 是否无限轮播 默认true
var infiniteCycle: Bool = true

/// 底部文字数组
var titleArray: [String]?

/// 图片数组 内存URL String 图片
var imageArray: [Any]? 


/// 是否显示小圆点
var showPageDot: Bool = true 

/// 小圆点的背景图片
var pageDotImage:Any?

/// 当前小圆点的背景图片
var currentPageDotImage:Any?

/// 小圆点颜色
var pageDotColor: UIColor = UIColor.white

/// 当前小圆点颜色
var currentDotColor: UIColor = UIColor(white: 1, alpha: 0.5)

/// 小白点的位置
var pageControlAliment: INOScrollViewPageAliment?

/// 是否显示Label
var showTextLabel: Bool = false 

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
```



