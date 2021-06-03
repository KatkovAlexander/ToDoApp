//
//  ContentView.swift
//  123213
//
//  Created by Alexander on 01.06.2021.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ContentView: View {
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    var body: some View {
        
        VStack {
            if status {
                NavigationView{
                    ListView()
                }
                .navigationViewStyle(StackNavigationViewStyle())
                .environmentObject(listViewModel)
            }
            else {
                SignInView()
            }
        }
        .animation(.spring())
        .onAppear {
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name("statusChange"), object: nil, queue: .main) { (_) in
                
                let status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                self.status = status
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
