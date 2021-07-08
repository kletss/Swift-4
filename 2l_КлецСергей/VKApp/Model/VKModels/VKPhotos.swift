//
//  VKPhotos.swift
//  VKApp
//
//  Created by KKK on 28.05.2021.
//

struct VKImage {
    let type: String
    let urlImage: String
}

struct VKLikes {
    let count: Int
}

extension VKImage: Codable {
    enum CodingKeys: String, CodingKey {
        case type
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
