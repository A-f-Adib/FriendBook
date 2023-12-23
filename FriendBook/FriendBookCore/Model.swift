//
//  Model.swift
//  FriendBook
//
//  Created by A.f. Adib on 12/14/23.
//

import Foundation

struct USer : Codable, Identifiable {
    let id : String
    let name : String
    let email : String
    let isActive : Bool
    let about : String
    let age : Int
    let address : String
    let friends : [Friend]
    
    struct Friend : Codable, Identifiable {
        let id : String
        let name : String
    }
}

