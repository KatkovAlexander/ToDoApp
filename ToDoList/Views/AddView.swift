//
//  AddView.swift
//  ToDoList
//
//  Created by Alexander on 14.05.2021.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel : ListViewModel
    
    @State var titleFieldText : String = ""
    @State var textTextEditor : String = ""
    @State var dateToDo = Date()
    @State var dedline = Date()
    
    @State var alertTitle : String = ""
    @State var showAlert : Bool = false
    
    init() {
        UITextView.appearance().backgroundColor = .clear
        UIDatePicker.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ScrollView{
            VStack (spacing: 14) {
                TextField("ToDo Title", text: $titleFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                
                ZStack {
                    if textTextEditor.isEmpty{
                        HStack{
                            Text("ToDo Text")
                                .font(.system(size: 17))
                                .foregroundColor(Color(UIColor.placeholderText))
                                

                            Spacer()
                        }
                        .padding(.leading, 17)
                    }
                        
                    TextEditor(text: $textTextEditor)
                        .padding(.leading, 11)
                        .padding(.trailing, 11)
                        .padding(.top, 8)
                        .padding(.bottom, 8)
                        
                }
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
                
                HStack(spacing: 30){
                    HStack{
                        Image(systemName: "calendar")
                            .foregroundColor(Color(#colorLiteral(red: 0.8321695924, green: 0.985483706, blue: 0.4733308554, alpha: 1)))
                        
                        DatePicker("", selection: $dateToDo, in: Date()..., displayedComponents: .date)
                    }
                    .padding(.leading, 10)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(5)
                    
                    HStack{
                        Image(systemName: "flag.fill")
                            .foregroundColor(Color(#colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)))
                        DatePicker("", selection: $dedline, in: Date()..., displayedComponents: .date)
                    }
                    .padding(.leading, 10)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(5)
                }
//                .padding(.top, 10)
                
            }
            .padding(14)
            .frame(maxWidth: .infinity)
            
            
            Button(action: saveBtnPressed, label: {
                Text("Save")
                    .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                    .font(.headline)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .cornerRadius(5)
                    .padding()
            })
        }
        .navigationTitle("Add an Item")
        .alert(isPresented: $showAlert, content: getAlert)
    }
    
    func saveBtnPressed () {
        if textIsAppropriate() {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy MM dd"
            
            listViewModel.addItem(title: titleFieldText, text: textTextEditor, dateToDo: dateFormatter.string(from: dateToDo), deadline: dateFormatter.string(from: dedline))
            presentationMode.wrappedValue.dismiss()

        }
    }
    
    func textIsAppropriate() -> Bool {
        if (titleFieldText.count < 3){
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

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AddView()
        }
        .environmentObject(ListViewModel())
    }
}
