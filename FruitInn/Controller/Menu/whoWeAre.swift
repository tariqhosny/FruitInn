//
//  whoWeAre.swift
//  FruitInn
//
//  Created by Tariq on 12/23/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class whoWeAre: UIViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var descriptionLb: UILabel!
    
    var facebook = String()
    var instagram = String()
    var twitter = String()
    var linked = String()
    var links = [socialModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMenuBtn(menuButton: menuButton)
        dataHandelRefresh()
        linksHandelRefresh()
        // Do any additional setup after loading the view.
    }
    
    func dataHandelRefresh(){
        activityIndicatorView.startAnimating()
        indicatorView.isHidden = false
        MenuApis.whoWeAreApi { (data) in
            if let whoWeAra = data.data{
                self.titleLb.text = whoWeAra[0].title
                self.descriptionLb.text = whoWeAra[0].description
            }
            self.indicatorView.isHidden = true
            self.activityIndicatorView.stopAnimating()
        }
    }
    
    func linksHandelRefresh(){
        MenuApis.socialApi { (links) in
            if let links = links.data{
                self.links = links
                print(self.links)
                for link in self.links{
                    if link.name == "facebook"{
                        self.facebook = link.link ?? ""
                    }else if link.name == "twitter"{
                        self.twitter = link.link ?? ""
                    }else if link.name == "instagram"{
                        self.instagram = link.link ?? ""
                    }else if link.name == "linkedin"{
                        self.linked = link.link ?? ""
                    }
                }
            }
        }
    }
    
    @IBAction func facebookBtn(_ sender: Any) {
        print(facebook)
        guard let url = URL(string: self.facebook) else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func twitterBtn(_ sender: Any) {
        print(twitter)
        guard let url = URL(string: self.twitter) else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func instaBtn(_ sender: Any) {
        print(instagram)
        guard let url = URL(string: self.instagram) else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func linkedBtn(_ sender: Any) {
        print(instagram)
        guard let url = URL(string: self.linked) else { return }
        UIApplication.shared.open(url)
    }
}
