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
    
    // MARK: - life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        layers = []
        cancelLayers = []
        initButtons(frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - private mothods
    func initButtons(_ frame: CGRect) {
      
       //self.layer.contents = UIImage(named: "课程总结反馈.jpg")?.cgImage
//        let titles = ["删除","撤销","恢复"]
//        let BtnW = frame.width / 3
//        for i in 0 ..< titles.count {
//           let button = UIButton()
//            button.tag = 100 + i
//            button.frame = CGRect(x: BtnW * CGFloat(i), y: 2, width: BtnW, height: 30)
//            button.setTitle(titles[i], for: UIControlState())
//            button.setTitleColor(UIColor.blue, for: UIControlState())
//            button.setTitleColor(UIColor.lightGray, for: .highlighted)
//            button.addTarget(self, action: #selector(self.click(_:)), for: .touchUpInside)
//            self.addSubview(button)
//        }
        
        let stoolsView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: frame.width, height: 30));
        stoolsView.backgroundColor = UIColor.gray;
        self.addSubview(stoolsView);
        let clearBtn = UIButton.init(frame: CGRect.init(x: frame.width - 240, y: 2, width: 30, height: 26));
        clearBtn.titleLabel?.font = UIFont.init(name: "iconfont", size: 20);
        clearBtn.setTitle("\u{e636}", for: .normal);
        clearBtn.tag = 100;
        clearBtn.addTarget(self, action: #selector(self.click(_:)), for: .touchUpInside)
        clearBtn.titleLabel?.textColor = UIColor.white;
        stoolsView.addSubview(clearBtn);
        
        let repealBtn = UIButton.init(frame: CGRect.init(x: frame.width - 200, y: 2, width: 30, height: 26));
        repealBtn.titleLabel?.font = UIFont.init(name: "iconfont", size: 20);
        repealBtn.setTitle("\u{e66f}", for: .normal);
        repealBtn.tag = 101;
        repealBtn.addTarget(self, action: #selector(self.click(_:)), for: .touchUpInside)
        repealBtn.titleLabel?.textColor = UIColor.white;
        stoolsView.addSubview(repealBtn);
        
        let recoverBtn = UIButton.init(frame: CGRect.init(x: frame.width - 160, y: 2, width: 30, height: 26));
        recoverBtn.titleLabel?.font = UIFont.init(name: "iconfont", size: 20);
        recoverBtn.setTitle("\u{e600}", for: .normal);
        recoverBtn.tag = 102;
        recoverBtn.addTarget(self, action: #selector(self.click(_:)), for: .touchUpInside)
        recoverBtn.titleLabel?.textColor = UIColor.white;
        stoolsView.addSubview(recoverBtn);
        
        let addActivtyBtn = UIButton.init(frame: CGRect.init(x:frame.width - 120, y: 2, width: 30, height: 28));
        addActivtyBtn.titleLabel?.font = UIFont.init(name: "iconfont", size: 20);
        addActivtyBtn.setTitle("\u{e81a}", for: .normal);
        addActivtyBtn.tag = 103;
        addActivtyBtn.addTarget(self, action: #selector(self.click(_:)), for: .touchUpInside)
        addActivtyBtn.titleLabel?.textColor = UIColor.white;
        stoolsView.addSubview(addActivtyBtn);
        
        let rubberBtn = UIButton.init(frame: CGRect.init(x:frame.width - 80, y: 2, width: 30, height: 28));
        rubberBtn.titleLabel?.font = UIFont.init(name: "iconfont", size: 20);
        rubberBtn.setTitle("\u{e608}", for: .normal);
        rubberBtn.tag = 104;
        rubberBtn.addTarget(self, action: #selector(self.click(_:)), for: .touchUpInside)
        rubberBtn.titleLabel?.textColor = UIColor.white;
        stoolsView.addSubview(rubberBtn);
        
        let penBtn = UIButton.init(frame: CGRect.init(x:frame.width - 40, y: 2, width: 30, height: 28));
        penBtn.titleLabel?.font = UIFont.init(name: "iconfont", size: 20);
        penBtn.setTitle("\u{e629}", for: .normal);
        penBtn.tag = 104;
        penBtn.addTarget(self, action: #selector(self.click(_:)), for: .touchUpInside)
        penBtn.titleLabel?.textColor = UIColor.white;
        stoolsView.addSubview(penBtn);
       
        
    }
    // 获取点
    func pointWithTouches(_ touches: Set<UITouch>) -> CGPoint {
        let touch = (touches as NSSet).anyObject()
        return ((touch as AnyObject).location(in: self))
    }
    
    func initStartPath(_ startPoint: CGPoint) {
        let path = UIBezierPath()
        path.lineWidth = 2
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
        shaperLayer.strokeColor = UIColor.red.cgColor
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
        let tag = button.tag
        switch tag {
        case 100:
            remove()
        case 101:
            cancel()
        case 102:
            redo()
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
 
    
    
  
}
