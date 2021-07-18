//
//  makeComponentsUrl.swift
//  VKApp
//
//  Created by KKK on 15.07.2021.
//

import Foundation

class makeComponentsUrl {
    
    enum MethodPaths: String {
        case getFriends = "friends.get"
        case getPhotos = "photos.getAll"
        case getGroups = "groups.get"
        case getNewsFeed = "newsfeed.get"
    }
    
    private static let apiVersion = "5.131"
    
    func makeComponents(for path: MethodPaths, user_id userID: String = MySingletonSession.instance.userID) -> URLComponents {
        let urlComponents : URLComponents = {
            var myUrl = URLComponents ()
            myUrl.scheme = "https"
            myUrl.host = "api.vk.com"
            myUrl.path = "/method/\(path.rawValue)"
            myUrl.queryItems = [
                URLQueryItem(name: "access_token", value: MySingletonSession.instance.token),
                URLQueryItem(name: "v", value: makeComponentsUrl.apiVersion),
            ]
            switch path {
            case .getGroups:
                myUrl.queryItems?.append(contentsOf:[
                        URLQueryItem(name: "user_id", value: userID),
                        URLQueryItem(name: "extended", value: "1"),
                ])
            case .getFriends:
                myUrl.queryItems?.append(contentsOf:[
                        URLQueryItem(name: "user_id", value: userID),
                        URLQueryItem(name: "fields", value: "photo_200"),
                ])
            case .getPhotos:
                myUrl.queryItems?.append(contentsOf:[
                        URLQueryItem(name: "owner_id", value: userID),
                        URLQueryItem(name: "extended", value: "1"),
                ])
            case .getNewsFeed:
                myUrl.queryItems?.append(contentsOf:[
                        URLQueryItem(name: "filters", value: "post,photo"),
                        URLQueryItem(name: "count", value: "10"),
                ])
            }
            return myUrl
        } ()
        return urlComponents
    }
}
