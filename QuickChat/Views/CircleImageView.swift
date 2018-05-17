//
//  CircleImageView.swift
//  QuickChat
//
//  Created by thanhbh on 5/17/18.
//  Copyright © 2018 vinicorp. All rights reserved.
//

import UIKit

@IBDesignable class CircleImageView: UIImageView {

    override func awakeFromNib() {
        self.setRounded()
    }
    
    override func prepareForInterfaceBuilder() {
        self.setRounded()
    }

}
