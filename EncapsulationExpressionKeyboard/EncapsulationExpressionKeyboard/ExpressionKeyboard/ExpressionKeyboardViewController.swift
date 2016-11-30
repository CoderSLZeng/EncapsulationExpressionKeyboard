//
//  ExpressionKeyboardViewController.swift
//  EncapsulationExpressionKeyboard
//
//  Created by Anthony on 16/11/30.
//  Copyright © 2016年 SLZeng. All rights reserved.
//  表情键盘控制器
//

import UIKit

class ExpressionKeyboardViewController: UIViewController {

    //==========================================================================================================
    // MARK: - 懒加载
    //==========================================================================================================
    // 表情视图控件
    private lazy var collectionView : UICollectionView = {
        let clv = UICollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
        clv.backgroundColor = UIColor.greenColor()
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
            let item = UIBarButtonItem(title: title, style: UIBarButtonItemStyle.Plain, target: self, action: #selector(ExpressionKeyboardViewController.itemClick(_:)))
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
