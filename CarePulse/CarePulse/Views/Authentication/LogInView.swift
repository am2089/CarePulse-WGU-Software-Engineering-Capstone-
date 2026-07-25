//
//  LogInView.swift
//  CarePulse
//
//  Created by Andrew Muniz on 7/16/26.
//

import SwiftUI

struct LogInView: View {
    
    @State private var username = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var isLoggedIn = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing:20) {
                
                Spacer()
                
                Text("CarePulse")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Recovery Record Organizer")
                    .foregroundColor(.gray)
                
                TextField("Username", text: $username)
                    .textFieldStyle(.roundedBorder)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)
                
                VStack{
                    Button {
                        if username.isEmpty || password.isEmpty {
                            errorMessage = "Username and password are required."
                        } else {
                            errorMessage = ""
                            isLoggedIn = true
                        }
                        
                    } label: {
                        Text("Log In")
                            .fontWeight(.bold)
                            .frame(width: 140)
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .tint(.blue)
                    
                    
                    
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .font(.caption)
                            .foregroundStyle(.red)
                    }
                }
                
                NavigationLink{
                    RegisterView()
                } label: {
                    Text("Register")
                }
                
                Spacer()
            }
            .padding()
            .fullScreenCover(isPresented: $isLoggedIn) {
                ContentView()
            }
        }
    }
}

#Preview {
    LogInView()
}
