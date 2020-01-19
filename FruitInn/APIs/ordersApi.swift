//
//  ordersApi.swift
//  FruitInn
//
//  Created by Tariq on 1/14/20.
//  Copyright © 2020 Tariq. All rights reserved.
//

import UIKit
import Alamofire

class ordersApi: NSObject {
    
    class func createOrderApi(id: Int, phone: String, quantity: String, comment: String, completion: @escaping(_ message: contactModel)-> Void){
        let parameters = [
            "product_id": id,
            "customer_phone": phone,
            "product_quantity": quantity,
            "customer_comments_extra": comment
            ] as [String : Any]
        let headers = [
            "Accept": "application/json",
            "Authorization": "Bearer \(helper.getUserToken() ?? "")"
        ]
        Alamofire.request(URLs.create_order, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers).response { (response) in
            do{
                let message = try JSONDecoder().decode(contactModel.self, from: response.data!)
                print(message)
                completion(message)
            }catch{
                
            }
        }
    }

    class func orderListApi(completion: @escaping(_ orders: orderModel)-> Void){
        let parameters = [
            "lang": "en".localized
        ]
        let headers = [
            "Accept": "application/json",
            "Authorization": "Bearer \(helper.getUserToken() ?? "")"
        ]
        Alamofire.request(URLs.order_list, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers).response { (response) in
            do{
                let orders = try JSONDecoder().decode(orderModel.self, from: response.data!)
                completion(orders)
            }catch{
                
            }
        }
    }
    
    class func orderDetailsApi(id: Int, completion: @escaping(_ order: orderDetailsModel)-> Void){
        let parameters = [
            "lang": "en".localized,
            "order_id": id
            ] as [String : Any]
        let headers = [
            "Accept": "application/json",
            "Authorization": "Bearer \(helper.getUserToken() ?? "")"
        ]
        Alamofire.request(URLs.order_list_details, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers).response { (response) in
            do{
                let orderDetails = try JSONDecoder().decode(orderDetailsModel.self, from: response.data!)
                completion(orderDetails)
            }catch{
                
            }
        }
    }
}
