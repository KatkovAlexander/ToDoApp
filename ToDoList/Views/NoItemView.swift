//
//  NoItemView.swift
//  ToDoList
//
//  Created by Alexander on 15.05.2021.
//

import SwiftUI

struct NoItemView: View {
    var body: some View {
        ScrollView{
            VStack (spacing: 20) {
                Text("There are no items!")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(.semibold)
//                    .padding(.bottom, 20)
                Text("Press the button to start your ToDo List!")
                NavigationLink(
                    destination: AddView(),
                    label: {
                        Text("Add new task")
                            .foregroundColor(.white)
                            .font(.headline)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.accentColor)
                            .cornerRadius(10)
                    })
                    .padding(.horizontal, 35)
            }
            .frame(maxWidth: 400)
            .multilineTextAlignment(.center)
            .padding(40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct NoItemView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            NoItemView()
        }
    }
}
