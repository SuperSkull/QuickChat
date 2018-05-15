//
//  ChannelVC.swift
//  QuickChat
//
//  Created by thanhbh on 5/10/18.
//  Copyright © 2018 vinicorp. All rights reserved.
//

import UIKit
import PBRevealViewController

class ChannelVC: UIViewController {

    @IBOutlet weak var btnLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnLoginPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }
    
    @IBAction func unwindToChannelVC(unwindSegue: UIStoryboardSegue){}
}
