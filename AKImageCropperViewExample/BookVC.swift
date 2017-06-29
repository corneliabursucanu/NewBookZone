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

class BookVC: UIViewController, SFSafariViewControllerDelegate, UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    
   
    @IBOutlet weak var otherImageBtn: UIButton!
    
    var isbn = " "
    var newisbn = ""
    var titlu: String!
    var autor: String!
    
    @IBOutlet weak var msgLabel: UILabel!
    @IBOutlet weak var googleBtn: UIButton!
    
    @IBOutlet weak var addcommBtn: UIButton!
    @IBOutlet weak var commentsTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(isbn)
        commentsTableView.isHidden = true
        addcommBtn.isHidden = true
        googleBtn.isHidden = true
        msgLabel.isHidden = true
        otherImageBtn.isHidden = true
        //  let trimmed = isbn.replacingOccurrences(of: " ", with: "")
        //  print(trimmed)
        
        
        isbn = isbn.replacingOccurrences(of: "-", with: "")

        let startIndex = isbn.index(isbn.startIndex, offsetBy: 4)
        let endIndex = isbn.index(isbn.startIndex, offsetBy: 16)
        
        newisbn = isbn[startIndex...endIndex]
        print(newisbn)
        
        
        queryEmail(of: newisbn) {
            (link) in
            if let link = link {
                // print("THE LINK IIIISSSS \(link)")
                
                
                let bookUrl = URL(string: link)
                
                /*
                 let safariVC = SFSafariViewController(url: bookUrl as! URL)
                 safariVC.delegate = self
                 self.present(safariVC,animated: true, completion: nil)
                 
                 */
                
            
                
                let request = URLRequest(url: bookUrl!)
                let session = URLSession.shared
                let task = session.dataTask(with: request){ (data, response, error ) in
                    
                    if error == nil{
                        let svc = SFSafariViewController(url: NSURL(string: link)! as URL)
                        svc.delegate = self
                        self.present(svc, animated: true, completion: nil)
                        
                        
                    }
                        
                    else {
                        
                        print("ERROR: \(String(describing: error))")
                    }
                    
                    
                }
                task.resume()
            }
                
            else {
                print("Link not found")
            
                self.msgLabel.isHidden = false
                self.googleBtn.isHidden = false
                self.otherImageBtn.isHidden = false
            }
        }
        
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = commentsTableView.dequeueReusableCell(withIdentifier: "commentCell") as! CommentTableViewCell
        
        return cell
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
           self.titlu = bookprop["Titlu"] as? String
        self.autor = bookprop["Autor"] as? String
            completion(bookprop["Link"] as? String)
        }
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController)
    {
        
         controller.dismiss(animated: true, completion: nil)
        self.googleBtn.isHidden = false
        
        
        
          }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moreVC"{
            if let destination = segue.destination as? MoreVC {
                print(isbn)
                print(titlu)
                
                destination.bookisbn = newisbn
                destination.booktitle = titlu
                destination.bookauthor = autor
                
            }
            
            
            
            
        }
    }
    
    
    
    
    
}
