//
//  CommentTableViewCell.swift

//
//  Created by Cornelia Bursucanu on 6/27/17.

//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var commentTextLabel: UILabel!
    var data = DataService()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.usernameLabel.text = ""
        self.commentTextLabel.text = ""
        
        
    }
    
    func configureCell(comment: Comment){
        
        
        data.fetchPostUserInfo(uid: comment.userId) { (user) in
            if let user = user {
                
                self.usernameLabel.text = user.username
           
                print("----------------")
                print(user.username)
         }
            
        }
        
        self.commentTextLabel.text = comment.commentText
        print(comment.commentText)

 
 

}
}
