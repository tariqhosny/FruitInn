//
//  categoryFilterCell.swift
//  FruitInn
//
//  Created by Tariq on 1/12/20.
//  Copyright © 2020 Tariq. All rights reserved.
//

import UIKit

class categoryFilterCell: UITableViewCell {

    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var selectedCell: UIImageView!
    
    func configure(category: productsData){
        selectedCell.isHidden = true
        categoryName.text = category.title
        let urlWithOutEncoding = ("\(URLs.imageUrl)\(category.image!)")
        let encodedLink = urlWithOutEncoding.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        categoryImage.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)"){
            categoryImage.kf.setImage(with: url)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectedCell.isHidden = selected ? false : true
    }

}
