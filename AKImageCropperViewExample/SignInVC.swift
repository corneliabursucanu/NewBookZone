//
//  SignInVC.swift
//  AKImageCropperView
//
//  Created by Cornelia Bursucanu on 6/15/17.
//  Copyright © 2017 Artem Krachulov. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth
import SwiftKeychainWrapper


class SignInVC: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passField: UITextField!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
         navigationController?.isNavigationBarHidden = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewDidAppear(_ animated: Bool) {
        
        if let _ = KeychainWrapper.standard.string(forKey: "uid"){
            performSegue(withIdentifier: "homeVC", sender: nil)
            
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }

    
    @IBAction func fbBtnTapped(_ sender: Any) {
    
        let fbLogin = FBSDKLoginManager()
        
        fbLogin.logIn(withReadPermissions: ["email"], from: self){ (result, error) in
            
            if error != nil {
                print("Unable to authenticate with Facebook - \(String(describing: error))")
                
            }
            else if result?.isCancelled == true {
                print ("User cancelled authentication")
            }
            else {
                print ("User authenticated successfully")
                let credential = FacebookAuthProvider.credential(withAccessToken:
                    FBSDKAccessToken.current().tokenString)
                
                self.firebaseAuth(_credential: credential)
            }
            
        }
        

    
    }
    
    
   
    @IBAction func signInBtnTapped(_ sender: Any) {
        
        if let email = emailField.text, let password = passField.text{
            
            Auth.auth().signIn(withEmail: email, password: password, completion: {(user,error) in
                
                if error == nil {
                    print ("User authenticated with email")
                    
                    if let user = user{
                        self.completeSignIn(id:user.uid, username: email, provider: "firebase")
                    }
                }
                else {
                    Auth.auth().createUser(withEmail: email, password: password, completion: { (user,error) in
                        if error != nil {
                            print ("Unable to authenticate with Firebase using email")
                        }
                        else {
                            print ("Successfully autenthicated with Firebase using email")
                            if let user = user{
                                self.completeSignIn(id:user.uid, username: self.emailField.text!, provider: "firebase")
                            }
                            
                        }
                        
                        
                    })
                    
                }
                
            })
            
        }
                
        
    }
    
    func firebaseAuth(_credential: AuthCredential)
    {
        Auth.auth().signIn(with: _credential, completion: { (user, error) in
            if error != nil {
                print("Unable to authenticate with Firebase")
            }
            else {
                
                print ("Successfully authenticated with Firebase")
                
                if let user = user{
                    self.completeSignIn(id: user.uid, username: user.displayName!, provider: "facebook.com")
                    
                }
                
            }
            
        })
        
    }
    
    func completeSignIn(id: String, username: String, provider: String){
        DataService.ds.createUser(uid:id, provider: provider, username: username)
        let k = KeychainWrapper.standard.set(id, forKey: "uid" )
        print ("Data saved to keychain\(k)")
        performSegue(withIdentifier: "homeVC", sender: nil)
        
        
    }
    
 
    

}
