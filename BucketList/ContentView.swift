//
//  ContentView.swift
//  BucketList
//
//  Created by Brandon Knox on 5/20/21.
//

import SwiftUI

struct User: Identifiable {
    let id = UUID()
    let firstName: String
    let lastName: String
}

struct ContentView: View {
    let users = [
        User(firstName: "Arnold", lastName: "Rimmer"),
        User(firstName: "Kristine", lastName: "Kochanski"),
        User(firstName: "David", lastName: "Lister")
    ].sorted {
        $0.lastName < $1.lastName
    }
    
    var body: some View {
        List(users) { user in
            Text("\(user.lastName), \(user.firstName)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
