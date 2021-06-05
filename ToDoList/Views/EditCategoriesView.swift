//
//  EditCategoriesView.swift
//  ToDoList
//
//  Created by Alexander on 05.06.2021.
//

import SwiftUI

struct EditCategoriesView: View {
    @EnvironmentObject var listViewModel: ListViewModel
    
    var body: some View {
        Form{
            Section{
                HStack{
                    Text("Swipe left to delete")
                    Spacer()
                }
                .listRowInsets(.init())
                .frame(height: 50)
                .background(Color(UIColor.secondarySystemBackground))
                    
            }
            
            Section{
                ForEach(listViewModel.categories){ category in
                    Text(category.title)
                        .padding()
                }
                .onDelete(perform: listViewModel.deleteCategory)
            }
        }
        .navigationTitle("Delete Categories")
    }
    
}

struct EditCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        EditCategoriesView()
    }
}
