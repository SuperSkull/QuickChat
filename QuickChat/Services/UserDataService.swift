//
//  UserDataService.swift
//  QuickChat
//
//  Created by thanhbh on 5/15/18.
//  Copyright © 2018 vinicorp. All rights reserved.
//

import Foundation

class UserDataService {
    
    static let instance = UserDataService()

//    public private(set) var id = ""
//    public private(set) var name = ""
//    public private(set) var email = ""
//    public private(set) var avatarName = ""
//    public private(set) var avatarColor = ""
//
//    func setUserData(userData: UserData) {
//        self.id = userData.id
//        self.name = userData.name
//        self.email = userData.email
//        self.avatarName = userData.avatarName
//        self.avatarColor = userData.avatarColor
//    }
    
    init() {
        self.userData = emptyUserData
    }
    
    private let emptyUserData = UserData()
    public private(set) var userData: UserData

    func setUserData(userData: UserData) {
        self.userData = userData
    }
    
    func loggoutUser() {
        self.userData = emptyUserData
        AuthService.instance.isLoggedIn = false
        AuthService.instance.authToken = nil
        AuthService.instance.userEmail = ""
    }
}
