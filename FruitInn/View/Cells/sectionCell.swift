//
//  sectionCell.swift
//  FruitInn
//
//  Created by Tariq on 12/22/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit

class sectionCell: UICollectionViewCell {
    
    @IBOutlet weak var sectionImage: UIImageView!
    @IBOutlet weak var sectionName: UILabel!
    
    func configureCell(section: productsData){
        sectionName.text = section.title
        let urlWithoutEncoding = ("\(URLs.imageUrl)\(section.image!)")
        let encodedLink = urlWithoutEncoding.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        sectionImage.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            sectionImage.kf.setImage(with: url)
        }
    }
}
