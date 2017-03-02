## 卡片布局，支持水平、垂直滚动。OC版本请[点击这里](https://github.com/Pr-Chen/CardLayout-OC)
![](https://ww3.sinaimg.cn/large/006tNbRwly1fd8xu377fng305k09vdo5.gif)
![](https://ww2.sinaimg.cn/large/006tNbRwly1fd8xu51jf4g305k09vq9x.gif)
![](https://ww4.sinaimg.cn/large/006tNbRwly1fd8xug0iejg305k09vdu7.gif)
![](https://ww4.sinaimg.cn/large/006tNbRwly1fd8xuimwh4g305k09vn64.gif)

## 用法简单
```swift
let layout = CardLayout()
let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
```

## 可以设置的属性
```swift
//cell的尺寸
var itemSize: CGSize

//cell间距
var spacing: CGFloat

//缩放率
var scale: CGFloat

//边距
var edgeInset: UIEdgeInsets

//滚动方向
var scrollDirection: UICollectionViewScrollDirection

```
