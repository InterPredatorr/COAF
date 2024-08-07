import SwiftUI
import GoogleSignIn
import COAF

class AppDelegate: NSObject, UIApplicationDelegate {
    
    var viewModel: UserViewModelWrapper?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        initializeViewModel { result in
            switch result {
            case .success(let viewModel):
                self.viewModel = viewModel
            case .failure(let error):
                print("Failed to initialize viewModel: \(error)")
            }
        }
        
        return true
    }
    
    private func initializeViewModel(completion: @escaping (Result<UserViewModelWrapper, Error>) -> Void) {
        Task {
            do {
                let viewModel = try await UserViewModelWrapper(userId: 6)
                completion(.success(viewModel))
            } catch {
                completion(.failure(error))
            }
        }
    }
}

@main
struct iOSApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State private var isLoggedIn = false
    @State private var path = NavigationPath()
    @State private var userViewModel: UserViewModelWrapper!
    @State private var isViewModelInitialized = false
    
    var body: some Scene {
        WindowGroup {
            if isViewModelInitialized {
                NavigationStack(path: $path) {
                    ZStack {
                        Color.backgroundPrimary.ignoresSafeArea()
                        BottomBarView()
                            .environmentObject(userViewModel)
                            .padding(.top, 1)
                            .onAppear {
                                UINavigationBar.appearance().backgroundColor = Color.backgroundPrimary.toUIColor
                            }
                    }
                    .navigationBarBackButtonHidden()
                }
                .onAppear {
                    userViewModel = appDelegate.viewModel
                }
            } else {
                ProgressView()
                    .progressViewStyle(.circular)
                    .onAppear {
                        Task {
                            while appDelegate.viewModel == nil {
                                try? await Task.sleep(nanoseconds: 100_000_000)
                            }
                            userViewModel = appDelegate.viewModel
                            isViewModelInitialized = true
                        }
                    }
            }
        }
    }
}
