//
//  ContentView.swift
//  BucketList
//
//  Created by Brandon Knox on 5/20/21.
//

import SwiftUI

struct ContentView: View {
    let values = [1, 5, 3, 6, 2, 9].sorted()
    
    var body: some View {
        List(values, id: \.self) {
            Text(String($0))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
