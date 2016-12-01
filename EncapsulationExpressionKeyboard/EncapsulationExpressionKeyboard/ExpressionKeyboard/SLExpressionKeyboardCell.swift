//
//  SLExpressionKeyboardCell.swift
//  EncapsulationExpressionKeyboard
//
//  Created by Anthony on 16/12/1.
//  Copyright © 2016年 SLZeng. All rights reserved.
//

import UIKit

class SLExpressionKeyboardCell: UICollectionViewCell {
    //==========================================================================================================
    // MARK: - 懒加载
    //==========================================================================================================
    private lazy var iconButton = UIButton()
    
    //==========================================================================================================
    // MARK: - 系统初始化函数
    //==========================================================================================================
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    //==========================================================================================================
    // MARK: - 内部控制函数
    //==========================================================================================================
    // 设置UI
    private func setupUI()
    {
        // 1.设置iconButton属性
        iconButton.frame = CGRectInset(bounds, 4, 4)
        iconButton.backgroundColor = UIColor.whiteColor()
        // 2.添加iconButton到容器视图
        contentView.addSubview(iconButton)
    }
}
