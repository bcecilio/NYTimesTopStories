//
//  ArticleDetailController.swift
//  NYTimesTopStories
//
//  Created by Brendon Cecilio on 2/7/20.
//  Copyright © 2020 Brendon Cecilio. All rights reserved.
//

import UIKit

class ArticleDetailController: UIViewController {
    
    var article: Article?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .plain, target: self, action: #selector(saveArticleButtonPressed(_:)))
    }
    
    private func updateUI() {
        guard let newsArticle = article else {
            fatalError("did not load article")
        }
        navigationItem.title = newsArticle.title
    }
    
    @objc private func saveArticleButtonPressed(_ sender: UIBarButtonItem) {
        print("save article button pressed")
    }
}
