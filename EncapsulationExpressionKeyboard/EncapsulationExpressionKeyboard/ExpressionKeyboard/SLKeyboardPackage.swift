//
//  SLKeyboardPackage.swift
//  EncapsulationExpressionKeyboard
//
//  Created by Anthony on 16/12/1.
//  Copyright © 2016年 SLZeng. All rights reserved.
//

import UIKit

/**
 说明：
 1. Emoticons.bundle 的根目录下存放的 emoticons.plist 保存了 packages 表情包信息
    >packages 是一个数组, 数组中存放的是字典
    >字典中的属性 id 对应的分组路径的名称
 2. 在 id 对应的目录下，各自都保存有 info.plist
     >group_name_cn   保存的是分组名称
     >emoticons       保存的是表情信息数组
     >code            UNICODE 编码字符串
     >chs             表情文字，发送给新浪微博服务器的文本内容
     >png             表情图片，在 App 中进行图文混排使用的图片
 */

class SLKeyboardPackage: NSObject {
    /// 当前组的名称
    var group_name_cn : String?
    /// 当前组对应的文件夹名称
    var id : String?
    /// 当前组所有的表情
    var emoticons : [SLKeyboardEmoticon]?
    
    init(id : String) {
        self.id = id
    }
    
    class func loadEmotionPackage() -> [SLKeyboardPackage]
    {
        // 1.获取emoticons.plist文件路径
        let path = NSBundle.mainBundle().pathForResource("emoticons.plist", ofType: nil, inDirectory: "Emoticons.bundle")!
        // 2.加载emoticons.plist文件
        let dict = NSDictionary(contentsOfFile: path)!
        let array = dict["packages"] as! [[String : AnyObject]]
        
        // 3.取出所有的表情
        var modes = [SLKeyboardPackage]()
        for packageDict in array
        {
            let package = SLKeyboardPackage(id: packageDict["id"] as! String)
            package.loadEmoticons()
            modes.append(package)
        }
     return modes
    }
    
    private func loadEmoticons()
    {
        // 1.拼接当前组的info.plist路径
        let path = NSBundle.mainBundle().pathForResource(self.id, ofType: nil, inDirectory: "Emoticons.bundle")!
        let filePath = (path as NSString).stringByAppendingPathComponent("info.plist")
        // 2.根据路径加载info.plist文件
        let dict = NSDictionary(contentsOfFile: filePath)!
        
        // 3.从加载进来的字典中取出当前组的数据
        // 3.1.取出当前组的名称
        group_name_cn = dict["group_name_cn"] as? String
        // 3.2.取出当前组所有的表情
        let array = dict["emoticons"] as! [[String : AnyObject]]
        
        // 3.3遍历数组，取出每一个表情
        var models = [SLKeyboardEmoticon]()
        for emoticonDict in array
        {
            let emotion = SLKeyboardEmoticon(dict: emoticonDict, id: self.id!)
            models.append(emotion)
        }
        emoticons = models
    }
}

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
    
    init(dict: [String : AnyObject], id: String) {
        self.id = id
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
