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
    
    fileprivate func setupView() {
        revealViewController()?.isLeftPresentViewOnTop = false
        revealViewController()?.setLeftViewRevealWidth(view.frame.width - (btnMenu.frame.width + btnMenu.frame.minX * 2) , animated: true)
        btnMenu.addTarget(revealViewController(), action: #selector(PBRevealViewController.revealLeftView), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
    }

}
