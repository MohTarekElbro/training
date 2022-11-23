//
//  User.swift
//  ecommerce
//
//  Created by Mohammed Tarek on 29/10/2022.
//

import Foundation

struct RegisterResponse: Codable {
    let status: Bool
    let message: String
    let data: User?
}

// MARK: - DataClass
struct User: Codable {
    let name, phone, email: String
    let id: Int
    let image: String
    let token: String
}
