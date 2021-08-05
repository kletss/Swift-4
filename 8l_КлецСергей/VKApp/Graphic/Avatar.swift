//
//  File.swift
//  VKApp
//
//  Created by KKK on 10.04.2021.
//

import UIKit

 class AvatarImage: UIImageView {
    @IBInspectable var borderColor: UIColor = .gray
    @IBInspectable var borderWidth: CGFloat = 1.5
    @IBInspectable var cornerRadius: CGFloat = 2
    
    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.height / cornerRadius
        self.layer.masksToBounds = true
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
            }
}

class AvatarImageShadow: UIImageView {
   @IBInspectable var borderColor: UIColor = .gray
   @IBInspectable var borderWidth: CGFloat = 2
   
   override func awakeFromNib() {
        self.layer.shadowColor = borderColor.cgColor
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 3
   }
}

class AvatarBackShadow: UIView {
    @IBInspectable var shadowColor: UIColor = .lightGray
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 3, height: 3)
    @IBInspectable var shadowOpacity: Float = 1
    @IBInspectable var shadowRadius: CGFloat = 3
//    @IBInspectable var cornerRadius : CGFloat = 30
    
    override func awakeFromNib() {
        self.backgroundColor = .clear
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
//        self.layer.shadowPath = UIBezierPath(
//            roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
////        self.layer.masksToBounds = true
    }
}



@IBDesignable class UserAvatar: UIView {
    
    var logoView = UIImageView()
    let shadowView = UIView()
    
    @IBInspectable var shadowRadius: CGFloat = 25.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var shadowBlur: CGFloat = 6.0 {
        didSet {
            setNeedsDisplay()
        }
    }


    @IBInspectable var shadowOpacity: Float = 0.3 {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 5) {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable var shadowColor: UIColor = UIColor.black {
        didSet {
            setNeedsDisplay()
        }
    }

    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        logoView.frame = rect
        logoView.layer.cornerRadius =  shadowRadius
        //logoView.layer.masksToBounds = true
        logoView.clipsToBounds = true
        logoView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)

        shadowView.frame = rect
        shadowView.clipsToBounds = false
        shadowView.layer.shadowColor = shadowColor.cgColor
        shadowView.layer.shadowOpacity = shadowOpacity
        shadowView.layer.shadowOffset = shadowOffset
        shadowView.layer.shadowRadius = shadowBlur
        shadowView.layer.shadowPath = UIBezierPath(
            roundedRect: shadowView.bounds,
            cornerRadius: shadowRadius).cgPath
        
        shadowView.addSubview(logoView)
        self.addSubview(shadowView)
    }
    
}

class AvatarAnimate {
    
    func avatarAnimate (_ imageAvatar: UIImageView) {
    UIView.animate(
        withDuration: 0.1,
        delay: 0,
        options: [.curveEaseInOut]
    ) {
//        imageAvatar.transform = CGAffineTransform.identity.scaledBy(x: 0.5, y: 0.5)
        imageAvatar.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
   } completion: {_ in
                UIView.animate(
                    withDuration: 0.5,
                    delay: 0,
                    usingSpringWithDamping: 0.4,
                    initialSpringVelocity: 15,
                    options: [.curveEaseInOut]
                ) {

//                    imageAvatar.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
                    imageAvatar.transform = CGAffineTransform.identity
               }
            }
    }
    
    
}
