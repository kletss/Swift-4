//
//  FrendInfoCollectionGroup.swift
//  VKApp
//
//  Created by KKK on 12.07.2021.
//

import UIKit

class FrendInfoCollectionGroup: UICollectionViewCell {

    var avatar: UIImage = UIImage(named: "noneAvatarGroup")!

    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var groupImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func configate(avatarLabel:String, avatarUrl: String) {
        
        guard let url = URL(string: avatarUrl) else { return }
        if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                        self.avatar = image
                }
            }

        groupLabel.text = avatarLabel
        groupImage.image = avatar
    }
}
