//
//  ProfileVC.swift
//  QuickChat
//
//  Created by thanhbh on 5/17/18.
//  Copyright © 2018 vinicorp. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var btnClose: UIButton!
//    @IBOutlet var tgrBackground: UITapGestureRecognizer!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var txtUsername: UILabel!
    @IBOutlet weak var txtEmail: UILabel!
    @IBOutlet weak var bgdView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    fileprivate func setupView() {
        // Do any additional setup after loading the view.
        let tgrBackground = UITapGestureRecognizer(target: self, action: #selector(closeTapped(_:)))
        bgdView.addGestureRecognizer(tgrBackground)
        txtUsername.text = UserDataService.instance.userData.name
        txtEmail.text = UserDataService.instance.userData.email
        imgUser.image = UIImage(named: UserDataService.instance.userData.avatarName)
        imgUser.backgroundColor = UserDataService.instance.userData.getAvatarColor()
    }
    
    @IBAction func bgdViewTapped(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func btnClosePressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnLogoutPressed(_ sender: UIButton) {
        UserDataService.instance.loggoutUser()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }
}
