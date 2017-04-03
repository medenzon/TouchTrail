//
//  Trail.swift
//  TouchTrail
//
//  Created by Michael Edenzon on 4/2/17.
//  Copyright © 2017 Michael Edenzon. All rights reserved.
//

import Foundation
import UIKit

class Trail {
    
    private var _circles: [Circle]!
    var superview: UIView!
    
    var circles: [Circle] {
        get {
            return _circles
        }
    }
    
    init(in superview: UIView) {
        _circles = []
        self.superview = superview
    }
    
    func distance(from p1: CGPoint, to p2: CGPoint) ->CGFloat {
        return abs(p2.x-p1.x) + abs(p2.y-p1.y)
    }
    
    private func add(new circle: Circle) {
        _circles.append(circle)
        superview.addSubview(_circles.last!)
    }
    
    private func add(new circle: Circle, at index: Int) {
        _circles[index] = circle
        superview.addSubview(_circles[index])
    }
    
    func add(new point: CGPoint) {
        
        guard !_circles.isEmpty else { add(new: Circle(center: point)); return }
        
        if distance(from: _circles.last!.center, to: point) > Circle.diameter + 5 {
            if _circles.count < 15 {
                add(new: Circle(center: point))
            } else {
                _circles[0].removeFromSuperview()
                for i in 1..<_circles.count {
                    _circles[i-1] = _circles[i]
                }
                add(new: Circle(center: point), at: _circles.count - 1)
            }
        }
    }
    
    func clear() {
        _circles.removeAll()
    }
}
