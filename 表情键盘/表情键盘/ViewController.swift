//
//  ViewController.swift
//  表情键盘
//
//  Created by apple on 15/11/8.
//  Copyright © 2015年 eason. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置自定义的键盘
        textView.inputView = emoticonVC.view
        
        emoji()
    }
    ///将16进制的0x1f603转成emoji 表情
    private func emoji() {
        let code = "0x1f603"
        //扫描器
        let scanner = NSScanner(string: code)
        //存储扫描器
        var value: UInt32 = 0
        scanner.scanHexInt(&value)
        print("扫描结果:\(value)")
        let c = Character(UnicodeScalar(value))
        let str = String(c)
        print("str:\(str)")
        textView.text = str
        
    }

    //MARK: - 懒加载
    private lazy var emoticonVC: CCEmoticonViewController = {
        let controller = CCEmoticonViewController()
        
        return controller
    }()
    


}

