//
//  CommentsControllet.swift
//  VKApp
//
//  Created by KKK on 07.07.2021.
//

import UIKit

class CommentsController: UIControl {

    var commentsCount: Int = 0 {
        didSet {
            updateSelectedLike()
            sendActions(for: .valueChanged)
        }
    }


    private var commentsImage: [UIImageView] = []
    private var commentsCounts: [UILabel] = []
    
    private var stackView: UIStackView!
    
    
    private func setupControl() {

        let button = UIImageView()
        
        button.image = UIImage(named: "comment")

        commentsImage.append(button)
        
        let label = UILabel()
        label.textColor = .black
        label.font = label.font.withSize(20)
        
        label.text = String(commentsCount)
        commentsCounts.append(label)
        
    

        stackView = UIStackView(arrangedSubviews:  commentsImage + commentsCounts)

        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.alignment = .bottom
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
        
//        let borderColor: UIColor = .gray
//        let borderWidth: CGFloat = 1.5
//        let borderRouding: CGFloat = 3
//
//        self.layer.cornerRadius = self.frame.height / borderRouding
//        self.layer.masksToBounds = true
//        self.layer.borderWidth = borderWidth
//        self.layer.borderColor = borderColor.cgColor
        
    }

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupControl()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupControl()
    }
    
    private func updateSelectedLike() {

        commentsCounts.forEach { label in
            label.text = String(commentsCount)
        }

    }
    
    


    
    
}

