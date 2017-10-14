//
//  selectPenViewController.swift
//  whiteboard
//
//  Created by 尤增强 on 2017/10/13.
//  Copyright © 2017年 zqyou. All rights reserved.
//

import UIKit

class selectPenViewController: UIViewController {

    let width = UIScreen.main.bounds.width
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .custom
        setUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUI(){
        let setView = UIView.init(frame: CGRect.init(x: width - 150, y: 30, width: 150, height: 60));
        self.view.addSubview(setView);
        let BtnW = 30 , colors = [UIColor.red, UIColor.black,UIColor.yellow,UIColor.purple,UIColor.orange];
        
        for i in 0 ..< colors.count {
            let button = UIButton()
            button.tag = i
            button.frame = CGRect(x:BtnW * i, y: 2, width: 16, height: 16);
            button.layer.borderWidth = 0;
            button.layer.cornerRadius = 8;
            button.addTarget(self, action: #selector(self.selectColor(_:)), for: .touchUpInside)
            button.backgroundColor = colors[i]
            setView.addSubview(button)
        }
        for i in 0 ..< 5 {
            let button = UIButton()
            let penwidth = 8 + i * 2;
            button.tag = penwidth / 2
            button.frame = CGRect(x:BtnW * i + 4, y: 30, width: penwidth , height: penwidth);
            button.layer.borderWidth = 0;
            button.layer.cornerRadius = CGFloat(penwidth / 2);
            button.addTarget(self, action: #selector(self.selectWidth(_:)), for: .touchUpInside)
            button.backgroundColor = UIColor.red;
            setView.addSubview(button)
        }
       
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.presentingViewController?.dismiss(animated: true, completion: nil);
        
    }

    func selectColor(_ button: UIButton) {
        
    }
    func selectWidth(_ button: UIButton) {
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
