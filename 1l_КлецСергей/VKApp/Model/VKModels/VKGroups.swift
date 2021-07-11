//
//  VKGroups.swift
//  VKApp
//
//  Created by KKK on 26.05.2021.
//

struct VKGroup {
    let id: Int
    let name: String
    let avatarURL: String
}


extension VKGroup: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case avatarURL = "photo_50"
    }
}


struct VKGroups: Codable {
    let count: Int
    let items: [VKGroup]
}

//{
//"response": {
//"count": 6,
//"items": [{
//"id": 101965347,
//"name": "ITc | сообщество программистов",
//"screen_name": "itcookies",
//"is_closed": 0,
//"type": "page",
//"is_admin": 0,
//"is_member": 1,
//"is_advertiser": 0,
//"photo_50": "https://sun9-73.u...1181,1181&ava=1",
//"photo_100": "https://sun9-73.u...1181,1181&ava=1",
//"photo_200": "https://sun9-73.u...1181,1181&ava=1"
//}]
//}
//}
