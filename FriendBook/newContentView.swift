//
//  newContentView.swift
//  FriendBook
//
//  Created by A.f. Adib on 12/7/23.
//

import SwiftUI

struct Userr : Identifiable, Codable {
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company, email, address, about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
    
    struct Friend :Identifiable, Codable {
        let id, name: String
    }
}

enum GhError : Error {
    case invalidURL
    case invalidResponse
    case invalidData
}


struct newContentView: View {
    @State private var user : Userr?
    var body: some View {
        NavigationView {
            
               
                    VStack(alignment : .leading) {
                        Text(user?.name ?? "No name")
                            .font(.headline)
                        Text(user?.email ?? "no email")
                       
                    }
                
            
            .navigationTitle("FriendBook")
            .task {
                do {
                    user = try await getUser()
                } catch GhError.invalidURL{
                    print("invalid Url")
                } catch GhError.invalidResponse {
                    print("invalid response")
                } catch GhError.invalidData {
                    print("invalid data")
                } catch {
                    print("unexpected error")
                }
            }
        }
    }
    
    func getUser () async throws -> Userr {
        let endPoint = "https://api.github.com/users/twoStraws"
        
        guard let url = URL(string: endPoint) else { throw GHError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GHError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(Userr.self, from: data)
        } catch {
            throw GHError.invalidData
        }
    }
}

struct newContentView_Previews: PreviewProvider {
    static var previews: some View {
        newContentView()
    }
}
