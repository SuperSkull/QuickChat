//
//  MessageService.swift
//  QuickChat
//
//  Created by thanhbh on 5/18/18.
//  Copyright © 2018 vinicorp. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    
    static let instance = MessageService()
    
    var channels = [Channel]()
    
    func findAllChannel(completion: @escaping CompletionHandle) {
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else {
                    AuthService.instance.errorMessage = "Cannot retrieve data!"
                    completion(false)
                    return
                }
//                do {
//                    self.channels = try JSONDecoder().decode([Channel].self, from: data)
//                    completion(true)
//                } catch let error {
//                    AuthService.instance.errorMessage = error as? String
//                    completion(false)
//                    debugPrint(error as Any)
//                }
                if let json = JSON(data).array {
                    for item in json {
                        if item["_id"].exists() && item["name"].exists() && item["description"].exists() && item["__v"].exists() {
                            let _id = item["_id"].stringValue
                            let name = item["name"].stringValue
                            let description = item["description"].stringValue
                            let __v = item["__v"].intValue
                            self.channels.append(Channel(_id: _id, description: description, name: name, __v: __v))
                        }
                    }
                    completion(true)
                }
            } else {
                AuthService.instance.errorMessage = response.result.error as? String
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
}
