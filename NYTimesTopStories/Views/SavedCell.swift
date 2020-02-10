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
    }
    
    @objc private func buttonPressed(_ sender: UIButton) {
        delegate?.didSelectMoreButton(self, article: currentArticle)
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
    
    public func configureCell(for savedArticle: Article) {
        currentArticle = savedArticle
        articleTitle.text = savedArticle.title
    }
}
