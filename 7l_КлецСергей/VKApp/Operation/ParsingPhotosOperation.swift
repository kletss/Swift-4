//
//  ParsingPhotosOperation.swift
//  VKApp
//
//  Created by KKK on 15.07.2021.
//

import Foundation


class ParsingPhotosOperation: AsyncOperation {
    var data: [RealmPhoto]?

    override func main() {
        guard let getDataOperation = dependencies.first as? GetDataOperation,
              let jdata = getDataOperation.data
        else { return }
        
        self.data = try? JSONDecoder().decode(VKResponse<RealmPhotos>.self, from: jdata).response.items
        self.state = .finished
        print("Parsing Photo - ok")
    }
    
}
