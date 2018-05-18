//
//  SocketService.swift
//  QuickChat
//
//  Created by thanhbh on 5/18/18.
//  Copyright © 2018 vinicorp. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
    
    static let instance = SocketService()
    var socket: SocketIOClient = SocketIOClient(manager: SocketManager(socketURL: URL(string: BASE_URL)!), nsp: "")
    
    override init() {
        super.init()
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }

}
