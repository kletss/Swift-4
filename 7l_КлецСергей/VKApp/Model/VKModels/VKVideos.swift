//
//  VKVideos.swift
//  VKApp
//
//  Created by KKK on 05.07.2021.
//

struct VKVideoImage {
    let height: Int
    let width: Int
    let urlImage: String
}


extension VKVideoImage: Codable {
    enum CodingKeys: String, CodingKey {
        case height
        case width
        case urlImage = "url"
    }
}


struct VKVideo: Codable {
    let id: Int
    let date: Int
    let description: String
    let image: [VKVideoImage]
}



