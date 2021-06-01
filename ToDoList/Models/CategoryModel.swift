//
//  CatecoryModel.swift
//  ToDoList
//
//  Created by Alexander on 30.05.2021.
//

import Foundation

struct CategoryModel: Identifiable, Codable {
    let id : String
    let title : String
    
    init(id: String = UUID().uuidString, title: String) {
        self.id = id
        self.title = title
    }
    
}
