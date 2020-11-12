//
//  GradientView.swift
//  Task1
//
//  Created by apple on 03/11/20.
//  Copyright © 2020 apple. All rights reserved.
//
import UIKit
import CoreGraphics

@IBDesignable
class GradientArcView: ScaleView {
    
    @IBInspectable var startColor: UIColor = .white { didSet { setNeedsLayout() } }
    @IBInspectable var endColor:   UIColor = .blue  { didSet { setNeedsLayout() } }
    @IBInspectable var lineWidth:  CGFloat = 5      { didSet { setNeedsLayout() } }
    
//    let anim = CABasicAnimation(keyPath: "locations")
    var arrowView: UIView? = nil
    
    private var startLocations = [0.0, 0.0]
    private var endLocations = [0.0, 0.0]
    
    private var moveAlongPath:CAAnimation!
    private let arcLayer = CAShapeLayer()
    private var animationDuration: CGFloat = 1
    
    private var currentProgress: CGFloat = 5 {
        didSet {
            startLocations = endLocations

            let end = Double(currentProgress/10)
            
            endLocations = [end - 0.02, end + 0.02]
            
            addAnimation(from: CGFloat((startLocations.last! - 0.02)), to: CGFloat(end))
            addImgAnimation(from: CGFloat((startLocations.last! - 0.02) * 10), to: CGFloat(end * 10))
        }
    }
    
    private let gradientLayer: CAGradientLayer = {
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.type = .axial
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0) // CGPoint(x: 0.5, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0) // CGPoint(x: 1, y: 0.5)
        gradientLayer.locations = [0.0, 0.0] //startLocations as [NSNumber]
        
        return gradientLayer
    }()
    
    
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)

        
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        configure()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        refCenter = CGPoint(x: bounds.midX, y: bounds.maxY + centerOffset) //
        
        updateGradient()
        addArrowImage()
    }
    
    
}

extension GradientArcView {
    
    func updateCurrentProgress(value: CGFloat) {
        
        self.currentProgress = value
    }
    func updateAnimationDuration(duration: CGFloat) {
        
        self.animationDuration = duration
    }
}

private extension GradientArcView {
    
    func configure() {
        
        layer.addSublayer(gradientLayer)
    }
    
    func addArrowImage() {
        
        if arrowView != nil { return }
        arrowView = UIView(frame: CGRect(x: 35, y: bounds.maxY - centerOffset, width: 16, height: 16)) //
//        arrowView.backgroundColor = .red
        let heightWidth = arrowView!.frame.size.width
        let path = CGMutablePath()
        
        path.move(to: CGPoint(x: heightWidth/2 - 8, y: 0))
        path.addLine(to: CGPoint(x:heightWidth - 4, y: heightWidth/2))
        path.addLine(to: CGPoint(x:heightWidth/2 - 8, y:heightWidth))
        path.addLine(to: CGPoint(x:heightWidth/2 - 8, y:0))
        
        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5)
        
        arrowView!.layer.insertSublayer(shape, at: 0)
        
        arrowView!.layer.position = refCenter
        
        self.layer.addSublayer(arrowView!.layer)
        
        
    }
    
    func addImgAnimation(from: CGFloat, to: CGFloat) {
        
        let moveAlongPath = CAKeyframeAnimation(keyPath: "position")

        let radius = (bounds.width - (lineWidth + dashLong + 40))/2 //(min(bounds.width, bounds.height) - lineWidth) / 2
        
        let startAdd = (CGFloat.pi * from)/10
        let endAdd = (CGFloat.pi * to)/10
        
        let path = UIBezierPath(arcCenter: refCenter, radius: radius, startAngle: CGFloat.pi + startAdd, endAngle: CGFloat.pi + endAdd, clockwise: from < to)

        moveAlongPath.path = path.cgPath
        moveAlongPath.duration = CFTimeInterval(animationDuration)
        moveAlongPath.repeatCount = 1 //HUGE
        moveAlongPath.calculationMode = CAAnimationCalculationMode.paced
        moveAlongPath.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)]
        moveAlongPath.fillMode = .forwards
        moveAlongPath.isRemovedOnCompletion = false
        self.moveAlongPath = moveAlongPath
        

        arrowView?.layer.add(moveAlongPath, forKey: "move along path")
        UIView.animate(withDuration: 1) {
            self.arrowView?.transform = CGAffineTransform(rotationAngle: CGFloat.pi + endAdd)
        }
     
    }
    
    func updateGradient() {
        
        let radius = (bounds.width - (lineWidth + dashLong + 16))/2 //(min(bounds.width, bounds.height) - lineWidth) / 2

        let arcPath = UIBezierPath(arcCenter: refCenter, radius: radius, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 2, clockwise: true)
        
        let baseArc = CAShapeLayer()
        baseArc.fillColor = UIColor.clear.cgColor
        baseArc.strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5)
        baseArc.lineWidth = lineWidth
        baseArc.path = arcPath.cgPath
        self.layer.addSublayer(baseArc)
        
        arcLayer.fillColor = UIColor.clear.cgColor
        arcLayer.strokeColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        arcLayer.lineWidth = lineWidth
        arcLayer.path = arcPath.cgPath
        
        
        self.layer.addSublayer(arcLayer)
    }
    
    func addAnimation(from: CGFloat, to: CGFloat) {
        
        let newAnimation = CABasicAnimation(keyPath: "strokeEnd")
        newAnimation.fromValue = from
        newAnimation.toValue = to
        newAnimation.duration = CFTimeInterval(animationDuration)
        newAnimation.fillMode = .forwards
        newAnimation.isRemovedOnCompletion = false
        arcLayer.add(newAnimation, forKey: nil)
    }
}
enum TickStyle {
    case short
    case long
}

class ScaleView: UIView {
    
    var refCenter: CGPoint = CGPoint(x: 50, y: 50)
    
    var path: UIBezierPath!
    
    // ScaleView properties.  If any are changed, redraw the view
    var radius: CGFloat = 40           { didSet { self.setNeedsDisplay() } }
    var dashLong: CGFloat = 25        { didSet { self.setNeedsDisplay() } }
    var dashShort: CGFloat = 8       { didSet { self.setNeedsDisplay() } }
    var middle = CGPoint(x: 50, y: 50) { didSet { self.setNeedsDisplay() } }
    var leftAngle: CGFloat = .pi       { didSet { self.setNeedsDisplay() } }
    var rightAngle: CGFloat = 0        { didSet { self.setNeedsDisplay() } }
    var min: CGFloat = 45              { didSet { self.setNeedsDisplay() } }
    var max: CGFloat = 117             { didSet { self.setNeedsDisplay() } }
    var majorTickStep: CGFloat = 30
    var minorTickStep: CGFloat = 2.5
    
    var maxTickCount: CGFloat = 2 { didSet { self.setNeedsDisplay() } }
    var minTickCount: CGFloat = 5 { didSet { self.setNeedsDisplay() } }
    
    let centerOffset: CGFloat = 16
    
    
    override func draw(_ rect: CGRect) {
        
        refCenter = CGPoint(x: bounds.midX, y: bounds.maxY + centerOffset) //
        
        path = UIBezierPath()

        middle = refCenter //CGPoint(x: bounds.midX, y: bounds.maxY)
        radius = (bounds.width - 30)/2
        min = 0
        max = 2 * CGFloat.pi * radius
        majorTickStep = max/maxTickCount
            
        minorTickStep = majorTickStep/minTickCount
        
        // draw the arc
        path.move(to: CGPoint(x: middle.x - radius, y: middle.y))
//        path.addArc(withCenter: middle, radius: radius, startAngle: leftAngle, endAngle: rightAngle, clockwise: true)

        let startTick = ceil(min / 2.5) * 2.5
        let endTick = floor(max / 2.5) * 2.5

        // add tick marks every 2.5 units
        for value in stride(from: startTick, through: endTick, by: minorTickStep) {
            
            let style: TickStyle = value.truncatingRemainder(dividingBy: majorTickStep) == 0 ? .long : .short
            
            addTick(at: value, style: style, to: path)
        }

        // stroke the path
        #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7996533891).setStroke()
        path.lineWidth = 2
        path.stroke()
    }

    // add a tick mark at value with style to path
    func addTick(at value: CGFloat, style: TickStyle, to path: UIBezierPath) {
        let angle = (max - value)/(max - min) * .pi

        let p1 = CGPoint(x: middle.x + cos(angle) * radius,
                         y: middle.y - sin(angle) * radius)

        var radius2 = radius
        if style == .short {
            radius2 += dashShort
        } else if style == .long {
            radius2 += dashLong
        }

        let p2 = CGPoint(x: middle.x + cos(angle) * radius2,
                         y: middle.y - sin(angle) * radius2)

        path.move(to: p1)
        path.addLine(to: p2)
    }
}
