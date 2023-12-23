
//
//  BreakingBadJson.swift
//  new.SwT
//
//  Created by A.f. Adib on 12/7/23.
//

import SwiftUI

struct Quote : Codable {
//    var quote_id : Int
//    var quote : String
//    var author : String
//    var series : String
    let userId : Int
    let id : Int
    let title : String
    let body : String
}

struct BreakingJSON: View {
    
    @State private var quotes = [Quote]()
    
    var body: some View {
        NavigationView {
            List(quotes, id: \.id) { quote in
                VStack(alignment : .leading) {
                    NavigationLink(quote.title) {
                       Text("hi")
                           
                    }
//                    Text(quote.body)
//                        .font(.body)
                }
            }
            .navigationTitle("Breaking Bad Quotes")
            .task {
                await fetchData()
            }
        }
    }
    
    
    func fetchData() async {
        
        //create the url
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            print("invalid url")
            return
        }
        
        //fetch the data
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            //decode the data
            if let decodedData = try? JSONDecoder().decode([Quote].self, from: data) {
                quotes = decodedData
            }
        } catch {
            print("Failed to Decode")
        }
        
    }
}

struct BreakingJSON_Previews: PreviewProvider {
    static var previews: some View {
        BreakingJSON()
    }
}
