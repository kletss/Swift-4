//
//  NewsViewController.swift
//  VKApp
//
//  Created by KKK on 19.04.2021.
//

import UIKit

class NewsViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource, UIViewControllerTransitioningDelegate {
    
    var vkNewsFeeds = VKNewsFeeds(items: [],groups: [], profiles: [])
    
    var heightCell = 400.0
    
    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "NewsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "NewsTableViewCell")
        
        NetworkService().getNewsFeeds() {
            [weak self] vkNewsFeeds in self?.vkNewsFeeds = vkNewsFeeds
            // коллекция должна прочитать новые данные
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
        
        sourceName = vkNewsFeeds.profiles.first(where: {$0.id == sourceID})?.fullName ?? ""
        sourceURL = vkNewsFeeds.profiles.first(where: {$0.id == sourceID})?.avatarURL ?? ""

        if sourceID < 0 {
            sourceID = -1 * sourceID
            sourceName = vkNewsFeeds.groups.first(where: {$0.id == sourceID})!.name
            sourceURL = vkNewsFeeds.groups.first(where: {$0.id == sourceID})!.avatarURL
        }


        var imPostURL: String? = nil
        let likeCount = vkNewsFeeds.items[indexPath.item].likes.count
        let userLike = (vkNewsFeeds.items[indexPath.item].likes.userLikes != 0)
        let commentCount = vkNewsFeeds.items[indexPath.item].comments.count
        
        switch vkNewsFeeds.items[indexPath.item].attach?.first?.type {
        case  VKNewsAttachments.CodingKeys.photo.rawValue:
            imPostURL = vkNewsFeeds.items[indexPath.item].attach?.first?.photo?.sizes.first?.urlImage
        case  VKNewsAttachments.CodingKeys.video.rawValue:
            imPostURL = vkNewsFeeds.items[indexPath.item].attach?.first?.video?.image.first?.urlImage
//            likeCount = vkNewsFeeds.items[indexPath.item].attach?[0].video?.likes?.count

        default:
            imPostURL = nil
        }
//        var imPostURL = vkNewsFeeds.items[indexPath.item].attach?[0].photo?.sizes[0].urlImage
//        if (imPostURL == nil) {
//            imPostURL = vkNewsFeeds.items[indexPath.item].attach?[0].video?.image[0].urlImage
//        }


        cell.configate (
            postID: vkNewsFeeds.items[indexPath.item].postID,
            sourceName: sourceName,
            sourceURL: sourceURL,
            datePost: vkNewsFeeds.items[indexPath.item].date,
            textPost: vkNewsFeeds.items[indexPath.item].text,
            imagePostURL: imPostURL,
            likeCount: likeCount,
            selectedLike: userLike,
            commentCount: commentCount
        )
        
                if imPostURL == nil {
                    heightCell = 210
                } else {
                    heightCell = 400
                }
        
        return cell
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         
        return CGFloat(heightCell)
    }
    
}
