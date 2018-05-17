//
//  AuthService.swift
//  QuickChat
//
//  Created by thanhbh on 5/15/18.
//  Copyright © 2018 vinicorp. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService {
    
    static let instance = AuthService()
    let defaults = UserDefaults.standard
    
    var authToken: String? {
        get {
            return defaults.value(forKey: TOKEN_KEY) as? String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var errorMessage: String? {
        get {
            return defaults.value(forKey: ERROR_MESSAGE) as? String
        }
        set {
            defaults.set(newValue, forKey: ERROR_MESSAGE)
        }
    }
    
    var isLoggedIn: Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var userEmail: String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    fileprivate func setUserData(_ data: Data) {
        let json = JSON(data)
        if json["_id"].exists() && json["name"].exists() && json["email"].exists() && json["avatarName"].exists() && json["avatarColor"].exists() {
            let id = json["_id"].stringValue
            let name = json["name"].stringValue
            let email = json["email"].stringValue
            let avatarName = json["avatarName"].stringValue
            let avatarColor = json["avatarColor"].stringValue
            UserDataService.instance.setUserData(userData: UserData(id: id, name: name, email: email, avatarName: avatarName, avatarColor: avatarColor))
        }
    }
    
    func registerUser(user: User, completion: @escaping CompletionHandle) {
        let lowerCaseEmail = user.email.lowercased()
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": user.password
        ]
        Alamofire.request(URL_REGISTER_USER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER_API).responseString {
            (response) in
            if response.result.error == nil {
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func loginUser(user: User, completion: @escaping CompletionHandle) {
        let lowerCaseEmail = user.email.lowercased()
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": user.password
        ]
        Alamofire.request(URL_LOGIN_USER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER_API).responseJSON { (response) in
            if response.result.error == nil {
//                if let json = response.result.value as? Dictionary<String, Any> {
//                    if let userEmail = json["user"] as? String {
//                        self.userEmail = userEmail
//                    }
//                    if let authToken = json["token"] as? String {
//                        self.authToken = authToken
//                    }
//                }
                guard let data = response.data else {
                    return
                }
                let json = JSON(data)
                if json["message"].exists() {
                    self.errorMessage = json["message"].stringValue
                    completion(true)
                } else if json["user"].exists() && json["token"].exists() {
                    self.userEmail = json["user"].stringValue
                    self.authToken = json["token"].stringValue
                    self.isLoggedIn = true
                    completion(true)
                } else {
                    completion(false)
                }
            } else {
                self.isLoggedIn = false
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func createUser(name: String, email: String, avatarName: String, avatarColor: String, completion: @escaping CompletionHandle) {
        let lowerCaseEmail = email.lowercased()
        let body: [String: Any] = [
            "name": name,
            "email": lowerCaseEmail,
            "avatarName": avatarName,
            "avatarColor" : avatarColor
        ]
        if let authToken = self.authToken {
            let header = [
                "Authorization": "Bearer \(authToken)",
                "Content-Type": "application/json; charset=utf-8"
            ]
            Alamofire.request(URL_ADD_USER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
                if response.result.error == nil {
                    guard let data = response.data else {
                        return
                    }
                    self.setUserData(data)
                    completion(true)
                } else {
                    completion(false)
                    debugPrint(response.result.error as Any)
                }
            }
        } else {
            completion(false)
        }
    }
    
    func findUserByEmail(completion: @escaping CompletionHandle) {
        if let authToken = self.authToken {
            let header = [
                "Authorization": "Bearer \(authToken)",
                "Content-Type": "application/json; charset=utf-8"
            ]
            Alamofire.request("\(URL_USER_BY_EMAIL)\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
                if response.result.error == nil {
                    guard let data = response.data else {
                        return
                    }
                    self.setUserData(data)
                    completion(true)
                } else {
                    completion(false)
                    debugPrint(response.result.error as Any)
                }
            }
        } else {
            completion(false)
        }
    }
}
