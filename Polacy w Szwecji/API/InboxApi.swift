//
//  InboxApi.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-19.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import Foundation
import Firebase

class InboxApi {

    func lastMessages(uid: String) {
        
        let ref = Ref().databaseInboxForUser(uid: uid)
        ref.observe(DataEventType.childAdded) { (snapshot) in
            if let dict = snapshot.value as? Dictionary<String, Any> {
                print(dict)
            }
        }
    }
}
