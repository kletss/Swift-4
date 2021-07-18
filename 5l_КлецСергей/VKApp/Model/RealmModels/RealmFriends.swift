//
//  RealmFriends.swift
//  VKApp
//
//  Created by KKK on 01.06.2021.
//

//import UIKit
//import RealmSwift


//final class RealmFriends: Object {
//    @objc dynamic var id: Int = 0
//    @objc dynamic var firstName: String = ""
//    @objc dynamic var lastName: String = ""
//    @objc dynamic var fullName: String  { "\(firstName)  \(lastName)" }
//    @objc dynamic var photoAvatarURL: Data? = nil
//    let photos = List<RealmPhotos>()
//
//    override static func primaryKey() -> String? {
//        return "id"
//    }
//    override static func indexedProperties() -> [String] {
//        return ["fullName"]
//    }
//}
//
//
//
//extension RealmFriends: Codable {
//    enum CodingKeys: String, CodingKey {
//        case id
//        case firstName = "first_name"
//        case lastName = "last_name"
//        case photoAvatarURL = "photo_200"
//    }
//}

//struct RealmFriends: Codable {
//    let count: Int
//    let items: [RealmUser]
//}
