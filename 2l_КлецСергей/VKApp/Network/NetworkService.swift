//
//  NetworkService.swift
//  VKApp
//
//  Created by KKK on 23.05.2021.
//

import UIKit
import RealmSwift
 
class NetworkService {
    
    enum MethodPaths: String {
        case getFriends = "friends.get"
        case getPhotos = "photos.getAll"
        case getGroups = "groups.get"
        case getNewsFeed = "newsfeed.get"
    }
    
    private let dispGroup = DispatchGroup()

    private static let apiVersion = "5.131"
    
    private func makeComponents(for path: MethodPaths) -> URLComponents {
        let urlComponents : URLComponents = {
            var myUrl = URLComponents ()
            myUrl.scheme = "https"
            myUrl.host = "api.vk.com"
            myUrl.path = "/method/\(path.rawValue)"
            myUrl.queryItems = [
                URLQueryItem(name: "access_token", value: MySingletonSession.instance.token),
                URLQueryItem(name: "v", value: NetworkService.apiVersion),
            ]
            return myUrl
        } ()
        return urlComponents
    }
//    ------------------
    func getListFriends(user_ID userID: String = MySingletonSession.instance.userID, completion: @escaping ([RealmUser]) -> Void)  {
        var myUrl = makeComponents(for: .getFriends)
        myUrl.queryItems?.append(contentsOf:[
                                        URLQueryItem(name: "user_id", value: userID),
                                        URLQueryItem(name: "fields", value: "photo_200"),
                                        ])

        if let url = myUrl.url  {
            print("url= \(String(describing: url))")
            
//            let session = URLSession.shared
            let session = URLSession(configuration: URLSessionConfiguration.default)
            session.dataTask(with: url) { (data, response, error) in
                guard
                    let JSONData = data
                else {return}
                let vkFriends = try? JSONDecoder().decode(VKResponse<RealmUsers>.self, from: JSONData)
                guard
                    let vkF1 = vkFriends?.response
                else {return}
                DispatchQueue.main.async {
                    completion(vkF1.items)
                }
          }
        .resume()
        }
    }
  
//    ------------
    

    func getListGroups(completion: @escaping ([RealmGroup]) -> Void) {
        var myUrl = makeComponents(for: .getGroups)
        myUrl.queryItems?.append(contentsOf:[
                                        URLQueryItem(name: "extended", value: "1"),
//                                        URLQueryItem(name: "count", value: "1"),
                                        ])
        if let url = myUrl.url {
        print("url= \(url)")
        
        
//        let session = URLSession.shared
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: url) { (data, response, error) in
//            guard error == nil else {
//                // error parsing
//                return
//            }
            
            if let JSONData = data {
//                let json = try? JSONSerialization.jsonObject(
//                    with: JSONData,
//                    options: .allowFragments)
//                print("json \(json) ")

                    let vkGroups = try? JSONDecoder().decode(VKResponse<RealmGroups>.self, from: JSONData)
//                    print(vkGroups)
                guard let vkG = vkGroups?.response else {return}
                DispatchQueue.main.async {
                    completion(vkG.items)
                }
            }
        }
        .resume()
      }
   }
    
    
    func getPhotos(user_ID userID : String = MySingletonSession.instance.userID, completion: @escaping ([RealmPhoto]) -> Void) {
        var myUrl = makeComponents(for: .getPhotos)
        myUrl.queryItems?.append(contentsOf:[
                                            URLQueryItem(name: "owner_id", value: userID),
                                            URLQueryItem(name: "extended", value: "1"),
        ])
        if let url = myUrl.url {
        print("url= \(url)")

            let session = URLSession(configuration: URLSessionConfiguration.default)

            session.dataTask(with: url) { (data, response, error) in
                guard let JSONData = data else {return}
                    let vkPhotos = try? JSONDecoder().decode(VKResponse<RealmPhotos>.self, from: JSONData)
                    guard let vkP = vkPhotos?.response else {return}
                    DispatchQueue.main.async {
                        completion(vkP.items)
                    }
            }
            .resume()
        }
    }
    
    func getNewsFeeds(completion: @escaping (VKNewsFeeds) -> Void) {
        var myUrl = makeComponents(for: .getNewsFeed)
        myUrl.queryItems?.append(contentsOf:[
                        URLQueryItem(name: "filters", value: "post,photo"),
                        URLQueryItem(name: "count", value: "10"),
        ])
        if let url = myUrl.url {
        print("url= \(url)")

            let session = URLSession(configuration: URLSessionConfiguration.default)

            session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print("er=", error as Any)
                }
                guard let JSONData = data else {return}
                let vkVar = try? JSONDecoder().decode(VKResponse<VKNewsFeeds>.self, from: JSONData)
//                        let json = try? JSONSerialization.jsonObject(
//                            with: JSONData,
//                            options: .allowFragments)
//                        print("json \(json) ")
        
                    guard let vkP = vkVar?.response else {return}
                
                    DispatchQueue.main.async {
                        completion(vkP)
                    }
            }
            .resume()
        }
    }

    func comlexNewsFeeds(completion: @escaping (_ vkNewsFeeds: VKNewsFeeds, _ vkGroup: VKGroups, _  vkProfile: VKProfiles) -> Void) {
        var vkNewsFeeds = VKNewsFeeds(items: [])
        var vkGroup = VKGroups(count: 0, groups: [])
        var vkProfile = VKProfiles(profiles: [])
        
        var myUrl = makeComponents(for: .getNewsFeed)
        myUrl.queryItems?.append(contentsOf:[
                        URLQueryItem(name: "filters", value: "post,photo"),
                        URLQueryItem(name: "count", value: "10"),
        ])
        if let url = myUrl.url {
        print("url= \(url)")

            let session = URLSession(configuration: URLSessionConfiguration.default)

            session.dataTask(with: url) { [self] (data, response, error) in
                if error != nil {
                    print("er=", error as Any)
                }
                guard let JSONData = data else {return}
  
                DispatchQueue.global().async(group: dispGroup) {
                    let vkVar = try? JSONDecoder().decode(VKResponse<VKNewsFeeds>.self, from: JSONData)
                    guard let vkP = vkVar?.response else {return}
                    vkNewsFeeds = vkP
                }
                DispatchQueue.global().async(group: dispGroup) {
                    let vkVar = try? JSONDecoder().decode(VKResponse<VKGroups>.self, from: JSONData)
                    guard let vkP = vkVar?.response else {return}
                    vkGroup = vkP
                }
                DispatchQueue.global().async(group: dispGroup) {
                    let vkVar = try? JSONDecoder().decode(VKResponse<VKProfiles>.self, from: JSONData)
                    guard let vkP = vkVar?.response else {return}
                    vkProfile = vkP
                }
                dispGroup.notify(queue: .main) {
                    completion(vkNewsFeeds, vkGroup, vkProfile)
                }
                
            }
            .resume()
        }
        
    }
    
}
 
