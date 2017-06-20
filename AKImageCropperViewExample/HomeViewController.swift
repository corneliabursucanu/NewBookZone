

import UIKit
import FirebaseAuth
import SwiftKeychainWrapper


final class HomeViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    let imagePicker = UIImagePickerController()
    
    // MARK: - Connections:
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
     
        
        
        
    }
    // MARK: -- Actions
    

    
    @IBAction func logOutBtnTapped(_ sender: UIButton) {
    
 
        
            let _ = KeychainWrapper.standard.removeObject(forKey: "uid")
            try! Auth.auth().signOut()
            print("FKeychain removed successfully")
            let signin = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "signInVC") as! SignInVC
        
        
        
        self.present(signin, animated: true, completion: nil)            }
        

        
    
    
    
    
    
    @IBAction func galleryAction() {
        
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.imagePicker.sourceType = .camera
                self.present(self.imagePicker, animated: true, completion: nil)
            }else{
                print("Camera not available")
            }
            
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
        
        
    }
    
    
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       self.navigationController?.isNavigationBarHidden = true
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        let cropperViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "cropperViewController") as! CropperViewController
        cropperViewController.image = image
        
        picker.pushViewController(cropperViewController, animated: true)
    
    
}

}


