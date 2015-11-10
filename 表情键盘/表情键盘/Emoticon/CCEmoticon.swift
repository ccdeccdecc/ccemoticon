//
//  CCEmoticon.swift
//  表情键盘
//
//  Created by apple on 15/11/9.
//  Copyright © 2015年 eason. All rights reserved.
//

import UIKit

//MARK: - 表情包模型
///表情包模型
class CCEmoticonPackage: NSObject {
    
    //MARK: - 属性 
    ///获取Emoticon.boundle的路径
    private static let bundlePath = NSBundle.mainBundle().pathForResource("Emoticons", ofType: "bundle")!
    
    ///表示文件夹名称
    var id: String?
    
    ///表情包名称
    var group_name_cn: String?
    
    ///所有表情
    var emoticons: [CCEmoticon]?
    
    ///构造方法,通过表情包路径
    init(id: String) {
        self.id = id
        super.init()
    }
    
    override var description: String {
        return "\n\t表情包模型:id:\(id), group_name_cn:\(group_name_cn), emoticons: \(emoticons)"
    }
    
    ///加载表情包
    class func packages() -> [CCEmoticonPackage] {
        
        //拼接 emoticon.plist的路径
        let plistPath = bundlePath + "/emoticons.plist"
        //加载plist
        let plistDict = NSDictionary(contentsOfFile: plistPath)!
        print("plistDict: \(plistDict)")
        
        ///表情包数组
        var packages = [CCEmoticonPackage]()
        //获取packages数组里面每个字典的key为id的值
        if let packageArray = plistDict["packages"] as? [[String : AnyObject]] {
            //遍历数组
            for dict in packageArray {
                //获取字典里面的key为id的值
                let id = dict["id"] as! String //对应表情包得路径
                //创建表情包,表情包里面只有id,其它的数据需要知道表情包的文件名称才能进行
                let package = CCEmoticonPackage(id: id)
                //让表情包去进一步加载数据(表情模型,表情包名称)
                package.loadEmoticon()
                packages.append(package)
            }
        }
        
        return packages
    }
    
    ///加载表情包里面的表情和其它数据
    func loadEmoticon() {
        //获取表情包文件里面的info.plist
        //info.plist = bundle + 表情包文件夹名称 + info.plist
        let infoPath = CCEmoticonPackage.bundlePath + "/" + id! + "/info.plist"
        //加载info.plist
        let infoDict = NSDictionary(contentsOfFile: infoPath)!
        print("infoDict:\(infoDict)")
        //获取表情包名称
        group_name_cn = infoDict["group_name_cn"] as? String
        
        //创建表情模型数组
        emoticons = [CCEmoticon]()
        
        //获取表情包模型
        if let array = infoDict["emoticons"] as? [[String: String]] {
            //遍历数组
            for dict in array {
                //字典转模型
                emoticons?.append(CCEmoticon(dict: dict))
            }
        }
    }
    
    
}


//MARK: - 表情模型
///表情模型
class CCEmoticon: NSObject {
    ///表情名称,用于网络传输
    var chs: String?
    ///表情图片对应的名称
    var png: String?
    //emoji表情对应的16进制字符串
    var code: String?
    
    ///字典转模型
    init(dict: [String: String]) {
        super.init()
        
        //KVC赋值
        setValuesForKeysWithDictionary(dict)
    }
    ///字典的key在模型里面没有对应的属性
    override func setValue(value: AnyObject?, forUndefinedKey key: String) { }
    
    override var description: String {
        return "\n\t\t表情模型:chs:\(chs), png:\(png), code:\(code)"
    }
    
}




