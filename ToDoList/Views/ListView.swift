//
//  ListView.swift
//  ToDoList
//
//  Created by Alexander on 14.05.2021.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    @State var selection: Int? = nil
    @State var settings = false
    
    var categories : [String] = ["All"]
    @State private var selectedCategory = 0
    
    var body: some View {

        ZStack {
            Color(UIColor.secondarySystemBackground)
                .ignoresSafeArea()
            
            if listViewModel.items.isEmpty {
                NoItemView()
            }
            else {
                Form {
                    Section{
                        Picker(selection: $selectedCategory, label: Text("Picked group:")) {
                            ForEach(0 ..< makingCategories().count, id: \.self) { category in
                                Text(makingCategories()[category])
                            }
                        }
                    }
                    
                    Section{
                        ForEach(listViewModel.items) { item in
                            if cheackItem(item: item){
                                NavigationLink(
                                    destination: OpenView(item: item),
                                    label: {
                                        ListRowView(item: item)
                                        
                                    })
                            }
                        }
                        .onDelete(perform: listViewModel.deleteItem)
                        .onMove(perform: listViewModel.moveItem)
                    }
                }.sheet(isPresented: $settings){
                        NavigationView{
                            SettingsView(settings: self.$settings)
                        }
                    }
                
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        NavigationLink(
                            destination: AddView(),
                            tag: 1,
                            selection: $selection)
                        {
                            Button(action: {
                                self.selection = 1
                                
                            }, label: {
                                Image(systemName: "plus")
                                    .font(.system(.largeTitle))
                                    .foregroundColor(Color.white)
                                    .padding()
                                
                            })
                            .background(Color.accentColor)
                            .cornerRadius(38.5)
                            .padding()
                            .shadow(color: Color.black.opacity(0.3),
                                    radius: 3,
                                    x: 3,
                                    y: 3
                            )
                        }
                        
                    }
                    
                }
            }
            
        }
        
        .listStyle(PlainListStyle())
        .navigationTitle("ToDo List")
        .navigationBarItems(
            leading: EditButton()
        )
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing){
                
                Button(action: {
                    self.settings.toggle()
                    
                }, label: {
                    Image(systemName: "gearshape.2.fill")
                })
                    
                
            }
        })
    
        
        
    }
    func makingCategories() -> Array<String>{
        return ["All"] + listViewModel.allCategories() + ["Complited"]
    }
    
    func cheackItem(item: ItemModel) -> Bool {
        
        if makingCategories()[selectedCategory] == "All" && item.isComplited == false {
            return true
        }
        else if makingCategories()[selectedCategory] == "Complited" && item.isComplited == true {
            return true
        }
        else if item.category == makingCategories()[selectedCategory] && item.isComplited == false {
            return true
        }

        return false
    }
    
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListView()
        }
        .environmentObject(ListViewModel())
    }
}
