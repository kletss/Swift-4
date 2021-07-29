//
//  FrendInfoCollectionGroup.swift
//  VKApp
//
//  Created by KKK on 12.07.2021.
//

import UIKit

class FrendInfoCollectionGroup: UICollectionViewCell {

    @IBOutlet weak var groupLabel: UILabel!
//    {
//        didSet {
//            groupLabel.translatesAutoresizingMaskIntoConstraints = false
//        }
//    }

    @IBOutlet weak var groupImage: UIImageView!
//    {
//        didSet {
//            groupImage.translatesAutoresizingMaskIntoConstraints = false
//        }
//    }

    func groupImageSize() {
        let sideWH: CGFloat = 70
        let varSize = CGSize(width: sideWH, height: sideWH)
//        let varOrigin = CGPoint(x: bounds.midX - sideWH / 2, y: bounds.midY - sideWH / 2)
        let varOrigin = CGPoint(x: 0, y: 0 )
        groupImage.frame = CGRect(origin: varOrigin, size: varSize)
    }
    
    func groupLabelSize() {
        let sideW: CGFloat = 70
        let sideH: CGFloat = 20
        let varSize = CGSize(width: sideW, height: sideH)
        let varOrigin = CGPoint(x: 0, y: 70)
        groupImage.frame = CGRect(origin: varOrigin, size: varSize)
        
    }
    
    override func layoutSubviews() {
            super.layoutSubviews()
//        groupImageSize()
//        groupLabelSize()
    }
        
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    

    
    func configate(
        avatarLabel:String,
        avatar: UIImage) {
            groupLabel.text = avatarLabel
            groupImage.image = avatar

         }
}
