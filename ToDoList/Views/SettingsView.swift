//
//  SettingsView.swift
//  ToDoList
//
//  Created by Alexander on 05.06.2021.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct SettingsView: View {
    @EnvironmentObject var listViewModel: ListViewModel
    @State var editCategories: Int? = nil
    
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var selectedCategory : Int
    @Binding var settings : Bool
    @State var selection: Bool = false
    
    var body: some View {
        Form {
            if !selection {
                Section {
                    
                    
                    Button(action: {
                        self.selection.toggle()
                    }, label: {
                        Text("Delete categories")
                    })
                    
                    
                    
                }
                
                Section {
                    Button(action: logOut) {
                        HStack {
                            Spacer()
                            Text("Log Out")
                                .font(.headline)
                                .foregroundColor(.white)
                            Spacer()
                        }
                    }
                    .listRowInsets(.init())
                    .frame(height: 50)
                    .background(Color.red)
                    .cornerRadius(5)
                }
            }
            else {
                Section{
                    HStack{
                        Text("Swipe left to delete")
                        Spacer()
                    }
                    .listRowInsets(.init())
                    .frame(height: 50)
                    .background(Color(colorScheme == .dark ? UIColor.systemBackground : UIColor.secondarySystemBackground))
                        
                }
                
                Section{
                    ForEach(listViewModel.categories){ category in
                        Text(category.title)
                            .padding()
                    }
                    .onDelete(perform: deletingCategory)
                }
                
            }
        }
        .navigationTitle(selection ? "Deleting categories" : "Settings")
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarLeading){
                
                Button(action: {
                    if !selection {
                        self.settings.toggle()
                    }
                    else {
                        self.selection.toggle()
                    }
                    
                }, label: {
                    Text(selection ? "Back" : "Close")
                })
                    
                
            }
        })
    }
    
    func logOut() {
        listViewModel.deleteAll()
        UserDefaults.standard.set(false, forKey: "status")
        NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        self.settings.toggle()
    }
    
    func deletingCategory(at offsets: IndexSet) {
        listViewModel.deleteCategory(indexSet: offsets)
        selectedCategory = 0
    }
}


