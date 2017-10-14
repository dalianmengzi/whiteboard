//
//  ViewController.swift
//  whiteboard
//
//  Created by 尤增强 on 2017/10/4.
//  Copyright © 2017年 zqyou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var drawView = LCDrawView();
    override func viewDidLoad() {
        super.viewDidLoad()
         drawView = LCDrawView(frame: self.view.bounds)
        self.view.addSubview(drawView)
        
        setUI()
    }

    func setUI(){
    
        let stoolsView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: 30));
        stoolsView.backgroundColor = UIColor.gray;
        self.view.addSubview(stoolsView);
        
        let titles = ["\u{e636}","\u{e66f}","\u{e600}","\u{e81a}","\u{e608}","\u{e629}"]
        let BtnW = 30
        for i in 0 ..< titles.count {
            let button = UIButton()
            button.tag = 100 + i
            button.titleLabel?.font = UIFont.init(name: "iconfont", size: 20);
            button.frame = CGRect(x:Int(self.view.bounds.width - 180 + CGFloat(BtnW * i)), y: 2, width: BtnW, height: 30)
            button.setTitle(titles[i], for: UIControlState())
            button.setTitleColor(UIColor.white, for: UIControlState())
            button.setTitleColor(UIColor.lightGray, for: .highlighted)
            button.addTarget(self, action: #selector(self.click(_:)), for: .touchUpInside)
            stoolsView.addSubview(button)
        }
    }
    
    func click(_ button: UIButton) {
        let tag = button.tag;
        drawView.colorline = drawView.preparativeColor;
        drawView.widthline = drawView.preparativeWidth;
        switch tag {
        case 100:
            drawView.remove()
        case 101:
           drawView.cancel()
        case 102:
            drawView.redo()
        case 103:
            drawView.add()
        case 104:
            drawView.rubber();
        case 105:
            pen();
        default:
            break
        }
    }

    //设置颜色与字体大小
    func pen(){
        let previwe = selectPenViewController()
        //这里要把展示出的控制器设置为透明颜色
        previwe.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5);
        
        self.present(previwe, animated:true, completion: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

