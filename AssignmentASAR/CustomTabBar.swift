//
//  CustomTabBar.swift
//  Assignment
//
//  Created by Sameer Jain on 05/08/24.
//

import Foundation
import UIKit

@IBDesignable
class CustomTabBar: UITabBar {
    
    
    private let circleView = UIView()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 50)
        
        UIColor.white.setFill()
        path.fill()
        
        UIColor.white.setStroke()
        path.lineWidth = 1
        path.stroke()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowRadius = 8
        self.layer.shadowOpacity = 0.3
        self.layer.masksToBounds = false
    }
}
