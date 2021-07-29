//
//  GroupsTableViewCell.swift
//  VKApp
//
//  Created by KKK on 18.04.2021.
//

import UIKit

class GroupsTableViewCell: UITableViewCell {
    
    @IBAction func buttonImage(_ sender: Any) {
        let av = AvatarAnimate()
        av.avatarAnimate(self.groupAvatar)
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        groupName.text = nil
        groupAvatar.image = nil
    }
    
    @IBOutlet weak var groupAvatar: UIImageView!
    @IBOutlet weak var groupName: UILabel!
    
    
    func configate(avatar: UIImage, name: String ) {
    
        groupName.text = name
        groupAvatar.image = avatar
    }
    

    
}
