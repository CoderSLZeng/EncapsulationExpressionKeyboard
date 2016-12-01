//
//  SLExpressionKeyboardViewController.swift
//  EncapsulationExpressionKeyboard
//
//  Created by Anthony on 16/11/30.
//  Copyright © 2016年 SLZeng. All rights reserved.
//  表情键盘控制器
//

import UIKit

class SLExpressionKeyboardViewController: UIViewController {

    //==========================================================================================================
    // MARK: - 懒加载
    //==========================================================================================================
    // 表情视图控件
    private lazy var collectionView : UICollectionView = {
        let clv = UICollectionView(frame: CGRectZero, collectionViewLayout: expressionKeyboardLayout())
        clv.dataSource = self
        clv.registerClass(SLExpressionKeyboardCell.self, forCellWithReuseIdentifier: "keyboardCell")
        return clv
    }()
    
    // 工具条视图空间
    private lazy var toolbar : UIToolbar = {
        let tb = UIToolbar()
        tb.tintColor = UIColor.lightGrayColor()
        
        var items = [UIBarButtonItem]()
        var index = 0
        
        for title in ["最近", "默认", "Emoji", "浪小花"]
        {
            // 1.创建标题item
            let item = UIBarButtonItem(title: title, style: UIBarButtonItemStyle.Plain, target: self, action: #selector(SLExpressionKeyboardViewController.itemClick(_:)))
            item.tag = index
            index += 1
            items.append(item)
            
            // 2.创建间隙item
            let spaceItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
            items.append(spaceItem)
        }
        // 3.删除最后一个间隙item
        items.removeLast()
        
        tb.items = items
        return tb
    }()
    
    //==========================================================================================================
    // MARK: - 系统初始化函数
    //==========================================================================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.设置背景颜色
        view.backgroundColor = UIColor.redColor()
        
        // 2.添加子控件
        view.addSubview(collectionView)
        view.addSubview(toolbar)
        
        // 3.取消自动布局
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        
        // 4.布局子控件
        let dict = ["collectionView" : collectionView, "toolbar" : toolbar]
        // 4.1.设置collectionView的水平布局
        var cons = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[collectionView]-0-|", options: NSLayoutFormatOptions.init(rawValue: 0), metrics: nil, views: dict)
        // 4.2.设置toolbar的水平布局
        cons += NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[toolbar]-0-|", options: NSLayoutFormatOptions.init(rawValue: 0), metrics: nil, views: dict)
        // 4.3.设置collectionView和toolbar的垂直布局
        cons += NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[collectionView]-[toolbar(49)]-0-|", options: NSLayoutFormatOptions.init(rawValue: 0), metrics: nil, views: dict)
        
        // 5.添加布局
        view.addConstraints(cons)
    }
    
    //==========================================================================================================
    // MARK: - 内部控制方法
    //==========================================================================================================
    
    
    // MARK: 处理监听事件
    @objc private func itemClick(item: UIBarButtonItem)
    {
        print(item.tag)
    }

}

//==========================================================================================================
// MARK: - UICollectionViewDataSource
//==========================================================================================================
extension SLExpressionKeyboardViewController : UICollectionViewDataSource
{
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 21
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("keyboardCell", forIndexPath: indexPath)
        cell.backgroundColor = (indexPath.item % 2 == 0) ? UIColor.redColor() : UIColor.purpleColor()
        return cell
    }
}

//==========================================================================================================
// MARK: - 设置UICollectionView的流水布局
//==========================================================================================================
class expressionKeyboardLayout : UICollectionViewFlowLayout
{
    override func prepareLayout() {
        super.prepareLayout()
        
        // 设置collectionView的属性
        let width = UIScreen.mainScreen().bounds.width / 7
        let heigth = collectionView!.bounds.height / 3
        itemSize = CGSize(width: width, height: heigth)
        
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        collectionView?.bounces = false
        collectionView?.pagingEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = false
        
    }
}