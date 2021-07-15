//
//  FrendCollectionViewCell.swift
//  VKApp
//
//  Created by KKK on 06.04.2021.
//

import UIKit

class FrendCollectionViewCell: UICollectionViewCell {
    
    var avatar: UIImage = UIImage(named: "noneAvatarGroup")!

   @IBOutlet weak var imageView: UIImageView!

    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        imageView.image = nil
//
//    }
//    func configate(frend: UIImage) {
        
    func configate(photoUrl: String) {
        
        guard let url = URL(string: photoUrl) else { return }
        if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                        self.avatar = image
                }
            }

        
        imageView.image = avatar 
    }
    
}
