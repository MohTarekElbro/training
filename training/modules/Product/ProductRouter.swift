//
//  CategoryRouter.swift
//  ecommerce
//
//  Created by Mohammed Tarek on 09/11/2022.
//

import Foundation

//
//  Router.swift
//  ecommerce
//
//  Created by Mohammed Tarek on 08/11/2022.
//

import Foundation
import Alamofire
enum ProductRouter: URLRequestConvertible {
    
    case categories
    case products(String)
    case addProductToCart(String , Int)
    
    
    
    func asURLRequest() throws -> URLRequest {
        
        var method: HTTPMethod {
            switch self {
            case .categories,.products:
                return .get
            default:
                return .post
            }
        }
        
        let params: ([String: Any]?) = {
            switch self {
            case .categories,.products:
                return nil
            case .addProductToCart(_, let id):
                return ["product_id":id]
            }
        }()
        
        let url: URL = {
            // build up and return the URL for each endpoint
            let relativePath: String?
            switch self {
            case .categories:
                relativePath = "categories"
            case .products:
                relativePath = "products"
            case .addProductToCart:
                relativePath = "carts"
            }
            
            var url = URL(string: K.url)!
            if let relativePath = relativePath {
                url = url.appendingPathComponent(relativePath)
            }
            return url
        }()
        
        let urlRequest : URLRequest = {
            var req = URLRequest(url:url)
            req.httpMethod = method.rawValue
            req.setValue("en", forHTTPHeaderField: "lang")
            switch self {
            case .products(let token), .addProductToCart(let token, _):
                req.setValue(token, forHTTPHeaderField: "Authorization")
            default: break
                
            }
            return req
        }()
        
        
        let encoding: ParameterEncoding = {
            return JSONEncoding.default
            
        }()
        return try encoding.encode(urlRequest, with: params)
    }
}
