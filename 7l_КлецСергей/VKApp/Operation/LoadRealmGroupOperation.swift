//
//  LoadRealmGroupOperation.swift
//  VKApp
//
//  Created by KKK on 14.07.2021.
//

class LoadRealmGroupOperation: AsyncOperation {
    var realmGroups: [RealmGroup]!
    
    override func main() {
        realmGroups = Array(try! RealmService.load(typeOf: RealmGroup.self))
        state = .finished
    }
}
