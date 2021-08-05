//
//  LikeController.swift
//  VKApp
//
//  Created by KKK on 11.04.2021.
//

import UIKit

@IBDesignable
class LikeController: UIControl {

    var likeCount: Int = 0

    
    var selectedLike = false {
        didSet {
            updateSelectedLike()
            sendActions(for: .valueChanged)
        }
    }
    
    private var likeButtons: [UIButton] = []
    private var likeCounts: [UILabel] = []
    
    private var stackView: UIStackView!
    
    
    private func setupControl() {

        let button = UIButton(type: .custom)
        
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        button.setImage(UIImage(named: "heart_nil"), for: .normal)
        button.setImage(UIImage(named: "heart_like"), for: .selected)
//        button.setTitle(String(countLike), for: .normal)

        button.setTitleColor(.lightGray, for: .normal)
//        button.setTitleColor(.yellow, for: .selected)
        
      button.addTarget(self, action: #selector(selectLike(_:)), for: .touchUpInside)

        likeButtons.append(button)
        
        let label = UILabel()
        label.textColor = .black
        label.font = label.font.withSize(17)
        
        label.text = String(likeCount)
        likeCounts.append(label)
        

        stackView = UIStackView(arrangedSubviews: likeButtons + likeCounts)

        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.alignment = .bottom
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
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
        likeButtons.forEach { button in
            button.isSelected = selectedLike
        }
        likeCounts.forEach { label in
            label.text = String(likeCount)
        }
        
//        for (_, button) in likeButtons.enumerated() {
//          button.isSelected = selectedLike
//        }
//        for (_, label) in likeCounts.enumerated() {
//          label.text = String(likeCount)
//        }
    }
    
    
    @objc private func selectLike(_ sender: UIButton) {
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: [.curveEaseInOut]
        ) {
            sender.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        }

        
        
        if selectedLike {
            likeCount -= 1
            selectedLike = false
        } else {
            likeCount += 1
            selectedLike = true
        }

        
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: [.curveEaseInOut]
        ) {

            sender.transform = CGAffineTransform.identity
       }
        
    }
    
    
}
