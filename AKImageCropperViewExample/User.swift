//
//  User.swift
//  AKImageCropperView
//
//  Created by Cornelia Bursucanu on 6/29/17.
//

import Foundation
import Firebase

struct User {
    
    var username: String!
    var uid: String!
    var ref: DatabaseReference!
    var key: String = ""
    
    
    
    
    init(snapshot: DataSnapshot){
        
        self.username = (snapshot.value as! NSDictionary)["username"] as! String
        self.uid = (snapshot.value as! NSDictionary)["uid"] as! String
        self.ref = snapshot.ref
        self.key = snapshot.key
    }
    
    
    init(username: String, uid: String){
        
        self.username = username
        self.uid = uid
        self.ref = Database.database().reference()
        
    }
    
   
    
    
    
    func toAnyObject() -> [String: Any]{
        return ["username":self.username,"uid":self.uid]
    }
    
    
    
    
    
    
}
