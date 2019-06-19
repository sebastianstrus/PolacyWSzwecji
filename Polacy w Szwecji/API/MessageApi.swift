//
//  MessageApi.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-16.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import Foundation
import Firebase

class MessageApi {
    
    func sendMessage(from: String, to: String, value: Dictionary<String, Any>) {
        let ref = Ref().databaseMessageSendTo(from: from, to: to)
        ref.childByAutoId().updateChildValues(value)
        
        //remove unnecessary data
        var dict = value
        if let text = dict["text"] as? String, text.isEmpty {
            dict["imageUrl"] = nil
            dict["height"] = nil
            dict["width"] = nil
        }
        
        let refFrom = Ref().databaseInboxInfor(from: from, to: to)
        refFrom.updateChildValues(dict)
        
        let refTo = Ref().databaseInboxInfor(from: to, to: from)
        refTo.updateChildValues(dict)
    }
    
    typealias MessageCompletion = (Message) -> Void
    func retriveMessage(from: String, to: String, onSuccess: @escaping(Message) -> Void) {
        let ref = Ref().databaseMessageSendTo(from: from, to: to)
        ref.observe(.childAdded) { (snapshot) in
            if let dict = snapshot.value as? Dictionary<String, Any> {
                if let message = Message.transformMessage(dict: dict, keyId: snapshot.key) {
                    onSuccess(message)
                }
            }
        }
    }
}
