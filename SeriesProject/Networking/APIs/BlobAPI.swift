//
//  BlobAPI.swift
//  SeriesProject
//
//  Created by Dağhan Kılıçay on 12.10.2021.
//

import Foundation
import Alamofire

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
}

class BlobAPI: NSObject {
    class func fetch<T: Decodable>(endPoint: String, completion: @escaping (Result<T, Error>) -> Void) {
        let url = URL(string: APIPaths.baseURL.rawValue + endPoint)!
        let headers: HTTPHeaders = ["authorization": ""]
        AF.request(url, method: .get, headers: headers).responseData { response in
            switch response.result {
            case .success(let res):
                 if let code = response.response?.statusCode{
                     switch code {
                     case 200...299:
                         do {
                             completion(.success(try JSONDecoder().decode(T.self, from: res)))
                         } catch let error {
                             print(String(data: res, encoding: .utf8) ?? "nothing received")
                             completion(.failure(error))
                         }
                     default:
                      let error = NSError(domain: response.debugDescription, code: code, userInfo: response.response?.allHeaderFields as? [String: Any])
                         completion(.failure(error))
                     }
                 }
             case .failure(let error):
                 completion(.failure(error))
             }
        }
    }
}
