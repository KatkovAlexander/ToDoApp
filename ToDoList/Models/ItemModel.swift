//
//  ItemModel.swift
//  ToDoList
//
//  Created by Alexander on 14.05.2021.
//

import Foundation

struct ItemModel: Identifiable, Codable {
    let id: String
    let title: String
    let text : String
    let dateToDo : String
    let deadline : String
    var isComplited: Bool
    
    init(id: String = UUID().uuidString, title: String, text: String, dateToDo: String, deadline: String, isComplited: Bool) {
        self.id = id
        self.title = title
        self.text = text
        self.dateToDo = dateToDo
        self.deadline = deadline
        self.isComplited = isComplited
    }
    
    func updateCompeletion() -> ItemModel {
        return ItemModel(id: id, title: title, text: text, dateToDo: dateToDo, deadline: deadline, isComplited: !isComplited)
    }
    
    mutating func Compeletion() {
        self.isComplited.toggle()
    }
    
}
