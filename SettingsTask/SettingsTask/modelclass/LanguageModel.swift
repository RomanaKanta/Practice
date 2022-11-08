//
//  LanguageModel.swift
//  SettingsTask
//
//  Created by Romana on 8/11/22.
//

import Foundation

struct LanguageModel {
    var icon: String
    var title: String
    var isSelected: Bool
    
    init(icon: String, title: String, isSelected: Bool) {
        self.icon = icon
        self.title = title
        self.isSelected = isSelected
    }
}

