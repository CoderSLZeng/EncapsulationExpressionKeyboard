//
//  SLExpressionKeyboardCell.swift
//  EncapsulationExpressionKeyboard
//
//  Created by Anthony on 16/12/1.
//  Copyright © 2016年 SLZeng. All rights reserved.
//

import UIKit

class SLExpressionKeyboardCell: UICollectionViewCell {
    // MARK: - 提供给外界的属性
    /// 当前行对应的表情模型
    var emoticon : SLKeyboardEmoticon?
        {
        didSet {
            // 1.显示emoji表情
            iconButton.setTitle(emoticon?.emoticonStr ?? "", forState: UIControlState.Normal)
            
            // 2.设置表情图片
            iconButton.setImage(nil, forState: UIControlState.Normal)
            if emoticon?.chs != nil
            {
                iconButton.setImage(UIImage(contentsOfFile: emoticon!.pngPath!), forState: UIControlState.Normal)
            }
            
            // 3.设置删除图标
            if emoticon!.isRemoveButton
            {
                iconButton.setImage(UIImage(named: "compose_emotion_delete"), forState: UIControlState.Normal)
                iconButton.setImage(UIImage(named: "compose_emotion_delete_highlighted"), forState: UIControlState.Highlighted)
            }
            
        }
    }
      
    // MARK: - 懒加载属性
    /// 表情图标按钮
    private lazy var iconButton : UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFontOfSize(30)
        btn.backgroundColor = UIColor.whiteColor()
        // 禁止按钮交互
        btn.userInteractionEnabled = false
        return btn
    }()
    
      
    // MARK: - 系统初始化函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
      
    // MARK: - 设置UI界面内容
    private func setupUI()
    {
        // 1.设置iconButton属性
        iconButton.frame = CGRectInset(bounds, 4, 4)
        // 2.添加iconButton到容器视图
        contentView.addSubview(iconButton)
    }
}
