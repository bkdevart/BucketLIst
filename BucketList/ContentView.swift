//
//  ContentView.swift
//  BucketList
//
//  Created by Brandon Knox on 5/20/21.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        MapView()
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
