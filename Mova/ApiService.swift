//
//  ApiService.swift
//  Mova
//
//  Created by Tarasenko Jurik on 3/19/19.
//  Copyright © 2019 Next Level. All rights reserved.
//
//   let header = ["Authorization": "563492ad6f91700001000001e013e517360f420d9691132d2985189e"]

import Foundation

final class ApiService {
    private init () {}
    static let shered = ApiService()
    
    func getImageBy(name: String, completion: @escaping ((_ model: Model?) -> Void)) {
        
        let randomNumber = Int.random(in: 1...1000) //get random page in search result
        let link = "https://api.pexels.com/v1/search?query=\(name)+query&per_page=1&page=\(randomNumber)"
        guard let url = URL(string: link) else { return }
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.setValue("563492ad6f91700001000001e013e517360f420d9691132d2985189e", forHTTPHeaderField: "Authorization")
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil,
                let data = data else { completion(nil)
                    return
            }
            let decoder = JSONDecoder()
            let model = try? decoder.decode(Model.self, from: data)
            completion(model)
        })
        task.resume()
    }
}
