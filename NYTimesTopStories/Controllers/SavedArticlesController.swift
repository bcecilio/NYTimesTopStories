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
    
    public var dataPersistence: DataPersistence<Article>!
    
    private var savedArticles = [Article]() {
        didSet{
            print("there are \(savedArticles.count) articles")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        fetchSavedArticles()
    }
    
    private func fetchSavedArticles() {
        do {
            savedArticles = try dataPersistence.loadItems()
        } catch {
            print("error fetch articles: \(error)")
        }
    }
}

extension SavedArticlesController: DataPersistenceDelegate {
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        print("item was saved")
    }
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        print("item was deleted")
    }
}
