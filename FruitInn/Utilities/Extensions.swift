//
//  Extensions.swift
//  FruitInn
//
//  Created by Tariq on 12/30/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit
import MOLH

extension UIViewController{
    func addTitleImage(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        
        let navController = navigationController!
        
        let image = UIImage(named: "logo-1")
        let imageView = UIImageView(image: image)
        
        let bannerWidth = navController.navigationBar.frame.size.width
        let bannerHeight = navController.navigationBar.frame.size.height
        
        let bannerX = bannerWidth / 2 - (image?.size.width)! / 2
        let bannerY = bannerHeight / 2
        
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: image!.size.width, height: image!.size.height)
        imageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = imageView
    }
    
    func addCountryBtn() {
        let countryBtn = UIButton()
        countryBtn.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        countryBtn.tintColor = UIColor.white
        //egypt vietnam  china  england
        if helper.getCountryId() == nil{
            helper.saveCountryId(country: "egypt")
        }else{
            if helper.getCountryId() == "egypt"{
                countryBtn.setImage(#imageLiteral(resourceName: "egypt"), for: .normal)
            }else if helper.getCountryId() == "china"{
                countryBtn.setImage(#imageLiteral(resourceName: "china"), for: .normal)
            }else if helper.getCountryId() == "england"{
                countryBtn.setImage(#imageLiteral(resourceName: "england"), for: .normal)
            }else{
                countryBtn.setImage(#imageLiteral(resourceName: "vietnam"), for: .normal)
            }
        }
        countryBtn.addTarget(self, action: #selector(countryBtnTaped), for: UIControl.Event.touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: countryBtn)
    }
    
    @objc func countryBtnTaped() {
        //egypt vietnam  china  england
        let names = ["Egypt", "China", "England", "Vietnam"]
        let images = ["egypt", "china", "england", "vietnam"]
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        for n in 0...(names.count-1){
            
            let action = UIAlertAction(title: names[n], style: .default, handler: { _ in
                helper.saveCountryId(country: images[n])
                self.loadView()
                self.viewDidLoad()
            })
            let image = UIImage(named: images[n])
            action.setValue(image?.withRenderingMode(.alwaysOriginal), forKey: "image")
            actionSheet.addAction(action)
        }
        
        actionSheet.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func setMenuBtn(menuButton: UIBarButtonItem){
        if revealViewController() != nil {
            if MOLHLanguage.currentAppleLanguage() != "ar"{
                menuButton.target = revealViewController()
                menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            }else{
                menuButton.target = revealViewController()
                menuButton.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            }
            view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
    }
    
    func showAlert(title: String, message: String, okTitle: String = "Ok".localized, okHandler: ((UIAlertAction)->Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: okTitle, style: .cancel, handler: okHandler))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func isValidInput(Input:String) -> Bool {
        let myCharSet=CharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ أ إ  ض ص ث ق ف غ ع ه خ ح  ج د ش ي ب ل ا ت ن م ك  ط ئ ء ؤ ر لا ى ة و ز ظ")
        let output: String = Input.trimmingCharacters(in: myCharSet.inverted)
        let isValid: Bool = (Input == output)
        print("\(isValid)")
        
        return isValid
    }
    
    func changeLanguage(){
        let alert = UIAlertController(title: "Select Language".localized, message: "", preferredStyle: UIAlertController.Style.actionSheet)
        alert.addAction(UIAlertAction(title: "English", style: .destructive, handler: { (action: UIAlertAction) in
            MOLH.setLanguageTo("en")
            helper.restartApp()
        }))
        alert.addAction(UIAlertAction(title: "中文", style: .destructive, handler: { (action: UIAlertAction) in
            MOLH.setLanguageTo("zh-Hans")
            helper.restartApp()
        }))
        alert.addAction(UIAlertAction(title: "عربى", style: .destructive, handler: { (action: UIAlertAction) in
            MOLH.setLanguageTo("ar")
            helper.restartApp()
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel".localized, comment: ""), style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func logOut(){
        let alert = UIAlertController(title: "Are you sure you want to log out?".localized, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Log out".localized, style: .destructive, handler: { (action: UIAlertAction) in
            let defUser = UserDefaults.standard
            defUser.removeObject(forKey: "user_token")
            helper.restartApp()
        }))
        alert.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        navigationController?.navigationBar.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension String{
    var localized: String{
        NSLocalizedString(self, comment: "")
    }
}

extension UITextView: UITextViewDelegate {
    
    /// Resize the placeholder when the UITextView bounds change
    override open var bounds: CGRect {
        didSet {
            self.resizePlaceholder()
        }
    }
    
    /// The UITextView placeholder text
    public var placeholder: String? {
        get {
            var placeholderText: String?
            
            if let placeholderLabel = self.viewWithTag(100) as? UILabel {
                placeholderText = placeholderLabel.text
            }
            
            return placeholderText
        }
        set {
            if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
                placeholderLabel.text = newValue
                placeholderLabel.sizeToFit()
            } else {
                self.addPlaceholder(newValue!)
            }
        }
    }
    
    /// When the UITextView did change, show or hide the label based on if the UITextView is empty or not
    ///
    /// - Parameter textView: The UITextView that got updated
    public func textViewDidChange(_ textView: UITextView) {
        if let placeholderLabel = self.viewWithTag(100) as? UILabel {
            placeholderLabel.isHidden = self.text.count > 0
        }
    }
    
    /// Resize the placeholder UILabel to make sure it's in the same position as the UITextView text
    private func resizePlaceholder() {
        if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
            let labelX = self.textContainer.lineFragmentPadding
            let labelY = self.textContainerInset.top - 2
            let labelWidth = self.frame.width - (labelX * 2)
            let labelHeight = placeholderLabel.frame.height

            placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
        }
    }
    
    /// Adds a placeholder UILabel to this UITextView
    private func addPlaceholder(_ placeholderText: String) {
        let placeholderLabel = UILabel()
        
        placeholderLabel.text = placeholderText
        placeholderLabel.sizeToFit()
        
        placeholderLabel.font = self.font
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.tag = 100
        
        placeholderLabel.isHidden = self.text.count > 0
        
        self.addSubview(placeholderLabel)
        self.resizePlaceholder()
        self.delegate = self
    }
    
}
