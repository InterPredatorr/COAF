//
//  UserViewModelWrapper.swift
//  iosApp
//
//  Created by Sevak on 02.08.24.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation
import COAF
import Combine

class UserViewModelWrapper: ObservableObject {
    
    let viewModel = UserViewModel()
    
    @Published private(set) var users = [User]()
    @Published var user: User {
        didSet {
            Task {
                do {
                    try await handleUserChange()
                } catch {
                    
                }
            }
        }
    }
    
    private var cancellables = Set<AnyCancellable>()

    
    
    init(userId: Int32) async throws {
        self.user = try await viewModel.getUser(id: userId)
        viewModel.onUsersUpdated = { [weak self] users in
            self?.users = users
        }
        
        viewModel.onUserUpdated = { [weak self] user in
            guard let user else { return }
            self?.user = user
        }
        try await setupBindings()
        
    }
    
    private func setupBindings() async throws {
        $user
            .sink { [weak self] _ in
                Task { [weak self] in
                    do {
                        try await self?.handleUserChange()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    private func handleUserChange() async throws {
        self.user = try await updateUser(with: user)
        print(user.gender)
    }
    
    func getUserBy(id: Int32) async throws {
        do {
            self.user = try await viewModel.getUser(id: id)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func create(user: User) -> Bool {
        viewModel.createUser(user: user)
    }
    
    func updateUser(with user: User) async throws -> User {
        try await viewModel.updateUser(user: user)
    }
    
    func deleteUser(id: Int32) -> Bool {
        viewModel.deleteUser(id: id)
    }
}
