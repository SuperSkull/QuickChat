//
//  LoginVC.swift
//  QuickChat
//
//  Created by Bùi Huy Thanh on 5/12/18.
//  Copyright © 2018 vinicorp. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var aivLogin: UIActivityIndicatorView!
    
    var toastText: String?
    var onCompletion: ((_ data: String) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let message = toastText {
            view.makeToast(message)
            toastText = nil
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? SignUpVC {
            destinationViewController.toastText = sender as? String
        }
    }
    
    fileprivate func setupView() {
        // Do any additional setup after loading the view.
        let tapGestureBackground = UITapGestureRecognizer(target: self, action: #selector(endEditingTapped(_:)))
        view.addGestureRecognizer(tapGestureBackground)
        aivLogin.isHidden = true
        aivLogin.hidesWhenStopped = true
    }

    @IBAction func btnClosePressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnLoginPressed(_ sender: UIButton) {
        guard let email = txtUsername.text, txtUsername.text != "" else {
            return
        }
        guard let pass = txtPassword.text, txtPassword.text != "" else {
            return
        }
        aivLogin.isHidden = false
        aivLogin.startAnimating()
        AuthService.instance.loginUser(user: User(email, pass)) { (success) in
            if success {
                AuthService.instance.findUserByEmail(completion: { (success) in
                    if success {
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                    } else {
                        self.view.makeToast(AuthService.instance.errorMessage)
                    }
                })
                self.dismiss(animated: true, completion: {
                    self.onCompletion?("Login successful!")
                })
            } else {
                self.view.makeToast(AuthService.instance.errorMessage)
            }
        }
//        aivLogin.isHidden = true
        aivLogin.stopAnimating()
    }
    
    @IBAction func btnSignUpPressed(_ sender: UIButton) {
        performSegue(withIdentifier: TO_SIGN_UP, sender: nil)
    }
    
    @IBAction func unwindToLoginVC(unwindSegue: UIStoryboardSegue){}

}
