//
//  AvatarCollectionCell.swift
//  QuickChat
//
//  Created by thanhbh on 5/16/18.
//  Copyright © 2018 vinicorp. All rights reserved.
//

import UIKit

@IBDesignable class AvatarCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imgAvatar: UIImageView!
    
//    override func layoutSubviews() {
//        customizedView()
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizedView()
    }
    
    override func prepareForInterfaceBuilder() {
        customizedView()
    }
    
    fileprivate func customizedView() {
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    func configureCell(index: Int, type: AvatarType) {
        imgAvatar.image = UIImage(named: "\(type)\(index)")
        if type == AvatarType.dark {
            self.layer.backgroundColor = UIColor.darkGray.cgColor
        } else {
            self.layer.backgroundColor = UIColor.lightGray.cgColor
        }
    }

}
