////
////  Dummy.swift
////  Task1
////
////  Created by apple on 03/11/20.
////  Copyright © 2020 apple. All rights reserved.
////
//
//import Foundation
//import UIKit
//import CoreGraphics
//class ViewController: UIViewController {
//
//    var moveAlongPath:CAAnimation!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        addAnimation()
//        initiateAnimation()
//    }
//
//    func curevedPath() -> UIBezierPath {
//
//        let path = createCurvePath()
//
//        let shapeLayer = CAShapeLayer()
//        shapeLayer.path = path.cgPath
//        shapeLayer.strokeColor = UIColor.blue.cgColor
//        shapeLayer.fillColor = UIColor.clear.cgColor
//        shapeLayer.lineWidth = 1.0
//        self.view.layer.addSublayer(shapeLayer)
//        return path
//    }
//
//
//    func addAnimation() {
//        let moveAlongPath = CAKeyframeAnimation(keyPath: "position")
//        moveAlongPath.path = curevedPath().cgPath
//        moveAlongPath.duration = 5
//        moveAlongPath.repeatCount = HUGE
//        moveAlongPath.calculationMode = CAAnimationCalculationMode.paced
//        moveAlongPath.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)]
//        self.moveAlongPath = moveAlongPath
//    }
//
//    func initiateAnimation() {
//        let layer = createLayer()
//        layer.add(moveAlongPath, forKey: "animate along Path")
//    }
//
//    //MARK:- Custom View Path
//    func createLayer() -> CALayer {
//        let customView  = CustomView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
//        self.view.addSubview(customView)
//        let customlayer = customView.layer
//        customlayer.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
//        customlayer.position = CGPoint(x: 25, y: 25)
//        return customlayer
//      }
//
//    //MARK:- Custom Curve Path
//    func createCurvePath() -> UIBezierPath {
//        let path = UIBezierPath()
//        path.move(to: CGPoint(x: 10, y: 200))
//        path.addQuadCurve(to: CGPoint(x: 300, y: 200), controlPoint: CGPoint(x: 150, y: 10) )
//        return path
//    }
//
//}
//
//
//class CustomView:UIView {
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setUpView()
//    }
//
//    func setUpView() {
//        let image = UIImage(named: "Go.png")
//        let imageView = UIImageView(image: image)
//        imageView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
//        addSubview(imageView)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//}
