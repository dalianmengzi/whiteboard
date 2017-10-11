//
//  ViewController.swift
//  whiteboard
//
//  Created by 尤增强 on 2017/10/4.
//  Copyright © 2017年 zqyou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let drawView = LCDrawView(frame: self.view.bounds)
        self.view.addSubview(drawView)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

