//
//  AuthApi.swift
//  FruitInn
//
//  Created by Tariq on 12/31/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit
import Alamofire

class AuthApi: NSObject {

    class func loginApi(email: String, password: String, completion: @escaping(_ userData: AuthLogin)-> Void){
        let parameters = [
            "email": email,
            "password": password
        ]
        Alamofire.request(URLs.login, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            do{
                let login = try JSONDecoder().decode(AuthLogin.self, from: response.data!)
                print(login)
                completion(login)
            }catch{
                
            }
        }
    }
    
    class func registerApi(email: String, password: String, name: String, completion: @escaping(_ userData: AuthRegister)-> Void){
        let parameters = [
            "email": email,
            "password": password,
            "name": name,
            "phone": "1"
        ]
        Alamofire.request(URLs.register, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
        do{
            let register = try JSONDecoder().decode(AuthRegister.self, from: response.data!)
            completion(register)
            }catch{
                
            }
        }
    }
    
    class func userDataApi(completion: @escaping(_ userData: userData)-> Void){
        let headers = [
            "Accept": "application/json",
            "Authorization": "Bearer \(helper.getUserToken() ?? "")"
        ]
        Alamofire.request(URLs.user_profile, method: .post, parameters: nil, encoding: URLEncoding.default, headers: headers).response { (response) in
            do{
                let user = try JSONDecoder().decode(userData.self, from: response.data!)
                print(user)
                completion(user)
            }catch{
                
            }
        }
    }
    
    class func updateProfileApi(email: String, name: String, completion: @escaping(_ messages: profileMessages)-> Void){
        let parameters = [
            "email": email,
            "name": name
        ]
        let headers = [
            "Accept": "application/json",
            "Authorization": "Bearer \(helper.getUserToken() ?? "")"
        ]
        Alamofire.request(URLs.update_profile, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers).response { (response) in
            do{
                let messages = try JSONDecoder().decode(profileMessages.self, from: response.data!)
                print(messages)
                completion(messages)
            }catch{
                
            }
        }
    }
    
    class func updatePasswordApi(password: String, newPassword: String, completion: @escaping(_ message: profileMessages)-> Void){
        let parametars = [
            "password": password,
            "new_password": newPassword
        ]
        let headers = [
            "Accept": "application/json",
            "Authorization": "Bearer \(helper.getUserToken() ?? "")"
        ]
        Alamofire.request(URLs.changePassword, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: headers).response { (response) in
            do{
                let message = try JSONDecoder().decode(profileMessages.self, from: response.data!)
                completion(message)
            }catch{
                
            }
        }
    }
}
