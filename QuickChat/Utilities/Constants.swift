//
//  Constants.swift
//  QuickChat
//
//  Created by thanhbh on 5/11/18.
//  Copyright © 2018 vinicorp. All rights reserved.
//

import Foundation

typealias CompletionHandle = (_ success: Bool) -> ()

// Segues
let TO_LOGIN = "toLoginSegue"
let TO_SIGN_UP = "toSignUpSegue"
let TO_CHANNEL = "toChannelSegue"
let TO_AVATAR = "toAvatarSegue"
//let CHANNEL_CELL = "channelCell"
let CHANNEL_CELL = "channelTableCell"
//let AVATAR_CELL = "avatarCell"
let AVATAR_CELL = "avatarCollectionCell"

// User defaults
let ERROR_MESSAGE = "errorMessage"
let LOGGED_IN_KEY = "loggedIn"
let TOKEN_KEY = "token"
let USER_EMAIL = "userEmail"
let AUTH_TOKEN = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVhZmI4NjhiYTljNTdiMDNmNjk4ZjgxMyIsImlhdCI6MTUyNjYxNDIwMiwiZXhwIjoxNTM0MzkwMjAyfQ.Qxf46K221e_u02u-JcpfGtltLv70nxuCOPe7DZMSAro"

// API URL
let BASE_URL = "https://quickchat-api.herokuapp.com/v1/"
//let BASE_URL = "http://localhost:3005/v1/"
let URL_REGISTER_USER = "\(BASE_URL)account/register"
let URL_LOGIN_USER = "\(BASE_URL)account/login"
let URL_ADD_USER = "\(BASE_URL)user/add"
let URL_GET_USERS = "\(BASE_URL)user"
let URL_USER_BY_EMAIL = "\(BASE_URL)user/byEmail/"
let URL_ADD_CHANNEL = "\(BASE_URL)channel/add"
let URL_GET_CHANNELS = "\(BASE_URL)channel"
let URL_MESSAGE_BY_CHANNEL = "\(BASE_URL)message/byChannel/"

// HEADER
let HEADER_API = ["Content-Type": "application/json; charset=utf-8"]
let BEARER_HEADER = ["Authorization": "Bearer \(AUTH_TOKEN)",
    "Content-Type": "application/json; charset=utf-8"]

// Constants
let NUMBER_AVATAR_IMAGE = 28
let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("notifUserDataChanged")
