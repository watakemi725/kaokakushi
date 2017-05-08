//
//  ViewController.swift
//  Kaokakushi
//
//  Created by Takemi Watanuki on 2016/10/07.
//  Copyright © 2016年 watakemi725. All rights reserved.
//

import UIKit
import CoreImage

extension UIImage{
    
    // UIImageをリサイズするメソッド.
    class func ResizeUIImage2(_ image : UIImage,width : CGFloat, height : CGFloat)-> UIImage!{
        
        // 指定された画像の大きさのコンテキストを用意.
        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
        
        // コンテキストに自身に設定された画像を描画する.
//        image.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        
        // コンテキストからUIImageを作る.
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // コンテキストを閉じる.
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myImage : UIImage!
        
//        myImage = UIImage.ResizeUIImage(image: UIImage(named: "IMG_2465.JPG")!, width: self.view.frame.width, height: self.view.frame.width)
//        
//        // UIImageViewの生成.
//        let myImageView : UIImageView = UIImageView()
//        myImageView.contentMode = UIViewContentMode.scaleAspectFit
//        myImageView.frame = CGRect(x: 0, y: 0, width: myImage.size.width, height: myImage.size.height)
//        myImageView.image = myImage
//        
//        self.view.addSubview(myImageView)
//        
//        // NSDictionary型のoptionを生成。顔認識の精度を追加する.
//        let options : NSDictionary = NSDictionary(object: CIDetectorAccuracyHigh, forKey: CIDetectorAccuracy as NSCopying)
//        
//        // CIDetectorを生成。顔認識をするのでTypeはCIDetectorTypeFace.
//        let detector : CIDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: options as? [String : AnyObject])!
//        
//        // detectorで認識した顔のデータを入れておくNSArray.
//        let faces : NSArray = detector.features(in: CIImage(image: myImage)!) as NSArray
//        
//        // UIKitは画面左上に原点があるが、CoreImageは画面左下に原点があるのでそれを揃えなくてはならない.
//        // CoreImageとUIKitの原点を画面左上に統一する処理.
//        var transform : CGAffineTransform = CGAffineTransform(scaleX: 1, y: -1)
//        transform = transform.translatedBy(x: 0, y: -myImageView.bounds.size.height)
//        
//        // 検出された顔のデータをCIFaceFeatureで処理.
//        for feature in faces {
//            
//            // 座標変換.
//            let faceRect : CGRect = (feature as AnyObject).bounds.applying(transform)
//            
//            //画像を
//            let myImage1 : UIImage = UIImage.ResizeUIImage(image: UIImage(named: "smile1.png")!, width: faceRect.width, height: faceRect.height)
//            
//            // UIImageViewの生成.
//            let myImageView1 : UIImageView = UIImageView()
//            myImageView1.frame = faceRect//CGRect(x: 0, y: 0, width: myImage1.size.width, height: myImage1.size.height)
////            myImageView1.contentMode = UIViewContentMode.UIViewContentModeScaleAspectFit
//            myImageView1.image = myImage1
//        
//            
//            
//            // 画像の顔の周りを線で囲うUIViewを生成.
//            let faceOutline = UIView(frame: faceRect)
//            faceOutline.layer.borderWidth = 1
//            faceOutline.layer.borderColor = UIColor.red.cgColor
//            faceOutline.backgroundColor = UIColor.white
//            myImageView.addSubview(myImageView1)
//        }
    }
    
}

