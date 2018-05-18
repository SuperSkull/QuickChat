//
//  UserData.swift
//  QuickChat
//
//  Created by thanhbh on 5/15/18.
//  Copyright © 2018 vinicorp. All rights reserved.
//

import Foundation
import UIKit.UIColor

class UserData: Decodable {
    public private(set) var _id: String = ""
    public private(set) var avatarColor: String = ""
    public private(set) var avatarName: String = ""
    public private(set) var email: String = ""
    public private(set) var name: String = ""
    public private(set) var __v: Int = 0
    
    init() {}
    
    init(_id: String, avatarColor color: String, avatarName: String, email: String, name: String, __v: Int) {
        self._id = _id
        self.avatarColor = color
        self.avatarName = avatarName
        self.email = email
        self.name = name
        self.__v = __v
    }
    
    init(_ _id: String, _ avatarColor: String, _ avatarName: String, _ email: String, _ name: String, _ __v: Int) {
        self._id = _id
        self.avatarColor = avatarColor
        self.avatarName = avatarName
        self.email = email
        self.name = name
        self.__v = __v
    }
    
    func setAvatarName(avatarName: String) {
        self.avatarName = avatarName
    }
    
    func setAvatarName(_ avatarName: String) {
        self.avatarName = avatarName
    }
    
    func setAvatarColor(avatarColor: String) {
        self.avatarColor = avatarColor
    }
    
    func setAvatarColor(_ avatarColor: String) {
        self.avatarColor = avatarColor
    }
    
    func getAvatarColor() -> UIColor {
        let scanner = Scanner(string: avatarColor)
        let skipped = CharacterSet(charactersIn: "[], ")
        let stopped =  CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skipped
        var r, g, b, a: NSString?
        scanner.scanUpToCharacters(from: stopped, into: &r)
        scanner.scanUpToCharacters(from: stopped, into: &g)
        scanner.scanUpToCharacters(from: stopped, into: &b)
        scanner.scanUpToCharacters(from: stopped, into: &a)
        var defaultColor = UIColor.lightGray
        guard let rUnwrapped = r else {
            return defaultColor
        }
        guard let gUnwrapped = g else {
            return defaultColor
        }
        guard let bUnwrapped = b else {
            return defaultColor
        }
        guard let aUnwrapped = a else {
            return defaultColor
        }
        let red = CGFloat(rUnwrapped.doubleValue)
        let green = CGFloat(gUnwrapped.doubleValue)
        let blue = CGFloat(bUnwrapped.doubleValue)
        let alpha = CGFloat(aUnwrapped.doubleValue)
        defaultColor = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return defaultColor
    }
    
}
