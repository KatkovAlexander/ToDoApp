import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ListViewModel : ObservableObject {
    
    private let database = Database.database(url: "https://taskmanagerfefu-default-rtdb.asia-southeast1.firebasedatabase.app").reference()
    
    private var user = Auth.auth().currentUser?.uid
    
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
        getItemsFromDb()
        getCategories()
        getCategoriesFromDb()
    }
    
    func getItemsFromDb() {
        print(user ?? "")
        database.child("\(String(describing: user))").child("items").observeSingleEvent(of: .value, with: { snapshot in
            guard
                let db = snapshot.value as? [String: Any]
            
            else {
                return
            }
            for item in db {
                var tmpItem = ItemModel(title: "", text: "", dateToDo: "", deadline: "", isComplited: false, category: "")
                
                if let tmp = item.value as? NSDictionary, let postContent = tmp["title"] as? String {
                    tmpItem.title = postContent
                }
                
                if let tmp = item.value as? NSDictionary, let postContent = tmp["text"] as? String {
                    tmpItem.text = postContent
                }
                
                if let tmp = item.value as? NSDictionary, let postContent = tmp["dateToDo"] as? String {
                    tmpItem.dateToDo = postContent
                }
                
                if let tmp = item.value as? NSDictionary, let postContent = tmp["deadline"] as? String {
                    tmpItem.deadline = postContent
                }
                
                if let tmp = item.value as? NSDictionary, let postContent = tmp["isComplited"] as? Bool {
                    tmpItem.isComplited = postContent
                }
                
                if let tmp = item.value as? NSDictionary, let postContent = tmp["category"] as? String {
                    tmpItem.category = postContent
                }
                if self.items.firstIndex (where: {$0.id == item.key}) != nil {}
                
                else{
                    self.items.append(ItemModel(id: item.key, title: tmpItem.title, text: tmpItem.text, dateToDo: tmpItem.dateToDo, deadline: tmpItem.deadline, isComplited: tmpItem.isComplited, category: tmpItem.category))
                }
            }
        })
        
    }
    
    func getItems(){
        
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else { return }
        
        self.items = savedItems
        
        
    }
    
    func getCategoriesFromDb(){
        database.child("\(String(describing: user))").child("categories").observeSingleEvent(of: .value, with: { snapshot in
            guard
                let db = snapshot.value as? [String: Any]
            
            else {
                return
            }
            for item in db {
                if let tmp = item.value as? NSDictionary, let postContent = tmp["title"] as? String {
                    
                    if self.categories.firstIndex (where: {$0.id == item.key}) != nil {}
                    else {
                        self.categories.append(CategoryModel(id: item.key, title: postContent))
                    }
                }
                
            }
            
        })
    }
    
    func getCategories(){
        
        guard
            let data = UserDefaults.standard.data(forKey: categoriesKey),
            let savedCategories = try? JSONDecoder().decode([CategoryModel].self, from: data)
        else { return }
        
        self.categories = savedCategories
    }
    
    func deleteCategory(indexSet: IndexSet) {
        let item = indexSet.map{self.categories[$0].id}
        database.child("\(String(describing: user))").child("categories").child(item[0]).removeValue()
        
        categories.remove(atOffsets: indexSet)
    }
    
    func deleteItem(indexSet: IndexSet) {
        let item = indexSet.map{self.items[$0].id}
        database.child("\(String(describing: user))").child("items").child(item[0]).removeValue()
        
        items.remove(atOffsets: indexSet)
    }
    
    func deleteItem(item: ItemModel){
        if let index = items.firstIndex (where: {$0.id == item.id}) {
            database.child("\(String(describing: user))").child("items").child(item.id).removeValue()
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
    
    func addItemToDb() {
        if (user != nil) {
            
            for item in items {
                let object : [String: Any] = [
                    "title" : item.title as NSObject,
                    "text" : item.text,
                    "dateToDo" : item.dateToDo,
                    "deadline" : item.deadline,
                    "isComplited" : item.isComplited,
                    "category" : item.category
                ]
                database.child("\(String(describing: user))").child("items").child(item.id).setValue(object)
            }
        }
    }
    
    func saveItems() {
        if let encodededData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodededData, forKey: itemsKey)
        }
        addItemToDb()
    }
    
    func addCategoriesToDb() {
        if (user != nil) {
            
            for category in categories {
                let object : [String: Any] = [
                    "title" : category.title
                ]
                database.child("\(String(describing: user))").child("categories").child(category.id).setValue(object)
            }
            
        }
    }

    func saveCategories() {
        if let encodededData = try? JSONEncoder().encode(categories) {
            UserDefaults.standard.set(encodededData, forKey: categoriesKey)
        }
        addCategoriesToDb()
    }
    
    func allCategories() -> Array<String> {
        var arr : [String] = []
        for category in categories {
            arr.append(category.title)
        }
        
        return arr
    }
    
    func deleteAll() {
        
        for item in items {
            if let index = items.firstIndex (where: {$0.id == item.id}) {
                items.remove(at: index)
            }
        }
        
        for category in categories {
            if let index = categories.firstIndex(where: {$0.id == category.id}) {
                categories.remove(at: index)
            }
        }
        
    }
    
    func updateUser() {
        user = Auth.auth().currentUser?.uid
    }
}
