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
    
    
    var body: some View {
        ZStack {
            if listViewModel.items.isEmpty {
                NoItemView()
            }
            else {
                List {
                    ForEach(listViewModel.items.reversed()) { item in
                        NavigationLink(
                            destination: OpenView(item: item),
                            label: {
                                ListRowView(item: item)
                                
                            })
                        
                    }
                    .onDelete(perform: listViewModel.deleteItem)
                    .onMove(perform: listViewModel.moveItem)
                }
                .listStyle(InsetGroupedListStyle())
                
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
            trailing: EditButton()
        )
        
        
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
