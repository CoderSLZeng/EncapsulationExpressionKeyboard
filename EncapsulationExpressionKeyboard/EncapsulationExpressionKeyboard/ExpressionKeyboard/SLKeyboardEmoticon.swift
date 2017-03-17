//
//  SLKeyboardEmoticon.swift
//  EncapsulationExpressionKeyboard
//
//  Created by Anthony on 17/3/17.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

import UIKit

class SLKeyboardEmoticon: NSObject {
    // 当前组对应的文件夹名称
    var id: String?
    
    /// 当前表情对应的字符串
    var chs : String?
    /// 当前表情对应的图片
    var png : String?
        {
        didSet
        {
            let path = NSBundle.mainBundle().pathForResource(id, ofType: nil, inDirectory: "Emoticons.bundle")!
            pngPath = (path as NSString).stringByAppendingPathComponent(png ?? "")
        }
    }
    /// 当前表情的绝对路径
    var pngPath : String?
    /// Emoji表情对应的字符串
    var code: String?
        {
        didSet
        {
            // 1.创建一个扫描器
            let scanner = NSScanner(string: code ?? "")
            // 2.从字符串中扫描出对应的16进制数
            var resutl : UInt32 = 0
            scanner.scanHexInt(&resutl)
            // 3.根据扫描出的16进制创建一个字符串
            emoticonStr = "\(Character(UnicodeScalar(resutl)))"
        }
    }
    
    /// 转换之后的emoji表情字符串
    var emoticonStr : String?
    
    /// 记录是否是删除按钮
    var isRemoveButton: Bool = false
    
    /// 记录当前表情使用次数
    var count: Int = 0
    
    init(dict: [String : AnyObject], id: String) {
        self.id = id
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    init(isRemoveButton: Bool)
    {
        self.isRemoveButton = isRemoveButton
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }

}
