import Foundation
import Alamofire

enum CartRouter: URLRequestConvertible {
    
    case cart(String)
    
    func asURLRequest() throws -> URLRequest {
        
        var method: HTTPMethod {
            switch self {
            case .cart:
                return .get
            }
        }
        
        let params: ([String: Any]?) = {
            switch self {
            case .cart:
                return nil
            
            }
        }()
        
        let url: URL = {
            // build up and return the URL for each endpoint
            let relativePath: String?
            switch self {
            case .cart:
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
            case .cart(let token):
                req.setValue(token, forHTTPHeaderField: "Authorization")                
            }
            return req
        }()
        
        
        let encoding: ParameterEncoding = {
            return JSONEncoding.default
            
        }()
        return try encoding.encode(urlRequest, with: params)
    }
}
