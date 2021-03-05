//
//  UIImageView+Extensions.swift
//  GitHubApp
//
//  Created by Ivan Simunovic on 05.03.2021..
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImageFromUrl(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let cacheImage = ImageCache.default.retrieveImageInMemoryCache(forKey: urlString)
        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        self.kf.setImage(with: resource, placeholder: cacheImage, options: [.keepCurrentImageWhileLoading])
    }
    
    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }

}
