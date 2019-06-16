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
    }
}
