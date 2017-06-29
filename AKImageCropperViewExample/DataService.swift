//
//  DataService.swift

//  Created by Cornelia Bursucanu on 6/14/17.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

class DataService{

private var _REF_BASE = DB_BASE
private var _REF_BOOKS = DB_BASE.child("Carti")
private var _REF_USERS = DB_BASE.child("Users")
private var _REF_COMM = DB_BASE.child("Comments")

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
    
    var REF_COMM: DatabaseReference{
        return _REF_COMM
    
    }
    func createUser (uid: String, provider: String, username:String){
        
        _REF_USERS.child(uid).updateChildValues(["provider": provider, "username": username])
        print("Created user in db")
    
    
    
    }
    
    func fetchAllComments(bookId: String, completion: @escaping ([Comment])->()){
        
        let commentsRef =  REF_COMM.queryOrdered(byChild: "bookId").queryEqual(toValue: bookId)
        
        commentsRef.observe(.value, with: { (comments) in
            
            var resultArray = [Comment]()
            for comment in comments.children {
                
                let comment = Comment(snapshot: comment as! DataSnapshot)
                resultArray.append(comment)
            }
            completion(resultArray)
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
  
    /*
    
    func saveCommentToDB(comment: Comment, completed: @escaping ()->Void){
        
        let postRef = REF_COMM.childByAutoId()
        postRef.setValue(comment.toAnyObject()) { (error, ref) in
            if let error = error {
                print(error.localizedDescription)
            }else {
                let alertView = ALERT
                _ = alertView.showSuccess("Success", subTitle: "Comment saved successfuly", closeButtonTitle: "Done", duration: 4, colorStyle: UIColor(colorWithHexValue: 0x3D5B94), colorTextButton: UIColor.white)
                completed()
            }
        }
        
    }
 
 */
    
}
