//
//  ViewModel.swift
//  FriendBook
//
//  Created by A.f. Adib on 12/14/23.
//

import Foundation

class UserViewModel : ObservableObject {
    
    @Published var users = [USer]()
//    @Published var details = [new]()
    
    private let service = UserDataService()
    
    init() {
        FetchUsers()
    }
    
    func FetchUsers() {
        service.fetchUser { user in
            DispatchQueue.main.async {
                self.users = user
            }
        }
    }
}
