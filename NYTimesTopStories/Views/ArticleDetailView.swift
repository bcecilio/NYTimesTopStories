//
//  ArticleDetailView.swift
//  NYTimesTopStories
//
//  Created by Brendon Cecilio on 2/7/20.
//  Copyright © 2020 Brendon Cecilio. All rights reserved.
//

import UIKit

class ArticleDetailView: UIView {
    
    // image view
    // abstract headline
    // byline
    // date
    
    public lazy var newsimageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "photo")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    public lazy var abstractHeadline: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.text = "Abstract Headline"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupAbstractHeadline()
        setupNewsImage()
    }
    
    private func setupNewsImage() {
        addSubview(newsimageView)
        newsimageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newsimageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            newsimageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            newsimageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            newsimageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.40)
        ])
    }
    
    private func setupAbstractHeadline() {
        
    }
}
