//
//  Sections.swift
//  FruitInn
//
//  Created by Tariq on 1/6/20.
//  Copyright © 2020 Tariq. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class Sections: UIViewController {

    @IBOutlet weak var sectionsCollectionView: UICollectionView!
    @IBOutlet weak var sectionNameLable: UILabel!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    @IBOutlet weak var indicatorView: UIView!
    
    var categories = [productsData]()
    var singleCategory = productsData()
    
    var sectionId = Int()
    var sectionName = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(sectionId)
        sectionNameLable.text = sectionName
        sectionsCollectionView.delegate = self
        sectionsCollectionView.dataSource = self
        addTitleImage()
        setMenuBtn(menuButton: menuButton)
        categoriesHandelRefresh()
        // Do any additional setup after loading the view.
    }
    
    func categoriesHandelRefresh(){
        activityIndicatorView.startAnimating()
        indicatorView.isHidden = false
        productsApi.categoriesApi(id: sectionId) { (category) in
            if let category = category{
                self.categories = category.data!
                self.sectionsCollectionView.reloadData()
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
extension Sections: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! categoryCell
        cell.configure(category: categories[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = sectionsCollectionView.frame.width
        var width = (screenSize-10)/2
        width = width < 130 ? 160 : width
        return CGSize.init(width: width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        singleCategory = categories[indexPath.item]
        performSegue(withIdentifier: "products", sender: nil)
    }
}
