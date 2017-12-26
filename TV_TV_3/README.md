# 可上下左右滚动的View #

**	住ViewController是一个UITableView，cell包含一个UICollectionView，UICollectionView中的每个cell，放子ViewController的view。
	cell的宽度比屏幕窄，在UICollectionView中的cell左右滑动时，根据滑动距离计算子ViewController的view的缩放比例，达到滚动的效果。
	折叠效果：第一层放一个View-A，获得View内容的高度，可设置contentInset，给tableView顶部插入额外的滚动区域,用来显示头部视图，UITableView滚动的时候，再更新View-A的位置。
	
	- (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent \*)event 
	- 方法可判断下传入过来的点在不在方法调用者的坐标系上，将TableView的顶部滚动区域不接受事件。**
