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


class BookVC: UIViewController, SFSafariViewControllerDelegate  {
    

    var isbn = " "
    
    @IBOutlet weak var msgLabel: UILabel!
    
   private var urlString:String = "https://goodread.ro/recenzie-povestea-faridei-fata-care-invins-isis-de-farida-khalaf-andrea-c-hoffmann/"

    override func viewDidLoad() {
        super.viewDidLoad()
        print(isbn)
        msgLabel.isHidden = true
        let startIndex = isbn.index(isbn.startIndex, offsetBy: 5)
        let endIndex = isbn.index(isbn.startIndex, offsetBy: 21)
        
        let newisbn = isbn[startIndex...endIndex]
        print(newisbn)
       
     
        DataService.ds.REF_BOOKS.queryOrdered(byChild: "ISBN").queryEqual(toValue: newisbn).observeSingleEvent(of: .value, with: {(snapshot) in
            
            if snapshot.exists() {
               
              print(snapshot.value)
                let svc = SFSafariViewController(url: NSURL(string: self.urlString)! as URL, entersReaderIfAvailable: true)
                svc.delegate = self
               self.present(svc, animated: true, completion: nil)
               
            }
            else {
               print("nu e")
            /*self.msgLabel.text = "Nu s-au gasit date!"
                self.msgLabel.isHidden = false*/
               
            }
        })
    
    
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController)
    {
        let home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeVC") as! HomeViewController
        
        
        
        self.present(home, animated: true, completion: nil)    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
 

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
