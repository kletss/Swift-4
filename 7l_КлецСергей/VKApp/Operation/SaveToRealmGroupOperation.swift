//
//  SaveToRealmGroupOperation.swift
//  VKApp
//
//  Created by KKK on 12.07.2021.
//

import Foundation

class SaveToRealmGroupOperation: AsyncOperation {
    
    override func main() {
        guard let parsingGroupOperation = dependencies.first as? ParsingGroupsOperation,
              let groups = parsingGroupOperation.groups
        else { return }
        do {
            // удаляем старых
            let ids = groups.map { $0.id}
            let objectsToDelete = try RealmService.load(typeOf: RealmGroup.self).filter("NOT id IN %@", ids)
            try RealmService.delete(object: objectsToDelete)
            //сохранение данных в Realm
            try RealmService.save(items: groups)
            state = .finished
            print("-> Save group \(state)")
        }
        catch {
            print(error)
        }
    }
}
