import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State private var textOpacity = 0.0
    @State private var textScale = 0.3
    
    @State private var usernameField: String = ""
    @State private var passwordField: String = ""
    
    private var isLoginButtonDisabled: Bool {
        usernameField.isEmpty || passwordField.isEmpty
    }
    
    @State private var unsecuredText: Bool = false
    
    var body: some View {
        ZStack {
            AppBackground()
            
            VStack {
                VStack {
                    Text("Welcome to")
                        .font(.title2)
                        .foregroundColor(Color("Col1"))
                    
                    Text("Tourpedo")
                        .font(.largeTitle)
                        .foregroundColor(Color("Col1"))
                }
                .opacity(textOpacity)
                .scaleEffect(textScale)
                .onAppear {
                    withAnimation(.easeOut(duration: 1.5)) {
                        self.textOpacity = 1.0
                        self.textScale = 1.0
                    }
                }
                
                VStack {
                    TextField("Username", text: $usernameField)
                        .padding()
                        .frame(width: 250, height: 40, alignment: .center)
                        .background(.white.opacity(0.8))
                        .cornerRadius(5)
                    
                    ZStack {
                        
                        if !unsecuredText {
                            SecureField("Password", text: $passwordField)
                                .padding()
                                .frame(width: 250, height: 40, alignment: .center)
                                .background(.white.opacity(0.8))
                                .cornerRadius(5)
                                
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        unsecuredText.toggle()
                                    }) {
                                        Image(systemName: "eye.slash")
                                            .padding()
                                            .foregroundColor(Color("Col3").opacity(0.5))
                                    }
                                }
                                .frame(width: 250)
                            
                        } else {
                            TextField("Password", text: $passwordField)
                                .padding()
                                .frame(width: 250, height: 40, alignment: .center)
                                .background(.white.opacity(0.8))
                                .cornerRadius(5)
                            
                            HStack {
                                Spacer()
                                Button(action: {
                                    unsecuredText.toggle()
                                }) {
                                    Image(systemName: "eye.fill")
                                        .padding()
                                        .foregroundColor(Color("Col3").opacity(0.5))
                                }
                            }
                            .frame(width: 250)
                        }
                    }
                    
                    Button(action: {
                        viewModel.isLoggedIn = true
                    }) {
                        Text("Login")
                            .frame(width: 250, height: 40)
                            .background(isLoginButtonDisabled ? Color.gray : Color("Col2").opacity(0.8))
                            .cornerRadius(5)
                            .foregroundColor(Color("Col1"))
                    }
                    .disabled(isLoginButtonDisabled)
                   
                        Button(action: {
                            // pass
                        }) {
                            Text("Sign Up")
                                .frame(width: 250, height: 40)
                                .background(Color("Col4").opacity(0.8))
                                .cornerRadius(5)
                                .foregroundColor(Color("Col1"))
                        }
                }
                .opacity(textOpacity)
                .scaleEffect(textScale)
                .onAppear {
                    withAnimation(.easeOut(duration: 1.5)) {
                        self.textOpacity = 1.0
                        self.textScale = 1.0
                    }
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(ViewModel())
    }
}
