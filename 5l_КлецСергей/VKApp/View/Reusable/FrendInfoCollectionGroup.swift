//
//  FrendInfoCollectionGroup.swift
//  VKApp
//
//  Created by KKK on 12.07.2021.
//

import UIKit

class FrendInfoCollectionGroup: UICollectionViewCell {

    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var groupImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
//    func configate(
//        avatarLabel:String,
//        avatarUrl: String,
//        photoService: PhotoService) {
//            groupLabel.text = avatarLabel
//            photoService.getImage(urlString: avatarUrl) { [weak self] image in
//                 DispatchQueue.main.async {
//                    self?.groupImage.image = image
//                 }
//             }
//         }

    
    func configate(
        avatarLabel:String,
        avatar: UIImage) {
            groupLabel.text = avatarLabel
            groupImage.image = avatar
         }
}
