//
//  DataService.swift
//  AKImageCropperView
//
//  Created by Cornelia Bursucanu on 6/14/17.
//  Copyright © 2017 Artem Krachulov. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

class DataService{

private var _REF_BASE = DB_BASE
private var _REF_BOOKS = DB_BASE.child("Carti")
private var _REF_USERS = DB_BASE.child("Users")

 static let ds = DataService()
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    
    }
    
    var REF_BOOKS: DatabaseReference{
        return _REF_BOOKS
    }

    
    var REF_USERS: DatabaseReference{
        return _REF_USERS
        
    }
    func createUser (uid: String, provider: String, username:String){
        
        _REF_USERS.child(uid).updateChildValues(["provider": provider, "username": username])
        print("Created user in db")
    
    
    
    }
    
}
