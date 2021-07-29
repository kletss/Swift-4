//
//  VKPhotos.swift
//  VKApp
//
//  Created by KKK on 28.05.2021.
//

import  UIKit

struct VKImage {
    let type: String
    let height: Int
    let width: Int
    let urlImage: String
    var aspectRatio: CGFloat { return CGFloat(height)/CGFloat(width) }

}

struct VKLikes {
    let count: Int
}

extension VKImage: Codable {
    enum CodingKeys: String, CodingKey {
        case type
        case height
        case width
        case urlImage = "url"
    }
}

extension VKLikes: Codable {
    enum CodingKeys: String, CodingKey {
        case count = "count"
    }
}

struct VKPhoto: Codable {
    let id: Int
    let date: Int
    let sizes: [VKImage]
    let likes: VKLikes?
}

struct VKPhotos: Codable {
    let count: Int
    let items: [VKPhoto]
}


//"sizes": [{
//"height": 87,
//"url": "https://sun9-70.u...jJd5bevYn45e_5RZuOc",
//"type": "m",
//"width": 130
