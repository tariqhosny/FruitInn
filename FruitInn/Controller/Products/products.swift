//
//  products.swift
//  FruitInn
//
//  Created by Tariq on 12/23/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class products: UIViewController {
    
    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var categoryNameLb: UILabel!
    
    var category = productsData()
    var products = [productsData]()
    var singleProduct = productsData()
    var seasonId = Int()
    var categorisIDs = [Int]()
    var egypt = Int()
    var england = Int()
    var china = Int()
    var vietnam = Int()
    var fromFilter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(seasonId)
        print(categorisIDs)
        print(egypt)
        print(england)
        print(china)
        print(vietnam)
        print(fromFilter)
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        addCountryBtn()
        addTitleImage()
        productsHandelRefresh()
        productsCollectionView.register(UINib.init(nibName: "productsCell", bundle: nil), forCellWithReuseIdentifier: "productsCell")
        // Do any additional setup after loading the view.
    }
    
    func productsHandelRefresh(){
        self.products.removeAll()
        activityIndicatorView.startAnimating()
        indicatorView.isHidden = false
        if fromFilter == 1{
            categoryNameLb.text = "Filter"
            productsApi.filterApi(seasonId: seasonId, categoryIDs: categorisIDs, england: england, egypt: egypt, china: china, vietnam: vietnam) { (products) in
                if let products = products.data{
                    self.products = products
                    self.productsCollectionView.reloadData()
                }
                self.indicatorView.isHidden = true
                self.activityIndicatorView.stopAnimating()
            }
        }else{
            if category.id == nil {
                categoryNameLb.text = "All Products"
                productsApi.allProductApi { (products) in
                    if let products = products.data{
                        self.products = products
                        self.productsCollectionView.reloadData()
                    }
                    self.indicatorView.isHidden = true
                    self.activityIndicatorView.stopAnimating()
                }
            }else{
                categoryNameLb.text = category.title
                productsApi.productsCategoryApi(id: category.id ?? 0) { (products) in
                    if let products = products.data{
                        self.products = products
                        self.productsCollectionView.reloadData()
                    }
                    self.indicatorView.isHidden = true
                    self.activityIndicatorView.stopAnimating()
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? productDetails{
            destination.product = self.singleProduct
        }
    }
    
}
extension products: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productsCell", for: indexPath) as! productsCell
        cell.configureCell(product: products[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = collectionView.frame.width
        var width = (screenWidth-10)/2
        width = width < 130 ? 160 : width
        return CGSize.init(width: width, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        singleProduct = products[indexPath.item]
        performSegue(withIdentifier: "details", sender: nil)
    }
    
}
