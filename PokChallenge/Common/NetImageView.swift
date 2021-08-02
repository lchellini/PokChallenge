//
//  DownloadedImageView.swift
//  PokChallenge
//
//  Created by Lorenzo Chellini on 01/08/21.
//

import Foundation
import UIKit

class NetImageView: UIImageView
{

    private let imageCache = NSCache<AnyObject, UIImage>()

    func loadImage(fromURL p_imageURL: URL, p_placeHolderImage: String)
    {
        self.image = UIImage(named: p_placeHolderImage)

        if let cachedImage = self.imageCache.object(forKey: p_imageURL as AnyObject) {
            //debugPrint("image loaded from cache for =\(p_imageURL)")
            self.image = cachedImage
            return
        }

        DispatchQueue.global().async { [weak self] in
            if let imageData = try? Data(contentsOf: p_imageURL) {
                //debugPrint("image downloaded from server...")
                if let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self!.imageCache.setObject(image, forKey: p_imageURL as AnyObject)
                        self?.image = image
                    }
                }
            }
        }
    }
}
