
import UIKit
import SafariServices



final class ImageViewController: UIViewController{

   
 
    
    var tessText = " "

    var image: UIImage!
    

    
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: -- Actions
    
    @IBAction func backAction(_ sender: UIButton) {
        
        _ = navigationController?.popViewController(animated: true)
    }
    
   
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = image
        
       
        let scaledImage = scaleImage(image, maxDimension: 640)
        self.performImageRecognition(scaledImage)
        
    }
  
    
    

    
    
    func performImageRecognition(_ image: UIImage) {
        // 1
        let tesseract = G8Tesseract()
        // 2
        tesseract.language = "eng+fra"

        // 4
        tesseract.pageSegmentationMode = .auto
        // 5
        tesseract.maximumRecognitionTime = 60.0
        
        
       
        // 6
        tesseract.image = image.g8_blackAndWhite()
        tesseract.recognize()
        tessText = tesseract.recognizedText.trimmingCharacters(in: .whitespacesAndNewlines)
       
        print("begining\(tessText)the end")
       
        
    
       
    }
    
  
    
    @IBAction func nextBtnTapped(_ sender: Any) {
       
        
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController)
    {
        let home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeVC") as! HomeViewController
        
        
        
        self.present(home, animated: true, completion: nil)    }
    
    func scaleImage(_ image: UIImage, maxDimension: CGFloat) -> UIImage {
        
        var scaledSize = CGSize(width: maxDimension, height: maxDimension)
        var scaleFactor:CGFloat
        
        if image.size.width > image.size.height {
            scaleFactor = image.size.height / image.size.width
            scaledSize.width = maxDimension
            scaledSize.height = scaledSize.width * scaleFactor
        } else {
            scaleFactor = image.size.width / image.size.height
            scaledSize.height = maxDimension
            scaledSize.width = scaledSize.height * scaleFactor
        }
        
        UIGraphicsBeginImageContext(scaledSize)
        image.draw(in: CGRect(x: 0, y: 0, width: scaledSize.width, height: scaledSize.height))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "bookVC"{
            if let destination = segue.destination as? BookVC {
                print(tessText)
                var recText = tessText.replacingOccurrences(of: "~", with: "-")
                recText = recText.replacingOccurrences(of: " ", with: "")
                recText = recText.replacingOccurrences(of: ":", with: "")

                
                destination.isbn = recText.replacingOccurrences(of: "—", with: "-")
                
            
            }
    
        
        
        
        }
    }
}
