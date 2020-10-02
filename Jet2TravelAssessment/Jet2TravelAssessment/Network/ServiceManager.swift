//
//  ServiceManager.swift
//  Jet2TravelAssessment
//
//  Created by Sandip Pund on 30/09/20.
//  Copyright © 2020 Sandip Pund. All rights reserved.
//

import Foundation

class ServiceManager {
    let urlString: String = "https://5e99a9b1bc561b0016af3540.mockapi.io/jet2/api/v1/blogs?page="
    static let shared: ServiceManager = ServiceManager()
    private init() { }
    
    func getArticles(handler: @escaping([ArticleModel]?, Error?) -> ())  {
        guard let url = URL(string: urlString) else { return  }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _error = error {
                DispatchQueue.main.async {
                    handler(nil, _error)
                }
                return
            }
            if let _data = data {
                do {
                    let response = try JSONDecoder().decode([ArticleModel].self, from: _data)
                    DispatchQueue.main.async {
                        handler(response, nil)
                    }
                } catch let error {
                    print(error)
                }
            }
        }
        task.resume()
    }
}
