//
//  AddChannelVC.swift
//  QuickChat
//
//  Created by thanhbh on 5/18/18.
//  Copyright © 2018 vinicorp. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

//    @IBOutlet var tgrBackground: UITapGestureRecognizer!
    @IBOutlet weak var txtChannelName: UITextField!
    @IBOutlet weak var txtDescription: UITextField!
    @IBOutlet weak var bgdView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    fileprivate func setupView() {
        // Do any additional setup after loading the view.
        let tgrBackground = UITapGestureRecognizer(target: self, action: #selector(closeTapped(_:)))
        bgdView.addGestureRecognizer(tgrBackground)
    }
    
    @IBAction func btnClosePressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnCreateChannelPressed(_ sender: UIButton) {
        
    }
}
