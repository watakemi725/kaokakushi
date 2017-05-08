//
//  Stamp.swift
//  Kaokakushi
//
//  Created by Takemi Watanuki on 2016/10/14.
//  Copyright © 2016年 watakemi725. All rights reserved.
//

import UIKit

class Stamp: UIImageView,UIGestureRecognizerDelegate {
    var currentTransform:CGAffineTransform!
    var scale: CGFloat = 1.0
    var angle: CGFloat = 0
    var isMoving: Bool = false
    
    override func didMoveToSuperview() {
        let rotationRecognizer: UIRotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(Stamp.rotationGesture(_:)))
        rotationRecognizer.delegate = self
        self.addGestureRecognizer(rotationRecognizer)
//        imageView.addGestureRecognizer(rotationRecognizer)
        
        let pinchRecognizer: UIPinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(Stamp.pinchGesture(_:)))
        pinchRecognizer.delegate = self
        self.addGestureRecognizer(pinchRecognizer)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.superview?.bringSubview(toFront: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        
        let dx = touch.location(in: self.superview).x - touch.previousLocation(in: self.superview).x
        let dy = touch.location(in: self.superview).y - touch.previousLocation(in: self.superview).y
        
        self.center = CGPoint(x: self.center.x+dx, y: self.center.y+dy)
    }
    
    func rotationGesture(_ gesture: UIRotationGestureRecognizer){
        print("rotation")
        if !isMoving && gesture.state == UIGestureRecognizerState.began {
            isMoving = true
            currentTransform = self.transform
        }
        else if isMoving && gesture.state == UIGestureRecognizerState.ended{
            isMoving = false
            scale = 1.0
            angle = 0.0
        }
        
        angle = gesture.rotation
        
        let transform = currentTransform.concatenating(CGAffineTransform(rotationAngle: angle)).concatenating(CGAffineTransform(scaleX: scale, y: scale))
        self.transform = transform
        
    }
    
    func pinchGesture(_ gesture: UIPinchGestureRecognizer){
        print("pinch")
        if !isMoving && gesture.state == UIGestureRecognizerState.began {
            isMoving = true
            currentTransform = self.transform
        }
        else if isMoving && gesture.state == UIGestureRecognizerState.ended{
            isMoving = false
            scale = 1.0
            angle = 0.0
        }
        
        scale = gesture.scale
        
        let transform = currentTransform.concatenating(CGAffineTransform(rotationAngle: angle)).concatenating(CGAffineTransform(scaleX: scale, y: scale))
        self.transform = transform
        
        
    }
}
