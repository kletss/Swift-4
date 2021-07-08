//
//  FrendInfoController.swift
//  VKApp
//
//  Created by KKK on 29.06.2021.
//

import UIKit

class FrendInfoController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    

    
    
    var frendFullNameVar = ""
    var frendAvatarURLVar = ""
    
    lazy var frendIndex = Int()
    
    @IBOutlet weak var frendFullName: UILabel!
    @IBOutlet weak var frendAvatar: UIImageView!
    
    private var vkPhotos = try? RealmService.load(typeOf: RealmPhoto.self)

    
    override func viewDidLoad() {
            super.viewDidLoad()

        
        frendFullName.text = frendFullNameVar
        frendAvatar.image = getAvatar()
        

        
        readFriendPhoto(fInd: frendIndex)
        
        NetworkService().getPhotos(user_ID: String(frendIndex)) {
            realmPhotos in
//            [weak self] realmPhotos in
            do {
                try RealmService.save(items: realmPhotos)
            } catch {
                print(error)
             }
        }
        
    
    }
    
    private func getAvatar() -> UIImage {
        var avatar = UIImage(named: "noneAvatarFriend")
        guard let url = URL(string: frendAvatarURLVar) else { return avatar!}
        if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    avatar = image
                }
        }
        return avatar!
    }
    
    
    private func readFriendPhoto(fInd frendIndex: Int) {
        
        self.vkPhotos = try? RealmService
            .load(typeOf: RealmPhoto.self)
            .filter(NSPredicate(format: "idUser == %i", frendIndex))
        
    }
    
    // MARK: UICollectionViewDataSource

    @IBOutlet weak var frendInfoCollection: UICollectionView!

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vkPhotos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
//            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("FrendCollectionViewCell", forIndexPath: indexPath),
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FrendCollectionViewCell", for: indexPath) as? FrendCollectionViewCell
        else { return UICollectionViewCell() }
        
        cell.configate(photoUrl: vkPhotos![indexPath.item].sizes.first!.photoURL)
        
        return cell
        
    }
    

    
}
