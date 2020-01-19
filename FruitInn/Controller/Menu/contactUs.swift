//
//  contactUs.swift
//  FruitInn
//
//  Created by Tariq on 12/23/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class contactUs: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var emailTf: UITextField!
    @IBOutlet weak var phoneTf: UITextField!
    @IBOutlet weak var messageTv: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMenuBtn(menuButton: menuButton)
        
        indicatorView.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendMessageBtn(_ sender: Any) {
        guard let name = nameTf.text, !name.isEmpty else {
            let messages = "Please enter your name"
            self.showAlert(title: "Message", message: messages)
            return
        }
        
        guard let email = emailTf.text, !email.isEmpty else {
            let messages = "Please enter your email"
            self.showAlert(title: "Message", message: messages)
            return
        }
        
        guard let phone = phoneTf.text, !phone.isEmpty else {
            let messages = "Please enter your Phone"
            self.showAlert(title: "Message", message: messages)
            return
        }
        
        guard let message = phoneTf.text else {
            let messages = "Please enter your Message"
            self.showAlert(title: "Message", message: messages)
            return
        }
        
        guard isValidInput(Input: nameTf.text!) == true else {
            self.showAlert(title: "Message", message: "Name not correct")
            return
        }
        
        guard isValidEmail(testStr: emailTf.text ?? "") == true else {
            let messages = "Email not correct"
            self.showAlert(title: "Message", message: messages)
            return
        }
        
        activityIndicatorView.startAnimating()
        indicatorView.isHidden = false
        
        MenuApis.contactApi(name: name, email: email, phone: phone, message: message) { (message) in
            if let message = message.data{
                self.showAlert(title: "Message", message: message)
            }
            if message.status ?? false{
                self.nameTf.text = ""
                self.emailTf.text = ""
                self.phoneTf.text = ""
                self.messageTv.text = ""
            }
            self.indicatorView.isHidden = true
            self.activityIndicatorView.stopAnimating()
        }
    }
    
}
