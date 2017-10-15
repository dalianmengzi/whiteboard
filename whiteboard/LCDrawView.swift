//
//  LCDrawView.swift
//  DrawBoardDemo
//
//  Created by 尤增强 on 17/6/8.
//  Copyright © 2017年 ifdoo. All rights reserved.
//

import UIKit

class LCDrawView: UIView {
    fileprivate var lastLayer: CAShapeLayer!
    fileprivate var lastPath: UIBezierPath!
    fileprivate var layers: [CAShapeLayer]!
    fileprivate var cancelLayers: [CAShapeLayer]!
    var widthline = 2;
    var colorline = UIColor.red;
    var preparativeColor = UIColor.red;
    var preparativeWidth = 2;
    
    // MARK: - life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        layers = []
        cancelLayers = []
//        initButtons(frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - private mothods
    func initButtons(_ frame: CGRect) {
      
        let stoolsView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: frame.width, height: 30));
        stoolsView.backgroundColor = UIColor.gray;
        self.addSubview(stoolsView);
        
       //self.layer.contents = UIImage(named: "课程总结反馈.jpg")?.cgImage
        let titles = ["\u{e636}","\u{e66f}","\u{e600}","\u{e81a}","\u{e608}","\u{e629}"]
        let BtnW = 30
        for i in 0 ..< titles.count {
           let button = UIButton()
            button.tag = 100 + i
            button.titleLabel?.font = UIFont.init(name: "iconfont", size: 20);
            button.frame = CGRect(x:Int(frame.width - 180 + CGFloat(BtnW * i)), y: 2, width: BtnW, height: 30)
            button.setTitle(titles[i], for: UIControlState())
            button.setTitleColor(UIColor.white, for: UIControlState())
            button.setTitleColor(UIColor.lightGray, for: .highlighted)
            button.addTarget(self, action: #selector(self.click(_:)), for: .touchUpInside)
            self.addSubview(button)
        }
    }
    // 获取点
    func pointWithTouches(_ touches: Set<UITouch>) -> CGPoint {
        let touch = (touches as NSSet).anyObject()
        return ((touch as AnyObject).location(in: self))
    }
    
    func initStartPath(_ startPoint: CGPoint) {
        let path = UIBezierPath()
        path.lineWidth = CGFloat(widthline)
        // 线条拐角
        path.lineCapStyle = .round
        // 终点处理
        path.lineJoinStyle = .round
        // 设置起点
        path.move(to: startPoint)
        lastPath = path
        
        let shaperLayer = CAShapeLayer()
        shaperLayer.path = path.cgPath
        shaperLayer.fillColor = UIColor.clear.cgColor
        shaperLayer.lineCap = kCALineCapRound
        shaperLayer.lineJoin = kCALineJoinRound
        shaperLayer.strokeColor = colorline.cgColor
        shaperLayer.lineWidth = path.lineWidth
        self.layer.addSublayer(shaperLayer)
        lastLayer = shaperLayer
        layers.append(shaperLayer)
    }
    
    // MARK: - response events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = self.pointWithTouches(touches)
        if event?.allTouches?.count == 1 {
            initStartPath(point)
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = self.pointWithTouches(touches)
        if event?.allTouches?.count == 1 {
            // 终点
            lastPath.addLine(to: point)
            lastLayer.path = lastPath.cgPath
        }
    }
    func click(_ button: UIButton) {
        let tag = button.tag;
        colorline = preparativeColor;
        widthline = preparativeWidth;
        switch tag {
        case 100:
            remove()
        case 101:
            cancel()
        case 102:
            redo()
        case 104:
            rubber();
        default:
            break
        }
    }
    
    // 删除
    func remove() {
        if layers.count == 0 {
            return
        }
        for slayer in layers {
            slayer.removeFromSuperlayer()
        }
        layers.removeAll()
        cancelLayers.removeAll()
    }
    
    // 撤销
    func cancel() {
       
        if layers.count == 0 {
            return
        }
        layers.last?.removeFromSuperlayer()
        cancelLayers.append(layers.last!)
        layers.removeLast()
    }
    
    // 恢复
    func redo() {
        if cancelLayers.count == 0 {
            return
        }
        self.layer.addSublayer(cancelLayers.last!)
        layers.append(cancelLayers.last!)
        cancelLayers.removeLast()
    }
   
    //橡皮
    func rubber(){
        widthline = 8;
        colorline = UIColor.white;
    
    }
    
    
    
  
}
