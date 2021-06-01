//
//  CategoryAddView.swift
//  ToDoList
//
//  Created by Alexander on 31.05.2021.
//

import SwiftUI

struct CategoryAddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel : ListViewModel
    
    @State var title : String = ""
    
    @State var alertTitle : String = ""
    @State var showAlert : Bool = false
    
    var body: some View {
        Form{
            Section{
                ZStack {
                    if title.isEmpty{
                        HStack{
                            Text("Category name")
                                .font(.system(size: 17))
                                .foregroundColor(Color(UIColor.placeholderText))
                            
                            
                            Spacer()
                        }
                        .padding(.leading, 17)
                    }
                    
                    TextEditor(text: $title)
                        .padding(.leading, 11)
                        .padding(.trailing, 11)
                        .padding(.top, 8)
                        .padding(.bottom, 8)
                    
                }
                .cornerRadius(10)
            }
            
            Section {
                Button(action: saveBtnPressed) {
                    HStack {
                        Spacer()
                        Text("Save")
                            .font(.headline)
                            .foregroundColor(.white)
                        Spacer()
                    }
                }
                .listRowInsets(.init())
                .frame(height: 50)
                .background(Color.blue)
                .cornerRadius(5)
            }
        }
        .navigationTitle("Add an category")
        .alert(isPresented: $showAlert, content: getAlert)
    }
    
    func saveBtnPressed () {
        if textIsAppropriate() {
                        
            listViewModel.addCategory(title: title)
            presentationMode.wrappedValue.dismiss()

        }
    }
    
    func textIsAppropriate() -> Bool {
        if (title.count < 3){
            alertTitle = "note length must be more than 3 characters"
            showAlert.toggle()
            return false
        }
        return true
    }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }
}

struct CategoryAddView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryAddView()
    }
}
