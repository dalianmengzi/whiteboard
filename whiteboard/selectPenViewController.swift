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
        let setView = UIView.init(frame: CGRect.init(x: width - 200, y: 30, width: 200, height: 60));
        self.view.addSubview(setView);
        
        
        
       
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.presentingViewController?.dismiss(animated: true, completion: nil);
        
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
