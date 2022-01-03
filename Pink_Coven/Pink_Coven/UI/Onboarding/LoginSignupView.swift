//
//  LoginSignupView.swift
//  Pink_Coven
//
//  Created by M_2022814 on 1/1/22.
//

import SwiftUI
import Combine

enum AuthState {
    case signUp
    case signIn
}

struct LoginSignupView: View {
    @State var authState: AuthState = .signUp
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var validationError = false
    @State private var requestError = false
    @State private var requestErrorText: String = ""
    @State var networkOperation: AnyCancellable?
    
    var body: some View {
        VStack(spacing: 55) {
            AppTitle()
            
            let columns: [GridItem] = [
                GridItem(.flexible(), spacing: 8, alignment: .leading),
                GridItem(.flexible())
            ]
            
            LazyVGrid(columns: columns) {
                Text("Username")
                TextField("Username", text: $username)
                    .textContentType(.username)
                    .autocapitalization(.none)
                if authState == .signUp {
                    Text("Email")
                    TextField("Email", text: $email)
                        .textContentType(.emailAddress)
                }
                Text("Password")
                SecureField("Password", text: $password)
                    .textContentType(.password)
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .alert(isPresented: $validationError) {
                if authState == .signUp {
                    return Alert(title: Text("Please complete the username and password fields"))
                } else {
                    return Alert(title: Text("Please complete the username and password fields"))
                }
            }
            
            VStack(spacing: 8) {
                Button(action: {
                    doAuth()
                }) {
                    HStack {
                        Spacer()
                        Text(authState == .signUp ? "Sign Up" : "Sign In" )
                            .foregroundColor(.white)
                        Spacer()
                    }
                }
                .padding([.top, .bottom], 10)
                .background(Color.pink.opacity(0.2))
                .clipShape(Capsule())
                .alert(isPresented: $requestError) {
                    Alert(title: Text(requestErrorText))
                }
                
                Button(action: {
                    withAnimation { toggleState() }
                }) {
                    HStack {
                        Spacer()
                        Text(authState == .signUp ? "Sign In" : "Sign Up")
                        Spacer()
                    }
                }
                .padding([.top, .bottom], 10)
                .overlay(Capsule().stroke(Color.pink, lineWidth: 2))
            }
            .padding(.horizontal, 50)
            .accentColor(.pink)
            
            Spacer()
                .frame(minHeight: 0, maxHeight: 100)
        }
        .padding(.horizontal)
    }
    
    private func toggleState() {
        authState = (authState == .signUp ? .signIn : .signUp)
    }
    
    private func doAuth() {
            networkOperation?.cancel()
            switch authState {
            case .signIn:
              doSignIn()
            case .signUp:
              doSignUp()
            }
    }
    
    private func doSignIn() {
            guard username.count > 0, password.count > 0 else {
              validationError = true
              return
            }
        
        let client = APIClient(environment: .local81)
            let request = SignInUserRequest(username: username, password: password)
            networkOperation = client.publisherForRequest(request)
              .sink(receiveCompletion: { result in
                handleResult(result)
              }, receiveValue: {_ in})
    }
    
    private func doSignUp() {
            guard username.count > 0, email.count > 0, password.count > 0 else {
              validationError = true
              return
            }
        
        let client = APIClient(environment: .local81)
            let request = SignUpUserRequest(username: username, email: email, password: password)
            networkOperation = client.publisherForRequest(request)
              .sink(receiveCompletion: { result in
                handleResult(result)
              }, receiveValue: {_ in})
    }
    
    private func handleResult(_ result: Subscribers.Completion<Error>) {
            if case .failure(let error) = result {
              // TODO: we could check for 401 and show a nicer error
              switch error {
              case APIError.requestFailed(let statusCode):
                requestErrorText = "Status code: \(statusCode)"
              case APIError.postProcessingFailed(let innerError):
                requestErrorText = "Error: \(String(describing: innerError))"
              default:
                requestErrorText = "An error occurred: \(String(describing: error))"
              }
            } else {
              requestErrorText = ""
              networkOperation = nil
            }
            requestError = requestErrorText.count > 0
    }
}

struct LoginSignupView_Previews: PreviewProvider {
    static var previews: some View {
        LoginSignupView()
    }
}
