//
//  NeyworkService.swift
//  weather
//
//  Created by Ilya Latugovskii on 26.03.2020.
//  Copyright © 2020 Ilya Latugovskii. All rights reserved.
//

import Foundation

protocol Networking: class {
    func request(params: [String : String], completion: @escaping (Data?, Error?) -> Void)
}

class NetworkService: Networking {
    
    let APIKey = "5e3600cc-8b03-4bcd-835f-7a88493de5a9"
   
    func request(params: [String : String], completion: @escaping (Data?, Error?) -> Void) {
        
        var allParams = params
        allParams["lang"] = API.lang
        allParams["limit"] = API.limit
        allParams["hours"] = API.hours
        allParams["extra"] = API.extra
    
        
        let url = self.url(params: allParams)
    
        var request = URLRequest(url: url)
        
        request.addValue(APIKey, forHTTPHeaderField: "X-Yandex-API-Key")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }.resume()
        
    }
    
    private func url(params: [String: String]) -> URL {
        var components = URLComponents()
        
        components.scheme = API.sсheme
        components.host = API.host
        components.path = API.path
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        
        return components.url!
    }
}
