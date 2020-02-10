//
//  NewsCell.swift
//  NYTimesTopStories
//
//  Created by Brendon Cecilio on 2/7/20.
//  Copyright © 2020 Brendon Cecilio. All rights reserved.
//

import UIKit
import ImageKit

class NewsCell: UICollectionViewCell {
    
    // image view of the article
    // title of article
    //
    public lazy var newsimageView: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        image.image = UIImage(systemName: "photo")
        image.contentMode = .scaleAspectFill
        return image
    }() // a function call - calls when its created
    
    
    private lazy var articleTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.text = "Article Title"
        label.font = UIFont(name: "Georgia-Bold", size: 20)
        return label
    }()
    
    private lazy var abstractHeadline: UILabel = {
        let label = UILabel()
        label.numberOfLines = 4
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.text = "Abstract Headline"
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        label.font = UIFont(name: "HelveticaNeue", size: 15)
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
        setupNewssImageCellConstraints()
        setupTitleConstraits()
        setupAbstractConstraints()
    }
    
    private func setupNewssImageCellConstraints() {
        addSubview(newsimageView)
        newsimageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            newsimageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            newsimageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            newsimageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            newsimageView.widthAnchor.constraint(equalTo: newsimageView.heightAnchor)
        ])
    }
    
    private func setupTitleConstraits() {
        addSubview(articleTitle)
        articleTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            articleTitle.topAnchor.constraint(equalTo: newsimageView.topAnchor),
            articleTitle.leadingAnchor.constraint(equalTo: newsimageView.trailingAnchor, constant: 8),
            articleTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
            // instransic value, knows its height
        ])
    }
    
    private func setupAbstractConstraints() {
        addSubview(abstractHeadline)
        abstractHeadline.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            abstractHeadline.topAnchor.constraint(equalTo: articleTitle.bottomAnchor, constant: 10),
            abstractHeadline.leadingAnchor.constraint(equalTo: articleTitle.leadingAnchor),
            abstractHeadline.trailingAnchor.constraint(equalTo: articleTitle.trailingAnchor)
        ])
        
        
    }
    
    public func configureCell(with article: Article) {
        articleTitle.text = article.title
        abstractHeadline.text = article.abstract
        // image format
        /*
         superJumbo 2048x1365
         thumbLarge 150x150
         */
        newsimageView.getImage(with: article.getArticleImageURL(for: .thumbLarge)) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.newsimageView.image = UIImage(systemName: "exclamationmark-octagon")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.newsimageView.image = image
                    self?.newsimageView.layer.cornerRadius = 7
                }
            }
        }
    }
}
