//
//  OrderDetails.swift
//  FruitInn
//
//  Created by Tariq on 1/14/20.
//  Copyright © 2020 Tariq. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class OrderDetails: UIViewController {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLb: UILabel!
    @IBOutlet weak var quantityLb: UILabel!
    @IBOutlet weak var codeLb: UILabel!
    @IBOutlet weak var commentsLb: UILabel!
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    @IBOutlet weak var indicatorView: UIView!
    
    var comments = String()
    var code = String()
    var image = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTitleImage()
        print(comments)
        print(code)
        orderHandelRefresh()
        productImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTaped)))
        // Do any additional setup after loading the view.
    }

    func orderHandelRefresh(){
        activityIndicatorView.startAnimating()
        indicatorView.isHidden = false
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
                self.image = order[0].image ?? ""
            }
            self.indicatorView.isHidden = true
            self.activityIndicatorView.stopAnimating()
        }
    }
    
    @objc func imageTaped(gestureRecognizer: UITapGestureRecognizer) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "GalleryImage") as! GalleryImage
        vc.image = image
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
