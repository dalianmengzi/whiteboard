//
//  addactivityViewController.swift
//  whiteboard
//
//  Created by 尤增强 on 2017/10/15.
//  Copyright © 2017年 zqyou. All rights reserved.
//

import UIKit

class addactivityViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    let width = UIScreen.main.bounds.width;
    var selimg = UIImage();
    var selectTag = 0;
    var setActivtyClosure:((_ tag:Int,_ img:UIImage) -> Void)?
    override func viewDidLoad() {
       
        super.viewDidLoad()
        self.modalPresentationStyle = .custom;
        setUI();
        // Do any additional setup after loading the view.
    }

    func setUI(){
        let  activeView = UIView.init(frame: CGRect.init(x: 0, y:0, width: 200, height: 80));
        activeView.center = self.view.center;
        self.view.addSubview(activeView);
        let fonts = ["\u{e612}","\u{e638}","\u{e666}"];
        let titles = ["空白板","相片","拍摄"];
        let colors = [0xf9755b,0x7c89e8,0xf2b240];
        let BtnW = 70 ;
        for i in 0 ..< fonts.count {
            let button = UIButton()
            button.tag = i
            button.frame = CGRect(x:BtnW * i, y: 20, width: 48 , height: 48);
            button.layer.cornerRadius = 24;
            button.titleLabel?.font = UIFont.init(name: "iconfont", size: 24);
            button.setTitle(fonts[i], for: .normal);
            button.setTitleColor(UIColor.white, for: .normal);
            button.addTarget(self, action: #selector(self.tap(_:)), for: .touchUpInside)
            button.backgroundColor = UIColor.colorWithHex(hexColor: Int64(colors[i]))
            activeView.addSubview(button)
        }
        let cancelBtu = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 20, height: 20));
        cancelBtu.titleLabel?.font = UIFont.init(name: "iconfont", size: 20);
        cancelBtu.setTitle("\u{e602}", for: .normal);
        cancelBtu.layer.cornerRadius = 10;
        cancelBtu.setTitleColor(UIColor.red, for: .normal);
        cancelBtu.center = CGPoint.init(x: self.view.center.x + 120, y: self.view.center.y - 30);
        cancelBtu.addTarget(self, action: #selector(self.cancel(_:)), for: .touchUpInside)

        self.view.addSubview(cancelBtu);
        
    
    }
    func tap(_ button: UIButton) {
        let tag = button.tag;
        if(tag == 0){
            setActivtyClosure?(tag,selimg);
            self.presentingViewController?.dismiss(animated: true, completion: nil);
        }else if (tag == 1){
            self.selectTag = tag;
            funcChooseFromPhotoAlbum();
        }else{
            self.selectTag = tag;
            funcChooseFromCamera();
        }
        
       
        
    }
    func cancel(_ button: UIButton) {
      self.presentingViewController?.dismiss(animated: true, completion: nil);
        
    }
    //从相册选择照片
    func funcChooseFromPhotoAlbum() -> Void{
        
        let masterVC = HsuAlbumMasterTableViewController()
        let navi = UINavigationController(rootViewController: masterVC)
        masterVC.title = "图片"
        let gridVC = HsuAssetGridViewController()
        gridVC.title = "所有图片"
        navi.pushViewController(gridVC, animated: false)
        
       
        present(navi, animated: true)
        
        HandleSelectionPhotosManager.share.getSelectedPhotos(with: 1) { (assets, images) in
            self.selimg = images[0]
            self.setActivtyClosure?(self.selectTag,self.selimg);
          self.presentingViewController?.dismiss(animated: true, completion: nil);
        }
        
        
    }
    
    func funcChooseFromCamera() -> Void{
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            
            //设置代理
            imagePicker.delegate = self
            //允许编辑
            imagePicker.isEditing = false;
            //设置图片源
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            //模态弹出IamgePickerView
            
            self.present(imagePicker, animated: true, completion: nil)
            
        }else{
            print("模拟器不支持拍照功能")
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //获取照片的原图
        let image = (info as NSDictionary).object(forKey: UIImagePickerControllerOriginalImage)as!UIImage
        //获得编辑后的图片
        //let image = (info as NSDictionary).object(forKey: UIImagePickerControllerEditedImage)as!UIImage
        self.selimg = image;
        self.setActivtyClosure?(self.selectTag,self.selimg);
        
        picker.dismiss(animated: true, completion: nil)
        
        self.presentingViewController?.dismiss(animated: true, completion: nil);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
