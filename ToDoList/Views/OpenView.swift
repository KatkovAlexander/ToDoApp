//
//  OpenView.swift
//  ToDoList
//
//  Created by Alexander on 19.05.2021.
//

import SwiftUI


struct OpenView: View {
    
    let item : ItemModel
    
    var body: some View {
        ScrollView{
            VStack{
                Text(item.dateToDo)
                Text(item.deadline)
                Text(item.text)
            }
        }
        .navigationTitle(item.title)
            
    }
}

struct OpenView_Previews: PreviewProvider {

    static var item1 = ItemModel(title: "1", text: "1", dateToDo: "1", deadline: "1", isComplited: false)
    
    static var previews: some View {
        NavigationView{
            OpenView(item: item1)
        }
    }
}
