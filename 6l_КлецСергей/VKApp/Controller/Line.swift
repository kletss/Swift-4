//
//  Line.swift
//  VKApp
//
//  Created by KKK on 13.04.2021.
//

import UIKit

class Line: UIView {
        
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setStrokeColor(UIColor.red.cgColor)
        context.move(to: CGPoint(x: 100, y: 300))
        context.addLine(to: CGPoint(x: 300, y: 300))
        context.addLine(to: CGPoint(x: 100, y: 200))

        context.closePath()
        context.strokePath()
    }
    

}
