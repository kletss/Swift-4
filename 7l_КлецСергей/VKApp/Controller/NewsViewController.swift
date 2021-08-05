//
//  NewsViewController.swift
//  VKApp
//
//  Created by KKK on 19.04.2021.
//

import UIKit

class NewsViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource, UIViewControllerTransitioningDelegate {
    
//    var vkNewsFeeds = VKNewsFeeds(items: [],groups: [], profiles: [])
    
    private var  vkNewsFeed = [VKNewsFeed]()
    private var  startTimeNews : String = ""
    private var  vkGroup = [VKGroup]()
    private var  vkProfile = [VKProfile]()
    
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
    
    private var isLoading: Bool = false
    
    private var heightCell = 400.0
    
    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "NewsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "NewsTableViewCell")
        
        getNews()
        
        makeRefreshControl()

        configPrefitch()
        
    }
    
    
    private func configPrefitch() {
        tableView.prefetchDataSource = self
    }
    
    @objc
    private func refresh() {
        getNews()
        tableView.refreshControl?.endRefreshing()
    }
    
    private func makeRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self,
                                            action: #selector(refresh),
                                            for: .valueChanged)
 
    }
    private func getNews(){
        
//        NetworkService().getNewsFeeds() {
//            [weak self] vkNewsFeeds in self?.vkNewsFeeds = vkNewsFeeds
//           self?.tableView.reloadData()
//         }
        NetworkService().comlexNewsFeeds() {
            [weak self] vkNewsFeedsN,vkGroupN,vkProfileN,startTimeNews  in
                self?.vkNewsFeed = vkNewsFeedsN
                self?.vkGroup = vkGroupN
                self?.vkProfile = vkProfileN
                self?.startTimeNews = startTimeNews
            
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections

        print("news=",vkNewsFeed.count)
        return vkNewsFeed.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
//        return vkNewsFeed.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell
        else { return UITableViewCell() }
        
        
        var sourceURL: String
        var sourceName: String
        let idN = indexPath.section
        
        var sourceID = vkNewsFeed[idN].sourceID
        
        sourceName = vkProfile.first(where: {$0.id == sourceID})?.fullName ?? "пусто"
        sourceURL = vkProfile.first(where: {$0.id == sourceID})?.avatarURL ?? ""

        if sourceID < 0 {
            sourceID = -1 * sourceID
            sourceName = vkGroup.first(where: {$0.id == sourceID})?.name ?? "пусто"
            sourceURL = vkGroup.first(where: {$0.id == sourceID})?.avatarURL ?? ""
        }



        let likeCount = vkNewsFeed[idN].likes.count
        let userLike = (vkNewsFeed[idN].likes.userLikes != 0)
        let commentCount = vkNewsFeed[idN].comments.count
        heightCell = 400
        
        var imagePostURL: String?
        
       switch vkNewsFeed[idN].attach?.first?.type {
        case  VKNewsAttachments.CodingKeys.photo.rawValue:
            imagePostURL = vkNewsFeed[idN].attach?.first?.photo?.sizes.first?.urlImage
        case  VKNewsAttachments.CodingKeys.video.rawValue:
            imagePostURL = vkNewsFeed[idN].attach?.first?.video?.image.first?.urlImage
        default:
            heightCell = 210
            imagePostURL = ""
        }
        
//        var imPostURL = vkNewsFeeds.items[indexPath.item].attach?[0].photo?.sizes[0].urlImage
//        if (imPostURL == nil) {
//            imPostURL = vkNewsFeeds.items[indexPath.item].attach?[0].video?.image[0].urlImage
//        }
        
        
        cell.configate (
            postID: vkNewsFeed[idN].postID,
            sourceName: sourceName,
            sourceAvatar: getImage(sUrl: sourceURL),
            datePost: getDateNews(indexPath: indexPath, stampDateTime: vkNewsFeed[idN].date),
            textPost: vkNewsFeed[idN].text,
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
            let date = dateFormatter.string(from: Date(timeIntervalSince1970: vkNewsFeed[indexPath.item].date))
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


extension NewsViewController: UITableViewDataSourcePrefetching {
//    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
//
//      // cancel the task of fetching news from API when user scroll away from them
//      for indexPath in indexPaths {
//        self.cancelFetchNews(ofIndex: indexPath.row)
//      }
//    }
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard
            let maxSection = indexPaths.map({ $0.section }).max()
        else {return}
        print(maxSection, vkNewsFeed.count, self.isLoading )
        if maxSection > vkNewsFeed.count - 3,
        !self.isLoading {
                self.isLoading = true
//
            NetworkService().comlexNewsFeeds(start_from: self.startTimeNews) {
                [weak self] vkNewsFeedN,vkGroupN,vkProfileN,startTimeNews  in
                guard let self = self else {return}
                self.startTimeNews = startTimeNews

                let indexSet = IndexSet(integersIn: self.vkNewsFeed.count ..< self.vkNewsFeed.count + vkNewsFeedN.count)
                
                
                if indexSet.count > 0
                    {
                    self.vkProfile.append(contentsOf: vkProfileN)
                    self
                        .vkGroup.append(contentsOf: vkGroupN)
                    self.vkNewsFeed.append(contentsOf: vkNewsFeedN)

                    
                    self.tableView.beginUpdates()
                    self.tableView.insertSections(
                        indexSet,
                        with: .automatic)
                    self.tableView.endUpdates()
                    self.isLoading = false
                }
             }
            
            
        }
    }
    
    
    
}
