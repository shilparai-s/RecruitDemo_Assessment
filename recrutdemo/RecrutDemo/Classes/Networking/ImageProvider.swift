import Foundation
import UIKit

typealias DownloadCompletion = ((_ image: UIImage?, _ urlString: String) -> ())?

class ImageProvider {
    
    private let networkLayer: NetworkLayer
    private let queue = DispatchQueue(label: "imageDownloading")
    private let cache = ImageCache()
    
    init() {
        self.networkLayer = NetworkLayer.sharedInstance
    }
    
    func imageAsync(from urlString: String, completion: DownloadCompletion) {
        
//        SS: This should check the image in cache if not available then download it from url
        
        guard let url = URL(string: urlString) else {
            
            completion?(nil, urlString)
            return
        }
        
        var imageName = self.imageName(for: url)
        queue.async { [weak self] in
            
            self?.downloadImage(from: url, saveAs: imageName, completion: { (image, urlString) in
                
                DispatchQueue.main.async { () -> Void in
                    completion?(image, urlString)
                }
            })
        }
    }

//    SS: Everytime the image is downloaded from URL, though there is a provision to save it locally it is never fetch from there. This method should first check if the image is available locally, if not check in application cache. If image is not available then it should fetch it from url.
    private func downloadImage(from url: URL, saveAs imageName: String, completion: DownloadCompletion) {
        
        networkLayer.downloadFile(from: url, completion: { (locationURL, response, error) in
            
            let urlString = url.absoluteString
            guard let location = locationURL else {
                
                completion?(nil, urlString)
                return
            }
            
            let name = self.cache.imageName(for: url)
//            SS: There should be separate method to fetch the image from cache.
            let image = self.cache.storeImageInCache(from: location, imageName: name)
            completion?(image, urlString)
        })
    }
    
    func imageName(for url: URL) -> String {
        
        var imageName = url.lastPathComponent
        if let size = url.query {
            imageName = imageName + size
        }
        return imageName
    }
}
























