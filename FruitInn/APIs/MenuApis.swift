//
//  MenuApis.swift
//  FruitInn
//
//  Created by Tariq on 1/12/20.
//  Copyright © 2020 Tariq. All rights reserved.
//

import UIKit
import Alamofire

class MenuApis: NSObject {

    class func whoWeAreApi(completion: @escaping(_ data: productsModel)-> Void){
        let parametars = ["lang": "en".localized]
        Alamofire.request(URLs.about, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: nil).response { (response) in
            do{
                let data = try JSONDecoder().decode(productsModel.self, from: response.data!)
                completion(data)
            }catch{
                
            }
        }
    }
    
    class func socialApi(completion: @escaping(_ links: socialModel)-> Void){
        Alamofire.request(URLs.social, method: .post, parameters: nil, encoding: URLEncoding.default, headers: nil).response { (response) in
            do{
                let links = try JSONDecoder().decode(socialModel.self, from: response.data!)
                completion(links)
            }catch{
                
            }
        }
    }
    
    class func contactApi(name: String, email: String, phone: String, message: String, completion: @escaping(_ message: contactModel)-> Void){
        let parameters = [
            "name": name,
            "email": email,
            "phone": phone,
            "message": message
        ]
        Alamofire.request(URLs.contact_message, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).response { (response) in
            do{
                let message = try JSONDecoder().decode(contactModel.self, from: response.data!)
                completion(message)
            }catch{
                
            }
        }
    }
    
    class func seasonApi(completion: @escaping(_ seasons: productsModel)-> Void){
        let parameters = [
            "lang": "en".localized
        ]
        Alamofire.request(URLs.seasons, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).response { (response) in
            do{
                let seasons = try JSONDecoder().decode(productsModel.self, from: response.data!)
                completion(seasons)
            }catch{
                
            }
        }
    }
    
    class func newsApi(completion: @escaping(_ news: productsModel)-> Void){
        let parametars = [
            "lang": "en".localized
        ]
        Alamofire.request(URLs.news, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: nil).response { (response) in
            do{
                let news = try JSONDecoder().decode(productsModel.self, from: response.data!)
                completion(news)
            }catch{
                
            }
        }
    }
    
    class func galleryApi(completion:@escaping(_ galleryLinks: galleryModel)-> Void){
        Alamofire.request(URLs.galleries, method: .post, parameters: nil, encoding: URLEncoding.default, headers: nil).response { (response) in
            do{
                let gallery = try JSONDecoder().decode(galleryModel.self, from: response.data!)
                completion(gallery)
            }catch{
                
            }
        }
    }
}
