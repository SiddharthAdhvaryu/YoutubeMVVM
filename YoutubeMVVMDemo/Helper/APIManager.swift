//
//  APIManager.swift
//  YoutubeMVVMDemo
//
//  Created by Siddharth Adhvaryu on 28/04/24.
//

import Foundation

enum DataError: Error {
    case invalidResponse
    case invalidUrl
    case invalidData
    case message(Error?)
}

typealias Handler = (Result<[Product],DataError>)-> Void

final class APIManager {
    static let shared = APIManager()
    private init() {}
    
    func fetchProduct(handler: @escaping Handler) {
        guard let url = URL(string: Constant.API.productAPI) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data,error == nil else {
                handler(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  200 ... 299 ~= response.statusCode else {
                handler(.failure(.invalidResponse))
                return
            }
            
            do {
                let products = try JSONDecoder().decode([Product].self, from: data)
                handler(.success(products))
            }catch {
                handler(.failure(.message(error)))
            }
            
        }.resume()
    }
    
    func fetchRequest() {
        guard let url = URL(string: Constant.API.productAPI) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            
        }
    }
}


