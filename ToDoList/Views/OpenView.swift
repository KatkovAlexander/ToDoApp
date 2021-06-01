//
//  OpenView.swift
//  ToDoList
//
//  Created by Alexander on 19.05.2021.
//

import SwiftUI


struct OpenView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel : ListViewModel
    
    @State var item : ItemModel
    @State var dateToDo = Date()
    @State var dedline = Date()
    
    @State var alertTitle : String = ""
    @State var showAlert : Bool = false
    
    @State var selection: Int? = nil
    @State private var selectedCategory = 0
    
    init (item: ItemModel){
        _item = State(initialValue: item)
        UITextView.appearance().backgroundColor = .clear
        UIDatePicker.appearance().backgroundColor = .clear
    }
    
    
    var body: some View {
        Form{
            Section{
                ZStack {
                    if item.title.isEmpty{
                        HStack{
                            Text("ToDo Title")
                                .font(.system(size: 17))
                                .foregroundColor(Color(UIColor.placeholderText))
                            
                            
                            Spacer()
                        }
                        .padding(.leading, 17)
                    }
                    
                    TextEditor(text: $item.title)
                        .padding(.leading, 11)
                        .padding(.trailing, 11)
                        .padding(.top, 8)
                        .padding(.bottom, 8)
                    
                }
                .cornerRadius(10)
            }
            Section{
                ZStack {
                    if item.text.isEmpty{
                        HStack{
                            Text("ToDo Text")
                                .font(.system(size: 17))
                                .foregroundColor(Color(UIColor.placeholderText))
                            
                            
                            Spacer()
                        }
                        .padding(.leading, 17)
                    }
                    
                    TextEditor(text: $item.text)
                        .padding(.leading, 11)
                        .padding(.trailing, 11)
                        .padding(.top, 8)
                        .padding(.bottom, 8)
                    
                }
                .cornerRadius(5)
            }
            
            Section{
                HStack{
                    HStack{
                        Image(systemName: "calendar")
                            .foregroundColor(Color(#colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1)))
                        
                        DatePicker("", selection: $dateToDo, in: Date()..., displayedComponents: .date)
                    }
                    .cornerRadius(5)
                    Spacer()
                    Divider()
                    Spacer()
                    HStack{
                        Image(systemName: "flag.fill")
                            .foregroundColor(Color(#colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)))
                        DatePicker("", selection: $dedline, in: Date()..., displayedComponents: .date)
                    }
                    .cornerRadius(5)
                }
            }
            
            Section {
                
                Picker(selection: $selectedCategory, label: Text("Picked group:")) {
                    ForEach(0 ..< makingCategories().count, id: \.self) { category in
                        Text(makingCategories()[category])
                    }
                }

                NavigationLink(
                    destination: CategoryAddView(),
                    tag: 1,
                    selection: $selection)
                {
                    Button(action: {
                        self.selection = 1
                        
                    }, label: {
                        HStack{
                            Image(systemName: "plus")
                            Text("Add an group")
                                .font(.headline)
                                .foregroundColor(Color.accentColor)
                                .padding(4)
                        }
                        
                        .font(.headline)
                        .foregroundColor(Color.accentColor)
                        .padding(4)
                        
                    })
                }
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
        
        .navigationTitle("Add an ToDo")
        .alert(isPresented: $showAlert, content: getAlert)
    }
    
    func makingCategories() -> Array<String>{
        return ["-"] + listViewModel.allCategories()
    }
    
    func saveBtnPressed () {
        if textIsAppropriate() {
            
            listViewModel.deleteItem(item: item)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy MM dd"
            
            listViewModel.addItem(title: item.title, text: item.text, dateToDo: dateFormatter.string(from: dateToDo), deadline: dateFormatter.string(from: dedline), category: makingCategories()[selectedCategory])
            presentationMode.wrappedValue.dismiss()

        }
    }
    
    func textIsAppropriate() -> Bool {
        if (item.title.count < 3){
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

struct OpenView_Previews: PreviewProvider {

    static var item1 = ItemModel(title: "1", text: "1", dateToDo: "1", deadline: "1", isComplited: false, category: "111" )
    
    static var previews: some View {
        NavigationView{
            OpenView(item: item1)
        }
    }
}
