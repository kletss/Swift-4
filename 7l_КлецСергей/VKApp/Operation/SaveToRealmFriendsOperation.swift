//
//  SaveToRealmFriendsOperation.swift
//  VKApp
//
//  Created by KKK on 26.07.2021.
//

import Foundation

class SaveToRealmFriendsOperation: AsyncOperation {
    
    override func main() {
        guard let parsingFriendsOperation = dependencies.first as? ParsingFriendsOperation,
              let data = parsingFriendsOperation.data
        else { return }
        do {
            // удаляем все
            let objectsToDeletePU = try RealmService.load(typeOf: RealmUser.self)
            try RealmService.delete(object: objectsToDeletePU)
            
            //сохранение данных в Realm
            try RealmService.save(items: data)
            state = .finished
            print("-> Save Friends \(state)")
        }
        catch {
            print(error)
        }
    }
}
