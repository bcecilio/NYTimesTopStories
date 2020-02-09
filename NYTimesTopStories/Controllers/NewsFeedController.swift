//
//  NewsFeedController.swift
//  NYTimesTopStories
//
//  Created by Brendon Cecilio on 2/6/20.
//  Copyright © 2020 Brendon Cecilio. All rights reserved.
//

import UIKit
import DataPersistence

class NewsFeedController: UIViewController {
    
    private let newsFeed = NewsFeedView()
    
    public var dataPersistence: DataPersistence<Article>!
    
    private var newsArticles = [Article]() {
        didSet {
            DispatchQueue.main.async {
                self.newsFeed.collectionView.reloadData()
            }
        }
    }
    
    override func loadView() {
        view = newsFeed
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Fake But Real News"
        newsFeed.collectionView.delegate = self
        newsFeed.collectionView.dataSource = self
        newsFeed.collectionView.register(NewsCell.self, forCellWithReuseIdentifier: "newsCell")
        getStories()
    }
    
    private func getStories(for section: String = "Technology") {
        TopStoriesAPIClient.fetchTopStories(for: section) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
            case .success(let articles):
                self?.newsArticles = articles
            }
        }
    }
    
//    private func convertDateFormater(date: String) -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
//        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
//
//        guard let date = dateFormatter.date(from: date) else {
//            assert(false, "no date from string")
//            return ""
//        }
//
//        dateFormatter.dateFormat = "yyyy MMM EEEE HH:mm"
//        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
//        let timeStamp = dateFormatter.string(from: date)
//
//        return timeStamp
//    }
}

extension NewsFeedController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath) as? NewsCell else  {
            fatalError("could not downcast to NewsCell")
        }
        let article = newsArticles[indexPath.row]
        cell.configureCell(with: article)
        cell.alpha = 5
        cell.backgroundColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemHeight: CGFloat = maxSize.height * 0.20
        let itemWidth: CGFloat = maxSize.width
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let article = newsArticles[indexPath.row]
        let detailVC = ArticleDetailController()
        detailVC.article = article
        detailVC.dataPersistence = dataPersistence
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
