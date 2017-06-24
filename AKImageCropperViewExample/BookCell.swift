//
//  BookCell.swift
//  AKImageCropperView
//
//  Created by Cornelia Bursucanu on 6/24/17.
//  Copyright © 2017 Artem Krachulov. All rights reserved.
//

import UIKit

class BookCell: UITableViewCell {

    
    @IBOutlet weak var titleCell: UILabel!
    
   
    @IBOutlet weak var imageBook: UIImageView!
    
    
    
    func configureCell(title:String, image:String) {
        
        titleCell.text = title
    
        
        let url = URL(string: image)
        
        if url != nil {
        
            let data = NSData(contentsOf: url!)
            let img = UIImage(data: data! as Data)
            imageView?.image = img
        
        }
            
        
    
        else{
        imageBook.image = UIImage(named: "noimage")
        }
    
    
    
  
}

}


    
    





