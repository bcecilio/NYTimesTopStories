//
//  SettingsController.swift
//  NYTimesTopStories
//
//  Created by Brendon Cecilio on 2/6/20.
//  Copyright © 2020 Brendon Cecilio. All rights reserved.
//

import UIKit

struct UserKey {
    static let newsSection = "News Section"
}

class SettingsController: UIViewController {
    
    private let settingsView = SettingsView()
    
    private let sections = ["Arts", "Automobiles", "Books", "Business", "Fashion", "Food", "Health", "Insider", "Magazine", "Movies", "NYRegion", "Obituaries", "Opinion", "Politics", "RealEstate", "Science", "Sports", "SundayReview", "Technology", "Theater", "T-Magazine", "Travel", "Upshot", "US", "World"].sorted()
    
    override func loadView() {
        view = settingsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        settingsView.pickerView.dataSource = self
        settingsView.pickerView.delegate = self
    }
}

extension SettingsController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sections.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sections[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // store the current selected news section in the user defaults
        let sectionName = sections[row]
        UserDefaults.standard.set(sectionName, forKey: UserKey.newsSection)
    }
}
