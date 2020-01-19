//
//  File.swift
//  FruitInn
//
//  Created by Tariq on 12/31/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import Foundation

struct AuthLogin: Codable{
    var data: AuthData?
    var status: Bool?
//    var error: String?
}

struct AuthRegister: Codable{
    var data: AuthData?
    var status: Bool?
//    var error: AuthError?
}

struct profileMessages: Codable{
    var data: String?
    var status: Bool?
    var message: String?
    var errors: AuthError?
}

struct AuthData: Codable {
    var user_token: String?
    var name: String?
    var email: String?
    
    enum CodingKeys: String, CodingKey {
        case user_token = "user_token "
        case name, email
    }
}

struct AuthError: Codable {
    
    var email: [String]?
}

struct userData: Codable{
    var data: [AuthData]?
    var status: Bool?
    var error: String?
}
