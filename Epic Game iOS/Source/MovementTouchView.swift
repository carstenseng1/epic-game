//
//  MovementTouchView.swift
//  Epic Game iOS
//
//  Created by Garret Carstensen on 8/23/14.
//  Copyright (c) 2014 Garret Carstensen. All rights reserved.
//

import UIKit

@objc protocol MovementTouchViewDelegate: class {
    func movementTouchViewDidChangeValue(movementTouchView: MovementTouchView, value: CGVector)
}

class MovementTouchView: UIView {
    
    let panBeginLocationIndicatorView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    let panLocationIndicatorView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    
    let sensitivity: CGFloat = 1
    
    var delegate: MovementTouchViewDelegate?
    
    required init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "panGestureRecognizerAction:")
        self.addGestureRecognizer(panGestureRecognizer)
        
        self.panBeginLocationIndicatorView.layer.cornerRadius = self.panBeginLocationIndicatorView.layer.frame.size.width * 0.5
        self.panBeginLocationIndicatorView.backgroundColor = UIColor.yellowColor().colorWithAlphaComponent(0.5)
        self.panLocationIndicatorView.layer.cornerRadius = self.panLocationIndicatorView.layer.frame.size.width * 0.5
        self.panLocationIndicatorView.backgroundColor = UIColor.greenColor().colorWithAlphaComponent(0.5)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = min(self.layer.bounds.size.width * 0.5, self.layer.bounds.size.height * 0.5)
    }
    
    func panGestureRecognizerAction(recognizer: UIPanGestureRecognizer!) {
        switch recognizer.state {
        case UIGestureRecognizerState.Began:
            let location = recognizer.locationInView(recognizer.view)
            
            self.panBeginLocationIndicatorView.center = location
            recognizer.view.addSubview(self.panBeginLocationIndicatorView)
            
            self.panLocationIndicatorView.center = location
            self.addSubview(self.panLocationIndicatorView)
            
        case UIGestureRecognizerState.Changed:
            let location = recognizer.locationInView(recognizer.view)
            
            var translation: CGPoint = recognizer.translationInView(nil);
            let length: CGFloat = translation.length()
            let maxLength: CGFloat = min(self.bounds.size.width, self.bounds.size.height)
            if length > maxLength {
                translation = translation.normalize().multiplyBy(maxLength)
                self.panLocationIndicatorView.center = self.panBeginLocationIndicatorView.center.addTo(translation)
            } else {
                self.panLocationIndicatorView.center = location
            }
            let value = CGVectorMake(translation.x * self.sensitivity, -translation.y * self.sensitivity)
            self.delegate?.movementTouchViewDidChangeValue(self, value: value)
            
        case UIGestureRecognizerState.Ended, UIGestureRecognizerState.Cancelled:
            self.panBeginLocationIndicatorView.removeFromSuperview()
            self.panLocationIndicatorView.removeFromSuperview()
            
            self.delegate?.movementTouchViewDidChangeValue(self, value: CGVector.zeroVector)
            
        default:
            println("pan state: \(recognizer.state)")
        }
    }
}
