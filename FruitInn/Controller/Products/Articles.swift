//
//  Articles.swift
//  FruitInn
//
//  Created by Tariq on 1/13/20.
//  Copyright © 2020 Tariq. All rights reserved.
//

import UIKit

class Articles: UIViewController {

    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleNameLb: UILabel!
    @IBOutlet weak var dateLb: UILabel!
    @IBOutlet weak var descriptionLb: UILabel!
    
    var article = productsData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setApearance()
        addTitleImage()
    }
    

    func setApearance(){
       let urlWithoutEncoding = ("\(URLs.imageUrl)\(article.image!)")
        let encodedLink = urlWithoutEncoding.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        articleImage.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            articleImage.kf.setImage(with: url)
        }
        
        articleNameLb.text = article.title
        dateLb.text = article.date
        descriptionLb.text = article.description
    }

}
