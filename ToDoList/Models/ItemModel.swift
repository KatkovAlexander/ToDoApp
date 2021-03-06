//
//  ItemModel.swift
//  ToDoList
//
//  Created by Alexander on 14.05.2021.
//

import Foundation

struct ItemModel: Identifiable, Codable {
    let id: String
    var title: String
    var text : String
    var dateToDo : String
    var deadline : String
    var isComplited: Bool
    var category : String
    
    init(id: String = UUID().uuidString, title: String, text: String, dateToDo: String, deadline: String, isComplited: Bool, category: String) {
        self.id = id
        self.title = title
        self.text = text
        self.dateToDo = dateToDo
        self.deadline = deadline
        self.isComplited = isComplited
        self.category = category
    }
    
    func updateCompeletion() -> ItemModel {
        return ItemModel(id: id, title: title, text: text, dateToDo: dateToDo, deadline: deadline, isComplited: isComplited, category: category)
    }
    
    mutating func Compeletion() {
        self.isComplited.toggle()
    }
    
}
