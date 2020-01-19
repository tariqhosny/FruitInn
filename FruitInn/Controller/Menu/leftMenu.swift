//
//  leftMenu.swift
//  Go Get It
//
//  Created by Tariq on 10/1/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit
import MOLH

class leftMenu: UIViewController {
    
    @IBOutlet weak var toLogin: UIButton!
    @IBOutlet weak var toProfile: UIButton!
    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var separaitedView: UIView!
    @IBOutlet weak var orderStackView: UIStackView!
    
    var sectionId = Int()
    var sectionName = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.toProfile.setTitle(helper.getUserName() ?? "", for: .normal)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if helper.getUserToken() != nil{
            self.logoutBtn.isHidden = false
            self.orderStackView.isHidden = false
            self.separaitedView.isHidden = false
            self.toLogin.isHidden = true
            self.toProfile.isHidden = false
//            self.penIamge.isHidden = false
        }else{
            self.logoutBtn.isHidden = true
            self.orderStackView.isHidden = true
            self.separaitedView.isHidden = true
            self.toLogin.isHidden = false
            self.toProfile.isHidden = true
//            self.penIamge.isHidden = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navVC = segue.destination as! UINavigationController
        if let sectionVC = navVC.viewControllers.first as? Sections{
            sectionVC.sectionId = self.sectionId
            sectionVC.sectionName = self.sectionName
        }
        
    }
    
    @IBAction func vegetablesBtn(_ sender: Any) {
        sectionId = 2
        sectionName = "Vegetables".localized
        performSegue(withIdentifier: "sections", sender: nil)
    }
    
    @IBAction func fruitBtn(_ sender: Any) {
        sectionId = 1
        sectionName = "Fruits".localized
        performSegue(withIdentifier: "sections", sender: nil)
        
    }
    
    @IBAction func languageBtn(_ sender: UIButton) {
        changeLanguage()
    }
    
    @IBAction func logOut(_ sender: UIButton) {
        logOut()
    }
    
}
