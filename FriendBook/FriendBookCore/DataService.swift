//
//  DataService.swift
//  FriendBook
//
//  Created by A.f. Adib on 12/14/23.
//

import Foundation

class UserDataService {
    
    private let urlString = "https://www.hackingwithswift.com/samples/friendface.json"
    
    func fetchUser(completion : @escaping([USer]) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }

            guard let Users = try? JSONDecoder().decode([USer].self, from: data) else {
                print("Failed to decode user")
                return
            }
            completion(Users)
            
        }.resume()
    }
}
