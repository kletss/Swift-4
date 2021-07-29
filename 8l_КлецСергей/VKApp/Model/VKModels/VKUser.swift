//
//  VKUser.swift
//  VKApp
//
//  Created by KKK on 26.05.2021.
//

struct VKUser {
    let id: Int
    let firstName: String
    let lastName: String
    var fullName: String  { "\(firstName)  \(lastName)" }
    let userAvatarURL: String

}


extension VKUser: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case userAvatarURL = "photo_200"

    }
}



//{
//"response": {
//"count": 1493,
//"items": [{
//"first_name": "Alex",
//"id": 1373072,
//"last_name": "Kouprin",
//"can_access_closed": false,
//"is_closed": true,
//"photo_200": "https://sun9-48.u...1205,1696&ava=1",
//"track_code": "be8e0bc38cN7GZdlBLpZ7dw6jgCcMY9FKmbn469dRIL0AeUuUC-cqHF4pTEGtF656857zitH9kYqD4I"
//}]
//}
//}
