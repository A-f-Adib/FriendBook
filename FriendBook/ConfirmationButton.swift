//
//  ConfirmationButton.swift
//  FriendBook
//
//  Created by A.f. Adib on 12/18/23.
//

import SwiftUI

struct ConfirmationButton: View {
    @State private var showConf = false
    @State private var bgColor = Color.white
    
    var body: some View {
        Button("Show Confirmation") {
            showConf.toggle()
        }
        .frame(width: 300, height: 300)
        .background(bgColor)
        .confirmationDialog("Change Background", isPresented: $showConf) {
            Button("Red") { bgColor = .red }
            Button("Green") { bgColor = .green }
            Button("Blue") { bgColor = .blue}
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Select a new color")
        }
    }
}

struct ConfirmationButton_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationButton()
    }
}
