//
//  productDetails.swift
//  FruitInn
//
//  Created by Tariq on 12/23/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class productDetails: UIViewController {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var detailsTableView: UITableView!
    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var viewHieght: NSLayoutConstraint!
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    @IBOutlet weak var indicatorView: UIView!
    
    var observer: NSObjectProtocol?
    var tableHeight = CGFloat()
    var product = productsData()
    var relatedProduct = [productsData]()
    var details = [productsData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(product.id ?? 0)
        startLoadData()
        addTitleImage()
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        productCollectionView.register(UINib.init(nibName: "productsCell", bundle: nil), forCellWithReuseIdentifier: "productsCell")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if let observer = observer {
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
    func startLoadData(){
        relatedProductHandelRefresh()
        detailsHandelRefresh()
        setProductImage()
    }
    
    func setProductImage(){
        productDescription.text = product.description
        productName.text = product.title
        let urlWithoutEncoding = ("\(URLs.imageUrl)\(product.image!)")
        let encodedLink = urlWithoutEncoding.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        productImage.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            productImage.kf.setImage(with: url)
        }
    }
    
    func relatedProductHandelRefresh(){
        activityIndicatorView.startAnimating()
        indicatorView.isHidden = false
        productsApi.relatedProductApi(id: product.id ?? 0) { (relatedProduct) in
            if let relatedProduct = relatedProduct.data{
                self.relatedProduct = relatedProduct
                self.productCollectionView.reloadData()
            }
        }
    }
    
    func detailsHandelRefresh(){
        productsApi.productsAdditionsApi(id: product.id ?? 0) { (details) in
            if let details = details.data{
                self.details = details
                self.detailsTableView.reloadData()
            }
            self.tableHeight = self.detailsTableView.contentSize.height + self.detailsTableView.contentInset.bottom + self.detailsTableView.contentInset.top
            self.viewHieght.constant = self.tableHeight + self.productDescription.intrinsicContentSize.height + 540
            self.view.layoutIfNeeded()
            self.indicatorView.isHidden = true
            self.activityIndicatorView.stopAnimating()
        }
    }
    
    @IBAction func orderBtn(_ sender: Any) {
        if helper.getUserToken() != nil{
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let popUp = sb.instantiateViewController(withIdentifier: "checkOut") as! checkOut
            popUp.id = product.id ?? 0
            self.present(popUp, animated: false)
        }else{
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let popUp = sb.instantiateViewController(withIdentifier: "login") as! Login
            popUp.fromDetails = 1
            self.present(popUp, animated: false)
        }
    }
    
}
extension productDetails: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return relatedProduct.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productsCell", for: indexPath) as! productsCell
        cell.configureCell(product: relatedProduct[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = collectionView.frame.width
        var width = (screenWidth-50)/2
        width = width < 130 ? 160 : width
        return CGSize.init(width: width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.product = relatedProduct[indexPath.item]
        self.loadView()
        self.viewDidLoad()
    }
}
extension productDetails: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productDetailsCell", for: indexPath) as! productDetailsCell
        cell.configureCell(details: details[indexPath.item])
        return cell
    }
}
