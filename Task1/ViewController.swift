//
//  ViewController.swift
//  Task1
//
//  Created by apple on 03/11/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var viewOuter: GradientArcView!
    @IBOutlet weak var mainBgView: UIView!
    @IBOutlet weak var btnMin: UIButton!
    @IBOutlet weak var btnMax: UIButton!
    @IBOutlet weak var leftDaysBgView: UIView!
    
    @IBOutlet weak var lblPertValue: UILabel!
    @IBOutlet weak var lblLBValue: UILabel!
    @IBOutlet weak var btnAccpetInvite: UIButton!
    
    var startValue: CGFloat = 1
    var endValue: CGFloat = 10
    var currentProgress: CGFloat = 5 {
        didSet {
            viewOuter.updateCurrentProgress(value: currentProgress)
        }
    }
    var stepTickCount: CGFloat = 2
    var stepValue: CGFloat = 1
    var majorTicksCount: CGFloat = 2
    var minorTicksCount: CGFloat = 18
    

    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        handleUI()
        viewOuter.minTickCount = minorTicksCount
        viewOuter.maxTickCount = majorTicksCount
        stepValue = (((CGFloat(endValue)/majorTicksCount)/minorTicksCount) * stepTickCount)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
        viewOuter.updateCurrentProgress(value: 5)
        viewOuter.updateAnimationDuration(duration: 0.2)
    }
    
    override func viewDidLayoutSubviews() {
        
        leftDaysBgView.layer.cornerRadius = leftDaysBgView.frame.height/2
    }

    //MARK: - Functions
    private func handleUI() {
        
        btnMin.setTitle("\(Int(startValue))", for: .normal)
        btnMax.setTitle("\(Int(endValue))", for: .normal)
        btnAccpetInvite.layer.borderColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
        btnAccpetInvite.layer.borderWidth = 2
        
    }
    
    @IBAction func descProgress(_ sender: Any) {
        
        if currentProgress <= 0.0 { return }
        if currentProgress - stepValue < 0 {
            
            currentProgress = 0
        } else {
            currentProgress -= stepValue
        }
    }
    
    @IBAction func incProgress(_ sender: Any) {
        
        if currentProgress >= endValue { return }
        
        if currentProgress + stepValue > endValue {
            currentProgress = endValue
        } else {
            currentProgress += stepValue
        }
    }
}


extension UIView {
    
    
    func roundCorners(corners:CACornerMask, radius: CGFloat) {
        
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = corners
    }
}
class SemiCirleView: UIView {

    var semiCirleLayer: CAShapeLayer!

    override func layoutSubviews() {
        super.layoutSubviews()

        
    }
}
