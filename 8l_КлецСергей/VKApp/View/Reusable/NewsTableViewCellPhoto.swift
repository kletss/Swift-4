//
//  NewsTableViewCellPhoto.swift
//  VKApp
//
//  Created by KKK on 30.07.2021.
//

import UIKit

class NewsTableViewCellPhoto: UITableViewCell {

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
//    }
    
    @IBOutlet weak var imagePost: UIImageView!
    
    func configate(

        imagePost:  UIImage?) {

        self.imagePost.image = imagePost

         }
    
}


