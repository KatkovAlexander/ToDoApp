//
//  ListViewModel.swift
//  ToDoList
//
//  Created by Alexander on 14.05.2021.
//

import Foundation

class ListViewModel : ObservableObject {
    
    @Published var items : [ItemModel] = [] {
        didSet {
            saveItems()
        }
    }
    
    let itemsKey : String = "items_list"
    
    init() {
        getItems()
    }
    
    func getItems(){
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else { return }
        
        self.items = savedItems
    }
    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String, text : String, dateToDo : String, deadline: String) {
        let newItem = ItemModel(title: title, text: text, dateToDo: dateToDo, deadline: deadline, isComplited: false)
        items.append(newItem)
    }
    
    func updateItem(item: ItemModel) {
        if let index = items.firstIndex (where: {$0.id == item.id}) {
            items[index] = item.updateCompeletion()
        }
    }
    
    func saveItems() {
        if let encodedeData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedeData, forKey: itemsKey)
        }
    }
}
