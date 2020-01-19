//
//  bannerCell.swift
//  FruitInn
//
//  Created by Tariq on 12/22/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit

class bannerCell: UICollectionViewCell {
    
    @IBOutlet weak var bannerImage: UIImageView!
    
    func configureCell(images: productsData){
        let urlWithoutEncoding = ("\(URLs.imageUrl)\(images.image!)")
        let encodedLink = urlWithoutEncoding.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        bannerImage.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            bannerImage.kf.setImage(with: url)
        }
    }
}
