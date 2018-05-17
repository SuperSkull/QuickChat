//
//  AvatarVC.swift
//  QuickChat
//
//  Created by thanhbh on 5/16/18.
//  Copyright © 2018 vinicorp. All rights reserved.
//

import UIKit

class AvatarVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var cltAvatar: UICollectionView!
    @IBOutlet weak var sgmColor: UISegmentedControl!
    
    var avatarType: AvatarType = .dark
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cltAvatar.delegate = self
        cltAvatar.dataSource = self
        setupView()
    }
    
    fileprivate func setupView() {
        if let tmpCollectionAvatar = cltAvatar as? AvatarCollectionView {
            let numberColumns = CGFloat(tmpCollectionAvatar.numberColumns)
            if let flowLayout = cltAvatar.collectionViewLayout as? UICollectionViewFlowLayout, numberColumns != 0 {
                let horizontalSpacing = flowLayout.scrollDirection == .vertical ? flowLayout.minimumInteritemSpacing : flowLayout.minimumLineSpacing
                let sectionInset = tmpCollectionAvatar.sectionInset
                flowLayout.sectionInset = UIEdgeInsetsMake(0, sectionInset, 0, sectionInset)
                let totalCellWidth = view.frame.width - max(0, numberColumns - 1) * horizontalSpacing - sectionInset * 2 - CGFloat(1)
                let cellWidth = totalCellWidth / numberColumns
                flowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth)
            }
        }
        if avatarType == .light {
            sgmColor.selectedSegmentIndex = 1
        } else {
            sgmColor.selectedSegmentIndex = 0
        }
    }

    @IBAction func btnBackPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sgmColorChanged(_ sender: UISegmentedControl) {
        if sgmColor.selectedSegmentIndex == 0 {
            avatarType = .dark
        } else {
            avatarType = .light
        }
        cltAvatar.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NUMBER_AVATAR_IMAGE
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = cltAvatar.dequeueReusableCell(withReuseIdentifier: AVATAR_CELL, for: indexPath) as? AvatarCollectionCell {
            cell.configureCell(index: indexPath.item, type: avatarType)
            return cell
        }
        return AvatarCollectionCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UserDataService.instance.userData.setAvatarName("\(avatarType)\(indexPath.item)")
        dismiss(animated: true, completion: nil)
    }
}
