//
//  GradientView.swift
//  QuickChat
//
//  Created by thanhbh on 5/11/18.
//  Copyright © 2018 vinicorp. All rights reserved.
//

import UIKit

@IBDesignable class GradientView: UIView {
    
    @objc enum DegreeUnit: Int {
        case degree = 0, radian, gradian
    }
    
    @IBInspectable var degree: DegreeUnit = .radian {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var repeated: UInt = 0 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var resolution: UInt = 512 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var angle: Double = 0 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
//    @IBInspectable var topColor: UIColor = UIColor.red {
//        didSet {
//            self.setNeedsLayout()
//        }
//    }
//
//    @IBInspectable var bottomColor: UIColor = UIColor.purple {
//        didSet {
//            self.setNeedsLayout()
//        }
//    }
    
    fileprivate func customizedView() {
        let subdivisions:CGFloat = CGFloat(resolution / (repeated + 1))
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = []
        for i in 0 ..< 512 {
            let pointColor: CGColor = UIColor(hue: CGFloat(i)/subdivisions, saturation: 1, brightness: 1, alpha: 1).cgColor
            gradientLayer.colors?.append(pointColor)
        }
        //        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        let angleGrad = angle * Double.pi
        var x = 0.5 * cos(angleGrad)
        var y = 0.5 * sin(angleGrad)
        if x != 0 && abs(tan(angleGrad)) <= 1 {
            y = 0.5 * ( 1 + y / x)
            x = x < 0 ? 0 : 1
        } else {
            x = 0.5 * (1 + x / y)
            y = y < 0 ? 0 : 1
        }
        gradientLayer.startPoint = CGPoint(x: x, y: y)
        gradientLayer.endPoint = CGPoint(x: 1 - x, y: 1 - y)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func layoutSubviews() {
        customizedView()
    }
    
//    override func awakeFromNib() {
//        customizedView()
//    }
//
//    override func prepareForInterfaceBuilder() {
//        customizedView()
//    }
}
