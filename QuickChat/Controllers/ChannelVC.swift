//
//  ChannelVC.swift
//  QuickChat
//
//  Created by thanhbh on 5/10/18.
//  Copyright © 2018 vinicorp. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var imgUser: UIImageView!
    
    var toastText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(userDataDidChanged), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let message = toastText {
            view.makeToast(message)
            toastText = nil
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let loginVC = segue.destination as? LoginVC {
            loginVC.onCompletion = { data in
                self.view.makeToast(data)
            }
        }
    }
    
    fileprivate func setupUserData() {
        if AuthService.instance.isLoggedIn {
            btnLogin.setTitle(UserDataService.instance.userData.name, for: .normal)
            imgUser.image = UIImage(named: UserDataService.instance.userData.avatarName)
            imgUser.backgroundColor = UserDataService.instance.userData.getAvatarColor()
        } else {
            btnLogin.setTitle("Login", for: .normal)
            imgUser.image = UIImage(named: "profileDefault")
            imgUser.backgroundColor = nil
        }
    }
    
    @objc func userDataDidChanged(_ notif: Notification) {
        setupUserData()
    }

    @IBAction func btnLoginPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            let profileVC = ProfileVC()
            profileVC.modalPresentationStyle = .custom
            present(profileVC, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
    }
    
    @IBAction func unwindToChannelVC(unwindSegue: UIStoryboardSegue){}
}
