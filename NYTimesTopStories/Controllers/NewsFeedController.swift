//
//  NewsFeedController.swift
//  NYTimesTopStories
//
//  Created by Brendon Cecilio on 2/6/20.
//  Copyright © 2020 Brendon Cecilio. All rights reserved.
//

import UIKit

class NewsFeedController: UIViewController {
    
    private let newsFeed = NewsFeedView()
    
    override func loadView() {
        view = newsFeed
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        newsFeed.collectionView.delegate = self
        newsFeed.collectionView.dataSource = self
        newsFeed.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "newsCell")
    }
}

extension NewsFeedController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath)
        cell.backgroundColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemHeight: CGFloat = maxSize.height * 0.30
        let itemWidth: CGFloat = maxSize.width
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
