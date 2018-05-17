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
    
    fileprivate func setupView() {
        // Do any additional setup after loading the view.
        let tapGestureBackground = UITapGestureRecognizer(target: self, action: #selector(endEditingTapped(_:)))
        view.addGestureRecognizer(tapGestureBackground)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let message = toastText {
            view.makeToast(message)
            toastText = nil
        }
        print(aivLogin.isHidden)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? SignUpVC {
            destinationViewController.toastText = sender as? String
        }
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
        aivLogin.startAnimating()
        aivLogin.isHidden = false
        AuthService.instance.loginUser(user: User(email, pass)) { (success) in
            if success {
                if AuthService.instance.isLoggedIn {
                    self.performSegue(withIdentifier: TO_SIGN_UP, sender: "Login successful!")
                } else {
                    self.view.makeToast(AuthService.instance.errorMessage)
                }
            } else {
                self.view.makeToast("Login failed! Check out the connection!")
            }
        }
        aivLogin.isHidden = true
        aivLogin.stopAnimating()
    }
    
    @IBAction func btnSignUpPressed(_ sender: UIButton) {
        performSegue(withIdentifier: TO_SIGN_UP, sender: nil)
    }
    
    @IBAction func unwindToLoginVC(unwindSegue: UIStoryboardSegue){}

}
