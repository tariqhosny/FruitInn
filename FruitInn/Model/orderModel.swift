//
//  orderModel.swift
//  FruitInn
//
//  Created by Tariq on 1/14/20.
//  Copyright © 2020 Tariq. All rights reserved.
//

import Foundation

struct orderModel: Codable{
    var data: [orderData]?
    var status: Bool?
}

struct orderData: Codable{
    var order_id: Int?
    var order_stat: String?
    var customer_phone: String?
    var created_at: String?
    var comments: String?
    
    enum CodingKeys: String, CodingKey {
        case comments = "$customer_comments_extra"
        case order_id, order_stat, customer_phone, created_at
    }
}

struct orderDetailsModel: Codable{
    var data: [orderDetails]?
    var status: Bool?
}

struct orderDetails: Codable{
    var product_id : String?
    var image: String?
    var product_name: String?
    var product_quantity: String?
}

struct galleryModel: Codable{
    var data: [galleryLinks]?
    var status: Bool?
}

struct galleryLinks: Codable{
    var id: Int?
    var image: String?
    var link: String?
}
