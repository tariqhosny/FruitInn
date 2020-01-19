//
//  galleryCell.swift
//  FruitInn
//
//  Created by Tariq on 12/26/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit

class galleryCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var videoIcon: UIImageView!
    
    func configuration(links: galleryLinks){
        let urlWithoutEncoding = ("\(URLs.imageUrl)\(links.image!)")
        let encodedLink = urlWithoutEncoding.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        imageView.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            imageView.kf.setImage(with: url)
        }
        if links.link == nil{
            videoIcon.isHidden = true
        }else{
            videoIcon.isHidden = false
        }
    }
    
}
