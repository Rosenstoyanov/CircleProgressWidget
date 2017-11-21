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
        
        let background = CALayer()
        background.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        background.backgroundColor = black.cgColor
        self.layer.addSublayer(background)
        let center = CGPoint(x: newDimension/2,y: newDimension/2)
        let radius = CGFloat(newDimension/2)
        
        drawCircleInNewLayer(circleCenter: center, radius: radius, circleColor: blue.cgColor)
        
        drawCircleInNewLayer(circleCenter: center, radius: radius - 10, circleColor: darkGray.cgColor)
        
        drawCircleInNewLayer(circleCenter: center, radius: radius - 20, circleColor: gray.cgColor)
        
//        let layer = CAShapeLayer()
//        drawArcInLayer(circleCenter: center, radius: radius - 20, circleColor: lightBlue.cgColor, startAngle: CGFloat(140).degrees(), endAngle: CGFloat(122 / (radius - 25)), layer: layer)
//        self.layer.addSublayer(layer)
        
        drawCircleWithLineDashesInLayer(circleCenter: center, radius: radius - 25, dashColor: darkRed.cgColor, startAngle: CGFloat(140).degrees(), endAngle: CGFloat(40).degrees(), lineWidth: 10, lineDashPattern: [0.0, 30.5])
        
        drawCircleWithLineDashesInLayer(circleCenter: center, radius: radius - 25, dashColor: black.cgColor, startAngle: CGFloat(140).degrees(), endAngle: CGFloat(40).degrees(), lineWidth: 20, lineDashPattern: [0.0, 122])
        
        print("radius: \(radius - 25) sin: \(122 / (radius - 25))")
        drawCircleInNewLayer(circleCenter: center, radius: CGFloat(15), circleColor: lightBlue.cgColor)
    }
    
    func drawCircleInNewLayer(circleCenter: CGPoint, radius: CGFloat, circleColor: CGColor) {
        let circleLayer = CAShapeLayer()
        drawArcInLayer(circleCenter: circleCenter, radius: radius, circleColor: circleColor, startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), layer: circleLayer)
        self.layer.addSublayer(circleLayer)
    }
    
    func drawArcInLayer(circleCenter: CGPoint, radius: CGFloat, circleColor: CGColor, startAngle: CGFloat, endAngle: CGFloat, layer: CAShapeLayer) {
        let arcPath = UIBezierPath(arcCenter: circleCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        layer.path = arcPath.cgPath
        layer.fillColor = circleColor
    }
    
    func drawCircleWithLineDashesInLayer(circleCenter: CGPoint, radius: CGFloat, dashColor: CGColor, startAngle: CGFloat, endAngle: CGFloat, lineWidth: CGFloat, lineDashPattern: [NSNumber]) {
        let layer = CAShapeLayer()
        let arcPath = UIBezierPath(arcCenter: circleCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        //        let  dashes: [ CGFloat ] = [ 15.0, 20.0 ]
        //        arcPath.setLineDash(dashes, count: dashes.count, phase: 0.0)
        layer.path = arcPath.cgPath
        layer.strokeColor = dashColor
        layer.lineWidth = lineWidth //10
        //        layer.lineDashPhase = 10
        layer.fillColor = UIColor.clear.cgColor
        layer.lineDashPattern = lineDashPattern //[ 0.0, 10.0 ]
        self.layer.addSublayer(layer)
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
