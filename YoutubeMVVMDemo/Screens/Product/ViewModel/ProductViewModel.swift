//
//  ProductViewModel.swift
//  YoutubeMVVMDemo
//
//  Created by Siddharth Adhvaryu on 28/04/24.
//

import Foundation

final class ProductViewModel {
    
    var products:[Product] = []
    var eventHandler: ((_ event: Event) -> Void)?
    
    func fetchProduct() {
        self.eventHandler?(.loading)
        APIManager.shared.fetchProduct { response in
            self.eventHandler?(.stoploading)
            switch response {
            case .success(let products):
                self.products = products
                self.eventHandler?(.dataLoaded)
                print(products)
            case .failure(let error):
                print(error)
                self.eventHandler?(.error(error))
            }
        }
    }
}

extension ProductViewModel {
    enum Event {
        case loading
        case stoploading
        case dataLoaded
        case error(Error?)
    }
}
