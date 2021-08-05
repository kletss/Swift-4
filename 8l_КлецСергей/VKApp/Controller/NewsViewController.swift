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
    
    private var isFullText: Bool = false
    
    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "NewsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "NewsTableViewCell")
        let nibI = UINib(nibName: "NewsTableViewCellPhoto", bundle: nil)
        tableView.register(nibI, forCellReuseIdentifier: "NewsTableViewCellPhoto")
        let nibB = UINib(nibName: "NewsTableViewCellBotton", bundle: nil)
        tableView.register(nibB, forCellReuseIdentifier: "NewsTableViewCellBotton")
        let nibH = UINib(nibName: "NewsTableViewCellHeader", bundle: nil)
        tableView.register(nibH, forCellReuseIdentifier: "NewsTableViewCellHeader")
 

        
        getNews()
        
        makeRefreshControl()

        configPrefitch()
        
    }
    
    
    private func configPrefitch() {
        tableView.prefetchDataSource = self
    }
    
    @objc
    private func refresh() {
        getNews(startTimeNews)
        tableView.refreshControl?.endRefreshing()
    }
    
    private func makeRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self,
                                            action: #selector(refresh),
                                            for: .valueChanged)
 
    }
    private func getNews(_ startTimeNews: String = "" ){
        
//        NetworkService().getNewsFeeds() {
//            [weak self] vkNewsFeeds in self?.vkNewsFeeds = vkNewsFeeds
//           self?.tableView.reloadData()
//         }
        NetworkService().comlexNewsFeeds(start_from: startTimeNews) {
            [weak self] vkNewsFeedsN,vkGroupN,vkProfileN,startTimeNews  in
            guard let self = self else {return}
            print("getnew = ",self.vkNewsFeed.count, vkNewsFeedsN.count )
                self.vkNewsFeed = vkNewsFeedsN + self.vkNewsFeed
                self.vkGroup =  vkGroupN + self.vkGroup
                self.vkProfile =  vkProfileN + self.vkProfile
                self.startTimeNews = startTimeNews
            self.tableView.reloadData()
            
         }
    }
    
    
//    func calculateHeight(inString: String) -> CGFloat {
//        let tableWidth = tableView.bounds.width
//        let attributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15.0)]
//
//        let attributedString = NSAttributedString(string: inString, attributes: attributes)
//
//        let box = CGSize(width: tableWidth, height: CGFloat.greatestFiniteMagnitude)
//        let rect = attributedString.boundingRect(with: box,
//                                                 options: [.usesLineFragmentOrigin,.usesFontLeading,],
//                                                 context: nil)
//
//        return rect.height.rounded(.up) + 20
//    }
    
    func calculateHeight(text: String) -> CGFloat {
        let tableWidth = tableView.bounds.width
        let box = CGSize(width: tableWidth, height: CGFloat.greatestFiniteMagnitude)
        
        let rect = text.boundingRect(with: box,
                                     options: .usesLineFragmentOrigin,
                                     attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15.0)],
                                     context: nil)
        
        return rect.size.height.rounded(.up)
    }
    
//    func getLabelSize(text: String, font: UIFont) -> CGSize {
//            // определяем максимальную ширину текста - это ширина ячейки минус отступы слева и справа
//            let maxWidth = tableView.bounds.width - 20
//            // получаем размеры блока под надпись
//            // используем максимальную ширину и максимально возможную высоту
//            let textBlock = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
//            // получаем прямоугольник под текст в этом блоке и уточняем шрифт
//        let rect = text.boundingRect(with: textBlock, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
//            // получаем ширину блока, переводим её в Double
//            let width = Double(rect.size.width)
//            // получаем высоту блока, переводим её в Double
//            let height = Double(rect.size.height)
//            // получаем размер, при этом округляем значения до большего целого числа
//            let size = CGSize(width: ceil(width), height: ceil(height))
//            return size
//    }
    
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
        return 4
//        return vkNewsFeed.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
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



        let likeCount = vkNewsFeed[idN].likes?.count ?? 0
        let userLike = (vkNewsFeed[idN].likes?.userLikes == 1)
        let commentCount = vkNewsFeed[idN].comments?.count ?? 0
        
        
        var imagePostURL: String?
        
       switch vkNewsFeed[idN].attach?.first?.type {
        case  VKNewsAttachments.CodingKeys.photo.rawValue:
            imagePostURL = vkNewsFeed[idN].attach?.first?.photo?.sizes.last?.urlImage
        case  VKNewsAttachments.CodingKeys.video.rawValue:
            imagePostURL = vkNewsFeed[idN].attach?.first?.video?.image.last?.urlImage
        default:
            
            imagePostURL = ""
        }
        
//        var imPostURL = vkNewsFeeds.items[indexPath.item].attach?[0].photo?.sizes[0].urlImage
//        if (imPostURL == nil) {
//            imPostURL = vkNewsFeeds.items[indexPath.item].attach?[0].video?.image[0].urlImage
//        }
        switch indexPath.row {
        case 0:
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCellHeader", for: indexPath) as? NewsTableViewCellHeader
            else { return UITableViewCell() }
            cell.configate (
                postID: vkNewsFeed[idN].postID,
                sourceName: sourceName,
                sourceAvatar: getImage(sUrl: sourceURL) ?? UIImage(named: "noneAvatarGroup")!,
                datePost: getDateNews(indexPath: indexPath, stampDateTime: vkNewsFeed[idN].date)
            )
            return cell
        case 1:
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell
            else { return UITableViewCell() }

            cell.configate (
                textPost: vkNewsFeed[idN].text ?? "",
                heightTextPost: self.calculateHeight(text: vkNewsFeed[idN].text ?? "") + 5
            )
           return cell

        case 2:
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCellPhoto", for: indexPath) as? NewsTableViewCellPhoto
            else { return UITableViewCell() }

                cell.configate (
                   imagePost: getImage(sUrl: imagePostURL!)
               )
            return cell

        case 3:
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCellBotton", for: indexPath) as? NewsTableViewCellBotton
            else { return UITableViewCell() }
            cell.configate (
                likeCount: likeCount,
                selectedLike: userLike,
                commentCount: commentCount
            )
            return cell
       
        default:
            return UITableViewCell()
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let idN = indexPath.section
        
        switch indexPath.row {
        case 0:
            return 50
        case 1:
            isFullText = false
            var heightRow: CGFloat = 210
            let height: CGFloat = self.calculateHeight(text: vkNewsFeed[idN].text ?? "") + 5
            if heightRow >= height {heightRow = height}
            else {isFullText = true}

            return heightRow
        case 2:
                // Вычисляем высоту
            var aspectRatio: CGFloat = 0
//                let idN = indexPath.section
            switch vkNewsFeed[idN].attach?.first?.type {
                case  VKNewsAttachments.CodingKeys.photo.rawValue:
                     aspectRatio = self.vkNewsFeed[indexPath.section].attach?.first?.photo?.sizes.first?.aspectRatio ?? 0
                case  VKNewsAttachments.CodingKeys.video.rawValue:
                     aspectRatio = self.vkNewsFeed[indexPath.section].attach?.first?.video?.image.first?.aspectRatio ?? 0
            default:
                    aspectRatio = 0
            }
                let tableWidth = tableView.bounds.width
                let cellHeight = tableWidth * aspectRatio
                return cellHeight
            
        case 3:
            return 50
        default:
        // Для всех остальных ячеек оставляем автоматически определяемый размер
                return UITableView.automaticDimension

        }
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        return CGFloat(heightCell)
//    }
 
    private func getDateNews(indexPath: IndexPath, stampDateTime: Double) -> String {
        
        if let date = dateTextCache[indexPath] {
            return date
        } else {
            let date = dateFormatter.string(from: Date(timeIntervalSince1970: stampDateTime))
            dateTextCache[indexPath]  = date
            return date
        }
    }
    
    private func getImage(sUrl: String) -> UIImage? {
        let avatar: UIImage? = nil //UIImage(named: "noneAvatarGroup")!
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
//        self.cancelFetchNews(ofIndex: indexPath.section
//      }
//    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard
            let maxSection = indexPaths.map({ $0.section }).max()
        else {return}
//        print(maxSection, vkNewsFeed.count, self.isLoading )
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
