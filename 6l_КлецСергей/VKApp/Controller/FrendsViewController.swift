//
//  FrendsViewController.swift
//  VKApp
//
//  Created by KKK on 14.04.2021.
//

import UIKit
import RealmSwift
import PromiseKit

class FrendsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
//    var rFriends = RealmFriends() {
//        didSet{
//            DispatchQueue.main.async {
//                self.FrandsTableView.reloadData()
//            }
//        }
//    }
    
//    var frends = [frendsSections]()
//    var lettersSection = [Character]()
//
//
    
    private let loadQueue = OperationQueue()
    
    
    private let vkFriends = try? RealmService.load(typeOf: RealmUser.self)
    private var token: NotificationToken?
    private var avatar: UIImage = UIImage(named: "noneAvatarFriend")!

    
//    private let photoService = PhotoService()
    private let photoService: PhotoService = {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        return appDelegate?.photoService ?? PhotoService()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observeRealmFriends()
        
//        let rFriends = RealmFriend()
//        try? RealmService.save(items: [rFriends])

//        NetworkService().getListFriends() {
//            realmFriends in
////            [weak self] realmFriends in
//            // weak self не нужно тк нет ссылок на self
//            do {
//                try RealmService.save(items: realmFriends)
//            } catch {
//                print(error)
//            }
//         }
        
//        let NS = NetworkService()
//        NS
//            .getUserFriendsPromise()
//            .thenMap(on: DispatchQueue.global())  {elem in
//                return Promise.value(RealmUser(value: elem))
//            }
//            .done {realmFriends in
//                do {
//                    try RealmService.save(items: realmFriends)
//                } catch {
//                    print(error)
//                }
//            }
//            .catch  {error in
//                print(error)
//            }
        
        let operDataFriends = GetDataOperation(
            methodPaths:
                makeComponentsUrl.MethodPaths.getFriends,
                userID: MySingletonSession.instance.userID
        )
        let operParsFriends = ParsingFriendsOperation()
        operParsFriends.addDependency(operDataFriends)

        let operSaveFriends = SaveToRealmFriendsOperation()
        operSaveFriends.addDependency(operParsFriends)
        
        self.loadQueue.addOperations([operDataFriends, operParsFriends, operSaveFriends, ],
                                     waitUntilFinished: true)


        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        token?.invalidate()
    }
    
    private func observeRealmFriends() {
        token = vkFriends?.observe({ changes in
            switch changes {
            case .initial(let results):
                if results.count > 0 {
                    self.FrandsTableView.reloadData()
                }
                
            case let .update(_, deletions, insertions, modifications):
                if !modifications.isEmpty {
                    var indexPath = [IndexPath]()
                    for item in modifications {
                        indexPath.append(IndexPath(row: item, section: 0))
                    }
//                    modifications.forEach({indexPath.append(IndexPath(row: modifications[$0], section: 0))})
                    self.FrandsTableView.reloadRows(at: indexPath, with: .automatic)
                }
                if !insertions.isEmpty {
                    var indexPath = [IndexPath]()
                    for item in insertions {
                        indexPath.append(IndexPath(row: item, section: 0))
                    }
                    self.FrandsTableView.insertRows(at: indexPath, with: .bottom)
                }
                if !deletions.isEmpty {
                        var indexPath = [IndexPath]()
                        for item in deletions {
                            indexPath.append(IndexPath(row: item, section: 0))
                        }
                        self.FrandsTableView.deleteRows(at: indexPath, with: .top)
                }
            case .error(let error):
                print(error)
            }
        })
    }
    
    
//    lazy var frendsController = VKApp.FrendsController(letters: lettersSection,
//                                                       frame: CGRect(x: FrendsController.frame.minX-25, y: FrendsController.frame.minY,
//                                                      width: 25,
//                                                      height: 250))
 
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    // MARK: - Table view data source
   @IBOutlet var FrandsTableView: UITableView!

    @IBOutlet weak var FrendsController: FrendsController!
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        return frends[section].rows.count
        return vkFriends?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FrendsCell_Ind", for: indexPath) as! FrendsCell
//        cell.textLabel?.text = frends[indexPath.item].nik
//        cell.imageView?.image = frends[indexPath.item].image
//        cell.accessoryType = .disclosureIndicator
//
        
//        cell.configate(image: frends[indexPath.item].image, nik: frends[indexPath.item].nik+" "+section)
//        print(indexPath.section)
//        cell.configate(image: frends[indexPath.section].rows[indexPath.row].image, nik: frends[indexPath.section].rows[indexPath.row].nik)
        

 
        photoService.getImage(urlString: vkFriends![indexPath.row].photoAvatarURL) { [weak self] image in
//               DispatchQueue.main.async {
                self?.avatar = image!
//               }
        }
        
        
        
        cell.configate(
//            imageUrl: vkFriends![indexPath.row].photoAvatarURL,
            nik: vkFriends![indexPath.row].fullName,
            avatar: avatar
//            photoService: photoService
        )
        
        return cell
    }
    
    // MARK: - Table view delegate methods
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: - Передача данных в FrendCollectionViewController
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//                guard segue.identifier == "presentFrendCollection" else { return }
//        guard let destination = segue.destination as? FrendCollectionViewController else { return }
//        let ind = FrandsTableView.indexPathForSelectedRow
//        destination.frendIndex = vkFriends![ind!.row].id
//
//    }
    
    
    // MARK: - Передача данных в FrendInfoController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "presentFrendInfo" else { return }
        guard let destination = segue.destination as? FrendInfoController else { return }
        let ind = FrandsTableView.indexPathForSelectedRow

        destination.frendAvatarURLVar = vkFriends![ind!.row].photoAvatarURL
        destination.frendFullNameVar = vkFriends![ind!.row].fullName
        
        destination.frendIndex = vkFriends![ind!.row].id

    }
    
    
    // Create a custom header
//    override func tableView(_ tableView: UITableView,
//            viewForHeaderInSection section: Int) -> UIView? {
//       let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
//                   "sectionHeader") as! MyCustomHeader
//       view.title.text = sectionLetter[section]
//   //    view.image.image = UIImage(named: sectionImages[section])
//
//       return view
//    }
    
    // Create a standard header that includes the returned text.
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
////        return   String(frends[section].section)
//        return   String(vkFriends[section].section)
//    }
    
    
//    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        return lettersSection.map{ "\($0)" }
//    }
    
}
