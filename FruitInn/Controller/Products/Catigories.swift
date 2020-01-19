//
//  Catigories.swift
//  FruitInn
//
//  Created by Tariq on 1/1/20.
//  Copyright © 2020 Tariq. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class Catigories: UIViewController {

    @IBOutlet weak var catigoriesCollectionView: UICollectionView!
    @IBOutlet weak var categoryTitleLb: UILabel!
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    @IBOutlet weak var indicatorView: UIView!
    
    var sections = productsData()
    var categories = [productsData]()
    var singleCategory = productsData()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addTitleImage()
        catigoriesCollectionView.delegate = self
        catigoriesCollectionView.dataSource = self
        // Do any additional setup after loading the view.
        categoryTitleLb.text = sections.title
        categoriesHandelRefresh()
    }

    func categoriesHandelRefresh(){
        activityIndicatorView.startAnimating()
        indicatorView.isHidden = false
        productsApi.categoriesApi(id: sections.id!) { (category) in
            if let category = category{
                self.categories = category.data!
                self.catigoriesCollectionView.reloadData()
            }
            self.indicatorView.isHidden = true
            self.activityIndicatorView.stopAnimating()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? products{
            destination.category = self.singleCategory
        }
    }
}
extension Catigories: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! categoryCell
        cell.configure(category: categories[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = catigoriesCollectionView.frame.width
        var width = (screenSize-10)/2
        width = width < 130 ? 160 : width
        return CGSize.init(width: width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        singleCategory = categories[indexPath.item]
        performSegue(withIdentifier: "products", sender: nil)
    }
}
