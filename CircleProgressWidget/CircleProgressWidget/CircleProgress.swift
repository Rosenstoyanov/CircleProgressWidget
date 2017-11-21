//
//  CircleProgress.swift
//  CircleProgressWidget
//
//  Created by Rosen Stoyanov on 21.11.17.
//  Copyright © 2017 Rosen Stoyanov. All rights reserved.
//

import UIKit

class CircleProgress: UIView {
    let blue = UIColor(hex: "22b4e7")
    let lightBlue = UIColor(hex: "13b6f1")
    let gray = UIColor(hex: "f0f0f0")
    let darkGray = UIColor(hex: "d2d2d0")
    let darkRed = UIColor(hex: "bb430e")
    let ligthRed = UIColor(hex: "e05011")
    let black = UIColor(hex: "000000")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepare()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepare()
    }
    
    func prepare() {
        //TODO: add rect witch should me square
        let width = self.frame.width
        let heigth = self.frame.height
        let newDimension = min(width, heigth)
        self.frame = CGRect(x: 0, y: 0, width: newDimension, height: newDimension)
    }

}

extension CGFloat {
    func degrees() -> CGFloat {
        return self * .pi / 180
    }
    
    init(degrees: CGFloat) {
        self = degrees.degrees()
    }
}

extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}
