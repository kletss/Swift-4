//
//  RealmGroups.swift
//  VKApp
//
//  Created by KKK on 01.06.2021.
//

import UIKit
import RealmSwift

final class RealmGroup: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var photoAvatarURL: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }

}

extension RealmGroup: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case photoAvatarURL = "photo_50"
    }
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.photoAvatarURL = try container.decode(String.self, forKey: .photoAvatarURL)
        
    }
    
}


struct RealmGroups: Codable {
    let count: Int
    let items: [RealmGroup]
    
}
