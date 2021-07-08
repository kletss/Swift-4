//
//  RealmPhotos.swift
//  VKApp
//
//  Created by KKK on 01.06.2021.
//

import UIKit
import RealmSwift


final class PhotoURL: Object, Codable {
    @objc dynamic var photoURL: String = ""
    @objc dynamic var type: String = ""
    
    enum CodingKeys: String, CodingKey {
        case photoURL = "url"
        case type = "type"
    }
    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.photoURL = try container.decode(String.self, forKey: .photoURL)
        self.type = try container.decode(String.self, forKey: .type)
    }
}

final class RealmPhoto: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var idUser: Int  = 0
//    @objc dynamic var likes: Int = 0
    var sizes = List<PhotoURL>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    override static func indexedProperties() -> [String] {
        return ["idUser"]
    }
    
}


    
extension RealmPhoto: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case idUser = "owner_id"
//        case likes = "like"
        case sizes = "sizes"
    }
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.likes = try container.decode(Int.self, forKey: .likes)
        self.id = try container.decode(Int.self, forKey: .id)
        self.idUser = try container.decode(Int.self, forKey: .idUser)

        let mSizes = try container.decodeIfPresent([PhotoURL].self, forKey: .sizes)
        sizes.append(objectsIn: mSizes!)
//        self.sizes = try container.decode(String.self, forKey: .sizes)
        
    }
}


struct RealmPhotos: Codable {
    let count: Int
    let items: [RealmPhoto]
}
