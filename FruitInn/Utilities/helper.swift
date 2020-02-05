//
//  helper.swift
//  FruitInn
//
//  Created by Tariq on 12/30/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit

class helper: NSObject {
    
    class func saveCountryId(country: String){
        let defUSer = UserDefaults.standard
        defUSer.setValue(country, forKey: "country")
        defUSer.synchronize()
    }
    
    class func getCountryId() -> String?{
        let defUser = UserDefaults.standard
        return (defUser.object(forKey: "country") as? String)
    }
    
    class func setCountryImage(Button: UIBarButtonItem){
        if getCountryId() == "egypt"{
            Button.setBackgroundImage(#imageLiteral(resourceName: "egypt"), for: .normal, barMetrics: .default)
        }else if getCountryId() == "china"{
            Button.setBackgroundImage(#imageLiteral(resourceName: "china"), for: .normal, barMetrics: .default)
        }else if getCountryId() == "england"{
            Button.setBackgroundImage(#imageLiteral(resourceName: "england"), for: .normal, barMetrics: .default)
        }else{
            Button.setBackgroundImage(#imageLiteral(resourceName: "vitnam"), for: .normal, barMetrics: .default)
        }
    }
    
    class func getUserToken() -> String?{
        let defUser = UserDefaults.standard
        return (defUser.object(forKey: "user_token") as? String)
    }
    
    class func saveUserToken(token: String){
        let defUser = UserDefaults.standard
        defUser.setValue(token, forKey: "user_token")
        defUser.synchronize()
    }
    
    class func saveUserName(name: String){
        let defUser = UserDefaults.standard
        defUser.setValue(name, forKey: "userName")
        defUser.synchronize()
    }
    
    class func getUserName() -> String?{
        let defUser = UserDefaults.standard
        return (defUser.object(forKey: "userName") as? String)
    }

    class func restartApp(){
        guard let window = UIApplication.shared.keyWindow else {return}
        let sb = UIStoryboard(name: "Main", bundle: nil)
        var vc: UIViewController
        vc = sb.instantiateInitialViewController()!
        window.rootViewController = vc
    }
}
