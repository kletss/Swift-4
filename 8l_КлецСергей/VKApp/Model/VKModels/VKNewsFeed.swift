//
//  VKNewsFeed.swift
//  VKApp
//
//  Created by KKK on 01.07.2021.
//


struct VKNewsFeeds: Codable {
    let items: [VKNewsFeed]
//    let groups: [VKGroup]
//    let profiles: [VKProfile]
    let next_from: String
}

struct VKNewsFeed {
    let sourceID: Int
    let date: Double
    let text: String?
    let attach: [VKNewsAttachments]?
    let comments: VKNewsComments?
    let likes: VKNewsLike?
    let reposts: VKNewsReposts?
    let views: VKNewsViews?
    let postID: Int
    let type: String
}

extension VKNewsFeed: Codable {
    enum CodingKeys: String, CodingKey {
        case sourceID = "source_id"
        case date
        case text
        case attach = "attachments"
        case comments
        case likes
        case reposts
        case views
        case postID = "post_id"
        case type
    }
}


struct VKNewsAttachments: Codable {
    let type: String
//    let T: Any?
    
    let photo: VKPhoto?
    let video: VKVideo?
    
    enum CodingKeys: String, CodingKey {
        case type
        case photo
        case video
    }

        
    init(from decoder: Decoder) throws {

        let contaner = try decoder.container(keyedBy: CodingKeys.self)
        type = try contaner.decode(String.self, forKey: CodingKeys.type)
        photo = try? contaner.decode(VKPhoto.self, forKey: CodingKeys.photo)
        video = try? contaner.decode(VKVideo.self, forKey: CodingKeys.video)
       
//        switch type {
//        case CodingKeys.photo.rawValue:
//           T = try? contaner.decode(VKPhoto.self, forKey: CodingKeys.photo)
//        case CodingKeys.video.rawValue:
//            T = try? contaner.decode(VKVideo.self, forKey: CodingKeys.video)
//        default:
//            T = nil
//        }
        

    }
    
    
}

//struct VKNewsAttachments {
//    let type: String
//    let photo: VKPhoto?
//    let video: VKVideo?
//}
//
//extension VKNewsAttachments: Codable {
//    enum CodingKeys: String, CodingKey {
//        case type = "type"
//        case photo
//        case video
//    }
//}

struct VKNewsComments {
    let count: Int
    let canPost: Int
}

extension VKNewsComments: Codable {
    enum CodingKeys: String, CodingKey {
        case count
        case canPost = "can_post"
    }
}

struct VKNewsLike {
    let count: Int
    let canLike: Int
    let userLikes: Int
}

extension VKNewsLike: Codable {
    enum CodingKeys: String, CodingKey {
        case count
        case canLike = "can_like"
        case userLikes = "user_likes"
    }
}

struct VKNewsReposts {
    let count: Int
    let userReposted: Int
}

extension VKNewsReposts: Codable {
    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}

struct VKNewsViews {
    let count: Int
}

extension VKNewsViews: Codable {
    enum CodingKeys: String, CodingKey {
        case count
    }
}

/*
 {
 "response": {
 "items": [{
 "source_id": -24565142,
 "date": 1601902200,
 "can_doubt_category": false,
 "can_set_category": false,
 "topic_id": 19,
 "post_type": "post",
 "text": "«Сундрунские кекуры»

 Останцы в верхнем течении реки Сундрун, Якутия. Снимал А. Лавров: nat-geo.ru/community/user/193148",
 "marked_as_ads": 0,
 "attachments": [{
 "type": "photo",
 "photo": {
 "album_id": -7,
 "date": 1601840378,
 "id": 457329521,
 "owner_id": -24565142,
 "has_tags": false,
 "access_key": "cf0d95f95cdb1fac6f",
 "post_id": 1568083,
 "sizes": [{
 "height": 87,
 "url": "https://sun9-70.u...jJd5bevYn45e_5RZuOc",
 "type": "m",
 "width": 130
 }, {...}, {...}, {...}, {...}, {...}, {...}, {...}, {...}, {...}],
 "text": "",
 "user_id": 100
 }
 }],
 "post_source": {
 "type": "vk"
 },
 "comments": {
 "count": 0,
 "can_post": 1,
 "groups_can_post": true
 },
 "likes": {
 "count": 3,
 "user_likes": 0,
 "can_like": 1,
 "can_publish": 1
 },
 "reposts": {
 "count": 0,
 "user_reposted": 0
 },
 "views": {
 "count": 388
 },
 "is_favorite": false,
 "donut": {
 "is_donut": false
 },
 "short_text_rate": 0.8,
 "post_id": 1568083,
 "type": "post",
 "push_subscription": {
 "is_subscribed": false
 },
 "track_code": "88ed6a78hqgoHukjGN4s5cEPvUrLI4wlm0osEy4XBEt5EsQ3vnn_xTt9ihUq6UzaJ786gvgd23TMKUJUfUxRHT4"
 },
 */
