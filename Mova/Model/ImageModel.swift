//
//  ImageModel.swift
//  Mova
//
//  Created by Tarasenko Jurik on 3/19/19.
//  Copyright © 2019 Next Level. All rights reserved.
//

import Foundation

struct Model: Decodable {
    let photos: [ImageModel]?
    let resultCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case photos
        case resultCount = "total_results"
    }
}

struct ImageModel: Decodable {
    
    let photographer: String?
    let imageSize: ImageSize?
    
    enum CodingKeys: String, CodingKey {
        case photographer
        case imageSize = "src"
    }
}

struct ImageSize: Decodable {
    
    let original: String?
    let small: String?
    let landscape: String?
}
