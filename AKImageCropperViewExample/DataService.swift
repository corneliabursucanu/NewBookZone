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

    var REF_BASE: DatabaseReference {
        return _REF_BASE
    
    }
    
    var REF_BOOKS: DatabaseReference{
        return _REF_BOOKS
    }

    
    
    
}
