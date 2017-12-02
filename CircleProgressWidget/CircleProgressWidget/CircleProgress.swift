//
//  CircleProgress.swift
//  CircleProgressWidget
//
//  Created by Rosen Stoyanov on 21.11.17.
//  Copyright © 2017 Rosen Stoyanov. All rights reserved.
//

import UIKit
@IBDesignable
class CircleProgress: UIView {
    let blue = UIColor(hex: "22b4e7")
    let lightBlue = UIColor(hex: "13b6f1")
    let gray = UIColor(hex: "f0f0f0")
    let darkGray = UIColor(hex: "d2d2d0")
    let darkRed = UIColor(hex: "bb430e")
    let ligthRed = UIColor(hex: "e05011")
    let black = UIColor(hex: "000000")
    
    var wigetCenter: CGPoint
    var radius: CGFloat
    var viewFrame: CGRect
    
    @IBInspectable
    var firstArcColor: CGColor? {
        didSet {
            prepare();
        }
    }
    
    override init(frame: CGRect) {
        wigetCenter = CGPoint(x: 0.0, y: 0.0)
        radius = 0.0
        viewFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
        super.init(frame: frame)
        prepare()
    }
    
    required init?(coder aDecoder: NSCoder) {
        wigetCenter = CGPoint(x: 0.0, y: 0.0)
        radius = 0.0
        viewFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
        super.init(coder: aDecoder)
        prepare()
    }
    
    func drawFirstBackgroundCircle(color: CGColor) {
        drawCircleInNewLayer(circleCenter: wigetCenter, radius: radius, circleColor: color)
    }
    
    func drawSecondBackgroundCircle(color: CGColor) {
        drawCircleInNewLayer(circleCenter: wigetCenter, radius: radius - 10, circleColor: color)
    }
    
    func drawThirthBackgroundCircle(color: CGColor) {
        drawCircleInNewLayer(circleCenter: wigetCenter, radius: radius - 20, circleColor: color)
    }
    
    func drawLastSmallBlueCircle(color: CGColor) {
        drawCircleInNewLayer(circleCenter: wigetCenter, radius: CGFloat(20), circleColor: color)
    }
    
    func prepare() {
        //TODO: add rect witch should me square
        let width = self.frame.width
        let heigth = self.frame.height
        let newDimension = min(width, heigth)
        viewFrame = CGRect(x: 0, y: 0, width: newDimension, height: newDimension)
        
        let background = CALayer()
        background.frame = viewFrame
        background.backgroundColor = black.cgColor
        self.layer.addSublayer(background)
        
        wigetCenter = CGPoint(x: newDimension/2, y: newDimension/2)
        radius = CGFloat(newDimension/2)
        
        drawFirstBackgroundCircle(color: blue.cgColor)
        
        drawSecondBackgroundCircle(color: darkGray.cgColor)
        
        drawThirthBackgroundCircle(color: gray.cgColor)
        
//        let layer = CAShapeLayer()
//        drawArcInLayer(circleCenter: center, radius: radius - 20, circleColor: lightBlue.cgColor, startAngle: CGFloat(140).degrees(), endAngle: CGFloat(122 / (radius - 25)), layer: layer)
//        self.layer.addSublayer(layer)
        
//        drawCircleWithLineDashesInLayer(circleCenter: wigetCenter, radius: radius - 25, dashColor: darkRed.cgColor, startAngle: CGFloat(140).degrees(), endAngle: CGFloat(40).degrees(), lineWidth: 10, lineDashPattern: [0.0, 30.5])
//
//        drawCircleWithLineDashesInLayer(circleCenter: wigetCenter, radius: radius - 25, dashColor: black.cgColor, startAngle: CGFloat(140).degrees(), endAngle: CGFloat(40).degrees(), lineWidth: 20, lineDashPattern: [0.0, 122])
        
        //360 / 8 = 45 each arc
        //360 - 2*45 = 270
        //360 - 45 = 315
        //270 degrees to be splited in 6
        // 1,45,90,135,180,225,270,270
        //big arc starts from 180+45=225 ends at 360-45=315
        
//        let arcLayer = CAShapeLayer()
//        drawStrokeArcInLayer(circleCenter: wigetCenter, radius: radius - 20, circleColor: ligthRed.cgColor, startAngle: CGFloat(0).degrees(), endAngle: CGFloat(220).degrees(), layer: arcLayer)
//        self.layer.addSublayer(arcLayer)
        
        drawArcs(center: wigetCenter, radius: radius)
        
//        drawaLines(center: wigetCenter, radius: radius, color: blue.cgColor)
        
        let layer = CAShapeLayer()
//        15
        let p1 = CGPoint(x: wigetCenter.x - 10, y: wigetCenter.y)
        let p2 = CGPoint(x: wigetCenter.x + 10, y: wigetCenter.y)
        let p3 = CGPoint(x: wigetCenter.x, y: wigetCenter.y - radius + 25)
        drawTriangle(firstPoint: p1, secondPoint: p2, thirthPoint: p3, color: lightBlue.cgColor, layer: layer)
        drawLastSmallBlueCircle(color: lightBlue.cgColor)
    }
    
    func drawArcs(center: CGPoint, radius: CGFloat){
        let sectorsSizes = [0, 20, 40, 60, 80, 100]
        
        var start = -1;
        for (index, element) in sectorsSizes.enumerated() {
            if start != -1 {
                let startAngle = 140.0 + (Double(start) * 2.6)
                let end = Double(140.0) + (Double(element) * Double(2.6))
                
                print("start angle: \(startAngle) end angle \(end)")

                var color = darkRed.cgColor;
                switch index {
                case 1:
                    color = darkRed.cgColor
                case 2:
                    color = blue.cgColor
                case 3:
                    color = ligthRed.cgColor
                case 4:
                    color = blue.cgColor
                case 5:
                    color = darkRed.cgColor
                default:
                    color = darkRed.cgColor
                }
                let layer = CAShapeLayer()
                drawStrokeArcInLayer(circleCenter: wigetCenter, radius: radius - 25, circleColor: color, startAngle: CGFloat(startAngle).degrees(), endAngle: CGFloat(end).degrees(), layer: layer)
                self.layer.addSublayer(layer)
            }
            start = element
        }
        
    }
    
    
    
    func drawCircleInNewLayer(circleCenter: CGPoint, radius: CGFloat, circleColor: CGColor) {
        let circleLayer = CAShapeLayer()
        circleLayer.frame = viewFrame
        drawArcInLayer(circleCenter: circleCenter, radius: radius, circleColor: circleColor, startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), layer: circleLayer)
        self.layer.addSublayer(circleLayer)
    }
    
    func drawStrokeArcInLayer(circleCenter: CGPoint, radius: CGFloat, circleColor: CGColor, startAngle: CGFloat, endAngle: CGFloat, layer: CAShapeLayer) {
        let arcPath = UIBezierPath(arcCenter: circleCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
//        arcPath.lineWidth = 140
        
        layer.lineWidth = 15
        layer.path = arcPath.cgPath
        layer.strokeColor = circleColor
        layer.fillColor = UIColor.clear.cgColor
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
    
    func drawTriangle(firstPoint: CGPoint, secondPoint: CGPoint, thirthPoint: CGPoint, color: CGColor, layer: CAShapeLayer) {
        let path = UIBezierPath()
        path.move(to: firstPoint)
        path.addLine(to: secondPoint)
        path.addLine(to: thirthPoint)
        path.addLine(to: firstPoint)
        path.close()
        
        layer.path = path.cgPath
        layer.fillColor = color
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
