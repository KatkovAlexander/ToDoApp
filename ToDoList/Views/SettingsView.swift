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
    
    var body: some View {
        Form {
            Section {
                NavigationLink(
                    destination: EditCategoriesView(),
                    tag: 1,
                    selection: $editCategories)
                {
                
                        Text("Delete Categories")
                    
                    
                }
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
        .navigationTitle("Settings")
    }
    
    func logOut() {
//        ListView.init(settings: nil)
        listViewModel.deleteAll()
        UserDefaults.standard.set(false, forKey: "status")
        NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}



struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
