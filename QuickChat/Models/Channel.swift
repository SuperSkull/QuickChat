//
//  Channel.swift
//  QuickChat
//
//  Created by thanhbh on 5/18/18.
//  Copyright © 2018 vinicorp. All rights reserved.
//

import Foundation

struct Channel: Decodable {
    public private(set) var _id: String
    public private(set) var description: String
    public private(set) var name: String
    public private(set) var __v:Int
}
