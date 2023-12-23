//
//  View.swift
//  FriendBook
//
//  Created by A.f. Adib on 12/14/23.
//

import SwiftUI

struct Views : View {
    
    @StateObject var viewModel = UserViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.users) { user in
                    VStack(alignment : .leading) {
                        NavigationLink {
                            ScrollView {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("Age : \(user.age)")
                                        .font(.title)
                                        .padding(.top)
                                    
                                        Text("Email: \(user.email)")
                                        .font(.title3.bold())
                                            .navigationTitle(user.name)
                                    Text("Address : \(user.address)")
                                    
                                    
                                        Text("About:")
                                            .font(.title3.bold())
                                        Text(user.about)
                                            .font(.title3)
                                   
                                    
                                    
                                 Spacer()
                                }.padding()
                            }
                        
                        }
                                        label: {
                            VStack(alignment : .leading) {
                                HStack {
                                    Text(user.name)
                                        .font(.headline)
                                    
                                    Spacer()
                                    if user.isActive {
                                        Image(systemName: "circle.fill")
                                            .foregroundColor(.green)
                                    }
                                }
                                
                            }
                            
                        }
                    }
                }
            }
//            .padding(.top)
            .navigationTitle("FriendsBook")
        }
    }
}

struct DetailView : View {
    
    let userInfo : USer
    
    var body: some View {
        
        Text(userInfo.email)
    }
}

struct Views_Previews: PreviewProvider {
    static var previews: some View {
        Views()
    }
}
