//
//  MapView.swift
//  Bucket List
//
//  Created by sardar saqib on 07/01/2025.
//

import SwiftUI
import MapKit
import LocalAuthentication

struct MapView: View {
    
    @State var viewModel = ViewModel()
    let mapStyles = ["Standard", "Hybrid"]
    @State private var selectedMode = 0

    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 33.6995, longitude: 73.0363),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
   
    var body: some View {
        if viewModel.authenticated {
            ZStack {
                mapView
                mapControlsView
            }
           
        } else {
            authenticationFailedView
        }
        
    }
    
    private var mapView: some View {
        MapReader { reader in
            Map(initialPosition: startPosition) {
                ForEach(viewModel.locations) { location in
                    Annotation(location.name, coordinate: location.coordinate) {
                        Image(systemName: "star.circle")
                            .resizable()
                            .foregroundStyle(.red)
                            .frame(width: 50, height: 50)
                            .background(.white)
                            .clipShape(.circle)
                            .onLongPressGesture(minimumDuration: 0.2) {
                                viewModel.selectedPlace = location
                            }
                    }
                }
            }
            .mapStyle(selectedMode == 0 ? .standard : .hybrid)
            .onTapGesture { position in
                if let coordinate = reader.convert(position, from: .local) {
                    viewModel.addAnnotation(coordinats: coordinate)
                }
            }
            .sheet(item: $viewModel.selectedPlace, content: { place in
                AnnotationEditView(location: place) {
                    viewModel.updateAnnotation(updatedLocation: $0)
                }
            })
        }
    }
    
    private var mapControlsView: some View {
        VStack {
            Picker("", selection: $selectedMode) {
                Text("Standard").tag(0)
                Text("Hybrid").tag(1)
            }
            .pickerStyle(.segmented)
            .padding()
            .background(Color.white.opacity(0.8))
            .cornerRadius(10)
            .padding(.horizontal)

            Spacer()
        }
    }
    
    private var authenticationFailedView: some View {
        ContentUnavailableView {
            Label("Authentication Failed", systemImage: "faceid")
        } description: {
            Text("unable to authenticate you please try again.!")
        } actions: {
            Button("Unlock Save Places") {
                viewModel.authenticate()
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
    }
}

#Preview {
    MapView()
}

extension MapView {
    
    @Observable
    class ViewModel {
        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")
        var authenticated: Bool = false
        
        private(set) var locations: [Location] {
            didSet {
                save()
            }
        }
        var  selectedPlace: Location?
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
            authenticate()
        }
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
        
        func addAnnotation(coordinats:CLLocationCoordinate2D) {
            let newLocation = Location(id: UUID(), name: "new Location", description: "", latitude: coordinats.latitude, longitude: coordinats.longitude)
            locations.append(newLocation)
        }
        
        func updateAnnotation(updatedLocation: Location){
            guard let selectedPlace else { return }
            
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = updatedLocation
            }
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?

            // check whether biometric authentication is possible
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                // it's possible, so go ahead and use it
                let reason = "We need to unlock your data."

                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    // authentication has now completed
                    if success {
                        self.authenticated = true
                    } else {
                        self.authenticated = false
                    }
                }
            } else {
                // no biometrics
            }
        }
    }
}
