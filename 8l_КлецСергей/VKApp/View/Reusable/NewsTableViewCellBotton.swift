//
//  NewsTableViewCellBotton.swift
//  VKApp
//
//  Created by KKK on 01.08.2021.
//

import UIKit

class NewsTableViewCellBotton: UITableViewCell {

    @IBOutlet weak var likeController: LikeController!
    @IBOutlet weak var commentController: CommentsController!
    //    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    
    func configate(

                likeCount: Int,
                selectedLike: Bool,
                commentCount: Int
    ) {
        
        likeController.likeCount = likeCount
        likeController.selectedLike = selectedLike
         
        commentController.commentsCount = commentCount
 
    }
}
