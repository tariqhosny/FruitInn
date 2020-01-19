//
//  seasonCell.swift
//  FruitInn
//
//  Created by Tariq on 1/12/20.
//  Copyright © 2020 Tariq. All rights reserved.
//

import UIKit

class seasonCell: UICollectionViewCell {
    @IBOutlet weak var seasonName: UILabel!
    @IBOutlet weak var seasonImage: UIImageView!
    
    func configure(season: productsData){
        seasonName.text = season.title
        let urlWithOutEncoding = ("\(URLs.imageUrl)\(season.image!)")
        let encodedLink = urlWithOutEncoding.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        seasonImage.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)"){
            seasonImage.kf.setImage(with: url)
        }
    }
    
    override var isSelected: Bool {
        didSet{
            layer.cornerRadius = isSelected ? 5.0 : 0.0
            layer.borderWidth =  isSelected ? 1.0 : 0.0
            layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
}
