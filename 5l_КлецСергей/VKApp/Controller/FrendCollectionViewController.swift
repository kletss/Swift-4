//
//  CollectionViewController.swift
//  VKApp
//
//  Created by KKK on 04.04.2021.
//

import UIKit
import RealmSwift


class FrendCollectionViewController: UICollectionViewController {


//    var vkPhotos = VKPhotos(count: 0, items: []) {
//        didSet {
//            DispatchQueue.main.async {
//                self.collectionView.reloadData()
//            }
//        }
//    }

    lazy var frendIndex = Int()
   
    private var photo: UIImage? = nil
    
    private var vkPhotos = try? RealmService.load(typeOf: RealmPhoto.self)
    private var token: NotificationToken?
    
    
    private let photoService = PhotoService()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        observeRealmPhoto()
        
        readFriendPhoto(fInd: frendIndex)
        
//        let vkPhotos1 = vkPhotos.sorted({$0[0].2 < $1[0].sizes.2})

        
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

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        token?.invalidate()
    }
    
    private func observeRealmPhoto() {
        token = vkPhotos?.observe({ changes in
            switch changes {
            case .initial(let results):
                if results.count > 0 {
                    self.collectionView.reloadData()
                }
                
            case let .update(_, deletions, insertions, modifications):
                if !modifications.isEmpty {
                    var indexPath = [IndexPath]()
//                    for item in modifications {
//                        indexPath.append(IndexPath(row: item, section: 0))
//                    }
                    indexPath.append(IndexPath(row: modifications.first!, section: 0))
                    self.collectionView.reloadItems(at: indexPath)
                }
                if !insertions.isEmpty {
                    let indexPath = [IndexPath]()
//                    for item in insertions {
//                        indexPath.append(IndexPath(row: item, section: 0))
//                    }
                    self.collectionView.insertItems(at: indexPath)
                }
                if !deletions.isEmpty {
                    let indexPath = [IndexPath]()
//                        for item in deletions {
//                            indexPath.append(IndexPath(row: item, section: 0))
//                        }
                    self.collectionView.deleteItems(at: indexPath)
                }
            case .error(let error):
                print(error)
            }
        })
    }
    
    
    private func readFriendPhoto(fInd frendIndex: Int) {
        
        self.vkPhotos = try? RealmService
            .load(typeOf: RealmPhoto.self)
            .filter(NSPredicate(format: "idUser == %i", frendIndex))
        
    }
    
    //    override func viewDidAppear(_ animated: Bool) {
    //        super.viewDidAppear(animated)//
    //    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items

//        return frendCollectionImag[frendIndex].images.count
        return vkPhotos?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FrendCollectionViewCell", for: indexPath) as? FrendCollectionViewCell
        else { return UICollectionViewCell() }
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FrendCollectionViewCell", for: indexPath) as! FrendCollectionViewCell

        // Configure the cell

        photoService.getImage(urlString: vkPhotos![indexPath.item].sizes.first!.photoURL) { [weak self] image in
//                   DispatchQueue.main.async {
                self?.photo = image!
//                   }
        }
        
        cell.configate(photo: photo!)
        
//        cell.configate(frend: frendCollectionImag[frendIndex].images[indexPath.item])
//        cell.configate(photoUrl: vkPhotos![indexPath.item].sizes.first!.photoURL)
         
        return cell
    }

    @IBOutlet var frendCollection: UICollectionView!

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "frendImagesIdentifier" else { return }
        guard let destination = segue.destination as? FrendViewControllerImages else { return }
//        let ind = FrandsTableView.indexPathForSelectedRow
      //  destination.frend.append(frends[ind!.item])
      //  destination.frend.append(frends[ind!.section].rows[ind!.row])
//        destination.frendImage = frends[ind!.section].rows[ind!.row].id
        
        let ind = frendCollection.indexPathsForSelectedItems?.first 
        destination.indFrendCollectionImag = frendIndex
        destination.indImage = ind!.row
        
        destination.vkPhotos = Array(vkPhotos!)
        
        

    }

}
