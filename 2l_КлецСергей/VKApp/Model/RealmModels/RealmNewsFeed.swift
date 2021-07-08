//
//  RealmNewsFeed.swift
//  VKApp
//
//  Created by KKK on 01.07.2021.
//




//  через VK

import UIKit
import RealmSwift

struct RealmNewsFeeds: Codable {
    let items: [RealmNewsFeed]
}
   
final class RealmNewsFeed: Object {
    @objc dynamic var sourceID: Int = 0
    @objc dynamic var date: Double = 0.0
    @objc dynamic var text: String = ""
    var attachments = List<RealmNewsAttachments>()
    var comments: RealmNewsComments?
    var likes: RealmNewsLikes?
    @objc dynamic var reposts: Int = 0
    @objc dynamic var views: Int = 0
    @objc dynamic var postID: Int = 0
    @objc dynamic var type: String = ""
        
        override static func primaryKey() -> String? {
            return "postID"
        }

}

extension RealmNewsFeed: Codable {
    enum CodingKeys: String, CodingKey {
        case sourceID = "source_id"
        case date
        case text
        case attachments
        case comments
        case likes
        case reposts
        case views
        case postID = "post_id"
        case type
    }
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.sourceID = try container.decode(Int.self, forKey: .sourceID)
        self.date = try container.decode(Double.self, forKey: .date)
        self.text = try container.decode(String.self, forKey: .text)
        self.reposts = try container.decode(Int.self, forKey: .reposts)
        self.views = try container.decode(Int.self, forKey: .views)
        self.postID = try container.decode(Int.self, forKey: .postID)
        self.type = try container.decode(String.self, forKey: .type)

        let mVarAt = try container.decodeIfPresent([RealmNewsAttachments].self, forKey: .attachments)
        self.attachments.append(objectsIn:  mVarAt!)
        
        let mVarCom = try container.decodeIfPresent(RealmNewsComments.self, forKey: .comments)
        self.comments = mVarCom!
        let mVarLike = try container.decodeIfPresent(RealmNewsLikes.self, forKey: .likes)
        self.likes = mVarLike!

    }
}

final class RealmNewsAttachments: Object, Codable {
    @objc dynamic var type: String = ""
    @objc dynamic var newsPhoto: RealmPhoto?
    
    enum CodingKeys: String, CodingKey {
        case type
        case newsPhoto = "photo"
    }
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(String.self, forKey: .type)
        
        let mVar = try container.decodeIfPresent(RealmPhoto.self, forKey: .newsPhoto)
//        newsPhoto.append(objectsIn: mVar!)
        self.newsPhoto = mVar!
    }
}


final class RealmNewsComments: Object, Codable {
    @objc dynamic var count: Int = 0
    @objc dynamic var canPost: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case count
        case canPost = "can_post"
    }
    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try container.decode(Int.self, forKey: .count)
        self.canPost = try container.decode(Int.self, forKey: .canPost)
    }
}

final class RealmNewsLikes: Object, Codable {
    @objc dynamic var count: Int = 0
    @objc dynamic var canLike: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case count
        case canLike = "can_like"
    }
    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try container.decode(Int.self, forKey: .count)
        self.canLike = try container.decode(Int.self, forKey: .canLike)
    }
}
