//
//  ParsingFriendsOperation.swift
//  VKApp
//
//  Created by KKK on 26.07.2021.
//

import Foundation

class ParsingFriendsOperation: AsyncOperation {
    var data: [RealmUser]?

    override func main() {
        guard let getDataOperation = dependencies.first as? GetDataOperation,
              let jdata = getDataOperation.data
        else { return }
        
        self.data = try? JSONDecoder().decode(VKResponse<RealmUsers>.self, from: jdata).response.items
        self.state = .finished
        print("Parsing frends - ok")
    }
}
