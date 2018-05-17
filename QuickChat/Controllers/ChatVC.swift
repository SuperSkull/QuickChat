//
//  ChatVC.swift
//  QuickChat
//
//  Created by thanhbh on 5/10/18.
//  Copyright © 2018 vinicorp. All rights reserved.
//

import UIKit
import PBRevealViewController
import Toast_Swift

class ChatVC: UIViewController {

    @IBOutlet weak var btnMenu: UIButton!
    
    var toastText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let message = toastText {
            view.makeToast(message)
            toastText = nil
        }
    }
    
    fileprivate func setupView() {
        revealViewController()?.isLeftPresentViewOnTop = false
        revealViewController()?.setLeftViewRevealWidth(view.frame.width - (btnMenu.frame.width + btnMenu.frame.minX * 2) , animated: true)
        btnMenu.addTarget(revealViewController(), action: #selector(PBRevealViewController.revealLeftView), for: .touchUpInside)
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            }
        }
    }

}
