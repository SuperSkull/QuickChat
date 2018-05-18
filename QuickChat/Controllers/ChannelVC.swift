//
//  ChannelVC.swift
//  QuickChat
//
//  Created by thanhbh on 5/10/18.
//  Copyright © 2018 vinicorp. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var tblChannel: UITableView!
    
    var toastText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tblChannel.delegate = self
        tblChannel.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(userDataDidChanged), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let message = toastText {
            view.makeToast(message)
            toastText = nil
        }
        setupUserData()
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
    
    @IBAction func btnAddChannelPressed(_ sender: UIButton) {
        let addChannelVC = AddChannelVC()
        addChannelVC.modalPresentationStyle = .custom
        present(addChannelVC, animated: true, completion: nil)
    }
    
    @IBAction func btnLoginPressed(_ sender: UIButton) {
        if AuthService.instance.isLoggedIn {
            let profileVC = ProfileVC()
            profileVC.modalPresentationStyle = .custom
            present(profileVC, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
    }
    
    @IBAction func unwindToChannelVC(unwindSegue: UIStoryboardSegue){}
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tblChannel.dequeueReusableCell(withIdentifier: CHANNEL_CELL, for: indexPath) as? ChannelTableCell {
            cell.configureCell(channel: MessageService.instance.channels[indexPath.row])
            return cell
        }
        return ChannelTableCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
