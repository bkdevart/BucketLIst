//
//  UnlockedView.swift
//  BucketList
//
//  Created by Brandon Knox on 5/25/21.
//

import MapKit
import SwiftUI

struct UnlockedView: View {
    // TODO turn these to bindings? @Binding var isPresented: Bool
    
    @Binding var centerCoordinate: CLLocationCoordinate2D
    @Binding var locations: [CodableMKPointAnnotation]
    @Binding var selectedPlace: MKPointAnnotation?
    @Binding var showingPlaceDetails: Bool
    @Binding var showingEditScreen: Bool
    
    var body: some View {
        // Having a complex if condition in the middle of ContentView isn’t easy to read – can you rewrite it so that the MapView, Circle, and Button are part of their own view? This might take more work than you think!
        ZStack {
            MapView(centerCoordinate: $centerCoordinate, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails, annotations: locations)
                .edgesIgnoringSafeArea(.all)
            Circle()
                .fill(Color.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action : {
                        let newLocation = CodableMKPointAnnotation()
                        newLocation.title = "Example Location"
                        newLocation.coordinate = self.centerCoordinate
                        self.locations.append(newLocation)
                        
                        self.selectedPlace = newLocation
                        self.showingEditScreen = true
                    }) {
                        Image(systemName: "plus")
                            .padding()
                            .background(Color.black.opacity(0.75))
                            .foregroundColor(.white)
                            .font(.title)
                            .clipShape(Circle())
                            .padding(.trailing)
                    }
                }
            }
        }
    }
    
//    init(mission: Mission, astronauts: [Astronaut]) {
//        self.mission = mission
//
//        var matches = [CrewMember]()
//
//        for member in mission.crew {
//            if let match = astronauts.first(where: { $0.id == member.name}) {
//                matches.append(CrewMember(role: member.role, astronaut: match))
//            } else {
//                fatalError("Missing \(member)")
//            }
//        }
//
//        self.astronauts = matches
//    }
    
}

//struct UnlockedView_Previews: PreviewProvider {
//    static var previews: some View {
//        UnlockedView()
//    }
//}
