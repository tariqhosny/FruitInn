//
//  productsApi.swift
//  FruitInn
//
//  Created by Tariq on 12/31/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit
import Alamofire

class productsApi: NSObject {
    
    class func sliderApi(completion: @escaping(_ photos: productsModel?)-> Void){
        let parametars = [
            "lang": "en".localized
        ]
        Alamofire.request(URLs.slider, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
            do{
                let images = try JSONDecoder().decode(productsModel.self, from: response.data!)
                completion(images)
            }catch{
                
            }
        }
    }
    
    class func sectionsApi(completion: @escaping(_ sections: productsModel?)-> Void){
        let parametars = [
            "lang": "en".localized
        ]
        Alamofire.request(URLs.sections, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
            do{
                let sections = try JSONDecoder().decode(productsModel.self, from: response.data!)
                completion(sections)
            }catch{
                
            }
        }
    }
    
    class func topProductsApi(completion: @escaping(_ topProducts: productsModel?)-> Void){
        let parametars = [
            "lang": "en".localized,
            "country": "\(helper.getCountryId() ?? "")"
        ]
        Alamofire.request(URLs.top_products, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
            do{
                let sections = try JSONDecoder().decode(productsModel.self, from: response.data!)
                completion(sections)
            }catch{
                
            }
        }
    }
    
    class func categoriesApi(id: Int, completion: @escaping(_ categories: productsModel?)-> Void){
        let parametars = [
            "lang": "en".localized,
            "section_id": id
            ] as [String : Any]
        Alamofire.request(URLs.categories, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
            do{
                let categories = try JSONDecoder().decode(productsModel.self, from: response.data!)
                completion(categories)
            }catch{
                
            }
        }
    }
    
    class func productsCategoryApi(id: Int, completion: @escaping(_ products: productsModel)-> Void){
        let parameters = [
            "lang": "en".localized,
            "category_id": id,
            "country": "\(helper.getCountryId() ?? "")"
            ] as [String : Any]
        Alamofire.request(URLs.products_category, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            do{
                let products = try JSONDecoder().decode(productsModel.self, from: response.data!)
                completion(products)
            }catch{
                
            }
        }
    }
    
    class func allProductApi(completion: @escaping(_ products: productsModel)-> Void){
        let parameters = [
            "lang": "en".localized,
            "country": "\(helper.getCountryId() ?? "")"
        ]
        Alamofire.request(URLs.allProducts, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            do{
                let products = try JSONDecoder().decode(productsModel.self, from: response.data!)
                completion(products)
            }catch{
                
            }
        }
    }
    
    class func relatedProductApi(id: Int, completion: @escaping(_ products: productsModel)-> Void){
        let parametars = [
            "product_id": id,
            "lang": "en".localized,
            "country": "\(helper.getCountryId() ?? "")"
            ] as [String : Any]
        Alamofire.request(URLs.related_products, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            do{
                let products = try JSONDecoder().decode(productsModel.self, from: response.data!)
                completion(products)
            }catch{
                
            }
        }
    }
    
    class func productsAdditionsApi(id: Int, completion: @escaping(_ details: productsModel)-> Void){
        let parametars = [
            "lang": "en".localized,
            "product_id": id
            ] as [String : Any]
        Alamofire.request(URLs.products_additions, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            do{
                let details = try JSONDecoder().decode(productsModel.self, from: response.data!)
                completion(details)
            }catch{
                
            }
        }
    }
    
    class func filterApi(seasonId: Int, categoryIDs: [Int], england: Int, egypt: Int, china: Int, vietnam: Int, completion: @escaping(_ products: productsModel)-> Void){
        let parametars = [
            "lang": "en".localized,
            "category_arr": categoryIDs,
            "seasone_id": seasonId,
            "england": england,
            "egypt": egypt,
            "china": china,
            "vietnam": vietnam
            ] as [String : Any]
        Alamofire.request(URLs.filter, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: nil).response { (response) in
            do{
                let products = try JSONDecoder().decode(productsModel.self, from: response.data!)
                completion(products)
            }catch{
                
            }
        }
    }
}
