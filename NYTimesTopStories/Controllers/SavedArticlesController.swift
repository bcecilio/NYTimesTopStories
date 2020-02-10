//
//  SavedArticlesController.swift
//  NYTimesTopStories
//
//  Created by Brendon Cecilio on 2/6/20.
//  Copyright © 2020 Brendon Cecilio. All rights reserved.
//

import UIKit
import DataPersistence

class SavedArticlesController: UIViewController {
    
    private let savedView = SavedArticleView()
    
    public var dataPersistence: DataPersistence<Article>!
    
    private var savedArticles = [Article]() {
        didSet{
            savedView.collectionView.reloadData()
            print("there are \(savedArticles.count) articles")
            if savedArticles.isEmpty {
                savedView.collectionView.backgroundView = EmptyView(title: "Saved Articles", message: "There are currently no saved articles. Start browsing by tapping on the News Icon.")
            } else {
                savedView.collectionView.backgroundView = nil
            }
        }
    }
    
    override func loadView() {
        view = savedView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        fetchSavedArticles()
        savedView.collectionView.dataSource = self
        savedView.collectionView.delegate = self
        savedView.collectionView.register(SavedCell.self, forCellWithReuseIdentifier: "savedCell")
    }
    
    private func fetchSavedArticles() {
        do {
            savedArticles = try dataPersistence.loadItems()
        } catch {
            print("error fetch articles: \(error)")
        }
    }
}

extension SavedArticlesController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "savedCell", for: indexPath) as? SavedCell else {
            fatalError("could not downcast")
        }
        let articleInfo = savedArticles[indexPath.row]
        cell.configureCell(for: articleInfo)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let spacingBetweenItems: CGFloat = 10
        let numberOfItems: CGFloat = 2
        let itemHeight:CGFloat = maxSize.height * 0.30
        let totalSpacing: CGFloat = (2 * spacingBetweenItems) + (numberOfItems - 1 ) * spacingBetweenItems
        let itemWidth: CGFloat = (maxSize.width - totalSpacing) / numberOfItems
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let article = savedArticles[indexPath.row]
        let detailVC = ArticleDetailController()
        detailVC.article = article
        detailVC.dataPersistence = dataPersistence
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension SavedArticlesController: DataPersistenceDelegate {
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        fetchSavedArticles()
    }
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        fetchSavedArticles()
    }
}

extension SavedArticlesController: SavedCellDelegate {
    func didSelectMoreButton(_ savedCell: SavedCell, article: Article) {
        print("didSelectMoreButton: \(article.title)")
        // create an action sheet
        // cancel + delete action
        // post MVP
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { alertAction in 
            self.deleteArticle(article)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        present(alertController, animated: true)
    }
    
    private func deleteArticle(_ article: Article) {
        guard let index = savedArticles.firstIndex(of: article) else {
            return
        }
        do {
            try dataPersistence.deleteItem(at: index)
        } catch {
            print("error deleting article: \(error)")
        }
    }
}
