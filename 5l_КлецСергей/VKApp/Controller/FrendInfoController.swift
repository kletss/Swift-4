//
//  FrendInfoController.swift
//  VKApp
//
//  Created by KKK on 29.06.2021.
//

import UIKit
import RealmSwift

class FrendInfoController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
 
    var frendFullNameVar = ""
    var frendAvatarURLVar = ""
    
    lazy var frendIndex = Int()
    
    @IBOutlet weak var frendFullName: UILabel!
    @IBOutlet weak var frendAvatar: UIImageView!
    @IBOutlet weak var fotkiLabel: UILabel!
    @IBOutlet weak var groupsLabel: UILabel!
    
        
    @IBOutlet weak var photoCollection: UICollectionView!
    @IBOutlet weak var groupCollection: UICollectionView!
    
    
    private lazy var vkPhotos = try? RealmService.load(typeOf: RealmPhoto.self)
//    private lazy var fotkiCount = vkPhotos?.count ?? 0
    private var photo: UIImage? = nil

    
    private lazy var vkGroups = try? RealmService.load(typeOf: RealmGroup.self)
//    private lazy var groupsCount = vkGroups?.count ?? 0
    private var avatarGroup: UIImage = UIImage(named: "noneAvatarGroup")!

    
    private var tokenGroup: NotificationToken?
    private var tokenPhoto: NotificationToken?
    
    private let loadQueue = OperationQueue()
    
//    private let photoService = PhotoService()
    private let photoService: PhotoService = {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        return appDelegate?.photoService ?? PhotoService()
    }()
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
        observeRealmGroups()
        observeRealmPhoto()
        
        frendFullName.text = frendFullNameVar
        frendAvatar.image = getAvatar()
        
        let operDataGroup = GetDataOperation(
            methodPaths:
                makeComponentsUrl.MethodPaths.getGroups,
                userID: String(self.frendIndex)
        )
        
        let operParsGroup = ParsingGroupsOperation()
        operParsGroup.addDependency(operDataGroup)
        
        let operSaveGroup = SaveToRealmGroupOperation()
        operSaveGroup.addDependency(operParsGroup)
        
        
        let operDataPhoto = GetDataOperation(
            methodPaths:
                makeComponentsUrl.MethodPaths.getPhotos,
                userID: String(self.frendIndex)
        )
        
        let operParsPhoto = ParsingPhotosOperation()
        operParsPhoto.addDependency(operDataPhoto)
        
        let operSavePhoto = SaveToRealmPhotoOperation()
        operSavePhoto.addDependency(operParsPhoto)
//        let oper4 = LoadRealmGroupOperation()
//        oper4.addDependency(oper3)
//        oper4.completionBlock = {
//            OperationQueue.main.addOperation {
//                self.vkGroups1 =  oper4.realmGroups!
//            }
//        }

        self.loadQueue.addOperations([operDataGroup, operParsGroup, operSaveGroup, ],
                                     waitUntilFinished: true)

        self.loadQueue.addOperations([operDataPhoto, operParsPhoto, operSavePhoto],
                                     waitUntilFinished: true)

//        _ = vkGroups as? [RealmGroup]?
        
//        readFriendInfo(fInd: frendIndex)
        
        
//        NetworkService().getPhotos(user_ID: String(frendIndex)) {
//            realmPhotos in
//            do {
//                try RealmService.save(items: realmPhotos)
//            } catch {
//                print(error)
//             }
//        }
        

        
        let nib = UINib(nibName: "FrendInfoCollectionGroup", bundle: nil)
        groupCollection.register(nib, forCellWithReuseIdentifier: "FrendInfoCollectionGroup")
    
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        observeRealmGroups()
//        observeRealmPhoto()
     }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tokenGroup?.invalidate()
        tokenPhoto?.invalidate()
//        do {
//            let objectsToDelete = try RealmService.load(typeOf: RealmGroup.self)
//            try RealmService.delete(object: objectsToDelete)
//        } catch { print(error) }
    }
    
    private func getAvatar() -> UIImage {
        let avatar = UIImage(named: "noneAvatarFriend")
        guard
            let url = URL(string: frendAvatarURLVar),
            let data = try? Data(contentsOf: url),
            let avatar = UIImage(data: data)
        else { return avatar!}

        return avatar
    }
    
    
//    private func readFriendInfo(fInd frendIndex: Int) {
//
//        self.vkPhotos = try? RealmService
//            .load(typeOf: RealmPhoto.self)
//            .filter(NSPredicate(format: "idUser == %i", frendIndex))
//
//        self.vkGroups = try? RealmService
//            .load(typeOf: RealmGroup.self)
//            .filter(NSPredicate(format: "idUser == %i", frendIndex))
//
//    }
    
    
    
    private func observeRealmGroups() {
        tokenGroup = vkGroups?.observe({ changes in

            switch changes {
            case .initial(let results):
//                if results.count > 0 {
                    self.groupCollection.reloadData()
                    self.groupsLabel.text = "Группы \(results.count)"

//                }
                
            case let .update(_, deletions, insertions, modifications):
                if !modifications.isEmpty {
                    var indexPath = [IndexPath]()
                    for item in modifications {
                        indexPath.append(IndexPath(row: item, section: 0))
                    }
                    self.groupCollection.reloadItems(at: indexPath)
//                    self.groupCollection.reloadData()
                }
                if !insertions.isEmpty {
                    var indexPath = [IndexPath]()
                    for item in insertions {
                        indexPath.append(IndexPath(row: item, section: 0))
                    }
                    self.groupCollection.insertItems(at: indexPath)
//                    self.groupCollection.reloadData()
                }
                if !deletions.isEmpty {
                        var indexPath = [IndexPath]()
                        for item in deletions {
                            indexPath.append(IndexPath(row: item, section: 0))
                        }
                    self.groupCollection.deleteItems(at: indexPath)
//                    self.groupCollection.reloadData()
                }
            case .error(let error):
                print(error)
            }
        })
    }
    
    private func observeRealmPhoto() {
        tokenPhoto = vkPhotos?.observe({ changes in
            switch changes {
            case .initial(let results):
//                if results.count > 0 {
                    self.fotkiLabel.text = "Фотки \(results.count)"
                    self.photoCollection.reloadData()
//                }
                
            case let .update(_, deletions, insertions, modifications):
                if !modifications.isEmpty {
                    var indexPath = [IndexPath]()

                    indexPath.append(IndexPath(row: modifications.first!, section: 0))
                    self.photoCollection.reloadItems(at: indexPath)
                }
                if !insertions.isEmpty {
                    let indexPath = [IndexPath]()
                    self.photoCollection.insertItems(at: indexPath)
                }
                if !deletions.isEmpty {
                    let indexPath = [IndexPath]()
                    self.photoCollection.deleteItems(at: indexPath)
                }
            case .error(let error):
                print(error)
            }
        })
    }
    
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var rret = 0
        switch collectionView {
            case photoCollection:
                rret = vkPhotos?.count ?? 0
            case groupCollection:
                rret = vkGroups?.count ?? 0
        default:
            rret = 0
        }
        return rret
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == photoCollection {
                guard
                     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FrendCollectionViewCell", for: indexPath) as? FrendCollectionViewCell

                else { return UICollectionViewCell() }
        
            photoService.getImage(urlString: vkPhotos![indexPath.item].sizes.first!.photoURL) { [weak self] image in
//                   DispatchQueue.main.async {
                    self?.photo = image!
//                   }
            }
            
//            cell.configate(photoUrl: vkPhotos![indexPath.item].sizes.first!.photoURL)
            cell.configate(photo: photo!)
            return cell
        } else {
//        if collectionView == photoCollection {
                guard
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FrendInfoCollectionGroup", for: indexPath) as? FrendInfoCollectionGroup

                else { return UICollectionViewCell() }
    
            photoService.getImage(urlString: vkGroups![indexPath.row].photoAvatarURL) { [weak self] image in
//                   DispatchQueue.main.async {
                    self?.avatarGroup = image!
//                   }
            }
         
            cell.configate(avatarLabel: vkGroups![indexPath.item].name, avatar: avatarGroup)
            
//            cell.configate(avatarLabel: vkGroups![indexPath.item].name, avatarUrl: vkGroups![indexPath.item].photoAvatarURL, photoService: photoService)
            return cell
                
        }
        
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "frendImagesIdentifier" else { return }
        guard let destination = segue.destination as? FrendViewControllerImages else { return }
       
        let ind = photoCollection.indexPathsForSelectedItems?.first
        destination.indFrendCollectionImag = frendIndex
        destination.indImage = ind!.row
        
        destination.vkPhotos = Array(vkPhotos!)
        
    }

    

    
}
