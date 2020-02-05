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
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(onDrage(_:))))

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
    
    @objc func onDrage(_ sender:UIPanGestureRecognizer) {
           let percentThreshold:CGFloat = 0.3
           let translation = sender.translation(in: view)

           let newX = ensureRange(value: view.frame.minY + translation.y, minimum: 0, maximum: view.frame.maxY)
           let progress = progressAlongAxis(newX, view.bounds.width)

           view.frame.origin.y = newX

           if sender.state == .ended {
               let velocity = sender.velocity(in: view)
              if velocity.y >= 300 || progress > percentThreshold {
                  _ = navigationController?.popViewController(animated: true)
              } else {
                  UIView.animate(withDuration: 0.2, animations: {
                      self.view.frame.origin.y = 0
                  })
             }
          }

          sender.setTranslation(.zero, in: view)
       }
    
    func progressAlongAxis(_ pointOnAxis: CGFloat, _ axisLength: CGFloat) -> CGFloat {
        let movementOnAxis = pointOnAxis / axisLength
        let positiveMovementOnAxis = fmaxf(Float(movementOnAxis), 0.0)
        let positiveMovementOnAxisPercent = fminf(positiveMovementOnAxis, 1.0)
        return CGFloat(positiveMovementOnAxisPercent)
    }

    func ensureRange<T>(value: T, minimum: T, maximum: T) -> T where T : Comparable {
        return min(max(value, minimum), maximum)
    }
}
