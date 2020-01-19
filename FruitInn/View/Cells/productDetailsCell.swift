//
//  productDetails.swift
//  FruitInn
//
//  Created by Tariq on 12/25/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit

class productDetailsCell: UITableViewCell {

    @IBOutlet weak var valueLb: UILabel!
    @IBOutlet weak var keyLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(details: productsData){
        keyLb.text = details.title
        valueLb.text = details.description
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
