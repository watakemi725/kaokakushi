//
//  StampViewController.swift
//  Kaokakushi
//
//  Created by Takemi Watanuki on 2016/10/14.
//  Copyright © 2016年 watakemi725. All rights reserved.
//

import UIKit
import CoreImage

extension UIImage{
    
    // UIImageをリサイズするメソッド.
    class func ResizeUIImage(_ image : UIImage,width : CGFloat, height : CGFloat)-> UIImage!{
        
        // 指定された画像の大きさのコンテキストを用意.
        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
        
        // コンテキストに自身に設定された画像を描画する.
        image.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        
        // コンテキストからUIImageを作る.
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // コンテキストを閉じる.
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

class StampViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet var canvasView:UIView!
    @IBOutlet var imageView:UIImageView!
    
    var imageArray:[UIImage] = []
    
    var stampArray: [Stamp] = []
    var isNewStampAdded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 1...5 {
            imageArray.append(UIImage(named: "\(i).png")!)
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func cameraTap(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.camera
        self.present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func albumTap(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(pickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imageView.image = info["UIImagePickerControllerOriginalImage"] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func stamp1(_ sender: AnyObject){
        
        let stamp = Stamp()
        stamp.image = imageArray[sender.tag]
        stamp.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        stamp.center = imageView.center
        stamp.isUserInteractionEnabled = true
        canvasView.addSubview(stamp)
        stampArray.append(stamp)
        isNewStampAdded = true
        
        
    }
    
    @IBAction func deleteTap(){
        if canvasView.subviews.count>1 {
            let lastSubView = canvasView.subviews.last! 
            lastSubView.removeFromSuperview()
            if lastSubView.isKind(of: Stamp.self) {
                let stamp = lastSubView as! Stamp
                if let index = stampArray.index(of: stamp) {
                    stampArray.remove(at: index)
                }
            }
        }
    }
    
    
    @IBAction func saveTap(){
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size,canvasView.isOpaque, 0.0)
        canvasView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        UIImageWriteToSavedPhotosAlbum(image, self,#selector(StampViewController.image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    func image(_ image:UIImage,didFinishSavingWithError error:NSError!,contextInfo: UnsafeMutableRawPointer){
        let alert = UIAlertView()
        alert.title = "保存"
        alert.message = "保存完了ですん"
        alert.addButton(withTitle: "OK")
        alert.show()
    }
    
    @IBAction func makeFacePrint(){
        
        let myImage : UIImage = UIImage.ResizeUIImage(self.imageView.image!, width: self.imageView.frame.width, height: self.imageView.frame.height)
        //UIImage.ResizeÜIImage(imageView.image)!, width: self.imageView.frame.width , height: self.imageView.frame.height)
        
        // NSDictionary型のoptionを生成。顔認識の精度を追加する.
        let options : NSDictionary = NSDictionary(object: CIDetectorAccuracyHigh, forKey: CIDetectorAccuracy as NSCopying)
        
        // CIDetectorを生成。顔認識をするのでTypeはCIDetectorTypeFace.
        let detector : CIDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: options as? [String : AnyObject])!
        
        // detectorで認識した顔のデータを入れておくNSArray.
        let faces : NSArray = detector.features(in: CIImage(image: myImage)!) as NSArray
        
        // UIKitは画面左上に原点があるが、CoreImageは画面左下に原点があるのでそれを揃えなくてはならない.
        // CoreImageとUIKitの原点を画面左上に統一する処理.
        var transform : CGAffineTransform = CGAffineTransform(scaleX: 1, y: -1)
        transform = transform.translatedBy(x: 0, y: -canvasView.bounds.size.height)
        
        // 検出された顔のデータをCIFaceFeatureで処理.
        for feature in faces {
            
            // 座標変換.
            let faceRect : CGRect = ((feature as AnyObject).bounds).applying(transform)
            
            // 画像の顔の周りを線で囲うUIViewを生成.
            let faceOutline = UIView(frame: faceRect)
            faceOutline.layer.borderWidth = 3
            faceOutline.layer.borderColor = UIColor.red.cgColor
            canvasView.addSubview(faceOutline)
        }
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
