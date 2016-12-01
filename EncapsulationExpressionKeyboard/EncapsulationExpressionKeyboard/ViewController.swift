//
//  ViewController.swift
//  EncapsulationExpressionKeyboard
//
//  Created by Anthony on 16/11/30.
//  Copyright © 2016年 SLZeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var customTextField: UITextField!
    
    //==========================================================================================================
    // MARK: - 懒加载
    //==========================================================================================================
    lazy var expressionKeyboardVC : SLExpressionKeyboardViewController = SLExpressionKeyboardViewController()
    
    
    //==========================================================================================================
    // MARK: - 系统初始化函数
    //==========================================================================================================

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.添加子控制器
        addChildViewController(expressionKeyboardVC)
        
        // 2.设置键盘弹出的视图
        customTextField.inputView = expressionKeyboardVC.view
    }


}

