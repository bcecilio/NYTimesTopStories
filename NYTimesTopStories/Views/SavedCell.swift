//
//  SavedCell.swift
//  NYTimesTopStories
//
//  Created by Brendon Cecilio on 2/10/20.
//  Copyright © 2020 Brendon Cecilio. All rights reserved.
//

import UIKit

protocol SavedCellDelegate: AnyObject {
    func didSelectMoreButton(_ savedCell: SavedCell, article: Article)
}

class SavedCell: UICollectionViewCell {
    
    private lazy var longPressGesture: UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer()
        gesture.addTarget(self, action: #selector(didLongPress(_:)))
        return gesture
    }()
    
    weak var delegate: SavedCellDelegate?
    
    private var currentArticle: Article!
    
    private lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var articleTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.text = "Article Title Article Title Article Title Article Title"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let IV = UIImageView()
        IV.image = UIImage(systemName: "photo")
        IV.alpha = 0
        IV.contentMode = .scaleAspectFill
        IV.clipsToBounds = true
        return IV
    }()
    
    private var isShowingImage = false
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupButton()
        setupTitle()
        setupImageView()
        addGestureRecognizer(longPressGesture)
    }
    
    @objc private func buttonPressed(_ sender: UIButton) {
        delegate?.didSelectMoreButton(self, article: currentArticle)
    }
    
    @objc private func didLongPress(_ gesture: UILongPressGestureRecognizer) {
        guard let currentArticle = currentArticle else {return}
        if gesture.state == .began || gesture.state == .changed {
            print("long pressed")
            return
        }
        
        isShowingImage.toggle()
        imageView.getImage(with: currentArticle.getArticleImageURL(for: .normal)) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(systemName: "photo")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.imageView.image = image
                    self?.animate()
                }
            }
        }
    }
    
    private func animate() {
        let duration: Double = 0.8
        if isShowingImage {
            UIView.transition(with: self, duration: duration, options: [.transitionFlipFromRight], animations: {
                self.imageView.alpha = 1.0
                self.articleTitle.alpha = 0.0
            }, completion: nil)
        } else {
            UIView.transition(with: self, duration: duration, options: [.transitionFlipFromRight], animations: {
                self.imageView.alpha = 0.0
                self.articleTitle.alpha = 1.0
            }, completion: nil)
        }
    }
    
    private func setupButton() {
        addSubview(moreButton)
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            moreButton.topAnchor.constraint(equalTo: topAnchor),
            moreButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            moreButton.heightAnchor.constraint(equalToConstant: 44),
            moreButton.widthAnchor.constraint(equalTo: moreButton.heightAnchor)
        ])
    }
    
    private func setupTitle() {
        addSubview(articleTitle)
        articleTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            articleTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            articleTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
            articleTitle.topAnchor.constraint(equalTo: moreButton.bottomAnchor),
            articleTitle.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupImageView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: moreButton.bottomAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    public func configureCell(for savedArticle: Article) {
        currentArticle = savedArticle
        articleTitle.text = savedArticle.title
    }
}
