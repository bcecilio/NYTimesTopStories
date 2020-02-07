//
//  ArticleDetailController.swift
//  NYTimesTopStories
//
//  Created by Brendon Cecilio on 2/7/20.
//  Copyright © 2020 Brendon Cecilio. All rights reserved.
//

import UIKit
import ImageKit
import DataPersistence

class ArticleDetailController: UIViewController {
    
    public var article: Article?
    
    private let detailView = ArticleDetailView()
    
    public var dataPersistence: DataPersistence<Article>!
    
    override func loadView() {
        view = detailView
    }

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
        detailView.abstractHeadline.text = newsArticle.abstract
        detailView.newsimageView.getImage(with: newsArticle.getArticleImageURL(for: .superJumbo)) { [weak self] (result) in
            switch result {
            case .failure(_):
                DispatchQueue.main.async {
                    self?.detailView.newsimageView.image = UIImage(systemName: "exclamationmark-octagon")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.detailView.newsimageView.image = image
                }
            }
        }
    }
    
    @objc private func saveArticleButtonPressed(_ sender: UIBarButtonItem) {
        guard let newsArticle = article else {
            return
        }
        do {
            // saved to documents directory
            try dataPersistence.createItem(newsArticle)
        } catch {
            print("error saving itee: \(error)")
        }
    }
}
