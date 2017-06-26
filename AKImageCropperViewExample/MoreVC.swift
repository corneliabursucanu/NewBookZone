//
//  MoreVC.swift
//  AKImageCropperView
//
//  Created by Cornelia Bursucanu on 6/22/17.
//  Copyright © 2017 Artem Krachulov. All rights reserved.
//

import UIKit
import SafariServices

class MoreVC: UIViewController {
    
    var books = [[String:Any]]()


    @IBOutlet weak var tableView: UITableView!
    

    @IBOutlet weak var searchBar: UISearchBar!
    
    var bookisbn: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate =  self
        
        print("I RECEIVED \(bookisbn)")
        var isbnSearch = bookisbn.replacingOccurrences(of:"-", with:"")
        print (isbnSearch)
        
    
        
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }
    
    

    func downloadBook(bookTitle:String) {
    
        var stringUrl = "https://www.googleapis.com/books/v1/volumes?q=\(bookTitle)"
        
        guard let url = NSURL(string: stringUrl) else{
            print("You have a problem with the url")
            return
        
        }
        
        let urlRequest = NSMutableURLRequest(url:url as URL)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest as URLRequest, completionHandler: { (data, response, error) in
            
            guard data != nil else {
                print("No data downloaded")
                return
            
            }
            
            do {
            
                if let data = data,
                    let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                    let items = json["items"] as? [[String:Any]]  {
                print(items)
                    self.books = items
               print("I DID IT")
                    DispatchQueue.main.async {
                    
                   self.tableView.reloadData()
                    
                    }
                
                }
                
            
            }
            
                
             catch{
            
                print("Error with JSON")
            }
         
            
            
            
            print(error)
            print(response)
        })
        task.resume()
            
        
        
        }
        
  
    
    
}


extension MoreVC: UITableViewDataSource{
  
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as? BookCell
    
    
        if let volumeInfo = self.books[indexPath.row]["volumeInfo"] as? [String:Any]{
        
            let titlu = volumeInfo["title"] as? String
            print("the titlu is \(titlu)")
            
            
            if let imageLinks = volumeInfo["imageLinks"] as? [String:Any] {
            
            let imageUrl = imageLinks["thumbnail"] as? String
            print("the image url is \(imageUrl)")
            
            cell?.configureCell(title: titlu!, image: imageUrl!)

            }
        
            
            
            
        }
        
    
        
        
        
        
        return cell!
    }
    
    
    
    
    
    
}


extension MoreVC:UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let bookTitle = searchBar.text
        
        self.downloadBook(bookTitle: bookTitle!)
        
        searchBar.resignFirstResponder()
    }


}


extension MoreVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       // let selectedBook = self.books[indexPath.row]["volumeInfo"]["title"]
       
        if let volumeInfo = self.books[indexPath.row]["volumeInfo"] as? [String:Any]{
            
            let link = volumeInfo["previewLink"] as? String
            
            let fileUrl = NSURL(string: link!)
            

    
        
        let safariVC = SFSafariViewController(url: fileUrl! as URL)
      safariVC.delegate = self
    self.present(safariVC,animated: true, completion: nil)
            
            
          
            
        
    }
}
}


extension MoreVC: SFSafariViewControllerDelegate{
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }


}

