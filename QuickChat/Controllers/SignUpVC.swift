//
//  SignUpVC.swift
//  QuickChat
//
//  Created by Bùi Huy Thanh on 5/13/18.
//  Copyright © 2018 vinicorp. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtRePass: UITextField!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var aivSignUp: UIActivityIndicatorView!
    
    var avatarName = "profileDefault"
    var avatarType = AvatarType.dark
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    var bgColor: UIColor?
    var toastText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let message = toastText {
            view.makeToast(message)
            toastText = nil
        }
        if UserDataService.instance.userData.avatarName != "" {
            avatarName = UserDataService.instance.userData.avatarName
            if (avatarName.hasPrefix("light")) {
                avatarType = .light
                imgUser.backgroundColor = UIColor.darkGray
            } else if (avatarName.hasPrefix("dark")){
                avatarType = .dark
                imgUser.backgroundColor = UIColor.lightGray
            }
            imgUser.image = UIImage(named: avatarName)
        }
        if bgColor != nil {
            imgUser.backgroundColor = bgColor!
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? AvatarVC {
            destinationViewController.avatarType = sender as! AvatarType
        }
        if let destinationViewController = segue.destination as? ChannelVC {
            destinationViewController.toastText = sender as? String
        }
    }
    
    fileprivate func setupView() {
        // Do any additional setup after loading the view.
        let tapGestureBackground = UITapGestureRecognizer(target: self, action: #selector(endEditingTapped(_:)))
        view.addGestureRecognizer(tapGestureBackground)
        aivSignUp.isHidden = true
        aivSignUp.hidesWhenStopped = true
    }
    
    @IBAction func btnCreateAccountPressed(_ sender: UIButton) {
        guard let name = txtUsername.text, txtUsername.text != "" else {
            return
        }
        guard let email = txtEmail.text, txtEmail.text != "" else {
            return
        }
        guard let pass = txtPassword.text, txtPassword.text != "" else {
            return
        }
        guard let rePass = txtRePass.text, txtRePass.text != "" else {
            return
        }
        if rePass != pass {
            return
        }
        
        //AuthService.instance.registerUser(user: User(email, pass)) { (success) in
        //    if success {
        //        self.dismiss(animated: true, completion: nil)
        //    } else {
        //        self.view.makeToast(AuthService.instance.errorMessage)
        //    }
        //}
        aivSignUp.isHidden = false
        aivSignUp.startAnimating()
        AuthService.instance.createUser(name: name, email: email, avatarName: avatarName, avatarColor: avatarColor) { (success) in
            if success {
                self.performSegue(withIdentifier: TO_CHANNEL, sender: "Create user successful!")
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            } else {
                self.view.makeToast(AuthService.instance.errorMessage)
            }
        }
//        aivSignUp.isHidden = true
        aivSignUp.stopAnimating()
    }
    
    @IBAction func btnBackPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnClosePressed(_ sender: UIButton) {
        performSegue(withIdentifier: TO_CHANNEL, sender: nil)
    }
    
    @IBAction func btnChooseAvatarPressed(_ sender: UIButton) {
        performSegue(withIdentifier: TO_AVATAR, sender: avatarType)
    }
    
    @IBAction func btnGenerateBackgroundPressed(_ sender: UIButton) {
        let red = CGFloat(arc4random_uniform(255)) / 255
        let green = CGFloat(arc4random_uniform(255)) / 255
        let blue = CGFloat(arc4random_uniform(255)) / 255
        bgColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
        avatarColor = "[\(red), \(green), \(blue), 1]"
        UIView.animate(withDuration: 0.4) {
            self.imgUser.backgroundColor = self.bgColor
        }
    }
}
