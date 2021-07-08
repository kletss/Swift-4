//
//  RealmUser.swift
//  VKApp
//
//  Created by KKK on 01.06.2021.
//

import UIKit
import RealmSwift


final class RealmUser: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var fullName: String  { "\(firstName)  \(lastName)" }
    @objc dynamic var photoAvatarURL: String = ""

    override static func primaryKey() -> String? {
        return "id"
    }
    override static func indexedProperties() -> [String] {
        return ["fullName"]
    }
}


extension RealmUser: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photoAvatarURL = "photo_200"
    }
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.lastName = try container.decode(String.self, forKey: .lastName)
        self.photoAvatarURL = try container.decode(String.self, forKey: .photoAvatarURL)

    }
        
}


struct RealmUsers: Codable {
    let count: Int
    let items: [RealmUser]
}


/*
 struct VKUser {
     let id: Int
     let firstName: String
     let lastName: String
     var fullName: String  { "\(firstName)  \(lastName)" }
     let userAvatarURL: String

 }
 */

