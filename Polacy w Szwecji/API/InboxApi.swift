//
//  InboxApi.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-19.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import Foundation
import Firebase

typealias InboxCompletion = (Inbox) -> Void

class InboxApi {

    func lastMessages(uid: String, onSuccess: @escaping(InboxCompletion)) {
        
        let ref = Ref().databaseInboxForUser(uid: uid)
        ref.observe(DataEventType.childAdded) { (snapshot) in
            if let dict = snapshot.value as? Dictionary<String, Any> {
                Api.User.getUserInfor(uid: snapshot.key, onSuccess: { (user) in
                    if let inbox = Inbox.transformInbox(dict: dict, user: user) {
                        onSuccess(inbox)
                    }
                })
            }
        }
    }
}
