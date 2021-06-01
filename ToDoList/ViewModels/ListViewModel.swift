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
    
    var categories : [CategoryModel] = []  {
        didSet {
            saveCategories()
        }
    }
    
    let itemsKey : String = "items_list"
    let categoriesKey : String = "groups_list"
    
    init() {
        getItems()
        getCategories()
    }
    
    func getItems(){
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else { return }
        
        self.items = savedItems
    }
    
    func getCategories(){
        guard
            let data = UserDefaults.standard.data(forKey: categoriesKey),
            let savedCategories = try? JSONDecoder().decode([CategoryModel].self, from: data)
        else { return }
        
        self.categories = savedCategories
    }
    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func deleteItem(item: ItemModel){
        if let index = items.firstIndex (where: {$0.id == item.id}) {
            items.remove(at: index)
        }
    }
    
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String, text : String, dateToDo : String, deadline: String, category: String) {
        let newItem = ItemModel(title: title, text: text, dateToDo: dateToDo, deadline: deadline, isComplited: false, category: category)
        items.append(newItem)
    }
    
    func addCategory(title : String){
        let newCategory = CategoryModel(title: title)
        categories.append(newCategory)
    }
    
    func updateItem(item: ItemModel) {
        if let index = items.firstIndex (where: {$0.id == item.id}) {
            items[index] = item.updateCompeletion()
        }
    }
    
    func saveItems() {
        if let encodededData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodededData, forKey: itemsKey)
        }
    }
    
    func saveCategories() {
        if let encodededData = try? JSONEncoder().encode(categories) {
            UserDefaults.standard.set(encodededData, forKey: categoriesKey)
        }
    }
    
    func allCategories() -> Array<String> {
        var arr : [String] = []
        for category in categories {
            arr.append(category.title)
        }
        
        return arr
    }
}
