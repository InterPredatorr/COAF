//
//  LoginView.swift
//  iosApp
//
//  Created by Sevak Tadevosyan on 05.05.24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import GoogleSignInSwift
import GoogleSignIn

struct LoginView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    let onLogIn: () -> Void
    init(onLogIn: @escaping () -> Void) {
        self.onLogIn = onLogIn
    }
    
    var body: some View {
        VStack {
            Image(.coafMain)
                .resizable()
                .scaledToFit()
                .padding()
            Spacer()
            CardView {
                HStack {
                    GoogleSignInButton(style: .icon, action: onLogIn)
                        .clipShape(.rect(cornerRadius: 12))
                    Spacer()
                    Text("Continue with Google")
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.horizontal)
                .onTapGesture {
                    onLogIn()
                }
            }
            .padding(.horizontal)
            Spacer()
        }
    }
    
    func signIn() {
        
    }
}
