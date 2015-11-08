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
    }

    //MARK: - 懒加载
    private lazy var emoticonVC: CCEmoticonViewController = {
        let controller = CCEmoticonViewController()
        
        return controller
    }()
    


}

