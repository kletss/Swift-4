//
//  SaveToRealmPhotoOperation.swift
//  VKApp
//
//  Created by KKK on 15.07.2021.
//

import Foundation

class SaveToRealmPhotoOperation: AsyncOperation {
    private let dataSave: [RealmPhoto] = []
    
    override func main() {
        guard let parsingPhotoOperation = dependencies.first as? ParsingPhotosOperation,
              let data = parsingPhotoOperation.data
        else { return }
        do {
            // удаляем все
            let objectsToDeletePU = try RealmService.load(typeOf: PhotoURL.self)
            try RealmService.delete(object: objectsToDeletePU)
            
            let objectsToDeleteP = try RealmService.load(typeOf: RealmPhoto.self)
            try RealmService.delete(object: objectsToDeleteP)
//            data.first

            //сохранение данных в Realm
            try RealmService.save(items: data)
            state = .finished
            print("-> Save photo \(state)")
        }
        catch {
            print(error)
        }
    }
}
