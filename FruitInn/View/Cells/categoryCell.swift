//
//  categoryCell.swift
//  FruitInn
//
//  Created by Tariq on 1/1/20.
//  Copyright © 2020 Tariq. All rights reserved.
//

import UIKit

class categoryCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    
    func configure(category: productsData){
        categoryName.text = category.title
        let urlWithOutEncoding = ("\(URLs.imageUrl)\(category.image!)")
        let encodedLink = urlWithOutEncoding.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        categoryImage.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)"){
            categoryImage.kf.setImage(with: url)
        }
    }
}
