//
//  Product.swift
//  ecommerce
//
//  Created by Mohammed Tarek on 01/11/2022.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let productResponse = try? newJSONDecoder().decode(ProductResponse.self, from: jsonData)

import Foundation

// MARK: - ProductResponse
struct ProductResponse: Codable {
    let status: Bool
    let message: String?
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let currentPage: Int
    let data: [Product]
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
struct Product: Codable {
    let id: Int
    let price, oldPrice: Double
    let discount: Int
    let image: String
    let name, datumDescription: String
    let images: Array<String>?
    let inFavorites, inCart: Bool?

    enum CodingKeys: String, CodingKey {
        case id, price
        case oldPrice = "old_price"
        case discount, image, name
        case datumDescription = "description"
        case images
        case inFavorites = "in_favorites"
        case inCart = "in_cart"
    }
}

struct AddProductToCartResponse: Codable {
    let status: Bool
    let message: String
    let data: AddProductToCartData?
}

struct AddProductToCartData: Codable {
    let id, quantity: Int
    let product: Product
}




