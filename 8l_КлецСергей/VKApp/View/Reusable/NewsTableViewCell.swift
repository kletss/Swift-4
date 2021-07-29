//
//  NewsTableViewCell.swift
//  VKApp
//
//  Created by KKK on 19.04.2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
        
    private var heightCell: CGFloat = 210
    private var heightCellFull: CGFloat = 0
    private var isFullTextView: Bool = false
    
    @IBOutlet weak var isFullText: UIButton!
    
    @IBAction func touchFullText(_ sender: Any) {
//        if isFullTextView {
//            viewSize(h: heightCell)
//        } else {
//            viewSize(h: heightCellFull)
//        }
//        isFullTextView = !isFullTextView
    }
    @IBOutlet weak var textPost: UITextView!
//        {
//        didSet {
//            textPost.translatesAutoresizingMaskIntoConstraints = false
//        }
//    }
        
//    func viewSize(h: CGFloat = 0) {
//        let sideW: CGFloat = bounds.width
//        let sideH: CGFloat = h
//        let varSize = CGSize(width: sideW, height: sideH)
//        let varOrigin = CGPoint(x: 0, y:  0)
//        textPost.frame = CGRect(origin: varOrigin, size: varSize)
//
//    }
//
//
//    override func layoutSubviews() {
//            super.layoutSubviews()
//        viewSize(h: heightCell)
//    }
    

    
    func configate(
        textPost: String,
        heightTextPost: CGFloat
    ) {
        self.textPost.text = textPost
        
//        if heightTextPost <= heightCell {
//             heightCell = heightTextPost
//            isFullText.isHidden = true
//        } else {
//            heightCellFull = heightTextPost
//            isFullText.isHidden = false
//        }

    }
    
    
//    @IBOutlet weak var viewBotton: UIView!
//    
//    override class var layerClass: AnyClass {
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = [UIColor.black.cgColor, UIColor.white.cgColor]
//        gradientLayer.locations = [0 as NSNumber, 1 as NSNumber]
//        gradientLayer.startPoint = CGPoint.zero
//        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
//
//        viewBotton.layer.addSublayer(gradientLayer)
//        gradientLayer.frame = viewBotton.bounds
//
//
//        return CAShapeLayer.self
//    }

}
