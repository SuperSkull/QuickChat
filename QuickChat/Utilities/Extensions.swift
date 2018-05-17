//
//  Extension.swift
//  QuickChat
//
//  Created by Bùi Huy Thanh on 5/13/18.
//  Copyright © 2018 vinicorp. All rights reserved.
//

import UIKit

extension UIViewController {
    
    @objc func endEditingTapped(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @objc func closeTapped(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension UIImageView {
    
    func setRounded() {
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.masksToBounds = true
    }
    
}
