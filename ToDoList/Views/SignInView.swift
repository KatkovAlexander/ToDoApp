//
//  SignInView.swift
//  ToDoList
//
//  Created by Alexander on 01.06.2021.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct SignInView: View {
    @EnvironmentObject var listViewModel: ListViewModel
    
    @State var user = ""
    @State var pass = ""
    @State var message = ""
    @State var alert = false
    @State var show = false
    
    var body : some View {
        let binding = Binding<String>(get: {
            self.user
        }, set: {
            self.user = $0.lowercased()
        })
        
        VStack {
            VStack {
                Text("Sign In").fontWeight(.heavy).font(.largeTitle).padding([.top,.bottom], 20)
                VStack(alignment: .leading){
                    
                    VStack(alignment: .leading) {
                        Text("Email").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                        
                        
                        TextField("Enter Your Email", text: binding)
                            
                        
                        Divider()
                        
                    }.padding(.bottom, 15)
                    
                    VStack(alignment: .leading){
                        Text("Password").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                        
                        SecureField("Enter Your Password", text: $pass)
                        
                        Divider()
                    }
                    
                }.padding(.horizontal, 6)
                
                Button(action: {
                    
                    signInWithEmail(email: self.user, password: self.pass) { (verified, status) in
                        
                        if !verified {

                            self.message = status
                            self.alert.toggle()
                        } else {
                            
                            UserDefaults.standard.set(true, forKey: "status")
                            NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                        }
                    }
                    listViewModel.getItemsFromDb()
                    listViewModel.getCategoriesFromDb()
                    listViewModel.updateUser()
                }) {
                    
                    Text("Sign In").foregroundColor(.white).frame(width: UIScreen.main.bounds.width - 120).padding()

                }.background(Color.accentColor)
                .clipShape(Capsule())
                .padding(.top, 45)
                
            }
            .padding()
            .alert(isPresented: $alert) {
                
                Alert(title: Text("Error"), message: Text(self.message), dismissButton: .default(Text("Ok")))
            
            }
            
            VStack{
                
                HStack(spacing: 8){
                    Text("Don't Have An Account ?").foregroundColor(Color.gray.opacity(0.5))
                    
                    Button(action: {
                        self.show.toggle() 
                    }) {
                        
                        Text("Sign Up")
                        
                    }.foregroundColor(.blue)
                    
                }.padding(.top, 25)
                
            }.sheet(isPresented: $show) {
                
                SignUpView(show: self.$show)
            }
        }
    }
}

func signInWithEmail(email: String,password : String,completion: @escaping (Bool,String)->Void){
    
    Auth.auth().signIn(withEmail: email, password: password) { (res, err) in
        
        if err != nil {
            completion(false,(err?.localizedDescription)!)
            return
        }
        
        completion(true,(res?.user.email)!)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
