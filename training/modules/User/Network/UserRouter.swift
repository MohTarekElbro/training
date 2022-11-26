//
//  Router.swift
//  ecommerce
//
//  Created by Mohammed Tarek on 08/11/2022.
//

import Foundation
import Alamofire
enum UserRouter: URLRequestConvertible {

    case login(String,String)
    case register([String: Any])
    case signout(String)
    
    
    
    func asURLRequest() throws -> URLRequest {
        
        var method: HTTPMethod {
            return .post
        }
        
        let params: ([String: Any]?) = {
            switch self {
            case .login(let mail,let password):
                return ["email":mail , "password":password]
            case .register(let user):
                return user
            case .signout(let token):
                return ["token":token]
            }
        }()
        
        let url: URL = {
              // build up and return the URL for each endpoint
              let relativePath: String?
              switch self {
                case .login:
                  relativePath = "login"
                case .register:
                  relativePath = "register"
                case .signout:
                  relativePath = "logout"
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
            case .signout(let token):
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
