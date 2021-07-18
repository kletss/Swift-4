//
//  GroupsTableViewCell.swift
//  VKApp
//
//  Created by KKK on 18.04.2021.
//

import UIKit

class GroupsTableViewCell: UITableViewCell {

    private var avatar: UIImage = UIImage(named: "noneAvatarGroup")!

    let av = AvatarAnimate()
    
    @IBAction func buttonImage(_ sender: Any) {
        av.avatarAnimate(self.groupAvatar)
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        groupName.text = nil
        groupAvatar.image = nil
    }
    
    @IBOutlet weak var groupAvatar: UIImageView!
    @IBOutlet weak var groupName: UILabel!
    
    
    func configate(imageUrl: String, name: String ) {
    
        guard let url = URL(string: imageUrl) else { return }
        if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                        self.avatar = image
                }
            }
        
        groupName.text = name
        groupAvatar.image = avatar
    }
    

    
}
