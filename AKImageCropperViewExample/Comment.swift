//
//  Comment.swift

//
//  Created by Cornelia Bursucanu on 6/27/17.

//

import Foundation

import Foundation
import Firebase

struct Comment {
    var bookId: String!
    var userId: String!
    var commentId: String!
    var commentText: String!
    var ref: DatabaseReference!
    var key: String = ""
    
    init(userId: String, commentText: String, commentId:String, bookId: String, key: String = ""){
        self.bookId = bookId
        self.commentText = commentText
        self.userId = userId
        self.commentId = commentId
        self.ref = Database.database().reference()
    }
    
    init(snapshot:DataSnapshot!) {
        
        self.commentText = (snapshot.value! as! NSDictionary)["commentText"] as! String
        self.bookId = (snapshot.value! as! NSDictionary)["bookId"] as! String
        self.userId = (snapshot.value! as! NSDictionary)["userId"] as! String
        self.ref = snapshot.ref
        self.key = snapshot.key
        
    }
    
    func toAnyObject()->[String: Any] {
        return ["commentId":self.commentId,"commentText":self.commentText,"bookId": self.bookId, "userId":self.userId]
    }
    
    
}
