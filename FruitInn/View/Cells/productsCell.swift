//
//  productsCell.swift
//  FruitInn
//
//  Created by Tariq on 12/22/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit

class productsCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productCountryImage: UIImageView!
    @IBOutlet weak var productDescription: UILabel!
    //egypt vietnam  china  england
    override func awakeFromNib() {
        if helper.getCountryId() == "egypt"{
            productCountryImage.image = #imageLiteral(resourceName: "egypt")
        }else if helper.getCountryId() == "china"{
            productCountryImage.image = #imageLiteral(resourceName: "china")
        }else if helper.getCountryId() == "england"{
            productCountryImage.image = #imageLiteral(resourceName: "england")
        }else{
            productCountryImage.image = #imageLiteral(resourceName: "vietnam")
        }
        
        self.mask?.layer.cornerRadius = 8.0
        self.mask?.layer.masksToBounds = true
        self.mask?.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
    }
    
    func configureCell(product: productsData){
        productName.text = product.title
        productDescription.text = product.short_description
        let urlWithoutEncoding = ("\(URLs.imageUrl)\(product.image!)")
        let encodedLink = urlWithoutEncoding.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        productImage.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            productImage.kf.setImage(with: url)
        }
    }
}
