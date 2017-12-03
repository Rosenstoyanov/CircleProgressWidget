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
    let lighterBlue = UIColor(hex: "dee9eb")
    let gray = UIColor(hex: "f0f0f0")
    let darkGray = UIColor(hex: "d2d2d0")
    let darkerGray = UIColor(hex: "598b98")
    let darkRed = UIColor(hex: "bb430e")
    let ligthRed = UIColor(hex: "e05011")
    let black = UIColor(hex: "000000")
    
    var wigetCenter: CGPoint
    var radius: CGFloat
    var viewFrame: CGRect
    let sectorsSizes = [0, 20, 40, 60, 80, 100]
    

    @IBInspectable
    var firstSectorColor: UIColor = UIColor(hex: "dee9eb") {
        didSet {
            prepare()
        }
    }
    @IBInspectable
    var secondSectorColor: UIColor = UIColor(hex: "22b4e7") {
        didSet {
            prepare()
        }
    }
    @IBInspectable
    var thirthSectorColor: UIColor = UIColor(hex: "598b98") {
        didSet {
            prepare()
        }
    }
    @IBInspectable
    var fourthSectorColor: UIColor = UIColor(hex: "bb430e") {
        didSet {
            prepare()
        }
    }
    @IBInspectable
    var fifthSectorColor: UIColor = UIColor(hex: "e05011") {
        didSet {
            prepare()
        }
    }
    @IBInspectable
    var arrowDegree: Int = 0 {
        didSet {
            prepare()
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
        
        drawArcs(center: wigetCenter, radius: radius)
        
        drawaLines(center: wigetCenter, radius: radius, color: blue.cgColor)
        
        let layer = CAShapeLayer()
        layer.frame = self.viewFrame
        let p1 = CGPoint(x: wigetCenter.x - 10, y: wigetCenter.y)
        let p2 = CGPoint(x: wigetCenter.x + 10, y: wigetCenter.y)
        let p3 = CGPoint(x: wigetCenter.x, y: wigetCenter.y - radius + 25)
        drawTriangle(firstPoint: p1, secondPoint: p2, thirthPoint: p3, color: lightBlue.cgColor, layer: layer)
        let triangleTranfrom = CATransform3DMakeRotation(CGFloat(arrowDegree).radians(), 0, 0, 1)
        layer.transform = triangleTranfrom
        
        
        drawLastSmallBlueCircle(color: lightBlue.cgColor)
    }
    
    func drawArcs(center: CGPoint, radius: CGFloat){
        var start = -1;
        for (index, element) in sectorsSizes.enumerated() {
            if start != -1 {
                let startAngle = 140.0 + (Double(start) * 2.6)
                let end = Double(140.0) + (Double(element) * Double(2.6))
                
                print("start angle: \(startAngle) end angle \(end)")

                var color = darkRed.cgColor;
                switch index {
                case 1:
                    color = firstSectorColor.cgColor
                case 2:
                    color = secondSectorColor.cgColor
                case 3:
                    color = thirthSectorColor.cgColor
                case 4:
                    color = fourthSectorColor.cgColor
                case 5:
                    color = fifthSectorColor.cgColor
                default:
                    color = darkRed.cgColor
                }
                let layer = CAShapeLayer()
                drawStrokeArcInLayer(circleCenter: wigetCenter, radius: radius - 25, circleColor: color, startAngle: CGFloat(startAngle).radians(), endAngle: CGFloat(end).radians(), layer: layer)
                self.layer.addSublayer(layer)
            }
            start = element
        }
        
    }
    
    func drawaLines(center: CGPoint, radius: CGFloat, color: CGColor) {
        
        let circleEdjePoint = CGPoint(x: center.x, y: 20)
        let circleSecondPointPoint = CGPoint(x: center.x, y: 40 )
        
        for itemSize in sectorsSizes {
            let item = Int(Double(itemSize) * 2.6)
            let myLayer = CAShapeLayer()
            myLayer.frame = viewFrame
            let path = UIBezierPath()
            
            path.move(to: circleEdjePoint)
            path.addLine(to: circleSecondPointPoint)
            path.close()
            
            myLayer.path = path.cgPath
            myLayer.lineWidth = 1
            myLayer.fillColor = color
            myLayer.strokeColor = color
            
            let degreeRotation: Int = (130 - item) * -1
            
            let textLayer = CATextLayer()
            textLayer.frame = CGRect(x: center.x - 15, y: 45, width: 30, height: 25)
            textLayer.string = "\(itemSize)"
            textLayer.fontSize = 15
            textLayer.alignmentMode = kCAAlignmentCenter
            textLayer.foregroundColor = darkRed.cgColor
            
            let labelTransform = CATransform3DMakeRotation(CGFloat(degreeRotation * -1).radians(), 0, 0, 1)
            textLayer.transform = labelTransform
            myLayer.addSublayer(textLayer)
            
            print("rotation \(degreeRotation)")
            let myTransf = CATransform3DMakeRotation(CGFloat(degreeRotation).radians(), 0, 0, 1)
            myLayer.transform = myTransf
            
            myLayer.path = path.cgPath
            myLayer.fillColor = color
            myLayer.strokeColor = color
        
            self.layer.addSublayer(myLayer)
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
    func radians() -> CGFloat {
        return self * .pi / 180
    }
    
    init(degrees: CGFloat) {
        self = degrees.radians()
    }
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
