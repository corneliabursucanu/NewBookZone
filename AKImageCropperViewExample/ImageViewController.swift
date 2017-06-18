
import UIKit

final class ImageViewController: UIViewController {
    
    // MARK: - Properties
    
    var image: UIImage!
    
    // MARK: - Connections:
    
    // MARK: -- Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: -- Actions
    
    @IBAction func backAction(_ sender: UIButton) {
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func showListAction(_ sender: UIButton) {
        
        if presentingViewController != nil {
            
            _ = navigationController?.popToRootViewController(animated: true)

        } else {
        
            _ = navigationController?.popToViewController(navigationController!.viewControllers[1], animated: true)
        }
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = image
        
        addActivityIndicator()
        let scaledImage = scaleImage(image, maxDimension: 640)
        self.performImageRecognition(scaledImage)
        
    }
   var activityIndicator:UIActivityIndicatorView!
    
    
    func addActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(frame: view.bounds)
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.25)
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
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
        print(tesseract.recognizedText)
        let trimmedString = tesseract.recognizedText.trimmingCharacters(in: .whitespaces)
        print(trimmedString)
        
        // 7
        removeActivityIndicator()
       
    }
    
    func removeActivityIndicator() {
        activityIndicator.removeFromSuperview()
        activityIndicator = nil
    }
    
    
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
}
