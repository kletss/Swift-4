//
//  RealmSwift.swift
//  VKApp
//
//  Created by KKK on 08.06.2021.
//

import RealmSwift

class RealmService {
    
    static let deleteIfMigration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)

    
    static func save<T: Object>(items: [T],
                                configuration: Realm.Configuration = deleteIfMigration,
                                update: Realm.UpdatePolicy = .modified) throws {
        
        print("SAVE, open", configuration.fileURL ?? "")
          let realm = try Realm(configuration: configuration)
          try realm.write{
            realm.add(items,
                      update: update)
        }

    }
    
    static func load<T:Object>(typeOf: T.Type) throws -> Results<T> {
        let realm = try Realm()
            print("LOAD, open",Realm.Configuration().fileURL ?? "")
            let object = realm.objects(T.self)
            return object

    }

    static func delete<T:Object>(object: Results<T>) throws {
        let realm = try Realm()
        try realm.write {
            realm.delete(object)
        }
    }
}
