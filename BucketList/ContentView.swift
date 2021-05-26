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
        .sheet(isPresented: $showingEditScreen, onDismiss: saveData) {
            if self.selectedPlace != nil {
                EditView(placemark: self.selectedPlace!)
            }
        }
        .onAppear(perform: loadData)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func loadData() {
        let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
        
        do {
            let data = try Data(contentsOf: filename)
            locations = try JSONDecoder().decode([CodableMKPointAnnotation].self, from: data)
        } catch {
            print("Unable to load saved data.")
        }
    }
    
    func saveData() {
        do {
            let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
            let data = try JSONEncoder().encode(self.locations)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
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
