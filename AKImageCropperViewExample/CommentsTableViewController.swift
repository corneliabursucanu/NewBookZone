//
//  CommentsTableViewController.swift
//  AKImageCropperView
//
//  Created by Cornelia Bursucanu on 6/29/17.
//  Copyright © 2017 Artem Krachulov. All rights reserved.
//

import UIKit
import FirebaseAuth

class CommentsTableViewController: UITableViewController {

    @IBOutlet weak var adaugaCommTextField: UITextField!
    var bookId:String!
    var isbn:String!
    var booktitle: String?
    var bookauthor: String?
    var commentsArray = [Comment]()
    var data = DataService()
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        data.fetchAllComments(bookId: bookId) { (comments) in
            self.commentsArray = comments
            print(comments)
            self.tableView.reloadData()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return commentsArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
            let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentTableViewCell
            cell.configureCell(comment:commentsArray[indexPath.row])
            
            return cell
        }
    
    
    @IBAction func adaugaBtnTapped(_ sender: Any) {
   
        var commentText = ""
        if let text = adaugaCommTextField.text{
            commentText = text
        }
        
      
    

    let commentId = NSUUID().uuidString
    
    let comment = Comment( userId: Auth.auth().currentUser!.uid, commentText: commentText, commentId: commentId,  bookId: self.bookId)

        self.data.saveCommentToDB(comment: comment, completed: {
         self.tableView.reloadData()
        self.adaugaCommTextField.text = ""
        })

    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moreVC"{
            if let destination = segue.destination as? MoreVC {
                print(isbn)
                
                
                destination.bookisbn = isbn
                destination.booktitle = booktitle
                destination.bookauthor = bookauthor
                
            }
            
            
        }


}

}
        
        
       
        



