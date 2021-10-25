import Foundation
import UIKit

typealias DownloadCompletion = ((_ image: UIImage?, _ urlString: String) -> ())?

class ImageProvider {
    
    private let networkLayer: NetworkLayer
    private let queue = DispatchQueue(label: "imageDownloading",attributes: .concurrent)
    private let cache = ImageCache()
    
    init() {
        self.networkLayer = NetworkLayer.sharedInstance
    
    }
    
    func imageAsync(from urlString: String, completion: DownloadCompletion) {
        
        guard let url = URL(string: urlString) else {
            
            completion?(nil, urlString)
            return
        }
        //Check in cache if the image is available, if YES return the image.
        if let image = self.cache.image(for: url) {
            DispatchQueue.main.async { () -> Void in
                completion?(image, urlString)
            }
            return
        }
        
        queue.async { [weak self] in
            self?.downloadImage(from: url, completion: { (image, urlString) in
                
                DispatchQueue.main.async { () -> Void in
                    completion?(image, urlString)
                }
            })
        }
    }

//    SS: Everytime the image is downloaded from URL, though there is a provision to save it locally it is never fetch from there. This method should first check if the image is available locally, if not check in application cache. If image is not available then it should fetch it from url.
    private func downloadImage(from url: URL, completion: DownloadCompletion) {
        networkLayer.downloadImage(from: url, completion: {
            (data, response, error) in
            
            let urlString = url.absoluteString
            guard let imageData = data else {
                completion?(nil,urlString)
                return
            }
            
            DispatchQueue.main.async {
                
                guard let image = UIImage(data: imageData) else {
                    completion?(nil,urlString)
                    return
                }
                
                let name = self.cache.imageName(for: url)
                self.cache.store(image: image, imageName: name)
                completion?(image,urlString)

            }
        })
        
//         networkLayer.downloadFile(from: url, completion: { (locationURL, response, error) in
//
//            let urlString = url.absoluteString
//            guard let location = locationURL else {
//
//                completion?(nil, urlString)
//                return
//            }
//
//            DispatchQueue.global().async {
//                guard let image = self.image(from: location) else {
//                    completion?(nil, urlString)
//                    return
//                }
//
//                DispatchQueue.main.async {
//                    let name = self.cache.imageName(for: url)
//                    self.cache.store(image: image, imageName: name)
//                    completion?(image, urlString)
//                }
//
//            }
//
//        })
    }
        
}
























