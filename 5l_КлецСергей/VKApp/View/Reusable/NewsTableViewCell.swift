//
//  NewsTableViewCell.swift
//  VKApp
//
//  Created by KKK on 19.04.2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var commentController: CommentsController!
    @IBOutlet weak var likeController: LikeController!
    
    @IBOutlet weak var datePost: UILabel!
    @IBOutlet weak var headPost: UILabel!
    @IBOutlet weak var frendAvatar: UIImageView!
    @IBOutlet weak var postID: UILabel!
    @IBOutlet weak var textPost: UITextView!
    @IBOutlet weak var textFullPost: UITextView!
    @IBOutlet weak var imagePost: UIImageView!
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        self.frendAvatar.image = nil
//        self.frendFIO.text = nil
//        self.datePost.text = nil
//        self.textPost = nil
//        self.textFullPost = nil
//        self.imagePost = nil
//        self.headPost = nil
//
//    }
    

    public func getImage(sUrl: String) -> UIImage {
        var avatar: UIImage = UIImage(named: "noneAvatarGroup")!
        guard let url = URL(string: sUrl) else { return avatar}
        if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    avatar = image
                }
            }
        return avatar
    }
    
    func configate(
        postID: Int,
                sourceName: String,
                sourceURL: String,
                datePost: Double,
                textPost: String,
                imagePostURL: String?,
                likeCount: Int,
                selectedLike: Bool,
                commentCount: Int
    ) {
        
        
        
        likeController.likeCount = likeCount
        likeController.selectedLike = selectedLike
         
        commentController.commentsCount = commentCount
 
        self.frendAvatar.image = getImage(sUrl: sourceURL)
//        self.frendFIO.text = frend.fullname
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd-MM-YYYY HH:MM"
        
        let date = dateFormat.string(from: Date(timeIntervalSince1970: datePost))
        
        self.postID.text = String(postID)
        self.datePost.text = date
        self.headPost.text = sourceName
        self.textPost.isHidden = true
        self.textFullPost.isHidden = true
        self.imagePost.isHidden = true
        
        if !(imagePostURL?.isEmpty ?? true) {
            self.textPost.text = textPost
            self.textPost.isHidden = false
            self.imagePost.image = getImage(sUrl: imagePostURL!)
            self.imagePost.isHidden = false
        } else {
            self.textFullPost.isHidden = false
            self.textFullPost.text = textPost
        }
        
    }
    
    
//    @IBOutlet weak var viewBotton: UIView!
//    
//    override class var layerClass: AnyClass {
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = [UIColor.black.cgColor, UIColor.white.cgColor]
//        gradientLayer.locations = [0 as NSNumber, 1 as NSNumber]
//        gradientLayer.startPoint = CGPoint.zero
//        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
//
//        viewBotton.layer.addSublayer(gradientLayer)
//        gradientLayer.frame = viewBotton.bounds
//
//
//        return CAShapeLayer.self
//    }

}
