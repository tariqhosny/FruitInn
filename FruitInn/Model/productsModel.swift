//
//  File.swift
//  FruitInn
//
//  Created by Tariq on 12/31/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import Foundation

struct productsModel: Codable{
    var data: [productsData]?
    var status: Bool?
    var error: String?
}

struct productsData: Codable{
    var id: Int?
    var image: String?
    var title: String?
    var date: String?
    var short_description: String?
    var description: String?
}

struct socialModel: Codable{
    var name: String?
    var link: String?
    var data: [socialModel]?
}

struct contactModel: Codable{
    var data: String?
    var message: String?
    var status: Bool?
    var error: String?
}
