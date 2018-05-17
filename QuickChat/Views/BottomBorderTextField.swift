//
//  BottomBorderTextField.swift
//  QuickChat
//
//  Created by thanhbh on 5/11/18.
//  Copyright © 2018 vinicorp. All rights reserved.
//

import UIKit

@IBDesignable class BottomBorderTextField: UITextField {
    
    @IBInspectable var bottomBorderWidth: CGFloat = 2.0 {
        didSet {
            customizedView()
            self.setNeedsLayout()
        }
    }

    fileprivate func customizedView() {
        let border = CALayer()
        border.borderWidth = bottomBorderWidth
        border.borderColor = #colorLiteral(red: 0.3568627451, green: 0.6235294118, blue: 0.7960784314, alpha: 0.5)
        border.cornerRadius = 5.0
        border.frame = CGRect(x: 0, y: self.frame.size.height - border.borderWidth, width:  self.frame.size.width, height: self.frame.size.height)
        self.borderStyle = .none
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedStringKey.foregroundColor : #colorLiteral(red: 0.2588235294, green: 0.3294117647, blue: 0.7254901961, alpha: 0.2468639965)])
    }
    
//    override func layoutSubviews() {
//        customizedView()
//    }
    
//    override func awakeFromNib() {
//        customizedView()
//    }
//
//    override func prepareForInterfaceBuilder() {
//        customizedView()
//    }

}
