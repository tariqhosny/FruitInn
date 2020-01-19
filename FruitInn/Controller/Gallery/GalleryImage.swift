//
//  GalleryImage.swift
//  FruitInn
//
//  Created by Tariq on 1/14/20.
//  Copyright © 2020 Tariq. All rights reserved.
//

import UIKit

class GalleryImage: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var ImageScroll: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    var image = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTitleImage()
        loadImage()
        ImageScroll.delegate = self
        ImageScroll.minimumZoomScale = 1.0
        ImageScroll.maximumZoomScale = 5.0

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onDoubleTap))
        tapRecognizer.numberOfTapsRequired = 2
        view.addGestureRecognizer(tapRecognizer)
        updateZoomFor(size: imageView.bounds.size)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func updateZoomFor(size: CGSize){
        let widthScale = size.width / imageView.bounds.width
        let heightScale = size.height / imageView.bounds.height
        let scale = min(widthScale,heightScale)
        ImageScroll.minimumZoomScale = scale
    }
    
    @objc func onDoubleTap(gestureRecognizer: UITapGestureRecognizer) {
        let scale = min(ImageScroll.maximumZoomScale, ImageScroll.maximumZoomScale)
        
        if scale != ImageScroll.zoomScale {
            let point = gestureRecognizer.location(in: imageView)
            
            let scrollSize = ImageScroll.frame.size
            let size = CGSize(width: scrollSize.width / scale,
                              height: scrollSize.height / scale)
            let origin = CGPoint(x: point.x - size.width / 2,
                                 y: point.y - size.height / 2)
            ImageScroll.zoom(to:CGRect(origin: origin, size: size), animated: true)
            print(CGRect(origin: origin, size: size))
        }else if scale == ImageScroll.maximumZoomScale{
            ImageScroll.zoom(to:CGRect(origin: imageView.frame.origin, size: imageView.frame.size), animated: true)
        }
    }
    
    func loadImage(){
        let urlWithoutEncoding = ("\(URLs.imageUrl)\(image)")
        let encodedLink = urlWithoutEncoding.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        imageView.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            imageView.kf.setImage(with: url)
        }
    }
}
