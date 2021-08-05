//
//  VKProfiles.swift
//  VKApp
//
//  Created by KKK on 07.07.2021.
//

struct VKProfiles: Codable {
    var profiles: [VKProfile]
}

struct VKProfile{
    let id: Int
    let firstName: String
    let lastName: String
    var fullName: String  { "\(firstName)  \(lastName)" }
    let avatarURL: String
}


extension VKProfile: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case avatarURL = "photo_50"
    }
}



/*
"profiles": [{
"id": 100,
"first_name": "VK Administration",
"last_name": "",
"is_closed": false,
"can_access_closed": true,
"is_service": true,
"sex": 2,
"screen_name": "id100",
"photo_50": "https://sun9-55.u...wzBfES0HE&ava=1",
"photo_100": "https://sun9-55.u...ef2P3L2M8&ava=1",
"online": 0,
"online_info": {
"visible": true,
"is_online": false,
"is_mobile": false
}
}],
*/
