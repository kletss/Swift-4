//
//  ParsingGroupsOperation.swift
//  VKApp
//
//  Created by KKK on 12.07.2021.
//

import Foundation


class ParsingGroupsOperation: AsyncOperation {
    var groups: [RealmGroup]?

    override func main() {
        guard let getDataOperation = dependencies.first as? GetDataOperation,
              let jdata = getDataOperation.data
        else { return }
        
        self.groups = try? JSONDecoder().decode(VKResponse<RealmGroups>.self, from: jdata).response.items
        self.state = .finished
//        print("o2 \(self.state)")
    }
    
}
