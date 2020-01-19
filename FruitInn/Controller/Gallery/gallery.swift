//
//  gallery.swift
//  FruitInn
//
//  Created by Tariq on 12/26/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit

class gallery: UIViewController {

    @IBOutlet weak var galleryCollectionView: UICollectionView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var gallery = [galleryLinks]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMenuBtn(menuButton: menuButton)
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
        galleryHandelRefresh()
        // Do any additional setup after loading the view.
    }
    
    func galleryHandelRefresh(){
        MenuApis.galleryApi { (gallery) in
            if let gallery = gallery.data{
                self.gallery = gallery
                self.galleryCollectionView.reloadData()
            }
        }
    }
}
extension gallery: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gallery.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "galleryCell", for: indexPath) as! galleryCell
        cell.configuration(links: gallery[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = collectionView.frame.width
        let width = (screenWidth-4)/3
        return CGSize.init(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if gallery[indexPath.item].link == nil{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "GalleryImage") as! GalleryImage
            vc.image = gallery[indexPath.item].image ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "GalleryVideo") as! GalleryVideo
            vc.videoLink = gallery[indexPath.item].link ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
