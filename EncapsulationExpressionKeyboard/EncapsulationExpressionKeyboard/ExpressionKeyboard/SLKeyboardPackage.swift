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
        var modes = [SLKeyboardPackage]()
        // 0.手动添加最近组
        let package = SLKeyboardPackage(id: "")
        package.appendEmptyEmoticon()
        modes.append(package)
        
        // 1.获取emoticons.plist文件路径
        let path = NSBundle.mainBundle().pathForResource("emoticons.plist", ofType: nil, inDirectory: "Emoticons.bundle")!
        // 2.加载emoticons.plist文件
        let dict = NSDictionary(contentsOfFile: path)!
        let array = dict["packages"] as! [[String : AnyObject]]
        
        // 3.取出所有的表情
        for packageDict in array
        {
            let package = SLKeyboardPackage(id: packageDict["id"] as! String)
            package.loadEmoticons()
            package.appendEmptyEmoticon()
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
        // 表情数量的标记
        var index = 0
        for emoticonDict in array
        {
            // 添加表情达到20个，就添加一个删除表情
            if index == 20
            {
                let emoticon = SLKeyboardEmoticon(isRemoveButton: true)
                models.append(emoticon)
                index = 0
                continue
            }
            
            let emoticon = SLKeyboardEmoticon(dict: emoticonDict, id: self.id!)
            models.append(emoticon)
            index += 1
            
        }
        emoticons = models
    }
    
    /**
     补全一组表情，能够被21整除
     */
    private func appendEmptyEmoticon()
    {
        // 1.判断是否是最近组
        if emoticons == nil
        {
            emoticons = [SLKeyboardEmoticon]()
        }
        
        // 2.补全
       let number = emoticons!.count % 21
        
        for _ in number..<20
        {
            let emoticon = SLKeyboardEmoticon(isRemoveButton: false)
            emoticons?.append(emoticon)
        }
        
        // 3.补全删除按钮
        let emoticon = SLKeyboardEmoticon(isRemoveButton: true)
        emoticons?.append(emoticon)
    }
    
    func addFavoriteEmoticon(emoticon: SLKeyboardEmoticon)
    {
        // 删除最后一个
        emoticons?.removeLast()
        
        // 2.判断当前表情是否已经添加过
        if !emoticons!.contains(emoticon)
        {
            // 2.1.添加当前点击的表情到最近组
            emoticons?.removeLast()
            emoticons?.append(emoticon)
        }
        
        // 3.对表情进行排序
        let array = emoticons?.sort({ (e1, e2) -> Bool in
            return e1.count > e2.count
        })
        emoticons = array
        // 4.添加一个删除按钮
        emoticons?.append(SLKeyboardEmoticon(isRemoveButton: true))
    }
}

