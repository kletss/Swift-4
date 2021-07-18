//
//  FrendsController.swift
//  VKApp
//
//  Created by KKK on 13.04.2021.
//

import UIKit

class FrendsController: UIControl {
 
    
    var letters: [Character] = [
        "A", "B", "C"
    ]
  
    
    
    lazy var selectedLike = letters[0] {
        didSet {
            updateSelectedLike()
            sendActions(for: .valueChanged)
        }
    }
    
    
    private var buttons: [UIButton] = []
//    private var labels: [UILabel] = []
    
    private var stackView: UIStackView!
    
    
    private func setupControl() {
        letters.forEach { Letters in
            
            let button = UIButton(type: .custom)
            button.setTitle(String(Letters), for: .normal)

            button.setTitleColor(.black, for: .normal)
            button.setTitleColor(.blue, for: .selected)
           button.addTarget(self, action: #selector(selectLike(_:)), for: .touchUpInside)

            buttons.append(button)
            
//            let label = UILabel()
//            label.text = Letters.rawValue
//            labels.append(label)
        
        }
        stackView = UIStackView(arrangedSubviews: buttons)

//        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }

//    override init( frame: CGRect) {
//        super.init(frame: frame)
//        setupControl()
//    }
    
    init(letters: [Character], frame: CGRect) {
        super.init(frame: frame)
        self.letters = letters
        setupControl()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupControl()
    }
    
//    private func updateSelectedLike() {
//         for (index, button) in self.buttons.enumerated() {
//            guard let day = letters![index] else { continue }
//             button.isSelected = day == self.selectedLike
//         }
//     }
    
    private func updateSelectedLike() {
        buttons.forEach { button in
            button.isSelected = button.title(for: []) == String(selectedLike)
        }
    }
    
    
    
//    @objc private func selectLike(_ sender: UIButton) {
//      //  guard let day = letters(rawValue: sender.title(for: [])!) else { return }
//        self.selectedLike = letters[0]
//
//    }
    
    
    @objc private func selectLike(_ sender: UIButton) {
        guard let index = self.buttons.firstIndex(of: sender) else { return }
        let letter = letters[index]
        self.selectedLike = letter
    }
    
}



class MyCustomHeader: UITableViewHeaderFooterView {
    let title = UILabel()
    let image = UIImageView()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureContents()
    }
    
    func configureContents() {
        image.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(image)
        contentView.addSubview(title)

        // Center the image vertically and place it near the leading
        // edge of the view. Constrain its width and height to 50 points.
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            image.widthAnchor.constraint(equalToConstant: 50),
            image.heightAnchor.constraint(equalToConstant: 50),
            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        
            // Center the label vertically, and use it to fill the remaining
            // space in the header view.
            title.heightAnchor.constraint(equalToConstant: 30),
            title.leadingAnchor.constraint(equalTo: image.trailingAnchor,
                   constant: 8),
            title.trailingAnchor.constraint(equalTo:
                   contentView.layoutMarginsGuide.trailingAnchor),
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
