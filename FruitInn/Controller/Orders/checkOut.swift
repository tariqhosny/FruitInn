//
//  checkOut.swift
//  FruitInn
//
//  Created by Tariq on 12/25/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class checkOut: UIViewController {
    
    @IBOutlet weak var phoneTf: UITextField!
    @IBOutlet weak var quantityTf: UITextField!
    @IBOutlet weak var commentsTv: UITextView!
    @IBOutlet weak var popView: UIView!
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    @IBOutlet weak var indicatorView: UIView!
    
    var id = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicatorView.isHidden = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTap(_:))))
        popView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapPop(_:))))
        // Do any additional setup after loading the view.
    }
    
    
    @objc func onTap(_ sender:UIPanGestureRecognizer) {
       dismiss(animated: false, completion: nil)
    }
    
    @objc func onTapPop(_ sender:UIPanGestureRecognizer) {
        print("متدوسش هنا تانى .... يلا يا كوكو متنحش")
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func orderBtn(_ sender: Any) {
        activityIndicatorView.startAnimating()
        indicatorView.isHidden = false
        
        guard let phone = phoneTf.text, !phone.isEmpty else {
            let messages = "Please enter your Phone".localized
            self.showAlert(title: "Order".localized, message: messages)
            return
        }
        
        guard let quantity = quantityTf.text, !quantity.isEmpty else {
            let messages = "Please enter the Quantity".localized
            self.showAlert(title: "Order".localized, message: messages)
            return
        }
        
        guard let comments = commentsTv.text, !comments.isEmpty else {
            let messages = "Please enter your Comments".localized
            self.showAlert(title: "Order".localized, message: messages)
            return
        }
        print(comments.description)
        ordersApi.createOrderApi(id: id, phone: phone, quantity: quantity, comment: comments) { (message) in
            if let message = message.data{
                let alert = UIAlertController(title: "Order".localized, message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok".localized, style: .destructive, handler: { (action: UIAlertAction) in
                    self.dismiss(animated: false, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
                print(" \(phone), \(quantity), \(comments), \(self.id)")
            }
        }
    }
    
}
