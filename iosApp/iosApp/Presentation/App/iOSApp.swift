import SwiftUI
import GoogleSignIn
import Shared



@main
struct iOSApp: App {
    
    @State private var isLoggedIn = false
    @State private var path = NavigationPath()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $path) {
                LoginView {
                    withAnimation {
                        isLoggedIn = true
                    }
                }
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
                .onAppear {
                    GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
                        // Check if `user` exists; otherwise, do something with `error`
                    }
                }
                .navigationDestination(isPresented: $isLoggedIn) {
                    ZStack {
                        Color.backgroundPrimary.ignoresSafeArea()
                        BottomBarView()
                            .padding(.top, 1)
                            .onAppear {
                                UINavigationBar.appearance().backgroundColor = Color.backgroundPrimary.toUIColor
                            }
                    }
                    .navigationBarBackButtonHidden()
                }
            }
        }
        
    }
}
