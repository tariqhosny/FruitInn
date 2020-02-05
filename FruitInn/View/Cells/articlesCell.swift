//
//  articlesCell.swift
//  FruitInn
//
//  Created by Tariq on 12/22/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit

class articlesCell: UICollectionViewCell {
    
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleLb: UILabel!
    @IBOutlet weak var dateLb: UILabel!
    
    func configureCell(product: productsData){
        articleLb.text = product.title
        dateLb.text = product.date
        let urlWithoutEncoding = ("\(URLs.imageUrl)\(product.image!)")
        let encodedLink = urlWithoutEncoding.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        articleImage.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            articleImage.kf.setImage(with: url)
        }
    }
}
