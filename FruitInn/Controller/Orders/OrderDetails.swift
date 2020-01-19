//
//  OrderDetails.swift
//  FruitInn
//
//  Created by Tariq on 1/14/20.
//  Copyright © 2020 Tariq. All rights reserved.
//

import UIKit

class OrderDetails: UIViewController {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLb: UILabel!
    @IBOutlet weak var quantityLb: UILabel!
    @IBOutlet weak var codeLb: UILabel!
    @IBOutlet weak var commentsLb: UILabel!
    
    var comments = String()
    var code = String()
    var image = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTitleImage()
        print(comments)
        print(code)
        orderHandelRefresh()
        // Do any additional setup after loading the view.
    }

    func orderHandelRefresh(){
        self.codeLb.text = self.code
        self.commentsLb.text = self.comments
        ordersApi.orderDetailsApi(id: Int(code) ?? 0) { (order) in
            if let order = order.data{
                self.quantityLb.text = order[0].product_quantity
                self.productNameLb.text = order[0].product_name
                let urlWithoutEncoding = ("\(URLs.imageUrl)\(order[0].image ?? "")")
                let encodedLink = urlWithoutEncoding.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
                let encodedURL = NSURL(string: encodedLink!)! as URL
                self.productImage.kf.indicatorType = .activity
                if let url = URL(string: "\(encodedURL)") {
                    self.productImage.kf.setImage(with: url)
                }
            }
        }
    }
}
