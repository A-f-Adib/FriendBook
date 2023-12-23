//
//  GIthubProfileView.swift
//  FriendBook
//
//  Created by A.f. Adib on 12/7/23.
//

import SwiftUI

struct GithubUser : Codable {
    let login : String
    let avatarUrl : String
    let bio : String
}

enum GHError : Error {
    case invalidURL
    case invalidResponse
    case invalidData
}



struct GIthubProfileView: View {
    
    @State private var user : GithubUser?
    
    var body: some View {
        VStack(spacing : 20) {
            
            AsyncImage(url: URL(string: user?.avatarUrl ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
            } placeholder: {
                Circle()
                    .foregroundColor(.secondary)
                    
            }.frame(width: 120, height: 120)
            
            
            
            Text(user?.login ?? "No name")
                .bold()
                .font(.title3)
            Text(user?.bio ?? "No bio")
                .padding()
            
            Spacer()
        }
        .padding()
        .task {
            do {
                user = try await getUser()
            } catch GHError.invalidURL{
                print("invalid Url")
            } catch GHError.invalidResponse {
                print("invalid response")
            } catch GHError.invalidData {
                print("invalid data")
            } catch {
                print("unexpected error")
            }
        }
    }
    
    
    func getUser () async throws -> GithubUser {
        let endPoint = "https://api.github.com/users/twoStraws"
        
        guard let url = URL(string: endPoint) else { throw GHError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GHError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(GithubUser.self, from: data)
        } catch {
            throw GHError.invalidData
        }
    }
}

struct GIthubProfileView_Previews: PreviewProvider {
    static var previews: some View {
        GIthubProfileView()
    }
}
