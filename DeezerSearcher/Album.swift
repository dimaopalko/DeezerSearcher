//
//  Album.swift
//  DeezerSearcher
//
//  Created by Dima Opalko on 9/4/19.
//  Copyright © 2019 Dima Opalko. All rights reserved.
//

import Foundation

struct Album: Decodable {
    let data: [Item]
}


struct Item: Codable {
    let artist: Artist
    let albumTitle: String
    let coverImageLink: String?
    
    private enum CodingKeys: String, CodingKey {
        case artist
        case albumTitle = "title"
        case coverImageLink = "cover_xl"
    }
}
struct Artist: Codable {
    let name: String
}
