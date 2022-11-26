//
//  Category.swift
//  ecommerce
//
//  Created by Mohammed Tarek on 31/10/2022.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let registerResponse = try? newJSONDecoder().decode(RegisterResponse.self, from: jsonData)

import Foundation

// MARK: - RegisterResponse
struct CategoryResponse: Codable {
    var status: Bool?
    var message: String?
    var data: CategoriesData?
    
}

// MARK: - DataClass
struct CategoriesData: Codable {
    let currentPage: Int
    let data: [Category]
    let firstPageURL: String
    let from, lastPage: Int
    let lastPageURL: String
    let nextPageURL: String?
    let path: String
    let perPage: Int
    let prevPageURL: String?
    let to, total: Int

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case data
        case firstPageURL = "first_page_url"
        case from
        case lastPage = "last_page"
        case lastPageURL = "last_page_url"
        case nextPageURL = "next_page_url"
        case path
        case perPage = "per_page"
        case prevPageURL = "prev_page_url"
        case to, total
    }
}

// MARK: - Datum
struct Category: Codable {
    var id: Int
    var name: String
    var image: String
}
