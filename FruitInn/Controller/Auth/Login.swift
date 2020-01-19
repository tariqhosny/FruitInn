//
//  Login.swift
//  FruitInn
//
//  Created by Tariq on 12/18/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class Login: UIViewController {
    
    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var emailTf: UITextField!
    @IBOutlet weak var passwordTf: UITextField!
    @IBOutlet weak var signBtn: UIButton!
    @IBOutlet weak var forgetPasswordBtn: UIButton!
    @IBOutlet weak var switchSignBtn: UIButton!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var transparenceView: UIView!
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    @IBOutlet weak var indicatorView: UIView!
    
    var loginData = AuthData()
    var registerData = AuthData()
    var fromDetails = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
       print(fromDetails)
        setMenuBtn(menuButton: menuButton)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTap(_:))))
        popUpView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapPop(_:))))
        loginAppearance()
        
        if fromDetails == 0{
            addTitleImage()
            self.transparenceView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }

        indicatorView.isHidden = true
    }
    
    func loginAppearance(){
        titleLb.text = "Sigh In"
        nameTf.isHidden = true
        nameTf.text = ""
        emailTf.text = ""
        passwordTf.text = ""
        signBtn.setTitle("SIGN IN", for: .normal)
        forgetPasswordBtn.isHidden = false
        switchSignBtn.setTitle("CREATE ACCOUNT", for: .normal)
    }
    
    func signUpAppearance(){
        titleLb.text = "Create Account"
        nameTf.isHidden = false
        nameTf.text = ""
        emailTf.text = ""
        passwordTf.text = ""
        signBtn.setTitle("CREATE ACCOUNT", for: .normal)
        forgetPasswordBtn.isHidden = true
        switchSignBtn.setTitle("SIGN IN", for: .normal)
    }
    
    func validation(title: String){
        guard let email = emailTf.text, !email.isEmpty else {
            let messages = "Please enter your email"
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let password = passwordTf.text, !password.isEmpty else {
            let messages = "Please enter your password"
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard passwordTf.text?.count ?? 0 >= 6 else {
            let messages = "The password must be at least 6 characters"
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard isValidInput(Input: nameTf.text!) == true else {
            self.showAlert(title: title, message: "Name not correct")
            return
        }
        
        guard isValidEmail(testStr: emailTf.text ?? "") == true else {
            let messages = "Email not correct"
            self.showAlert(title: title, message: messages)
            return
        }
    }
    
    @objc func onTap(_ sender:UIPanGestureRecognizer) {
        dismiss(animated: false, completion: nil)
    }
    
    @objc func onTapPop(_ sender:UIPanGestureRecognizer) {
    }
    
    @IBAction func forgetPasswordButton(_ sender: UIButton) {
    }
    
    @IBAction func signButton(_ sender: UIButton) {
        if titleLb.text == "Sigh In"{
            validation(title: "Login")
            activityIndicatorView.startAnimating()
            indicatorView.isHidden = false
            AuthApi.loginApi(email: emailTf.text ?? "", password: passwordTf.text ?? "") { (loginData) in
                if let login = loginData.data{
                    self.loginData = login
                    helper.saveUserToken(token: loginData.data?.user_token ?? "")
                    helper.saveUserName(name: loginData.data?.name ?? "")
                    print(helper.getUserName() ?? "")
                    if self.fromDetails == 0{
                        helper.restartApp()
                    }else{
                        self.dismiss(animated: false, completion: nil)
                    }
                }
                if loginData.status == false{
                    self.showAlert(title: "Login", message: "Unauthorised")
                    self.passwordTf.text = ""
                    self.indicatorView.isHidden = true
                    self.activityIndicatorView.stopAnimating()
                }
            }
        }else if titleLb.text == "Create Account"{
            guard let name = nameTf.text, !name.isEmpty else {
                let messages = "Please enter your name"
                self.showAlert(title: "Register", message: messages)
                return
            }
            validation(title: "Register")
            activityIndicatorView.startAnimating()
            indicatorView.isHidden = false
            AuthApi.registerApi(email: emailTf.text ?? "", password: passwordTf.text ?? "", name: nameTf.text ?? "") { (register) in
                if register.status ?? false{
                    if let registerData = register.data{
                        self.registerData = registerData
                        helper.saveUserToken(token: register.data?.user_token ?? "")
                        helper.saveUserName(name: register.data?.name ?? "")
                        print(helper.getUserName() ?? "")
                        if self.fromDetails == 0{
                            helper.restartApp()
                        }else{
                            self.dismiss(animated: false, completion: nil)
                        }
                    }
                }else{
                    self.showAlert(title: "Register", message: "The email has already been taken")
                }
            }
        }
    }
    
    @IBAction func switchSignButton(_ sender: UIButton) {
        if titleLb.text == "Sigh In"{
            signUpAppearance()
        }else{
            loginAppearance()
        }
    }
    
}
