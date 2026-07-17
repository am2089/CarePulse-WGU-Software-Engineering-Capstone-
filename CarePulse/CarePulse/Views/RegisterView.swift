//
//  RegisterView.swift
//  CarePulse
//
//  Created by Andrew Muniz on 7/17/26.
//

import SwiftUI

struct RegisterView: View {
    
    @State private var username = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var errorMessage = ""
    
    var body: some View {
        VStack(spacing: 20){
            
            Text("Create Account")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Register to begin organizing your recovery records.")
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
            
            TextField("Username", text: $username)
                .textFieldStyle(.roundedBorder)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
            
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
            
            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(.roundedBorder)
            
            VStack(spacing: 5) {
                Button {
                    if username.isEmpty || password.isEmpty || confirmPassword.isEmpty {
                        errorMessage = "All fields are required."
                    } else if password != confirmPassword {
                        errorMessage = "Passwords do not match"
                    } else {
                        errorMessage = ""
                        
                        
                    }
                } label: {
                    Text("Create Account")
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
            
            Spacer()
            
        }
        .padding()
        .navigationTitle("Register")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack{
        RegisterView()
    }
}
