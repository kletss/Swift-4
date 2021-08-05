//
//  NewsTableViewCellHeader.swift
//  VKApp
//
//  Created by KKK on 02.08.2021.
//

import UIKit

class NewsTableViewCellHeader: UITableViewCell {

    
    @IBOutlet weak var datePost: UILabel!
    @IBOutlet weak var headPost: UILabel!
    @IBOutlet weak var frendAvatar: UIImageView!
    @IBOutlet weak var postID: UILabel!
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
        postID: Int,
                sourceName: String,
                sourceAvatar: UIImage,
                datePost: String
    ) {
        self.frendAvatar.image = sourceAvatar
        self.postID.text = String(postID)
        self.datePost.text = datePost
        self.headPost.text = sourceName
    }
}
