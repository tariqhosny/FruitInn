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

    @IBOutlet weak var nameTf: UITextField!
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
        guard let name = nameTf.text, !name.isEmpty else {
            let messages = "Please enter your Name"
            self.showAlert(title: "Order", message: messages)
            return
        }
        
        guard let phone = phoneTf.text, !phone.isEmpty else {
            let messages = "Please enter your Phone"
            self.showAlert(title: "Order", message: messages)
            return
        }
        
        guard let quantity = quantityTf.text, !quantity.isEmpty else {
            let messages = "Please enter the Quantity"
            self.showAlert(title: "Order", message: messages)
            return
        }
        
        guard let comments = commentsTv.text, !comments.isEmpty else {
            let messages = "Please enter your Comments"
            self.showAlert(title: "Order", message: messages)
            return
        }
        productsApi.createOrderApi(id: id, name: name, phone: phone, quantity: quantity, comment: comments) { (message) in
            if let message = message.data{
                let alert = UIAlertController(title: "Order", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: { (action: UIAlertAction) in
                    self.dismiss(animated: false, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
                print("\(name), \(phone), \(quantity), \(comments), \(self.id)")
            }
        }
    }
    
}
