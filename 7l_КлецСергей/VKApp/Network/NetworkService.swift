//
//  NetworkService.swift
//  VKApp
//
//  Created by KKK on 23.05.2021.
//

import UIKit
import RealmSwift
import PromiseKit
 
class NetworkService {
    
    
    private let dispGroup = DispatchGroup()
    private let mcUrl = makeComponentsUrl()
    
//    ------------------
    func getListFriends(user_ID userID: String = MySingletonSession.instance.userID, completion: @escaping ([RealmUser]) -> Void)  {

        let myUrl = mcUrl.makeComponents(for: .getFriends, user_id: userID)

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
  
    
    func getUserFriendsPromise(user_ID userID: String = MySingletonSession.instance.userID) -> Promise<[RealmUser]> {
        
        let myUrl = mcUrl.makeComponents(for: .getFriends, user_id: userID)
        
       return Promise<[RealmUser]> { seal in
            if let url = myUrl.url {
                let session = URLSession(configuration: URLSessionConfiguration.default)
                session.dataTask(with: url) { (data, response, error) in
                    
                    guard
                        let JSONData = data
                    else {return}
                    do {
                        let vkFriends = try JSONDecoder().decode(VKResponse<RealmUsers>.self, from: JSONData)
                        let vkF1 = vkFriends.response
//                        DispatchQueue.main.async {
                            seal.fulfill( vkF1.items)
//                        }
                    }
                    catch {print(error)}
              }
            .resume()
            }
        }
        
    }
    
//    ------------
    

    func getListGroups(user_ID userID : String = MySingletonSession.instance.userID, completion: @escaping ([RealmGroup]) -> Void) {
        let myUrl = mcUrl.makeComponents(for: .getGroups)

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
                vkG.items.forEach({$0.idUser = Int(userID)!})
                DispatchQueue.main.async {
                    completion(vkG.items)
                }
            }
        }
        .resume()
      }
   }
    
    
    func getPhotos(user_ID userID : String = MySingletonSession.instance.userID, completion: @escaping ([RealmPhoto]) -> Void) {
        let myUrl = mcUrl.makeComponents(for: .getPhotos, user_id: userID)

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
        let myUrl = mcUrl.makeComponents(for: .getNewsFeed)

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

    func comlexNewsFeeds(start_from: String = "", completion: @escaping (_ vkNewsFeeds: [VKNewsFeed], _ vkGroup: [VKGroup], _  vkProfile: [VKProfile], _ startTimeNews: String) -> Void) {
        var vkNewsFeeds = [VKNewsFeed]()
        var vkGroup = [VKGroup]()
        var vkProfile = [VKProfile]()
        var startTimeNews: String = ""
        
        var myUrl = mcUrl.makeComponents(for: .getNewsFeed)
        
        myUrl.queryItems?.append(contentsOf:[
            URLQueryItem(name: "start_from", value: start_from),
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
                    vkNewsFeeds = vkP.items
                    startTimeNews = vkP.next_from
                }
                DispatchQueue.global().async(group: dispGroup) {
                    let vkVar = try? JSONDecoder().decode(VKResponse<VKGroups>.self, from: JSONData)
                    guard let vkP = vkVar?.response else {return}
                    vkGroup = vkP.groups
                }
                DispatchQueue.global().async(group: dispGroup) {
                    let vkVar = try? JSONDecoder().decode(VKResponse<VKProfiles>.self, from: JSONData)
                    guard let vkP = vkVar?.response else {return}
                    vkProfile = vkP.profiles
                }
                dispGroup.notify(queue: .main) {
                    completion(vkNewsFeeds, vkGroup, vkProfile, startTimeNews)
                }
                
            }
            .resume()
        }
        
    }
    
}
 
