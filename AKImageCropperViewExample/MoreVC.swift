//
//  MoreVC.swift
//  AKImageCropperView
//
//  Created by Cornelia Bursucanu on 6/22/17.


import UIKit
import SafariServices

class MoreVC: UIViewController, SFSafariViewControllerDelegate {
    
    var books = [[String:Any]]()
    var booktitle: String?
    var bookauthor: String?

    
    
    @IBOutlet weak var otherImage: UIButton!
    var bookisbn: String!
    
    @IBOutlet weak var msgLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        msgLabel.isHidden = true
        otherImage.isHidden = true
        
        print("I RECEIVED \(bookisbn) and \(booktitle)")
        let isbnSearch = bookisbn.replacingOccurrences(of:"-", with:"")
        booktitle = booktitle?.replacingOccurrences(of: " ", with: "")
        bookauthor = bookauthor?.replacingOccurrences(of: " ", with: "")
        print(isbnSearch)
        
        
         print("---------------")
       downloadBookByIsbn(isbn: isbnSearch)
        
        
        

    }
    
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }
    
    
    
    
    func downloadBookByIsbn(isbn:String) {
        
        let stringUrl =  "https://www.googleapis.com/books/v1/volumes?q=isbn:\(isbn)"

        
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
                  //  print(items)
                    
                    
                    self.books = items
                    
                    
                    for book in self.books {
                        
                         let volumeInfo = book["volumeInfo"] as! [String:Any]
                        let title = volumeInfo["title"] as! String
                            let link = volumeInfo["previewLink"] as! String
                        
                   print("THANKS GOD\(link)")
                        print("titlul este \(title)")
                        
                        let svc = SFSafariViewController(url: NSURL(string: link)! as URL)
                        svc.delegate = self
                        self.present(svc, animated: true, completion: nil)

                        
                       
                        
                        
                        
                    }
                    
              //      print("I DID IT BY ISBN")
                    DispatchQueue.main.async {
                        
                    }
                    
                }
                
                
                else {
                    print("Nu am gasit cu ISBN")
                    if self.booktitle != nil {
                        if self.bookauthor != nil {
                    
                    self.downloadBookByTitle(titlu: self.booktitle!, autor:self.bookauthor!)
                    
                    
                }
            }
                    
                    else {
                    
                        print("N-am nici titlu nici autor")
                        self.msgLabel.isHidden = false
                        self.otherImage.isHidden = false
                    }
                    
            
            
            }
        }
                
            catch{
                
                print("Error with JSON")
            }
            
                    })
        task.resume()
        
        
        
    }
    
    
    
    func downloadBookByTitle(titlu:String, autor: String) {
        
        let stringUrl =  "https://www.googleapis.com/books/v1/volumes?q=\(titlu)+\(autor)"
        
        
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
                    //  print(items)
                    
                    
                    self.books = items
                    
                    
                    for book in self.books {
                        
                        let volumeInfo = book["volumeInfo"] as! [String:Any]
                        let title = volumeInfo["title"] as! String
                        let link = volumeInfo["previewLink"] as! String
                        
                        print("THANKS GOD\(link)")
                        print("titlul este \(title)")
                        
                        let svc = SFSafariViewController(url: NSURL(string: link)! as URL)
                        svc.delegate = self
                        self.present(svc, animated: true, completion: nil)
                        
                        
                        
                        
                        
                        
                    }
                    
                    //      print("I DID IT BY ISBN")
                    DispatchQueue.main.async {
                        
                    }
                    
                }
                    
                    
                else {
                    print("Nu am gasit cu ISBN")
                    
                    
                    
                }
                
                
            }
                
                
            catch{
                
                print("Error with JSON")
            }
            
            
        
        })
        task.resume()
        
        
        
    }
    

    
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController)
    {
        let home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeVC") as! HomeViewController
        self.present(home, animated: true, completion: nil)
        self.otherImage.isHidden = false
        
    }
    
    
    
}



