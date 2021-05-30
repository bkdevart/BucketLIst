//
//  ContentView.swift
//  BucketList
//
//  Created by Brandon Knox on 5/20/21.
//

import LocalAuthentication
import MapKit
import SwiftUI

struct ContentView: View {
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [CodableMKPointAnnotation]()
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingPlaceDetails = false
    @State private var showingEditScreen = false
    @State private var isUnlocked = false
    @State private var authError = false
    @State private var authErrorMessage = ""
    
    var body: some View {
        ZStack {
            if isUnlocked {
                UnlockedView(centerCoordinate: $centerCoordinate,
                             locations: $locations,
                             selectedPlace: $selectedPlace,
                             showingPlaceDetails: $showingPlaceDetails,
                             showingEditScreen: $showingEditScreen)
            } else {
                Button("Unlock Places") {
                    self.authenticate()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
                .alert(isPresented: $authError) {
                    Alert(title: Text("Authentication Error"),
                          message: Text(authErrorMessage),
                          dismissButton: .default(Text("OK")))
                }
            }
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to unlock your places."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        // error
                        authError = true
                        authErrorMessage = "Unrecognizable face or fingerprint"
                    }
                }
            }
        } else {
            // no biometry
            authError = true
            authErrorMessage = "Face ID and Touch ID are not supported on this device"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
