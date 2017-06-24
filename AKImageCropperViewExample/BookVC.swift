//
//  BookVC.swift
//  AKImageCropperView
//
//  Created by Cornelia Bursucanu on 6/14/17.
//  Copyright © 2017 Artem Krachulov. All rights reserved.
//

import UIKit
import SafariServices
import FirebaseCore
import Firebase
import WebKit

class BookVC: UIViewController, SFSafariViewControllerDelegate  {
    
   
    var isbn = " "
    
    @IBOutlet weak var msgLabel: UILabel!
    
 //  private var urlString:String = "https://goodread.ro/recenzie-povestea-faridei-fata-care-invins-isis-de-farida-khalaf-andrea-c-hoffmann/"

    override func viewDidLoad() {
        super.viewDidLoad()
        print(isbn)
        msgLabel.isHidden = true
        
     //  let trimmed = isbn.replacingOccurrences(of: " ", with: "")
    //  print(trimmed)
        
        
        let startIndex = isbn.index(isbn.startIndex, offsetBy: 5)
        let endIndex = isbn.index(isbn.startIndex, offsetBy: 21)
        
        let newisbn = isbn[startIndex...endIndex]
        print(newisbn)
        
        queryEmail(of: newisbn) {
            (link) in
            if let link = link {
               // print("THE LINK IIIISSSS \(link)")
               let bookUrl = URL(string: link)
                let safariVC = SFSafariViewController(url: bookUrl as! URL)
                safariVC.delegate = self
                self.present(safariVC,animated: true, completion: nil)
                
                
                
            } else {
                print("Link not found")
            }
        }
       
     
        
    }
    
    func queryEmail(of ISBN: String, completion: @escaping (String?) -> Void) {
        let users = Database.database().reference().child("Carti")
        let query = users.queryOrdered(byChild: "ISBN").queryEqual(toValue: ISBN)
        query.observeSingleEvent(of: .value) {
            (snapshot: DataSnapshot) in
            guard snapshot.exists() else {
                completion(nil)
                return
            }
            let carti = snapshot.children.allObjects as! [DataSnapshot]
            let bookprop = carti.first!.value as! [String: Any]
            completion(bookprop["Link"] as? String)
        }
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController)
    {
        let home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeVC") as! HomeViewController
        
        
        
        self.present(home, animated: true, completion: nil)    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
 


}
