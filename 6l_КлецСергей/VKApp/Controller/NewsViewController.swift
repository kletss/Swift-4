//
//  NewsViewController.swift
//  VKApp
//
//  Created by KKK on 19.04.2021.
//

import UIKit

class NewsViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource, UIViewControllerTransitioningDelegate {
    
//    var vkNewsFeeds = VKNewsFeeds(items: [],groups: [], profiles: [])
    
    private var  vkNewsFeeds = VKNewsFeeds(items: [])
    private var  vkGroup = VKGroups(count: 0, groups: [])
    private var  vkProfile = VKProfiles(profiles: [])
    
    private var dateTextCache: [IndexPath: String] = [:]

    private let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy HH.mm"
        return df
    }()
    
    private let photoService: PhotoService = {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        return appDelegate?.photoService ?? PhotoService()
    }()
    
    
    private var heightCell = 400.0
    
    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "NewsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "NewsTableViewCell")
        
        NetworkService().getNewsFeeds() {
            [weak self] vkNewsFeeds in self?.vkNewsFeeds = vkNewsFeeds
           self?.tableView.reloadData()
         }
        
        NetworkService().comlexNewsFeeds() {
            [weak self] vkNewsFeedsN,vkGroupN,vkProfileN  in
                self?.vkNewsFeeds = vkNewsFeedsN
                self?.vkGroup = vkGroupN
                self?.vkProfile = vkProfileN

           self?.tableView.reloadData()
         }
        
        
    }
    
    
//    func passData() {
//        let storyboard = UIStoryboard(name: "newsFeed", bundle: nil)
//        guard let secondViewController = storyboard.instantiateViewController(identifier: "LikeController") as? LikeController else { return }
//        secondViewController.likeCount = 5
//
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("news=",vkNewsFeeds.items.count)
        return vkNewsFeeds.items.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell
        else { return UITableViewCell() }
        
        
        var sourceURL: String
        var sourceName: String
        var sourceID = vkNewsFeeds.items[indexPath.item].sourceID
        
        sourceName = vkProfile.profiles.first(where: {$0.id == sourceID})?.fullName ?? "пусто"
        sourceURL = vkProfile.profiles.first(where: {$0.id == sourceID})?.avatarURL ?? ""

        if sourceID < 0 {
            sourceID = -1 * sourceID
            sourceName = vkGroup.groups.first(where: {$0.id == sourceID})?.name ?? "пусто"
            sourceURL = vkGroup.groups.first(where: {$0.id == sourceID})?.avatarURL ?? ""
        }



        let likeCount = vkNewsFeeds.items[indexPath.item].likes.count
        let userLike = (vkNewsFeeds.items[indexPath.item].likes.userLikes != 0)
        let commentCount = vkNewsFeeds.items[indexPath.item].comments.count
        heightCell = 400
        
        var imagePostURL: String?
        
       switch vkNewsFeeds.items[indexPath.item].attach?.first?.type {
        case  VKNewsAttachments.CodingKeys.photo.rawValue:
            imagePostURL = vkNewsFeeds.items[indexPath.item].attach?.first?.photo?.sizes.first?.urlImage
        case  VKNewsAttachments.CodingKeys.video.rawValue:
            imagePostURL = vkNewsFeeds.items[indexPath.item].attach?.first?.video?.image.first?.urlImage
        default:
            heightCell = 210
            imagePostURL = ""
        }
        
//        var imPostURL = vkNewsFeeds.items[indexPath.item].attach?[0].photo?.sizes[0].urlImage
//        if (imPostURL == nil) {
//            imPostURL = vkNewsFeeds.items[indexPath.item].attach?[0].video?.image[0].urlImage
//        }
        
        
        cell.configate (
            postID: vkNewsFeeds.items[indexPath.item].postID,
            sourceName: sourceName,
            sourceAvatar: getImage(sUrl: sourceURL),
            datePost: getDateNews(indexPath: indexPath, stampDateTime: vkNewsFeeds.items[indexPath.item].date),
            textPost: vkNewsFeeds.items[indexPath.item].text,
            imagePost: getImage(sUrl: imagePostURL!),
            likeCount: likeCount,
            selectedLike: userLike,
            commentCount: commentCount
        )
        
        
        return cell
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         
        return CGFloat(heightCell)
    }
 
    private func getDateNews(indexPath: IndexPath, stampDateTime: Double) -> String {
        
        if let date = dateTextCache[indexPath] {
            return date
        } else {
            let date = dateFormatter.string(from: Date(timeIntervalSince1970: vkNewsFeeds.items[indexPath.item].date))
            dateTextCache[indexPath]  = date
            return date
        }
    }
    
    private func getImage(sUrl: String) -> UIImage {
        let avatar: UIImage = UIImage(named: "noneAvatarGroup")!
        guard
            let url = URL(string: sUrl),
            let data = try? Data(contentsOf: url),
            let image = UIImage(data: data)
        else { return avatar}
        return image
    }
}
