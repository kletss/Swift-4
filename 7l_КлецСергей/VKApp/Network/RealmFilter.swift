//
//  RealmFilter.swift
//  VKApp
//
//  Created by KKK on 13.07.2021.
//

import RealmSwift


class ReadPhotoUserIDOperation: AsyncOperation   {
    var photo: [RealmPhoto]?
    var frendIndex: String?
    
    init(frendIndex: String) {
        self.frendIndex = frendIndex
        super.init()
    }
    
    func readPhotoUserId(frendIndex: String = MySingletonSession.instance.userID,complition: @escaping ([RealmPhoto]) -> ()) {
        guard let vkPhotos = try? RealmService
            .load(typeOf: RealmPhoto.self)
            .filter(NSPredicate(format: "idUser == %i", frendIndex))
        else { return }
        complition(Array(vkPhotos))
    }
    
    override func main() {
        readPhotoUserId(frendIndex: self.frendIndex ?? ""){[weak self] (pdata) in
            self?.photo = pdata
            self?.state = .finished
        }
    }
    
}

func readGroupsUserID(fInd frendIndex: Int) -> [RealmGroup] {

    guard let vkGroup = try? RealmService
            .load(typeOf: RealmGroup.self)
            .filter(NSPredicate(format: "idUser == %i", frendIndex))
    else { return [] }

    return Array(vkGroup)
}
