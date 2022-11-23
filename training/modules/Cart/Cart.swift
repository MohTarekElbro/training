// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let addProductToCartResponse = try? newJSONDecoder().decode(AddProductToCartResponse.self, from: jsonData)

import Foundation

struct GetCartResponse: Codable {
    let status: Bool
    let message: String?
    let data: GetCartData?
}

struct GetCartData: Codable {
    let cartItems: [Cart]
    let subTotal, total: Int

    enum CodingKeys: String, CodingKey {
        case cartItems = "cart_items"
        case subTotal = "sub_total"
        case total
    }
}

struct Cart: Codable {
    let id, quantity: Int
    let product: Product
}



