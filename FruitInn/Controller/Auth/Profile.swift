//
//  Profile.swift
//  FruitInn
//
//  Created by Tariq on 1/8/20.
//  Copyright © 2020 Tariq. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class Profile: UIViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTf: UITextField!
    @IBOutlet weak var oldPasswordTf: UITextField!
    @IBOutlet weak var newPasswordTf: UITextField!
    @IBOutlet weak var confirmPasswordTf: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    @IBOutlet weak var indicatorView: UIView!
    
    var dataOrPassword = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTitleImage()
        setMenuBtn(menuButton: menuButton)
        userDataAppearance(status: true)
        userDataHandelRefresh()
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.white], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.black], for: .selected)
        // Do any additional setup after loading the view.
    }
    
    func userDataAppearance(status: Bool){
        nameTF.isHidden = !status
        emailTf.isHidden = !status
        oldPasswordTf.isHidden = status
        newPasswordTf.isHidden = status
        confirmPasswordTf.isHidden = status
    }
    
    func userDataHandelRefresh(){
        activityIndicatorView.startAnimating()
        indicatorView.isHidden = false
        AuthApi.userDataApi { (userData) in
            if let userData = userData.data{
                self.nameTF.text = userData[0].name
                self.emailTf.text = userData[0].email
                helper.saveUserName(name: userData[0].name ?? "")
            }
            self.indicatorView.isHidden = true
            self.activityIndicatorView.stopAnimating()
        }
    }
    
    func profileValidation(){
        guard let name = nameTF.text, !name.isEmpty else {
            let messages = "Please enter your name".localized
            self.showAlert(title: "Profile".localized, message: messages)
            return
        }
        
        guard let email = emailTf.text, !email.isEmpty else {
            let messages = "Please enter your email".localized
            self.showAlert(title: "Profile".localized, message: messages)
            return
        }
        
        guard isValidInput(Input: nameTF.text!) == true else {
            self.showAlert(title: "Profile".localized, message: "Name not correct".localized)
            return
        }
        
        guard isValidEmail(testStr: emailTf.text ?? "") == true else {
            let messages = "Email not correct".localized
            self.showAlert(title: "Profile".localized, message: messages)
            return
        }
    }
    
    func passwordValidation(){
        guard let oldPassword = oldPasswordTf.text, !oldPassword.isEmpty else {
            let messages = "Please enter your old password".localized
            self.showAlert(title: "Password".localized, message: messages)
            return
        }
        
        guard let newPassword = newPasswordTf.text, !newPassword.isEmpty else {
            let messages = "Please enter your new password".localized
            self.showAlert(title: "Password".localized, message: messages)
            return
        }
        
        guard let confirmPassword = confirmPasswordTf.text, !confirmPassword.isEmpty else {
            let messages = "Please confirm password".localized
            self.showAlert(title: "Password".localized, message: messages)
            return
        }
        
        guard oldPasswordTf.text?.count ?? 0 >= 6, newPasswordTf.text?.count ?? 0 >= 6 else {
            let messages = "The password must be at least 6 characters".localized
            self.showAlert(title: "Password".localized, message: messages)
            return
        }
    }
    
    @IBAction func segmentedBtn(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            dataOrPassword = 0
            userDataAppearance(status: true)
        case 1:
            dataOrPassword = 1
            userDataAppearance(status: false)
        default:
            print("AnyThing")
        }
    }
    
    @IBAction func editBtn(_ sender: Any) {
        activityIndicatorView.startAnimating()
        indicatorView.isHidden = false
        if dataOrPassword == 0 {
            profileValidation()
            AuthApi.updateProfileApi(email: emailTf.text ?? "", name: nameTF.text ?? "") { (messages) in
                if messages.status ?? false{
                    self.showAlert(title: "Profile".localized, message: messages.data!)
                    self.userDataHandelRefresh()
                    self.indicatorView.isHidden = true
                    self.activityIndicatorView.stopAnimating()
                }else{
                    if let message = messages.errors{
                        self.showAlert(title: "Profile".localized, message: message.email?[0] ?? "")
                        self.userDataHandelRefresh()
                        self.indicatorView.isHidden = true
                        self.activityIndicatorView.stopAnimating()
                    }
                }
            }
        }else{
            passwordValidation()
            AuthApi.updatePasswordApi(password: oldPasswordTf.text ?? "", newPassword: confirmPasswordTf.text ?? "") { (message) in
                if message.status ?? false{
                    self.showAlert(title: "Password".localized, message: message.data!)
                    self.oldPasswordTf.text = ""
                    self.newPasswordTf.text = ""
                    self.confirmPasswordTf.text = ""
                    self.indicatorView.isHidden = true
                    self.activityIndicatorView.stopAnimating()
                }else{
                    if let message = message.errors{
                        self.showAlert(title: "Password".localized, message: message.email?[0] ?? "")
                        self.oldPasswordTf.text = ""
                        self.newPasswordTf.text = ""
                        self.confirmPasswordTf.text = ""
                        self.indicatorView.isHidden = true
                        self.activityIndicatorView.stopAnimating()
                    }
                }
            }
        }
        
    }

}
