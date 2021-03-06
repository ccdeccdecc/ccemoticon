//
//  CCEmoticonViewController.swift
//  表情键盘
//
//  Created by apple on 15/11/8.
//  Copyright © 2015年 eason. All rights reserved.
//

import UIKit

class CCEmoticonViewController: UIViewController {
    
    //MARK: -属性
    private var collectionViewCellIdentifier = "collectionViewCellIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()

//        view.backgroundColor = UIColor.cyanColor()
        
        prepareUI()
    }
    
    //MARK: - 准备UI
    func prepareUI() {
        //添加子控件
        view.addSubview(collectionView)
        view.addSubview(toolbarView)
        
        //添加约束
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        toolbarView.translatesAutoresizingMaskIntoConstraints = false
        
        let views = ["cv" : collectionView, "tb" : toolbarView]
        //conllectionView水平方向
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[cv]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        //toolbarView
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[tb]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        //垂直方向
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[cv]-[tb(44)]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
        setupToolBar()
        setupCollectionView()
    }
    ///设置toolBar
    private func setupToolBar() {
        var items = [UIBarButtonItem]()
        for name in ["最近", "默认", "emoji", "浪小花"] {
            let button = UIButton()
            //设置标题
            button.setTitle(name, forState: UIControlState.Normal)
            //设置颜色
            button.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
            button.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Highlighted)
            button.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Selected)
            
            button.sizeToFit()
            
            //创建barbuttonitem
            let item = UIBarButtonItem(customView: button)
            items.append(item)
            //添加弹簧
            items.append(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil))
        }
        //移除最后一个多有的弹簧
        items.removeLast()
        toolbarView.items = items
    }
    
    ///设置collectionView
    private func setupCollectionView() {
        collectionView.dataSource = self
        
        //注册cell
        collectionView.registerClass(CCEmoticonCell.self, forCellWithReuseIdentifier: collectionViewCellIdentifier)
    }

    //MARK: -懒加载
    private lazy var collectionView: UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: CCCollectionViewFlowLayout())
    
    private lazy var toolbarView = UIToolbar()

}

//MARK: - 扩展CCEmoticonViewController 实现 UICollectionViewDataSource 协议
extension CCEmoticonViewController: UICollectionViewDataSource {
    //返回cell的数量
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 21 * 2
    }
    //返回cell
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(collectionViewCellIdentifier, forIndexPath: indexPath) as! CCEmoticonCell
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }

}

//MARK: - 自定义表情cell
class CCEmoticonCell: UICollectionViewCell {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        prepareUI()
    }

    //MARK: - 准备UI
    private func prepareUI() {
        //添加子控件
        contentView.addSubview(emoticonButton)
        //设置frame
        emoticonButton.frame = CGRectInset(bounds, 4, 4)
        emoticonButton.backgroundColor = UIColor.cyanColor()
        
    }
    //MARK: - 懒加载
    ///表情按钮
    private lazy var emoticonButton: UIButton = UIButton()
}

//MARK: - 继承流水布局
///在collectionView布局之前设置layout的参数
class CCCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func prepareLayout() {
        super.prepareLayout()
        //item宽度
        let width = collectionView!.frame.width / 7.0
        let height = collectionView!.frame.height / 3.0
        itemSize = CGSize(width: width, height: height)
        //滚动方向
        scrollDirection = UICollectionViewScrollDirection.Horizontal
        //间距
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        
        //取消弹簧效果
        collectionView?.bounces = false 
        collectionView?.alwaysBounceHorizontal = false
        collectionView?.showsHorizontalScrollIndicator = false
        
        //分页显示
        collectionView?.pagingEnabled = true
    }
}


