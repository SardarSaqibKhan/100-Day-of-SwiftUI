//
//  AnnotationEditView.swift
//  Bucket List
//
//  Created by sardar saqib on 07/01/2025.
//

import SwiftUI

enum LoadingStates {
    case loading
    case loaded
    case failed
}
struct AnnotationEditView: View {
 
    @Environment(\.dismiss) var dismiss
    var onSave: (Location) -> Void
    @State var viewModel = ViewModel(location: .example)
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Place Name", text: $viewModel.placeName)
                TextField("Place Description", text: $viewModel.placeDesc)
                
                Section("Nearby…") {
                    switch viewModel.loadingState {
                    case .loading:
                        LoadingView()
                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ") +
                            Text(page.description)
                                .italic()
                        }
                    case .failed:
                        ErrorView()
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    var newLocation = viewModel.location
                    newLocation.name = viewModel.placeName
                    newLocation.description = viewModel.placeDesc
                    newLocation.id = UUID()
                    onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                await viewModel.fetchNearByPlaces()
            }
        }
    }
    
    init(location:Location, onSave: @escaping (Location) -> Void){
    
        self.onSave = onSave
        _viewModel =   State(initialValue: ViewModel(location: location))
    }
}

#Preview {
    AnnotationEditView(location: Location.example, onSave: {_ in})
}
extension AnnotationEditView {
    @Observable
    class ViewModel {
        
       var location:Location
       var loadingState = LoadingStates.loading
       var pages = [Page]()
        var placeName : String
        var placeDesc : String
        
        init(location: Location) {
            self.location = location
            self.placeName = location.name
            self.placeDesc = location.description
        }
        
        func fetchNearByPlaces() async {
            let url =  "https://en.wikipedia.org/w/api.php?ggscoord=\(location.latitude)%7C\(location.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
            
            guard let url = URL(string: url) else {
                fatalError("Bad URL")
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decodedData = try JSONDecoder().decode(Result.self, from: data)
                DispatchQueue.main.async {
                    self.pages = decodedData.query.pages.values.sorted()
                    self.loadingState = .loaded
                }
            } catch {
                self.loadingState = .failed
            }
        }
    }
}


struct LoadingView : View {
    var body: some View {
        Text("Loading...")
            .font(.largeTitle)
    }
}
struct LoadedView : View {
    var body: some View {
        Text("Loaded")
            .font(.largeTitle)
    }
}
struct ErrorView : View {
    var body: some View {
        Text("Please try again later.")
            .font(.largeTitle)
    }
}
