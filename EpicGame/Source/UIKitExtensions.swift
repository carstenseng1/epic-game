//
//  UIKitExtensions.swift
//  Epic Game iOS
//
//  Created by Garret Carstensen on 8/17/14.
//  Copyright (c) 2014 Garret Carstensen. All rights reserved.
//

import Foundation
import UIKit

func CGFloatMean(values: CGFloat...) -> CGFloat {
    var sum: CGFloat = 0
    for value in values {
        sum += value
    }
    return sum / (CGFloat)(values.count);
}

extension CGPoint {
    func translate(x: CGFloat, _ y: CGFloat) -> CGPoint {
        return CGPointMake(self.x + x, self.y + y)
    }
    func translateX(x: CGFloat) -> CGPoint {
        return CGPointMake(self.x + x, self.y)
    }
    func translateY(y: CGFloat) -> CGPoint {
        return CGPointMake(self.x, self.y + y)
    }
    
    func addTo(a: CGPoint) -> CGPoint{
        return CGPointMake(self.x+a.x, self.y+a.y)
    }
    func deltaTo(a: CGPoint) -> CGPoint{
        return CGPointMake(self.x-a.x, self.y-a.y)
    }
    func multiplyBy(value:CGFloat) -> CGPoint{
        return CGPointMake(self.x*value, self.y*value)
    }
    
    func length() -> CGFloat {
        return CGFloat(sqrt(CDouble(
            self.x*self.x + self.y*self.y
            )))
    }
    func normalize() -> CGPoint {
        let l = self.length()
        return CGPointMake(self.x / l, self.y / l)
    }
}

extension CGSize {
    func scale(value:CGFloat) -> CGSize {
        return CGSizeMake(self.width * value, self.height * value)
    }
}

extension CGVector {
    func translate(x: CGFloat, _ y: CGFloat) -> CGVector {
        return CGVectorMake(self.dx + x, self.dy + y)
    }
    func translateX(x: CGFloat) -> CGVector {
        return CGVectorMake(self.dx + x, self.dy)
    }
    func translateY(y: CGFloat) -> CGVector {
        return CGVectorMake(self.dx, self.dy + y)
    }
    
    func addTo(a: CGVector) -> CGVector {
        return CGVectorMake(self.dx + a.dx, self.dy + a.dy)
    }
    func deltaTo(a: CGVector) -> CGVector {
        return CGVectorMake(self.dx - a.dx, self.dy - a.dy)
    }
    func multiplyBy(value:CGFloat) -> CGVector {
        return CGVectorMake(self.dx * value, self.dy * value)
    }
    
    func length() -> CGFloat {
        return CGFloat(sqrt(CDouble(
            self.dx * self.dx + self.dy * self.dy
            )))
    }
    func normalize() -> CGPoint {
        let l = self.length()
        return CGPointMake(self.dx / l, self.dy / l)
    }
}