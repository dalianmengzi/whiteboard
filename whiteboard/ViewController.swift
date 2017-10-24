//
//  ViewController.swift
//  whiteboard
//
//  Created by 尤增强 on 2017/10/4.
//  Copyright © 2017年 zqyou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let width = UIScreen.main.bounds.width;
    let colors = [0xfc0b1d,0xf5af42,0xfbe156,0x7ce471,0x5b207b,0x000000,0xb8b8ba,0xe6e6e6,0x2991f6,0x73defa];
    var drawView = LCDrawView();
    var penView = UIView();
    override func viewDidLoad() {
        super.viewDidLoad()
         drawView = LCDrawView(frame: self.view.bounds)
        self.view.addSubview(drawView)
        
        setUI()
    }

    func setUI(){
    
        let stoolsView = UIView.init(frame: CGRect.init(x: 0, y: 0, width:width , height: 30));
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
            if(i == 5){
                 button.setTitleColor(UIColor.red, for: UIControlState())
            }else{
                 button.setTitleColor(UIColor.white, for: UIControlState())
            }
           
            button.setTitleColor(UIColor.lightGray, for: .highlighted)
            button.addTarget(self, action: #selector(self.click(_:)), for: .touchUpInside)
            stoolsView.addSubview(button)
        }
        
        setPenUI()
    }
    
   func  setPenUI(){
        penView = UIView.init(frame: CGRect.init(x:width - 220, y: 40, width: 210, height: 160));
        penView.backgroundColor = UIColor.colorWithHex(hexColor: 0xf5f5f5);
        penView.layer.masksToBounds = true;
        penView.layer.cornerRadius = 10;
        self.view.addSubview(penView);
    
        for i in 0 ..< 5{
            let button = UIButton()
            button.tag = (i + 1) * 2
            button.frame = CGRect(x:10 + 40 * i, y: 10, width: 30, height: 30);
            button.layer.borderWidth = 2;
            button.setTitle("\u{e601}", for: .normal);
            button.titleLabel?.font = UIFont.init(name: "iconfont", size: CGFloat(20 + 3 * i));
            button.addTarget(self, action: #selector(self.selectWidth(_:)), for: .touchUpInside);
            button.contentHorizontalAlignment = .center;
            button.setTitleColor(UIColor.red, for: .normal);
            button.layer.borderColor = UIColor.white.cgColor;
            button.layer.cornerRadius = 15;
            button.backgroundColor = UIColor.white;
            penView.addSubview(button);
            
        }
        let labline = UILabel.init(frame: CGRect.init(x: 10, y: 56, width: 190, height: 4));
       
        labline.backgroundColor = UIColor.colorWithHex(hexColor: 0xe6e8e8);
        penView.addSubview(labline);
    
        for i in 0 ..< colors.count{
            let button = UIButton()
            var  Bheight = 70,Bwidth = 10 + 40 * i;
            if(i > 4){
                Bheight = 110;
                Bwidth = 10 + 40 * (i - 5);
            }
            button.tag = i
            button.frame = CGRect(x:Bwidth, y: Bheight, width: 30, height: 30);
            button.layer.borderWidth = 2;
            button.setTitle("\u{e601}", for: .normal);
            button.titleLabel?.font = UIFont.init(name: "iconfont", size: 32);
            button.contentHorizontalAlignment = .center;
            button.setTitleColor(UIColor.colorWithHex(hexColor: Int64(colors[i])), for: .normal);
            button.addTarget(self, action: #selector(self.selectColor(_:)), for: .touchUpInside);
            button.layer.borderColor = UIColor.white.cgColor;
            button.layer.cornerRadius = 15;
            button.backgroundColor = UIColor.white;
            penView.addSubview(button);
            
        }
        penView.isHidden = true;
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
            add()
        case 104:
            drawView.rubber();
        case 105:
            pen();
        default:
            break
        }
    }
    
    func selectWidth(_ button: UIButton) {
       
        self.drawView.widthline = button.tag;
        self.drawView.preparativeWidth =  button.tag;
        button.layer.borderColor = UIColor.gray.cgColor;
        penView.isHidden = true;
        
    }
    
    func selectColor(_ button: UIButton) {
        
        let tag  = button.tag;
        self.drawView.colorline = UIColor.colorWithHex(hexColor: Int64(colors[tag])) ;
        self.drawView.preparativeColor = UIColor.colorWithHex(hexColor: Int64(colors[tag])) ;
        penView.isHidden = true;
        
    }
    //添加
    func add(){
        let previwe = addactivityViewController()
        //这里要把展示出的控制器设置为透明颜色
        previwe.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1);
        previwe.setActivtyClosure = {
            (tag:Int) in
            if(tag == 0){
                self.drawView.remove();
            }
        }
        self.present(previwe, animated:true, completion: nil)
    }
    //设置颜色与字体大小
    func pen(){
//        let previwe = selectPenViewController()
//        //这里要把展示出的控制器设置为透明颜色
//        previwe.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5);
//        previwe.linecolor = drawView.preparativeColor;
//        previwe.linewidth = drawView.preparativeWidth;
//        previwe.setWidthandColorClosure = {
//            (width:Int,color:UIColor) in
//            self.drawView.widthline = width;
//            self.drawView.colorline = color;
//            self.drawView.preparativeColor = color;
//            self.drawView.preparativeWidth = width;
//
//        }
//        self.present(previwe, animated:true, completion: nil)
        
        let isHidden =   penView.isHidden
        penView.isHidden = !isHidden;
      
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

