//
//  ContentView.swift
//  FriendBook
//
//  Created by A.f. Adib on 12/3/23.
//

import SwiftUI

struct User : Identifiable, Codable {
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

class DownloadJson : ObservableObject {
    @Published var posts : [User] = []

    init () {
        getPost()
    }

    func getPost () {

        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")
        else {
            return
        }

        downData(fromUrl: url) { Ndata in
            if let dataa = Ndata {
                guard let newPost = try? JSONDecoder().decode([User].self, from: dataa)
                else {
                    return
                }
                DispatchQueue.main.async { [weak self] in
                    self?.posts = newPost
                }
            }
            else {
                print("No Data")
            }
        }
    }

    func downData(fromUrl url : URL, completion : @escaping (_ data : Data?) -> ()) {

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let data = data ,
            error == nil,
            let response = response as?  HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300

            else {
                print("Error downloading data")
                completion(nil)
                return
            }
            completion(data)

        }.resume()
    }

}


struct ContentView: View {
    
    @StateObject var jvm = DownloadJson()
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(jvm.posts) { post in
                    VStack(alignment : .leading) {
                        Text(post.name)
                            .font(.headline)
                        Text(post.email)
                    }
                }
            }
            .navigationTitle("FriendBook")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
