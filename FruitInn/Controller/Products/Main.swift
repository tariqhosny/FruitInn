//
//  ViewController.swift
//  FruitInn
//
//  Created by Tariq on 12/18/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit
import MarqueeLabel
import NVActivityIndicatorView
import MOLH

class Main: UIViewController {
    
    @IBOutlet weak var bageControl: UIPageControl!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var sectionCollectionView: UICollectionView!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var articlsCollectionView: UICollectionView!
    @IBOutlet weak var viewHieght: NSLayoutConstraint!
    @IBOutlet weak var marqueeLabel:MarqueeLabel!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var underNewsImage: UIImageView!
    @IBOutlet weak var otherNewsImage: UIImageView!
    
    var collectionHeight = CGFloat()
    var slider = [productsData]()
    var sections = [productsData]()
    var singleSection = productsData()
    var products = [productsData]()
    var news = [productsData]()
    var article = productsData()
    var singleProduct = productsData()
    var timer : Timer?
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setMenuBtn(menuButton: menuButton)
        addCountryBtn()
        addTitleImage()
        productsCollectionView.register(UINib.init(nibName: "productsCell", bundle: nil), forCellWithReuseIdentifier: "productsCell")
        marqueeLabel.type = .continuous
        marqueeLabel.animationCurve = .linear
        
        bannerCollectionView.delegate = self
        sectionCollectionView.delegate = self
        productsCollectionView.delegate = self
        articlsCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        sectionCollectionView.dataSource = self
        productsCollectionView.dataSource = self
        articlsCollectionView.dataSource = self
        
        if MOLHLanguage.currentAppleLanguage() == "ar"{
            marqueeLabel.type = .rightLeft
            underNewsImage.image = #imageLiteral(resourceName: "Subtraction 2")
            otherNewsImage.image = #imageLiteral(resourceName: "Subtraction 1")
        }
        // Do any additional setup after loading the view.
        startTimer()
        sliderHandelRefresh()
        sectionsHandelRefresh()
        productsHandelRefresh()
        newsHandelRefresh()
    }
    
    func sliderHandelRefresh(){
        activityIndicatorView.startAnimating()
        indicatorView.isHidden = false
        productsApi.sliderApi { (image) in
            if let images = image{
                self.slider = images.data!
                self.bageControl.numberOfPages = self.slider.count
                self.bageControl.currentPage = 0
                self.bannerCollectionView.reloadData()
            }
            print(image!)
        }
    }
    
    func sectionsHandelRefresh(){
        productsApi.sectionsApi { (section) in
            if let section = section{
                self.sections = section.data!
                self.sectionCollectionView.reloadData()
            }
            print(section!)
        }
    }
    
    func productsHandelRefresh(){
        self.products.removeAll()
        productsApi.topProductsApi { (product) in
            if let product = product{
                self.products = product.data!
                self.productsCollectionView.reloadData()
            }
            print(product!)
            self.collectionHeight = self.productsCollectionView.collectionViewLayout.collectionViewContentSize.height
            self.viewHieght.constant = self.collectionHeight + 720
            self.view.layoutIfNeeded()
            
            self.indicatorView.isHidden = true
            self.activityIndicatorView.stopAnimating()
        }
    }
    
    func newsHandelRefresh(){
        MenuApis.newsApi { (news) in
            if let news = news.data{
                self.news = news
                self.articlsCollectionView.reloadData()
            }
            for n in self.news{
                self.marqueeLabel.text?.append(" - \(n.short_description ?? "")")
            }
            self.marqueeLabel.speed = .duration(CGFloat(10*self.news.count))
        }
    }
    
    func startTimer(){
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
    }
    
    @objc func changeImage() {
        
        if currentIndex < slider.count {
            let index = IndexPath.init(item: currentIndex, section: 0)
            self.bannerCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            bageControl.currentPage = currentIndex
            currentIndex += 1
        } else {
            currentIndex = 0
            let index = IndexPath.init(item: currentIndex, section: 0)
            self.bannerCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            bageControl.currentPage = currentIndex
            currentIndex = 1
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destenation = segue.destination as? Catigories{
            destenation.sections = self.singleSection
        }
        
        if let destination = segue.destination as? productDetails{
            destination.product = self.singleProduct
        }
        
        if let destination = segue.destination as? Articles{
            destination.article = self.article
        }
    }
    
}

extension Main: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == bannerCollectionView{
            return slider.count
        }else if collectionView == sectionCollectionView{
            return sections.count
        }else if collectionView == productsCollectionView{
            return products.count
        }else{
            return news.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == bannerCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath) as! bannerCell
            cell.configureCell(images: slider[indexPath.item])
            return cell
        }else if collectionView == sectionCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sectionCell", for: indexPath) as! sectionCell
            cell.configureCell(section: sections[indexPath.item])
            return cell
        }else if collectionView == productsCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productsCell", for: indexPath) as! productsCell
            cell.configureCell(product: products[indexPath.item])
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "articlesCell", for: indexPath) as! articlesCell
            cell.configureCell(product: news[indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == bannerCollectionView{
            return CGSize.init(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
        }else if collectionView == productsCollectionView{
            let screenWidth = collectionView.frame.width
            var width = (screenWidth-15)/2
            width = width < 130 ? 160 : width
            return CGSize.init(width: width, height: 150)
        }else if collectionView == sectionCollectionView{
            let screenWidth = collectionView.frame.width
            var width = (screenWidth-10)/2
            width = width < 130 ? 160 : width
            return CGSize.init(width: width, height: 150)
        }else{
            let screenWidth = collectionView.frame.width
            var width = (screenWidth-10)/2.25
            width = width < 130 ? 160 : width
            return CGSize.init(width: width, height: 175)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == productsCollectionView{
            singleProduct = products[indexPath.item]
            performSegue(withIdentifier: "details", sender: nil)
        }else if collectionView == sectionCollectionView{
            self.singleSection = sections[indexPath.item]
            performSegue(withIdentifier: "catigories", sender: nil)
        }else if collectionView == articlsCollectionView{
            self.article = news[indexPath.item]
            performSegue(withIdentifier: "articles", sender: nil)
        }
    }
    
}

